Return-Path: <linux-kernel+bounces-24943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFF82C513
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FEDB217C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12217C96;
	Fri, 12 Jan 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q4YRZyfi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ED0VmWNY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25C17C81;
	Fri, 12 Jan 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 18:53:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705082020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tCG6i8W/p1iLpKLZv+LzebT6VrGogYOB7oDgy6w/esw=;
	b=Q4YRZyfieUbXw57ZkWutwz0rTD5SFBcfxVvcjO/5hb93D5N2lRglmys6t45a72/bSSFFo1
	pKRmxHOd4z86rSWDF8o5mjYKJqcrcX5bbqnvbH4M3kjjrVLV2qyxR7fn/N2Yo19PmrCNTN
	OsPnEn52U+Y5n+jhRFRSZ/Vp5XrLUOzVwHKSRZOicZrVKzUqhUYQl0MtHE1lQWwFi70YOV
	sTHepBr9JipEtCOLJNeQg8t5RV7Wu0C7fQQl7bvGdpH00mPiOziexw2HpbsIav8QVRBCwa
	x1CjGibLlCJ+m3sf4SE6HUa8PCSDYqQV3bxkThC8ryF8WBWi47bbtNhEeU0a/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705082020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tCG6i8W/p1iLpKLZv+LzebT6VrGogYOB7oDgy6w/esw=;
	b=ED0VmWNYaEoS/qOXaTBEfA8IweNyjKspoKZJ8c2ah68SSnzwGddB4IOr2e23MqQIgchXPh
	17K3Ek5pesn0fRAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Kiyanovski, Arthur" <akiyano@amazon.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Arinzon, David" <darinzon@amazon.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	Sunil Goutham <sgoutham@marvell.com>
Subject: Re: RE: [PATCH net-next 17/24] net: amazon, aquanti, broadcom,
 cavium, engleder: Use nested-BH locking for XDP redirect.
Message-ID: <20240112175338.e5Ipk3C2@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-18-bigeasy@linutronix.de>
 <13a755a898a44a98ac9b8e3240d17550@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13a755a898a44a98ac9b8e3240d17550@amazon.com>

On 2023-12-16 22:09:07 [+0000], Kiyanovski, Arthur wrote:
> Hi Sebastian,
 Arthur,

> I would like to make sure I understand correctly the difference in this patch
> between ena and atlantic drivers.
> 
> In the atlantic driver the change you've made seems like the best change
> in terms of making the critical section as small as possible.
> 
> You could have done exactly the same thing with ena, but you chose instead
> to let ena release the lock at the end of the function, which in case of an XDP_TX
> may make the critical section considerably longer than in the atlantic solution.
> 
> If I understand correctly (quote from your commit message "This does not
> always work because some drivers (cpsw, atlantic) invoke xdp_do_flush()
> in the same context"), in the case of atlantic you had to go for the more
> code-altering change, because if you simply used guard() you would include
> the xdp_do_flush() in the critical section, but in the case of ena xdp_do_flush()
> is called after the function ends so guard is good enough.
> 
> Questions:
> 1. Did I understand correctly the difference in solution choice between atlantic
> and ena?

Yes. I could have moved the "XDP_REDIRECT" case right after
bpf_prog_run_xdp() and use "scope guard" to make it slim in the ena
driver. I just made "this" because it was simpler I did not want to
spent unnecessarily cycles on it especially if I have to maintain for a
few releases.

> 2. As far as I can see the guard() solution looks good for ena except for (maybe?)
> XDP_TX, where the critical section becomes a bit long. Can you please explain,
> why you think it is still  good enough for ena to use the guard() solution instead
> of doing the more  code-altering atlantic solution?

Well, it was simpler/ quicker. If this approach would have been accepted
and this long section a problem then it could have been shorten
afterwards. Maybe a another function/ method could be introduced since
this pattern fits ~90% of all drivers.
However it looks like touching all drivers is not what we want so
avoiding spending a lot of cycles on it in the first place wasn't that
bad. (Also it was the third iteration until I got all details right).

> Thanks!
> Arthur
> 
Sebastian

