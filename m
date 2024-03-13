Return-Path: <linux-kernel+bounces-101483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC387A7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16651F2424B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C241E891;
	Wed, 13 Mar 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEVM4V/R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nUP9+ZOx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E394416;
	Wed, 13 Mar 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333572; cv=none; b=Ql/FfkpRT9iciuErEG0fwnNuvGvtCCmsr87Mq0wwtDB0VXo3Yt7LeCYUWRcs/6cA5n4fe9jqKLpSXf80b4WmVZGxaZigJilK8uNqXaWRVGH7gxkZ0XiDZhp6WOGNi7KMoPD1jy6lGlunhNIfMkWwUfXCH6ibQx55jJV+IPEvQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333572; c=relaxed/simple;
	bh=NFM9gcOH0xSx5epNsLrj556RESBc3LI2P165z8F1sQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwfrSwliVHXWQWR1+whob8uHxHcHwfKLtefVTZTlgf7cKBCp+p6WnrMkTtZwMdfTyC1fCZeBanTNxdO+Tn5y3hOwgWTPXZHB+kpub2zzOgUeqws7WJaosDeh59UsbH92A0Tlc4PomzCT5+uCx/xFooieot67rrPOl1EYe8WmFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEVM4V/R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nUP9+ZOx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710333569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFM9gcOH0xSx5epNsLrj556RESBc3LI2P165z8F1sQw=;
	b=mEVM4V/RscEpbePLHNjcRF2vhiHSlwRBWiNAVRD6+1LY8CF9P4bahY/q5cwl5HaM71XAPN
	sHs7t53//FVLxWHI5hU/iOdzywAsnZ2u0SG0+bqqL+T1dRv+EyJQM9AcNgNHJW0YwVW0R1
	wurNXkEN0RgT/5rPiFf9pnGzSFWy7DlI0e7nLS8CW4sX6Fx4YrC4hIZNFTdPPgJRqqpIfg
	QRKiBJzIUYq0hIxD1Qgw5qRSnVKBR4TcQS9MX3jAR40/zVkD70ozAPMJnxrfi65oaANM6c
	WXkeXDoyKndVo0+jnYNkeFo9vMdVBjFCTMlhdROlV9B8ApyrOAVR/7XOxa9fNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710333569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFM9gcOH0xSx5epNsLrj556RESBc3LI2P165z8F1sQw=;
	b=nUP9+ZOxwaDNLyrRw1e2GJAc6Eq1xLjh18gtQVTa6Y0ohAVO8icHSH9XvgMgqcNzKJRvrw
	PNpeFEu+cogSMZDw==
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Shtylyov
 <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
In-Reply-To: <CAAhV-H6Qqz54yQ8uehjx+jEhwCzNzeFfN=gHttLaq_xYQJZchg@mail.gmail.com>
References: <20240130082722.2912576-1-maobibo@loongson.cn>
 <20240130082722.2912576-4-maobibo@loongson.cn> <87a5o4iti4.ffs@tglx>
 <CAAhV-H6Qqz54yQ8uehjx+jEhwCzNzeFfN=gHttLaq_xYQJZchg@mail.gmail.com>
Date: Wed, 13 Mar 2024 13:39:28 +0100
Message-ID: <87plvynw5b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13 2024 at 14:20, Huacai Chen wrote:
> On Tue, Feb 13, 2024 at 5:49=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
>> > During suspend and resume, CPUs except CPU0 can be hot-unpluged and IR=
Qs
>> > will be migrated to CPU0. So it is not necessary to restore irq affini=
ty
>> > for eiointc irq controller when system resumes.
>>
>> That's not the reason. The point is that eiointc_router_init() which is
>> invoked in the resume path affines all interrupts to CPU0, so the
>> restore operation is redundant, no?
> I'm sorry for the late response but I think this is a little wrong.
> When irq_migrate_all_off_this_cpu() is called at hot-unplug, if an
> irqdesc is irqd_affinity_is_managed() then its affinity is untouched
> (doesn't change to CPU0). Then after resume we should not keep its
> affinity on CPU0 set by eiointc_router_init() , but need to restore
> its old affinity.

Affinity is restored when the interrupt is started up again, so yes the
affinity setting should not be changed.

