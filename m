Return-Path: <linux-kernel+bounces-98159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AC8775D2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41D51F22AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3118EC0;
	Sun, 10 Mar 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYwFKngk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C223D2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710059932; cv=none; b=s0LVipye9A/jKht6nxLq60Q/I+uBSa6mGpk9YWmNE8Uw0VIJ4D2NBdFwbMdTMR0YOKrWfkMzz+g2b+iK/MLyk7Ea/TYRwz0UqDMQqAPTDgl4hKIK5JatwCWwoNe4DOOGVUTeucW9VSZWpLpB3U4G+Yl6QdO9SlOpFoGY4UBKhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710059932; c=relaxed/simple;
	bh=Zye+GswJlWWVcR0Uial7FqwCOXrU+2aBIhMjZyA8Keo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX2/0xyDigrKRwRSmB0CKUEOLrVT+u+kgLkj7SMtRD+ODkz/DxgwjT0wuqQmTlvVxIhA+c6X2YLbYjISok/95YO9xuBA62qk1qzj4CHjsC+LmURGiccWaXC7HnL6lykkfompkIw+CrwJHxtkjR8gY5blOMgPcEUfHieAw+to4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYwFKngk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c4d0fa48so1827274a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 00:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710059929; x=1710664729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PXXyxSDfmkhd0+8Hv8Xrn1/0yeModrZzPQO+8IBMds=;
        b=aYwFKngk9lWZXzs4q4G/TWv3r9jthCysBG7m3S8M1r5l3KHYTc79lC+jUzUaJ3t6sS
         +7oKgomnJVEshx2EFEQFuFKpUgKxBUzvXIHBb9YOPpPz3U7n/0Vt2N5+eyJ5bpeXb5Sa
         hEZAIKIQCdRVknh59SvRFHAkQz+slkDC4qec4PjY1oV+p/T0Y8l3Awsc8EgyQJNV7ebb
         pmCaQMzNNEQL0+bANFKfnp79Q7w3wNFMmRda9BrBSz03EpylPSe3jC3v0r8+H88owW6S
         23XSPMCd5g/V+lIE1GwU3Qrmw+GV4n18WPZc1V/W1oUY0N5h2ZwFxmOOmiraKqXHG5QA
         ulGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710059929; x=1710664729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PXXyxSDfmkhd0+8Hv8Xrn1/0yeModrZzPQO+8IBMds=;
        b=Cmvy6Qd90e6tymb/F1d9AghnikI4cWltfOCOJ8b9w0vkmXXJ8vUrf/cnfGDTWxPKLM
         rdhhlfKaCMH5RWVhXVzbswHPDlG6yVUJJJ3pdLzbxfnxq6NocKig1h9W+rPT5LlsbVRz
         U8IGBu6tXJIpfHhRVu1OhcfSeMyWhc8h2rhit9k1BbcxqQLLNA68kftdkjnjbLZiYu/r
         Em9+0+bgmgWUIhFPqc1C27oRKKdT43TQgWPqM2djtsyoUxjithVLOWYkr98i7zECRpur
         Ec2ctTr6W7cJQjtCPwiHokeGqM/BLJ8qPWV1i88EO6BgSWRDHZ2/RPKwHwdeKbBwCxUq
         rl5A==
X-Forwarded-Encrypted: i=1; AJvYcCVaxPjJQvclnDDWRfWtQWiVWttu9usT6hX6PH3izfwuEThR58oZuT0OsavkURX0Y0RSaWNxiYznEsecLx6hvsPso7b3ULSsUd2EIga5
X-Gm-Message-State: AOJu0Yxrfv/CwKNITgzMeNL46B+aIa+CUL0ao017Wksn5pPTRz+u4DJq
	GufEgxzIVuWq7J+mPF6+CZWTflzGNSatdc9NOzMCAsOB6eO+qBWI
X-Google-Smtp-Source: AGHT+IFGsp7r61eDz65QNX/YqPLjtuDnboVeG1EzevcLye8ICPPhUJOhxAcvFuutwRtUXip+R+R7CQ==
X-Received: by 2002:a05:6402:e89:b0:567:156e:7893 with SMTP id h9-20020a0564020e8900b00567156e7893mr2514618eda.4.1710059928860;
        Sun, 10 Mar 2024 00:38:48 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7d659000000b005645961ad39sm1761102edr.47.2024.03.10.00.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 00:38:48 -0800 (PST)
Message-ID: <7b52b937-787a-45eb-a8ba-e96f4aad006a@gmail.com>
Date: Sun, 10 Mar 2024 09:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Staging: rtl8192e: Declare variable with static
Content-Language: en-US
To: Ariel Silver <arielsilver77@gmail.com>, gregkh@linuxfoundation.org,
 yogi.kernel@gmail.com, straube.linux@gmail.com, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.de, linux-kernel@vger.kernel.org
References: <20240309174722.3463-1-arielsilver77@gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240309174722.3463-1-arielsilver77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 18:47, Ariel Silver wrote:
> Fixed sparse warning:
> "'dm_rx_path_sel_table' was not declared. Should it be static?"
> As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.
> 
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
> ---
> V2 -> V3: add patch version number and changelog
> V1 -> V2: fix checkpatch.pl warnings
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 330dafd62656..5b52bc992a61 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
>   /*------------------------Define global variable-----------------------------*/
>   struct dig_t dm_digtable;
>   
> -struct drx_path_sel dm_rx_path_sel_table;
> +static struct drx_path_sel dm_rx_path_sel_table;
>   /*------------------------Define global variable-----------------------------*/
>   
>   


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

