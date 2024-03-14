Return-Path: <linux-kernel+bounces-103025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A7D87BA10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FEF1C21066
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A16BB4A;
	Thu, 14 Mar 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVj8vszb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yweRirHu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF76433A0;
	Thu, 14 Mar 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407501; cv=none; b=mlGl8FuE8SFd9JKxis5cM5Y+J6U2Ib3dAsM/QOno3eZRPR80efi1rWgFkGSBG7tkayWn30n6AxNn9h8Frs+SX+zww5wlmx0JDJvHJqtX+VjP2cerQBO2GX658NSlb8Mb38QIIGVVmCUf6ut+MbpnqU7ZCUdB8KmradvrNG5QbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407501; c=relaxed/simple;
	bh=2cJKZBx5PsaaqfUwwITqRaBdcp6gvaVRh9yAv6LGQI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWLMnszku5wEi7nAupkqiI8ruOlqMXqWDrkPAwBCJ6OJGlVWScLvITJ6tA7V1q4THWXH9ym5drooNqeBJSeyUXaSkQi0NQJC8kXoS5Xy5nf1b86JxV6Y76MSQA2v7SpPD6Rol/u9Q/751NxOmoNwsl99PUPLIWFxuhfvFI96hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVj8vszb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yweRirHu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710407497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/D79kxBNVBIRfHA+CVmBNXD66NqkIGVp8XPWqMURUk=;
	b=zVj8vszbDAduY2HP4b5b5yxdUC+ObYwzypCXBuf4ewS+xK01uchTmQNaWrQUqqkL5q3EQr
	JF6PceLSHnhIAYw28xk6bYGCsJvEoPa4t8Vi/2yaTRLOcfSl1iXaiBCwxlHfC7y91BF6JB
	1ksq2DjL0erAmPPxABETwmpjmAgYBsJrH4Gp882GnD4zFZ0AoPnOYPLPLgNEgizWqG4Ywf
	qVLWkWq7dQM84f61QlNF4V5ufux1fv5e4y37SGatogNla4nzxgifv3jAsl1McRAN6OS3q3
	J1MOhjtXa6CFrBTcU3E0vp9Z8BPjjT2bunxHd1F0ad9/a7P3kSLmljRV65FTEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710407497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/D79kxBNVBIRfHA+CVmBNXD66NqkIGVp8XPWqMURUk=;
	b=yweRirHuPQbIwYpeTuqVvUbjgFdko0pY2NwH2CBSyGvQ1AlYsExCPA5IFncKsTIy5jQz54
	QzH/X70YPfAWBsCw==
To: Florian Fainelli <f.fainelli@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Joel Fernandes
 <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, bigeasy@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org, Justin Chen
 <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes
 for v6.9]
In-Reply-To: <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
Date: Thu, 14 Mar 2024 10:11:37 +0100
Message-ID: <87le6lmb3q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024 at 20:44, Florian Fainelli wrote:
> On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
>> Can you please boot with:
>> 
>>      trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
>> 
>> And add the following and give us the resulting output in dmesg?
>
> Here are two logs from two different systems that exposed the problem on 
> boot:
>
> https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81
> https://gist.github.com/ffainelli/dc838883edb925a77d8eb34c0fe95be0

[    0.003042] Failed to enable trace event: timer_migration

The event option should be:

      trace_event=timer_migration:*,timer_start,timer_expire_entry,timer_cancel

Thanks,

        tglx

