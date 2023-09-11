Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8E79BBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbjIKVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjIKJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:19:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91764CD3;
        Mon, 11 Sep 2023 02:19:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A538C433C7;
        Mon, 11 Sep 2023 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694423956;
        bh=CMfUhNrtWuDI24j8Rms6Yate8XX09AcwZIWD3r2Z/zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmoFmUhxt/yiEd8G4jeOoUDXygJumzb975APomu67gdlwxo5cS2WCXKyVSTrBqa/M
         NR4IkGbrcCIzRa5UWolX8IyFd5w/w+wzMiEFpXCRf/nP6lLHaHpfmnD4josve/7vFm
         MYUzhzVJaHdlkUeAiGNmJNunEe9UeIf/Fxt3k/MWPuMSmB8Mi/9FvNpBezFQhKKjf/
         QotFPklwBoxQ2wGiLd/AhmauC3KX10AJ6ZJRYfYUIugPeITN9qdKwd5ZCj2u1d3W9y
         6ciI1UHwEy6LiLKoT/bNyVPb/lpwXHo77YK1VVQUV9kZ65C5/QCx7d1+U1L2BkTJGJ
         8nC3vpdKXpiBw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qfd4b-00005f-0p;
        Mon, 11 Sep 2023 11:19:13 +0200
Date:   Mon, 11 Sep 2023 11:19:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Drown <dan-netdev@drown.org>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 24/25] usb: cdc-acm: move ldisc dcd
 notification outside of acm's read lock
Message-ID: <ZP7bkRc-1U8-M6X1@hovoldconsulting.com>
References: <20230909003715.3579761-1-sashal@kernel.org>
 <20230909003715.3579761-24-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909003715.3579761-24-sashal@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 08:37:12PM -0400, Sasha Levin wrote:
> From: Dan Drown <dan-netdev@drown.org>
> 
> [ Upstream commit f72ae60881ff685004d7de7152517607fcd9968f ]
> 
> dcd_change notification call moved outside of the acm->read_lock
> to protect any future tty ldisc that calls wait_serial_change()
> 
> Signed-off-by: Dan Drown <dan-netdev@drown.org>
> Acked-by: Oliver Neukum <oneukum@suse.com>
> Link: https://lore.kernel.org/r/ZN1zV/zjPgpGlHXo@vps3.drown.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/class/cdc-acm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 11da5fb284d0a..ca51230f44409 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -318,6 +318,16 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
>  		}
>  
>  		difference = acm->ctrlin ^ newctrl;
> +
> +		if ((difference & USB_CDC_SERIAL_STATE_DCD) && acm->port.tty) {
> +			struct tty_ldisc *ld = tty_ldisc_ref(acm->port.tty);
> +			if (ld) {
> +				if (ld->ops->dcd_change)
> +					ld->ops->dcd_change(acm->port.tty, newctrl & USB_CDC_SERIAL_STATE_DCD);
> +				tty_ldisc_deref(ld);
> +			}
> +		}
> +
>  		spin_lock_irqsave(&acm->read_lock, flags);
>  		acm->ctrlin = newctrl;
>  		acm->oldcount = acm->iocount;

This is a fix for a commit in 6.6-rc1 (3b563b901eef ("usb: cdc-acm: add
PPS support")) so a backport of it makes no sense.

Please drop.

Johan
