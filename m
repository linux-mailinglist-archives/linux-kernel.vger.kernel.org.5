Return-Path: <linux-kernel+bounces-129917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA78971FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889E91C26015
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA113149003;
	Wed,  3 Apr 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I97Yk/EA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0D148FE4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153425; cv=none; b=h1eW20u8LSIb2kS8YEoP2pzIeJ2WI+UmjnePEzKEbusjBgq03FN4m2DajnUbF1vRIPPb0XFokKVAFgdrrfWbzaRA/RWwu2SDPMMlvL3sgsojzhY0EtWE67krUeWZSBNsovp8prniOu+TfEQY96a0KxAHk3V+/MotC778Zqd5Otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153425; c=relaxed/simple;
	bh=PoednBtoE1tvUhRclYnddbxZ7od4p002R25b+VPNj7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsdvLV3jUlm9GeGeO+629QF4pmjNGcSaLMN3KpgdmkuFjlEbDr8HbulrwthYteNmjIbTeuUN+Bwbiu1MYu2gdiyWLUd+/RJIzlli5mYEigfMsJOXmpShnJTWFJtbm5tolvEJg0RB1+EObhNuqE+a2VXPlxfLPjKKxPTuoFFgag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I97Yk/EA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0+cDn0/ggKHKobWqWXUXd6pCIGaHqIXCgKr68nR+EE=;
	b=I97Yk/EAxf2i8ZmufK+8zCbCgH9qrFjpGsBoA9UeyfEPEO++NXzLnm6QeQaADLFRLaQvO/
	Ut4qcVSlqjSys0K7PnulqNVuWwjDtBFrdhnVbclY7hV2NaSrlKKrSWJRWemFx93TkZ85hq
	y40Cy+vb881uuClX2Yro7a5JC+VeSBI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-sE0c_jd3PuKmoHIVBedDwQ-1; Wed, 03 Apr 2024 10:10:21 -0400
X-MC-Unique: sE0c_jd3PuKmoHIVBedDwQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56dc267c77dso2506396a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153420; x=1712758220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0+cDn0/ggKHKobWqWXUXd6pCIGaHqIXCgKr68nR+EE=;
        b=aZEQkpOgOclx5hjBTrrEQLKuJKyjQiaOf2ZLCEF8GJF+kI0TYHRfHGn+f6vtV9eYnE
         srlormzZZ+aztD121DMLFuqgZQ6jpin0exiZB5TB+ebOHIiepkdGEdsjnG/vvs9LNBRP
         guEZa8ZjWbO3P1jUKHOq9o1kgtmaLzDplaE9jFfAWJ/dbv8eoTOl1JU6VZ/f11sU/bE0
         eD/eZbkGOnmdfD3W/B52rYmeUXfS04TOWAXukh7eK8i60KADHm0tSqz41XkBv4GsDSYa
         G2dK1lueUJByPMh7wAeHo8e3I6s8XGVql1MTBHzSdnx3y+OFOpRgHVpZY9uaYa6feka+
         u28Q==
X-Gm-Message-State: AOJu0YxH8l/xm26MYUY+ddC6n/2lUmR9j16RIbXjIxthL/KGG7DHuwoJ
	cyvVPZk2hBYBSihA91GkmyQ3z/Qp1mErJpnPSJKxXOT1GZE3kpzjzJSHFa6DBMhz2ZNlgPojgwe
	hz4gp1x/hfayKB2txzpWUmViKczZiSryLnD3xzQrDw7/Zm61wtz83rMVi8mGX+6PiJMNDjw==
X-Received: by 2002:a50:a446:0:b0:568:d55c:1bb3 with SMTP id v6-20020a50a446000000b00568d55c1bb3mr11923373edb.31.1712153420153;
        Wed, 03 Apr 2024 07:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhi00Gg7n9Ts7IAvb+tYatzzV6iMMMdxXDIzLOIHLjOh3ba8rP3luYiF+Q/5TjPb4RqxFo8w==
X-Received: by 2002:a50:a446:0:b0:568:d55c:1bb3 with SMTP id v6-20020a50a446000000b00568d55c1bb3mr11923354edb.31.1712153419787;
        Wed, 03 Apr 2024 07:10:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm948334edb.3.2024.04.03.07.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:10:19 -0700 (PDT)
Message-ID: <95be6ebf-9f45-404c-a643-89dd6ee4efdf@redhat.com>
Date: Wed, 3 Apr 2024 16:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx()
 fails
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/23 11:49 AM, Christophe JAILLET wrote:
> If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
> still 0.
> So, in the error handling path, we will call ida_simple_remove(..., 0)
> which is not allocated yet.
> 
> In order to prevent a spurious "ida_free called for id=0 which is not
> allocated." message, tweak the error handling path and add a new label.
> 
> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, both patches in this series look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have added both patches to my local vboxsf branch now and I'll send
out a pull-request with this and a couple of other vboxsf fixes
soon.

Regards,

Hans





> ---
>  fs/vboxsf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1fb8f4df60cb..9848af78215b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!sbi->nls) {
>  			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
>  			err = -EINVAL;
> -			goto fail_free;
> +			goto fail_destroy_idr;
>  		}
>  	}
>  
> @@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
> +fail_destroy_idr:
>  	idr_destroy(&sbi->ino_idr);
>  	kfree(sbi);
>  	return err;


