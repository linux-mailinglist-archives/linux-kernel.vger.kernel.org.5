Return-Path: <linux-kernel+bounces-7178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248F81A2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CFA1C23B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4162405ED;
	Wed, 20 Dec 2023 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="bJIMUG2S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB63FB0B;
	Wed, 20 Dec 2023 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 7A0142FC005D;
	Wed, 20 Dec 2023 16:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1703086706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh4BwqGQX+3KQNJkHIAuHIku7RX7fc7Y+ZvFl8sSnH8=;
	b=bJIMUG2SIBwrDr+t8Sayz+kIotVPgRQ1OHTU3BIZA/MP2KkkzIeG52wrk75xomqKJ3qj2d
	T+DRddnE/Pi3hEHVwpi+GuHnS2H7qMLfjzj9Wp0adKWvTT28AoZEEJKt0efB7fhpF5lxgZ
	1XaARp6dliLRwVID2wPDWT2dFOZcoEA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <1d67eff0-c0f4-4b9b-8fea-1b48eecb54e5@tuxedocomputers.com>
Date: Wed, 20 Dec 2023 16:38:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: SoC button array: add mapping for airplane mode
 button
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231215171718.80229-1-wse@tuxedocomputers.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20231215171718.80229-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 15.12.23 um 18:17 schrieb Werner Sembach:
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> This add a mapping for the airplane mode button on the TUXEDO Pulse Gen3.
>
> While it is physically a key it behaves more like a switch, sending a key
> down on first press and a key up on 2nd press. Therefor the switch event is
> used here. Besides this behaviour it uses the HID usage-id 0xc6 (Wireless
> Radio Button) and not 0xc8 (Wireless Radio Slider Switch), but since
> neither 0xc6 nor 0xc8 are currently implemented at all in soc_button_array
> this not to standard behaviour is not put behind a quirk for the moment.
>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Cc: stable@vger.kernel.org

> ---
>   drivers/input/misc/soc_button_array.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 08bcee3d6bcca..f6d060377d189 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -299,6 +299,11 @@ static int soc_button_parse_btn_desc(struct device *dev,
>   		info->name = "power";
>   		info->event_code = KEY_POWER;
>   		info->wakeup = true;
> +	} else if (upage == 0x01 && usage == 0xc6) {
> +		info->name = "airplane mode switch";
> +		info->event_type = EV_SW;
> +		info->event_code = SW_RFKILL_ALL;
> +		info->active_low = false;
>   	} else if (upage == 0x01 && usage == 0xca) {
>   		info->name = "rotation lock switch";
>   		info->event_type = EV_SW;

