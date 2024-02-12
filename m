Return-Path: <linux-kernel+bounces-61880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE98517C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34430282A22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC33C473;
	Mon, 12 Feb 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCLE5xdC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87B3C06A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751063; cv=none; b=i5xLP2KaSOUVdZa2kFbRC3Zz3aAuOjOGJ3jafSgbZ0p/0IrewC5qx6sO3iCpZfiwlal8aOWrQDUD4FwLhkEu8ES/HCQVjxRferHzlSRfWr6/4j3Ug/q1qvFRBgOjxa0ltfNQOk6psKuwhx2uY0VaI28PYI5DVhbF+uYnskGKUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751063; c=relaxed/simple;
	bh=BWg6VtGUNMhGC/tP4bmNmvs37IMyIM/nH687l6YZ4xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXZvsMdfYdi1i+QinQy997POlQRhBKfT3dsz0DGbR958i3XPGruVAnWCaTU8h4Vw3n9Jrj5150AfDdErCRPfc99uOxLehr3d0Qi8XWO24YiUTdXCTPA3nHbcHfDjwTE7XlSEgiLu0TEpu2TdWjWO46L7nlehI75pnYwZpe3YoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCLE5xdC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0adANtr6IwbtjNWnYkh0vuaJaZzmH8KV1/mm2CL+0c=;
	b=bCLE5xdC/6wOleTqubI4WFHaz2zCdQzEcfAZWiRqik1q3LFa0z3qRh64TtpcXDNsNVj9GH
	Vw+WGYBw/oEoTHw79Ype1UxFJK2GxFp3YUCOFzMmsmpHf3YUWU1DUIWZNXmkdQ0ynXx0Qd
	KOPalMAfVskgX4vdbGK5GW0BCtLE1Pk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-iclO14xUPJih-GzJtHcBVQ-1; Mon, 12 Feb 2024 10:17:36 -0500
X-MC-Unique: iclO14xUPJih-GzJtHcBVQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3c2fc67d19so56176966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751055; x=1708355855;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0adANtr6IwbtjNWnYkh0vuaJaZzmH8KV1/mm2CL+0c=;
        b=wIRJvmputtzuC3I2SFl4nL8C+iYb39lqhtFk61c6uIMfXcwLOMrqiAJ0sn+D/pIwIJ
         6FFn2+vg+AdNsyT4QOMWiK/ggsci8guWI+aOGEluk0CQAFET1EtS/GcXLznEptaEJEwW
         V6hPVxFhKaNAyGrwjS9Wf8xVRaQXlMqr+LeMi0P5N2lFREUFhE80xQpdRAUv3nNl9fIe
         wpfD1Yma0V+su6K2dwOUTnexPVG9Mn28HqOvILmk6qX1kNtBLh+qMB1i6DzlVCPdk5m3
         1rfzudx/H6UY9LiAuqVwoxfFE3WYk0faL7reZrTR5ejwmfK1q/zhfxqiNppit5on+1vl
         SGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJIt2N88qfAJQCjgiew7RA4Will+bAOIecfMwKbrEy5KVWwwibsKs85gI9Q+34O9CzdHEdKwkDDx/V74DzzcDN16soR13nalFOCXLv
X-Gm-Message-State: AOJu0YzMYIna4foFmAcA3v7dd+XSDyfHhV0GpS4nIXw3PynSmywwypmG
	BC+JgAZq0d1hWrXqECIItr3gufqe8V/Dr6YmorSfD4Q3C/Wc7VN9L2mbeV6CgKB2JNL3FFKYAg6
	vd65m+HDHJVWrVqRnrUHdkAz1V86EEZnPYmOth+hoGhvp8bS6koYRGkpvsBsbrw==
X-Received: by 2002:a17:906:80d8:b0:a3c:d965:8c4c with SMTP id a24-20020a17090680d800b00a3cd9658c4cmr880618ejx.72.1707751055042;
        Mon, 12 Feb 2024 07:17:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP4kdKVvKtJmqRPWfvNqX7XdE6EB/6EBMSBRnR2ga+amR0tCNAgo0M/n/Zj3VSm25/5huN+w==
X-Received: by 2002:a17:906:80d8:b0:a3c:d965:8c4c with SMTP id a24-20020a17090680d800b00a3cd9658c4cmr880595ejx.72.1707751054739;
        Mon, 12 Feb 2024 07:17:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXENn7BUszgo98/LNDqPnwT881+rZTZ+ocxY2+ycJA9F2vtoTJWBqeZFiWh1lMSR6qUxUXf9Bqgxdd5YUKJ/Nnd9KVoYoBojQs3VeibaMCE1vkyFhwEdWP+69ii7hbqTpkoa/VV9dHxRGsjJV/mOzPGJjpMntd/UoFEjiQw85kdWawlAPKEfH3bu/SHX3XQvqrLQAOBR/FYCIy094dzYoVtvEQyJqA26SpnOtYA7s8/hOGj6+htlBLymi7Nu3lrWacX6HHF9nqQgGLP4I/TsJ/+q6NfTqsj9M5EUQ/zgmI7psVHzq82P8RvwTdrmrdiF1PCYBE8JXzaZfdfbqz98vichWL049v2VNWDitsPmzyOUZT+/nP7m9Ki/ZE6m3lstjP10CRm7/VNKtnZc3aSbWE=
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906139b00b00a3cabea1b51sm300289ejc.42.2024.02.12.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:17:34 -0800 (PST)
Message-ID: <bddbec20-356b-468d-9c34-98a50c4f78a0@redhat.com>
Date: Mon, 12 Feb 2024 16:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nouveau/svm: fix kvcalloc() argument order
To: Arnd Bergmann <arnd@kernel.org>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@redhat.com>,
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240212112230.1117284-1-arnd@kernel.org>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240212112230.1117284-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 12:22, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The conversion to kvcalloc() mixed up the object size and count
> arguments, causing a warning:
> 
> drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_svm_fault_buffer_ctor':
> drivers/gpu/drm/nouveau/nouveau_svm.c:1010:40: error: 'kvcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>   1010 |         buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
>        |                                        ^
> drivers/gpu/drm/nouveau/nouveau_svm.c:1010:40: note: earlier argument should specify number of elements, later size of each element
> 
> The behavior is still correct aside from the warning, but fixing it avoids
> the warnings and can help the compiler track the individual objects better.
> 
> Fixes: 71e4bbca070e ("nouveau/svm: Use kvcalloc() instead of kvzalloc()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-fixes, thanks!

> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 4d1008915499..b4da82ddbb6b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -1007,7 +1007,7 @@ nouveau_svm_fault_buffer_ctor(struct nouveau_svm *svm, s32 oclass, int id)
>   	if (ret)
>   		return ret;
>   
> -	buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
> +	buffer->fault = kvcalloc(buffer->entries, sizeof(*buffer->fault), GFP_KERNEL);
>   	if (!buffer->fault)
>   		return -ENOMEM;
>   


