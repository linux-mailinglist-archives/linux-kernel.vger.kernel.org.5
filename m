Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14D7F58B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjKWG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjKWG5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:57:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD76D5A;
        Wed, 22 Nov 2023 22:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700722669; x=1732258669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSSKqxFMQeGyy+U4Vp/A4nwnDKKfSQTSbRhi17Xi79c=;
  b=ajJzcNbj1TRGG8uF7Mu+lH7uLLYyICMA4PGgKNf9JMC9MoUmgKBKDsdw
   qSe3vaTPon8rHbMWpGkrzXi1frDy3RbBq48u0kRjoJDhRgi8HEHPSfq7z
   1CF0kE477VzuKaKQB717PT3fnvCVX38c886dpMYGThrx6rH0lwkLn95r2
   C7OlJvtPMVBIhbxtsAp1RCCb+Ux9sobEjcI/P0O8bYwIi/VUDwtJaVUfG
   hNoSXn1pV6LN551Xa8tsCJY7jIjq2DmZ23BEzc9Y7MJu0pgT+HC+xlDpv
   PV923F+Y9ROrHk+XAZ7ktOma60jqX1m0+A9vqRBJIYPaYa3PPRffM67F2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456544969"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="456544969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911079181"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="911079181"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 22:57:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4F8CC2A6; Thu, 23 Nov 2023 08:57:39 +0200 (EET)
Date:   Thu, 23 Nov 2023 08:57:39 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sanath S <sanaths2@amd.com>, Sanath S <Sanath.S@amd.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Message-ID: <20231123065739.GC1074920@black.fi.intel.com>
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
 <efb152bc-fd17-a374-4303-20aa9bde698d@amd.com>
 <20231123060516.GB1074920@black.fi.intel.com>
 <1687d5aa-3c79-4bbf-ae4f-891208edab9b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1687d5aa-3c79-4bbf-ae4f-891208edab9b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:23:36AM -0600, Mario Limonciello wrote:
> > It can be used to re-configure the link but also simple reset.
> > 
> > Actually can we instead of the quirk in quirks.c add this to nhi.c and
> > "host_reset". So that on these AMD controllers trigger host reset in the
> > same way Windows would?
> > 
> > That's DPR and probably host interface reset. In other words tie this to
> > the host reset we are doing for USB4 v2 routers (this one adds it for
> > USB4 v1 routers and enables it by default for AMD).
> 
> Assuming this "works" how would you feel about just "aligning the behavior"
> with Windows for all USB4 routers instead of just these AMD controllers and
> USB4v2?

I was thinking the same pretty much after I wrote the reply ;-) Yeah, I
think it is worth a try.

It may need some additional code from Intel side to get the host fully
reset but I can do that myself on top.
