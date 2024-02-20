Return-Path: <linux-kernel+bounces-73315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5385C0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54A61C233AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23D76413;
	Tue, 20 Feb 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhY+zEYo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dt3XistD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434A763F2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445579; cv=none; b=aShzKcdRkWpdS9Xk7wJJrzq4lJI6K44uMn1PoE2t/HAejXqcLdwB3+mvGKCvc56YurGC2nORoVoC8h2cXDTRD0rVoSC0TShfjySYZO+K2PjX+lSYVnxuy2qTYpYbfTq7rTJQlbvQd3DA1OBkI85RCqv5KCMuAPJweJyAAGLegTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445579; c=relaxed/simple;
	bh=5tAhIw/LCPQZkqfKPCUp+TgjCjXAEnSGyozQ+zzqwmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=apbCYQbox3arLEN6pBrmHE6HgsUFc7qEB4mKdQsYXTWnTU1fVqtstLjNbLuLbD9kiTJWDAZLWLp1/GLh6BYno5S84oAnLF38TPXydH1bxTHTo892APjPZROFe8AKWCmXCGvjUdtSmKQW9u5gS2HxKhpyuJQQt/Cj0sf9pIXGoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhY+zEYo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dt3XistD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708445575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZrY1gZPRUvTnU9/cDlk7x1h0DpwHxopqdoV/0GbhPM=;
	b=vhY+zEYoC7D9zwqbcnW1119riOcQ+OFEtBVbgAQVG69dJRwRab6ob5mgV+X1aVUvP4t56c
	cq/TLWNqUmUQcBmKe7eAFZFZ57Jy1QcO4h5eVzfNPN4pprnAbKyyWlwTPqt59igDkB6oTw
	qxdEgXBQ21aOx95WFj8iPIIp5bJ4YZXC5tYHbrAITXb0uH7+KKEJeqTViUce4zmsnBKfhO
	SYL+vcWdMA8U3XaR4LL1s2gL9ew6I8/FHvULPPF7tWb9OktJshJglCsl97olL2+NYcwm7T
	4jHS6kbCeFo0KuIRYV3lFSoY82jQU2Z61xDJ9Y2TQgQhTmyhlbUAA4w8rDyhoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708445575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZrY1gZPRUvTnU9/cDlk7x1h0DpwHxopqdoV/0GbhPM=;
	b=Dt3XistDyurCcEeAaa7TewWu6cHD3oicJDNl30atSYP5EjgqdkCCKSXMvJ15qVqRszkeP2
	AHsa+z7/BynoIqDA==
To: James Morse <james.morse@arm.com>, David Hildenbrand <david@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
 <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com,
 lcherian@marvell.com, bobo.shaobowang@huawei.com,
 tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com, Jamie Iles
 <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
In-Reply-To: <49f42c63-63b9-4cf9-96ad-901b3fc1d50e@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
 <52f81c45-efa7-42c7-86f4-fc1084b1d57a@redhat.com>
 <59ebda21-6164-4dff-9ba8-956d5a715048@arm.com> <87v86jgmhp.ffs@tglx>
 <49f42c63-63b9-4cf9-96ad-901b3fc1d50e@arm.com>
Date: Tue, 20 Feb 2024 17:12:55 +0100
Message-ID: <87sf1nglmg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 16:01, James Morse wrote:
> On 20/02/2024 15:54, Thomas Gleixner wrote:
>>> With MPAM this code can be invoked from an error IRQ signalled by the hardware, so it
>>> could happen anytime.
>> 
>> Which does not work because you can't acquire a mutex from hard
>> interrupt context.
>
> Indeed - which is why that happens via schedule_work() [0]
>
> My point was that its non-obvious where/when this will happen, so taking the lock and
> forgetting about it is the simplest thing to do.

Makes sense.

Thanks,

        tglx

