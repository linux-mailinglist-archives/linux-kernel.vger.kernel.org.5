Return-Path: <linux-kernel+bounces-48547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9D845D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C48B1C255E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E105242;
	Thu,  1 Feb 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+1RKOYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C004C67
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806050; cv=none; b=UPHvutCYVJgWur4n/025eC3ob/ifzMbWFPL9nD9A+R1adcAeSii06+AgppZXhjo3o/toudn52Vv1Gil+dmfRoaRF/7WoswMvj37BjO2uPFJvPLDrVxBfb7ZWsS69aA8l0jBGz1vJR77wxw12vKCEipRJJ9b1+cWkziw1mAkKrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806050; c=relaxed/simple;
	bh=zAH2uQqL5Ghvi4qHjuvcOGK8ukNTqNE0n+POJg40rI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu41CWXGM/h3Yl6yLn2T0mmrJyF7GPplo5z1iz/tcWl3v4yMsn4NsRmJ5B56nRTdj+2YdKejcHZb+4+VltuhjFGT63rxGwtmu8e3v7DN9qJ+KHN1hzb/h+T9uabdjuJHsDfjRUOyBOx8oM4UMl6+MFAQv3kKvfk1sDcCX3YfmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+1RKOYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64058C433C7;
	Thu,  1 Feb 2024 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706806049;
	bh=zAH2uQqL5Ghvi4qHjuvcOGK8ukNTqNE0n+POJg40rI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+1RKOYH2OinbbPvsqgtrjbqENkTGpctjpJWlbLkP/L+k+rXffMuHkrK1dGXfSFmf
	 xG0nOq8qfbK9Q3Z/5Ikk0pF0hTF6aPfh35ugHSG/1sV2qYRCyclpNuhqQX30FrLR+U
	 VBOAhqQnqJmXdRNS0RoZasUxd3j9Qcvd3jA2gMGK37G1Ox1i1ApwLsyAQygL4Lkzze
	 J5vTs8+KWyQSGJli5C11lJt0jYDshY1w2yanFwsfaURaKeQcxJnVD5MIL4ITL/vylz
	 qqa6/CHAzYEXq0Zc8WJcq1bl9T/xSfy5eUXYPtvv5cDTBAZue3Ctt5C+JtFnYOQVyx
	 I+ymF5YcjY1OA==
Date: Thu, 1 Feb 2024 17:47:26 +0100
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
Subject: Re: [PATCH v10 19/20] timer_migration: Add tracepoints
Message-ID: <ZbvLHnigSf1NOZ5M@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-20-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-20-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:42PM +0100, Anna-Maria Behnsen a écrit :
> +TRACE_EVENT(tmigr_connect_child_parent,
> +
> +	TP_PROTO(struct tmigr_group *child),
> +
> +	TP_ARGS(child),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	child		)
> +		__field( void *,	parent		)
> +		__field( unsigned int,	lvl		)
> +		__field( unsigned int,	numa_node	)
> +		__field( unsigned int,	num_children	)
> +		__field( u32,		childmask	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->child		= child;
> +		__entry->parent		= child->parent;
> +		__entry->lvl		= child->parent->level;
> +		__entry->numa_node	= child->parent->numa_node;
> +		__entry->numa_node	= child->parent->num_children;

__entry->num_children ?

> +		__entry->childmask	= child->childmask;
> +	),
> +
> +	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
> +		  __entry->child,  __entry->childmask, __entry->parent,
> +		  __entry->lvl, __entry->numa_node, __entry->num_children)
> +);
> +
> +TRACE_EVENT(tmigr_connect_cpu_parent,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	parent		)
> +		__field( unsigned int,	cpu		)
> +		__field( unsigned int,	lvl		)
> +		__field( unsigned int,	numa_node	)
> +		__field( unsigned int,	num_children	)
> +		__field( u32,		childmask	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->parent		= tmc->tmgroup;
> +		__entry->cpu		= tmc->cpuevt.cpu;
> +		__entry->lvl		= tmc->tmgroup->level;
> +		__entry->numa_node	= tmc->tmgroup->numa_node;
> +		__entry->numa_node	= tmc->tmgroup->num_children;

Ditto.

Thanks.

