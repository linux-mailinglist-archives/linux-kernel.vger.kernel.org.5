Return-Path: <linux-kernel+bounces-66212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8885588D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0851F28D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325E1362;
	Thu, 15 Feb 2024 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMiIKM7o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PdCLD3Kh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEBEC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958970; cv=none; b=OSwwVv+J9818gIiZ7C29hTOL9/dGSxHBALbP4yfAy7nfQ0pfaPRS1XGSP0FdEB0fRVMmu/j6CgSpo6y7xGyMinorUu83T7XnMg2oq7TNDrp6g42EejDTt+ktOvrruEx7JocIUZqvijDNasc2YQeUI/igos3PciKCWBdOaRF+PMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958970; c=relaxed/simple;
	bh=Sibafm6sqfut3pthWhmBw87/ptRneGZPBq7CN4LIOvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtuiGSiHDEWtaZzjNOAvDtokpR1XwKxA/VXeCDrMe6RffeRf9nz5DP0Ae6LFy3g9Ryr98zkYpgOIAEnVz+T/2bSky87demxrnWxHPfV47wCGbJjNYxbL/rVOOj9hK4sxumTQbdo4nH8XbG8NzldzVm/59x4VPrDOGXwq/DjnP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMiIKM7o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PdCLD3Kh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707958966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvQ1S2KxmtsJBdyutBnJ1y5QRJHOWP3UsNVglbau+0=;
	b=sMiIKM7o51mBC4nUqsJO3huKc6na5wpofIyI5c+sMHRk+jkcREB1p6W8Ja33vpSAQUEnbv
	hg2bOWVb/GC7Jv7yEY4iUglry7eHmKCgFo7LJ5uvwnQdIFF8d9ULD3AUWJ+3U22VUFmyKg
	1fJigcbwBk1sGddsG0S2eGsob2HFlM9B9xewuq6XhBMT528HCdMPWdvs8s9t5HJ74ZDvZr
	JQYDl2R8O89BMg8fWxV4wRCn08++n7Pgu/OX4rUSsHxFxAB8+LXs0QSs4EHmftqCrtivwx
	uMfkbWLgwFO87/m2cmqPKIPx7VpsVn9ZjEAkTLfgT7/3FKtQArQnlY34YzQ7PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707958966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfvQ1S2KxmtsJBdyutBnJ1y5QRJHOWP3UsNVglbau+0=;
	b=PdCLD3KhqXR1PsICH6XSeR/hqShKKQYvMcWc02dNxAPIEJwkg12uSLHA2Qs9WqpalHpeSL
	Czu5q3Bq1RzOGhAQ==
To: Doug Anderson <dianders@chromium.org>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, akpm@linux-foundation.org,
 pmladek@suse.com, maz@kernel.org, liusong@linux.alibaba.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming
 hardirq
In-Reply-To: <CAD=FV=URLh5N6smwdnPXn6di8iek_vn=uBYFWBpCdsuRjLK8ew@mail.gmail.com>
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-3-yaoma@linux.alibaba.com> <8734tufwjh.ffs@tglx>
 <CAD=FV=URLh5N6smwdnPXn6di8iek_vn=uBYFWBpCdsuRjLK8ew@mail.gmail.com>
Date: Thu, 15 Feb 2024 02:02:45 +0100
Message-ID: <87wmr6edze.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14 2024 at 15:39, Doug Anderson wrote:
> On Wed, Feb 14, 2024 at 3:36=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Tue, Jan 23 2024 at 20:12, Bitao Hu wrote:
>> As a side note: While C does not allow proper encapsulation it's a non
>> starter to fiddle with the interrupt descriptor internals in random code
>> just because the compiler allows you to do so. While not enforced there
>> are clear boundaries and we went a long way to encapsulate this.
>
> I think you must have gotten dropped from all the future versions of
> this patch series when Bitao took my advice and started using
> interrupt counts instead of tracing. For what it's worth, the latest
> version can be found at:
>
> https://lore.kernel.org/r/20240214021430.87471-1-yaoma@linux.alibaba.com

Yes. I'm not on CC and for some stupid reason it evaded my LKML filters.

Let me find that thread and stare at it.

Thanks,

        tglx

