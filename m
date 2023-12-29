Return-Path: <linux-kernel+bounces-13266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8E82023E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E212C1C21954
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B314AAE;
	Fri, 29 Dec 2023 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AU0WAstE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4B14AA1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27bdd05fd5so4301366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703890459; x=1704495259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6m9VLF20O4X/KrY9sImyrM2z1XysljU0MX887Rj6Zms=;
        b=AU0WAstED9IOJVCtIV4tYJaKakjKm3i0NNjy+OBJoxEInztqykeXgFrfSyGX8DT9gY
         WHmYWVvi+omqv/cQL4Qe2OK7rPM6dzc//e2KTI5IUsWAjXflm43uHK+4M5lzDEweq9Ck
         eV9mhyYgkvFE8DXc5FnYcxvo4TUkjHGTbnCc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703890459; x=1704495259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m9VLF20O4X/KrY9sImyrM2z1XysljU0MX887Rj6Zms=;
        b=NvTzXm4Uce2RXfQc0tDKgE3nexgSuzp3k8uFsZNFFjMqwka7XDF0hQ1Ny0sSnDcMTY
         oDrl736wz+sxVYU+KA68Z0kHXl4+Ra0eiBaMSlLbd+ZchttmYpwvy3Eb2MXXF44/TtF0
         a4guAtZtA+IuXY1q1hn3xzVLBQKk+dX8U49IYpf7HdwHQhdCuGpj6XEEIGIOy+IFbKMr
         GXTghLFix/fCZebLjWqI1ICfyfQhqglYg/nVUZ0B8yDeiPmx6PBx0mn209ZYxvILD4jn
         oMuFNsTc6B5rmDqYYLmmrET2wSs+hjzPCezuQFh8PvEKrVUN7PrNYYIi5fZOWyZ//Ayh
         7Lhw==
X-Gm-Message-State: AOJu0Ywn203xyElw2+H7JIcvlqhLgExXaSVtu3nK2yfC77MPs1/RVB7v
	p07zk0GVVI7LFpd4jG6gx2DFzgwp2yli/RizFFhlfCcSlHplEw==
X-Google-Smtp-Source: AGHT+IF3iuNWh5aFrTbSzDcOh29nQwQOeugl/mIGJmFjq2JBXEYU1z/iYEqXY5kVjHs2FMHr18U2fg==
X-Received: by 2002:a17:906:73c7:b0:a27:9a96:83c6 with SMTP id n7-20020a17090673c700b00a279a9683c6mr693932ejl.44.1703890458994;
        Fri, 29 Dec 2023 14:54:18 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id zz16-20020a170907351000b00a26e0236191sm5764463ejb.208.2023.12.29.14.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 14:54:18 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2356bb40e3so596371566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 14:54:18 -0800 (PST)
X-Received: by 2002:a17:906:15b:b0:a23:6084:d5c4 with SMTP id
 27-20020a170906015b00b00a236084d5c4mr6851817ejh.34.1703890457697; Fri, 29 Dec
 2023 14:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com> <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
In-Reply-To: <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Dec 2023 14:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3pHPAyNNaZ78u-RA=iwN8CPkfe69txoK=b0oKdKfROA@mail.gmail.com>
Message-ID: <CAHk-=wj3pHPAyNNaZ78u-RA=iwN8CPkfe69txoK=b0oKdKfROA@mail.gmail.com>
Subject: Re: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:56, David Laight <David.Laight@aculab.com> wrote:
>
> osq_wait_next() is passed 'prev' from osq_lock() and NULL from osq_unlock()
> but only needs the 'cpu' value to write to lock->tail.
> Just pass prev->cpu or OSQ_UNLOCKED_VAL instead.
>
> Also directly return NULL or 'next' instead of breaking the loop.

Please split these two totally independent things out of the patch,
just to make things much more obvious.

I like the new calling convention, but I don't like how the patch
isn't obviously just that.

In fact, I'd take your patch #1 and just the calling convention change
from #3 as "these are obviously not changing anything at all, only
moving things to more local places".

I'd also take the other part of #3 as a "clearly doesn't change
anything" but it should be a separate patch, and it should be done
differently: make 'next' be local to just *inside* the for-loop (in
fact, make it local to the if-statement that sets it), to clarify the
whole thing that it can never be non-NULL at the top of the loop, and
can never have any long-term semantics.

The other parts actually change some logic, and would need the OSQ
people to take a more serious look.

            Linus

