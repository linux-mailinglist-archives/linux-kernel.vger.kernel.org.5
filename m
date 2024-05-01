Return-Path: <linux-kernel+bounces-165706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238208B8FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B6BB21DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10D161306;
	Wed,  1 May 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmhrKOGP"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983E37E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590934; cv=none; b=J8GHeswLwzyugLI0D73DHoYKeTp7l2zy+IKLsqz5/SeFtJNPzoq6Mb4WbWamcbCwnGHdnUkBR6KfyIAkUpi9KzCC1sB6Lt6/NYXnEB/ho1aHR93d/ZrT4u+miEf9Xe53MqKo6LgG2/ZSS7wf7/K9nFNfcZhY2eqOJeG8P6Xaodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590934; c=relaxed/simple;
	bh=FjDFufbsvnrKVpq/d3f57SbbkDccuVf6Mo7zLPWNI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXAatIXNGwFEJ7rQKS2EPmB8BuJ4kKjsr2lAYE58VY1cUu9jxRy6e1+wsaMsCLsHwdaKxSlItRhVVgPIbV5O0PC/muAiWEbp0zYPTtoINPcKaR1MZcMv6Dl8nG+09JpDI87AcSGau7gVi5lcHqSVhvkKdXSZxXNJxo9z8YvwaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmhrKOGP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so7121095b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590932; x=1715195732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=JmhrKOGPNOqzHr8k2ATuVWV9FcWJ5q0nf6hFu8OGHjzWNdlwoQZs60KS6TQCNuqRw3
         iNooqKTSGhjXNpn+4/uw5iJgXQe6vOLFZXXxa9eZHKE/FB6B2PCYJ/tlvS+mnB0mGtV2
         ca2z7FQT16EvzATAzO0PKBAfY6PFOlohuX2D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590932; x=1715195732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=e/U4Fgx904oABXFXVPjkGZRa2iqebwfxVNfivjDmvKbhrnXN9AesVAg3N6UzcoPu52
         kp06DF/PyIb6dwWTXwjxVQ/42EIX0/5ZWYDcMnEx/nCeKBvuK+2m/GAI2gD0ljanA/7X
         CjZlf7vN3sDv+JXe/+vETU0nDha6yqVG4/lYWTtQxvrOoix3Hqi9oqBsdiKiLw8Uai17
         RsjZ/+KBDOdOtAHyR9SKLsrAEasgM4z6CsOI0O8796Ac3yydyBn6SyEZmN4pxA5O73yk
         zrka1YXP87kZ9tA3d1i7TR68MM3ykS8vXI3dqXy1hM/rQ5BSMdKgHf7LtxlnKCZa2IXV
         +43Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpAGAzmPt3/XVFsobD3kFeM7o6/l/qZ1Q03xX5EecIwtvaxw956j/WmNbl0X0yYAEwHohrrkVwUIvIpHJZvakJL4Ea+I/CR4uGsnJJ
X-Gm-Message-State: AOJu0Yz6vxWP9hEmbFcyE4ToE/z87+1jidslll3OkmqkJUJpGKyxABtA
	6MyuyBEnlAVp8grxuHLocEqZa6TPLv3eGFzmOfOyoQqaBdWSAlkwa1sIyuwSxQ==
X-Google-Smtp-Source: AGHT+IEha+gO+FpGkm9o8MQRL+GDzeOY8CJgsWHInozyoylrwPFagTvr8PCPZBBqlxdqKOVB+3C9lA==
X-Received: by 2002:a05:6a21:606:b0:1a9:c80a:bdcf with SMTP id ll6-20020a056a21060600b001a9c80abdcfmr3454424pzb.2.1714590932324;
        Wed, 01 May 2024 12:15:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b006eac2a25631sm22896185pfm.129.2024.05.01.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:15:31 -0700 (PDT)
Date: Wed, 1 May 2024 12:15:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_sync: Use cmd->num_cis instead of
 magic number
Message-ID: <202405011214.EB46DAB416@keescook>
References: <ZjKAyg2bZNyTcT+C@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKAyg2bZNyTcT+C@neat>

On Wed, May 01, 2024 at 11:50:02AM -0600, Gustavo A. R. Silva wrote:
> At the moment of the check, `cmd->num_cis` holds the value of 0x1f,
> which is the max number of elements in the `cmd->cis[]` array at
> declaration, which is 0x1f.
> 
> So, avoid using 0x1f directly, and instead use `cmd->num_cis`. Similarly
> to this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZivaHUQyDDK9fXEk@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 6e15594d3565..af9513f3c451 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6559,7 +6559,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
>  		cis->cis_handle = cpu_to_le16(conn->handle);
>  		aux_num_cis++;
>  
> -		if (aux_num_cis >= 0x1f)
> +		if (aux_num_cis >= cmd->num_cis)
>  			break;
>  	}
>  	cmd->num_cis = aux_num_cis;

Yeah, good idea. No need to repeat a hard-coded value.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

