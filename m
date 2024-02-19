Return-Path: <linux-kernel+bounces-71068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEE85A03A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602171C20FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDC25556;
	Mon, 19 Feb 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z80xIDpU"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55524B50
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336377; cv=none; b=V1cw6JJQaZg6iF6eakVz8ZFvOtz5j8l+W6ECCuKv9f5T2BWr/7OLiBfoQ9l84Kic38Mfuzn2j91AaJ75VLjLmDV6kq1r1zRM+jQjPVmhhIBPwcIpxxArJMApYrWRjj611OMKk/nhcTE4879aVqILSWUadFATL6/sefkFMfvFw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336377; c=relaxed/simple;
	bh=XBLvqfu5S/YyIzRMdcTJ531SxMGqeuOOA+uCAhNyIx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWJ9GCQjv0LlTahu+bIKn9w16v4NLqsYHpj4zdcRlZ3bUkw0YuXwVRK9408s0He7Rwo8tjrZL4MzwYLhPvVIWEbFAZeV6j9KfCOV3buDy+0nHQrqiLmgDZ2AsM6MqZG3fJaxaveDynaEFtD8ylxnxynW/TExYTUOyKOpAYXD2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z80xIDpU; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4c90bdfc8b2so20092e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708336375; x=1708941175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBLvqfu5S/YyIzRMdcTJ531SxMGqeuOOA+uCAhNyIx0=;
        b=Z80xIDpUl0PuILjOImfNdCrqT6UehJW0nGvOSf9f97uju/ujGHbnIO1290LLeIqiSr
         e4CJOLtAtdORKQMko5aklbBjTLp3GOYZqPD51iQrcwziZHypyImJB0yihiU3XgQBrV95
         mZJ0KCl52w1/l/4L8AyXgd0Qq+8kH9vp6k/EiuYCVpecQc36pV4orb+9WXFmhZtCzIST
         /7t/tPDdCgFL81WedZ/UZ9eaArR0YcscKakokDKCpgrNXRwV9/QlrExo4i8UHDyzZICi
         NS+D3CxhK/+EiU6+V0l3qq6BZp0N0Seaa1IcAdeVkzbtgzpDxoBmLzWVSfPWbeKByI7U
         Jk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336375; x=1708941175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBLvqfu5S/YyIzRMdcTJ531SxMGqeuOOA+uCAhNyIx0=;
        b=dU31PHpI0X0TBRLEBDyaWer9KHDB+wRmu2dtcUiFJ+J8/Jexvs8K1JzYA8L/Ebuq5n
         uJgs+E5aeKWceVCnRRKOE0vT9kjKUwBv0bac7KwwZTRObeRkWQI4wz9vk0Q4Gp20xsuT
         AMVVoGB8OakJgFvPRk9vPRwfyA0NXWYbfHD9vkgLglHWWsx+4fv16T0wANFRCowu6tQQ
         NhSJ3Ns4TRm08RAsy5ckbXXufs7qfHifHnEGcdbMjvKUg/ej1svt/cbmk4Pm1sGg0pJ2
         MqEE6BXmKmGZxat5jukH315KrbGQBy6cZqkruJQnjfBHK2AsP974tSjOlYVM2gKO/k1A
         n/rg==
X-Forwarded-Encrypted: i=1; AJvYcCW3S19VK1PodVadvmfa3Mym0DuBN5lmBb9FvU7n89G5K5f1DjFlqkpWd4ODDkwFMl7sr/qeY1qu5MT3qaIp6P57wBV9XVE85oszTulw
X-Gm-Message-State: AOJu0Yza8aMd4dDdMq4xIRDC6vnBv9Q2U/DRnEmEmJ1/RBQhbnQwL3DO
	0m72O+GQ89CbUh5Z8h1w6EMKr7JTd/q8zmmYGOsUSeoUTyT2NSCvTPu8/AGPBi9dqUvGM+Puafy
	B6FzxtNj0aDwp+PlPtl/EJou0aZN0WtxTAMdR
X-Google-Smtp-Source: AGHT+IFxm9gTtnw2kEqRG+NDvqVv1o9zPMM4YjhytO9ViafMJgLXk8vADLCrJ946126O1nHjq4bDRaMgdL9Sw86KDYA=
X-Received: by 2002:a1f:de02:0:b0:4c8:38f2:cebc with SMTP id
 v2-20020a1fde02000000b004c838f2cebcmr1870633vkg.13.1708336374943; Mon, 19 Feb
 2024 01:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
 <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com> <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
In-Reply-To: <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 19 Feb 2024 10:52:17 +0100
Message-ID: <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 10:48, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Sat, Feb 3, 2024 at 1:14=E2=80=AFAM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > You are right.
> > Thanks for digging into it!
> >
>
> This [2] revert is still not merged at least I checked on 4f5e5092fdbf.
> Is there any plan to merge it or find another approach?
>
> [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com=
/

I think it's already in -mm and -next. It just takes time, which is a
good thing, after all we want to let -next testing confirm nothing is
wrong with it.

Andrew, is this planned for the next merge window or as a "hot fix"
for the current rc? Given it has the right "Fixes" tags it will make
it to stable kernels eventually, but I also think that the previous
"slow" version is almost unusable on big systems, so it may be
worthwhile considering the current rc.

Thanks,
-- Marco

