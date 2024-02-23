Return-Path: <linux-kernel+bounces-77957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA510860D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589A92817C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD31B5A0;
	Fri, 23 Feb 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaO4+eda";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RY0/77R8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231271A29F;
	Fri, 23 Feb 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678492; cv=none; b=PoJ8l+C1r+S9puh0FCb3D2+iyWw990k4k/yKjMrikUe7ANZ4zmzWNcSvVshwvFQJbNu/4QtO6umpkl1T48Dn0xSxm+JNP5H60XdOCSAHiXwm5CNrxeKaUm6c9TXGdbStj5zwFD9IjfTlbcm0rZ/mL8f3E3uACs9crSPPqlvB15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678492; c=relaxed/simple;
	bh=oYSYLti2IifVDTV0OzRPUbZTcLilwnzAMygead+Tsog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZloINzr8L7t0eVmLQoXhT/zHdOXYgqFWPkJG38PvhulqyqIxsAhYP8/GvZ7W9pYppWvnwIZ3UDz6G6cqfyQkb6iyoVzBQAKME6PaQfw4TfhZgc5o7p7gCs88S4WusH/gdJMoyEHOw3QJm6tKIulEY+lI/V3Ji2VBRsXyOyvyvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UaO4+eda; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RY0/77R8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708678489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zrx67e+Ks02+zDid4MN+n+m4AfW7G8yFrILIPbdnNa4=;
	b=UaO4+edaAlRkEF1meSANixfmhiR1danHJMIoI4bWIlEjqMxlificuKVRiZjKRI34uK+/hk
	yov6A0AAylIj/5+xhEkh25rs/R5t1D0FnBd6XiLZHZws8ZndsF4Fx6/BRPnb9WiijW74wC
	awhDyB/C7rcWplgSzNGGRzKEdbwcmqq3WDPnGbLr42NCF1DXy7P/ggZbu6FT5xUcsNXGKG
	aWIUlN84e44uMKNJRSTu+RlK+p7CZzXgzQbdwe7UDpsvjKIfxUfXcFI+qIbJQboXX/1e0j
	DYYGgINgTShkLB7bcNMk/4SsS/Av095OpICDU2bdXJIq759Vi3dSngtB86Wrsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708678489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zrx67e+Ks02+zDid4MN+n+m4AfW7G8yFrILIPbdnNa4=;
	b=RY0/77R84x+3anj5rVqtXr7nePncBV1qdEK0MqIR9HQ97lVwGiQRJSrwrJwrBASYJ6hOj/
	v2mgwGRxCXg66LAA==
To: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
 adrian.hunter@intel.com, ajones@ventanamicro.com,
 alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
 conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
 devicetree@vger.kernel.org, evan@rivosinc.com, geert+renesas@glider.be,
 guoren@kernel.org, heiko@sntech.de, irogers@google.com,
 jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
 mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com,
 namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 peterlin@andestech.com, peterz@infradead.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
 robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
 tim609@andestech.com, uwu@icenowy.me, wens@csie.org, will@kernel.org,
 inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com
Cc: Randolph <randolph@andestech.com>
Subject: Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
In-Reply-To: <877civefa5.ffs@tglx>
References: <20240222083946.3977135-1-peterlin@andestech.com>
 <20240222083946.3977135-4-peterlin@andestech.com> <87o7c8dvv4.ffs@tglx>
 <877civefa5.ffs@tglx>
Date: Fri, 23 Feb 2024 09:54:48 +0100
Message-ID: <874jdzef1j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 09:49, Thomas Gleixner wrote:
> On Thu, Feb 22 2024 at 22:36, Thomas Gleixner wrote:
>> Palmer, feel free to take this through the riscv tree. I have no other
>> changes pending against that driver.
>
> Aargh. Spoken too early. This conflicts with Anups AIA series.
>
>   https://lore.kernel.org/all/20240222094006.1030709-1-apatel@ventanamicro.com
>
> So I rather take the pile through my tree and deal with the conflicts
> localy than inflicting it on next.

> Palmer?

Nah. I just apply the two intc patches localy and give you a tag to pull
from so we carry both the same commits. Then I can deal with the
conflicts on my side trivially.

Thanks,

        tglx

