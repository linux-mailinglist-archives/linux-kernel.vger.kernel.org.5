Return-Path: <linux-kernel+bounces-149293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3F8A8EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416941F22081
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334083CA0;
	Wed, 17 Apr 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWxMOwye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E18172F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394238; cv=none; b=qvI/85XJNGo6vgCObl6Uf4XNF00ISHgmHV0NZ9/9ZST21cQWjbrXh7YKTntdJT8njEzTaah4w+hLHSZ50FqwMGeJu9nODBQO1mp4MbNgBdM+o4ifvzhZ1DKInExPbz6KKXk/I2KXvbB56cOPFHvQNqo5yXrv8y1QBy05ExDTv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394238; c=relaxed/simple;
	bh=ctEO9HzoI/WqLYY4Pdx9Tvx1u89nhwwmg6io0AotnrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8J69n7Qh9QOZT8k+E+7k7bfrh7WpyaoKQ2HwT1mzcVM9h+B5aBqyWZBL6r6duc+NT+KEz3cs+f1AH7ifKBfHFZKoIgtnJDXcIUBv31RAm1Kr3EsyqlBZ1hqnevn4IM4C0kSns89bY68/xcff7n6gtq7+/4NNJWBF2IckKZVBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWxMOwye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EA2C116B1;
	Wed, 17 Apr 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713394238;
	bh=ctEO9HzoI/WqLYY4Pdx9Tvx1u89nhwwmg6io0AotnrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWxMOwye4/PxEWBUvLrBlrL2Fh2P92hza+Nq4e2/fZAj4v0xhYq4XYNrgBA2GPIz7
	 wOPFmpvaLIbX9G3Vns+WgarT0nWP9JU2MniguAGun7YuuwLv77V72Zu+Dfmxwjv+fz
	 vZDEzKYZIP3yfy7nWDgqlCiPG8iWPj2/0Zk0A4ApOFFFxk3Sn50/wu7+RC9yRaLRm2
	 XOLuaWTEvPamIyC+1JRaw67DhShX5blq7Rt7aUHXtKFlbkqYOIkJhfnekfxdx3YlPx
	 gJtfLxwrg8RaQWxyppU5OxHeGhzq2OgisgD/QIN+7XGyv1uqBLeb2Kb9tBhSUAYJHT
	 VvVn1kMBYC5WQ==
Date: Thu, 18 Apr 2024 00:50:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 09/50] posix-cpu-timers: Handle interval timers
 correctly in timer_get()
Message-ID: <ZiBSO27fUvTEZMPT@pavilion.home>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.507566619@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410165551.507566619@linutronix.de>

Le Thu, Apr 11, 2024 at 12:46:27AM +0200, Thomas Gleixner a écrit :
> timer_gettime() must return the remaining time to the next expiry of a
> timer or 0 if the timer is not armed and no signal pending, but posix CPU
> timers fail to forward a timer which is already expired.
> 
> Add the required logic to address that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

