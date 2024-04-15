Return-Path: <linux-kernel+bounces-145484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F148A56C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC431C2132F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221B7E58C;
	Mon, 15 Apr 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eqstKA9C"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325887A724
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196089; cv=none; b=pt0cjvdNeNo7k3dYj0TEceCVLMD4AggVf9r71JrjH1oryxzACgu1jkSW+TJGp2EXAQfdKvLp6a6QNGkSy6GGAXzFcEu7bgkwGd9sG0+dwxApHztgSJ1S6s5QIzFY1VcKR8O4S0b5Cl6RR514s8VYzMVT9Dr32aCMP7dU8k1ACo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196089; c=relaxed/simple;
	bh=dZ4dGq+HPjfFCn2dp8S3o/q8z5c/99q9yF5TfOaJh9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzKKXjP1BNn8zrb6/pIGODjvQOr6Iw3xB4kXPq2uHUUQM6DkKDNL4BFQ/znRaJ3qasH62+ToY+1Cvi/NUzKFA7xA8l1KNvbBLTuou8bKggEmlQpaPni4j3y2Ijc8nWjHZYjuv6ha/PW/xcWGutyP/06Laj+FXcm7d8KlS5YIqwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eqstKA9C; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da01cb187cso61322501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713196086; x=1713800886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zOPJUrkkBPsUFEF+l3h8xinlO94VHQW6MgwuJEIdPac=;
        b=eqstKA9CFvsG41KNbBDJx7q0Kn29E1wo52tg6gdCmrZBQuJ2zwL1jGEZc6OR3rDWCd
         7vD/dbMH1QHet+Zz6oAsV+SviptP8+aCw8AjjcKzUtP3WhjNo1n0NDWocGUu3J+imUKW
         KcIfZXUjKtxnfHeuOIh5mLXRyu7ve7jzb9uWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196086; x=1713800886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOPJUrkkBPsUFEF+l3h8xinlO94VHQW6MgwuJEIdPac=;
        b=cyGcUruvNTIjRBD0lN4uORIMzfjSmOP9U4YQJGYsO453k4M6rmKkB8fF7WKWlYDay4
         CgH1mp+CZiyIov7FE+pv0Gp1Rvz/fS1fZXe8IRCb9Id0maf/delCXl+0rEBSox9YCq6z
         9kmOesfPBqkSHbtzNx9HwlhegfmV9dNOuL2Y8bDOodFOu5a64upHj3phZL/1sOEtzosk
         Uy9yKQfEoeyapP/GAWwBHdG22rySyTombw817V6egTgzuxW8kCQ1yWCFF/4wa1Gsz4N9
         /QGFpEp+yfc7dtEYJV5L0fAhQ58Rfkq71y2/2g5mGUfISRfLy41XXv6iBL04h9+Qbe8J
         oA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLHIEjbkLPR1U1MJ53x9A+HDbZtXZa1B/OiOMXCxU7YABwtP6Dzc6o69yIuIVaTW+Mi0Qra8CCWzGUBKHZUMwW+rJzT6pywX5tMuiB
X-Gm-Message-State: AOJu0YwuHFjV8FvipHALrX/lJZP6QdRM9kD8rrxDLw7CaIK33Q+LXD4e
	yYeguVFy9snXvOZf5nr6t2edhuoa4J2cBNOQJp8JuldeXTMkoUD/cZx+l/DBlHH5ez7zFobQA51
	7yqU+sg==
X-Google-Smtp-Source: AGHT+IE0w9PbKCU/CGnZ1OT9FHnSkpGcENJEsvX+vaM7EPIvW9kym8N+LFYlNy4DJmqfSQ/89oSx2g==
X-Received: by 2002:a2e:b00e:0:b0:2d8:36f9:67af with SMTP id y14-20020a2eb00e000000b002d836f967afmr7247840ljk.44.1713196086066;
        Mon, 15 Apr 2024 08:48:06 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id hd13-20020a170907968d00b00a5217964308sm5595287ejc.218.2024.04.15.08.48.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:48:05 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34782453ffdso1595746f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:48:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8Foqoz0dm/PgIQLYUv+ROK+097kfqmV/+XHgvjrnt4WP3FxQsrTtVI5cqA5SlpsU5gHJt1jtHKGYssmzFslu8Su8hMtI4u7o6narb
X-Received: by 2002:adf:ebca:0:b0:343:e3df:6c6d with SMTP id
 v10-20020adfebca000000b00343e3df6c6dmr8354073wrn.21.1713196085185; Mon, 15
 Apr 2024 08:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712944776.git.jpoimboe@kernel.org> <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
 <8aee08a9-0d7a-4b5f-aee1-c70bad9433ca@suse.com> <CAHk-=wi0QrKuxQQmNsJhn5rE9Qe-Cz_9NsJOcOM1FK+knLeAFw@mail.gmail.com>
 <7f7df1f6-345f-4062-aa00-40c260b14040@suse.com>
In-Reply-To: <7f7df1f6-345f-4062-aa00-40c260b14040@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 08:47:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXidMn6-gGFidXvm0=k_4m-rk5Pgs5HcrtkYKMHYA3xg@mail.gmail.com>
Message-ID: <CAHk-=wjXidMn6-gGFidXvm0=k_4m-rk5Pgs5HcrtkYKMHYA3xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 08:27, Nikolay Borisov <nik.borisov@suse.com> wrote:
>
> Same as with every issue - assess the problem and develop fixes.

No. Let's have at least all the infrastructure in place to be a bit proactive.

> Let's be honest, the indirect branches in the syscall handler aren't the
> biggest problem

Oh, they have been.

> it's the stacked LSMs.

Hopefully those will get fixed too.

There's a few other fairly reachable ones (the timer indirection ones
are much too close, and VFS file ops aren't entirely out of reach).

But maybe some day we'll be in a situation where it's actually fairly
hard to reach indirect kernel calls from untrusted user space.

The system call ones are pretty much always the first ones, though.

> And even if those get fixes
> chances are the security people will likely find some other avenue of
> attack, I think even now the attack is somewhat hard to pull off.

No disagreement about that. I think outright sw bugs are still the
99.9% thing. But let's learn from history instead of "assess the
problem" every time anew.

               Linus

