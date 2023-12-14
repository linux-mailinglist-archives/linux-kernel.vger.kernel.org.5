Return-Path: <linux-kernel+bounces-115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13B813C62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044F21F22732
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95713FE27;
	Thu, 14 Dec 2023 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAYVSkci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgZxg3/J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070A2BCF6;
	Thu, 14 Dec 2023 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702588305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSvaVuzRrYUFxbGHasdwEk5ZlSQOIF9rp0WttitjT6c=;
	b=DAYVSkcizitZKRh1T9LSbw+7SfRNAUkpkrOKx9CAflfTLt0Mo8rXNrXojveiRlRYUiRz21
	JbY7gGpDhSBHFssQv09M7R72LxhRQWyTziNFCJWLo2L1yyQbTT0/YZ/AM64+AXtLYwEbiY
	zemeXy9ZVTt1hUsOC1IdKtg/fRYPCiZYK+CyDh6EqlLZiYJj+Gw8KcFnNb8+u6TLLblGWd
	1yoZ2WJ5PLi05gPG91LFICnD7Ict0/vYV4ZQs+aU78sTpY4p+gDNMRjZv8LwNodzxmuFaS
	/+7fIKMa9elxkJJog6YEbSu+KnLwT2+HuJ9jU9j4jxLyL43A5jh81vvx3WDMPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702588305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSvaVuzRrYUFxbGHasdwEk5ZlSQOIF9rp0WttitjT6c=;
	b=KgZxg3/JgA/dzaNvOMsoOVtanpDB76qq/4Zsg5RJ3YQp8QxNAdUWwJftOYi52FlYOdTtDB
	IHv+ND5Htc/jB0Bw==
To: "Zhang, Rui" <rui.zhang@intel.com>, "jsperbeck@google.com"
 <jsperbeck@google.com>, "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "andres@anarazel.de" <andres@anarazel.de>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <378afe31b40b94fbb9096832bf47055c27fa8638.camel@intel.com>
References: <87ttonpbnr.ffs@tglx>
 <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
 <878r5yp357.ffs@tglx>
 <378afe31b40b94fbb9096832bf47055c27fa8638.camel@intel.com>
Date: Thu, 14 Dec 2023 22:11:44 +0100
Message-ID: <87jzpgo5f3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 14 2023 at 15:00, Zhang, Rui wrote:
> On Wed, 2023-12-13 at 15:51 +0100, Thomas Gleixner wrote:
>> The topology evaluation rework gets rid of this return value
>> completely,
>> so I really don't want to add an dependency on it.
>
> Great to know that the topology evaluation rework is still in your
> plan. We have tested the latest version and it indeed solves some real
> issues we observed, and I'm willing to test if we have a new version
> posted.

If I ever get a breather :)

