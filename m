Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59898812E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443859AbjLNLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443808AbjLNLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:04:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871A11D;
        Thu, 14 Dec 2023 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702551877; x=1734087877;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5QYydh+nV7rO0ti2n05onJEK+DBqaZEzvPhqHsdKqkQ=;
  b=JJ5mxr+jnlSxsqAb9p84T896HqGkJqWhUvWPg4ZsRPQ7cWc8iZrJXn8C
   abUMpTODzs5ogEdCQUGaJRVxccaRpB+CPiX+8rQ7Ly50ouhQZxWGAhMIT
   3QumVcm1ITnv/h9u5QDp5vpEVw3Tl/YsMJikkyd5JQbjQLgeFxiacaz98
   C0tbHa4fZv2mXzUNbZWjZk6dBOPHCZxg4MkrrA/HX4tmqN/R61MiV85jn
   dV7LI5N/NIdxuzzhCObiYPdGKbto6WXs9J0vILBd+6D+Up2/12VeZ6OdZ
   v18YMQU4KOg87aFprqhBicCYM8+Kl9OZg0BvV79u0AiRsXIHMf+7lSWw1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2185979"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2185979"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767572456"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="767572456"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2023 03:04:30 -0800
Message-ID: <7fdd62c6-f492-1f7e-9eca-9f965cdd73ef@linux.intel.com>
Date:   Thu, 14 Dec 2023 13:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Sam Edwards <cfsworks@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 0/2] Allow disabling USB3 ports in xHCI/DWC3
In-Reply-To: <20231208210458.912776-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.12.2023 23.04, Sam Edwards wrote:
> Hi USB devs,
> 
> This patchset is a semi-RFC: I haven't discussed this change yet, and it may
> turn out to be a bad idea. But if there is a consensus that this change is
> appropriate, these patches are the ones I'd submit for inclusion.
> 
> These patches were developed while working with a SoC (Rockchip RK3588) that
> contains DWC3-OTG controllers and accompanying USB2 + USB3/DP PHYs. My target
> (Turing RK1) uses its first bus in USB2.0-OTG mode only: the associated USB3
> PHY is reserved for DP. Worse, a driver for the USBDP block (though it exists)
> has not been merged to mainline. Without lighting up the PHY side of the PIPE,
> the DWC3 behaves erratically, even for USB2 operation.
> 
> This could be addressed by patching in the (out-of-tree) USBDP driver and
> enabling only its USB backend. However, I found it cleaner (also from a
> user-friendliness standpoint) just to disable the unusable USB3 port. These
> patches achieve that by (1) making it possible to tell the xHCI driver to
> ignore any USB3 port(s), and (2) (perhaps more controversially) making the DWC3
> driver disable USB3 host ports when `maximum-speed` isn't set high enough.

I don't think this will work as a generic xhci driver feature.

Even if we ignore all USB3 ports in software they will for most xHC hosts be powered
and enabled in hardware by default after controller reset.

This means they perform link training, generate all kinds of events with interrupts
(connect, over-current etc) that driver now can't handle.

Sound like the setup you are using has a very specific issue, and it would need
a narrow targeted quirk to solve it.

> 
> There are other ways to disable the USB3 ports on RK3588, such as via some
> syscon registers. I figured I would start with the most general solution
> (benefitting other SoCs) first, getting more specific only if necessary. :)

To me a specific solution to a specific problem like this sounds better.

Thanks
Mathias
