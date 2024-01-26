Return-Path: <linux-kernel+bounces-40695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3F83E441
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7419B1F22B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449D250EC;
	Fri, 26 Jan 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITiiXhmu"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29F33CF3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305774; cv=none; b=GvSLn5OyOCJjJkb+BWaFaVMzyhcCtA/3hQKb6DbLe36vzkm5BYU0xxovQIViIsFQuVk8R4fGnyrT6VY3d13TGSid6bpmQvr014u6frmyqCb7ZxtYI4LDVcYleFTPqIeNdiax6FRUF7sG6/GRizfds3JGGPpDr8UMoHn/V8rfdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305774; c=relaxed/simple;
	bh=1feBzgxjUm84iiTUiKu7X66LEHmz3gCWzAl4aZvt1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwVcgJ8Olc05qNr9Tng+jtGZYLcCzA041hfgw3iC0pY3Rs/M2iBNKeQ93a/W9EvXFC5PcymWdfIquj+NHyLR5gMIIF5/iH6ZTKew40f4VKnb8IQoz95RxwTL4q+Hqth1SH9YrjngLe8JaFl+UbCoPB5lEernR4o7qMlheNFpvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITiiXhmu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ad3ee50e4so1292708f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706305770; x=1706910570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wu3+xA7CIMWU4XKJQMmnJ1lLlzU5w120Zsjy2ckeYo=;
        b=ITiiXhmudKL1MPHqHwYC1207HInRj/txaj8MxdEN5yhIElN4HKnN3uJ0qy+v0o2vDC
         MbPRgPt5thoZu9pOGm4LdmSMR1mLCpMIlx1d3OhBpd+RWpv5kyBNJYSLaQqeeszBT5OH
         YxD60z5BY0bNA/cPPaOgmdXyhThUliqyMkhm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305770; x=1706910570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wu3+xA7CIMWU4XKJQMmnJ1lLlzU5w120Zsjy2ckeYo=;
        b=m699cXgtjQkuQWaqYtuqslpuSHZepu6/pgvCx6uFOvBBGRR34hbpRRDRBxwWBq3oJZ
         Sf4r9u4r/nVTzcx77eLX2ipdT/mFnfs/6mHNSXrIYCLGlUArJWh9L35W5l3aCy+V1Ddv
         D9pN5xOAowQqNKOVULzU5ABCvpxbQSBb0fLVALc07CXIld1GX6stMuV7qYAtgonHSNuD
         D1A0lAD/96cOpGoy6LVpJeop/dtxgmzhXAzopNzgKbTbc9GQIfMGzkiqgYWbT5ohVC23
         MUWpVzDLqxNpcgS0xgXr0sTrE6+vi3L/nWkm3cj8bMqh4A1K7f/zRcWayhHvtxHAVDJF
         G3fg==
X-Gm-Message-State: AOJu0YyGdMu3Vr1XQ0lr1XmPQYMM1T6pDz3C5FqIRMpS5u20zsOt+ypJ
	N2iN6KcqEr5X2Pm6IkFw6Zr86KNeH6kSceHA0q2793TYKudBfyjxqOh2ELfoi0mUKCSFoI5OhLq
	/h2y/AA==
X-Google-Smtp-Source: AGHT+IGXJlTTsFbt4xxUbPYxdsNAW+7bA9FiSm7bnMymcM4Q97v+4ms/OdOjjLWopCOgrOta9EkiKA==
X-Received: by 2002:a5d:61d2:0:b0:333:4b44:c9e5 with SMTP id q18-20020a5d61d2000000b003334b44c9e5mr155991wrv.51.1706305770410;
        Fri, 26 Jan 2024 13:49:30 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id dq5-20020a170907734500b00a26f1f36708sm1043135ejc.78.2024.01.26.13.49.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:49:30 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so17972305e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:49:29 -0800 (PST)
X-Received: by 2002:a05:600c:4a21:b0:40e:9706:9a38 with SMTP id
 c33-20020a05600c4a2100b0040e97069a38mr197355wmp.214.1706305769566; Fri, 26
 Jan 2024 13:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:49:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Message-ID: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you have more than 4 billion inodes, something is really really wrong.

Btw, once again, the vfs layer function you took this from *does* have
some reason to worry. Somebody might be doing 'pipe()' in a loop.

Also, if your worry is "what if somebody mounts that thing a million
times", the solution to *that* would have been to make it a per-sb
counter, which I think would be cleaner anyway.

But my real issue is that I think you would be *much* better off just
deleting code, instead of adding new code.

For example, what purpose does 'e->dentry' and 'ei->d_childen[]' have?
Isn't that entirely a left-over from the bad old days?

So please try to look at things to *fix* and simplify, not at things
to mess around with and make more complicated.

              Linus

