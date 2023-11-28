Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8327FAF32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjK1Al7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1Al5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:41:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31C1A7;
        Mon, 27 Nov 2023 16:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701132123; x=1732668123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3VfU9NwhaNjLoj9hTq3TLLG+FPVaZX89uWfoXGqjeb8=;
  b=evhprX2L20vxQey8za4eyWxz5yy/359HRsNAVPVOcS+/IRjRWVF9Ikj6
   eVoVtzSMwYSXmn8vOoO9OrrxTOksJvoS3UGbrpXt5s9GbXTLyXIHz3YJa
   TQC/eNKRG1lTYF6i/Ww7eU66lN7lmprzRCdfU5lH91818uLN37+P7tb5a
   ojsI4BgDQF327QUsTEnfS3fbXmZ1FDLVNUcBPHSlArns3H/hDcbgWJzC9
   oUFTmp6CnRYPQMgrLtPkWOzMaddZ+zk2BA1ULynwHuxx07svlO1iA8cKX
   1sVMWDFJGjMYTrDnWueT0Y5QqJGBeJ4ZPU709fzaOP4mRfaOSgSH1jKqS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389976671"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="389976671"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 16:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834483743"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="834483743"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 16:42:03 -0800
Date:   Mon, 27 Nov 2023 16:42:02 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZWU3WkmUMz3Wk9wT@agluck-desk3>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
 <ZWTzAujHdrJ950F3@agluck-desk3>
 <ZWT4pAJ6g0i78wec@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWT4pAJ6g0i78wec@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:14:28PM -0800, Tony Luck wrote:
> On Mon, Nov 27, 2023 at 11:50:26AM -0800, Tony Luck wrote:
> > On Tue, Nov 21, 2023 at 12:54:48PM +0100, Borislav Petkov wrote:
> > > On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
> > But it isn't doing the same thing.  The timer calls:
> > 
> > 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> > 
> > and cmci_mc_poll_banks() calls:
> > 
> > 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

        machine_check_poll(0, this_cpu_ptr(&mce_banks_owned));

> 
> Bah ... I've cut & pasted the same thing ... but I think there
> are separate bit maps ... maybe I'm wrong. Will go back and
> look again.
> 
> -Tony
