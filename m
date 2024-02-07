Return-Path: <linux-kernel+bounces-56078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C984C5A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30BE28228D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2331F93E;
	Wed,  7 Feb 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGp0VCw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8811F61C;
	Wed,  7 Feb 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291062; cv=none; b=dUvkSIMxbGHRZCe3dQl1jhzJXIn5wvyinIvpIc9y882D/KvphAT25XuUM59ENE5DV7sqpcIPElE80cPCK6hiXpD/2xy87svVAYv4NK61j86i74ZUyvGb5mCU90jb3BxZu2M3Q4jh49qxiU+AlPWdSGroMytymZZuW3fUmjeHY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291062; c=relaxed/simple;
	bh=peaUftXrWic18CddrBoaXETZSCSrNh8TslugLOSvkCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNkLeGG0m01Yy2gayKjNrXNfOkMkpwqQ8iZ+C8+TK+1479a8DSfp2fIVZedrvKzDm9bSNsn+UBXxZrlqRB2AMDfJmzI4uNAZZDHZRMFmYk3xObEFx2LW/gW2UnNdYK2kkZyp4XBH2q3zO2Fr5hzEnjdyzKIgvajR4NL81OfSxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGp0VCw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB2DC43390;
	Wed,  7 Feb 2024 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707291061;
	bh=peaUftXrWic18CddrBoaXETZSCSrNh8TslugLOSvkCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GGp0VCw2X51EtMDNXx1G6fetOHUR7yDlPXgybkXspa9fS369foFEpGFgJmBCAfLLN
	 SHsFXrJ9QaywGjYulhRdz/cR3nol8JMP7xgQ1PX3W1Uu+nwSi3t4myf0cNYyiC/jJP
	 eej6At8hHcdrcJFtZd37r5xRmbMofe4oPOPOVnqMVeZi1NNsNRVC90il6VzPDp3YeV
	 2z8eafu6s1V5ip8CJmmfRc7zE+P7ebFN63VNcDYVRvcyhp2vr/vtiFqzZCP6IFN4kb
	 aYkQLKXHRM6Y6ASUGzpZ0b2u4vvR0i6q1Wnp/PqAlIDXen5BCTMVn34UFbdDZMlh8N
	 Tmf01WrbqJieQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, =?utf-8?B?QmrDtnJuIFTDtnBl?=
 =?utf-8?B?bA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH] riscv: Fix text patching when icache flushes use IPIs
In-Reply-To: <20240206204607.527195-1-alexghiti@rivosinc.com>
References: <20240206204607.527195-1-alexghiti@rivosinc.com>
Date: Wed, 07 Feb 2024 08:30:58 +0100
Message-ID: <87v87091e5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> For now, we use stop_machine() to patch the text and when we use IPIs for
> remote icache flushes, the system hangs since the irqs are disabled on all
> cpus.
>
> So instead, make sure every cpu executes the stop_machine() patching
> function which emits a local icache flush and then avoids the use of
> IPIs.
>
> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

FWIW, the BPF selftests pass nicely with this (especially the
fentry/fexit tests ;-)). I don't know if it's worth much saying that
your own stuff was tested, but here goes:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

