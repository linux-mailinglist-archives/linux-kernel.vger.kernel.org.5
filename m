Return-Path: <linux-kernel+bounces-24600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372ED82BECE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E611F259D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12F5FEED;
	Fri, 12 Jan 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOuoPt/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UE4ej+PJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9059143;
	Fri, 12 Jan 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 11:58:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705057118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcDPupKIRzXbxwgij2GVnfAkg467ozmzxDLRD9VH7oU=;
	b=rOuoPt/HVkANoi6MITGsf0GCFh3cmJggz4jgwm0+38Ex7+R1ZajHhrPwt/ITIM/qoO/H6p
	/FEa4uFCdOCUnmRnx/BFdBr75S6LvCukP0aTRSd+ebb0NuZ0urjYA3FataIaWqtzvjDV1N
	co/7eZtzyCTFUQjoV2XlKmCsFsvTqudku6xatxNWokiuLfaJMD55VyI/3grGOKewz2P9ni
	C7O/K/xOLHa3CxgagLBw+tuFv28gU/kng3Ug4WhOKKeSQfrvxPOQ+kYsm6x/bbS++Jn343
	IAyYJho6rcoJDvPADg3PktmCFObfzA5pCJdgCveRh1JXP3Yuf5FQ+E+uqcoh8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705057118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcDPupKIRzXbxwgij2GVnfAkg467ozmzxDLRD9VH7oU=;
	b=UE4ej+PJFqrYk6kHF8YRJSYdOczdRnIdOtMAphs6IQ4o9qDWXPlMT/IeS0i26iG3lS+lMz
	fJ1JTp4b4Yj0lFBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 04/24] net: Use nested-BH locking for
 napi_alloc_cache.
Message-ID: <20240112105836.mVtRB2us@linutronix.de>
References: <20231215171020.687342-5-bigeasy@linutronix.de>
 <202312161210.q8xdLxsl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312161210.q8xdLxsl-lkp@intel.com>

On 2023-12-16 12:43:23 [+0800], kernel test robot wrote:
> Hi Sebastian,
Hi,

> >> net/core/skbuff.c:302:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@

updated the guard definition for that.
Thanks for the report.

Sebastian

