Return-Path: <linux-kernel+bounces-65400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A3854C62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A895F28CD26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA75B691;
	Wed, 14 Feb 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JpEw6dO6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A354729
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923691; cv=none; b=A/Dt5QP2VY6cJA8EYZo+Rb/xg/JcYy2OX0bOlgyKxWLVyE8WE+JH6Nz4jUyxR5OOhIYAfl9kmH8l6zgkJCj3Cwqo/B/YTnU6WQqH3w5az1Rk24b9XeYyAoXSoCEUbzB+Fxmpqe0XvN5bUQcYfQfdYridyBfrlik4wFXwTdguF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923691; c=relaxed/simple;
	bh=MSq1aHhyCOZwuB6HVLXhkIsc0Z/1YI2U6yTQBaiIqp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHnPrD/H6rB/xLuQfKWsiBb69TmnnMkd1ZNCe8emzTwIbjZ15K7NCTnA7egn+89wYrD70Ehr+DbdhNj6zWSBMDyj/L4t1z1pN9x/FaMTHDMkmoLUPecJFsaFQPmYJmZkreigC6gU7w14gFy24klL7rTYACW8NOOurqS71n87sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JpEw6dO6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33cf46a5f10so133618f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1707923688; x=1708528488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiPUoU/OSL+4s0/gfmeerSenEDwyaNer/qzbwOkxu3g=;
        b=JpEw6dO6iuIfqBWFCOko74cH15XuM1/st6UeI6vlR+HY9hlSoD4FH04zUMuODOEk9b
         fd0rttULK+rI5qLGcjGLGc++T8pvdiOLBIA7LaWSRXfHH4F4nj040RKPqng2m/2NmRZ4
         Frs0FvyQDHcDFZHk49/7KnvBARqBhYnIUpuDMjxaXQvnhhAwEdZoQ7WoKIpATXlWPuZ7
         KEo3W5MVgFROCMxmNr5R38seO2HtZ9/WBVb71R4oLmoIYFn19InzBAaPoeRzb3oXtydz
         dh30PyeGJvxZrIuqE/iq6nnACW/tL6ksskqaudiiwGNa4qzCPS4sz2aPY/H24VczQgHX
         3WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923688; x=1708528488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiPUoU/OSL+4s0/gfmeerSenEDwyaNer/qzbwOkxu3g=;
        b=J0ynZM/ieRAbk+0HHN1nxH9dp/9I6ivUnsTB6WZGUcKcf6GmcNiVjm3AJJKTC8HHXl
         Mk/oYEAFthvZwNKsa9XlSqNaDXBPFq0aDrUSgxQM/DIZazQ5Xaxy847Rxd8Af27DOfRM
         La+sw+H+IJm154wqsWrpzUh/Is7/4wTNi/ZrhbnE9drmRxJl/ubvxiHt9MlIc1mxcI1k
         EcJSpd2tl6PmVOpnn9V6hAm5Q+SSQVvgZSQ/Yes/B/r5hr+Zrho1ggJotXBMpcQuBLr8
         JwqyURdmNVd2+Xg0VVvkihuIEs3qrq9Tnv8kGC/2DmeyiiGIIB7IoCvaj3pUIF8dMqWx
         ozng==
X-Forwarded-Encrypted: i=1; AJvYcCVgpEFq9zZRWOF8uZR2HvuPQKyCWMQ7DQb1hW4awfRWX18nVGzjkMO4bqLKoUD1pKeno2Z+QLPjF1naK9KOOUoeL+bnR2bRay/YsDk/
X-Gm-Message-State: AOJu0YzQGGEwJiEvwDDnlzZtFWkqzBz8t91K6klF2rLFNwYorhaPbhm/
	C9GdnQZVE1WbRdav539so6TEgiXcdnYV27SiTWhJwaLQ/Zo7JydnEoInYO4M2DM=
X-Google-Smtp-Source: AGHT+IGEVz053KgocSLsMnqG2P0pn+W65e6jl9r1ASxuSK9ftBcG2FJaRGHvh2PfH1lRDJXA1UA5Vg==
X-Received: by 2002:adf:f285:0:b0:33b:63a5:feaf with SMTP id k5-20020adff285000000b0033b63a5feafmr1946972wro.20.1707923688231;
        Wed, 14 Feb 2024 07:14:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7xiIfn89urt5aSbJHCKWUeIhMcIDfy6bdDO+pIE3BC9PJTIUiWp71xaUHldy783YGwJz2ZQv6aLdzLdhd5AwgWS7SE3C9uM+OAM0mbX0vrurYxEH+R/jGFIxfathKcTOyKEHZ7q4XuWyuZN5lLeVdIfb/xjN1gRUwxGY8DIwuVrk8uM5OY0Wt2Z4R+h4zHFHDKo203H5cFim524OSqPvndw/usaGiqZh/Ys1U5x6Q8cuRx73EylGHqY1DnSlHGt/d10Iwkj8oo2clnK2op4vOdYEHzdWpDJZwEBoT4kOFa2YwATNEZKaWV0VzyOob13Xnx+VqNmlND/3AxQlOGtbMKr7NkpbCdsgvsBF7p22llEkNte7gSkMdDMFsXWJXzxirBfHPW9gf
Received: from ?IPV6:2a02:8011:e80c:0:bfa:fdd5:7522:6528? ([2a02:8011:e80c:0:bfa:fdd5:7522:6528])
        by smtp.gmail.com with ESMTPSA id u9-20020adfa189000000b0033cf35e8fd8sm779460wru.57.2024.02.14.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:14:47 -0800 (PST)
Message-ID: <5bb799e2-492b-49f2-b5f5-7e8f113bf56f@isovalent.com>
Date: Wed, 14 Feb 2024 15:14:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Corrected GPL license name
Content-Language: en-GB
To: Gianmarco Lusvardi <glusvardi@posteo.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240213230544.930018-3-glusvardi@posteo.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240213230544.930018-3-glusvardi@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-13 23:07 UTC+0000 ~ Gianmarco Lusvardi <glusvardi@posteo.net>
> The bpf_doc script refers to the GPL as the "GNU Privacy License".
> I strongly suspect that the author wanted to refer to the GNU General
> Public License, under which the Linux kernel is released, as, to the
> best of my knowledge, there is no license named "GNU Privacy License".
> 
> This patch corrects the license name in the script accordingly.
> 
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> ---
>  scripts/bpf_doc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 61b7dddedc46..0669bac5e900 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -513,7 +513,7 @@ eBPF programs can have an associated license, passed along with the bytecode
>  instructions to the kernel when the programs are loaded. The format for that
>  string is identical to the one in use for kernel modules (Dual licenses, such
>  as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
> -programs that are compatible with the GNU Privacy License (GPL).
> +programs that are compatible with the GNU General Public License (GNU GPL).
>  
>  In order to use such helpers, the eBPF program must be loaded with the correct
>  license string passed (via **attr**) to the **bpf**\\ () system call, and this

Not sure how I came up with that one. Thanks for the fix!

Fixes: 56a092c89505 ("bpf: add script and prepare bpf.h for new helpers documentation")
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

