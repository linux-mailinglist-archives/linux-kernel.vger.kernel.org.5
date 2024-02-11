Return-Path: <linux-kernel+bounces-60673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E9850845
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B91A1C20F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC759155;
	Sun, 11 Feb 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=420blaze.it header.i=@420blaze.it header.b="hMsJV+cd"
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F758ABE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707642190; cv=none; b=OsP6DffcISeJzYPqBmmNW2ZNsJySWcYoV5jIBy+94M7nXgotoUa0FNqTsm61e5XCu1G2T62TLx3YhqrZWA7JuywNG+OI4Dk+LuTT0U+V+6xctz3WgAK6nDC2XoOZKVQNbRbXpKx+OwcE1o2xMSqasPPG+P/wYv77TK9wwH8xiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707642190; c=relaxed/simple;
	bh=4JP92RE3t9VQw+D1FzK47Dplx1G0LHGUu6RQVFkBwfw=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:Message-ID; b=fvXgpa7Eu3qC1TC3XA601JqoeUFWF6Fcz7OZhnwn1AuFSZjDh1c0ywlz2EFjgJBZcURtPiWVvEPYB94zhrASCDp63yZsuOEhAavOSBK5DtcXZZTCRXutrq+BcAPMWFau/4TEE9YzDfQTB37B5YeDPDHI7lkEF2zM2tj3JKxbq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=420blaze.it; spf=pass smtp.mailfrom=420blaze.it; dkim=pass (2048-bit key) header.d=420blaze.it header.i=@420blaze.it header.b=hMsJV+cd; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=420blaze.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=420blaze.it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=420blaze.it; s=mail;
	t=1707641567; bh=4JP92RE3t9VQw+D1FzK47Dplx1G0LHGUu6RQVFkBwfw=;
	h=Date:From:To:Cc:Subject:From;
	b=hMsJV+cdlLbcDaSujjO4cqMmMsvrJUoNqsQfRjSojzLMZ46qZ3ObQjTy+e0r3IBXJ
	 DSguVHCkZN5YzxuSs3x3J459wXTVaDMH/xOaN1X60XLT0pB2i6zMCrGDtNrrv27Kc0
	 qyoFNtKvZtIPkEfPog7ks9YgSRRJJtIkF7nZry1yHCOQN7whBk3UCK9uC69QvBVHkU
	 nOPJ7+df7ewpWczoT7/JuOlEI0Qc8SQuKSKuTVq5nuh5ZrObF7ISIURt8rv1g0m6k7
	 UKtO96BWU4Sz4IQVvtPieRJHHt95ulyJuTsHpk8+Xd1ipaB1zZdBeu2dzQvd5V4jXI
	 O71BllM9aJfkQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Feb 2024 08:52:45 +0000
From: hapter@420blaze.it
To: mingo@redhat.com
Cc: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/sys_x86_64.c: rationale for 0x40000000 for
 MAP_32BIT's start address?
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
X-Sender: hapter@420blaze.it
Return-Receipt-To: hapter@420blaze.it
Disposition-Notification-To: hapter@420blaze.it

I've found that passing in MAP_32BIT for mmap() will always return an 
address above 0x40000000. The problem seems to lie in 
arch/x86/kernek/sys_x86_64.c, where the following comment is the only 
thing close to a hint(Line 100):

/* This is usually used needed to map code in small
    model, so it needs to be in the first 31bit. Limit
    it to that.  This means we need to move the
    unmapped base down for this case. This can give
    conflicts with the heap, but we assume that glibc
    malloc knows how to fall back to mmap. Give it 1GB
    of playground for now. -AK */

Unfortunately this does not supply a rationale for starting from 
0x40000000, which seems very arbitrary, and the git commit has been 
there since the beginning of time (i.e. as far the the git history 
goes), so the git blame has not helped much to clarify it. I was also 
not able to find who "AK" was.

I have found another operating system that provides MAP_32BIT, FreeBSD, 
to not exhibit the same behavior and not cause any execution problems 
for RWX pages allocated below 0x40000000, so it does not seem a 
technical rationale exists either.

mmap will happily return 0x10000 (which seems like the lowest address 
the kernel will map when you supply it as a hint, so I do not see any 
reason not to start the find from 0x10000, or something that isn't as 
big as 0x40000000, which is big enough to impose a significant handicap 
for applications using MAP_32BIT (e.g. JITs that want to use CALL rel32 
at all times).

I will happily await for any clarifications on this matter.

- hapter

