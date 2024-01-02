Return-Path: <linux-kernel+bounces-14656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB8822060
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95741C2265A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810C154B8;
	Tue,  2 Jan 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="cDvGAaI9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93D15499;
	Tue,  2 Jan 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 403FB2FC006B;
	Tue,  2 Jan 2024 18:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704216380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a74/zz8HrsjKCFeCoszDWgapalrYzqiYG2QXRna7kd0=;
	b=cDvGAaI9rnohgD/XRDF3DHd8vv74QTjXjkaK1ecurETnAs0IpIi1OIv4PpTgxC3udBq+oh
	MCRbDDJt0w6LPXmRldV2xNnXI2bdzHKeyIV2t3prbacDzyEvdnmOpZZQvxkvhYGzabiNuR
	p4FrZtdWEojK+bSHfCTYGey7CH6HN88=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ab2f9e55-8bdb-444a-b559-dc09c813af9c@tuxedocomputers.com>
Date: Tue, 2 Jan 2024 18:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i8042: Use new forcenorestore quirk to replace old
 buggy quirk combination
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
References: <20240102172356.78978-1-wse@tuxedocomputers.com>
 <20240102172356.78978-2-wse@tuxedocomputers.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20240102172356.78978-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to add Hans again for git send-email to adding him again after initial send.

Am 02.01.24 um 18:23 schrieb Werner Sembach:
> The old quirk combination sometimes cause a laggy keyboard after boot. With
> the new quirk the initial issue of an unresponsive keyboard after s3 resume
> is also fixed, but it doesn't have the negative side effect of the
> sometimes laggy keyboard.
>
> v2: Fix typo in commit message
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/input/serio/i8042-acpipnpio.h | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 10ec4534e5e14..e631a26394e92 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1142,18 +1142,10 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>   					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>   	},
>   	{
> -		/*
> -		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
> -		 * the keyboard very laggy for ~5 seconds after boot and
> -		 * sometimes also after resume.
> -		 * However both are required for the keyboard to not fail
> -		 * completely sometimes after boot or resume.
> -		 */
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
>   		},
> -		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> -					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
>   	},
>   	{
>   		.matches = {

