Return-Path: <linux-kernel+bounces-161336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4104E8B4ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02015281CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD456B6A;
	Sun, 28 Apr 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwMuYQiM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91556742
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294771; cv=none; b=ddytoLbctSseoyMXB72t2jO/r+bCyo6SQS8GwAw3ToHAs6rwxSDj3PkQThMTJUFw5Cva8AzkAkmmTHt9NzaTdutfOcH36uJWIDB0BOw5Nd+5xiA3i1UAGcBdXlOfRVki2Gl+Pz97XRLndhE5Ce6wcGI1Whf/snMJo42jl3JXfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294771; c=relaxed/simple;
	bh=rW3sx+iJ4Wx7OjptAWofT0yBM2c/NmQi4Zu3B2fvcw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq0NcxydONf+YPghl3bguWTpTWZza0bUx6ml8NYviLsWr9vcD6OHB8B9anSDoPohWVsMQ2t3RBJW6SiCbHe4riH4V2gU+Se68e0PCc9+5NEGtlIt0QkmnHNr7C1w0Y+izDK1dDRMquD8NxWVW+7zV8Ivd7QH5EJvPJAzAfxOcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwMuYQiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D53C4AF17;
	Sun, 28 Apr 2024 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714294771;
	bh=rW3sx+iJ4Wx7OjptAWofT0yBM2c/NmQi4Zu3B2fvcw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwMuYQiMBMnQ9VAT4/jAyFaNRVbd+75f3LOyU+Dx4uBMGnV+HWD1jgnhGPXFVy4v9
	 PRJgDT0KbSptaltPv6jCbJkADAf/6hnnk51Gy83lTmGSjIs1qnujC4dl6k9BJoQKzc
	 Olwi5ao+8XkGUOhnDsd5oQfed2izk7LTDoLmVg6O+fjfPdueajLPnOGADTw9Ry51G9
	 bVpHTEEM2mQ9N2DMloeBnhE3OW39drS16Cps/FOyO24qg6hdZHhoWPtxbo13HGI9cB
	 VmkkqoxlgkeBm4RyYwnektaTH2637nesJDqfzdB1jFSn97bEXoBvfuI+/v65e2UbcH
	 nyQCYJFkp3Rig==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Shiqi Liu <shiqiliu@hust.edu.cn>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	miguel.luis@oracle.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	jingzhangos@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update PIE permission encodings
Date: Sun, 28 Apr 2024 09:59:16 +0100
Message-Id: <171428930771.1715055.15946640761283385227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240421063328.29710-1-shiqiliu@hust.edu.cn>
References: <20240421063328.29710-1-shiqiliu@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 21 Apr 2024 14:33:28 +0800, Shiqi Liu wrote:
> Fix left shift overflow issue when the parameter idx is greater than or
> equal to 8 in the calculation of perm in PIRx_ELx_PERM macro.
> 
> Fix this by modifying the encoding to use a long integer type.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/sysreg: Update PIE permission encodings
      https://git.kernel.org/arm64/c/12d712dc8e4f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

