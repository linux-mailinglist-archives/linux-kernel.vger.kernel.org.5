Return-Path: <linux-kernel+bounces-121972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A161288F00A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFAD29588D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A3152501;
	Wed, 27 Mar 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K6Lgh26O"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BA14EC63
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571224; cv=none; b=lxndlFmK/bQ5Al1oVo3kSRJCLpiJKHu8PfWiErXJoi9hB22r4fmmRJtf2lSG09x7A0hpf95UT0tJTAfUTbkS+2jQqbajJAiWQS2G1VYLU3WtKLWhUEFxtfzTFbYkTsgCANOh8k7XWfS2HHWCpd5YE12sZSYN1KJh8d8aWWrMt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571224; c=relaxed/simple;
	bh=/kMFUecOlLtZ6TruFpDnojpWw0M0AwECSE5Df/hzRSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUZkysSjAfOO7ajFBzfJ07m1P+1ScZhVUTux2HsbaLA0fpPrtAVxOf0KbfA8iXbmW3C9b4IGLXWKjvYnCsju/1weUMWgm5XvSZlhVht/xOF/8f4e5qgKnmhhiIWo1f5YQz1Idp2ugl2ar7aYYLZuX2FhGyipKjhZnALAmBNiMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K6Lgh26O; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so2867761fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711571220; x=1712176020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa4G+rafja9Pd/ZwHhTkok07IxAnxqObZh21oazJr/A=;
        b=K6Lgh26OKsuQMQSKa72FwWGX8iH2c4GTIdqZAr+7tqwBjqpewgO1qmmJIM/hs2+rnT
         EnxUeukCDBDRucQjz7SdiU8cfkePiB7D9krCnSWY10iQ8oOJQgv4YUl8GkDW2QbkSiHw
         eWC+RdAru9uyK88ZD7G5HclhlALOqTZEJdryc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571220; x=1712176020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa4G+rafja9Pd/ZwHhTkok07IxAnxqObZh21oazJr/A=;
        b=HeSyJFCMxKWR7/E2VSA4HInvlbyv4n8jvc0zJ7VxHGetCjaWTysFR4ab42hkFi8O2k
         sCLlDOjN9kxND4DI5TsSluJ3gCVeo7eV3+GhzDgNieETOjImUROYNWe81Gv1ZUhk0Vs6
         Eweqdna5O3JTveHtYDbJcUXFm2NoAn6lm9IobUidSRvfiZBrCyHfnPGQGmPnFU/Po97p
         U0dsZiQ0ZbH4xOH4IwfuAZqiRqmPZA6Wb9a1ZDDessH2VYNFd1KtmV1Sm96dRwYJRzuC
         M+C+ETkuozYR1qNyxxWIDDugETu4lDRsFRxQE+sXwmgN/XaCWLZI9ytsO3abZiqQzoJR
         Ychw==
X-Gm-Message-State: AOJu0YxT+Suk6hmsxnuBl28H13EF4QMw+NWmpKVjwZb/f17qjt7zL5n6
	kuEBnRPkmbuvXaqAGzM9b0uhwJ43gOX/v7X92UnPd9RWGzDH8Q68CmLCakDtyvfUtcXebYoGbvT
	PcjWpaQ==
X-Google-Smtp-Source: AGHT+IG1dvS1kNYBuINr3CZEewX5mYbtwoK6zdVi6n/e7f2STfNyUV1XKw3VKNR+PqGczTTMrRIvGA==
X-Received: by 2002:a05:6512:344b:b0:513:5eea:2942 with SMTP id j11-20020a056512344b00b005135eea2942mr333195lfr.37.1711571220409;
        Wed, 27 Mar 2024 13:27:00 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u16-20020ac248b0000000b00513c7599f73sm1944302lfg.148.2024.03.27.13.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:26:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e39226efso143119e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:26:59 -0700 (PDT)
X-Received: by 2002:ac2:54b6:0:b0:513:dd66:d5ed with SMTP id
 w22-20020ac254b6000000b00513dd66d5edmr412518lfk.29.1711571219226; Wed, 27 Mar
 2024 13:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com> <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
In-Reply-To: <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 13:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwOC+AJoOBYUotSsOfch80D-5k3Uioox2znozeAYnQYQ@mail.gmail.com>
Message-ID: <CAHk-=wiwOC+AJoOBYUotSsOfch80D-5k3Uioox2znozeAYnQYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Greg KH <gregkh@linuxfoundation.org>, Chris Leech <cleech@redhat.com>, 
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 09:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I also *suspect* that using 'physaddr_t' is in itself pointless,
> because I *think* the physical addresses are always page-aligned
> anyway, and it would be better if the uio_mem thing just contained the
> pfn instead. Which could just be 'unsigned long pfn'.

Oddly, the uio code seems to be written to allow unaligned page buffers,

        actual_pages = ((idev->info->mem[mi].addr & ~PAGE_MASK)
                        + idev->info->mem[mi].size + PAGE_SIZE -1) >>
PAGE_SHIFT;

but none of the mmap routines than actually allow such a mapping, and
they all have alignment checks.

Which sounds wonderful, until you find code like this duplicated in
various uio drivers:

                uiomem->memtype = UIO_MEM_PHYS;
                uiomem->addr = r->start & PAGE_MASK;
                uiomem->offs = r->start & ~PAGE_MASK;
                uiomem->size = (uiomem->offs + resource_size(r)
                                + PAGE_SIZE - 1) & PAGE_MASK;

IOW, it explicitly aligns the resources to pages, so now mmap works
again. Oh the horror.

But yes, that physical part of 'addr' should be a pfn. Sadly, all of
this code is such a mess that it's a horrible job to try to fix it all
up.

So we may be stuck with the horrendous confusion that is the current
uio_mem thing.

                 Linus

