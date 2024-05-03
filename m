Return-Path: <linux-kernel+bounces-167133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6898BA4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E1B1C21BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D2C8E9;
	Fri,  3 May 2024 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dV3na+13"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E657C91
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698753; cv=none; b=qIQb66cT5KYIDzlL8zGpQB4+IGe4ZcI6NVOTKQpCc7u8EMIfCOpwOnXMiUiL4mLaSVLcD4U8abp8YtlTOjEsWGSRutQSfYLQ2Ez2ilveZO6dBD2xjzURI30OQFP8HqZjputJKLzGUXWv6JxhL1yXcSaGUqalaxzX+jI/22CoNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698753; c=relaxed/simple;
	bh=/EHAbUmEnismHqHCnrEdu/RGlnUctWo1thXm7yBHE/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=babYTmaxk9beMFAJ1kbCeiIxd+267aXZObkemQQT6xXOyA8gHkVAjFmm/+qfD8dC3mq7glPWz4Y/u0BcijuNa6o6/Hyk3I0mpqYRvsYYUxqIFbcNtDrh1wkagYvdVY4pbMx/VMU8SEXemVxzZ3mJQcGLkr/GtBjrTKxRrr5koms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dV3na+13; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a595c61553cso324878366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714698750; x=1715303550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0aAvYct7sRTxmrD1qX3Fgt4t7pw7u1PQBkmfH1Ekq6Y=;
        b=dV3na+13Xtuu4ptqC7o3jt/aAA7zDNQHxBlverXmXDag8iw4AXJWC+Q2xRBUOynWcA
         K3e18yFC9Aqu+3uUHQ+DPhEW7cYCgky2fkmF9WRelmPyutCeYoeNpJZyBsm2Mta8n3xx
         E83YXbfARtxQAw1sLN6WAvEpRe17Vn418hykk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714698750; x=1715303550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aAvYct7sRTxmrD1qX3Fgt4t7pw7u1PQBkmfH1Ekq6Y=;
        b=Db5BSaOnNa8DtStFGIE3zZhpeN+gW57XiCSi5geRJyA3t07aTNMXFJX6tO4io93MYS
         UB/CWYLugKLi2+fpDeu2WxFFaabZ0yczhurINMWCKRWBRcXWSGUihuwQFtTO7+DbkCDF
         f/+MmUlZurF9OUaYdbXjzCTVM2PptPPVdB8JJqKiwJBOP3D9+RHtGk4y7dos+GQz2VUr
         FkLGJufgNdjHXhIKUVG0OpYzlA1fXsmXC2b2rcXqM8qSEoswSNtSlUYCfU9o/d5pGphs
         Ws/CgXpEm4ek3tkxFoSclyTRNcKk7vNuuJBWo13at8J4tMLp2OL9D6QI2rcNw41WD7Fi
         wXKw==
X-Forwarded-Encrypted: i=1; AJvYcCUzShNMz3VTE9iRi1jFTA9ofKX+emjmINlpNPdRuIWLahxJiZa6/FqCDLkAD+SwdPuDTYTdkRrgmJEj92znIkWsCAzCFcGdHopl3fHl
X-Gm-Message-State: AOJu0YxgwbttWRrkL/EnitSEVaJrJldWDq6f4BVvQezhvseUqWr092v0
	IpdBBPKh8ANnZdrCkPBQArQCYe3+lupkTtec3RXEdU/GRop2QecGIPvY7mMz/28hlRx9VASZObn
	8SRhdrw==
X-Google-Smtp-Source: AGHT+IGU7tFYFwb1eUkm4oWJL2k2BV1Zlc7Q/C6pNJ8pudFLm+KZk/2nPWTRXWEcl39D4aSBd+FRXA==
X-Received: by 2002:a17:906:fc20:b0:a55:b487:5676 with SMTP id ov32-20020a170906fc2000b00a55b4875676mr574112ejb.72.1714698750369;
        Thu, 02 May 2024 18:12:30 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id qc11-20020a170906d8ab00b00a51e9b299b9sm1122993ejb.55.2024.05.02.18.12.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 18:12:29 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55911bff66so1133945866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:12:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyxdWiTyuwTdqGH+zJ1lvZlLC5HHILo1zIKDjd9zhFg6X3zZBcjOhd1LWzLcjQ857rg1SLbIbYxuvvbWE4EmsZIwdLCq4iCr80PRh3
X-Received: by 2002:a17:906:2553:b0:a58:8d37:a5d2 with SMTP id
 j19-20020a170906255300b00a588d37a5d2mr614192ejb.42.1714698748982; Thu, 02 May
 2024 18:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
 <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
 <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com> <5125d9ac-32d5-476d-82cc-b57d4e5d0807@I-love.SAKURA.ne.jp>
In-Reply-To: <5125d9ac-32d5-476d-82cc-b57d4e5d0807@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 18:12:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh33VL0v-fymirrB+i4pyqQoK0==4j2FW0=mLW2B_kpsg@mail.gmail.com>
Message-ID: <CAHk-=wh33VL0v-fymirrB+i4pyqQoK0==4j2FW0=mLW2B_kpsg@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Marco Elver <elver@google.com>, paulmck@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 16:54, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> debugfs (or maybe any filesystems that wraps f_op) caches filp->f_op into
> private data

That's just for debugfs uses. If you somehow try to do that on a tty,
you are quite welcome to keep both broken pieces.

               Linus

