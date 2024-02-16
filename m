Return-Path: <linux-kernel+bounces-69348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E38587A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBF1C26A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2C145FFC;
	Fri, 16 Feb 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvCnSUsi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fu5NEToU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94030145B13;
	Fri, 16 Feb 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117540; cv=none; b=rI5FMrqcKESwna6xqkmW8XQ0bdwH7MgRNJm/w8gEFHtm0f40GUawnGIqRDuzvaAuI9dMb+BrjyOe+T8+zYiUrie6E5+0rwD/VSCT50KMDdODE6iJ3TxN0tgMbkBfP5WmRM48oH7rz6yCNDE7Zt8tSNa03NyapIyilYOFRuCSkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117540; c=relaxed/simple;
	bh=KLCwIs9FDIf60u4E6KTsXRvqqc8rm9ZViDMx+qTLqs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XCc5c6wqR6nXiN/OtXF+v8aBFj1B9cO+G8m6NeSwL+DBxFKP6foRc6cX9E2++KEgOkrcZ9Bp90QNFVi/Gio/pq5hZ3V9IiE+QOq0ZBmK7wbhTFt3/MzVLFbQ3Ur56amtFrEffOuZB4aotwKRBNkRbHanW5qpON+2CACf7FTQH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvCnSUsi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fu5NEToU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708117536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmEvoquY3BqSFZ0HDkxXKDAY9E0wZEnxUJmSLkCOtxg=;
	b=vvCnSUsijtARAt8uts96ga74b3dHsnePNt2qBbmO253debzyKJ0adesDq/8mekvm+xz4iY
	p8otEfvshT8dv0ifaktzky7cdRv7GSc36mgrG9tnvEBgBkR5ZvaLJaLAQMbZEaSuf3oFcF
	JEEXzOt+8Q/GV1/ltyXEBYD7i03vvlkwlgPAc93+U9vhcvL42d7loSxyjm+sg5byhZawco
	FENyHeFmGbTBr5CrXBxQQ+wzsYe/PRB9MywSnF9bQvqIneGPA4jcYsS6Tj8ZTMl7J3LOr3
	QOXHu0jgflSoLqgg5DIk+cX9PgiH/EmK4cMxmW63+wpJf+6g7ozIRBRJkOVO6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708117536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmEvoquY3BqSFZ0HDkxXKDAY9E0wZEnxUJmSLkCOtxg=;
	b=fu5NEToUUytvGpRtCWSTHzGJsDi1/IFYPlFboW3xgF/5SAD3bEtn6TbczZv2JjWOw10Qma
	1FWa28CpyIvTPVBg==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Marc Zyngier <maz@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Atish Patra <atishp@atishpatra.org>, Andrew
 Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, "Ahmed S.
 Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <87v86pcxcb.ffs@tglx>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
 <87bk8ig6t2.ffs@tglx>
 <CAK9=C2WsSSHgDF+7ruxx_QF0Lk+Dsx2F2Y-_NabnxrJ_qWhgGQ@mail.gmail.com>
 <87v86pcxcb.ffs@tglx>
Date: Fri, 16 Feb 2024 22:05:36 +0100
Message-ID: <87zfw0azmn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anup!

On Thu, Feb 15 2024 at 20:59, Thomas Gleixner wrote:
> I'm going over the rest of the series after I dealt with my other patch
> backlog.

Aside of the nitpicks I had, this looks pretty reasonable.

Thanks,

        tglx

