Return-Path: <linux-kernel+bounces-109140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C276881532
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA591285239
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8A5467F;
	Wed, 20 Mar 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F66iNyrg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3C53E26
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950720; cv=none; b=kojKQqQTdwtvTs/3k5pihAFoGVbqLoANunk4TfUzwJbzQxGoPHf8XAbCF87i9hYKxejgH8l6WZ4gQJ5Ziup2JRuGO8wc466f7TLM4kfLuszA3hEq8g7o8AT0yrzoyr7HAuMVt3Iyq3sEvZCyiYZwx186Q8usQ00UAdulmX2D5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950720; c=relaxed/simple;
	bh=+oU4qEG9S3J4Io6ZyibfWWXlYyCdJm1i2y+SyCbGu8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7mN/BsJ936Y1uMgqrJX5huBFQizu9XEbvxCSSKR2mRAAfqnBy1SPZECYkDSB2fWiG2TDW/wbfuF2RZvloWwK1mArXy9gK8KNEbi5ZfyM+ZaFcZHx7JUUEgDvdRQqZRZIAoeIiIqel5UxitWp40ID2I8rmsIfu3zFCBZeCu/2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F66iNyrg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bb3343552so940798a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710950716; x=1711555516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flOLAPt+j2N3owHC8tz8TWGzLUzASU0n79EdF+rziHs=;
        b=F66iNyrgU/7nrNyTuYg5jF9vMsMUQhPwjFwf69xgG2HOzxl3dtYHbiBGW+CUNFrwpW
         cfV2jGEyKJTTfV7KbC02psu4JTNPgPOBJCiRNLs6THsjTTJgnrjCm2zh8fXFwFH0SmNO
         D9wr+p0bv+Jd0ego4E/TY0QHMTzniHw1t0GIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950716; x=1711555516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flOLAPt+j2N3owHC8tz8TWGzLUzASU0n79EdF+rziHs=;
        b=rY7cUx4vzRXMLSQ8PA/w76LoMKrNGQW2i/nNFKgkhC2spO9+iQWGiSTNAh3eeHVa3H
         /01xjgi0+LLyyN7Mr+fUlsl5y62zCIA7d9Dwl4D/bg+0EWXim68+QREtjsQenW6PDQih
         15wLdL/UwiWjBLNKuwLVrEFRnNKNVqUpdf1j9ghucOni7eJBnjknnouhxNgOdmJZOGO7
         /BVz/v2Es4qtZxD69JKNuAnXIOHBcnJSIOJ4Lfimn1Qo6fqY9Z80mZtYKiI/ZHj3NxFL
         ayImbBSYdc65T8ShE2vLNz7eZtPgRaKdRGVz7hhf5fs/FES4Zoib4zC5LG9sevsIPD18
         r2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVoBMacp3UVmsTmMNbAMBfpFNuBV9WqryLSM63Of/NxtFEISfuzL42iJQwaYgcTKbgzapGBW1lPmdZSWg3DTbGrlQwyRODvtMUlQt7
X-Gm-Message-State: AOJu0Yw4G/zrLJ8TsIqQcAy/D8b9117NW/3FyW03QwwZIls3VnRBqtOW
	thUJyvGXJ0XPJrz0Z46EB0AXEDy2pqC6xtKufHrt+7JQg7xtkHpKG+Fw7h1lUI/T4o9CJQHttyT
	ZLTCGUA==
X-Google-Smtp-Source: AGHT+IFhUAsbBUHaDIxKYBT0IjCVVGca6U312FvnSQnZTfJd5u/AiHxy0z+FWOIWsTlJ2TL4G4kGfQ==
X-Received: by 2002:a05:6402:1f82:b0:566:c167:4ac1 with SMTP id c2-20020a0564021f8200b00566c1674ac1mr4824725edc.26.1710950716572;
        Wed, 20 Mar 2024 09:05:16 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640205d200b00568b6d731e1sm5752171edx.4.2024.03.20.09.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 09:05:15 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so946764966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQNNFV9aczbEt82UA1MPO8H6P2Afh+iQTiBc6cNg/oNbAqGZdTkgq80b74pSZeEQ42501jKOaiOHxOIucIY0b7YBq1p6TL7Cia3dHF
X-Received: by 2002:a17:906:c14d:b0:a46:edfb:ff68 with SMTP id
 dp13-20020a170906c14d00b00a46edfbff68mr2554701ejc.5.1710950715478; Wed, 20
 Mar 2024 09:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com>
In-Reply-To: <20240320101851.2589698-1-glider@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Mar 2024 09:04:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whepBP2i6KrkSMdV98vs2PSpRcWS+zg0e8cNZKq0WUDnw@mail.gmail.com>
Message-ID: <CAHk-=whepBP2i6KrkSMdV98vs2PSpRcWS+zg0e8cNZKq0WUDnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: kmsan: implement kmsan_memmove()
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 03:18, Alexander Potapenko <glider@google.com> wrote:
>
> Provide a hook that can be used by custom memcpy implementations to tell
> KMSAN that the metadata needs to be copied. Without that, false positive
> reports are possible in the cases where KMSAN fails to intercept memory
> initialization.

Thanks, the series looks fine to me now with the updated 3/3.

I assume it will go through Andrew's -mm tree?

               Linus

