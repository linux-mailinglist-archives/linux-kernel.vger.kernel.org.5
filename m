Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334427A01B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjINKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjINKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:32:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B941FC2;
        Thu, 14 Sep 2023 03:32:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmYX01Fscz6K5pj;
        Thu, 14 Sep 2023 18:31:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 11:32:03 +0100
Date:   Thu, 14 Sep 2023 11:32:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <20230914113200.000060a8@Huawei.com>
In-Reply-To: <65020d0264085_321c802941d@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
        <20230830125025.00000fea@Huawei.com>
        <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
        <20230912174904.00005fed@Huawei.com>
        <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
        <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
        <6501f1c29a2c4_31df46294ec@iweiny-mobl.notmuch>
        <6501f89c9ef86_12747294bd@dwillia2-xfh.jf.intel.com.notmuch>
        <65020d0264085_321c802941d@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 12:26:58 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dan Williams wrote:
> > Ira Weiny wrote:

Jumping in on randomly selected points :)

> > [..]  
> > > > 
> > > > Given that one of the expected DCD use cases is to provide just in time
> > > > memory for specific jobs the "first-available" search for free capacity
> > > > in a Sparse DAX Region collides with the need to keep allocations
> > > > bounded by tag.  
> > > 
> > > How does it collide?
> > > 
> > > My attempt here is to leave dax devices 'unlabeled'.  As such they will use
> > > space on a 'first-available' search regardless of extent labels.
> > > 
> > > Effectively I have defined 'no label' as being 'any label'.  I apologize
> > > for this detail being implicit and not explicit.
> > > 
> > > My envisioned path would be that older daxctl would continue to work like
> > > this because the kernel would not restrict unlabeled dax device creation.
> > > 
> > > Newer daxctl could use dax device labels to control the extents used.  But
> > > only when dax device labeling is introduced in a future kernel.  Use of a
> > > newer daxctl on an older DCD kernel could continue to work sans label.
> > > 
> > > In this way I envisioned a path where the policy is completely dictated by
> > > user space restricted only by the software available.  
> > 
> > Tags are a core concept in DCD. "Allocate by tag" does not feel like
> > something that can come later at least in terms of when the DCD ABI is
> > ready for upstream. So, yes, it can remain out of this patchset, but the
> > upstream merge of all of DCD would be gated on that facility arriving.  
> 
> I don't see how this can be left out of this patchset.  Without dax device
> support on DCD there is no functionality and this patchset does nothing.

Agreed - but I think one path you suggest is fine.

No label dax == no label DCD extents.

That one should be true for ever (or until writeable tags added) so
is safe and gets us going.

> 
> >   
> > > > I agree with Jonathan that unless and until the allocation scheme is
> > > > updated to be tag aware then there is no reason for allocate by tag to
> > > > exist in the interface.  
> > > 
> > > I will agree that it was perhaps premature to introduce labels on the
> > > extents.  However, I did so to give tags a space to be informationally
> > > surfaced.
> > > 
> > > IMO we must have a plan forward or wait until that plan is fully formed
> > > and implemented.  The size of this set is rather large.  Therefore, I was
> > > hoping that a plan would be enough to move forward.  
> > 
> > Leave it out for now to focus on the core mechanisms and then we can  
>        ^^^^
>        it what?
> > circle back to it.  
> 
> Again dax devices need to be created to full test this so I have to create
> them in some way.  I'm going to assume you mean 'labelless' and deal with
> labels later.
> 
> >   
> > > > That said, the next question, "is DCD enabling considered a toy until
> > > > the ability to allocate by tag is present?" I think yes, to the point
> > > > where old daxctl binaries should be made fail to create device instances
> > > > by forcing a tag to be selected at allocation time for Sparse DAX
> > > > Regions.  
> > > 
> > > Interesting.  I was not considering allocate by label to be a requirement
> > > but rather an enhancement.  Labels IMO are a further refinement of the
> > > memory space allocation.  I can see a very valid use case (not toy use
> > > case) where all the DCD memory allocated to a node is dedicated to a
> > > singular job and is done without tags or even ignoring tags.  Many HPC
> > > sites run with singular jobs per host.  
> > 
> > Is HPC going to use DCD? My impression is that HPC is statically
> > provisioned per node and that DCD is more targeted at Cloud use cases
> > where dynamic provisioning is common.  
> 
> I heard someone mention HPC in a call at some point.

I'd not rule it out.  Some HPC systems run very mixed workloads in parallel
so would benefit form Dynamic capacity - though maybe not with the same
rate of change as cloud workloads.

