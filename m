Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD477FAB17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjK0UO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0UOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:14:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B51B6;
        Mon, 27 Nov 2023 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701116070; x=1732652070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SxzevEclsE/KPgHwJilVWyMcBuoIU7bogsOVE5VIkzg=;
  b=fLNWSnck7Rwlg8TCSD9NksHaR49imm9FjJgoiyxAe889KfdNNTkpb5aL
   S9VpMaeDeBvfe3k6f8NH2zKEzrP7CqLnCxiEvZWxvBIuMT6xmv9dqMnGS
   lC38zYtfgN1p23uQSnAOuioMIdnClO/keIYa/ODCfHC6dI0iqJFBZzMs2
   DJ3KiL6mWApnAW7wopmL1teQhCUNdHegTXduuhssIIgGGgf1hSZURGS1U
   m+xFpP/D1zkzgg6egFQy/pGBsolxuPoyMsrsuOjCtPPENpiHfqpRbnnDu
   dNhunCNXEsUdsMVo12vgB2UlNFifteF4yFcu9vz8qcBa3z0XhHTdEp+V4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372948073"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372948073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797345443"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="797345443"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:14:29 -0800
Date:   Mon, 27 Nov 2023 12:14:28 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZWT4pAJ6g0i78wec@agluck-desk3>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
 <ZWTzAujHdrJ950F3@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTzAujHdrJ950F3@agluck-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:50:26AM -0800, Tony Luck wrote:
> On Tue, Nov 21, 2023 at 12:54:48PM +0100, Borislav Petkov wrote:
> > On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
> But it isn't doing the same thing.  The timer calls:
> 
> 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> 
> and cmci_mc_poll_banks() calls:
> 
> 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

Bah ... I've cut & pasted the same thing ... but I think there
are separate bit maps ... maybe I'm wrong. Will go back and
look again.

-Tony
