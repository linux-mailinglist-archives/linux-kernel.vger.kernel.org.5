Return-Path: <linux-kernel+bounces-138818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C189FABA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E211C2185F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210ED16F0E2;
	Wed, 10 Apr 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOHWODub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nTBZ53J9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70716F0E9;
	Wed, 10 Apr 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760878; cv=none; b=KmyZCN+MkgmmENormbkWKc8fnsfLhH4uc+e+DszH0EVZYKwXOgXls0PLZFkBY7/HlCapIivlm2RmVqcjOw7nOoSae+SNDN0pCG0zHexLM+6z5RQ2GsGocKOgsOOszx/+aAOQKEs6P9naromiVBcswHXWHEDbIPbwp6ZYdwq5r/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760878; c=relaxed/simple;
	bh=/wL+CsvkkMwaJAgDAaETeMNQO2L94tEPin5keiX6FVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+zyQLZaUP62S5rJTGkVi7m8xyAWdviMbIrhPEyy4xwHIIuoeGRzRnKAScGMZBRNbjTVzBW0MuNOKtLwst4hq+Y9xKrJg/DrqeLFLO4W/VgdOHc7n7HmOS+ImYoPG3/Jri66yfGNJFI0V3LLx1P/DLQ1IsPgXi+4aE9vTZ62n3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HOHWODub; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nTBZ53J9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712760875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5hhICO2Tuhg0O6s88ESY/Px6fYRxYIzb84iKPTZhY8=;
	b=HOHWODubEITQQy3ny2ZVhXd6g6NzO7iUD+DlfezqL527zz9sNlX5C4EeXhl3z5dnq953pN
	Rh3DlWxW3rGzM2jt9GyMvfWsUxUTUvfPGzr0v4aMq+UJ3HZ+POAqv/meIyfFKbsrjuLx0U
	wKUAJEm6OOCa7lRatmhCcpns/6Oo1GwDqLn5jXuAGi3KOHbElrsHoVVPDhODOJUcL2gP+S
	6gv/v669zCCwQk5YYiH/kapgxHFAYF4baJ8Y3m+dVm29oCjATORrrf8PCQ9sFffaIuNpQY
	lemqb4oDnpP5R+SlroGgZvHeescbyQfQHz90gtChXucecWrKhpWa/hocdHuO/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712760875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5hhICO2Tuhg0O6s88ESY/Px6fYRxYIzb84iKPTZhY8=;
	b=nTBZ53J9KKuTdWfMwgMlw5koSi2TGSLNr4GdPzI2reBz3Hwi0aVi95nuITyo9TKaI8afA2
	Dzkji7/LaDwsV4DA==
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, Sean Anderson <sean.anderson@seco.com>,
 x86@kernel.org
Subject: Re: [tip: timers/urgent] timekeeping: Use READ/WRITE_ONCE() for
 tick_do_timer_cpu
In-Reply-To: <ZhZKiKyXsgSeABvD@gmail.com>
References: <87cyqy7rt3.ffs@tglx>
 <171269748856.10875.3911619468870441338.tip-bot2@tip-bot2>
 <ZhZKiKyXsgSeABvD@gmail.com>
Date: Wed, 10 Apr 2024 16:54:34 +0200
Message-ID: <87y19l2rpx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 10:15, Ingo Molnar wrote:
>> @@ -232,7 +233,7 @@ static void tick_setup_device(struct tick_device *td,
>>  						!tick_nohz_full_cpu(cpu)) {
>>  			tick_take_do_timer_from_boot();
>>  			tick_do_timer_boot_cpu = -1;
>> -			WARN_ON(tick_do_timer_cpu != cpu);
>> +			WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) != cpu);
>
> So there's no such thing as READ_ON_ONCE() - I've amended the commit with 
> the fix below.

Can you hand me a brown paper bag please?

