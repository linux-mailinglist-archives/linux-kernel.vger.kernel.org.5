Return-Path: <linux-kernel+bounces-75175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6485E449
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08A41C228A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010F83CC7;
	Wed, 21 Feb 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="282fANev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9hCIOH+E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A680BE5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535738; cv=none; b=EHUG0ccpc5xrq3Daii2ADHV3+4LnTo9H6Qg0USHvhqt2q/8Hw132yrQaHj5DD2DqMEF/GnfT61cRE9xxJcM8dPgwDTly4+FishCGQ6hwiy12iROBqcgtu710KwgQi0Z6b1dJ88SneOzSmXZiihsDx3P2VOqGVbihocIQRBPTZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535738; c=relaxed/simple;
	bh=aEJzOLDZkrDjd+yeJI7n3WWrFghfvAICj4gUtvCgTg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNrGClCZatGNIOUwL7M+llqKl/G2Lg3nTDGQdyebxJGutQnpWdvF1sPm+lgKkNtdiuMsQGmUcZTeLuwkoB14j1mdcQ94KJh+ZVpGI2EVYdcFf+K54mpg159uXBR/8LJp+hBKDfOkyBulvoUrsF7d504x2+Zg5wx7CNSFeMEDKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=282fANev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9hCIOH+E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708535734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEQdXTfrttMbW4EmfhHm/Pngds+cPmrwXTYctSBfY8c=;
	b=282fANev39NJ42oosNvUau67/CrBCi9X0XUQbjCB6Jl7welrGug1ZjhZZOQXheLi05Km2R
	zVxmjX4Jq7HCMVocH3iF5UOpuN0bZPI974UfhF9P+lVH1ECUb25uJ2WtxoXPK1KNqTHTpA
	esF7Oyyl4UuJ+15+4hfJ7Mwk41EJUKV+aV6O/m52/LRdpHfZVr/yZx8a0hvZ+dUsLDthYp
	uHj5w54b/eXUtP7JMBc8cF/8+nMTi9jNgGjskPhcv4al4U63ygAtIZsJrcM9dagz5gW6JK
	4uanVs+j6RXy3TAlNWZAo3bNjTfU4/OH8NIgixZdyuLE6wYUaeUAjYPsVIIFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708535734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEQdXTfrttMbW4EmfhHm/Pngds+cPmrwXTYctSBfY8c=;
	b=9hCIOH+EEFu8t0DQ9hV0FqH+x6QEPDg7TDA0IIfbmJ7JVlTE7Kx1vKil1lRgEl8JX+/242
	rmQdPouXeHuyplAA==
To: Raghavendra K T <raghavendra.kt@amd.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-Reply-To: <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com>
Date: Wed, 21 Feb 2024 18:15:34 +0100
Message-ID: <87zfvtg2mh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
> Configuration tested.
> a) Base kernel (6.7),

Which scheduling model is the baseline using?

> b) patched with PREEMPT_AUTO voluntary preemption.
> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>
> Workloads I tested and their %gain,
>                     case b                   case c
> NAS                +2.7                    +1.9
> Hashjoin,          +0			     +0
> XSBench	     +1.7		     +0
> Graph500,  	     -6 		     +0

The Graph500 stands out. Needs some analysis.

Thanks,

        tglx

