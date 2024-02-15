Return-Path: <linux-kernel+bounces-66939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009948563D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924E91F25EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C612F596;
	Thu, 15 Feb 2024 12:59:52 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8F12E1C7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001991; cv=none; b=sR0JOoJ7ZpLzQSU0os1O+I5UgdRSeyuwlldaZigLe3ELlB9fxBCODrbbIuC1lo9VIy6dh7hI+nsnSWX2We0DjCHjlIX8N0S4nDSzUB3uUdmJN8VbwxshEUUULIqK6C2NREV7Ybi0NTXXjS4OwUgWoyMPmBdxiAE2ivlJasNK54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001991; c=relaxed/simple;
	bh=KOW6CW1R6T1RofAsuGzYSFK5XvFJ8rVlWVmsRwyXFZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yk2v58uhuZ1i7dVPI6ocCfl1feJQM/bS+J2MWVtm1cR3riTDAG7ZQt8ur8kINof5L48z6g6CHsOA5fyhzP2vLO9SFbX6q+d2giTCqF7XcOppVlf+Hsy2an0MFTO81kYb8AQOD/9M9ekk+v3RSl8GNGYACDdGT6gbizbR5scYg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX23Q7Sz4wcp;
	Thu, 15 Feb 2024 23:59:46 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, David Engraf <david.engraf@sysgo.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240207092758.1058893-1-david.engraf@sysgo.com>
References: <20240207092758.1058893-1-david.engraf@sysgo.com>
Subject: Re: [PATCH] powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E
Message-Id: <170800185785.599237.15747454436307843287.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 07 Feb 2024 10:27:58 +0100, David Engraf wrote:
> Commit e320a76db4b0 ("powerpc/cputable: Split cpu_specs[] out of cputable.h")
> moved the cpu_specs to separate header files. Previously PPC_FEATURE_BOOKE
> was enabled by CONFIG_PPC_BOOK3E_64. The definition in cpu_specs_e500mc.h
> for PPC64 no longer enables PPC_FEATURE_BOOKE.
> 
> This breaks user space reading the ELF hwcaps and expect PPC_FEATURE_BOOKE.
> Debugging an application with gdb is no longer working on e5500/e6500
> because the 64-bit detection relies on PPC_FEATURE_BOOKE for Book-E.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E
      https://git.kernel.org/powerpc/c/eb6d871f4ba49ac8d0537e051fe983a3a4027f61

cheers

