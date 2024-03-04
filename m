Return-Path: <linux-kernel+bounces-91227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9442870B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BDF1C22539
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16B7AE72;
	Mon,  4 Mar 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esKk90ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA14AEF9;
	Mon,  4 Mar 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583853; cv=none; b=Y29Y2XPLEYlSUaCJdQ13hzTtBMfXbmfv292L7V4A0JSDrwh6siJ8HUDbQ3Hibc50JZHarqRU8UwBoiQ5DwvFWoL4sGmgmfwesg1Ycgh2LuIuEdMWAy/oXx/pdjSqaKyPchWTUe7RaU2XsEkXwG9jn9rOb1aElDVobHedN7hRlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583853; c=relaxed/simple;
	bh=uFdMSM3qZM+dt1Bib9NpBh7aRqMQlZ7L+ConpzhZ4zI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W63KibzYUp8pRyXoRIC9Rxkliu8FmolE4ryTDLPOACNT88DGrjJno8Rud6rhghNdKleDVO+yUevX7stgPu0XsFoAsCfcA/ELdHrCdUcY5a0OAzhflURriW4zQbFni0yMCf2PXR/jZ9Jh1NtJQX8+iCxmoWHDYrn2pb8QJy30At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esKk90ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A67DC433F1;
	Mon,  4 Mar 2024 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583852;
	bh=uFdMSM3qZM+dt1Bib9NpBh7aRqMQlZ7L+ConpzhZ4zI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=esKk90ckOpB4uFBQnt/GYpn0GrhgyghLnGC7L0zw12stK+8uozpCBiKrOB4m1a0ZA
	 pRMxW4h6bymwqgtxGEcA9Hif4E32M+6hzng349/9lt4ejmj6/LKjrMzzPLuvTecAd2
	 CePkDGtzs8UDm+NCl/rBP5HAuAl27/VYYe1iv0WUDBNruGoOdjnsylp81rLl9ADv5v
	 MxYyqkQTeNQ/lGDsVoYsfYpV001tkYqcXMeotIgkURA5k5NyEJzodV6euzmmG/syIX
	 dwV4PjWi4j0mid1r6gLBZ2gHiKpHnnvxIXX0u4RerpFB+bC5vdX1iwkHdAJ/0IuuUG
	 XnLhQXVAShCtQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri
 <andrea@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrea Parri
 <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
In-Reply-To: <20240304-makeshift-bakeshop-26c9611de1a3@spud>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com>
 <20240304-makeshift-bakeshop-26c9611de1a3@spud>
Date: Mon, 04 Mar 2024 21:24:09 +0100
Message-ID: <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> writes:

> On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
>> For now, we use stop_machine() to patch the text and when we use IPIs for
>> remote icache flushes (which is emitted in patch_text_nosync()), the sys=
tem
>> hangs.
>>=20
>> So instead, make sure every CPU executes the stop_machine() patching
>> function and emit a local icache flush there.
>>=20
>> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
>
> What commit does this fix?

Hmm. The bug is exposed when the AIA IPI are introduced, and used
(instead of the firmware-based).

I'm not sure this is something we'd like backported, but rather a
prerequisite to AIA.

@Anup @Alex WDYT?

