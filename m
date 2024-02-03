Return-Path: <linux-kernel+bounces-51096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1584866C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3451C2303D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261C5D908;
	Sat,  3 Feb 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZQD6GrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907D5D755
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965285; cv=none; b=iciDqNzk5ttRFUpX4J1NchdW9NzyCtbFXNK4Sb94l/Hho6fCplTM1bXPrkVu4n03bX8UmR2zcENSgB2EMll6KsCg7wSxuJG2pNh/huaTOkF0mCZObd/Nj3A/NvWgc1NZfbzZp06CcS5wp7BV1eY/WhTx3wWHzbLXfu71HV7dzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965285; c=relaxed/simple;
	bh=D3W1AsSUTP+B0YKV6vbmTQlyrvjF0RqEOhYOQor2mtE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bTDxCiJY9k4ECDYgfSKAOWXT3sh9eWRaFcrsTkz4hIGTLT22LPD5eHfd5qiHi9RsufXrHelrnH0t69xXPfNxUwSR+sn2BLnKdw4SDmJXuB8K4EONGjQKjFSVrP0zKJQnkshyfYcAt7Iq5G+o7LSQBcR2EOv5EoA4SoOKadRUN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZQD6GrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08212C433C7;
	Sat,  3 Feb 2024 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706965284;
	bh=D3W1AsSUTP+B0YKV6vbmTQlyrvjF0RqEOhYOQor2mtE=;
	h=From:Subject:Date:To:Cc:From;
	b=TZQD6GrFV2G+xwZX71EaBYFfeSfdGB3xv5QSX1iT2w/cWJKQr9TfHhgxXJvK+k0OQ
	 p30tiZXkajbvu0Cotx7TCw/YeahmB1x5wcQKZyx/0fMthMhpkYZAAGum+h0aHc4TQ3
	 efeuHLwnYYyMZ6smxwdj/TOXLEUoo6GuoTILRtIfT7zpKBTzdI8t87vBCZeUiDrPVt
	 tt1ozXuMT3WnvJlTehESbwjApoAGAzWT3iJv48JIfnjIXpsg6UX0qs/UEEqw9gnTQw
	 OZ1s1slCiNpSIUU/l6uq3I28eZM1RNJ7opk/QZYpo/9wCzaAAMR9vC0R9d+VAfAFS8
	 P+uvpyoltIIVQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] arm64/sme: Fix handling of traps on resume
Date: Sat, 03 Feb 2024 13:00:39 +0000
Message-Id: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPc4vmUC/2WNwQ6CMBBEf4Xs2Zrtgo148j8Mh1YWaJRCttpoC
 P9uJd48Td4k82aByOI5wqlYQDj56KeQgXYFXAcbela+zQyEVKGmWlkZTaXiyEo4PnOUZIw+INX
 kDOTZLNz516a8NJkHHx+TvLeHpL/tT1bivyxphQrZIDtn9bHtzjeWwPf9JD0067p+AMo2zi+xA
 AAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D3W1AsSUTP+B0YKV6vbmTQlyrvjF0RqEOhYOQor2mtE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjkSPyDD4qD02bq9cgLjmNpEkXRhypQErmtqaC0z
 lcggwOGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb45EgAKCRAk1otyXVSH0JkLB/
 4/6+XvC4MH7DTqdY/qRrhW2VVyJp/yA8nn1co9LeZGDg9eAn+Jkg5lcOVe/gI/ERmgtEV2SicTZ5sw
 vy76JP3CP1E4Pt1WXLJPd18j9VIYAY4ixLV8vp1xa+nGDSXfGUoci7mBRQ37rcQ5mLYNKk7BdXGnEE
 NbPhUXcNaYiNRM627fqtVCAnv58EYkOX2gqSxYP2c1dVwgQ7OplSahpFU0n8xlv38cYTWsuWrCDV3m
 1FN8yjGoF4j08KsMd0oSbajyGyy4OUwJIGooTZx2ClH6Tw/ffMcLhKbDkOq32pvPf3zzZ0tBwdQgWu
 V60Dj5j2mrpBNlu+xnUhRofEYLgDTp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fast model was recently changed to reset system registers to 0 on
resume, exposing the fact that for SME we do not restore the
configuration of traps for extensions that add state.  Fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Also reinitialise SMPRI_EL1.
- Link to v1: https://lore.kernel.org/r/20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org

---
Mark Brown (2):
      arm64/sme: Restore SMCR on exit from suspend
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


