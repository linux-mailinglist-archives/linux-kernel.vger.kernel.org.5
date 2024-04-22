Return-Path: <linux-kernel+bounces-152961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBB8AC6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3857A1C219DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A28548ED;
	Mon, 22 Apr 2024 08:18:51 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF150A77
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773930; cv=none; b=XF0U/+C6UtvkavNZLqXQZr2w6D0Kzb3EJ4ddVGAacnVJeNIp5jz/4DPKks3hWMwVfrpQM0s+h7yKATGB/WEnFJPHL+AIOrQtS/0VA9dpugeN0/eK6Xo6mOQdH7Ary16PFS70b2tXQ6bPuaBVEpCQVR9bPt2Vfh2+bOW2h0qdyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773930; c=relaxed/simple;
	bh=J3Vo0dPp9DaOA8VOKKGz2d/zYNWjY1FVMPKqn/vx/pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tWxx/m6BkdN6QtFpuocikS9Yk++mGLxD0FChp+qm/WHPCuY/cZyY/aCykUM7JuR0JPAnOK60Bz/vMxzYPS9aw4NV+lkuLxeGjY0a/cCgBoFbEHEeiPZSzlkpO8P87cja8ksq/YAyMj0fwan7f9UEiMAxUII17iLJcWZoIDuJd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNJ6v0Zlxz4x1Y;
	Mon, 22 Apr 2024 18:18:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Geoff Levand <geoff@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <d64f06f4-81ae-4ec5-ab3b-d7f7f091e0ac@infradead.org>
References: <20240320180333.151043-1-arnd@kernel.org> <415f4af0-f44a-49fb-b1fa-76f64ed09ec6@infradead.org> <d64f06f4-81ae-4ec5-ab3b-d7f7f091e0ac@infradead.org>
Subject: Re: [PATCH v2] powerpc: Fix PS3 allmodconfig warning
Message-Id: <171377378379.1025456.13649802272990358966.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 18:16:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 01 Apr 2024 16:08:31 +0900, Geoff Levand wrote:
> The struct ps3_notification_device in the ps3_probe_thread routine
> is too large to be on the stack, causing a warning for an
> allmodconfig build with clang.
> 
> Change the struct ps3_notification_device from a variable on the stack
> to a dynamically allocated variable.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Fix PS3 allmodconfig warning
      https://git.kernel.org/powerpc/c/bfe51886ca544956eb4ff924d1937ac01d0ca9c8

cheers

