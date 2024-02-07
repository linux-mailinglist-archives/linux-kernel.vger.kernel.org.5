Return-Path: <linux-kernel+bounces-56286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7CB84C851
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EA52865C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58192560C;
	Wed,  7 Feb 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qS9+itkL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmscFldW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7441250F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300580; cv=none; b=ItMS617T5T305xdl2a24aMMRh1Ce9yB/4UNMSwf98rcrAnUXzRb26LKO4NrB4/BXiSGyIAGrGakkmCtsxXg5T2vgzWjS2WWAUTv7wlssVgLfDpAYZ8P+LXbVXEBJFfVMhp6dBnKE3ujjOGwtrgUxxoDFzTnYiaoBdSRm9id5Wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300580; c=relaxed/simple;
	bh=7cWIqL+AIo9NrMbiRmTYyymRICjR4BA6HqjzIbR46P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8JERi3IgQQC9CVWVzDzMUvGTggj7/hd2010ErXyB77Yi4JuVA8+LGbCHCJD05nmC0ysKNA9mxcQ50f1Q/4aOtxXTTOb6P41wl0+neGZbXMzLnB6UozFg2Q14/c9XtmlM8oVYYb1tlvf3Fnu9a1MpyebUPX9mHA8vuWpwrJC7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qS9+itkL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmscFldW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707300569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cWIqL+AIo9NrMbiRmTYyymRICjR4BA6HqjzIbR46P4=;
	b=qS9+itkLNVJWa5S3VSX7TMK27feLcw1kNYrg9ieql7hTn5ZQGzzDvYV+0csOmzI+YKQaiL
	goHljjBJUhdjUlxeo+jouMQJe87g8wKR+f8cyR3QuI7vqqCXv2Fd8yG6/3ylMYvipIHlFV
	Lq0mGY1dCWMCfHore6EI4t7H6g9OnPazJSJDOKfYtZBh/bGZX2NymM7i5/R0ZXn9ZisxZB
	PCvNMv5O1hPmzHF5h5RGqcaYCG6cQLnejivuCblICzVpEXokoEq4Gu8gv6M5sUmj68xcGU
	5pfhLiSXpUspbpY8gSm2G8mHBcy6519hc9LCDvmmt8Oh21YQvuBhJKxPmMvABg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707300569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cWIqL+AIo9NrMbiRmTYyymRICjR4BA6HqjzIbR46P4=;
	b=QmscFldW/I7x3UnXzbL7KT42pMtGsUFS6iQ4BlHWhqDznumDeUtnwk6u4Q65dk+vj4m5o4
	4BvV+aZjzjlUXkDw==
To: tiozhang <tiozhang@didiglobal.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
 zyhtheonly@yeah.net, tiozhang@didiglobal.com
Subject: Re: [PATCH] hrtimer: add cmdline parameter retry_threshold to
 config retry times in interrupt handler routine
In-Reply-To: <20240131104152.GA19461@didi-ThinkCentre-M930t-N000>
References: <20240131104152.GA19461@didi-ThinkCentre-M930t-N000>
Date: Wed, 07 Feb 2024 11:09:28 +0100
Message-ID: <87sf24mvqf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 31 2024 at 18:41, tiozhang@didiglobal.com wrote:
> Motivation of doing this is to give user a config option to reduce time
> cost in hrtimer irq when influenced by some time consuming hrtimer
> callbacks running in irq context.
> E.g, if we tune this parameter to 1, we dont retry anymore to prevent
> occasionally consecutive time consuming callbacks running in a single
> interrupt.

Which is the exact problem you are trying to solve here?

