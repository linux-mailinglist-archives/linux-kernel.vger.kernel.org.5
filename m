Return-Path: <linux-kernel+bounces-67632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72E856E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5002C1C2416B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E803B13A89E;
	Thu, 15 Feb 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FC2rV3J7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvEDjueY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CE13959C;
	Thu, 15 Feb 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027192; cv=none; b=I6KCGWdcJKP3w7H7TSl59Mcf5kWnGlyqtiGZqs17a9CGwGMdsKfB+ZZaEmLXcLiUauCbhDb6gYmXjhnuPnjT11MyvmWfpTb1cv4hJ+SSwryD46E49fIjtQyVxFQTb8NGNF1POaEcLZ2QN/4X/iWr27QAp2qwvlb6Tbh6Zqnhacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027192; c=relaxed/simple;
	bh=L7bcSnkXrPvlWYl4fEOQIJjl5ykV3vORJAPl4RXnXTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FM1fmTzTuw3fopIYHS0AsVUxX7b+ZXp6HCUd486s8vG/cC/n8sdvdzhUdJRchG85iHE3PxLWXTBkpAvLdNGyiwRtvVvVrb59ts/2PSud5udu5Uok7E5RwKP1eP4UCssYPYDO58Z9XfEgmSkGdjuhRweJIkaakkrH/Qb/h1WcxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FC2rV3J7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvEDjueY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSYfftfvnoNIEsV/zUwUyNXq3OsLbyrS3xmJdbEjgcg=;
	b=FC2rV3J7iMT20bfmDpKIzYMB6ZmyLIA/IJRb4Tx8xL2Qxt1IsRvPEyD2xPtSipTMBYLgTr
	7nxv5wFY8MllxiR/F0Y2y7blCZLBfc8c8+2e8CH87qyRxCNJZUgqLxj7LE+4e+3RRNOXHH
	lkMZ8JrZZXYDs+HoHK4mDrwGYN3dga8dU/SJ3KSsZeCzs0mxe7rYGaOLqOcczSA8KaubWT
	n1g+WSqIL5bnK7cZzxRg40w+MJ9a3WxFS1CtLqCZqSnQwUt6qT0pkRNFXqYwFNJRI+hQ19
	3N5SN3FMJB8mwHBpH7Vqbb9IH7Hy+EPm8f/W6z4e/7UHow3CcU77GADiJE6xCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSYfftfvnoNIEsV/zUwUyNXq3OsLbyrS3xmJdbEjgcg=;
	b=vvEDjueYHLIdYonrN/q3kU2Ip6cwkYGmm05lIBYR4BpbPCEnN8wSz1ZvlaD2M3vGVpsr8f
	7P1l5q83KTxAcAAg==
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
In-Reply-To: <CAK9=C2WsSSHgDF+7ruxx_QF0Lk+Dsx2F2Y-_NabnxrJ_qWhgGQ@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
 <87bk8ig6t2.ffs@tglx>
 <CAK9=C2WsSSHgDF+7ruxx_QF0Lk+Dsx2F2Y-_NabnxrJ_qWhgGQ@mail.gmail.com>
Date: Thu, 15 Feb 2024 20:59:48 +0100
Message-ID: <87v86pcxcb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup!

On Thu, Feb 15 2024 at 11:18, Anup Patel wrote:
> On Thu, Feb 15, 2024 at 1:24=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Thanks for picking this up and driving it forward!
>
> Thanks Thomas, I will be sending v13 of this series next week.
>
> For the time being, I will carry the 13 infrastructure patches in
> this series until they land in upstream Linux so that it is easier
> for people to try this series.

I pushed out the lot on top of 6.8-rc4 (no other changes) to

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi

with some minimal changes (DEVICE_IMS -> DEVICE_MSI, removal of an
unused interface).

I'm going over the rest of the series after I dealt with my other patch
backlog.

Thanks,

        tglx


