Return-Path: <linux-kernel+bounces-133300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9689A1F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D951C23A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DDB16FF5A;
	Fri,  5 Apr 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy0rCCCv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84616F919
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332415; cv=none; b=lyab8O/YquCYSazxAZ8Ftt+c3vHsqYtxf7rztyxDe9dQqh6fsNugZmBXhj605f/NRzEBXslatQfEK4gN1LZ8wXpgtuGIYH9NRRe27kT0tYUJRexCy40caSr5e40nbrEaKjaqLdzr2oXtzenxMZlY5TQrMf9icSWQ4qXFaZLJW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332415; c=relaxed/simple;
	bh=Iei/2ssZLrKn2nm3sbBfFc+ThN4tjUj62NIgvrziHig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjdN0N0Y7ub28uQ9TGGBjPd5DAGqEBU1aXtWhnWWyKwQmJUvar05CiysguSspSMGJ1Ctzk4I09040w3CEcOssqjVj0EohrCWXfWUYyhs5d3sKk/keOKEg/PL3ILxsKCFVFcrNW+dIUmpoKqVtQCmhEqEedBeLZ7iRbUfeC8Xg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy0rCCCv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712332412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI80OQSSTp75Yz5rWxOaRLVcBrwx8DfV0TdIcg8SDyg=;
	b=Wy0rCCCvFvl3t/RmBr2ksjv9jAprigjRV+75jbm/u1/dciDxE4p1HXQuRr+/u8wVvgoR/L
	u5I1h8xukOZx1H5Gw11a+B6dCTape5tKTPRipGDFyHEuFSUy2s/1e+e7vlkzURqI5gsm2r
	V9aXnlGYHCHSV6RjN7xard8IJbEiCtY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Sgp_AjeTOLKT1tarl_vI2Q-1; Fri, 05 Apr 2024 11:53:30 -0400
X-MC-Unique: Sgp_AjeTOLKT1tarl_vI2Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-414908c5403so11244985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332409; x=1712937209;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI80OQSSTp75Yz5rWxOaRLVcBrwx8DfV0TdIcg8SDyg=;
        b=ND9Cy2lE+pJF6/d/vbF+iCcQOUwsPyZazeULVlRF2c2EQQfJC7bGjO0UKFl2wmGg9E
         Rd6WbN2jzcef9XtQ7tiJVR5+J//qr0o140i5NzboXZDkk+0jP8toSVkg8Q/VxFVx9JZ0
         r+1pE7HWZZw1apveY9vYaQsYvuGeXFGsM7+wQruTUAqAdsMmsHC+0SuZPzL5almUUJ34
         4CB65VpuG1VOqe+BE5TR8G/MuOjr3KlmuClcuZCSyCF9dPZf25nv8ZPfviNwyQ2hMgvr
         bgKtZYHcQM/kLXofa2oInYucD3lbA8X9e009dFG5gDxNkjYdG7uWnK2m3f6DPzTcmEBj
         GcNw==
X-Forwarded-Encrypted: i=1; AJvYcCU1C074Yr82ccaaUPtlg4SlGDiPq0KU2pMq6V15UG94ROO0LZtJZ+t+Bok55h3ne14+QHXGsUahV6vDR2vXYKxwLzGYp/JBJvojpbA+
X-Gm-Message-State: AOJu0Yy9HZ0aYEXT0kQa7GzRXXmhxX3NnPhpGbObqzMB+MnozTBlx4pH
	MgE0di97B5+3m02qHzjSKER828zmu09V1aOP8LoaHM/rcWq0e6H8RPCzb0E7j23exQSM1LtQekn
	Vtkh/MkbYunJ1T7QOQS+lLrV6NIQSLHW4BV01l/V53QqcTRG67q9SI51M159MZQ==
X-Received: by 2002:a05:600c:5494:b0:416:29e1:48ab with SMTP id iv20-20020a05600c549400b0041629e148abmr1383264wmb.29.1712332409496;
        Fri, 05 Apr 2024 08:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWYKp3MvuNtM1C4UI8yZRQC9e7WA0mMptREYTTgtMTckNkCjjIeh8XWt2OzPDA7mSt68JtQQ==
X-Received: by 2002:a05:600c:5494:b0:416:29e1:48ab with SMTP id iv20-20020a05600c549400b0041629e148abmr1383245wmb.29.1712332409119;
        Fri, 05 Apr 2024 08:53:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00416326cc353sm1340950wmq.8.2024.04.05.08.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 08:53:28 -0700 (PDT)
Message-ID: <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
Date: Fri, 5 Apr 2024 17:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: nv04: Add check to avoid out of bounds access
To: Mikhail Kobuk <m.kobuk@ispras.ru>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20240331064552.6112-1-m.kobuk@ispras.ru>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240331064552.6112-1-m.kobuk@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/24 08:45, Mikhail Kobuk wrote:
> Output Resource (dcb->or) value is not guaranteed to be non-zero (i.e.
> in drivers/gpu/drm/nouveau/nouveau_bios.c, in 'fabricate_dcb_encoder_table()'
> 'dcb->or' is assigned value '0' in call to 'fabricate_dcb_output()').

I don't really know much about the semantics of this code.

Looking at fabricate_dcb_output() though I wonder if the intention was to assign
BIT(or) to entry->or.

@Lyude, can you help here?

Otherwise, for parsing the DCB entries, it seems that the bound checks are
happening in olddcb_outp_foreach() [1].

[1] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_bios.c#L1331

> 
> Add check to validate 'dcb->or' before it's used.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for iMac G4")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> ---
>   drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c b/drivers/gpu/drm/nouveau/dispnv04/dac.c
> index d6b8e0cce2ac..0c8d4fc95ff3 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
> @@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder *encoder, bool enable)
>   	struct drm_device *dev = encoder->dev;
>   	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>   
> -	if (nv_gf4_disp_arch(dev)) {
> +	if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
>   		uint32_t *dac_users = &nv04_display(dev)->dac_users[ffs(dcb->or) - 1];
>   		int dacclk_off = NV_PRAMDAC_DACCLK + nv04_dac_output_offset(encoder);
>   		uint32_t dacclk = NVReadRAMDAC(dev, 0, dacclk_off);
> @@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder *encoder)
>   	struct drm_device *dev = encoder->dev;
>   	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
>   
> -	return nv_gf4_disp_arch(encoder->dev) &&
> +	return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
>   		(nv04_display(dev)->dac_users[ffs(dcb->or) - 1] & ~(1 << dcb->index));
>   }
>   


