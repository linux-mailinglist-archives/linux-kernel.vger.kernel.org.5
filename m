Return-Path: <linux-kernel+bounces-1617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD238150ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2682B28B33B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791B47769;
	Fri, 15 Dec 2023 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bb0KVBdI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4745BE9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so126772966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702671121; x=1703275921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVwL6WxlcPOuKKrag/vl+avkwXISK2Xio8iynqWTYiM=;
        b=bb0KVBdIO/l8wsNCmnMjYVUkH99K9kcGPqzLNzrxsA0bu2EvyrMGQvgZY+ojgs3ZUf
         qg2h267+mEP9JhiPuUubrLS4nT0bMt0oyo9XwkeqekW6AdFWJbGhdxid0nKj/3IuNsR6
         /V5PZM7BNN/3ldTq+iKBLkmOkZsoBkftKb1uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671121; x=1703275921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVwL6WxlcPOuKKrag/vl+avkwXISK2Xio8iynqWTYiM=;
        b=wR/UuA00j/5Emtq2fWLPMdRzrC6+O7vCrxE9cEfOD+G9P2nzAfqzflM6H4p9gqrDMO
         6kdXACV8A/Odi/ClNz/RUgl7h5HeCiARQenxTTtbmGSYpQYrBUsjlHq+xP/lUjmMKNK/
         abZ6TMjdJdoscure8qvnWvZmSP/9iBt6ngqF1BE1lxsUaOc/haIX89Ev+jvJjI12z+zl
         GDqizSoI2O9SemeViWreQqIeeVGXTOil4p0K6uB+aN3XfqQZl+V1DgE7qGOwrBYh2+Fw
         xSsTExSRIdFaDv/GF3TIEV33LjdZZ1qRE8NDES7GsyJJh0ps9QGZdVkzA+RYbOCbRa3E
         tszg==
X-Gm-Message-State: AOJu0YwmxtOQui74pYJsYD83gVPSWanOvt6VmSlaGTcIBpVdBVMIOlGn
	8Luuh2LaTHYxOiNvtfFXMwDvjNsh+QomKOuv+fJmn8am
X-Google-Smtp-Source: AGHT+IF2SQShsIRez25I1ElQlmY8KrX2xcecRsU3dO/G3a54hWBVlwXcvZgIicKrDTvDxKPZt3RB/w==
X-Received: by 2002:a17:907:20b4:b0:a1d:f19c:ab1e with SMTP id pw20-20020a17090720b400b00a1df19cab1emr7381221ejb.100.1702671121079;
        Fri, 15 Dec 2023 12:12:01 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ga16-20020a1709070c1000b00a1c7f8fe581sm11137537ejc.221.2023.12.15.12.12.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:12:00 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1e35c2807fso125784166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:12:00 -0800 (PST)
X-Received: by 2002:a17:907:2495:b0:a1d:86c0:7be7 with SMTP id
 zg21-20020a170907249500b00a1d86c07be7mr5669635ejb.126.1702671120066; Fri, 15
 Dec 2023 12:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
In-Reply-To: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Dec 2023 12:11:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
Message-ID: <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 07:16, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Yu Zhao (4):
>       mm/mglru: fix underprotected page cache
>       mm/mglru: try to stop at high watermarks
>       mm/mglru: respect min_ttl_ms with memcgs
>       mm/mglru: reclaim offlined memcgs harder

Entirely unrelated to this pull request (which I already pulled and
pushed out, as noted by pr-tracker-bot), since I looked at these it
just reminded me about a question I've had for a while...

Do we have any long-term (or even short-term?) plans to just make
mglru be the one and only model?

Yes, right now it's not just a Kconfig choice, but a real technical
issue too: it depends on having enough flags available, so we have
that "cannot use it on 32-bit with sparsemem".

But I'm hoping there is a plan or a workaround for that?

Because I feel like we really don't want to keep this "two different
models" situation around forever.

                     Linus

