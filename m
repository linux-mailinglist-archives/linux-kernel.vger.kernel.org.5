Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41347FD4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjK2Kvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2Kvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:51:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A310D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:51:56 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 873DA21999;
        Wed, 29 Nov 2023 10:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701255114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B76eGcDwY3AvWINd4TnIg5SbA5HlN+Zz+jDp5sSwrmo=;
        b=PbG3LxXT891FhLv00eo4CIIi/LZYZzo6WwoHDm6XreEJapBNYRdRSevK7Qt9MhjKzeWkfo
        XILM06dNFcNRaPSLwxgOB1U/xIjBXd8FL1Jyt2XE6+ChrdpJdS2RrJfLTUVWFAQo3fV0wa
        uQhiQ5Sdv3HLyjXsuyRcUDJ+S8dSHJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701255114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B76eGcDwY3AvWINd4TnIg5SbA5HlN+Zz+jDp5sSwrmo=;
        b=MRReT9Ti2iztIwpcXDMYuel0XBhfde8MM+TwpqlObZCSU+ttaXcHswLoBZ58ZqfDN0Z9lT
        66m37d7Qci3xZcDw==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
        by relay2.suse.de (Postfix) with ESMTP id A9A022C199;
        Wed, 29 Nov 2023 10:51:53 +0000 (UTC)
