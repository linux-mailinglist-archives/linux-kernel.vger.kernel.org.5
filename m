Return-Path: <linux-kernel+bounces-31678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD1833273
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D891F22BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAFED6;
	Sat, 20 Jan 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTJUfS+y"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF23EBC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705718091; cv=none; b=aVKff6gY3ipZnjM8Wjjw7BiTHdwrdmg5tfkD3Pnh2a/ILi6ygLX2Bs2lCGBjoo4AUNUtDNYuCKoiopIWphPqGUBYzuvcymIaS3a1IZG79DSKFmmizixEYO4HlxZnew37sL17nYCEPN+6t8+v4NARBEjVVVcKZ7Jp7eHAhrEf6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705718091; c=relaxed/simple;
	bh=gvWx8n+MqlwR24wYQ8sFNK9KUVlrw3LQiIBpTMGPEIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uApPH0EWfUh0XahtvaQTOr/l0SbZgnROJ29bl/92oYvZyvA97sSvDSfyrj58TvxKNw/jWJlnEDJbCNgVALKCSrsFk4gpvCRjJ7Fe+EQx1qzyt3r4BjhFyUx7+tiMiL4qhSy7vW7j8wHJvGgST3JSw65yAbJAQSbU2JBMJx7WP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTJUfS+y; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bf2a5cf9cbso68643039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705718089; x=1706322889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvWx8n+MqlwR24wYQ8sFNK9KUVlrw3LQiIBpTMGPEIc=;
        b=KTJUfS+yOAID5wLkc3Wa8bEybh0S0tA6vkNFBC0TGew5W/raVv5udNkY4c7CXrTJNL
         0n5NHA2YMm9EBa35jTBhnxU0vZzQ4rfoNjDsD3TwlVf9yI5uNnTZ46t3Xwq0djdYb+ey
         2+hwAvmZZcRxIHrRjxTfDlwWGWcfjPf9z5Ln5PrE6OzXrOoU3cPPA5M0waX2sSsS2dFb
         CI2y4Y9iqxECdYGBSUasOywZSftG0OmFZOwr5eZlYXVkM6Jcmb+HNQ5uenHp/gWR8PII
         2XoPrLNjHcwoI+EC5hXyR2iyoTb/7t+tR9M5sDQvfHB9L3Hiw/3Hfng/lqIL1FsosFgP
         0nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705718089; x=1706322889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvWx8n+MqlwR24wYQ8sFNK9KUVlrw3LQiIBpTMGPEIc=;
        b=K/8i6tyHnOPkE0oqhBJN4kB1qgCYbqUcYxxoCm+bnmqgfaNFAMv+ZaVZuVPKmtzeME
         iRZfHhydNa63T9+BYPEHaKNdOPXokfZQizHG/GJJUXZD3SuhHakjZBh6vr93o19GLdog
         gy1wbQyE1L0chiFYI/6OPRVdy5HdzYLOKKx36feWneUnQFSSvsAFvg/4V3OXMFznp1Fu
         uvwV0FssS6OvUA6BHFEBZfU8txV3MoRIM4UMOkK5zBbl5Y42Nh1CoyacJpa3+ccB2z3q
         nawNMwiLU81qIEo/3qt3PeqVWLJz5wCJ6moooQiSmFuX4B/vEU/aM2reBkA/XKoviBaP
         HRgQ==
X-Gm-Message-State: AOJu0YxIe99RmmslHSGmqx/1t3CZZJmubOxUInAfBJkuKI3JXlfdx3bs
	nROQjUvV64pwiItE2vDMP+6lYnfhMNXyq4MUDZ1Q/VeOUfPHF/QqRuD4UcS46qtFMrQO3gGfVIA
	0bwjnM5B3hlkoQwHVwG2d/HfHquw=
X-Google-Smtp-Source: AGHT+IEuNyW7dRwX0qJVya7Wtr11xnvWW7YZfKvrMvoEUGNOSPBC54vGBuP9ePtPykh8CT/KkeHZI2CPUp7SEWNRG7I=
X-Received: by 2002:a05:6e02:1053:b0:35e:7188:2c1b with SMTP id
 p19-20020a056e02105300b0035e71882c1bmr716410ilj.87.1705718088914; Fri, 19 Jan
 2024 18:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117050217.43610-1-ioworker0@gmail.com> <87ededl9u3.fsf@linux.intel.com>
In-Reply-To: <87ededl9u3.fsf@linux.intel.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 20 Jan 2024 10:34:37 +0800
Message-ID: <CAK1f24=cG4S2MzdMuZOvSmzrj0QFSXTeuVpfuObhUNGxDMSKWg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
To: Andi Kleen <ak@linux.intel.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, songmuchun@bytedance.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Andi,

Thanks for taking the time to review!

We are currently discussing this at
Link: https://lore.kernel.org/all/20240118120347.61817-1-ioworker0@gmail.co=
m/

On Fri, Jan 19, 2024 at 9:41=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Lance Yang <ioworker0@gmail.com> writes:
>
> > This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
> >
> > Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
> > make a least-effort attempt at a synchronous collapse of memory at
> > their own expense.
> >
> > The only difference from MADV_COLLAPSE is that the new hugepage allocat=
ion
> > avoids direct reclaim and/or compaction, quickly failing on allocation =
errors.
> >
> > The benefits of this approach are:
> >
> > * CPU is charged to the process that wants to spend the cycles for the =
THP
> > * Avoid unpredictable timing of khugepaged collapse
> > * Prevent unpredictable stalls caused by direct reclaim and/or
> > compaction
>
> I haven't completely followed the discussion, but it seem your second
> and third point could be addressed by a asynchronous THP fault without
> any new APIs: allocate 2MB while failing quickly, then on failure get
> a 4K page and provide it to the process, while asking khugepaged to
> convert the page ASAP in the background, but only after
> it managed to allocate a fresh 2MB page to minimize the process visible
> down time.
>
> I suppose that would be much more predictable, although there would be a
> slightly risk of overwhelming khugepaged. The later could be
> addressed by using a scalable workqueue that allocates more threads
> when needed.

Thank you for your suggestion!

Unfortunately, AFAIK, the default THP behavior on most Linux distros is
that MADV_HUGEPAGE blocks while the kernel eagerly reclaims
and compacts memory to allocate a hugepage.

In the era of cloud-native computing, it's challenging for users to be
aware of the THP configurations on all nodes in a cluster, let alone
have fine-grained control over them. Simply disabling the use of huge
pages due to concerns about potential direct reclaim and/or compaction
may be regrettable, as users are deprived of the opportunity to experiment
with huge page allocations. However, relying solely on
MADV_HUGEPAGE introduces the risk of unpredictable stalls,
making it a trade-off that users must carefully consider.

With the introduction of MADV_COLLAPSE into the kernel, it
is not governed by the defrag mode. MADV_COLLAPSE
offers the potential for more fine-grained control over the hugepage
allocation strategy.

BR,
Lance
>
> -Andi
>

