Return-Path: <linux-kernel+bounces-30074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ECF8318D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815AE286AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A024B3D;
	Thu, 18 Jan 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRmSCPG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D824A18
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579355; cv=none; b=qSzvlVurYzmq0RFXj/6ywSGnlo1u048UKO6xIm1Gs98gVE4ZVa+dUXLysu4wWXPLFPR7Tr33d+oyTpRi8vPN2Msbhin3FcD5ovgCcpEyk+JSE4DjyG76Y8MMFENcHgJkOGTtVP0m9oT0Uk0dVizqF4J9kPjkzP1WWnmvgAIKjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579355; c=relaxed/simple;
	bh=HkvjrkwPoNggfGuAt0QTtfV2Uq15mf6eeytkNTiLxjg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=cPZ1979MBNnv4EJtSE7LlEUylhrX5JnmnA4kKrXDDgWITMJEhuM3+qGHKU+900/sVKH1RzR6OX3tnV6lofCfmvsE/yOmOsSpSY8STlKDeX7ZSGYB1u/QkqDyiUE9JHQzqp1cWYeKiSZackifwmKZ26YMqX3cv4relWPdFULBi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRmSCPG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADEEC43399;
	Thu, 18 Jan 2024 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705579354;
	bh=HkvjrkwPoNggfGuAt0QTtfV2Uq15mf6eeytkNTiLxjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRmSCPG4c8zk/m88wFTLxVBuKiu1pY263ShdpOdSkrEq8baJkg/WmhQF9fZhtNFsY
	 aoENJugJl/Ihb6UdQSugaD+YoLBxn/bfY/qN6MIOjrZFNe8oWP9cHbsXHOswcqGds3
	 CsTucGDnKdBegk16/NtXEJ5GR/n79AauQaFEgVkfJApmRBqwJYa0kSSI2bsHFRIoVB
	 /sUnN0qHpcvXj4y0lOXflxmxN84B6Hjzabfxw0KxPh3sm70dcVVpWYq3evxlMveE65
	 UqQ7sW6NGByJhR/zpCOGPl/pV2ild7D9GBoHRvkvfXFzGcykAOgw9Q/JVv4225+ksg
	 q8GemRcNz98+Q==
From: Will Deacon <will@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH] arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrace
Date: Thu, 18 Jan 2024 12:02:24 +0000
Message-Id: <170557585754.3201244.6685336349493300608.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240115-arm64-fix-ptrace-za-zt-v1-1-48617517028a@kernel.org>
References: <20240115-arm64-fix-ptrace-za-zt-v1-1-48617517028a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 18:42:38 +0000, Mark Brown wrote:
> When writing ZA we currently unconditionally flush the buffer used to store
> it as part of ensuring that it is allocated. Since this buffer is shared
> with ZT0 this means that a write to ZA when PSTATE.ZA is already set will
> corrupt the value of ZT0 on a SME2 system. Fix this by only flushing the
> backing storage if PSTATE.ZA was not previously set.
> 
> This will mean that short or failed writes may leave stale data in the
> buffer, this seems as correct as our current behaviour and unlikely to be
> something that userspace will rely on.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrace
      https://git.kernel.org/arm64/c/b7c510d04904

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

