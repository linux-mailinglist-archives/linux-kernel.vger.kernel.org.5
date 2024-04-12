Return-Path: <linux-kernel+bounces-143006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A38A3320
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85924283657
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FE149C55;
	Fri, 12 Apr 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxzXwe5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C27149C4B;
	Fri, 12 Apr 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938018; cv=none; b=XIGxU7IABxdIt7Uvbyep08r4haG3qdNo7PTATdcgmgEfmvvqCo77czNS63FPgUmH5fOGlOZqCuOxAL0RKG7y8vSG1QZlcKywW5XTtBrJPKARIyc8JJLmlVCdEcsZmtOnSAaKUheZMuWS0RKeprC6ynCIHPuGyQwhf9AW+5AA1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938018; c=relaxed/simple;
	bh=SZqKudt5FTC3rOk56xsVGwpEDU2VMNifDM266Sx+iGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPRNAOzmcNZjjNneIWiZVluc78BFy4DM//m3YH+wIj4ZA5OKNq7mJHEzdRnW8CQfiJ4j4Q51YD5oFugUObfzQdsAbm5ZHMLwDrjVUHC9Knw7WSZtsydBKOFW1exXGsBuRC62YOnkZaOLeGI311QqJVoZOKLlOborkn25AZz5w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxzXwe5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5684C3277B;
	Fri, 12 Apr 2024 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938018;
	bh=SZqKudt5FTC3rOk56xsVGwpEDU2VMNifDM266Sx+iGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxzXwe5hQ5iqF2Uz46pK7fVmMSBDUaAsnpFdInr154aJADcoWnU2k8kvJDf0r+prB
	 o33TvXiF89vIGIb+woV47XVvscUIsVsVLwbzplnqD0JphR+KHQGFQFpWRtwI06Jqm1
	 KZZolbpPt+Hq+KMPKdsO/bU0PnoR25fYc3Ol37Zt6TFfXfBf5PUSyWh//OOYh8GxQF
	 UhgwucXJlf6H8ykPnliExUIO62u2On2zfBPzTHgHWrCcGfB1aKquX6a/ssW7nYINYD
	 NQfN0g/wipFliifWbQV30Ni6DwEq87gdPjOIOs96U/EbHhecNPJVueo9k1qsi9R5Gb
	 lHZ+5pGFYi85g==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v12 0/2] arm64: Add a build target for Flat Image Tree
Date: Fri, 12 Apr 2024 17:06:42 +0100
Message-Id: <171293331329.145753.1710092313353102300.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240329032836.141899-1-sjg@chromium.org>
References: <20240329032836.141899-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 Mar 2024 16:28:34 +1300, Simon Glass wrote:
> Flat Image Tree (FIT) is a widely used file format for packaging a
> kernel and associated devicetree files[1]. It is not specific to any
> one bootloader, as it is supported by U-Boot, coreboot, Linuxboot,
> Tianocore and Barebox.
> 
> This series adds support for building a FIT as part of the kernel
> build. This makes it easy to try out the kernel - just load the FIT
> onto your tftp server and it will run automatically on any supported
> arm64 board.
> 
> [...]

Applied to arm64 (for-next/kbuild), thanks!

[1/2] arm64: Add BOOT_TARGETS variable
      https://git.kernel.org/arm64/c/0dc1670bd0ce
[2/2] arm64: boot: Support Flat Image Tree
      https://git.kernel.org/arm64/c/7a23b027ec17

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

