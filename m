Return-Path: <linux-kernel+bounces-161433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDB8B4BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EBC1C20D93
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6076CDBE;
	Sun, 28 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQqmfCYC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D90653
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310300; cv=none; b=Y1CmcUhoCGBOFy8hLZqs4BhmREfwhrA5RuWNc4Rlu/lsPxR1+9gw+PmrF0eJl/TnfttaElfj19O64H+1yPv/IyhOA89L6Y8OnFudn7Vogs3TVrC/vsgylXkTNIlA06ViJ0CIi+ucoZpeSbf/LYy/66hoLTL2l0dcexK0Sb+povI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310300; c=relaxed/simple;
	bh=CgfUEtVUVqryBOU20Pw4HvjHv8QjwbFcKFGTsksoSUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBd/beGL2R595/cnTQXge94tivU/ZuTXMfJhVnD1EL0W1GryxSS/UF4ofTM3KJi1qeJXfOh7PqnX6y99TVwpbnAHPrLSFKc4wb2YIphoaC7bqmPNRPmfFtGppZSzMgBSlOT41XdBOHlQ2FQYPIaIVoLTmdWACfwWgBvJS7ZtyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQqmfCYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714310297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgfUEtVUVqryBOU20Pw4HvjHv8QjwbFcKFGTsksoSUQ=;
	b=UQqmfCYCTFUXnyECsueKpM3+LZvAx+UWzew7WPHL+GDmEtYxPFwxsyHA9bnp3CqLm5ipXU
	OSrl1Dx1A9a5C7627/hLcm88MQdUHf4uRJ5cob0zsGW64v6JdFJjcCP7XvFCKtTFlpYTnH
	OAHY9Zi2QOIMuRG/jD4rvikk8E4BOSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ZC-jobWDMySgLHBythwwfg-1; Sun, 28 Apr 2024 09:18:14 -0400
X-MC-Unique: ZC-jobWDMySgLHBythwwfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55E98059E0;
	Sun, 28 Apr 2024 13:18:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.143])
	by smtp.corp.redhat.com (Postfix) with SMTP id 37A2040C6CB1;
	Sun, 28 Apr 2024 13:18:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Apr 2024 15:16:48 +0200 (CEST)
Date: Sun, 28 Apr 2024 15:16:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: Fix boot crash when maxcpus
 < first housekeeping CPU
Message-ID: <20240428131645.GA20436@redhat.com>
References: <20240413141746.GA10008@redhat.com>
 <171398910207.10875.4426725644764756607.tip-bot2@tip-bot2>
 <Zi4FHsc51wNhdSW4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4FHsc51wNhdSW4@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/28, Ingo Molnar wrote:
>
> * tip-bot2 for Oleg Nesterov <tip-bot2@linutronix.de> wrote:
>
> > Another corner case is "nohz_full=0" on a machine with a single CPU or with
> > the maxcpus=1 kernel argument. In this case non_housekeeping_mask is empty
> > and tick_nohz_full_setup() makes no sense. And indeed, the kernel hits the
> > WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().
> >
> > And how should the kernel interpret the "nohz_full=" parameter? It should
> > be silently ignored, but currently cpulist_parse() happily returns the
> > empty cpumask and this leads to the same problem.
> >
> > Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
> > and do nothing in this case.
>
> So arguably the user meant NOHZ_FULL to be turned off - but it is de-facto
> already turned off by the fact that there's only a single CPU available,
> right?

Or the user passes the empty "nohz_full=" mask on a multi-CPU machine.

In both cases (before this patch) housekeeping_setup() calls
tick_nohz_full_setup(non_housekeeping_mask) which sets
tick_nohz_full_running = true even if tick_nohz_full_mask is empty.

This doesn't look right to me and triggers the "this should not happen"
warning in tick_sched_do_timer().

But let me repeat, I know nothing about nohz/etc.

Oleg.


