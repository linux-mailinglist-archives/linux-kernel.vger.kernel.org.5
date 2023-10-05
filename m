Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1317BA25E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjJEPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjJEPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:32:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783814DF75
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:50:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F25701480;
        Thu,  5 Oct 2023 01:51:57 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FDD3F5A1;
        Thu,  5 Oct 2023 01:51:17 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:49:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Olivier Deprez <Olivier.Deprez@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20231005084946.vn4mbizdisaw4q5d@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
 <20231004091154.GB1091193@rayden>
 <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
 <20231004153234.ktk6egntk7drao47@bogus>
 <CAHUa44GWA_WQSgOgtQKgawc11vpaD5B4q5rNq8fxnEFJk_NzmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44GWA_WQSgOgtQKgawc11vpaD5B4q5rNq8fxnEFJk_NzmA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:57:26AM +0200, Jens Wiklander wrote:
> Hi Sudeep,
> 
> On Wed, Oct 4, 2023 at 5:32 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 04, 2023 at 10:50:26AM +0100, Olivier Deprez wrote:
> > > Hi Jens,
> > >
> > > > dst_id and drv_info->vm_id should be swapped.
> > >
> > > I'm curious about this because swapping like this actually makes hafnium
> > > fail. Need to check from the spec.
> >
> > I did check after I had swapped this in v2(because I was convinced Jens) was
> > correct and you reported the failure. Reading the spec again the other day,
> > I got corrected myself and agreed with Olivier and my original
> > implementation(v1) which matches this patch(v3).

Well, I am not exactly sure what is the root cause for the confusion here:
My poor choice of variable names and their usage with this macro, or the
macro definition itself(I am not sure)

OR

The wordings in the specification

>
> I don't get it. The spec says for FFA_NOTIFICATION_BIND:
> Sender and Receiver endpoint IDs.
> – Bit[31:16]: Sender endpoint ID.
> – Bit[15:0]: Receiver endpoint ID.
> This is exactly the same as for instance FFA_MSG_SEND_DIRECT_REQ.
>

Not really as per my understanding of the specification.

> In ffa_msg_send_direct_req() you assign
> src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
>

Correct and if you look at the callsite, it is
	ffa_msg_send_direct_req(drv_info->vm_id, dev->vm_id,...)

So the driver is the sender and the partition is the receiver. Probably
this is simpler.

> but here in ffa_notification_bind_common() you assign
> src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
>

A receiver(FF-A driver) must bind a non-framework notification to a
sender(SP) before the latter can signal the notification to the former.
Only the sender can ring these doorbells. A receiver uses the
FFA_NOTIFICATION_BIND interface to bind one or more notifications to the
sender.

So, based on this text(modified to refer sender and receiver in the driver
context) from the spec, my understanding is the driver is the receiver
and the SP is the sender of the notification.

Do you think I am missing someting here ? Sorry for agreeing with you
in v2 and silently changing it back without this actual discussion.
Olivier raised the issue and then when I went back and looked at the
spec, I realised why I had it this way from the beginning.

-- 
Regards,
Sudeep
