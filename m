Return-Path: <linux-kernel+bounces-61780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A2851674
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF528486D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA14CE06;
	Mon, 12 Feb 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbBd/Hmi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kz1K/T9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D24C635
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746226; cv=none; b=AXinI6grYZEYpygkBMyj1ryuBxgzgl6Qahl5geRT1JtvdgLOxv/e9iOXKLJKw9A+GHdK6U5CwurYHilN3JhlLjeUEO5Uv2pSrKiaWLb3CPwHXyWFsEticHUe7IVbNCy6sSCkvaI/aDToTMJK3EOR0TXES5PVLuRg8Hzx4lP2LPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746226; c=relaxed/simple;
	bh=PhHUI0/op/Qan6FvY/VR9aAaIVdZQKnXApivF6nk/xI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=QK+q/OYr72DNmSN7rowxIH679RSu9NPILlZKXwt2rhnhvfkP8P90+CK9T+0hhd9BVlD5jg2q2NQyXVsN9rO8zqrdy/bHafW1X1l3W5rqouOpn7uwMuedausVKvcWSR2YFFg6r6O5jz9n14vlOuxnudabin8y7H94YEfXGze2LGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbBd/Hmi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kz1K/T9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707746223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PDs667/kyIokG7fh/bIYu8xk/luCO9c6+FvAq1iBXGI=;
	b=sbBd/HmiodRWiGy6/hdfeHSy42CNWZxJJgDMlU1KCbmwbfBHuokYiA8RcmsDnFK1WXMZTS
	mq6B9TgCqeIT2nxwcBUfSs15oDKtSqyVnpxx8v1kugVQ3BruwM/XTakh9g1KyFqZHTTpTA
	tVFQZv/nYmzjmpUAY7I5v8KmrgRH99g75S/rQwvWxgXIVlUc/XbZ+FWPIvMO6iGeXIO2q7
	jKBtHQtSwWH3HuM7AlJ0K3dRwp9J260ezBh7Y4Zj9likzdbHf6rMGryJd4h5PUKko6zNFx
	S3AfLl2sYgd3PL4FwHsDDo31YPRq+hRTupc4IkqWT+eb86X65DOkWtcdjBcm6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707746223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PDs667/kyIokG7fh/bIYu8xk/luCO9c6+FvAq1iBXGI=;
	b=kz1K/T9G0KAQsJwWer8yj5E3F2bJzHPyiaOKT2ENQWU2Pb/kyqDM6ghMT7Olg2stggai58
	tAvA6iB/VoKsk2AQ==
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>
Subject: Re: [patch v5 01/19] x86/cpu: Provide cpuid_read() et al.
In-Reply-To: <20240124200207.GHZbFsv-XjMRGfp19b@fat_crate.local>
Date: Mon, 12 Feb 2024 14:57:02 +0100
Message-ID: <87le7plr9t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 21:02, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 01:25:12PM +0100, Borislav Petkov wrote:
>> > +static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
>> > +				    enum cpuid_regs_idx regidx, u32 *reg)
>> > +{
>> > +	u32 regs[4];
>> > +
>> > +	__cpuid_read(leaf, subleaf, regs);
>> > +	*reg = regs[regidx];
>> 
>> Why not do
>> 
>> 	return regs[regidx];
>> 
>> instead?
>
> Or do you really want to be able to use anonymous structs with bitfields
> in them and then convert them to a u32 * when passing in to
> cpuid_leaf_reg() etc in order to save yourself all the masking and
> shifting and read out the bitfields directly?
>
> I'm looking at the parse_topology() use case.
>
> Looks like it...

Yes, that's the idea.