> 
> >   
> > > > The last question is whether *writable* tags are needed to allow for
> > > > repurposing memory allocated to a host without needing to round trip it
> > > > through the FM to get it re-tagged. While that is something the host and
> > > > orchestrator can figure out on their own, it looks like a nice to have
> > > > until the above questions are answered.  
> > > 
> > > Needed?  No.  Of course not.  As you said the orchestrator software can
> > > keep iterating with the FM until it gets what it wants.  It was you who
> > > had the idea of a writable labels and I agreed.  
> > 
> > Yeah, it was an idea for how to solve the problem of repurposing tag
> > without needing to round trip with the FM.
> >   
> > > "Seemed like a good idea at the time..."  ;-)
> > > 
> > > As I have reviewed and rewritten this message I worry that writable labels
> > > are a bad idea.  Interleaving will most likely depend on grouping extent
> > > tags into the CXL/DAX extent.  With this in mind adjusting extents is
> > > potentially going to require an FM interaction to get things set up
> > > anyway.
> > > 
> > > 	[Again re-reading my message I thought of another issue.  What
> > > 	happens if the user decides to change the label on an extent after
> > > 	some dax device with the old label?  That seems like an additional
> > > 	complication which is best left out by not allowing extent labels
> > > 	to be writable.]  
> > 
> > At least for this point extents can not be relabeled while allocated to
> > an instance.  
> 
> Sure but is having writeable labels worth this extra complexity?

No. Or not yet anyway.


> 
> > 
> > [..]  
> > > My current view is:
> > > 	1) No.  Current dax devices can be defined as 'no label'
> > > 	2) I'm not sure.  I can see both ways having benefits.

> 2) What does 'no dax device label' mean?
> 		a) any extent label
> 		b) no extent label
(that bit got cropped)

Option b seems something we can support for ever.  Not sure that works
for option a.

> > > 	3) No I think the ROI is not worth it.
> > > 	4) The use of 'any extent label' in #2 means that available size
> > > 	   retains it's meaning for no label dax devices.  Labeled dax
> > > 	   devices would require a future enhancement to size information.  
> > 
> > If the ABI is going to change in the future I don't want every debug
> > session to start with "which version of daxctl were you using", or "do
> > your scripts comprehend Sparse DAX Regions?".  
> 
> Well then we are stuck.  Because at a minimum they will have to understand
> Sparse DAX regions.  cxl create-region needs a new type to create such
> regions.
> 
> I envisioned an ABI *extension* not change.  The current ABI supports dax
> devices without a tag.  Even with DCD no tag is possible.  Unless you want
> to restrict it, which it sounds like you do?
> 
> I'm ok with that but I know of at least 1 meeting where it was
> emphatically mentioned that tags are _not_ required.  So I'd like some
> community members to chime in here if requiring tags is ok.

They are definitely not required and I don't think we want to make
it a Linux requirement that tags are needed.


> 
> >
> > This stance is motivated
> > by having seen the problems that the current ABI causes for people that want
> > to do things like mitigate the "noisy neighbor" phenomenon in memory
> > side caches.  
> 
> Does a dax device need specific placement within the region?  That sounds
> like control at the extent layer when the extent is mapped into the
> region.
> 
> The mapping store interface does need to be resolved for DCD.  I could
> envision the ability for user space to create extents...  Are you thinking
> the same thing?
> 
> Conceptually from a top down approach _any_ dax region could be a sparse
> dax region if I get what you are driving at?  Not just DCD?  In that case
> extent creation is even more complicated in the DCD case.

For now at least I'd push any clever noisy neighbour mess on to the
Fabric manager once we have tags.  Not sure the OS even has the visibility to
do this sort of fine tuning.  We could provide it of course, but that's
a whole level of system description that we don't have today.

> 
> > The allocation ABI is too simple and DCD seems to need
> > more.  
> 
> Are you advocating for an ABI which requires dax devices to be labeled?
> It sounds like you don't want the current tool set to work on sparse dax
> regions.  Is that correct?  I'm ok with that but I don't think a specific
> check in the kernel is the proper way to do that.  Current dax devices are
> unlabled.  So I envisioned them being supported with the current ABI.
> 
> > 
> > The kernel enforced requirement for Sparse DAX Region aware tooling just
> > makes it easier on us to maintain. If it means waiting until we ahve
> > agreement on the allocation ABI I think that's a simple release valve.  
> 
> These statements imply to me you have additional requirements for this ABI
> beyond what DCD does.  I've tried to make the dax layer DCD/CXL agnostic.
> But beyond having the concept of region extents which are labeled and
> matched to dax devices based on that label; what other requirements on dax
> to region space allocations are there?
> 
> > 
> > The fundamental mechanisms can be reviewed in the meantime.  
> 
> Sure,
> Ira
> 

