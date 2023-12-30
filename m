Return-Path: <linux-kernel+bounces-13578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8282084B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AEF1C21D40
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5EBE6F;
	Sat, 30 Dec 2023 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RnOGC95j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345BBE5D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a23350cd51cso870551466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703965260; x=1704570060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFIhXDqs+3JV6YOccBLM5u+iUwrlM3KyelM0uyYE3o=;
        b=RnOGC95jMlf7SNhTeq1uZezW/VzPcWB17PKZMQi7nW7kO6vg38zwz3aWsn6uSr8NPh
         RDAGm9imSlghebKIB9E6rumejobtWJoAj7SwODlRf9iB2Z6JmH35fdeXXLJNeNmf2Dol
         DLitFynX9o2A0zxYMeJXpFXevLLHIsmoqxKAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703965260; x=1704570060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoFIhXDqs+3JV6YOccBLM5u+iUwrlM3KyelM0uyYE3o=;
        b=cBpuQTPgaQTcRGRtMR0DkBbcGj9CrE8PdGn28PJ1jBh9ShhzcMlEXmag3SxJJfFbKl
         CEct5S6+QD5SkRjuFRtR9bYUnrrVIfM4ixQ5aGbbewaByibqZ4RYI0ALzxjygZbKJFAD
         l4Txbs0B5xIMKBBAvNo2gx6i1SuCNwjPHcwmOGr8Tet0E94sFkvgBV1paUGScMXT/TWM
         IPw61POky7dkzhlndkyo8M6l72QNt+UYtPgFu+koBhR0EYtuLhA1iNhfIoV4O56evbO1
         8Gn96Qj+tBROVh16Th5ei2zrwmk43EB8bCUmXEs1KDd9ePuOMJ9HXoDEVCS47M8k6uaU
         f6rw==
X-Gm-Message-State: AOJu0YyP6pVLyY1+qItVR92LTsQDxuhXUaAvjCsL/jhoqxig4P4Gjl9X
	lAr0Wr1DSkg6xrGr3bYW6q1JmSBeK/sphdF9BIePbRrxz+2nDA==
X-Google-Smtp-Source: AGHT+IFUyOCAgAcR6Myo18PkB6KlwNc2t9XRrHgfKBFFY7/pQoOULU7HzZg/i4wMcr18C834xiCnYg==
X-Received: by 2002:a17:906:209e:b0:a23:2762:e48a with SMTP id 30-20020a170906209e00b00a232762e48amr5932921ejq.78.1703965259807;
        Sat, 30 Dec 2023 11:40:59 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906b31000b00a235e5139d2sm9545367ejz.150.2023.12.30.11.40.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 11:40:58 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2340c803c6so873930566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:40:58 -0800 (PST)
X-Received: by 2002:a17:906:3a16:b0:a26:e4ec:b6ca with SMTP id
 z22-20020a1709063a1600b00a26e4ecb6camr3417319eje.92.1703965258406; Sat, 30
 Dec 2023 11:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
In-Reply-To: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 11:40:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
Message-ID: <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
Subject: Re: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock code
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:52, David Laight <David.Laight@aculab.com> wrote:
>
> David Laight (5):
>   Move the definition of optimistic_spin_node into osf_lock.c
>   Clarify osq_wait_next()

I took these two as preparatory independent patches, with that
osq_wait_next() clarification split into two.

I also did the renaming that Waiman asked for.

           Linus

