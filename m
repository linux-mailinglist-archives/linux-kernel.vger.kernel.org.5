Return-Path: <linux-kernel+bounces-35450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A009083915A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5861A289D34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B655FB9F;
	Tue, 23 Jan 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJgsvDlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B95FB80
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020105; cv=none; b=HWpd3CHFRq91iWvqWfc5QohBbMhB05+Kv3kdiMI9ZpLgRxEl16fqqgzOdOBPWBEdfXm/2ikYey6xZ6BcwCt/M5fkxrCC7QsntglQACQhVUfKhd6fmFV+QnBlGqaMopz6bpRkagEejR8ZVcUiV+2cpf4W0nul30BSVU0yYGxTtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020105; c=relaxed/simple;
	bh=dQvJ3trJKh6QJTOvlFIaT7wJidG7USkqz/e9KfMNZZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsX3HuBQvYeJebBBoOUqQOmodu2qYOqmS4qc/RKCFC3KVUTvBLEXdMPnlSixH86XtgVrgWSBThgfnEz1c8p/nq+b1CagmLGgZHLFUl7r4YoVamjS8x4Suige1cHYGZF+EQgsFE38f6goKUqN2uQhwuwjJEr0hC0VlYpMglHDRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJgsvDlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308B0C433C7;
	Tue, 23 Jan 2024 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706020105;
	bh=dQvJ3trJKh6QJTOvlFIaT7wJidG7USkqz/e9KfMNZZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJgsvDlrR0L7rBDTDrZpZP4W/4waRexkAQjKYcmboD46l74DG1hOEPBIn1EznpmJi
	 lEXgm73s7JY+M/XNc+3/aaKTAty6TA4dhxektMXSnsLcLbtSgLMypEffYdYfz5LTZW
	 aCUKUQ5O6egZi/jdVXJSJfle91cP6OV/wXZbNSSRRL9P/bifapX1gMd/5XYanmVOlj
	 Na2y59Omhn78a3wiI7Zf12125ezpSpIqfqjwyV5ONUJXjOht4+MlIfUKqlx4Og4cjd
	 yacpT0x/F6dRK/qehDtY4xF4V4osPRkP2gfxMm5eztKbMzSRQb2bINQvd1sRsKjDxp
	 ijqlr2jg9cr6w==
Date: Tue, 23 Jan 2024 15:28:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 09/20] timers: Split next timer interrupt logic
Message-ID: <Za_NBvkvejwhtWjp@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-10-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-10-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:32PM +0100, Anna-Maria Behnsen a écrit :
> Split the logic for getting next timer interrupt (no matter of recalculated
> or already stored in base->next_expiry) into a separate function named
> next_timer_interrupt(). Make it available to local call sites only.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