Date:   Wed, 29 Nov 2023 11:51:53 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Baoquan He <bhe@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWcXyeDiI2v251F_@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.49
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=pass (smtp-out1.suse.de: domain of jbohac@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=jbohac@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 873DA21999
X-Spamd-Result: default: False [11.49 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         MID_RHS_MATCH_FROMTLD(0.00)[];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

thanks for your interest...

On Wed, Nov 29, 2023 at 03:57:59PM +0800, Baoquan He wrote:
> On 11/28/23 at 10:08am, Michal Hocko wrote:
> > On Tue 28-11-23 10:11:31, Baoquan He wrote:
> > > On 11/28/23 at 09:12am, Tao Liu wrote:
> > [...]
> > > Thanks for the effort to bring this up, Jiri.
> > > 
> > > I am wondering how you will use this crashkernel=,cma parameter. I mean
> > > the scenario of crashkernel=,cma. Asking this because I don't know how
> > > SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> > > driver will be filter out? If latter case, It's possibly having the
> > > on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> > > reset during kdump bootup because the NIC driver is not loaded in to
> > > initialize. Not sure if this is 100%, possible in theory?

yes, we also only add the necessary drivers to the kdump initrd (using
dracut --hostonly).

The plan was to use this feature by default only on systems where
we are reasonably sure it is safe and let the user experiment
with it when we're not sure.

I grepped a list of all calls to pin_user_pages*. From the 55,
about one half uses FOLL_LONGTERM, so these should be migrated
away from the CMA area. In the rest there are four cases that
don't use the pages to set up DMA:
	mm/process_vm_access.c:		pinned_pages = pin_user_pages_remote(mm, pa, pinned_pages,
	net/rds/info.c:	ret = pin_user_pages_fast(start, nr_pages, FOLL_WRITE, pages);
	drivers/vhost/vhost.c:	r = pin_user_pages_fast(log, 1, FOLL_WRITE, &page);
	kernel/trace/trace_events_user.c:	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,

The remaining cases are potentially problematic:
	drivers/gpu/drm/i915/gem/i915_gem_userptr.c:		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
	drivers/iommu/iommufd/iova_bitmap.c:	ret = pin_user_pages_fast((unsigned long)addr, npages,
	drivers/iommu/iommufd/pages.c:	rc = pin_user_pages_remote(
	drivers/media/pci/ivtv/ivtv-udma.c:	err = pin_user_pages_unlocked(user_dma.uaddr, user_dma.page_count,
	drivers/media/pci/ivtv/ivtv-yuv.c:		uv_pages = pin_user_pages_unlocked(uv_dma.uaddr,
	drivers/media/pci/ivtv/ivtv-yuv.c:	y_pages = pin_user_pages_unlocked(y_dma.uaddr,
	drivers/misc/genwqe/card_utils.c:	rc = pin_user_pages_fast(data & PAGE_MASK, /* page aligned addr */
	drivers/misc/xilinx_sdfec.c:	res = pin_user_pages_fast((unsigned long)src_ptr, nr_pages, 0, pages);
	drivers/platform/goldfish/goldfish_pipe.c:	ret = pin_user_pages_fast(first_page, requested_pages,
	drivers/rapidio/devices/rio_mport_cdev.c:		pinned = pin_user_pages_fast(
	drivers/sbus/char/oradax.c:	ret = pin_user_pages_fast((unsigned long)va, 1, FOLL_WRITE, p);
	drivers/scsi/st.c:	res = pin_user_pages_fast(uaddr, nr_pages, rw == READ ? FOLL_WRITE : 0,
	drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:		actual_pages = pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK, num_pages,
	drivers/tee/tee_shm.c:		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
	drivers/vfio/vfio_iommu_spapr_tce.c:	if (pin_user_pages_fast(tce & PAGE_MASK, 1,
	drivers/video/fbdev/pvr2fb.c:	ret = pin_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pages);
	drivers/xen/gntdev.c:	ret = pin_user_pages_fast(addr, 1, batch->writeable ? FOLL_WRITE : 0, &page);
	drivers/xen/privcmd.c:		page_count = pin_user_pages_fast(
	fs/orangefs/orangefs-bufmap.c:	ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
	arch/x86/kvm/svm/sev.c:	npinned = pin_user_pages_fast(uaddr, npages, write ? FOLL_WRITE : 0, pages);
	drivers/fpga/dfl-afu-dma-region.c:	pinned = pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
	lib/iov_iter.c:	res = pin_user_pages_fast(addr, maxpages, gup_flags, *pages);

We can easily check if some of these drivers (of which some we don't
even ship/support) are loaded and decide this system is not safe
for CMA crashkernel. Maybe looking at the list more thoroughly
will show that even some of the above calls are acually safe,
e.g. because the DMA is set up for reading only.
lib/iov_iter.c seem like it could be the real
problem since it's used by generic block layer...

> > > The crashkernel=,cma requires no userspace data dumping, from our
> > > support engineers' feedback, customer never express they don't need to
> > > dump user space data. Assume a server with huge databse deployed, and
> > > the database often collapsed recently and database provider claimed that
> > > it's not database's fault, OS need prove their innocence. What will you
> > > do?
> > 
> > Don't use CMA backed crash memory then? This is an optional feature.

Right. Our kdump does not dump userspace by default and we would
of course make sure ,cma is not used when the user wanted to turn
on userspace dumping.

> > Jiri will know better than me but for us a proper crash memory
> > configuration has become a real nut. You do not want to reserve too much
> > because it is effectively cutting of the usable memory and we regularly
> > hit into "not enough memory" if we tried to be savvy. The more tight you
> > try to configure the easier to fail that is. Even worse any in kernel
> > memory consumer can increase its memory demand and get the overall
> > consumption off the cliff. So this is not an easy to maintain solution.
> > CMA backed crash memory can be much more generous while still usable.
> 
> Hmm, Redhat could go in a different way. We have been trying to:
> 1) customize initrd for kdump kernel specifically, e.g exclude unneeded
> devices's driver to save memory;

ditto

> 2) monitor device and kenrel memory usage if they begin to consume much
> more memory than before. We have CI testing cases to watch this. We ever
> found one NIC even eat up GB level memory, then this need be
> investigated and fixed.
> With these effort, our default crashkernel values satisfy most of cases,
> surely not call cases. Only rare cases need be handled manually,
> increasing crashkernel.

We get a lot of problems reported by partners testing kdump on
their setups prior to release. But even if we tune the reserved
size up, OOM is still the most common reason for kdump to fail
when the product starts getting used in real life. It's been
pretty frustrating for a long time.

> Wondering how you will use this crashkernel=,cma syntax. On normal
> machines and virt guests, not much meomry is needed, usually 256M or a
> little more is enough. On those high end systems with hundreds of Giga
> bytes, even Tera bytes of memory, I don't think the saved memory with
> crashkernel=,cma make much sense.

I feel the exact opposite about VMs. Reserving hundreds of MB for
crash kernel on _every_ VM on a busy VM host wastes the most
memory. VMs are often tuned to well defined task and can be set
up with very little memory, so the ~256 MB can be a huge part of
that. And while it's theoretically better to dump from the
hypervisor, users still often prefer kdump because the hypervisor
may not be under their control. Also, in a VM it should be much
easier to be sure the machine is safe WRT the potential DMA
corruption as it has less HW drivers. So I actually thought the
CMA reservation could be most useful on VMs.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

