Return-Path: <linux-kernel+bounces-151016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35C8AA7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F01F211D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B0101C5;
	Fri, 19 Apr 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0KvnlyH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtTpOt44"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F7D515
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504990; cv=none; b=mk5dE0IFwMs9tMXYQRqtF83LvS3VCrijrOgMXOSAL8E4bOdyw1U1Ed6lIEyK2/aghwEuaqHUdukNktxW+d4RKWqR0yNN2pUUm8/Sz3Sq5dqlq4MzI4GJsnntFiqzPEptz+dw49gD3sv/mCaHLFFSYDBZ03yarzM3daiCjq5tMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504990; c=relaxed/simple;
	bh=WWVqZp2+30Zq4b8Ve11Pe7XNTZL8nxWZ0Ar7i6fbXRM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=pQM1psoedH/BjmLnNG0NGSVofabTpT60vg/gJRs/GkU14IRAfZiYbG9eF0SC3TOgZ09SPNPIrlotKsXRVJnZQRYX7AomVVfSKhyXjTQA9YyQFQtZIviFsTKqKM8yOv0ExW3jNMrz8bkXxnhIGQGk7A4sIcuwndS4sKgkqLzqiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0KvnlyH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtTpOt44; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713504986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=lWzBA6aH5GojVMHZr16y2dsdvm+/ZPJut2i3UGgY3S0=;
	b=P0KvnlyHcjiEG0T6RM4o4vUgLyYFvWP3ludf05LOCx/Fnz/Y/FJNl9ddgd9vZLv8EPnjWc
	ldvSqUxZgtStgszT5lMCAsLFVdnKz1YVhkS5LCvJV6GAy1xLNcjBXKHX0IPshGdSvptkIk
	Hgyobp8HM+wwBbPFlbNErHJgk7ZHVz6x31lWbexdcOE7k7l4gJig89/ox2/P6TiDcn2VCL
	t0crriuZlEKbIsq6ZvqyBuVa4mSjRcKSocOpRSx0R3LQU1GA4EBHzPhc6oxGtfLhSDLI6V
	l9Qf0zQ2IjT97ySdU/yxSjtaLh2p4JcZNykeOA9hF1oZ8TF5GR/4QMauA/UieQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713504986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=lWzBA6aH5GojVMHZr16y2dsdvm+/ZPJut2i3UGgY3S0=;
	b=MtTpOt44UWioNiohn7xGlSx0OuIPDwPUNVEDHuFnkpQb5EkE20EMUlXJEo7zxkoQG69bh1
	sUjCDcvnOY88dPAQ==
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org,
 ying.huang@intel.com, vernhao@tencent.com, mgorman@techsingularity.net,
 hughd@google.com, willy@infradead.org, david@redhat.com,
 peterz@infradead.org, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v9 1/8] x86/tlb: add APIs manipulating tlb batch's arch
 data
In-Reply-To: <20240417071847.29584-2-byungchul@sk.com>
Date: Fri, 19 Apr 2024 07:36:14 +0200
Message-ID: <871q71ykvl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024 at 16:18, Byungchul Park wrote:
> This is a preparation for migrc mechanism that needs to recognize
> read-only tlb entries during migration by separating tlb batch arch data
> into two, one is for read-only entries and the other is for writable
> ones, and merging those two when needed.

I have no idea what migrc mechanism means. Please add enough context
into the change log so the reviewer does not have to go through loops
and hoops to figure out what this is about.

Thanks,

        tglx

