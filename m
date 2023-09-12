Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9379C44F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbjILDlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjILDla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:41:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB542737;
        Mon, 11 Sep 2023 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694488899; x=1726024899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyBMVRJMQibKvySpIWcoHMqhgrudXfTR87m1mqfpg1c=;
  b=WMz5OPWWdg3DawfID1t11IfFi32OwsMLAoskPaBHC5TYH4yC4wzVRd48
   +i2MD/ClvBLnCA4Li6hw+2znzjHZ9Ihn6oTuFH+SgeUxk00jI6tGvEEB9
   sZifW5JXHjNvc2VhfKh5QKTEULdo9jrpjjU6hCEn2EREp+Ph8bcQ4oUxT
   9cQGXRlB5XjnDYITNy6zM/8L4jWAsU7gPk8CSrIUrRTLwxQKOaCIXgZ3h
   +4Nk0/IUbdFsrHIcw6dHOd4LyDzKWk/inSUyiZhlJjWkX09+isYTnpWOS
   wZ3XFonYpTbqWeAr8EIuU2aq8C4q7yoUo4NuwSjMzEl+GwfXTU7zQSstO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358540473"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="358540473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720228698"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="720228698"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:21:32 -0700
Date:   Mon, 11 Sep 2023 20:23:50 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Andreas Herrmann <aherrmann@suse.de>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20230912032350.GA17008@ranerica-svr.sc.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230901065028.GG8103@alberich>
 <20230901075254.GH8103@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901075254.GH8103@alberich>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 09:52:54AM +0200, Andreas Herrmann wrote:
> On Fri, Sep 01, 2023 at 08:50:31AM +0200, Andreas Herrmann wrote:
> > On Fri, Aug 04, 2023 at 06:24:18PM -0700, Ricardo Neri wrote:
> > > Hi,
> > 
> > Hi Ricardo,
> > 
> > > This is v3 of a patchset to set the number of cache leaves independently
> > > for each CPU. v1 and v2 can be found here [1] and here [2].
> > 
> > I am on CC of your patch set and glanced through it.
> > Long ago I've touched related code but now I am not really up-to-date
> > to do a qualified review in this area. First, I would have to look
> > into documentation to refresh my memory etc. pp.
> > 
> > I've not seen (or it escaped me) information that this was tested on a
> > variety of machines that might be affected by this change. And there
> > are no Tested-by-tags.
> > 
> > Even if changes look simple and reasonable they can cause issues.
> > 
> > Thus from my POV it would be good to have some information what tests
> > were done. I am not asking to test on all possible systems but just
> > knowing which system(s) was (were) used for functional testing is of
> > value.
> 
> Doing a good review -- trying to catch every flaw -- is really hard to
> do. Especially when you are not actively doing development work in an
> area.
> 
> For example see
> 
>   commit e33b93650fc5 ("blk-iocost: Pass gendisk to ioc_refresh_params")
>   [Breno Leitao <leitao@debian.org>, Tue Feb 28 03:16:54 2023 -0800]
> 
> This fixes commit
> 
>   ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more
>   useful") [Christoph Hellwig <hch@lst.de>, Fri Feb 3 16:03:54 2023
>   +0100]
> 
> I had reviewed the latter (see
> https://marc.info/?i=Y8plg6OAa4lrnyZZ@suselix) and the entire patch
> series. I've compared the original code with the patch and walked
> through every single hunk of the diff and tried to think it
> through. The changes made sense to me. Then came the bug report(s) and
> I felt that I had failed tremendously. To err is human.
> 
> What this shows (and it is already known): with every patch new errors
> are potentially introduced in the kernel. Functional, and higher
> level testing can help to spot them before a kernel is deployed in the
> field.
> 
> At a higher level view this proves another thing.
> Linux kernel development is a transparent example of
> "peer-review-process".
> 
> In our scientific age it is often postulated that peer review is the
> way to go[1] and that it kind of guarantees that what's published, or
> rolled out, is reasonable and "works".
> 
> The above sample shows that this process will not catch all flaws and
> that proper, transparent and reliable tests are required before
> anything is deployed in the field.
> 
> This is true for every branch of science.
> 
> If it is purposely not done something is fishy.
> 
> 
> [1] Also some state that it is "the only way to go" and every thing
> figured out without a peer-review-process is false and can't be
> trusted. Of course this is a false statement.

Hi Andreas,

Agreed. Testing is important. For the specific case of these patches, I
booted CONFIG_PREEMPT_RT and !CONFIG_PREEMPT_RT kernels. Then I
  a) Ensured that the splat reported in commit 5944ce092b97
     ("arch_topology: Build cacheinfo from primary CPU") was not observed.

  b) Ensured that /sys/devices/system/cpu/cpuX/cache is present.

  c) Ensured that the contents /sys/devices/system/cpu/cpuX/cache is the
     same before and after my patches.

I tested on the following systems: Intel Alder Lake, Intel Meteor
Lake, 2-socket Intel Icelake server, 2-socket Intel Cascade Lake server,
2-socket Intel Skylake server, 4-socket Intel Broadwell server, 2-socket
Intel Haswell server, 2-socket AMD Rome server, and 2-socket AMD Milan
server.

Thanks and BR,
Ricardo
