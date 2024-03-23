Return-Path: <linux-kernel+bounces-112146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F488763D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ACEAB22066
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217CEDE;
	Sat, 23 Mar 2024 00:46:38 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740062F52
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154797; cv=none; b=Bzu8ATEfUL9JG5GrpsmrfRYnHefK0t61H/ZwZEltk1TzYFc7GxHhrnZvRVKY89B7MD9+4M5vzxFgdIgxWdJRdZLauBKfX4cBNq/i6zkWKNoULtxfsioKLzBXsLmyMYsRdg3pL0vBMp6dutjDb8FppOVQ6Sqtn4eEF90vHvzP5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154797; c=relaxed/simple;
	bh=+K85rsbfJQhvVbqV28+LwaJiUZQ5tuvMEoY4KoXZ+QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YMM8Huh+CBFiC86y7ueBzKpEsPD09K8vGz3VbSBbgIVg4lhF0SMk2Fg26za/HragezpxpS+cj3DCb8CgoszpkOta0Ew5enNW7D3pCgwHxiDQK1625ToGlTC+poJ9Uu+lQ+EAzL3BOdOSPRPVuTAtpba24msKacXFbPtSpPXmrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1gVx4dkjz4wyf;
	Sat, 23 Mar 2024 11:46:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Kexec-ml <kexec@lists.infradead.org>, Hari Bathini <hbathini@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH linux-next v2 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP out from CONFIG_KEXEC_CORE
Message-Id: <171115475789.936455.12230073027482662538.b4-ty@ellerman.id.au>
Date: Sat, 23 Mar 2024 11:45:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 16:00:07 +0530, Hari Bathini wrote:
> This patch series is a follow-up to [1] based on discussions at [2]
> about additional work needed to get it working on powerpc.
> 
> The first patch in the series makes struct crash_mem available with or
> without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
> code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
> patch splits other kdump specific code under CONFIG_CRASH_DUMP and
> removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.
> 
> [...]

Applied to powerpc/next.

[1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
      https://git.kernel.org/powerpc/c/56a34d799bfa53064e7b8bd354aacd176aeaecc8
[2/3] powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
      https://git.kernel.org/powerpc/c/33f2cc0a2e90f7177c49559b434191b02efd0cd5
[3/3] powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency
      https://git.kernel.org/powerpc/c/5c4233cc0920cc90787aafe950b90f6c57a35b88

cheers

