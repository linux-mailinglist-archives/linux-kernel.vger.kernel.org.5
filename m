Return-Path: <linux-kernel+bounces-99464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3D8788C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A253280ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0785154BE8;
	Mon, 11 Mar 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuKku1Or"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BB1EB5C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184866; cv=none; b=NoukhvS7muY8LIWvPMKYF9ZseXdDw6PaqtCrSQxJ/+TgEwKsnrmPuQqSik3eh15Zw59ioGwUQL4ddL5+tfY7bKT7/ynUATxiClpi238Kd1RT0eI4WfdMFsYkxW7timSc7ZyJEbELux9hxUgsjN+2x5llrVtSnYxh/h8W9nNfAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184866; c=relaxed/simple;
	bh=sdiIgAJg0WVhlnuSmujapDS8NBl6O2XbKat3g5PwiPI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTYG9wyiDeUEyl15ThqjC97apWQdpnGQUbIOAhRdCFuqCGpBv45qgEduzyk1R3K16m8MUJxeVILdD14+WQpy57antM3AXtT2W6BAMDPAHT7ahM+04llQ7GOZMPD02ubQFYSjCSq/lLHyLTsFnj7GPQHp4z/Hntl6wOHT55LiusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuKku1Or; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso2086510a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710184863; x=1710789663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdiIgAJg0WVhlnuSmujapDS8NBl6O2XbKat3g5PwiPI=;
        b=LuKku1OrNsqZd5K6E3S5ihni/OIa2nBZfkPJzneMEqzA6XuqKW/9w67IQYpBPywqvU
         QKCF2/cLJVs9dxAjHOb7ynjxZkr9famf4C0GU0d0UDtJqyPiOXgMUtzG1NRny92tLD6q
         r8QNIunu0iJkACmcOZFh3XkPqumYAEAgJgMGMT0M3CRJd/Wb8V09fQtJt1Tjd/9kBbqQ
         xtF6ef6TA2+gCfyrDtt1ImSQ1kIrjsA6JMVGMFrtmHdtSq2Zs5auD3f5U99/Ju2Pxk6W
         xC0IzTV3xfv1kOeurKaVhmYtXMVdQwXzvyX5ERJpMBzk0WD51WBnBsLMcgNjxLzNOlBN
         uNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710184863; x=1710789663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdiIgAJg0WVhlnuSmujapDS8NBl6O2XbKat3g5PwiPI=;
        b=hh7OSDKtg1xVtck0yiNh3/w7n5QNanuE9DbAzx38d0uwd2p5riT6+FBQ5O1sOsgKHx
         7cG5xNAnjLlpQaQP7MMZ0P8XKnVI4jt/XphshkDvJdmahYlQ4FLSrnogJDjiXUU88sIN
         cM1uzphjTpilZ4WmQJGAUJPF7u++SvIX5SzoN4WG7Gp1JeEte+IXioxdjcDRtrzQpeYM
         pIEZ8KCnQtZF1YFkXpxBi905TYIoE5jStbgKnETbejwZSp/lZDJscbF/+K3aGigvutDX
         bERLLzL1WyUt1GY7OXaV571OWvwCtfNQEeqXHHzOqh7VpFeGyeUvR7taUuvUZmj7eTn+
         oJLQ==
X-Gm-Message-State: AOJu0YzWkYl2MChC6OI4ueJyrPwz2NhSt9KXxP+BqvP35PCH55L9v07C
	IGnSstzFxKXGKXx/vEvGzRj/NoVcqUnsfH8kUVUDUiDCPt5+53GJLn91sRV22E9jygM7+y2rdcD
	FycTlHPrf0pgeLWOa6RxKmhKYIcA=
X-Google-Smtp-Source: AGHT+IFeiZ9ORIOiJdWwUhVsq8ZnHumI5NXM2hO8BfIFekg68bFpl1pd7vDKsZz/aQMub/KKywTthYNOv8Yl6yC9yp4=
X-Received: by 2002:a50:d7de:0:b0:565:3aa7:565f with SMTP id
 m30-20020a50d7de000000b005653aa7565fmr4754481edj.8.1710184862828; Mon, 11 Mar
 2024 12:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6f02:f0d:b0:65:b649:35ec with HTTP; Mon, 11 Mar 2024
 12:21:01 -0700 (PDT)
In-Reply-To: <CA+CK2bBr2wH4=L39ZthRPUnAjVxMqt80bsZj0NPx9xdH=_Mn0Q@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <CAGudoHERLX=X1r0q7yHM22O9udsR=6M+geix7TR3f8ZzHkb-hQ@mail.gmail.com> <CA+CK2bBr2wH4=L39ZthRPUnAjVxMqt80bsZj0NPx9xdH=_Mn0Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 11 Mar 2024 20:21:01 +0100
Message-ID: <CAGudoHHFQPiYkpHrBqSUVDtxaWXLbSc3ZJDOwMEzheBLO8E6Lw@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, hca@linux.ibm.com, 
	hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kent.overstreet@linux.dev, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, 
	mingo@redhat.com, mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, 
	pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org, 
	surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3/11/24, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> On Mon, Mar 11, 2024 at 1:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>> 1. what about faults when the thread holds a bunch of arbitrary locks
>> or has preemption disabled? is the allocation lockless?
>
> Each thread has a stack with 4 pages.
> Pre-allocated page: This page is always allocated and mapped at thread
> creation.
> Dynamic pages (3): These pages are mapped dynamically upon stack faults.
>
> A per-CPU data structure holds 3 dynamic pages for each CPU. These
> pages are used to handle stack faults occurring when a running thread
> faults (even within interrupt-disabled contexts). Typically, only one
> page is needed, but in the rare case where the thread accesses beyond
> that, we might use up to all three pages in a single fault. This
> structure allows for atomic handling of stack faults, preventing
> conflicts from other processes. Additionally, the thread's 16K-aligned
> virtual address (VA) and guaranteed pre-allocated page means no page
> table allocation is required during the fault.
>
> When a thread leaves the CPU in normal kernel mode, we check a flag to
> see if it has experienced stack faults. If so, we charge the thread
> for the new stack pages and refill the per-CPU data structure with any
> missing pages.
>

So this also has to happen if the thread holds a bunch of arbitrary
semaphores and goes off cpu with them? Anyhow, see below.

>> 2. what happens if there is no memory from which to map extra pages in
>> the first place? you may be in position where you can't go off cpu
>
> When the per-CPU data structure cannot be refilled, and a new thread
> faults, we issue a message indicating a critical stack fault. This
> triggers a system-wide panic similar to a guard page access violation
>

OOM handling is fundamentally what I was worried about. I'm confident
this failure mode makes the feature unsuitable for general-purpose
deployments.

Now, I have no vote here, it may be this is perfectly fine as an
optional feature, which it is in your patchset. However, if this is to
go in, the option description definitely needs a big fat warning about
possible panics if enabled.

I fully agree something(tm) should be done about stacks and the
current usage is a massive bummer. I wonder if things would be ok if
they shrinked to just 12K? Perhaps that would provide big enough
saving (of course smaller than the one you are getting now), while
avoiding any of the above.

All that said, it's not my call what do here. Thank you for the explanation=
.

--=20
Mateusz Guzik <mjguzik gmail.com>

