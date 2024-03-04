Return-Path: <linux-kernel+bounces-90293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7586FCFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C791F2426D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230E24B54;
	Mon,  4 Mar 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmfpqWs/"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7727C224D5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543846; cv=none; b=mWMaeaMeNQIpzHRnU2iYPneLy6tuurwzhUU1RdKiDs6ydCIHE/gXbLNVcA0WlBax5Mr1Gnt3bKMTHE1UayS5ZRGCsAoKWpEasUC5wHxqpB/kHZ8ToK3bTZUOhC3qQi79MrgTzYTzY+Tqn3JGEGNwcw3aTeOc3RU2pCHaaBG/ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543846; c=relaxed/simple;
	bh=0cH0sGgH29hlXLiK6gSK9NkKYoxG4zTANFmso2w03CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw7KmQwygsmPj+qvJLUM4laD4uMBbkFFx/iT+uLS5HpdVwdmgDB4PQS/yb/6PAf/gRhtDpa7eiwXm7898RHHnOn0rZAzML7eYAWdLbr4fpc7lF6taVQN8PW88la8axV9icVQZ6dLv0eLtwXb0UmqL1dtKn7XJgbAJL36cpR6Aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmfpqWs/; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7dade974b0bso1826677241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709543842; x=1710148642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0MwiZA1cBA+0PzvnzU74hfVNWNLRRcLuEqTA/3M/Bbo=;
        b=ZmfpqWs/wwjbGUncTcbhtxuETIFupyYg06RvDahAqP7UkyvuXaLPLSC5SESVrG7vHR
         5wcTFWS+L/WQvKCkCB3XMV0zqKC7dD0VJoDiVusF44s0/UQvBVSZvOHM57GIKmbOj5Ub
         tBvgj0Gd9Ny8iAL8rKBEOOr2+MdiE5PHOAyQZeo8OKtiNIUU1lGBHgCGYY6UKPLRJA49
         G4EcrGbR05geMG0wiUFIAQgsivoTyKqHUGEQsRLTY86EsK3sg5xQyMcJucLcmOF/BI8l
         EZW+kHTCvhDeMoWNB7q8KOPOfxZylvg+0mhuLcT0b0Tx3q0K0+X34NuugjHpk7UDCGau
         GedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543842; x=1710148642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MwiZA1cBA+0PzvnzU74hfVNWNLRRcLuEqTA/3M/Bbo=;
        b=JqMYgifEpUYAabYQ7i45FG9iuUSZGmLl/vGr0aPu3pb7chOaF4x8C9+7gIPrOh1GcB
         6qxvwqCYFkV9O4HwjY89VjbyLFBhROYCQ2LdWN7cTnJ88/8+nLtG0d68gP0J1gWHxGwM
         D72E/gyiijBvR+f+b/HykXY/3OvGrGnsCNHsm4Am3JfUlYyYSi9Mtc43/rukZJ5BGWm4
         69QZN9i4VzbTH6+F1Uy7PaKYf8PTjmI52MdexHj4bhybfz6BsJxazdDHrbCk0KoxI9ID
         GxB+IzCgdsiX+tpf/1DlqMlgUvhOGTLtrgLq3b8RttCDO8xvgjXH7qS70LO+aDhrDDOP
         I7IA==
X-Forwarded-Encrypted: i=1; AJvYcCWj+tTTb7A1hg5r0ycOM47ZLViL5LxZHoaaxu3fcfD0RJXI8MzXI9E8dTK5dmYvPOHZ4CxFvJKzFRV+N8gzs9sqBFp/51kG0kuZMaA5
X-Gm-Message-State: AOJu0YxhNMLbl+J+eT27um1pMjXPeGFybc0RZwk/E3AOLbFYwlR0NBIR
	sdFegL7hGvP/gdh2hyh79e8YKaQVK6GI4wlb6lMSo2/YcdZ8C0iVDWKWd7JK+CcSvbBQjKsftOp
	4jqjpqV30KLkuuMkUy3Vv5+utEdEISKxzTtiK1A==
X-Google-Smtp-Source: AGHT+IGm58EGp6zyEamWAbvLgFuXFt0fgBxhzGA+FlV7PlF7jNoSc6rWzROVnOONJMROb+xdl1spvGMBUyIuuAKRJpw=
X-Received: by 2002:a05:6102:1590:b0:472:9b30:567a with SMTP id
 g16-20020a056102159000b004729b30567amr6374784vsv.3.1709543842338; Mon, 04 Mar
 2024 01:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com> <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
 <4E68610D-8F2B-4E27-AE5C-45CB59D7FEC0@arm.com>
In-Reply-To: <4E68610D-8F2B-4E27-AE5C-45CB59D7FEC0@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 14:47:11 +0530
Message-ID: <CAFA6WYNz57v_S9CBQHUjvPdzcP9FWuDN0ciPNvgUZY_-m3JKRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Balint,

On Mon, 4 Mar 2024 at 14:33, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> Hi Sumit,
>

[snip]

> >> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> >> index 911ddf92dcee..4cf402424e71 100644
> >> --- a/include/linux/tee_drv.h
> >> +++ b/include/linux/tee_drv.h
> >> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
> >>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
> >>
> >> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> >> +                                size_t size, size_t align,
> >> +                                int (*shm_register)(struct tee_context *ctx,
> >> +                                                    struct tee_shm *shm,
> >> +                                                    struct page **pages,
> >> +                                                    size_t num_pages,
> >> +                                                    unsigned long start));
> >> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> >> +                                int (*shm_unregister)(struct tee_context *ctx,
> >> +                                                      struct tee_shm *shm));
> >> +
> >
> > These rather belong to drivers/tee/tee_private.h as we shouldn't
> > expose them to other kernel client drivers.
>
> As per the discussion in the other thread I'll ignore this.
>

Then it will have conflicts with this [1] patch. If you are fine to
incorporate [1] in your series then the right place for these function
declarations should be include/linux/tee_core.h.

[1] https://www.spinics.net/lists/kernel/msg5122983.html

-Sumit

> Regards,
> Balint
>
> >>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >>                                             void *addr, size_t length);
> >>
> >> --
> >> 2.34.1
> >>

