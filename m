Return-Path: <linux-kernel+bounces-67499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C6856C88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A051F21A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B81419BE;
	Thu, 15 Feb 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="el+YSwMe"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7D13B7A3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021563; cv=none; b=KkX0vz4qkrb/zpkpge1/lTGmk/lobmPvx5HZJabgOM0bp3hqD2woNRuoq8Qk1jyxoPMg1oaFN1c+RlyZFyXS6fJSLI4bF/6dbJThZMmFgdaAng7CGu4WdTgZn2BYVJ8p6SjsDM5ul0wsCSvXtgSn20HP2joLUUX1IRZARDsTUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021563; c=relaxed/simple;
	bh=dk7nldjBHf2OhhUJm5xdgR4jejE5bUggZf5m/L2de8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPU0aQZLJf5cScoD+IzP0ADtaekCk0WKRenpByHfAsKg0W5eWX4J0FBNmLZhPozjqNe6XQFUlTdmvrXOXQpCgoNlLpzRbKKHknX3QtT88rdMBwmKWSe2ZanjQV3ZNHvNBBc7d7Q++dBdbFVnfR/fIDqq6x4Rg0iPqyWgjZkQcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=el+YSwMe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d002bc6f7so115747666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708021559; x=1708626359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sjjC6lYZHHWcZkiJkEdyU7XkS4SkECfb3ViIZBKdrI=;
        b=el+YSwMetnVQOm6Ng602mTNUm2syJGnqaMdy0M0M0zx5SFhwOb2cDP7ZN9W2io9m0M
         NsUFcpM0cMvIGY3ucIQpsawuiDgYLXaoS1cqkLEl/jKZ6h4GeAc0r+5RBnT3AxTCeLgk
         8t0jnDZXBIMStqpKMhKMaKK0p6Ph3dVtW+KdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021559; x=1708626359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sjjC6lYZHHWcZkiJkEdyU7XkS4SkECfb3ViIZBKdrI=;
        b=p/P9uMBjU688h9VHT2Q04oxjqM14JyCXcKgQs+ts8iLSlp+iLEyejlYPVQZhjcIdGT
         4vkSKCF0akKnSZMsQ+Pz155Qsz/Gbsq8LOu1hu/cgB4lIVeJEGz1X3/udKg/5qzXDF4C
         C+zTBuyHnTp7eP2jQv0cZMT0itxp9ToAh0Xfn6nWPI/8E2MkzMMZFZUVQjrb2UduRvbM
         oe5URZiETst3SrgdrGw0P6ff4t0EgH2fkOqIbYEtL0PRGW0iE0AEKAF6+UCOrFnF1jQX
         WXFUjHpxgKSf3pef72BaBpdfMvAQNpd+JpFJQGutQTUVS0HtEE4xOBl0qa7m2trQjgoM
         shQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK8XsZmDnchJm5hEuydHGCuD5OfztV44sz5JjuzgkB3RY6FtCfRR7o7MtTRdBm/7Vo/1C6He936blOt6+TKuBmHvKofD05b5TVM8vR
X-Gm-Message-State: AOJu0YxTs5MB+bg1hQmQMuBHjn7w1psWd52eBoj0HF24wVCSZ2NYX/MP
	mGR1qGEq/GCEZCKEHBCzaKuL5oc1uZ0xidZkt1V1Mv06NnfS1unIkVKAa9iQLmN/PykBscxDiLK
	pOVM=
X-Google-Smtp-Source: AGHT+IHMhZvO1+oru/8r10lDFJWoz9eMi/4EiTq2VMQEKvrfYlX5lEKb8ARORXLnRGJbZLRCN6Oa8w==
X-Received: by 2002:a17:906:ae48:b0:a3c:de7:f59a with SMTP id lf8-20020a170906ae4800b00a3c0de7f59amr1895327ejb.60.1708021558794;
        Thu, 15 Feb 2024 10:25:58 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id hd16-20020a170907969000b00a385535a02asm806128ejc.171.2024.02.15.10.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:25:57 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1771430a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:25:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU61meHaU0n7IWwWlPWhNfxgIcFcAvT0sNi4vkxlx4XHlABmsusuleRQw8+lg0lAbMdwaL2fFlmvRjl9jBVLwwn5znUuCG3tueKMd5q
X-Received: by 2002:aa7:cf8d:0:b0:560:14c4:58fe with SMTP id
 z13-20020aa7cf8d000000b0056014c458femr1868778edx.29.1708021557034; Thu, 15
 Feb 2024 10:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
 <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com>
 <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
 <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
 <CAHk-=wh2LQtWKNpV-+0+saW0+6zvQdK6vd+5k1yOEp_H_HWxzQ@mail.gmail.com> <Zc3NvWhOK//UwyJe@tucnak>
In-Reply-To: <Zc3NvWhOK//UwyJe@tucnak>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2024 10:25:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiar+J2t6C5k6T8hZXGu0HDj3ZjH9bNGFBkkQOHj4Xkog@mail.gmail.com>
Message-ID: <CAHk-=wiar+J2t6C5k6T8hZXGu0HDj3ZjH9bNGFBkkQOHj4Xkog@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Jakub Jelinek <jakub@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 00:39, Jakub Jelinek <jakub@redhat.com> wrote:
>
> Can it be guarded with
> #if GCC_VERSION < 140100

Ack. I'll update the workaround to do that, and add the new and
improved bugzilla pointer.

Thanks for fixing this so quickly.

                Linus

