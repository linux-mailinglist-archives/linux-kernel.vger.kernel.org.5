Return-Path: <linux-kernel+bounces-145939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0988A5D01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9301C20AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4E157469;
	Mon, 15 Apr 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN8+J4+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E71E89A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217073; cv=none; b=T9kxCMMGeuxDKvyaXLD9HmsHJxU6qxHz0Ckimb4HLGjfjTlCzsPJvLFY+9oNZvYWRVPqZJBqGCsh1jL4YCRC5sjgPkqGOUo9P3Ik+NsCcj1zdD68Xl2SeIgGERwPwP1uCEi1gG7g/C/0XVLIEGM+aEFXsOsnUJLs0BphfR9+iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217073; c=relaxed/simple;
	bh=LrNCRf6AYFBg2yEZSaZLlRRszF2n2/fBOUmVb5nWeIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Exn0fm4JdYlrSPABm6P/nOkb38ClXlh0OsRP5sF5NuNDoiL0JgwVkvS/toV4j93+SjAdmM+T3m3ZhYKyPIrzmIw3McE17VMjn5P2t9MkFunvSmhhTfBZuMBnNm1NkF9GJ9ryatJ4vN/kpidmEL1YGSk1LSAmRuWhh8ALd1RziyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN8+J4+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743AEC113CC;
	Mon, 15 Apr 2024 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713217072;
	bh=LrNCRf6AYFBg2yEZSaZLlRRszF2n2/fBOUmVb5nWeIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hN8+J4+uU09Pyr4W6pLQ8ysqdXa2y6fhx/oeZtqJuxs4g8kAVtNIJBf/ZA0whEE4h
	 cs8861e8+MdxnPvbNf+QZG/VCEKZbp1wena+Dv0TRysKVBKMeoBKlTXRJN86thSh0m
	 23fkZHirRXvv0wKPpmCvbtEF5CSG4xfix1IBJRJkXEYkpl/ploY8Sz/TLUHFced3hk
	 w8SMgidI7tZZL5VNwZ7WEZy+ZcX+oYViqQMHQy9N7KelSVxfFgiRzLSDborqpTg7ML
	 A9B2lGWZvK43kTglk4Eh2VV589MNYO9WP/dCVvpXW+uvlU8tgS/k3dqhL6NwvZCd/f
	 ONssDyobeXIaQ==
Date: Mon, 15 Apr 2024 23:37:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH] sched/isolation: fix boot crash when the boot CPU is
 nohz_full
Message-ID: <Zh2eLUFm3LQvYVtF@pavilion.home>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411143905.GA19288@redhat.com>

Le Thu, Apr 11, 2024 at 04:39:05PM +0200, Oleg Nesterov a écrit :
> Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> include the boot CPU, this is no longer true after the commit 08ae95f4fd3b
> ("nohz_full: Allow the boot CPU to be nohz_full").
> 
> However after another commit aae17ebb53cd ("workqueue: Avoid using isolated
> cpus' timers on queue_delayed_work") the kernel will crash at boot time in
> this case; housekeeping_any_cpu() returns an invalid cpu nr until smp_init()
> paths bring the 1st housekeeping CPU up.
> 
> Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
> return smp_processor_id() in this case. Yes, this is just the simple and
> backportable workaround which fixes the symptom, but smp_processor_id() at
> boot time should be safe at least for type == HK_TYPE_TIMER, this more or
> less matches the tick_do_timer_boot_cpu logic.
> 
> We should not worry about cpu_down(); tick_nohz_cpu_down() will not allow
> to offline tick_do_timer_cpu (the 1st online housekeeping CPU).
> 
> Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
> Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
> Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

