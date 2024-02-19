Return-Path: <linux-kernel+bounces-71707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE085A94D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F2E1C21CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CA40C0E;
	Mon, 19 Feb 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8adDIMF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTWrsG8W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8FF23B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361374; cv=none; b=A+rjqW2L0xy1dnwpyz7opvYA0J8IaOu4nyV4L2kdUB2vaum17e1422HYRhjoWuEcKK/dcN5sXIpOWVNr1cmxww+2sVvNtEaYqfhUUWZ10Rqyq0ee2FB6cPq7M4iDDSredU8x7uCOqz94sd+jIN6faAnywazT4uBmhV52I2zxr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361374; c=relaxed/simple;
	bh=Y6EKdBCPl4p5Md0hUI02SPFaxQ5gQVhFLesx9SAjvRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4QWzJ1duNWsAYNUWJUoJwUK9ruh/c3abeC+LbSYn4/OO/Ddk50rSG5q0fHEnAtrs+id7mxKODLyF549EjAkBguDReelxyho71EI4jh6bIUxcFLwqn7xMcuspEoWEav0LeZ5aq2GdX+Qo2CGFu0mPx6FDEy5Xp70vmGhks0JLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8adDIMF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTWrsG8W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708361369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU+4flsDNEBo83o/yPdzhjo6IBA6Ub/lrR12JPUBrfk=;
	b=Q8adDIMFh/RQwClkAghYdeCatkuI1NOnvyuEYoaipex+Df26d/QdX5O9q/TYf+wERymDdc
	rdHQ++rAkLskvlkl02f8T8pTT6QYRL1E/9WIOXArRdKD6SAnSk8NGchU+uDEZqBB0+YKio
	Vk8PRHY8VrpYzj/oTSPhz5pq1Dw49MkOo+j/lo9Y9swXtpKbiRygUYVRFHfq0+qk4y3ug1
	hP3tvVy+MvIBhq0BX6Ixl+luScZeOVrFfP6zrG5pjCYzKoLTRNutuBuG67i9vTWS6TqvO8
	KsXUGHVKYQ1vcFnVoriq/BDAcTvo0Ez5C5kf1OIyoFys4ZGVO0XIatNZ7aisIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708361369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU+4flsDNEBo83o/yPdzhjo6IBA6Ub/lrR12JPUBrfk=;
	b=MTWrsG8WwuF+xhBsAu0MhUpUCJ/6TJS6fuHyJvrW4Hvvhz/MqBgAOrGigyenYVRLFsm5SQ
	WoZV4yBSJ6qpsIAw==
To: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu
 <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Ingo
 Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
 <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com,
 lcherian@marvell.com, bobo.shaobowang@huawei.com,
 tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com, Jamie Iles
 <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
In-Reply-To: <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
Date: Mon, 19 Feb 2024 17:49:29 +0100
Message-ID: <87zfvwieli.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:

> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>> Hello!
>> 
>> It's been back and forth for whether this series should be rebased onto Tony's
>> SNC series. This version isn't, its based on tip/x86/cache.
>> (I have the rebased-and-tested versions if anyone needs them)
>
> The set applied ontop of tip:x86/cache gives:
>
> vmlinux.o: in function `get_domain_from_cpu':
> (.text+0x150f33): undefined reference to `lockdep_is_cpus_held'
> ld: vmlinux.o: in function `rdt_ctrl_update':
> (.text+0x150fbc): undefined reference to `lockdep_is_cpus_held'

Wants to be folded into patch 24.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -368,8 +368,8 @@ struct rdt_domain *get_domain_from_cpu(i
 	 * about locks this thread holds will lead to false positives. Check
 	 * someone is holding the CPUs lock.
 	 */
-	if (IS_ENABLED(CONFIG_LOCKDEP))
-		lockdep_is_cpus_held();
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && IS_ENABLED(CONFIG_LOCKDEP))
+		WARN_ON_ONCE(!lockdep_is_cpus_held());
 
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */

