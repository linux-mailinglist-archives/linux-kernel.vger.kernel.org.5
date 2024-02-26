Return-Path: <linux-kernel+bounces-81770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC978679F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D049E1F305BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1512B163;
	Mon, 26 Feb 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoLjgR8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VHdsomR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84B1E498
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960376; cv=none; b=geDQZzvK03ZG9guOMZBF/OXqckxGVG69v5gLD3yJoYQL8/N9i9GfkbF/94mFtDg1DxMqwo+kEeD/ZAUgTNIVJepgmz1njP9JCKQzwLIH1qdam2Mx/F5V/0Wd1i+Yck6f+u1TpX0YZERhQzZui+KNu+YVbcMPcVfw+7AeNoPTvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960376; c=relaxed/simple;
	bh=ZSRChojwrXCT0b7vENu5UlBhAbld9GHMiKpHpncCWJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MYj4ewIHLHzebK0ouMnQh4+PbQESOWKhlZ5rTeJ2w/iG91GlRSWBRiDwbCaC2CciXFLu35bHX3pv9Ilm2kzHWrDSNMIgikJjbMgUfdiu5blm5s8+5Xajj1Pr+rx0B7tC4zVYgSRLfvhevLeFChxCAcd/+bOLunySx0Xia8tYVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aoLjgR8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VHdsomR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708960373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G46q6yAlg32Zo4rclnr4qr52SJ5Jzfk+eglrodDl5U4=;
	b=aoLjgR8ir6HxU9Ywv6oJW+Yb9Wy8x6m3nlJr4653gIJIODuI0ZYWlcDjt0Bbs9SWIeYUwB
	/CG4VWFP9RfONLx1vJtuJ4OQcxfT5KHxzYdRjYUH9NpIkdvHYB3q7I6XkwQo1p5waN021Z
	OjAJfm03iKAa2pFjR0SH0I+FPtlxrBaU33Z+R3mMjgQJLI/b8sxRF7nErbx1xV8zwoL1eV
	a697fvqv9RbMfRZYizvQfOfgNRMSX9MT6XnghxxzV92nq3xFkXD/ZTfQN+4mF4E+UZ527g
	LdAzYguoa9VPJesIRdxvx1e8DSzcEoPSC5vD8lqPl2ghDoohdWA9gILSk+UiCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708960373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G46q6yAlg32Zo4rclnr4qr52SJ5Jzfk+eglrodDl5U4=;
	b=1VHdsomRdQjf+EXAiMvUewWU5qhEvyBU4sTXKBH/4XkkmP6O/ruXS5S6PGrST1FefSKE45
	sRp4GYwlNjRm+zAA==
To: kernel test robot <oliver.sang@intel.com>, Marc Zyngier <maz@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Anup Patel <anup@brainfault.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Biju
 Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [avpatel:riscv_aia_v15] [genirq/irqdomain] c3842e43d9:
 kernel_BUG_at_arch/x86/kernel/apic/io_apic.c
In-Reply-To: <202402261004.1e2e3e3e-oliver.sang@intel.com>
References: <202402261004.1e2e3e3e-oliver.sang@intel.com>
Date: Mon, 26 Feb 2024 16:12:53 +0100
Message-ID: <87wmqr9s3u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 26 2024 at 12:57, kernel test robot wrote:
> kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/apic/io_apic.c" on:
>
> commit: c3842e43d9d6b013a40adaea274b663936b14e32 ("genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens")
> https://github.com/avpatel/linux.git riscv_aia_v15

Fixed in

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi

with commit c147e1ef59d4 ("x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC domain search")

Anup, please update your branch.

