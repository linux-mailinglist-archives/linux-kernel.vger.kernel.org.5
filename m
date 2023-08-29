Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D190078BC23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjH2Ab3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjH2AbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:31:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F32109;
        Mon, 28 Aug 2023 17:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693269076; x=1724805076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+O0znDO+Pz3D60RFYXIkyVZSD4gqgtT9ZrBhiyflP+Q=;
  b=JgRjYWvtSOrCO4igVo2KKt3kFc4WPEfWT7/9L9pxtnrENIcGKJ+WVp30
   6Hk6o2izFJT8eNutQAdOLJh9SEvIWCSdrIUp9U1GuhdDmPYGvL3s6+1bw
   e83pg1jxXMSPqw43+fNlYNF76cvAl7qOs91MhCA2SaAaV61NC2Ja6alon
   By49cXOsme8i6dIiTN8Q4DBF05neReH+FLN1JYNR63IdwqMmV/dz77/LA
   /ADt3ojcazcLHkddm/0KfIgLSG8w3+o7qzpWEzC/rRpXPdndGmCvLWbjO
   C1YEE6dtski+sCP6hboOBa/3dPbHUVIu0iIxQBgaej+DHNuWG2eq+N5/b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="379015205"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="379015205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882117833"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:31:20 -0700
Date:   Mon, 28 Aug 2023 17:31:13 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
Message-ID: <ZO08UYWgxAATl/oq@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
 <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
 <ZOzroJqc22HFZOXq@agluck-desk3>
 <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
 <ZO0KtAefCStikXEm@agluck-desk3>
 <e3cbefc5-e686-5561-a71e-06417ab51d07@intel.com>
 <ZO0b2j5lOpxPu3iw@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO0b2j5lOpxPu3iw@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming to the core of the discussion.

> > >> 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> > >> 		domain_free(hw_dom);
> > >> 		return;
> > >> 	}
> > >>
> > >> 	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> > >> 		domain_free(hw_dom);
> > >> 		return;
> > >> 	}

In the current code the control and monitor functions share a domain
structure. So enabling one without the other would lead to a whole
slew of complications. Various other bits of code would need to change
to make run-time checks that the control/monitor pieces of the shared
domain structure had been completely set up. So the existing code takes
the easy path out and says "if I can't have both, I'll take have
neither".

> > >> The above is the other item that I've been trying to discuss
> > >> with you. Note that existing resctrl will not initialize monitoring if
> > >> control could not be initialized.
> > >> Compare with this submission:
> > >>
> > >> 	if (r->alloc_capable)
> > >> 		domain_add_cpu_ctrl(cpu, r);
> > >> 	if (r->mon_capable)
> > >> 		domain_add_cpu_mon(cpu, r);

With the updates I'm making, there are separate domain structures for
control and monitor.  They don't have to be tied together. It's possible
for initialization to fail on one, but the other remain completely
functional (without adding "is this completely setup" checks to
other code).

The question is what should the code do? Should it allow a partial
success (now that is possible)? Or should it maintain legacy behavior
and block use of both control and monitor for domain if either fails
to allocate necessary memory to operate?

I'm generally in favor of legacy semantics. But it seems weird to make
the code deliberately worse to preserve this particular behavior.
Especially as it adds complexity to the code for a case that in practice
is never going to happen.

-Tony
