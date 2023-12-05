Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427E8805C47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjLEO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345742AbjLEO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:57:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5013C9;
        Tue,  5 Dec 2023 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701788229; x=1733324229;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=mlZUqVzzz78kYGKI5cXqocVGJbtwH388Pqsjwxt8CGE=;
  b=HJDY57ZuhNDJCR+XCRfL6Fd17/nPgoGudZfmJL82Mj3hrg8TuUsdVm0l
   Ycq0cC4nTUnwXJ0a3q041FVthWTJbRn/hFdIuAgAa3+66SdjK8RbcxA+2
   Zm1X2qZy6U7h1saetvUxQoFc4kTmgGMnmW3y4gcipg/mtgs77FglYNHje
   JIFW362ErU5IhD+dqUX4MJXJpnylOyLZOXvWmslgx0kNK+2Ld2KFuieDs
   ckQPGutPSS9LCh+mHw5FAP5pVEAjTvIHmBx5fHBXP9ON+Jpfq2Z7oPqGc
   u9srmuKRztWlvLRoV0WfmIyMo2FqM6l1/b8Ur2EcQr5j+mi1u2Jb3jZwV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="378929719"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="378929719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="799991881"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="799991881"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 06:57:06 -0800
Message-ID: <f02353be-4e51-aad2-08ee-d44b3693f061@linux.intel.com>
Date:   Tue, 5 Dec 2023 16:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Yaxiong Tian <iambestgod@outlook.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianyaxiong@kylinos.cn
References: <TYZPR01MB4784CB3058AC1B5787DB6601D586A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb:xhci: Avoid hub_event() stuck when xHC restore state
 timeout
In-Reply-To: <TYZPR01MB4784CB3058AC1B5787DB6601D586A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.12.2023 10.02, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> when xHc restore state timeout,the xhci_reusme() return -ETIMEDOUT

Out of curiosity, have you tried if it still is possible to revive your
xHC controller here?

Instead of returning -ETIMEDOUT, try setting " reinit_xhc = true", and
jump to  "if (reinit_xhc) {"  where we reinitialize xHC in xhci_resume() due
to other resume issues.

> instantly. After usb_hc_died() called ,they kick hub_wq to running
> hub_event() but the wq is freezd. When suspend ends,hub_evnet realy
> running and sticking.
> Such as:
> [  968.794016][ 2] [   T37] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  968.802969][ 2] [   T37] kworker/2:3     D    0   999      2 0x00000028
> [  968.809579][ 2] [   T37] Workqueue: usb_hub_wq hub_event
> [  968.814885][ 2] [   T37] Call trace:
> [  968.818455][ 2] [   T37]  __switch_to+0xd4/0x138
> [  968.823067][ 2] [   T37]  __schedule+0x2dc/0x6a0
> [  968.827680][ 2] [   T37]  schedule+0x34/0xb0
> [  968.831947][ 2] [   T37]  schedule_timeout+0x1e0/0x298
> [  968.837079][ 2] [   T37]  __wait_for_common+0xf0/0x208
> [  968.842212][ 2] [   T37]  wait_for_completion+0x1c/0x28
> [  968.847432][ 2] [   T37]  xhci_configure_endpoint+0x104/0x640
> [  968.853173][ 2] [   T37]  xhci_check_bandwidth+0x140/0x2e0
> [  968.858652][ 2] [   T37]  usb_hcd_alloc_bandwidth+0x1c8/0x348
> [  968.864393][ 2] [   T37]  usb_disable_device+0x198/0x260
> [  968.869698][ 2] [   T37]  usb_disconnect+0xdc/0x3a0
> [  968.874571][ 2] [   T37]  usb_disconnect+0xbc/0x3a0
> [  968.879441][ 2] [   T37]  hub_quiesce+0xa0/0x108
> [  968.884053][ 2] [   T37]  hub_event+0x4d4/0x1558
> [  968.888664][ 2] [   T37]  kretprobe_trampoline+0x0/0xc4
> [  968.893884][ 2] [   T37]  worker_thread+0x4c/0x488
> [  968.898668][ 2] [   T37]  kthread+0xf8/0x128
> [  968.902933][ 2] [   T37]  ret_from_fork+0x10/0x18
> 
> The result is that you cannot suspend again.because the wq can't
> be freezed.Also hard to reboot,when some application visited this
> piece.
> 
> The reason of stuck is that some access related to xhci hardware
> is being called.But xhci has problem,at least not running.(
> when xhci_restore_registers(),the xhci will load op_regs.The
> CMD_RUN will clear in xhci_suspend().)
> 

Nice catch and debugging work btw.

> So using XHCI_STATE_DYING flag,to avoid any code to touching
> hardware immediately.hub_event() will complete.The usb_hc_died
> tasks will be completed and some sys interfaces will be removed.

The XHCI_STATE_DYING flag is currently only set in xhci_hc_died().
So when this flag is set we could assume that the command ring and
pending URBs are, or will be cleaned up. This would change with your patch.
  
We might need some other solution,
Maybe set the set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags) after
CNR (Contorller Not Ready) is successfully cleared, and controller is
actually accessible.

We then would need to add checks to see if controller is accessible
before queuing any commands to xHC hardware.

Thanks
Mathias
