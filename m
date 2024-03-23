Return-Path: <linux-kernel+bounces-112470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABAB887A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BC0281EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FFB59167;
	Sat, 23 Mar 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yddHpm+x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqvzGfGy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033318E20;
	Sat, 23 Mar 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711224321; cv=none; b=BY9twsYMToBMsrer52V6ydywEVQzknDNIBcqwddwglTkbsIhP1oU+Voo8+u+f/v3qilfaJAoCDBhlz+To17Xs3cqOkdY7SnykdlvRZTcwWLwy4F8OqU6rZjvrBR5GQmfyDuhhFe9H4Y9OOk6wyxWetGaIHYDZFC5hUq7ZHAkYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711224321; c=relaxed/simple;
	bh=upuZnzT8aOWZK734xhR2B21P63h5U9ql/DJ8dcXmRSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqP9Rq6ZlHcqU8r9bqhSvtcw+ZuCmSsv+qD32tyLpcibBzl6kwcRcyQKQCHY4zRGCfFNFmTB1uiiKd8hslbwC7b5qSUobguA8fr91ciDFVXHoetxb1obU8BdsQCUbeEpQIZuXOsKDdhEXKf+aBLiPbHMtjxEvE414iimpEbSlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yddHpm+x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqvzGfGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711224318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdDet6KtuaahptjfgPKR+KD91ftph6T4F5W1EFsslQs=;
	b=yddHpm+xaMoArpJAtlEjYhCNOjY7vHgDQWQjQnGPu2Aygfx/hYk9+2S7y6g0BZL4ZMaN4w
	Ld11vbnxj5UDr2C5rmJw2noemwGxX2ryP1nKMy9gQjg4mIuJdIl2Kv1m/V7yaFUEyYRNtS
	jIZkW643UnyFsvB4VDKL6/N69/Z31o/uWud6CIgBloc/NLDES23J6WTCv+0blXVnM4HWV+
	W98/jrrnXIvlK9kDHjnnjb27WDNxERTlqhtth4D5Oq19uLiPI9mBdwqoaOWLbkr1qDmfo/
	ESvHOckaUruYoguBKg7kul63VRE6V5u9LhUkLztC/Es42AR0uHu0ljqx2UPSbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711224318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdDet6KtuaahptjfgPKR+KD91ftph6T4F5W1EFsslQs=;
	b=xqvzGfGyd9lVzjpQcBopqx0CW5LwkyhUVtMg7uLOgQJig7Vfth87AI5Ew6gIin6vfe7Sxl
	eMhC/u+0vIfGatAw==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Baoqi Zhang
 <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
Subject: Re: [PATCH V3] irqchip/loongson-pch-pic: Update interrupt
 registration policy
In-Reply-To: <648e7f23-a2e0-ce8f-7c52-3bcda262de86@loongson.cn>
References: <20240319124629.23925-1-zhangtianyang@loongson.cn>
 <878r2di3ak.ffs@tglx> <648e7f23-a2e0-ce8f-7c52-3bcda262de86@loongson.cn>
Date: Sat, 23 Mar 2024 21:05:17 +0100
Message-ID: <8734sghfya.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyang!

On Fri, Mar 22 2024 at 18:14, Tianyang Zhang wrote:

Please do not top-post. See the 'Top-posting' chapter in:
https://people.kernel.org/tglx/notes-about-netiquette 

> Regarding "WHY", my understanding is that a convincing reason is needed 
> to explain the necessity of this patch.

Yes.

> If so, can the last paragraph "This will be more conducive to fully 
> utilizing existing vectors to support more devices."
>
> be considered a simple explanation?

Kinda, but ideally you describe it in a way that there is context for
the reader. Like this:

  The fixed mapping between the LS7A interrupt source and the HT
  interrupt vector prevents the utilization of the full interrupt vector
  space which limits the number of devices in a system

  Replace the fixed mapping with a dynamic mapping which allocates a
  vector when an interrupt source is set up. This avoids that unused
  sources prevent vectors from being used for other devices.

See?

Thanks,

        tglx

