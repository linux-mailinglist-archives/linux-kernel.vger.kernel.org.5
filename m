Return-Path: <linux-kernel+bounces-82010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0801867DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32CA1C297B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E813F006;
	Mon, 26 Feb 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqEW7hdk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43713EFEC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966760; cv=none; b=rGxZnXitIB5r4JPdF2IPGc1hqbAPC9wbV5ByF29tEpebLY/wTUK7NbYh5a+++eiVsy88vyDnf4dlsNC8OEkgl8F9l+nyAwRVZqCQMAEz8qljscldRlZRpl3Cz2hanwRXM238A8waw+28dpDORx8/jKJ4sWLL9wdCrH+ikqBZZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966760; c=relaxed/simple;
	bh=Er5kYmOwbzt4vnhThP5tnUWt8owS9wSl1gKtGt0Oo4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifJ+rOu56KENjB+KmHS24eBZ8PCviHDav2dnT823sVYxJUBn9XnI6gr0J4Mq4SoHODpTJSTID61ZKI1TuwiiMFfZQnDD6h9XDEv197PdNbR2R+TNPQ71bK1MccMuTlUPXT7arfXHLlACw5wDPfKX3c8moOUgRkro3mdgZ1SXEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqEW7hdk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d90b322b0so863560f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708966757; x=1709571557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eptKKzttKp+WY9FQ4xCv+8P8GHnHxpcwbYYbruZKAew=;
        b=MqEW7hdkm8jgabZ31Ov0sQndiypvCO2eR+GEEhFEsNe9/cEAbGLKcQVU8wvuQ3QPxS
         22S/0t8IDHR4OGqn0DYcfBUDvl+jR9LNr1XsWvVPKIg8Ip9HV0/mN+zFYHeg8MB5kAGd
         iQ6dJhJqwhltpU8q+KNncCl/WBbcHktCxhniAExoNaLBv0lte02XRg5Rffn3LUb9ub2Z
         7Fpl0uIsfEVhXzVM0pyamRJyge8cf066ZOSyMprCMBku0Oe34IWMODwq/QcJWYmos2VP
         PsznyQm60wWABrMevIfuknTbbmwy8DUwS0qrqzHh+/R+iqgG+j9aRs1QCBOtNf9eq/wE
         UskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966757; x=1709571557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eptKKzttKp+WY9FQ4xCv+8P8GHnHxpcwbYYbruZKAew=;
        b=jlySjCjIc7MKMLJcqmOjcEBeMBABIh3OotF94GEO9KBGiziB6oacfPkR31dPzuYmkT
         ZbU301OY7QmaowdTVuqcsE7soXcSt9weIQRVovt4lZxM9VDf3mT70gxPmegY2indunYs
         dL9yg8eaJ/or3DRCJvPOHBAtbM3kidNzrj3XZa5pWTAzYf+HIQA3dRPhLf/HaRF6meB7
         073N/q6IZcKiTi/iRLc7FSi9juZcjfaxFrIRZIiHIoHGpVC12gCgwl7RqdYeR4oQl0Gg
         Cjx6fDxwFOtNTWcP/Ak3xsAc1d9NiAEcd1kSKJH/a5ZBeW8DIJv2XA3+82qloSJ19afS
         ld1g==
X-Forwarded-Encrypted: i=1; AJvYcCUk9KleduPKUKqV1HCsdT7MF7WnfpGP6rd71H3xbwSy3t32E44rmnm5/BHYsoITYDifz7ECr+wIvpoyrSL+MHahf0B7Wkx7wBmSD/GR
X-Gm-Message-State: AOJu0YwBZGZK5zeJTkcxltQSPTxjkznZMBxvDbeTUS1T/s7d4OoX9Rdd
	pv5/NxtLy+m8knlUnxhBep4R6eOEYrQO1lMHW47+Rn4Wz5GZesq0
X-Google-Smtp-Source: AGHT+IHxRmyFfLI5Nxsic5nNOcezskF5ApgJeljJNXcoAx4s/4UwsRLvaSZxfN1YaExD612ZVRPu+Q==
X-Received: by 2002:a05:6000:1e09:b0:33c:fa05:68b with SMTP id bj9-20020a0560001e0900b0033cfa05068bmr5217307wrb.0.1708966756773;
        Mon, 26 Feb 2024 08:59:16 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id by15-20020a056000098f00b0033da933b250sm8942363wrb.5.2024.02.26.08.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:59:16 -0800 (PST)
Message-ID: <236c7275-c8db-4ed8-9568-dd21c5834fc9@gmail.com>
Date: Mon, 26 Feb 2024 17:59:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] Staging: rtl8192e: Rename function
 rtllib_rx_ADDBAReq()
Content-Language: en-US
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240226035624.370443-1-tdavies@darkphysics.net>
 <20240226035624.370443-2-tdavies@darkphysics.net>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240226035624.370443-2-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 04:56, Tree Davies wrote:
> Rename function rtllib_rx_ADDBAReq to rtllib_rx_add_ba_req to fix checkpatch
> warning Avoid CamelCase.
> 
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#7:
Rename function rtllib_rx_ADDBAReq to rtllib_rx_add_ba_req to fix checkpatch
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index da7319c124e7..bd1d86e0323d 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -211,7 +211,7 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
>   		netdev_dbg(ieee->dev, "Failed to generate DELBA packet.\n");
>   }
>   
> -int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
> +int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
>   {
>   	struct ieee80211_hdr_3addr *req = NULL;
>   	u16 rc = 0;
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 348644998744..95a8e9416f61 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1771,7 +1771,7 @@ u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
>   void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
>   bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
>   u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
> -int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
> +int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
>   void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 2545ac8963c4..f12ee685e989 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -1551,7 +1551,7 @@ static void rtllib_process_action(struct rtllib_device *ieee,
>   	case ACT_CAT_BA:
>   		switch (*act) {
>   		case ACT_ADDBAREQ:
> -			rtllib_rx_ADDBAReq(ieee, skb);
> +			rtllib_rx_add_ba_req(ieee, skb);
>   			break;
>   		case ACT_ADDBARSP:
>   			rtllib_rx_add_ba_rsp(ieee, skb);


