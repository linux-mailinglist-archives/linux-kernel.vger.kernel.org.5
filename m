Return-Path: <linux-kernel+bounces-44535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2F84235F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3B1C240DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0067A0B;
	Tue, 30 Jan 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/G+KgZ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72D67727
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614867; cv=none; b=bTT1KzUsvjPHwpJJg1viynidC5fErWM/0IiDYmOxhijUTQiLEn388GUiepkZdRNR1tGOXgNj0aXqOjg8Y0U1VoTpCLw/asxMQkBcKzYbWClkoYgbIvb6Tvl28BSQYeu24InefWTP6Ed4ptLxnVh5t5qTRrPxIz6aNYQXBx93iXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614867; c=relaxed/simple;
	bh=M+/cvRTiNQlo7KPfcEVL7C2AvVbn8/Y9+Zbphu4uI/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRM3L3LiNUvNUEBaWHXXBhjutnymUW4M67Yt2UsgF8nMzWux0SiF1vg42ieTrmcy+6sVvM+opD+uQx+9s6hLQo/BCMlsvu84yUUo1hpqqDdM3Xqt/5khhEZ4gZ/MU0VhXopRHLWdx8MQXkt9AXksRSW7qesAEvETpClSK7xFh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/G+KgZ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706614864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qawN/sGbFjDIitx+OorbC+U5Qtbve2fOYXbwnffL1Dc=;
	b=S/G+KgZ0RfwnUf88Kn/DlBbDhou3gwmafdrkY+oNWPwGWhGqzxcC8zm85V79MjpXMm+fFt
	vvU51CpEgxyQkM5p4zGqO8iYZaf292m9N8+RqYyLqaQ2a+vDRN5iWUJS7N+qY+vay+GQD2
	Mhi8Wk1jT7nOTzh73wckIKWgrd9LNTg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-zpM27NtYNJyT0x6-09eQEw-1; Tue, 30 Jan 2024 06:41:03 -0500
X-MC-Unique: zpM27NtYNJyT0x6-09eQEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40ef88ff82aso3780035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614862; x=1707219662;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qawN/sGbFjDIitx+OorbC+U5Qtbve2fOYXbwnffL1Dc=;
        b=YruqEvJ+tfXDnR7Jq+oBuhjVsmU+s9El4YaFoyBBKEz4ubIXVYDRdAgrJROciVaP+k
         XXz5SjI1fVUoavGdRb/KufntDQXIw3toqxFnEVrLI52gnT48BDz8X5vj+us4KiaEJGpI
         0B4Pn2SmiPtdQmfQCEebLsC+cbcJFW9kX77AsrNrgMftnLbrocqE4P/PoofFSVFmvrXA
         zdN6Pn3wgnqN8/GqTfV57/BlxUmggAN89l2Whr2ixC8QaQeUp84nB2ARiM1CzarO5NdX
         ldtfZgL7w/pgK2rRtplEGiB9sP+EvfUhcD9z5xzqs1VhQ/9dSsuJk9EVr5qVr5kM/dwO
         pwPw==
X-Forwarded-Encrypted: i=0; AJvYcCUvI03Is4p71AL6K/wbWxbExTtHjCxt4Z6CkkEyv1dUsG5JUZv4yzzbzIhzAyys1wkmyjVBmEytn6HpGZdT2OwGLFQ9JyqTv0Ccxn3s
X-Gm-Message-State: AOJu0Yy4gB8gVFwDGOkv+/pRM6oLdN+pk63igh4XpY7auGHGYE1jiDJq
	vR/XXqWzKlSA6qMPEnlk5aqS5jKtvqx0Bs/pNjxH+TCM+zMImF5PjVIr2swdtihg7jjI7XEcstD
	flkHtECSii60rH92ybGXXLJ+vmJOuZNyylZ/dHauolTyUwqWXTVx2h8Z7Ha5MPQ==
X-Received: by 2002:adf:ab03:0:b0:33a:e9d3:5112 with SMTP id q3-20020adfab03000000b0033ae9d35112mr5449390wrc.6.1706614862076;
        Tue, 30 Jan 2024 03:41:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIIeJgGMfAM6ut6/WvxTeihLmkFSyfr9rChSanCUvXU3AmcWKRXEsMnL/zFfSJ3c70P75sjQ==
X-Received: by 2002:adf:ab03:0:b0:33a:e9d3:5112 with SMTP id q3-20020adfab03000000b0033ae9d35112mr5449369wrc.6.1706614861759;
        Tue, 30 Jan 2024 03:41:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id r15-20020adfda4f000000b00337d9a717bcsm10503807wrl.52.2024.01.30.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:41:01 -0800 (PST)
Message-ID: <efd5126fcfe840d9bb7d583c8c69a3c97cdb2285.camel@redhat.com>
Subject: Re: [PATCH net v2] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
From: Paolo Abeni <pabeni@redhat.com>
To: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto
 <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	xfr@outlook.com, rock.xu@nio.com
Date: Tue, 30 Jan 2024 12:40:59 +0100
In-Reply-To: <20240126073928.1070729-1-0x1207@gmail.com>
References: <20240126073928.1070729-1-0x1207@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 15:39 +0800, Furong Xu wrote:
> @@ -914,7 +964,12 @@ static int dwxgmac3_safety_feat_irq_status(struct ne=
t_device *ndev,
>  		ret |=3D !corr;
>  	}
> =20
> -	err =3D dma & (XGMAC_DEUIS | XGMAC_DECIS);
> +	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
> +	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
> +	 * Parity Errors here
> +	 */
> +	err =3D (dma & (XGMAC_DEUIS | XGMAC_DECIS)) ||
> +	      (dma & XGMAC_MCSIS);

The above syntax is IMHO confusing,=20

	err =3D (dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS))

should be more readable.

Cheers,

Paolo


