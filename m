Return-Path: <linux-kernel+bounces-61999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63818519CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247C71C2203A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9048494;
	Mon, 12 Feb 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZJVUbtV2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8gIZXnR5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5A3FB1F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756056; cv=none; b=CmTYTe1FxsTJh9QXSUvsRV4oezaeDKi3f22k/11f/JtjB8Ku5rjAkbWVwbzYT8CpHJ1G3/TNtx0zXv49/iI9xs62zGxyTtL4jm8WefmB03LfONzpLo5P8HZw7WWN7GdzObWKd2FlIwmM95u8uyg7mwTGR48iPWhDV+qEYdkug3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756056; c=relaxed/simple;
	bh=yHx9btOFGYnx+HbYbVOZNhA96GXQPGCwiMAQ2+tOCig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gh6KwCkrLj/YPsuHmQ5cCzGS+Kcq39cssFZ5qZegXGKqBz5/j8gaHUk06shaa59oEhqemkAAb6MBKdKDYjaO74nys0AMILYYQhtvJPnruG+uxXMMfN24LLl21vZBypcaN47LW7+eKi8eNo7MkdXdTwE1u5+Yqk5247YzXOAnBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZJVUbtV2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8gIZXnR5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707756052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4Cjg5Perng8D2lFlhCaxnNUlZMDjAMNQP/UM0aHvBU=;
	b=ZJVUbtV2otuFE8CO3JRHrKMNqvbGt5LRHtT/tq3AT9tRZsiBtANd1FlqaWaS1wv3nH72dm
	bkYUUdQWVZYAKn2Pxlx1/DycagZR095vdsz1skhXBMjLKf9xKFVvZhIUceD1sZjGQV51Mb
	Gd9E/8AE/9HG56ROL7EhOVhFTi0/bI8ciji5WA/0suL3QpkWxKEHiOFDUlUqZmhYhWZFXT
	jPEWe3gNqnyskir71gFnZYnCyrxoZ+4R450z94BBoAeqkEGysBgKNrHT5HrhuwYFt+yz2L
	WHzD+c1Z0Dg6sslFA1yacH8Vqy/61HKXITteRFkPHTTLoGhxL1frW4dT7KfjHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707756052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4Cjg5Perng8D2lFlhCaxnNUlZMDjAMNQP/UM0aHvBU=;
	b=8gIZXnR5qpumh7ghxTDtBkuN08pSh2NqValJuKTEdIue0BG/CffY8jMehnn/29DBUF/hve
	zm4ippMuxlrxqjCQ==
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "mhklinux@outlook.com"
 <mhklinux@outlook.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
 "ray.huang@amd.com" <ray.huang@amd.com>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
 <dimitri.sivanich@hpe.com>, "Tang, Feng" <feng.tang@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "jgross@suse.com" <jgross@suse.com>,
 "andy@infradead.org" <andy@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>
Subject: Re: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for sizing
In-Reply-To: <87fryjhmjs.ffs@tglx>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.739960607@linutronix.de>
 <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
 <87fryjhmjs.ffs@tglx>
Date: Mon, 12 Feb 2024 17:40:52 +0100
Message-ID: <87mss5k54b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 26 2024 at 21:22, Thomas Gleixner wrote:
> On Fri, Jan 26 2024 at 07:07, Zhang, Rui wrote:
>> Say, on my Adlerlake platform, which has 4 Pcores with HT + 8 Ecores,
>> cnta is 12, cntb is 16, and smp_num_siblings is set to 1 erroneously.
>>
>> I think we should use
>> 	smp_num_siblings = DIV_ROUND_UP(cntb, cnta);
>> here.
>
> Indeed. That's more than obvious.

I pushed out a new version which addresses this and also the fallout
Michael and Sohil reported:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v3

I let the robot chew on it before posting it in the next days.

Thanks,

        tglx

