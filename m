Return-Path: <linux-kernel+bounces-167068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF618BA403
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFFF1C2226C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AB38F91;
	Thu,  2 May 2024 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b0WScEK7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91A1CAA1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692778; cv=none; b=ZEvzVMIIikxe5sm6kK63uqCkxVPD8/GgdWjtCBpjS7SmywQe1D8cLs5PbA7EHqO7lKveh7oTPm7bg31YHmz8qwigPYunfRzfit+c3Mn4+jDRyCi9YXs0YgxZjEv9fDITxv3z2LD14ZktFF9/uF83DirimsLDjeLIdSiD+QqpPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692778; c=relaxed/simple;
	bh=BZ52Tcx3eQkXrtn3fFvtEmKqc76WYA0oPdpNw2t/Pqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzzKp/ZBXCe0miW4CFttL6fa5eaBbrYLWuNDwzhwR9p0XkiIhN0bFZRpzkIvf7VnbuiAYGPBAdfGxmx5lHqCehae9B6erQlDBhQPcGr8zIekjSNqq+NIbW6TifykLyV3ihVO8w83Jw6Cg9og3z7FrZTaUAmrYq1Ym+W+N2EJX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b0WScEK7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso13272779e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714692774; x=1715297574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=b0WScEK7eqgWZ+bW3n1GeLpuoH9anxP5PNUtwu8tkw2jUtAkvNDlbABIlaFprHIsIn
         aeiZzXjWFkpQyTgFDWVe7znGYClIK43Z7R9Ese7Y91LW8iM04V18g+9ui5RMd9dVjt48
         d0xwvOvBQNjUYyFu0cbjX5BEGs3QKKZfp3WTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692774; x=1715297574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=kJVgsF4XNZMw1Ye72cXSqbhduxOCh/ud5ZGMnuxjDwr2TIN8C0CBKfXb9qoppH46jq
         mX1FSk6bnbJ8j+JQ63QMXiQJap8bUE+AWBp2WDWTkphXvoLrvf1p++wdn/wEgNKpiqjJ
         g4S41aWjdGZ7ArUVLWRlxNxsYde+ALNStjJwgZV5jsHQbJkya9L/pdoZHusmVWIfPmGn
         nVom3beaFJdM69oghvYDc3s3zAeNvMYU8X05hFHBGhMjoOWrmSi2AJHE6MWEsU0159m8
         8fq+Y3ftcnMFEhuoj2Npxvy5dCqmRXAiPAb0cYx++JaKsxSWwfMK2x9cXz69RZXFrZ48
         jgPg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIkFCA3BiZ/adVMtq/jmf1Ol2TnZRvRd0NWlCzN7nt+HBvKbZHFUCu5GBby6CAVwdftVVx8vy2OfNucS2jaF/si5J7SVEv3oI2iSB
X-Gm-Message-State: AOJu0YxmBaw3JSBBEnOgDs7ns73/eUL1vmAbO0DclLIomrlnnlwnjCfd
	eDTrDjY1JVdwdPrFhSS180v3Y3QLuk2V2zvpnW3mE2LImptvZf+EHAIQGru51y087mL68YCR4Zu
	JQwqHhw==
X-Google-Smtp-Source: AGHT+IHAs8nNsMIBRa601tHmDQ58Jose3CKOZQO0XMb/znhQdgpZlCwG6OAgfsaLjCgFEK+Fyev0Ow==
X-Received: by 2002:a05:6512:32c4:b0:51f:c8f:e356 with SMTP id f4-20020a05651232c400b0051f0c8fe356mr1247977lfg.62.1714692774474;
        Thu, 02 May 2024 16:32:54 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090639d300b00a522c69f28asm1037379eje.216.2024.05.02.16.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 16:32:54 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so80206235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlx2WXJQ0Zs1B5ez+TeZ6g1XSqqNuf18+yvmVxMxb+Bhf+XjO80tMWxyX1bTH6C+63h3GsK2RdxbzweBbyU9NIKPC2aszS/2w4mzS6
X-Received: by 2002:a05:600c:1ca0:b0:418:4aac:a576 with SMTP id
 k32-20020a05600c1ca000b004184aaca576mr1051475wms.39.1714692772592; Thu, 02
 May 2024 16:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org> <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop> <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop> <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop> <20240502220757.GL2118490@ZenIV>
 <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
In-Reply-To: <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 16:32:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
To: paulmck@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 16:12, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> One of RCU's state machines uses smp_store_release() to start the
> state machine (only one task gets to do this) and cmpxchg() to update
> state beyond that point.  And the state is 8 bits so that it and other
> state fits into 32 bits to allow a single check for multiple conditions
> elsewhere.

Note that since alpha lacks the release-acquire model, it's always
going to be a full memory barrier before the store.

And then the store turns into a load-mask-store for older alphas.

So it's going to be a complete mess from a performance standpoint regardless.

Happily, I doubt anybody really cares.

I've occasionally wondered if we have situations where the
"smp_store_release()" only cares about previous *writes* being ordered
(ie a "smp_wmb()+WRITE_ONCE" would be sufficient).

It makes no difference on x86 (all stores are relases), power64 (wmb
and store_release are both LWSYNC) or arm64 (str is documentated to be
cheaper than DMB).

On alpha, smp_wmb()+WRITE_ONCE() is cheaper than smp_store_release(),
but nobody sane cares.

But *if* we have a situation where the "smp_store_release()" might be
just a "previous writes need to be visible" rather than ordering
previous reads too, we could maybe introduce that kind of op. I
_think_ the RCU writes tend to be of that kind?

                    Linus

