Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10F78ED31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346266AbjHaMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHaMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:34:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19DC19A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:34:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3D83C15;
        Thu, 31 Aug 2023 05:34:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C333A3F738;
        Thu, 31 Aug 2023 05:34:14 -0700 (PDT)
Date:   Thu, 31 Aug 2023 13:34:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: arm_scmi: Fix NULL pointer dereference in
 mailbox_clear_channel
Message-ID: <20230831123412.wetnqqb7owqfyqov@bogus>
References: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
 <20230830093902.duvvjimgwddh7qbt@bogus>
 <F59FC6AB-40E6-4BBA-A0BD-C7221160854B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F59FC6AB-40E6-4BBA-A0BD-C7221160854B@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:23:58PM +0800, Qiujun Huang wrote:
> 
> 
> > 2023年8月30日 下午5:39，Sudeep Holla <sudeep.holla@arm.com> 写道：
> > 
> > On Wed, Aug 30, 2023 at 01:07:47AM +0800, Qiujun Huang wrote:
> >> There is a race between the failure of probe and rx_callback (due to a
> >> delayed response).
> >> 
> >> scmi_probe
> >> scmi_acquire_protocal
> >> do_xfer
> >> timeout
> >> mailbox_chan_free
> >>                                                    <--- delay response
> >>                                                           rx_callback
> >> mbox_free_channel
> >> cinfo->transport_info = NULL
> >>                                                          mailbox_clear_channel
> >>                                                         dereference cinfo->transport_info
> > 
> > It is always good to provide the kernel stacktrace which you get when a
> > NULL pointer is dereference. It helps for review and also to document it.
> > 
> > -- 
> > Regards,
> > Sudeep
> 
> Get it. Here is the splat.
> 
> [    1.942240][    C0] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
> [    1.942241][    C0] Mem abort info:
> [    1.942243][    C0]   ESR = 0x96000005
> [    1.944888][    T9] spmi spmi-1: PMIC arbiter version v7 (0x70000000)
> [    1.950652][    C0]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.950653][    C0]   SET = 0, FnV = 0
> [    1.950654][    C0]   EA = 0, S1PTW = 0
> [    1.950656][    C0] Data abort info:
> [    1.950657][    C0]   ISV = 0, ISS = 0x00000005
> [    1.950658][    C0]   CM = 0, WnR = 0
> [    1.950660][    C0] [0000000000000048] user address but active_mm is swapper
> [    1.950663][    C0] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    2.338929][    C0] pc : mailbox_clear_channel+0x18/0x64
> [    2.344384][    C0] lr : scmi_handle_response+0x17c/0x4f4
> [    2.349923][    C0] sp : ffffffc010003db0
> [    2.354045][    C0] x29: ffffffc010003dc0 x28: ffffffd85263f000 
> [    2.360216][    C0] x27: ffffffd851621068 x26: ffffffd84ec815c8 
> [    2.366386][    C0] x25: ffffffd85263bf80 x24: ffffffd85263d230 
> [    2.372556][    C0] x23: ffffff803cd70cc0 x22: 0000000000000008 
> [    2.378726][    C0] x21: ffffff8036cf0df8 x20: ffffffd85161bac8 
> [    2.384896][    C0] x19: ffffff8043ffa580 x18: ffffffc010005050 
> [    2.391065][    C0] x17: 0000000000000000 x16: 00000000000000d8 
> [    2.397234][    C0] x15: ffffffd8507965e8 x14: ffffffd84eaebdf0 
> [    2.403404][    C0] x13: 00000000000001ea x12: 0000000000007ffb 
> [    2.409574][    C0] x11: 000000000000ffff x10: ffffffd852c5a000 
> [    2.415744][    C0] x9 : d7be1a9b75f29500 x8 : 0000000000000000 
> [    2.421914][    C0] x7 : 382e31202020205b x6 : ffffffd852c57e7c 
> [    2.428084][    C0] x5 : ffffffffffffffff x4 : 0000000000000000 
> [    2.434254][    C0] x3 : ffffffd84eae6668 x2 : 0000000000000001 
> [    2.440424][    C0] x1 : 0000000000000000 x0 : ffffff8043ffa580 
> [    2.446594][    C0] Call trace:
> [    2.449819][    C0]  mailbox_clear_channel+0x18/0x64

Is this with latest kernel ? IIUC the mailbox_clear_channel should get called
only for delayed response and notification in this path(scmi_handle_response).
You are saying it happens as part of probe and again IIUC probe doesn't have
any delayed response command. What am I missing ?

Any additional changes in the tree ? My build has much smaller
mailbox_clear_channel.

> [    2.454916][    C0]  scmi_handle_response+0x17c/0x4f4
> [    2.460100][    C0]  rx_callback+0x60/0xec
> [    2.464311][    C0]  mbox_chan_received_data+0x44/0x94
> [    2.469584][    C0]  qcom_rimps_rx_interrupt+0xc0/0x144 [qcom_rimps]

This suggests out of tree driver, any pointers ?

Also I vaguely remember discussing this in the past. Perhaps at [1] or
somewhere else.

--
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com/
