Return-Path: <linux-kernel+bounces-108082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2288805B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878A2284734
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2E3D0D2;
	Tue, 19 Mar 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/Gg2Usb"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389983B78D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878123; cv=none; b=Sk+YiXbG87J256Y9jiriFLe9QXB2KI1DqCQPBX0SeaNs/lEfbN7Ggvtpf5O1TjJ8cPLuu39xGaaNb69Pe1+hbi9Tk5vIDclsECfu5lfPPGoHIAzHbqy3kFV2NA3/2i7evPuKufU32FU7YtEEIIjyx8XNTwETvTdnvj6o1Qwebvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878123; c=relaxed/simple;
	bh=tq/1pPtVk4bFy1TUWWqhNCcGUABz2Wn0gW+04VmLGUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZJuMMcY8gfT541iCOav4rjGHLIR36V26J8pezTCFhU85GBYxVUphgkw7LmCo62Pmd65ZZi0IL6LDiDon8+setvLpoMWPPcXjM+OmfnbqUCHqH5hvH1lI48gAbhulaWVSf/VDAavtxNS6ATFxmwSytCvss5yoRGCCdFSyb6aVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/Gg2Usb; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-366a04fb186so34055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710878121; x=1711482921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgLh9fxNWA3PLxV487Uv3NZnNjKvvWhoCvzQBg8zyQQ=;
        b=i/Gg2UsbI+WuXMivJK5yDnCJA8uYabgTTBLxhQMw5fQ//qS+w29wcwbyExemOyWlcK
         DIQxAE5ceQYKlRHIBZ7kIXn68al8eQlCZMnrap7wG3IPdS9L1deXQ6doSUtoONwYSsC8
         DKFYVMsd2FPDL/C2RJcUGsLwd0+YLOzjJEsuCAes6fnRoLN2flirAsNsIpcXPNktLsZU
         I2wX8nwHBoZCEHxTBxfAxKIDzKF7EGFySyJxZuW2LIn2nXF73jYT1kTZLQtiefaNj+GM
         ifXMz9UBjHjeRqGHJOQIUD7sv8AwmEd51FXBaYxFmpAn785lNM1nv3NkklCGeR6xMsRo
         FYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878121; x=1711482921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgLh9fxNWA3PLxV487Uv3NZnNjKvvWhoCvzQBg8zyQQ=;
        b=tTY1NCD8pB9EtwMhaC8Hok49G3ZcR2T6ao8bYABDuB7AWJdf1I6qhQ2SYvLo7GDTbq
         G2SfyLVchi7q4vX+atfDc5JYsqztV4yhCrAiX89SkVofjNdQFSE9yMJMtnD1mbotIq3g
         v1wbE/k+JYGKcuSpqV9rhYY3uRvPQKCtflrWtwkiiS0QLoiERUT86R3th5pC2wdRqPm+
         I+pTkCxoOisiOhXLeezW/jtMgUIb9yTlGMf90zyhBHVzeD2DQrbDiqjaVgct0Rk/DvG4
         OL2Hudj847eylMh92xF3kHomm/e/HBybHbpCkd25HrUiDtYgVkTSv0nEAKoiae++NdHn
         8JQw==
X-Forwarded-Encrypted: i=1; AJvYcCVqTd5PpNA2cwywaaxSGYCd1YxdXrX48bi/a8lRK51ejJ6V4xr84H4LZvpAQgG1HhL5XahTkrRPWSOhTysLyHevcEOll0dYJ9p1Xhp/
X-Gm-Message-State: AOJu0YwbRMbJi0Pt2fqIe4CVoVM3Ub3AzlfQRxbsxb17dqqvYOb48nY6
	Hkszr9eVXUThOa54B8B17zN/01F8LyFfgKzfdiZ7GlTmseXiN8n5nC+epuq4ZKsevu1L/4dErON
	pm+VghLdT72UsqD+chJ/UKOpQWJTj6GetD/6E
X-Google-Smtp-Source: AGHT+IERlmpYbi7scXHRweGWqKFANu4nCnjg91c1eLgZPt1tpqmLTiArMaKYHHFVGIrDmnNDhYnBI2oLyIaUqaSz3v8=
X-Received: by 2002:a05:6e02:1aa7:b0:365:a6a3:9c82 with SMTP id
 l7-20020a056e021aa700b00365a6a39c82mr63098ilv.26.1710878121279; Tue, 19 Mar
 2024 12:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-7-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-7-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:55:10 -0700
Message-ID: <CAP-5=fURxwVSddrNRhRwT4rWsRhq+BLkAzqi7ooZ6JQbPsOP8A@mail.gmail.com>
Subject: Re: [PATCH 06/13] lib min_heap: Add min_heap_peek()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Add min_heap_peek() function to retrieve a pointer to the smallest
> element. The pointer is cast to the appropriate type of heap elements.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I see there's coverage of these functions caused by later changes.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index ed462f194b88..7c1fd1ddc71a 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -56,6 +56,16 @@ void __min_heap_init(struct __min_heap *heap, void *da=
ta, int size)
>  #define min_heap_init(_heap, _data, _size)     \
>         __min_heap_init(&(_heap)->heap, _data, _size)
>
> +/* Get the minimum element from the heap. */
> +static __always_inline
> +void *__min_heap_peek(struct __min_heap *heap)
> +{
> +       return heap->nr ? heap->data : NULL;
> +}
> +
> +#define min_heap_peek(_heap)   \
> +       (__minheap_cast(_heap) __min_heap_peek(&(_heap)->heap))
> +
>  /* Sift the element at pos down the heap. */
>  static __always_inline
>  void __min_heapify(struct __min_heap *heap, int pos, size_t elem_size,
> --
> 2.34.1
>

