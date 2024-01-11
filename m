Return-Path: <linux-kernel+bounces-23885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562B82B333
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488928239A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9D5100C;
	Thu, 11 Jan 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLBbjTqf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0DtS3D3K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6D51004
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704991461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5r2dpKzpPM7p1IXawUf2NKSUect+eJPGZyCSRkJeR+w=;
	b=pLBbjTqfYeZKMJIOpBxdPF8AmHue55yIWh+sKk/Vl7etEUamXc2AtCVAoy06QosuBsZNPx
	2G6Qz/fDljn/HCtrWKz1SUT7LwY8h2Wct5zBhVbYAvSlxAC9xezLtWGuCEjD8Bm+ENIwlk
	dTBQDTsuu/nKW61+0drAACpMpY5IEmTXLnSq3P1RgCOc+yu2F9hrBbTc4HlawXL5j0eXIB
	jVNu8ixYURO77ciqUZYq0KnmM6+RrDKjNj9VgGLtwsAVrtMIv/+DiwDYrTJyHcENI8SUmL
	PkAVLeiTCgt7/8eDoa8myV2XfCqptz/G8OSqGR5YAtwPSEWjeBG9IypXuhngPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704991461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5r2dpKzpPM7p1IXawUf2NKSUect+eJPGZyCSRkJeR+w=;
	b=0DtS3D3K1UyP/rJDCCki9/PxbCVmMafero+bm4l437NE3e5l280O85JPXATI8lzjjoIO60
	K4NWpjGtzooEERBw==
To: Lizhe <sensor1010@163.com>, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, Lizhe <sensor1010@163.com>
Subject: Re: [PATCH] hrtimer.c : Remove redundant thread state settings
In-Reply-To: <20240110141349.52718-1-sensor1010@163.com>
References: <20240110141349.52718-1-sensor1010@163.com>
Date: Thu, 11 Jan 2024 17:44:20 +0100
Message-ID: <877ckfkefv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 10 2024 at 06:13, Lizhe wrote:
> After a thread is awakened, its state is already task_running

That's correct, but please look at hrtimer_wakeup() and the conditional
schedule() invocation in schedule_hrtimeout_range_clock(). You break the
guarantee that this function returns with task state == TASK_RUNNING.

Thanks,

        tglx

