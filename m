Return-Path: <linux-kernel+bounces-73134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6685BE07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294F5B211B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750506A8A4;
	Tue, 20 Feb 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAiiaXqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6F6A32D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437885; cv=none; b=SiL4NKi2uq0S31OY9svM59oS7YwFSS4rEoopNPWqwt62PGo5oND/q8ECal6AMKUrMR73TgLjovJ5amWEX7SqqEl3+vzQkt8DG7CzETSgYe5IXJHwnJf1Bui+XBLFyqdhpNlBrr/fTwM60fIgAmWN/8gDzpxVLjsdVdSnWWc19LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437885; c=relaxed/simple;
	bh=Ve7lzopPQlWU2SF13ezexWDYpFsoJbsHtNnpmpXEG0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bk0ImlFfaVGt6inMiWn69gYeS6U3qkC8l8W79fOtwPvNsFKz2fxxV9AlIxv2+r5IeOpgdnAyICWzhFy2IOj4XVwW2FEXgQA/bJsVkmjn9VQBm90LiXtxV3DrsQ0EJLbEhGGGdkzuT89JuBV20xyeOvRnazCITRqIrIgmw35Z+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAiiaXqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B4C433C7;
	Tue, 20 Feb 2024 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708437885;
	bh=Ve7lzopPQlWU2SF13ezexWDYpFsoJbsHtNnpmpXEG0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAiiaXqz1GUZXsa4Jsv+xx/9SV9TydzyqfimjcTEgOQ/2dcPxBXxfBtHsbtOrjTTE
	 BkjmQMaf7xC+McqG1B1+NiWdlgMAeXry6Pcl9iHC72R9dC9rLD789MubjLZE3DJ0nF
	 lut83AS50+YqdBsaiaNE3UWS0KA/uZuzEybor4+PsJoxEPbdDycpwPSc1d6cwhWyEC
	 EqHDCvJsAklZPV132e+GDJDorweozgIHoJfSSaIKyZV9iypLrJexXrkf/kuCWmtl2m
	 ciZuWy0IdIDd7Y7pOCmk00lRaTVOO3XWjWlWm+QF5TMjLD2rysNU2UKIcPDCr+hKm2
	 3FPZ175a60lpg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 0/2] arm64/sme: Fix handling of traps on resume
Date: Tue, 20 Feb 2024 14:04:38 +0000
Message-Id: <170843155702.2619064.8773471291853791364.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
References: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 23:06:31 +0000, Mark Brown wrote:
> The fast model was recently changed to reset system registers to 0 on
> resume, exposing the fact that for SME we do not restore the
> configuration of traps for extensions that add state.  Fix this.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64/sme: Restore SME registers on exit from suspend
      https://git.kernel.org/arm64/c/9533864816fb
[2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
      https://git.kernel.org/arm64/c/d7b77a0d565b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

