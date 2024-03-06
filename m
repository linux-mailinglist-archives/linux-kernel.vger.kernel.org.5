Return-Path: <linux-kernel+bounces-94551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8B87413F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C7D287612
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC814263B;
	Wed,  6 Mar 2024 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O8G6Oyis"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FD1350DB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756032; cv=none; b=WuAOp/rMxfzh/amaJu17dnAdgRr3aOy+0spx0Ng5z2jZ2u3L4ceSAij4G87OP/RmYD49WTKR2IIhzD4bK4Pm5l00JsrKaAfMUWPA2pBqRpAL+mL1//wkjmJYBlcc+ZQhxYBYmSlbpwfqRYwnquOdwCzi9ffZP/Js5M+m7cscLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756032; c=relaxed/simple;
	bh=SyrHb40N341DxXn2vMM7iLdQWShX0cFfOW4dnLdSUZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTkTLk9MGJ2mppzclTCOgUcjTV+oH+Rsme1PFshmWvidTkZ5cTgmrsrapjQglSON2xfGSH1cW0e58z2h7V2zsr9k6RZ76TLp8pp7rO0/930T+PNMFz/FamyZ0DHNuL8bxnEPOYcNoHvgvS8MftIqgkIsrOLGNfTt2hrNpmMgOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O8G6Oyis; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so29947866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709756028; x=1710360828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFv5gaMBFA/PPhuhGbhdZFZpUSVHV/ywVciaghdbwWE=;
        b=O8G6Oyisf391jO5tTz46D/gKYfxtubmuc8FvdITvYYYadhHdfkrAcNfNao9U9RjgKH
         tm3kQBX89Hdb42o6Jep7mmGCw8ZVjZzMmihB6ImNcfZGCdnDZ3Gzs9aryx1hIDGVOyQr
         v883x0M1sW9b2C6GG0/uwf8gO31NTnLhih5/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709756028; x=1710360828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFv5gaMBFA/PPhuhGbhdZFZpUSVHV/ywVciaghdbwWE=;
        b=YSbILE5I3mqXiT1hk7knCUXTdlSOdRVtReeM8OJqdgO5bfdt+2PauvEOD/GTO8RSan
         K36c1yF//DO41t9mtiXkg7+bUUVJpN3fjLbQhktak5iRAzMreIqWd7Q97c1ZXZbTiYAa
         dEQHAbXnRLUCgx9fdKju474/bT3Ft7jt7qun/07DMoIzv5D4Qqs4HUCJvq99M2N9c4dz
         almOpcIqVabjaePcQ71KxYfI5foL41klDXIEafboOKbzPfcUVIONh8l2Zmp4gXQLy3jC
         0/PwzWsqTTMSIWowABfs+ExTJmksIn9cV22buPslzSkW97Vmy++7iLYfdNldl37O3KRH
         WcSA==
X-Forwarded-Encrypted: i=1; AJvYcCVnELJ5J1DfP1/KpGknWpsPsavISZ9ND8QE0pQhH9kapk+ERQTWiJQd5TrNja4srkOFDzLXnrXnxBYaaCfvi9ySU9u9zcoLjZIsRIs1
X-Gm-Message-State: AOJu0YzFqSfbrb4hZmITWiaGdt/g02/AVkyIaBQ6ZrQAT31RvFka/DPj
	PY6v+VbKUXyioLA344/yQ1ygwhSDLorCtiDsSXdjCupGwQC/1EFWoivMdGBZVeknkIjzE/pZSRS
	fZvatJw==
X-Google-Smtp-Source: AGHT+IGfe5/M36nVQoIz+9bU+MoY+gzf8Q7ZtwUPBBM56nXjAcbIKJ+V2eq1QxyIQJ5bxBMJHzgMPg==
X-Received: by 2002:a17:906:d8b4:b0:a45:ae7d:c8fc with SMTP id qc20-20020a170906d8b400b00a45ae7dc8fcmr3300301ejb.60.1709756027981;
        Wed, 06 Mar 2024 12:13:47 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a4452ed413asm7320778ejc.16.2024.03.06.12.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:13:47 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so2524f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:13:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8ThHjtG4rP4MDBP8oT4HIMc7P0UHmhysZn6nVopcafr9RxYTE3WGUdv5c6iLPBKi7XZFw50ESryWZvz5Alvnak0XI8w8JTZGtNxWq
X-Received: by 2002:a17:906:364d:b0:a43:811b:71de with SMTP id
 r13-20020a170906364d00b00a43811b71demr10393124ejb.38.1709755577715; Wed, 06
 Mar 2024 12:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com> <20240306144713.2e1709ad@gandalf.local.home>
In-Reply-To: <20240306144713.2e1709ad@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 12:06:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
Message-ID: <CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Here's the back story. I received the following patch:
>
>   https://lore.kernel.org/all/tencent_BA1473492BC618B473864561EA3AB1418908@qq.com/
>
> I didn't like it. My reply was:
>
>         > -     rbwork->wait_index++;
>         > +     WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);
>
>         I mean the above is really ugly. If this is the new thing to do, we need
>         better macros.
>
>         If anything, just convert it to an atomic_t.

The right thing is definitely to convert it to an atomic_t.

The memory barriers can probably also be turned into atomic ordering,
although we don't always have all the variates.

But for example, that

                /* Make sure to see the new wait index */
                smp_rmb();
                if (wait_index != work->wait_index)
                        break;

looks odd, and should probably do an "atomic_read_acquire()" instead
of a rmb and a (non-atomic and non-READ_ONCE thing).

The first READ_ONCE() should probably also be that atomic_read_acquire() op.

On the writing side, my gut feel is that the

        rbwork->wait_index++;
        /* make sure the waiters see the new index */
        smp_wmb();

should be an "atomic_inc_release(&rbwork->wait_index);" but we don't
actually have that operation. We only have the "release" versions for
things that return a value.

So it would probably need to be either

        atomic_inc(&rbwork->wait_index);
        /* make sure the waiters see the new index */
        smp_wmb();

or

        atomic_inc_return_release(&rbwork->wait_index);

or we'd need to add the "basic atomics with ordering semantics" (which
we aren't going to do unless we end up with a lot more people who want
them).

I dunno. I didn't look all *that* closely at the code. The above might
be garbage too. Somebody who actually knows the code should think
about what ordering they actually were looking for.

(And I note that 'wait_index' is of type 'long' in 'struct
rb_irq_work', so I guess it should be "atomic_long_t" instead -  just
shows how little attention I paid on the first read-through, which
should make everybody go "I need to double-check Linus here")

               Linus

