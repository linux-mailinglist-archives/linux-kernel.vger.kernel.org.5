Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F627B8CA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbjJDTQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbjJDTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:16:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26510171E;
        Wed,  4 Oct 2023 12:16:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0C6C433C8;
        Wed,  4 Oct 2023 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446975;
        bh=UGWfEq96LPoL2DJ4iPTL/UOZYg+9lvo1XfLHM+eQIc0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tShegiyBNnzyHruJ+bS/TORGBESplQQ2gItE4COmHAoR34eMmuxG20vRiuJNLE/CK
         8OIICuQJproFGrNTruF16/Wdothk/TD2emE5Itt7641nqnj3UOkweWCiuZXB2GcHZx
         Hvmz1Xcz3zwpG1Z7xkaYy3qFM0GImuNC2D4V1ehm7gITRykaSP8knVpp88+kGoJAda
         vrui+4TEZrH9rxu5rrR+MFV1dbubxSIsOzc9LqfO2ypWh58hHl2vjAdVBZAeRmeHx6
         uVvd28njDsf3yUt/3T0LUw8GN4rWQz0+/ogEjgy8x9I5Sauqzo3CZxKfKvraT03B46
         ujClQCAHkvC5g==
Date:   Wed, 4 Oct 2023 21:16:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Fabian Vogt <fabian@ritter-vogt.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Add quirk to ignore the touchscreen battery on HP
 ENVY 15-eu0556ng
In-Reply-To: <4537226.LvFx2qVVIh@fabians-envy>
Message-ID: <nycvar.YFH.7.76.2310042116030.3534@cbobk.fhfr.pm>
References: <4537226.LvFx2qVVIh@fabians-envy>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023, Fabian Vogt wrote:

> Like various other devices using similar hardware, this model reports a
> perpetually empty battery (0-1%).
> 
> Join the others and apply HID_BATTERY_QUIRK_IGNORE.
> 
> Signed-off-by: Fabian Vogt <fabian@ritter-vogt.de>
> ---
>  drivers/hid/hid-ids.h   | 1 +
>  drivers/hid/hid-input.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7e499992a793..e4d2dfd5d253 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -425,6 +425,7 @@
>  #define I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100	0x29F5
>  #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
>  #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
> +#define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
>  
>  #define USB_VENDOR_ID_ELECOM		0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084	0x0061
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 0235cc1690a1..c8b20d44b147 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -409,6 +409,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
>  	  HID_BATTERY_QUIRK_IGNORE },
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2),
>  	  HID_BATTERY_QUIRK_IGNORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
> +	  HID_BATTERY_QUIRK_IGNORE },
>  	{}

Applied, thanks Fabian.

-- 
Jiri Kosina
SUSE Labs

