Return-Path: <linux-kernel+bounces-37105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F339883AB97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC82C28572C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1877F3E;
	Wed, 24 Jan 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjJE0Eo8"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2B77653
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106128; cv=none; b=f9YWXUXsIITDYtupd1JfY/fXGPg2DTatvBTdl+ntBht89xmS2LWJTQ9enDTW8celSTJjLnIK5+WpjHfwegacg1gEn7SU9eW9Xu4cEId/5yxa+WNRICzkQ3Eaw93UlbM8YLHJGbV/XLFQFEr6Rka3ddsLZp9v/5XyWfVlXiADz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106128; c=relaxed/simple;
	bh=WVh1AR3Asl0nZzBxeVknLN3Eq6yKRsKoisGl+yslhao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB10tuB6Eiw/6m7m8F6zJ3zlo5QWwz/laP5gKDfdstJfYMypJap7W0KsC/D743ajfzjFv0SaMIm1O4gg/W2yalEJszYRLKkluAxIgmcOu7BOXvTIoFaFgmduAsj2IaVGIQ0qWhJdjkiY86Txiwar7FI0UAkYKbuTwIKxAapVn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjJE0Eo8; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-469531dd926so1293063137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706106125; x=1706710925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Ickior11wnkNoXoIh8jyoa5DElGtPsGaiZ6/joupA=;
        b=NjJE0Eo8O2flgYeMFwdxmHLDD0pYBHyiJVGfsnvTD5qO0uWHZGlOA3+5brEfa8y9m9
         3fM1Sv9Urelt3WBdDhaSnQmY9DmyiMEFFE/oCGs3nn573bCGVnGmLX3yPn8E0A1ENB3D
         VpO0K8hiPAFhjv0o31VL2GiB3YroONoM9+D22cd/vBVwAM1n4VAPpXiINKh/e36KpkD9
         n8zCDOfR2yXhPloPPe0wOg62HIF0tx37u0Ct7vq8GLAiuKC2u7AMTFdnjwTbSij4hx00
         ALCn9WTOg0MejV/SLYHQztZ9dEmvUA8R9HOnzKXUllgWpUN8gSm0iIYZUdwSOPz7xRW3
         qQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106125; x=1706710925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2Ickior11wnkNoXoIh8jyoa5DElGtPsGaiZ6/joupA=;
        b=hq2D3D+z0Bz0lCg1wRddXp8Cl8PDf57lBVwJJ1XOmg/63g5GaP7tc6uw5Fe6Hn6kve
         32k3x5P3IJiRc1chtD3/uXcDcXLs37el1i9BhmNArWXQM8oHpJrQAvdestrCDlPFaDLp
         17nXZnCoYlkPZ1OdVnEsN6TMZosc3YDif35Ag/gdm9hnv7NsopcRT0fIVs7MwOms0cDZ
         A9ytA/eTdi2Y9s4BCuULwo6Ij+MqBE/j2VjMPO3QwUjKFhHVDVFi4RPECJeJ5q/8Z3cM
         10mEIcKN2mK3/h1RrIyE/8BhsY8JNTeTGDDgeMIIAA7SMQICn54C6eTRNW9+DXbw0Qgx
         IRBA==
X-Gm-Message-State: AOJu0YyWhvLWDfIj/M1kMUYO5122PnNCEAEyeyxSZ1OeCOfIQiDFZkhw
	424gVpPv88MBQ54xo5jS5czExXQ1kPXu6bSj64hiDe35U0vBJI4o1Ro5P0hpLq6oR1jOMiVpTqp
	oGrhIZRL4+pGd1XB/lJnbOKRTsZiW0XY+RgP1
X-Google-Smtp-Source: AGHT+IFn937a8xEj05SpiWuUTTV/ZEsI1GUIeimXuL5mw2tMlv9nj8yo84Gldw8XvPU0L31EiOIknjQRZzjdUZlIQmM=
X-Received: by 2002:a05:6122:9d:b0:4b6:bfae:3285 with SMTP id
 r29-20020a056122009d00b004b6bfae3285mr3899127vka.4.1706106125184; Wed, 24 Jan
 2024 06:22:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZbEbmyszaK9tYobe@gmail.com>
In-Reply-To: <ZbEbmyszaK9tYobe@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Jan 2024 15:21:26 +0100
Message-ID: <CANpmjNNnrKYKkV74rcBUkpA09KqwHOjse9J9aCHPRFuYKCQM2w@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Breno Leitao <leitao@debian.org>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 15:16, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Andrey,
>
> On Mon, Nov 20, 2023 at 06:47:10PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Currently, stack depot uses the following locking scheme:
> >
> > 1. Lock-free accesses when looking up a stack record, which allows to
> >    have multiple users to look up records in parallel;
> > 2. Spinlock for protecting the stack depot pools and the hash table
> >    when adding a new record.
> >
> > For implementing the eviction of stack traces from stack depot, the
> > lock-free approach is not going to work anymore, as we will need to be
> > able to also remove records from the hash table.
> >
> > Convert the spinlock into a read/write lock, and drop the atomic accesses,
> > as they are no longer required.
> >
> > Looking up stack traces is now protected by the read lock and adding new
> > records - by the write lock. One of the following patches will add a new
> > function for evicting stack records, which will be protected by the write
> > lock as well.
> >
> > With this change, multiple users can still look up records in parallel.
> >
> > This is preparatory patch for implementing the eviction of stack records
> > from the stack depot.
>
> I am testing quite recent "debug" kernel (with KASAN, Lockdep, etc
> enabled). This kernel is based on
> 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e, and I found the following

This version predates this series, as far as I can tell. Can you try linux-next?

Thanks,
-- Marco

