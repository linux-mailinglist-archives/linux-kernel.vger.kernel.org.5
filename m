Return-Path: <linux-kernel+bounces-99472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B788788F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654A51F21664
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1A54FB7;
	Mon, 11 Mar 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap9LltHW"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414854F83
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185477; cv=none; b=fhKpTgFFf036QoEM6kieGY1etdcBFDKj0NJkfmQnEnhq01ofV/jMQ90+sWrMllbqbolryj6afVJm1giSGX7YdjFiu50InBnXGk43o1bj/r74E9sqX05XzXTUMyOSqFRKwtebX7rAn+rSZedimiDuUYpMV7gq5yQC2GCcsp6f9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185477; c=relaxed/simple;
	bh=AC1uPRCZj/8wnOJitSEIWUojwXPSwENw/WWJYgzkVrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZkd35ow0+jhkA8PCBLf+uxVV3ZVjxRe2KH1OgAvOM2ZxJBeGKJjxK/+eQ6V+uwb/uMe+pryCpnNyrKBTHlWAFnubBVVPEqQKsvU8NKux25AnxbxaBscxa6p+an78o93s/DEo6jyn2tKTVX5GN4hznWy3OXXt4rgGcSeiE0EtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap9LltHW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28cfca3c45so180068366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710185474; x=1710790274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGD/K7PbcPXhTYr2ynjthnXfGqD/UYdkpGpwMVFT2yE=;
        b=ap9LltHWFPKNPWQ8qOyhlCv0PVEUA7lkBtplFVtfaptrRRfohJLhwlIgu05UxBx9o4
         OEa6lw4vGgVO90ULAG1WotTu09p9igKLN33cgDqxG3a+c2ViZkZSlS62d+7TCf4oTvre
         WrsQHRnBMk2/148dtTR7fWAHdvu8rPRGeAhpGfBMF0ewnoEEPMaLD7bG7WO5l1oUxF9S
         Xl4uNL2D+/Dj5tQkehILuxZuLuXJYK2I4FC+JYgWAhShEnnoFNKVgyga/8LEi9RCZAxn
         OWRzIQVXpMAE5PsE6IVuHoVpAmSG6LySaS0xQHSCw9S4Vln+RBlvXNDom0WIcjUL9R4c
         zdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185474; x=1710790274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGD/K7PbcPXhTYr2ynjthnXfGqD/UYdkpGpwMVFT2yE=;
        b=tlvjxZ+J2oovSrST5SJjwW9N4DOwLR/lMlJyEuNw0eUZfnY7eW7U+98Vr4c3h1x7qq
         1gONx3k7tKM7vha9/pUde26hsZsqUa+LgZlzeB02FsRQlOKJV9SifC1JDbGTn9SlUiuN
         cV60JRsZM84f6LHvcTm5Aakl7VgwfjGWiT67awVA0WeC76PTgrE6SpBvJj0+pRmrO/nT
         YDyc5+3+K1nGMTMSqXGnsofeMxWQ8GPYcfy70d2xntVlmvo+lJb6eCxz62Dvf6F3Shdf
         R7m6mU6EBT8nQDZXTMExRDHfnl/Q/nU9dxN427aNw7hm6sIx1z6u9xZj/hfiLlDb1HX9
         LYTg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Xhw8GekCmImcCnk5k3RiNVgDgwnkb4CgCQh0TNW57qnhgslzxfYyJcstJmRNeDIp3Ra2GbizznybbXFwuYwNEtlK4JaSy/vPbw9e
X-Gm-Message-State: AOJu0YwNpPAFTHcxb5ixeAJ/aEuYRcyYH/4n50gUBHKSZN2gcYel/tdl
	luRUWuIdIYk7RVmQGUWIXXH+d9m1cCa3tuxttS3CMyaWsh8SuxDg
X-Google-Smtp-Source: AGHT+IFCp9YWXjL3GAKRj2gE9ehP0MXbh1gQhiEBhuAGk6m7UJhFvSbXcrXdc9w5PdZO+BaVqhGd/A==
X-Received: by 2002:a17:906:3087:b0:a45:da91:8d29 with SMTP id 7-20020a170906308700b00a45da918d29mr4784404ejv.2.1710185474164;
        Mon, 11 Mar 2024 12:31:14 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a44a859fd9dsm3188581ejb.174.2024.03.11.12.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 12:31:13 -0700 (PDT)
