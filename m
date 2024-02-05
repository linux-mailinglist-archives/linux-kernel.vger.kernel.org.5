Return-Path: <linux-kernel+bounces-52501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F0C84990E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301A7284D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18AA18EA5;
	Mon,  5 Feb 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOCUSp8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B88467
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133324; cv=none; b=pTwLXmkYSZmc/AW3QSBqlKZ5dubM84+RGBmGatLb8f/X2jlDWvaExwWscNAGks6JZcitw0o+MCkitCUaFIqsUpplR/qxw8Gznj9+Chba9+KV1yj1fmEyNOG5tpO0ZoqqsQdFVC3DRWsU3Efz291TcRLdYHT7CCJIueUz3EQylV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133324; c=relaxed/simple;
	bh=mCWvEFnSCi2HdGggqDit3vI/8lP5Dx3NTbHsew0yjPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qyjqQpdPKT/w/DIPPKmacOp5/KGEPe9UXtokr04MItfrE7NyMrUd4C95W3V2F+TnZx7S9pyoSgJROO9Xpv25VxavcmoMY+QIkPT204qqfdlqNGz3ddaBv5WhxVls7x1sHauvL83NbrvIA2lhWv4aAXMUKM8Bck6imPM+YZHeWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOCUSp8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F4C433C7;
	Mon,  5 Feb 2024 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707133323;
	bh=mCWvEFnSCi2HdGggqDit3vI/8lP5Dx3NTbHsew0yjPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sOCUSp8VQUqg/ThvYrkaZt45+tGXrbrevpaHUcjx3Efjwb0NaoKZUZuJG4BA/HONs
	 GWXRMD2kPzGQh0RvVJPVIgclzPAPc0wMcGnBkVdoJLSZfrpDUi3i4z0zV/jQuHQp19
	 2ZwQOfgwSGaJW1cUnsBPtXGs5VwIor/S82MEwcXPU8CaYwx7pnZ7DJDvlpOppthSVy
	 gXpGE1uMjS5LS0706UjHS40rQxfeM1iBQupXj8EZarpXSYIF4m+cUmlvg3IhmpaqKt
	 L63esQJ8nSMtprkPxjpyR7zK2ssDyAK424dEmt4ykMEv4UGu0RqJVcy3xX6iwda/R6
	 nM0Q9bJ1ggTqQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Anup Patel
 <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
In-Reply-To: <87wmrj9m0b.fsf@all.your.base.are.belong.to.us>
References: <20240205042955.833752-1-apatel@ventanamicro.com>
 <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr>
 <CAK9=C2XEmFBDB6R5f+L9++7ojhWb8rJK-e-vgFrDmsi2=DMOBw@mail.gmail.com>
 <87y1bzch0u.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2U9K+u2r8xNcguqpROKeDhKSBoQCrDW1Y_Qa_MU-SBqnw@mail.gmail.com>
 <87wmrj9m0b.fsf@all.your.base.are.belong.to.us>
Date: Mon, 05 Feb 2024 12:42:01 +0100
Message-ID: <87sf279lyu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Yup (and thanks for working on it BTW!). Hmm, making it possible for
> Charlie's work [1] to attach to cpu_stopper? But maybe that's more
> work...

Trigger finger...

[1] https://lore.kernel.org/linux-riscv/20240124-fencei-v10-1-a25971f4301d@=
rivosinc.com/

