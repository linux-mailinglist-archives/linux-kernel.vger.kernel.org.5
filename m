Return-Path: <linux-kernel+bounces-83987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F786A11E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC601F21F80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A314E2C6;
	Tue, 27 Feb 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N7mHnDdl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639614DFF0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066996; cv=none; b=tG1rKBwlloNompqOSikl0lWDiEie1aVxwMG8VSLTemPIkEeSe6zfs8SIDyqritz0xfG/0YH48p6enOGlh2HR+fWhhr47WOzJ6ICFGypE715g/DRVxfNdbEm0kzoDIgnus13EGnxzm+ylKkfaxNLHCEGelBv6aW8V2KUC3xqUyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066996; c=relaxed/simple;
	bh=p9k/50J2fJtv36WtCUbSmzFiwVLwISsJpimpNmnaOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tkw3RuSCNN8JhqWbg7/mlxNA62vNAW1b41HGDTVf1xZnWfimXY4SXX8+CNYHhrOcULHfRLHuYV1l9lqovQWXlO1+mdWo7iv1Im5cQEDUTQCJ9pLl7GTPvKKNvUp9Vg5Lms4bNp2yfsXtEWgtIZv7SzFSa2VoK0HyX18B11x6aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N7mHnDdl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso39010066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709066992; x=1709671792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yi/RZQ8KqnZwl+S2VL1o58Mg6IThl5Qs0hc2x6y80JI=;
        b=N7mHnDdlSqH85ZaFemTfQk9eMgpfdEUeRWT7CHXa8EPKcauFoDCcpaMVyu/YxebETE
         w1F9NBzgpidkkMvZtV0K9R22ci7jz1k7hBHYYhNZWdvRizycBwdPnE1h0s1h5cIBWVhe
         dQwhJd/0LKY7j/VkVx0yJN8rVG1xlBWDfhal0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066992; x=1709671792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yi/RZQ8KqnZwl+S2VL1o58Mg6IThl5Qs0hc2x6y80JI=;
        b=SyAjn0sbDB64r5pCF8yR47pqu7Iqh/dx99XSw90gkYAlLAAzIgMjEP3NuqPXHBeVpk
         4RjKmsTt9ihchjYHLZfAKcOJ/eztP1E1fyG1T9GrNNhmGz6Veg4AGM33otDmKu/Em1XF
         N/zT3lS4tMr/VIi3v3oWDstfh90sOaUGNJ7kVgCfQw5bHyjiOsVLBMfmrbQ+MWTg72p5
         aK1zW6D8Pgr7vWJ/HKwJX7nzgmCOduwUvuZY0+YTzZm1JwPXatd95029SAFYlf/Sk20m
         QfWnbH8l3XZRLPTNySBrhmSuQ+qJ1aeeZ209s8VxXiBkUJn4SE+vBMU2IJ7P6hO3VMc9
         ScEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPgpzEpzQuZdLY52UhoKztRt3cMJ3XXEGEavUkZGqB7kmh/Bp+2c5hO+ywGbdMy2+hB/lxGh6OcXlpbhWGK9K55ofXzSXTJII0lNa6
X-Gm-Message-State: AOJu0YwOu84LA+luoWNKnD9mrDeusyicHzIUhJ0E+jB+nnT+hZbv4iM5
	xGBxEsC/uY5T5smpeA/eOscs3K/qtrEwZ2GbOEMjtseC0+M+VLCgIrZWA5JTOvgm+O9TPsMz8Sl
	K98CZUQ==
X-Google-Smtp-Source: AGHT+IE2xpg7TXzIf92/msQdpD7eA9oelfhoXu6D2ZybGXATlOkR7BHIzS6yf26sy4M3dEbBQJr8ag==
X-Received: by 2002:a17:906:2414:b0:a3e:c1ef:e1bd with SMTP id z20-20020a170906241400b00a3ec1efe1bdmr416515eja.16.1709066992293;
        Tue, 27 Feb 2024 12:49:52 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id wb16-20020a170907d51000b00a4329670e9csm1103903ejc.126.2024.02.27.12.49.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:49:51 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso33995366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAtKA2UyoUsGEKy82xePsS8QvImdfA10xHOQYWtbkLrKhHeuVfgEPJU/muB5LcK823pvJ22tmjm+IJ3cfCrJijzZEKHFLA3MdY9B/+
X-Received: by 2002:a17:906:4557:b0:a43:1099:7e72 with SMTP id
 s23-20020a170906455700b00a4310997e72mr375001ejq.35.1709066990810; Tue, 27 Feb
 2024 12:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:49:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com>
Message-ID: <CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cleanup: Add cond_guard() to conditional guards
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
>         cond_guard(mutex_intr, return -EINTR, &mutex);

Again, this is *not* helping make code readable and less likely to have bugs.

The macro has obvious deficiencies, like the "_fail" argument not
being surrounded by  "{ }" (the equivalent of parenthesizing an
expression argument), but even with that trivial fix the syntax is
just too ugly to live, and doesn't match normal C syntax.

And yes, we have other macros that don't have normal C syntax, and
they are ugly too (example: #define CHKINFO(ret) in
drivers/video/fbdev/hgafb.c), but we should have higher standards for
globally visible helpers, and we should have *MUCH* higher standards
for helpers that are supposed to be all about reducing mistakes.

Bad / odd syntax does not reduce mistakes.

If a sane 'guard' model doesn't work for some code, the answer is not
to make an insane guard model. The answer is to not use 'guard' in
code like that.

               Linus

