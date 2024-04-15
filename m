Return-Path: <linux-kernel+bounces-144952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788608A4D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1959E1F22A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB85FBA1;
	Mon, 15 Apr 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PbSFr24D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAE5FB82
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178754; cv=none; b=Ajak6BsESBtfKsT1xYVFkq+4CwfZqFkt/sVrJLeGVS0lnLg178jaegJeuFy+E4oVAZjMhoIoN6ZUKSsoTHBpbSVup2ccDWiv3npCKCxz4SmWLHy050IABcQODwU2dBexS1KhtQUM2nZ1n7+Zb8uOym1xON49jqKoa6I5Ec0FFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178754; c=relaxed/simple;
	bh=MDxynuU4+UuWKScVgW9vlzNQ6RFxBEaz2sIhu42e/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxBkSH0W6Mr/d+aB58f2o1zdC/EgcuaNIkew+Nv+ZOOwfP4mSr6qVLveFEaTHmK7mCRuYOXPXJnuLB84Kefi45vez3uoBiSjdnN4UYGhYl0Pfx0nbPNLoV+yoDjJBR2gs2lrxR0ZPneS25Isw1S1i+BT8+l4xgu+bo6RwQsSW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PbSFr24D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JwGAP2rr9BBl+58DYDCoQZsQAutUxZJU5nYB8humZ48=; b=PbSFr24DDLlw6JL9iQcEyEZYU/
	hTNI+WXjb/Bzna+bYoQTK6UDqp+gpHATnjJPhEShpT1QMOVB2bWeFJCUbQMOzoNVsdNoyTxAHblw9
	sBuipW4OD5P6Uk+lv3A42oKuLPpsY/gOweyyuOnZODszWd6SQTXrHGF7tGmqrNNKf+a3F+A6ANZFJ
	d/DLq8+wf4FTFVNX3ZuuYwcUv0P7R4KSw2HpoJjrVN13MSsIErmXhK0ZEoYZPMT1ZOad8Z1wJwFll
	fJZFeOT4a5a+3jZch+TNDsl01Y7MdKjxOzRMaGj42Oh/aO3p/vRFWL89WfHfkXqOhz7p9Z9iYTDrN
	bJhdBmmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwK3I-0000000FXeY-0wK4;
	Mon, 15 Apr 2024 10:59:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D81C430040C; Mon, 15 Apr 2024 12:59:07 +0200 (CEST)
Date: Mon, 15 Apr 2024 12:59:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	yu.c.chen@intel.com, wuyun.abel@bytedance.com
Subject: Re: 6.8 to 6.9.0-rc3: kernel NULL pointer dereference in
 pick_next_task_fair+0x89
Message-ID: <20240415105907.GL40213@noisy.programming.kicks-ass.net>
References: <ZhuYyrh3mweP_Kd8@nz.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhuYyrh3mweP_Kd8@nz.home>

On Sun, Apr 14, 2024 at 09:50:18AM +0100, Sergei Trofimovich wrote:
> Hi kernel/sched/ maintainers!
> 
> Over past few days my machines started OOpsing when a nightly kernel
> build starts. I don't have a reliable reproducer. The builder should use
> `idle` CPU scheduling policy.
> 

Thanks for the report, some of us have been chasing this ghost for a
little while and so far it has proven elusive because it's very hard to
reliably reproduce.

I'll go try with your approach.