Message-ID: <6d643351-8924-4c86-9fb5-9951e016f5db@gmail.com>
Date: Mon, 11 Mar 2024 20:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
Content-Language: en-US
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
References: <Ze9Ie67PCSvBU+og@MOLeToid>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Ze9Ie67PCSvBU+og@MOLeToid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/24 19:07, Felix N. Kimbu wrote:
> This change renames the local variable foo to decrypt_check in functions
> skb_ether_to_p80211(...) and skb_p80211_to_ether(...), giving intuitive
> meaning to the identifier.
> 
> It also indents the parameters to match the the opening parentheses.
> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>

Hi Felix,

I think the subject names the subsystem "staging" and then the driver 
which is "wlan-ng" the file can follow but you cannot omit the driver 
name.


Please check the following checkpatch warnings:
File Nr: 0    Patch: ../../../Downloads/20240311-[PATCH] staging_ 
p80211conv_ Rename local foo to decrypt_check-15036.txt
WARNING: Possible repeated word: 'the'
#11:
It also indents the parameters to match the the opening parentheses.

ERROR: code indent should use tabs where possible
#41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
+^I^I^I^I  ^I^I^I^I^Iskb->len,$

WARNING: please, no space before tabs
#41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
+^I^I^I^I  ^I^I^I^I^Iskb->len,$

CHECK: Alignment should match open parenthesis
#41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
+		decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
+				  					skb->len,

WARNING: line length of 115 exceeds 100 columns
#42: FILE: drivers/staging/wlan-ng/p80211conv.c:190:
+									wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,

WARNING: line length of 105 exceeds 100 columns
#43: FILE: drivers/staging/wlan-ng/p80211conv.c:191:
+									p80211_wep->iv, p80211_wep->icv);

CHECK: Alignment should match open parenthesis
#72: FILE: drivers/staging/wlan-ng/p80211conv.c:309:
+		decrypt_check = wep_decrypt(wlandev, skb->data + payload_offset + 4,
+									payload_length - 8, -1,

total: 1 errors, 4 warnings, 2 checks, 58 lines checked

Thanks for your support.

Bye Philipp


> ---
>   drivers/staging/wlan-ng/p80211conv.c | 30 ++++++++++++++--------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
> index 8336435eccc2..a0413928a843 100644
> --- a/drivers/staging/wlan-ng/p80211conv.c
> +++ b/drivers/staging/wlan-ng/p80211conv.c
> @@ -93,7 +93,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>   	struct wlan_ethhdr e_hdr;
>   	struct wlan_llc *e_llc;
>   	struct wlan_snap *e_snap;
> -	int foo;
> +	int decrypt_check;
>   
>   	memcpy(&e_hdr, skb->data, sizeof(e_hdr));
>   
> @@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>   		p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
>   		if (!p80211_wep->data)
>   			return -ENOMEM;
> -		foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> -				  skb->len,
> -				  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> -				  p80211_wep->iv, p80211_wep->icv);
> -		if (foo) {
> +		decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> +				  					skb->len,
> +									wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> +									p80211_wep->iv, p80211_wep->icv);
> +		if (decrypt_check) {
>   			netdev_warn(wlandev->netdev,
>   				    "Host en-WEP failed, dropping frame (%d).\n",
> -				    foo);
> +				    decrypt_check);
>   			kfree(p80211_wep->data);
>   			return 2;
>   		}
> @@ -265,7 +265,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
>   	struct wlan_llc *e_llc;
>   	struct wlan_snap *e_snap;
>   
> -	int foo;
> +	int decrypt_check;
>   
>   	payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
>   	payload_offset = WLAN_HDR_A3_LEN;
> @@ -305,15 +305,15 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
>   				   "WEP frame too short (%u).\n", skb->len);
>   			return 1;
>   		}
> -		foo = wep_decrypt(wlandev, skb->data + payload_offset + 4,
> -				  payload_length - 8, -1,
> -				  skb->data + payload_offset,
> -				  skb->data + payload_offset +
> -				  payload_length - 4);
> -		if (foo) {
> +		decrypt_check = wep_decrypt(wlandev, skb->data + payload_offset + 4,
> +									payload_length - 8, -1,
> +									skb->data + payload_offset,
> +									skb->data + payload_offset +
> +									payload_length - 4);
> +		if (decrypt_check) {
>   			/* de-wep failed, drop skb. */
>   			netdev_dbg(netdev, "Host de-WEP failed, dropping frame (%d).\n",
> -				   foo);
> +				   decrypt_check);
>   			wlandev->rx.decrypt_err++;
>   			return 2;
>   		}


