Return-Path: <linux-kernel+bounces-139333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA748A0184
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24E1B2557E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DE181D04;
	Wed, 10 Apr 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bUQi+HCP"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186D15EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782413; cv=none; b=WvzHJwyfD0wEC9jkXzBuc6EA8WRsOc099q7+zb63kI1fqJ2d/ymTL5P/5DPdvv60KaFSoNc+hQVZe8mTK6kv0o6KyItASgNuAR93WL0KLySTWAwXWp8Gq2l3h+ujYl3C/MpiNul8Y0RnafIhqeh6LrFg16ywDcGB0062bar+Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782413; c=relaxed/simple;
	bh=dN9QAFFSPnKO+kppDSwGYQaQqQZPMRvjy+igFIMMS0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDbSzcuvQzFDqAwEJ5plV7IeKb4DlwvnUk6p4vz31aO5zrJ4rpWHZbeG7rBbsd1E4vG4cfHdjPz71Sm4Wky9M6A6IiJQ9GJmRHu4HhL2NjPnXyLdeTnuppmaCAIsPJZahG9EsPFf/kH+dMGLSrgAPYnhMPSJYpWLMWmVPzs0UdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bUQi+HCP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso10659987a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712782410; x=1713387210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFiQhEOGgH7BulX7PcWOBKJwuVCh69V2zXaiyRkXXhg=;
        b=bUQi+HCPfJAEz4kdR2cwMuH26//p8PlGJF+UK/ul+umkE003gRrBYIi3zi8P1axbS3
         lN2GO5qu/wTj4qsjyXoIhzcpN7k1vWDGybquxxejHjA0a2ZLAWvf0nfqgY3kcZmMnlaI
         IVUAiDTBmfwVv3Sn6v6K//F0kikMl9v9PXngo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782410; x=1713387210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFiQhEOGgH7BulX7PcWOBKJwuVCh69V2zXaiyRkXXhg=;
        b=VCn+DSdQdxKHHmx8CHaMJOG0I2Ofs4TURkh+qEI3bw6sbznqksTsS8nnx1Xyx7yPL1
         nOa/7Lmkz3JGDxls9M7KCeBa7O/FHC76Ai7R8OuDWvBB0iooy6OtcnPFpI1MXtoymmsO
         kKwFTSYACH8wd4JGyiCkzOwZEx8n8aiAXVuprqkAhJeQYeeO+j7VrFyx26/fZHoWRhBC
         OmrPgUI8rQdog2G8pjefsZit5imt2/2EHy6DoikMcAiqf7F39rBo2HiIhpGHU4Uqza37
         qRsG8iBaCTL5sZt49yTV5UDncGtpAAX8EPKYPaQUSyuNfgXkDq27uYVLeC3YCcsPANNv
         poIw==
X-Forwarded-Encrypted: i=1; AJvYcCVzIb+ZE5d/43ztEFp/4hbtK23v6MAETT2ARyvqAe1L6ByMP1H1RwT9nu2mj64ZinGdnJlU9BqY9vc18XtyJgw2p1Ervs5lMCD13iW9
X-Gm-Message-State: AOJu0YxNiyOgpk15Usa9sK33yVs0IFTln3UKhlJT8fyfC3vz+Qm0LIsk
	H0BXdr/udEm4YC7AFpMEGYnZnoVnItf/6YRzB7ego++ZYfxB7iN2o9v8toarL+S+s8Md9w72Hy2
	Mw3YLbg==
X-Google-Smtp-Source: AGHT+IGssipc33veXdfxDEWhvd7oIqBoLQ7iLJi8nlkDG0NQ//eJ38en5rTo00pWsNkquJXDiAsOVw==
X-Received: by 2002:a17:907:7208:b0:a51:e05b:a168 with SMTP id dr8-20020a170907720800b00a51e05ba168mr2785536ejc.16.1712782409851;
        Wed, 10 Apr 2024 13:53:29 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id my42-20020a1709065a6a00b00a51dccd16d9sm43322ejc.99.2024.04.10.13.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 13:53:29 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51b008b3aeso585689766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:53:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNheV/vmkUcgWYd3Jx6P0iDIwtxUC00DbALgjh4GBXvcw8T0UwTzNjT6IvOzUoBbkFaJ+HBWUaYO1+vwwiv5FR0uklqvwY5G6ypvqH
X-Received: by 2002:a17:907:c789:b0:a52:1635:9e05 with SMTP id
 tz9-20020a170907c78900b00a5216359e05mr1520228ejc.13.1712782408768; Wed, 10
 Apr 2024 13:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410183852.6df5011e@coco.lan>
In-Reply-To: <20240410183852.6df5011e@coco.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 13:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwn2VamMH-o2zmk0d__GtEPTjL=x3QSEC0MHEt30=g1Q@mail.gmail.com>
Message-ID: <CAHk-=wiwn2VamMH-o2zmk0d__GtEPTjL=x3QSEC0MHEt30=g1Q@mail.gmail.com>
Subject: Re: [GIT PULL for v6.9-rc4] media fixes
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 09:39, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
>   - some fixes causing oops on mediatec vcodec encoder/decoder.

Well, I certainly hope it's not the fixes that cause oopses. That
would be the opposite of a fix.

However, having fixed that, I also find some of the fixes in here
rather broken: commit d353c3c34af0 ("media: mediatek: vcodec: support
36 bits physical address") has a "fix" for a cast like this:

-       dec->bs_dma = (unsigned long)bs->dma_addr;
+       dec->bs_dma = (uint64_t)bs->dma_addr;

but the underlying problem was in fact that the cast was WRONG TO EVEN EXIST.

Both 'bs_dma' and 'dma_addr' are integers. The cast is pointless and
wrong. It makes the code look like it is doing something else than
what it's doing, and that something else would be wrong anyway (ie if
it is a cast from a pointer, it would be doubly wrong).

IOW, as far as I can tell, the fix *should* have been to just remove
the cast entirely since it was pointless.

I've pulled this, but please people - make the pull request
description make sense, and when fixing bugs, please think about the
code a bit more than just do a mindless conversion.

           Linus

