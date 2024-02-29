Return-Path: <linux-kernel+bounces-87598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8986D657
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555421F23A30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131626D50F;
	Thu, 29 Feb 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDw7oitb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF516FF21;
	Thu, 29 Feb 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243332; cv=none; b=sFqtdj5PQuDN/eWc3XWFy739MTH9uuVM1ggUacuqH1AqWi6bb8r8Tv6g23tt1tG6ArIoFuHXq7oCfC1t21YIGINKoPa1EKvncPgAZvbIwUzgXFak6PtSRVEfftl6tgPV+yrHZgr700uHvG5QwObqLI5CFoZ4RrwPlLJJuMiV8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243332; c=relaxed/simple;
	bh=WzBVNuU8gyYdqlnWzHeJD0lxBnSeUPUhpjVNqPa44jw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DfzEwkLNB8ZltVTnZs4RB932bQgff66Yv1qgfFuQbYulINGNVTK0HbdpJFG+acbA3zuIdDzmXv3lUPo20tLB+kfu9jdAFRzpifqKoHHOzcbMguvI2F5qREX0FGOq9L7DR1hdOAbwrMtku/AX2OCxEIXK/RydM3xa/EfoAphIF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDw7oitb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9948EC433C7;
	Thu, 29 Feb 2024 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709243331;
	bh=WzBVNuU8gyYdqlnWzHeJD0lxBnSeUPUhpjVNqPa44jw=;
	h=From:Subject:Date:To:Cc:From;
	b=ZDw7oitbKFVJM7q32xq0FubWrEZNpka1eFgbv6MixAG/ReUe4VJAmFg960pYSeqjV
	 I4t36ZA7dp3H4/Do3fe8olClbttZDCrejqG6b+jODdo1uvhG3y4L6UDzL2ixgMpCMO
	 o76SkwURe8C8p9maD9Lzx8DkeX+UJEwxJVyk73YmczdgZ2uwXm4VtEiYh4pnDtATme
	 ZvbKJt5ExYi3icRTLMBPliIt1baXBxpH0t2jYvn4QjxC87xVmlt03yEoXj7Nx4X+of
	 kVve1Hboo0hwjmam2GmRaRA1HwytulMGeL3Kdr0Eo3NN9kvJZlQMYp+9wSgObZXuBF
	 ZQpWc6HshZ1SQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] KVM: arm64: Store a cpu_fp_state directly in the
 vCPU data
Date: Thu, 29 Feb 2024 21:47:33 +0000
Message-Id: <20240229-kvm-arm64-group-fp-data-v2-0-276de0d550e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHX74GUC/4WNTQ6CMBBGr0Jm7Zj+AdEV9zAsGhigQWgzxUZDu
 LuVC7h8L/net0MkdhThXuzAlFx0fs2gLgV0k11HQtdnBiWUEUpVOKcFLS+VwZH9K+AQsLebRWF
 JV7ojZQaCvA5Mg3uf5UebeXJx8/w5j5L82f/NJFGgqHup6/JWypqamXil59XzCO1xHF9yuuvMv
 wAAAA==
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WzBVNuU8gyYdqlnWzHeJD0lxBnSeUPUhpjVNqPa44jw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl4Pu+i7B88JTtuAL3YxM8iBShhTXfFuBmsKTwDle7
 XUORxkeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZeD7vgAKCRAk1otyXVSH0LPjB/
 0b7ehU+vSkSpFfFlsDZ/3eZq7Ic6P3SALmeFu4XqK0LCCqd9O5eZTgDZvuucbafviaa4RIyn0QGpxZ
 CgIE5K96VT1GQdJL+ZONRV4C8OF2Enlahogdtzl0kNSNjy4OuWSu2jUk2IpjiaAhIR7nPgDyBCeCc9
 MfI+QXmxDwE4xP8xIWHeenTYySzu3ZdLMg2BCZXlKTG9DC3DKiP0KI7s9sdOdsciaSPAZA6Fx/sRY9
 WsUpHLZ9iXvrysMjbfry2jP3ua5+9qjWh4L9V4DBkB+8Mp0XlUKhAc2wjWl81zkbEUT5ghzNptP4Ef
 +wUSne3o0RaMj860eHu2LVtgqpfXcR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Simplify the binding of the guest state to the CPU when returning to the
host by storing a copy of the structure used to pass the state in the
vCPU data and initialising it during guest setup rather than creating a
new copy each time we exit the guest.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Remove stale fp_state local.
- Changelog updates.
- Link to v1: https://lore.kernel.org/r/20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org

---
Mark Brown (2):
      KVM: arm64: Rename variable for tracking ownership of FP state
      KVM: arm64: Reuse struct cpu_fp_state to track the guest FP state

 arch/arm64/include/asm/kvm_emulate.h    |  4 ++--
 arch/arm64/include/asm/kvm_host.h       | 25 ++++++++++++-------------
 arch/arm64/kvm/arm.c                    | 14 +++++++++++++-
 arch/arm64/kvm/fpsimd.c                 | 31 ++++++-------------------------
 arch/arm64/kvm/guest.c                  | 21 ++++++++++++++-------
 arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  9 +++++----
 arch/arm64/kvm/hyp/nvhe/switch.c        |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 arch/arm64/kvm/reset.c                  | 14 ++++++++------
 10 files changed, 65 insertions(+), 63 deletions(-)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240226-kvm-arm64-group-fp-data-0ae363ce24fe

Best regards,
-- 
Mark Brown <broonie@kernel.org>


