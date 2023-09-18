Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037F7A4FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjIRQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjIRQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:48:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A78210A;
        Mon, 18 Sep 2023 09:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ACDC433C7;
        Mon, 18 Sep 2023 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695055662;
        bh=Offg6VmtFe2UBByUqEhSGUwj6q3tNukHJa7EtuPg/UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfmpFokFWz+1524hZtLpJ7zeYbI902PzYuG/+6N96zVgQWjmAsmsjrUqQaewh+kOj
         8hfV9Rt1PQVZcFai8A+RqKiDo2LNo6AUCGpwljNQoAPchhFxgtRyRxpoBkygHVoGfY
         iMRarhhfX7ThGSQTLJQ2saAh7xn6wI2pIbhzQxZCb1CLGm2KhZb26lNmePFv9zs3l0
         Vw73HQ6L4/XH6bGA4QGFiKnzQ6rNz9M7Yz9dAM+YI+fq/7Wl8PVKWhVl0eA+1Oz8Xk
         mb0LMwINAOiMQCByIQ7xBdm4suF54dGa9YH/42BaXwMNViy23JrZQG8R7D5rWspNDT
         TwpzGrIpVmfXg==
Date:   Mon, 18 Sep 2023 12:47:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Drown <dan-netdev@drown.org>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 24/25] usb: cdc-acm: move ldisc dcd
 notification outside of acm's read lock
Message-ID: <ZQh/LTtayWgQ/BrS@sashalap>
References: <20230909003715.3579761-1-sashal@kernel.org>
 <20230909003715.3579761-24-sashal@kernel.org>
 <ZP7bkRc-1U8-M6X1@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZP7bkRc-1U8-M6X1@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:19:13AM +0200, Johan Hovold wrote:
>On Fri, Sep 08, 2023 at 08:37:12PM -0400, Sasha Levin wrote:
>> From: Dan Drown <dan-netdev@drown.org>
>>
>> [ Upstream commit f72ae60881ff685004d7de7152517607fcd9968f ]
>>
>> dcd_change notification call moved outside of the acm->read_lock
>> to protect any future tty ldisc that calls wait_serial_change()
>>
>> Signed-off-by: Dan Drown <dan-netdev@drown.org>
>> Acked-by: Oliver Neukum <oneukum@suse.com>
>> Link: https://lore.kernel.org/r/ZN1zV/zjPgpGlHXo@vps3.drown.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/usb/class/cdc-acm.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
>> index 11da5fb284d0a..ca51230f44409 100644
>> --- a/drivers/usb/class/cdc-acm.c
>> +++ b/drivers/usb/class/cdc-acm.c
>> @@ -318,6 +318,16 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
>>  		}
>>
>>  		difference = acm->ctrlin ^ newctrl;
>> +
>> +		if ((difference & USB_CDC_SERIAL_STATE_DCD) && acm->port.tty) {
>> +			struct tty_ldisc *ld = tty_ldisc_ref(acm->port.tty);
>> +			if (ld) {
>> +				if (ld->ops->dcd_change)
>> +					ld->ops->dcd_change(acm->port.tty, newctrl & USB_CDC_SERIAL_STATE_DCD);
>> +				tty_ldisc_deref(ld);
>> +			}
>> +		}
>> +
>>  		spin_lock_irqsave(&acm->read_lock, flags);
>>  		acm->ctrlin = newctrl;
>>  		acm->oldcount = acm->iocount;
>
>This is a fix for a commit in 6.6-rc1 (3b563b901eef ("usb: cdc-acm: add
>PPS support")) so a backport of it makes no sense.
>
>Please drop.

Done, thanks!

-- 
Thanks,
Sasha
