Return-Path: <linux-kernel+bounces-64504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F991853FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26331F2566B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F3629FC;
	Tue, 13 Feb 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOekE/Wg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FE62810
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865634; cv=none; b=XXsNyY33DRgaGWayPF5fH14aBCGQn5tceHTlLjwgbZsQMexCO7flloBymaWEzx1kKt6lak/dFmXwVChG5VZe7L+FySqL8zg+fI7GwE6/MVRyp1C7x9sXFQGKM0MhNdZyp6MIaddQtR5blVMjmctXB0U9GNhpzNSiwcmrVFBs/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865634; c=relaxed/simple;
	bh=f2Cdl3IDDtVePEix7n4iaiKSi9bMZGjncwLg38ulR7U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F+mRC2TN6q0ufyc3a+Fo55JFYM4xiS2toMvySyu3esyLVHxlrc+fK+zh5zTsZl6gsYoQhEVWaPL2iF3N2g0EleByMY2awuannBGWTCrH7f374W2Z17wqfu7yLAU45tsWcT0zLLhl8YWeKWS0mQ7AaVEy0tokcG5dMPiutLwXfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOekE/Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45A0C433F1;
	Tue, 13 Feb 2024 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707865634;
	bh=f2Cdl3IDDtVePEix7n4iaiKSi9bMZGjncwLg38ulR7U=;
	h=From:Subject:Date:To:Cc:From;
	b=qOekE/Wg1oH05btXKZszw40TIAQU+iF2PFDcEq+hVEad1Nfkdq6i02JSUtVf256+H
	 WKLoMOYOyUw74OSOnO6cPdFgaZtsqcSIEePdtyyBM0j0LrtMwqKoM4PfyAf+LfLAG1
	 7noTdNKjw7A6u/Mk/PRQKMiRfIVkhgTN6hiM1JZ6svoU6F+chPatQbF2GaQlAlH/Y9
	 P+KyWgm7KLQ8ZxVdkNkWiWequ2J0xmGIeiCzs1qqLo/Mex18HnwANbUTj/Lp0QGyVT
	 Mswr6YIkirZgjgfbG5AElRUIBByqqSn7sqE/vlUV5DM8WVFEBn6FBuEPuvCpOW51ID
	 zDgFM6eDAKulg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] arm64/sme: Fix handling of traps on resume
Date: Tue, 13 Feb 2024 23:06:31 +0000
Message-Id: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPj1y2UC/23NwQrCMAyA4VcZPVtp0644T76HeGjXbCu6TVIty
 ti72w1BRE/hD+TLxCJSwMj2xcQIU4hhHHKoTcHqzg4t8uBzMxCghYSKW+qN5rFHThjveSgwRpY
 CKnCG5bMrYRMeK3k85e5CvI30XD8kuWzfmBK/WJJccIFGoHNW7nxzOCMNeNmO1LJFS/ARQKg/A
 mTBysZZ72utofwS5nl+Af/ek9jzAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=f2Cdl3IDDtVePEix7n4iaiKSi9bMZGjncwLg38ulR7U=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTT3+RCY892RR1RDYhT7W0o+B9V0yW9ViFhrZKzwr3K0r1f
 v57tZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMruR/a+sWoy8GPdVrq3axQx6MZ
 N/HFTmvrmtYqfFfqv7pYV2zmm5gckrtjG1Srxec+52/5Ylp+qqbi99csrZLWaBVdLkxn72o/s3BEau
 Xvqz+/9EieMhn5/Yr/18ZocUS/S5I70LhJ+857QS9gmvNrHJE3BK9mueH6QaXKA99xB/f0OqQITJTr
 lNsbN7bYptlPplCxeKeN56U5Soqbg9nn2uwqnYKrf/91ZX3NDNdPDlClZnM5zrbZ+xdoGfQK3RDkWR
 zROEE9RkiwQWWMRuYBF53VPrm6tTblbY0eXy/9iFRetEr996LtjnduaYYJKelP0/+1d/S6o2potZNO
 5e6/k1UfHRvvA9ywx+/Tj7bcYbAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fast model was recently changed to reset system registers to 0 on
resume, exposing the fact that for SME we do not restore the
configuration of traps for extensions that add state.  Fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Tweak commit message.
- Link to v2: https://lore.kernel.org/r/20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org

Changes in v2:
- Also reinitialise SMPRI_EL1.
- Link to v1: https://lore.kernel.org/r/20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org

---
Mark Brown (2):
      arm64/sme: Restore SME registers on exit from suspend
      arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend

 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 16 ++++++++++++++++
 arch/arm64/kernel/suspend.c     |  3 +++
 3 files changed, 21 insertions(+)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240129-arm64-sme-resume-3266150292b6

Best regards,
-- 
Mark Brown <broonie@kernel.org>


