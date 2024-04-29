Return-Path: <linux-kernel+bounces-162775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDC8B605A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E7D1F21DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E5128815;
	Mon, 29 Apr 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ov084Mox"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37296128396
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412723; cv=none; b=eztzwwwTvHq1VYmT53D0NV0iatkzfdDjX7nnHRkNUD/sNPqKrLJx/HF8iEv7Z2yZB5JgMZ2dng1t/4zYUXNnRgmFJogHHJYbodA3FgjxgvWk1gYQoA5ZiM4011PgJVIUVE24mMSNJe8sT10hFSkkZYxo5OLRP9MQQzASQG53P/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412723; c=relaxed/simple;
	bh=yC65xUsXdzGIMRm3JuMM7ViqdUqr5hPlZJ/3EznCieU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCRXsmRg+d0jBfT4zwV6MVJ6zNvcP4trroMyBggNcBKOq2IRfbE5ECeWpbuFfOxyHnBZjBxbhWqzjLaNDPiDAT0otDaUiXRK7Ql8+JaxE3lvX6bM4ptcUoi0ThC3mSZmb4S0NTNq8g0Hek9t+Hg97OWAIReC0ATNtUfxAqRDw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ov084Mox; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso2829751b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412721; x=1715017521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G4KfVVL57asc6jdAgtmGDhKAJMXo7zTUk6MT6QrGQs=;
        b=Ov084MoxZwzc68hma6vAnIR8uCO0cWqnShjwT6JUQeOskaP5u9lMmSKdobwGOfKmpk
         Z1fIXOGeRFbrIpiQPsBF/ue70oWxkCy6vS0jvX6pe2exKXlXX4Ps9KADHxR7IlOtkeui
         hXKLKj3VJZm3nwJYb67sGOlaK5iSmBXLe9+vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412721; x=1715017521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G4KfVVL57asc6jdAgtmGDhKAJMXo7zTUk6MT6QrGQs=;
        b=EshRBVnoW+5V5o51A0Qt7TyZGQxeXw8rrv2BqDu7JnxUXxSrgRybGmmlHdV2UJP5JQ
         NIkK0LGs7cz4kXxqI4EUExRZZW6Jn+DDLOZ9cQN1Hge8xi7dje2AQjxeg46ATqe55xsi
         U9rMebH/d3QWpr9Miy/nQuLpLiuMpj6LC58sb8pq9SDh9xYKgRygsEVM05svOadI39vt
         9l6L5mJ7bPZMvU49LEO+XNk6pnNPJpX6sz8or993J9Ar3+HIhD6swbygcx/1MobYY+mc
         JDugezfzLIuDHmg7SBixMD4H7gIPQC1TxgEsnEKHUhJT0acjuy3s5EzO69GnEAy2qNsQ
         tttw==
X-Forwarded-Encrypted: i=1; AJvYcCWsHGzDBMDlOCJR8u6jKi45K5YMZtPG6h5ffJKl1rvBYa2aNw4EpmkMVelCq6VQVta9OIG3gxfSY0SnCYPacNt6ofAzLr3ET6pTR+uK
X-Gm-Message-State: AOJu0YxJJYuTKyWZ6vRiCx2Rp27Jo/crfcBiX/zo92TQQe2fa7I3vumh
	BEbyXVAm0lac9diJt1b8hrwNb2+yuWgsQTVrIfF4+yDWQIQrXCvFdJoVzUZBKQ==
X-Google-Smtp-Source: AGHT+IFGc3/kOEV9/ewwKn9tq1l3GHLYlcfc71HQx0P4bfGndPtYd6mE9UF3L0lkmhnYTfEDthuc1g==
X-Received: by 2002:a05:6a20:6a99:b0:1a5:bc5d:3c0a with SMTP id bi25-20020a056a206a9900b001a5bc5d3c0amr12084908pzb.61.1714412721543;
        Mon, 29 Apr 2024 10:45:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001e2bfd40b86sm21028740pla.47.2024.04.29.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:45:21 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:45:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sctp: prefer struct_size over open coded arithmetic
Message-ID: <202404291044.E9A6A13@keescook>
References: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>

On Sat, Apr 27, 2024 at 07:23:36PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "ids" variable is a pointer to "struct sctp_assoc_ids" and this
> structure ends in a flexible array:
> 
> struct sctp_assoc_ids {
        __u32           gaids_number_of_ids;
> 	sctp_assoc_t	gaids_assoc_id[];
> };

This could gain __counted_by:

diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
index b7d91d4cf0db..836173e73401 100644
--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -1007,7 +1007,7 @@ enum sctp_sstat_state {
  */
 struct sctp_assoc_ids {
 	__u32		gaids_number_of_ids;
-	sctp_assoc_t	gaids_assoc_id[];
+	sctp_assoc_t	gaids_assoc_id[] __counted_by(gaids_number_of_ids);
 };
 
 /*

> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + size * count" in
> the kmalloc() function.
> 
> Also, refactor the code adding the "ids_size" variable to avoid sizing
> twice.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  net/sctp/socket.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index e416b6d3d270..64196b1dce1d 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7119,6 +7119,7 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
>  	struct sctp_sock *sp = sctp_sk(sk);
>  	struct sctp_association *asoc;
>  	struct sctp_assoc_ids *ids;
> +	size_t ids_size;
>  	u32 num = 0;
>  
>  	if (sctp_style(sk, TCP))
> @@ -7131,11 +7132,11 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
>  		num++;
>  	}
>  
> -	if (len < sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num)
> +	ids_size = struct_size(ids, gaids_assoc_id, num);
> +	if (len < ids_size)
>  		return -EINVAL;
>  
> -	len = sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num;
> -
> +	len = ids_size;
>  	ids = kmalloc(len, GFP_USER | __GFP_NOWARN);
>  	if (unlikely(!ids))
>  		return -ENOMEM;

But yes, this looks fine to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

