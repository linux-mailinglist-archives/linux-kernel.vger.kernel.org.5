Return-Path: <linux-kernel+bounces-94556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6987414E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5469D1F24226
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD69141987;
	Wed,  6 Mar 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O9ahK6Rr"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDA137C29
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756434; cv=none; b=MFQCLWRMF6sgc8G/RgYRUyvT5ihw9DaASZigP1Y4yAhu4KiT+1hzVlTckYV+N1XyDfnkVhHFlR5BRho05Ckno8O9VZ9Lq/0ti4QruCKdm4OQozZ3M7BubklinS8o3F/F5VWY8Q6cpvzvPwv56sGXBOWW8UM5iQHn3ogJukp81qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756434; c=relaxed/simple;
	bh=1fMRZLipMrytyIL2P/bemn1/S7ehcHXKbZQM+j1zbmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FECUYGW9PvP/Wj/2FoEPMIiKS33/rgFwXhki+Rt2ZUo1lq//s4ypFygnSEHyIafNOXdr1xnmY4oiT1ShDm6Zl2a33A92XioiAlNK1pk1HQ3+ApffhM9pRVA3TP0j0di9BPJ1rbxqpgO4G7cFv+hSchzejfC2+y2n76gkqw9ohr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O9ahK6Rr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so22819366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709756431; x=1710361231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eBM56IgKWK3xhe9y5Rbhoc/hv2ZNbpBXfMCabxfGGA=;
        b=O9ahK6RrMAIhZ2N5wgmD/QXizmks9/fuI0hz5LNa/8PXh840Z7Vc0u22ld0JuRy6QY
         hoH/+7eRnhB6qXxu3JITOjBZZECVWpMxJDfyFHH9Ve4tfPgrJuk1a3vrQtQBdPSrkMlI
         upzR/v6cSEcEItSAGlVWUk9PbelvR/sJaFi1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709756431; x=1710361231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eBM56IgKWK3xhe9y5Rbhoc/hv2ZNbpBXfMCabxfGGA=;
        b=T3g2PzdPo7prWJnWrfVwMuB2YRb3DMJaAjkDeCeqm+KjR20V/LG9e6NZOfPiEHpSGu
         c63pya3TIIvhxzLK27U8uiA55re/XmpECBqN12h7OzrMg2KTPtLMgc627OqXJkNPrVBN
         /RTBc0j5j7YkUwzp4FDkrJfUswIdvTBxzSjwwFUqspaDG/9IWORdq7j1uKrDznXSXmu6
         LQR6DvxW31b56hSh3HcYYMw342rEuu2PfitVTEMkY3nm1B0BjTS5Jwto7fT92xuJnNy2
         PPTySyE5S33CdVPMLUWZnJNNGpHq44yHE9Uv0IWmGYlJrf6gCmfb+Mi7hhsJhxifK9Np
         Jdzw==
X-Forwarded-Encrypted: i=1; AJvYcCWmTr7ltdSerIaq1vyi+mUVO6EhkwdvJ6P6ImJJwyCPFlSq1+fMRX8bXk1S7IqtAvDwrkuMrDroYuWHoWL1Gqg29Es0sN2ZUT9YZhXD
X-Gm-Message-State: AOJu0YwNekVBVKYAOGCx+gRKVNBPcrpcQWwB6Fzo8uRGH3kYBr4RyBvY
	dh74EhYXje9jDa6EloeQq32ex8fiOrRWSrgLkg0E6OxddYIKeTcSJqlkGqkIgPdLoKNkyDbgFwz
	X64ilWg==
X-Google-Smtp-Source: AGHT+IFP4ZBiY+baA8MTp1cmdRlKlbxFFE4A4Aw3YBSds2nOVTwYFx8MthPEMUl1pwo06yxsf8Mn3w==
X-Received: by 2002:a17:906:a2c7:b0:a45:b84f:7ad8 with SMTP id by7-20020a170906a2c700b00a45b84f7ad8mr1948002ejb.13.1709756430980;
        Wed, 06 Mar 2024 12:20:30 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906279700b00a45a62e0ed0sm2244670ejc.98.2024.03.06.12.20.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:20:29 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso209023a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:20:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQPvi10DQdRS/7D+TD+Tox+qwSz7oKHBgUNL5VWFoaZnG+Uz/aci6jF3sLHAuY9w7NQg6e7RCfbwhFHb11bJ3vvLFr0XsAcX3bsjhs
X-Received: by 2002:a17:906:5fd3:b0:a45:ac0f:38e4 with SMTP id
 k19-20020a1709065fd300b00a45ac0f38e4mr3620090ejv.38.1709756429144; Wed, 06
 Mar 2024 12:20:29 -0800 (PST)
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
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 12:20:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiswkKOzA7279LOzMMMBwYhquu9yQsujJDZnS_Zi9PzbA@mail.gmail.com>
Message-ID: <CAHk-=wiswkKOzA7279LOzMMMBwYhquu9yQsujJDZnS_Zi9PzbA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That 'rtort_pipe_count' should be an atomic_t, and the "add one and
> return the old value" should be an "atomic_inc_return()-1" (the "-1"
> is because "inc_return" returns the *new* value).

Bah. I am lost in a twisty maze of operations, all the same.

One final correction to myself: if you want the old value, the nicer
thing to use is probably just "atomic_fetch_inc()".

It generates the same result as "atomic_inc_return()-1", but since we
do have that native "return old value" variant of this, let's just use
it.

So the rules are "atomic_op_return()" returns the new value after the
op, and "atomic_fetch_op()" returns the old value.

For some ops, this matters more than for others. For 'add' like
operations, it's you can deduce the old from the new (and vice versa).

But for bitwise ops, only the 'fetch" version makes much sense,
because you can see the end result from that, but you can't figure out
the original value from the final one.

And to *really* confuse things, as with the memory ordering variants,
we don't always have the full complement of operations.

So we have atomic_fetch_and() (returns old version) and atomic_and()
(doesn't return any version), but we don't have "atomic_and_return()"
because it's less useful.

But for 'inc' we have all three.

                        Linus

