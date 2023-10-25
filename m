Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5798A7D678F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjJYJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjJYJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:52:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474C130;
        Wed, 25 Oct 2023 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698227576; x=1729763576;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dz1VmCxFJ+SngRQa9f6ZZEmeAlr+peVmwpQyAL3nbQs=;
  b=KIM560g5XUYoIR9h9ncmSwEAC6e6+2K5ay/VaVs1jShkQqHPL5n5NfAz
   MMQMz3IUfgcFkC8nID7mK0jXMilX3JbEOyGmhL07eE6TWv+3t9qzZIcQy
   td1+YSSM+nnxNokLPjBOvOxmv6rudReC0XOWijTXmzGdrwTlCtxr1UiXj
   /PLZt+zipx5XMPJ5NZsWbvVXf0VjdeXLQIcSzZRdjbLcYeQfg4HiuKIsz
   2etZn52JFiw0hJ+BplyCG2d7XdxG2jQSHUdRep6GwGFZdbDwmvby3hmqy
   uHjzZvNnHekfyItAQxKehT7om6hGwF7Knz+sAbH2XuqbJGA/48IZ5XLX8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5889024"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5889024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="788072828"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="788072828"
Received: from cristina-mobl3.ger.corp.intel.com ([10.251.212.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:52:52 -0700
Date:   Wed, 25 Oct 2023 12:52:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Preparations for fixing WMI reprobing issue
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
Message-ID: <123de6d2-fa8-ad7f-fac-9750a8a1358@linux.intel.com>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Armin Wolf wrote:

> This patch series contains preparations for fixing the WMI reprobing
> issue discussed here:
> 
> https://lkml.kernel.org/1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de
> 
> It mainly aims to decouple some parts of the WMI subsystem from the
> wmi_block_list, which is going to get replaced in the future. It also
> fixes some issues, like a probe failure when failing to register WMI
> devices and a potential issue when opening the wmi char device.
> 
> The changes where tested on a Dell Inspiron 3505, a Lenovo E51-80,
> a Acer Aspire E1-731 and a Asus PRIME B650-Plus motherboard and appear
> to work, but additional feedback especially on the third patch
> is appreciated.
> 
> Changes since v2:
> - Drop already merged first patch
> - break the paragraphs of the second patch with an empty line
> 
> Armin Wolf (5):
>   platform/x86: wmi: Decouple probe deferring from wmi_block_list
>   platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
>   platform/x86: wmi: Fix probe failure when failing to register WMI
>     devices
>   platform/x86: wmi: Fix opening of char device
>   platform/x86: wmi: Decouple WMI device removal from wmi_block_list
> 
>  drivers/platform/x86/wmi.c | 263 ++++++++++++++++++++++---------------
>  1 file changed, 157 insertions(+), 106 deletions(-)

I've now applied these into review-ilpo branch.

I adjusted the long blocks of text in the changelogs. In the future, if 
you have a changelog that is longer than ~4 lines, please try to split the 
problem description and solution into separate paragraphs as it makes the 
changelog less heavy to read.

-- 
 i.

