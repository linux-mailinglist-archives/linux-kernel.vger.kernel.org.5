Return-Path: <linux-kernel+bounces-62515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FBA852239
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED75282F30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A04F214;
	Mon, 12 Feb 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jPQWVbQ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHMRp7YK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79C4EB32
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778927; cv=none; b=gQts4jyvxIcXv1Qg5LgOz46AhUmpk7JR9TLdHgbhKRSNa4qQZY5OGZYZhxIBmlfKIi+5cZek8B5celyoggW/Yo2UmZ1vmANuS8UZBDJiGW9GAzBJ23r+i9CTnrO6N/341cYyKcadBO2I2e/UxD6fj8QRNJvglptBMj2xgi9Kg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778927; c=relaxed/simple;
	bh=AyPyPcsNq8Arnk0FVDIqFAwz17dp+qsLIam4KOSEwE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKfej1SUJ6gdu0RUOWpyLNUAptUwiog/FjF8YqguL4nJD6F+rQ2TdXk0cfNDAYkDv8ZGZA5ol7qFfk8WT/CNvVLTbukd5mY6USdqYEfBTAq+9M14yc8d3sA4881eCHGyBeG5PIKOLmfMeb6zut0Z+oKYjkpqsHF1DjQBCMMDDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jPQWVbQ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHMRp7YK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707778924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMviVYMKKD2WM77H/qLOFoZT99RqVHLEMw6ourA+xaY=;
	b=jPQWVbQ2Ne8IPJ0fgty1ay72LecBIV31mYDJkz2++xkks6Y6JNGA7GrouFbnzQWUWj292j
	tUEJrJw2p+XUjZivWys6OBsMkXZP8sjiMQObygqXBIoFQsOl+OlflDeZ+9C+gZkXm9ZYkc
	QTlCMnnmMnJ4hZ/KXopXOoyIy6pivNMAGxgDUNd5BC7dyASv1kEF4QfA2ccJaAPAc9osNo
	csmmPSXmVSz8P1NQLt17U6gDp+Zjxi4U4D/SX8vyAvcC+2yd0ZLM0nUOtozjQq9vYv1oDV
	eh2BXdR7xDD4JnO9LRdIgTj0OYkGQ+OeIpOF5r5b4zIAn142TxZ2doAckvHYxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707778924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMviVYMKKD2WM77H/qLOFoZT99RqVHLEMw6ourA+xaY=;
	b=cHMRp7YKuRJFsee70O9hcxfTF2r9k+QUeanwPbJSOomypfrouifOrXZPx+8jLcBIsmmnVw
	lMOaDar8DnEwBVBQ==
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <20240212154347.GHZco8s27sOmg4neu-@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local> <87il2tlqba.ffs@tglx>
 <20240212150053.GEZcoypaBQPB1IcZGY@fat_crate.local> <877cj9lnyo.ffs@tglx>
 <20240212154347.GHZco8s27sOmg4neu-@fat_crate.local>
Date: Tue, 13 Feb 2024 00:02:03 +0100
Message-ID: <8734txjnh0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 16:43, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 04:08:31PM +0100, Thomas Gleixner wrote:
>> This really makes my eyes bleed.
>
> From: Borislav Petkov (AMD) <bp@alien8.de>
> Date:   Mon Feb 12 16:41:42 2024 +0100
>
> Documentation/maintainer-tip: Add C++ tail comments exception
>
> Document when C++-style, tail comments should be used.
>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

