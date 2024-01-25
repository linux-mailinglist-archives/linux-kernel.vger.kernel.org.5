Return-Path: <linux-kernel+bounces-38602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E283C301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2A828FB39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295D4F5EB;
	Thu, 25 Jan 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHQsanWc"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245E374F5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187805; cv=none; b=NkS+zb/eCVzw4FyBvF69PbF58O+GT49OiZm41hQ+7SxnttL9af5xnC6vdUlDEEs0LCdUHuWybI2bU3D6T9tJXVpbQat8umPJO6rf4RHtCUglpARvdn4uXCwRetgTBj5+xpBHvRyUb3MXOI7ts/D2whw43llzfd8hvp33GXlpLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187805; c=relaxed/simple;
	bh=rk/AdcjA8LM5kSptwYAB5cvEIzrG6fwDwK3NoIgWvrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFDl+iXbkZkuXITh70AxTItAT0Yh5AW8eNRb1sCJFu5Yvax7g6Gq6NSL1kBNtKmiZr4JL+BVz/eQuNO3pMlyB6S9d31duEtRYqjMNtUd8dwsaNrd006Qz6SEasR3tSZQzXpx8VIiZM7066HhPp51t6PyVQi++OwhlknbCXBj2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHQsanWc; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc2308fe275so5751951276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706187803; x=1706792603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk/AdcjA8LM5kSptwYAB5cvEIzrG6fwDwK3NoIgWvrY=;
        b=kHQsanWcbqEmqpLDxjHQi3nRv2cVrQ+6F+2ZO9FHnDnYpmrj0jOhFoNoeqSTlgB7aI
         1QG62MKkJJNtjGyPaw/AurlD/sHYTpH62aEGKeF0UNXdYx3UpxCqtclNd7twi5gQO4v/
         jWCB39feNLttSuNL4XO+cPrSsu9ai9Nq1YE6Kje5kofKKMHJmiv5cb7dGySi2uKksfJC
         86D6bc2cSQQChMaBjymdJpwfyRMMecqLbvvl6qh5DD60W7FX5lwQEmOAHOTzQiDFtSlK
         oYxG4AP/n2yh7Z9MfI123bE1t03s03Wr0hCsJxYJncdHiO2BxpxoUYe7Qsdsz8EJcOD5
         ILWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187803; x=1706792603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk/AdcjA8LM5kSptwYAB5cvEIzrG6fwDwK3NoIgWvrY=;
        b=WrAvGeXLoPJvxlPDDI5fJrW/M1pB/G95xgZpCiE1P6Eqp4kZKTY30McdnwAj84kJtv
         xY8mNYDg2lwYqW+7WSUMNsKrIEnTV7RpARdzQYCU6a6vfch6J4i3/vx6HrH30vpcuPYs
         8KsiRD/CH9h5fUKIgH5kVddW24wvEmrlh3byYIP2diJphpQeLT0hAhb7iEFL9nhwjynf
         SpuneRzkv9oMFWZYhMF6yU2L31TdMQ5UXj2kgg2qgppwmeoVZzZS5KwQ0hP+g3xXUGSB
         pAs8rDiJNjEkjnMxhLoGeNIXRABQKojdSAN+2T/fivwPJrciOVwRqslNj6MN0HZIlL9z
         jqhQ==
X-Gm-Message-State: AOJu0YwKMooEKzwEHdBFFjhmBj/uYV304+V0NZQHYMRb3TP9aD7AF/Lw
	ppuEYh5acosTfeBmn+h6Xygq9qFYpNA5ebhHkY25qt0eVbYcx0HHbY9vbjJ6Z3HWyejdNt2zVz2
	fhgfWSRijOjcn43OFNa/HZJXar6Y=
X-Google-Smtp-Source: AGHT+IEVrc3BZ3CpTuYXryrI0tChAMEUXaCGI2T9zqW+QwDCV+fs+2Fe6iouCQteajEDIGL0vR83zW6gm494ee2OqqQ=
X-Received: by 2002:a05:6902:567:b0:dc2:2b05:4ab1 with SMTP id
 a7-20020a056902056700b00dc22b054ab1mr684198ybt.18.1706187803049; Thu, 25 Jan
 2024 05:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24mZcxdxKA5hyNaMy-jX=dGtEoZEY8imXKrTnZ0EC61_gw@mail.gmail.com>
 <c9b4dfc0-19b9-4e19-b681-e2fab63f41e8@redhat.com>
In-Reply-To: <c9b4dfc0-19b9-4e19-b681-e2fab63f41e8@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Jan 2024 21:03:12 +0800
Message-ID: <CAK1f24kg+c9XQruTjask+2LLXE6A3OHsRKdVq6-gVbNVV0jS9g@mail.gmail.com>
Subject: Re: [Issue] mprotect+madvise may be better than mmap for permission
 changes and page zeroing
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

On Thu, Jan 25, 2024 at 8:44=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.01.24 13:28, Lance Yang wrote:
> > Hello Everyone,
> >
> > I've noticed that using mprotect(PROT_NONE) with
> > madvise(MADV_DONTNEED) is much faster than
> > mmap(PROT_NONE, MAP_FIXED) alone for changing
> > permissions and zeroing pages.
> >
> > I have maintained a chunk-allocator internally at the
> > company. It allocates a chunk using
> > mmap(PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0),
> > releases a chunk using mmap(PROT_NONE, MAP_ANON|MAP_FIXED|MAP_PRIVATE, =
-1, 0),
> > and reuses a chunk using mprotect(PROT_READ|PROT_WRITE).
> > Recently, I replaced mmap(PROT_NONE, MAP_FIXED) with
> > mprotect(PROT_NONE) + madvise(MADV_DONTNEED) to
> > reduce the latency of releasing chunks.
> >
> > Test code:
> > https://github.com/ioworker0/mmapvsmprotect/blob/main/test2.c
> >
> > Here are the test results on my machine:
> > CPU: AMD EPYC 7R13 Processor
> > Kernel: 6.2.0
> > Elapsed Time for mprotect+madvise: 3670 nanoseconds
> > Elapsed Time for mmap: 5520 nanoseconds
>
> mprotect+madvise won't free page tables, mmap will. That's the biggest
> difference.
>
> --
> Cheers,
>
> David / dhildenb
>

