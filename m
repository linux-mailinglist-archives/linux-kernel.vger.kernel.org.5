Return-Path: <linux-kernel+bounces-7152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7449181A254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79ED1C20AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03179482F6;
	Wed, 20 Dec 2023 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="uoYpqJL8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334148782;
	Wed, 20 Dec 2023 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id DB9A02FC005B;
	Wed, 20 Dec 2023 16:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1703085796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEipMX9+RGlNqeYObAaMXD2YSbazIyFF/g9TIoQ9xgk=;
	b=uoYpqJL8QO9uj31jBnDN/1X231o2GaoVOYIAbukLKqLkp3LtfCfK7LdpMQe2xP6CU8Ylsa
	urXyAJ9MyaZH6DrQWo5Twoh4vUU84ts87/ucgg0iv1y4A8FAlt5numOLIbFJND/qi2CNOe
	Osrw42rk4C2z4a7pqU9d+hMYZBC6ml0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
Date: Wed, 20 Dec 2023 16:23:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
To: Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20231220150956.230227-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.12.23 um 16:09 schrieb Werner Sembach:
> This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
> systems with Intel Maple Ridge".
>
> It seems like the timeout can be reduced to 250ms. This reduces the overall
> delay caused by the retires to ~1s. This is about the time other things
> being initialized in parallel need anyway*, so like this the effective boot
> time is no longer compromised.
>
> *I only had a single device available for my measurements: A Clevo X170KM-G
> desktop replacement notebook.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
I wonder if this could also land in stable? Or would it be to risky?
> ---
>   drivers/thunderbolt/icm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index d8b9c734abd36..56790d50f9e32 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -1020,7 +1020,7 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
>   
>   	memset(&reply, 0, sizeof(reply));
>   	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
> -			  1, 10, 2000);
> +			  1, 10, 250);
>   	if (ret)
>   		return ret;
>   

