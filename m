Return-Path: <linux-kernel+bounces-83891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BC869FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472AA1C28455
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83D14EFFD;
	Tue, 27 Feb 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="c6AEBXaP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8358149E0B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060571; cv=none; b=STWTW2vI08JxjDReMh+h9VWj9m8dtpsLCukH8Rh73dkPHGkOMlhUf8USO53RMZOCJHnlthDfjMQUC2SxFzfd8gRJll8oYR6AnS6xnIl6z4TozISBDc0E2Q9fXifGXQR9LSOc2y5Z9nw+tI8v1BStWFHNWW0oPgpoL5qHlszNT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060571; c=relaxed/simple;
	bh=62mCy06yom5/3xe32ZTRaQKwjk4T0LRNc3FRQaih5po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVHfIYX09DDc+zsnq2SpctjnJe1+BdMzAWFC8GGEOw/uiF4IlqOwI6G5eenieKXXh52KNiZ29z5iagCqhOIqmEFcdrlfysQnW4aS89MZhEV6It5g91gUL6REtIa4wUXBQNedG/rrJfNIhWgIbpBoDMWCOT8G/Q+DEnJkuMpd9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=c6AEBXaP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3190350a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709060567; x=1709665367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=c6AEBXaPEAx3oIdQRARt3PqijwVptPEpJw823O9AmYhc+2OZ1tNjZIufNVHyz3aAdb
         ia9kunaxxGSDTVaQJA8FFWBXHyX0RTQY1X/UulbGtEKc24LgW0Jh8cFkwQFMlA3aWvbr
         GZUlQ/6yiYmBY+9zPgOFehc4OC6sfqaG00NGVNj6vMtafLAJ4w0/2xLDE28CB6xLOcmv
         dbh5Bq2slgR3B+oja8CslcB9G9pjD8GeLZCZJ/zr+AfRegQyvRcA8Za+5ag5htI7itTR
         Zi58gz1os8lXC0WoMs1w9Tyx1ySZI0H1OvB5fSRlppdH2Gy/sf0W5vgcwyYO17iWIblj
         dI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060567; x=1709665367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=s6eV2bxOdk7MzJBUFNN9JoKwl566M5VtXwEIirJIzpkkRFwBrl2T3CL6xLZ2SMNI69
         8P1C1r1h75Qohb9KRxf6lRZJjsq+ygh+DiB/e87R+otJ27Fc8exQzv0/0udMeFT/iNaB
         PKIGrN0enhspbvhM7QJwTv4cmkZJjs2oCpTy78WI2i/DDeNWW7Bx119LG+SpMWmlZ5dS
         5TavdU1FCJRhFEX2j7cMazIbSFCO/7TJ8NANnvqyDq20VzvsU5/My8rT9bssJ294nzqb
         VCfDpI28iaV4aTmECga1dPRreKaRB/Lh6i+d0AcpQw7sEz+HWT6ZiBbsEm6R+0j0NkYE
         9aNA==
X-Forwarded-Encrypted: i=1; AJvYcCUjuIj7gMWLW81PF2Y8WMRu2AHxZMdMsG0q6MFcKbXrbuhKLiTMCE2u2jYI8rvx+SZ0iJEd5QF/CI64rpCXDhgEYSGiq9Qqr6qIHBmJ
X-Gm-Message-State: AOJu0YyBKioZVhJxTM0pAfjvdRYGXw7rCwyFKgV4mH6HLSH3ZJ2aNG1x
	HDoWBXgmVAjLN3D1w1jKjhdddfMVVMZfEoU9mrtUgmGvp4ZNWhYkaWjjmDfN4MQ=
X-Google-Smtp-Source: AGHT+IHwlaf1WNIWALYUt7NSPAriGIGVbEfipxAgr6lBGWMwiTlps9KdmMszSlFOlV6rNFwC7vlCdg==
X-Received: by 2002:a17:906:3488:b0:a43:ccd:a816 with SMTP id g8-20020a170906348800b00a430ccda816mr6234481ejb.31.1709060567415;
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a43e6c2e107sm91703ejc.189.2024.02.27.11.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Message-ID: <f8a78ffd-3504-4cad-bbcf-553186f228f0@blackwall.org>
Date: Tue, 27 Feb 2024 21:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bridge: Exit if multicast_init_stats
 fails
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20240227182338.2739884-1-leitao@debian.org>
 <20240227182338.2739884-2-leitao@debian.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227182338.2739884-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 20:23, Breno Leitao wrote:
> If br_multicast_init_stats() fails, there is no need to set lockdep
> classes. Just return from the error path.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/bridge/br_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 4f636f7b0555..c366ccc8b3db 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -135,10 +135,11 @@ static int br_dev_init(struct net_device *dev)
>   		br_vlan_flush(br);
>   		br_mdb_hash_fini(br);
>   		br_fdb_hash_fini(br);
> +		return err;
>   	}
>   
>   	netdev_lockdep_set_classes(dev);
> -	return err;
> +	return 0;
>   }
>   
>   static void br_dev_uninit(struct net_device *dev)

Please send them as separate patches next time. These are not related 
and shouldn't be a part of a set.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

