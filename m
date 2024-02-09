Return-Path: <linux-kernel+bounces-59800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FEA84FBDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CD11F291C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4682888;
	Fri,  9 Feb 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALal7hRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295A8286E;
	Fri,  9 Feb 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503484; cv=none; b=T4awoPmwQhbzl7OGSrBhDpnXvAAqCFW6dAmvRAwPx4qa2zSzIwl7g7nk5z5O9anAjBWKAv4XalQQv8evdlPaf1/aSV+n6xHFNA7X+zp4EM/SEIjrYW2St6hNMMKgaF3267YWvh7rAGuEMmP0lB0/i1EKXKU1C3eXB9XTGtPTEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503484; c=relaxed/simple;
	bh=yMevUDxLK0NwGJ8Z8pZ5Sin6BlhE8eNPdZ5e6aErPGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kguY2iOZ5pcYJoStUwe+7Tw+fBkrXyuOn8tTpsmVeAiP76gbnvkZ9qUNmMwi47cf40CAfgeFguDUV2oWla5W+kALKavtW6zwjn8v5v4mNKALkNdEuApemR/v8TeXXhY6LSc4VW90IJ7Muhpp9HyvFJVzNpS1nUX1Y4G67ti7azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALal7hRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E320C433C7;
	Fri,  9 Feb 2024 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503484;
	bh=yMevUDxLK0NwGJ8Z8pZ5Sin6BlhE8eNPdZ5e6aErPGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALal7hRT51AXkooxAQe7tbFSCnXqsv1P8A49tGycGrPr0G/Nt/XfREhi1LEjzRdKP
	 iYdxGyAvYp+JTAvxy+oxXMTjrQZ8urT0iOlEgclt4fiS2EBxglUfCPgkusSw5bS+1Z
	 RHrFlIE6GsqJMaC70d1f2gXpPMR6hqB76bOJuuOlStzkCLtndrMlQxLtCAZohbxAwS
	 lANWZNjWkfvEOj7rHxhRin0Us2HIc3i3yx9PAls8BE6L1lToC3qbWnTBGgIcPqEO3M
	 7vBQnF8lolqpO6OXE/Lz9A7eP/Chhr1a9Fe0gJi5wg1au7AMib/cXFOiAyclggdYlX
	 Z6DSZC3fFSCPg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Fangrui Song <maskray@google.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Smith <peter.smith@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
Date: Fri,  9 Feb 2024 18:31:08 +0000
Message-Id: <170749826521.2630324.4507897270923627883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240206074552.541154-1-maskray@google.com>
References: <20240206074552.541154-1-maskray@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 5 Feb 2024 23:45:52 -0800, Fangrui Song wrote:
> The generic constraint "i" seems to be copied from x86 or arm (and with
> a redundant generic operand modifier "c"). It works with -fno-PIE but
> not with -fPIE/-fPIC in GCC's aarch64 port.
> 
> The machine constraint "S", which denotes a symbol or label reference
> with a constant offset, supports PIC and has been available in GCC since
> 2012 and in Clang since 7.0. However, Clang before 19 does not support
> "S" on a symbol with a constant offset [1] (e.g.
> `static_key_false(&nf_hooks_needed[pf][hook])` in
> include/linux/netfilter.h), so we use "i" as a fallback.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: jump_label: use constraints "Si" instead of "i"
      https://git.kernel.org/arm64/c/f9daab0ad01c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

