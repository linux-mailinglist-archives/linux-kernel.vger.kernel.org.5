Return-Path: <linux-kernel+bounces-146698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FAB8A6980
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B8E1C20DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855312882C;
	Tue, 16 Apr 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MnC69Yz+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA0128820
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266282; cv=none; b=QHdJLMj+hrQmt29lCMPtE+dnzEAp8EBXGSsiDdXXyYz9tDADHkzY4EuSn8GIQBiy16k2ksg0dDh7j3f1MaKJq43O3WcMBIseWOaUIyRYHhKrcqkBQp+LXqsgVIagqQ3vLjoe3a3EdpIVzq/5ARSgI9jDL5+kozQRUxQ/AS73V3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266282; c=relaxed/simple;
	bh=duFrP0x3+qNKG3tHLlle3sc6z5Hv/xwPHlK3OcIV2F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL8fBCT13a5+dbv/XfoEZSjIAxWhYvKeuqrNDKBQ+3FQVaSOXLuWDf85Jg+vPeDPKScZuEE1YIZpZ7SfWISezeyLUZ8yZ8inkg1cQpLWmiY7kvO+hau0tr1YYIGAF2xM6pA4w6FMVckLuIFAqONSXdRGjsRR8DxNu9iVUnflIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MnC69Yz+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=duFrP0x3+qNKG3tHLlle3sc6z5Hv/xwPHlK3OcIV2F4=; b=MnC69Yz+ffXS32fDmSHhEEtzGi
	uWCzvG/izsTyQ9o6+MJEEC3oewhucbyLwrVCZB3K3rAtGXzpPpG1j7vHmZDWOJfcil6bw2CxOU08J
	u6mCZ588PSMIUAmtbkj82TizUTUJnzKJPymi/He1eHQTcqQspgM8ZfFhsvc8x5j7faZZuHqVniC85
	iG/nMiO+JHu8pJ66akDNPt1mDBQhR9dVCProDP1aMrM/ll7enCO7rJsg+LPAQ/UhUyDcN3BYae/5+
	v4DW1kvoGx8Od97MXsm6OJyWf+J3+ax1fhBw4jzU5GX7S+UQpvrYxJO3lb6vVl/wRlzIbLQvzHwyj
	GFVTJbeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwgov-0000000B2oH-2MEV;
	Tue, 16 Apr 2024 11:17:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38E5C30040C; Tue, 16 Apr 2024 13:17:49 +0200 (CEST)
Date: Tue, 16 Apr 2024 13:17:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v4 27/27] lockdep: Mark emergency sections in
 lockdep splats
Message-ID: <20240416111749.GM40213@noisy.programming.kicks-ass.net>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-28-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-28-john.ogness@linutronix.de>

On Wed, Apr 03, 2024 at 12:17:29AM +0206, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> lock debugging output are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.

I am confused, when in emergency I want the thing to dump everything to
the atomic thing asap.

Storing it all up runs the risk of never getting to the 'complete' point
because we're dead.

