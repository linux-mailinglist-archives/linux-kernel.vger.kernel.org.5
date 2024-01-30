Return-Path: <linux-kernel+bounces-43664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C1841760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF4D1C23367
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55B9442;
	Tue, 30 Jan 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDG1TiGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533210FD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573669; cv=none; b=MBHcnK4ryEV6gIpWqWpn9diFvPPi5U7xQ2cSwYNs4QLM+QOoCtmxvQ1S/DVcxaSUyVeTvFFk/N+pKzVNQwA+/A7orjig/9uTgxuoLJAakrw6Y6e/EwVq0okZn4ChV5oGK9ZxmW3yCp15GjKdLmxggXbVl/G/UznVfOa3ZKKpz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573669; c=relaxed/simple;
	bh=1NRtCpz4VPp/Yq/drptQbUJSG0OlGHk6ih4YpuLMwd0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ucUZ+sADR6HoyXdR8EuMdAVdlDovVgqwBLygZ2mPojw4OUwaI/zi+PDomPfpRviV9Vq9A8W+9s8JvXfunXd2GuypjCeulUmXaeZuKnRdgAyjL4Iq4u0hwgl5F2m7DqrED6ojhJ8hTskPibfe/90xVCh/iMBH3r7gMvWMpEu79b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDG1TiGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ADDC433F1;
	Tue, 30 Jan 2024 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573668;
	bh=1NRtCpz4VPp/Yq/drptQbUJSG0OlGHk6ih4YpuLMwd0=;
	h=From:Subject:Date:To:Cc:From;
	b=XDG1TiGZnmqZRyhb3cWB5rG3jzsmmcFuKTGt63/+sUcWk78oP/QNRbVsWVp+IjQOj
	 gFpIqiCLP3ocb8ntszPvAQOIFt+kNo530cuWCI6ex1kUUcmCcRoeMfIYs2VMHHSm4T
	 t2WSCPLPM8oSD+vvafAuCk4agdr//p1TMi8nxR1MRRCn9hHtHM/FL7C4WaV4Nolb/m
	 mWvpkmR/zBIxvuI9UHufQpl1mEaOTcpuvFdDV6MGWVYolv7zP4WQkB0JWZFYbArDK9
	 FcFpuU979ZLqr+d0VaipwRZby2DSgr5IMOchHhAZD2tYZ0VXoix6JNWiqYx/SIx7D1
	 4EtHQ8af5usvg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/sme: Fix handling of traps on resume
Date: Tue, 30 Jan 2024 00:02:47 +0000
Message-Id: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKc8uGUC/x2MMQqAMAwAvyKZLbRRC/Ur4lA1aoaqJCiC+HeL0
 3HD3QNKwqTQFg8IXay8b1lcWcC4xm0hw1N2QIu1dRhMlORro4mMkJ4ZFXrvGosBBw85O4Rmvv9
 l17/vB+H+GhhiAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1NRtCpz4VPp/Yq/drptQbUJSG0OlGHk6ih4YpuLMwd0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBluD9gOXKfNU7diV0+qg2AWrCO5D3yOccSHLyLgY29
 UKDCaD+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbg/YAAKCRAk1otyXVSH0NWoB/
 0cENzSwzeB6KXF8FRfTtKsaIGfrtYF+2QzNvfF8lfAlrXEbQZ7t98iXQufi6L2v6Sj4rIY4S2+mlbL
 e0JOuyAKEAh72fjtSXhe9Asp7vRhCeB3ewhqAwlFIIV7cWTeG7q+iGJQ8N0FUVRV5y+JYAwMKh2GAK
 TmIb6xrbP9jFsA1SGn6+bd6JQTvEGdG0ulnl4XXk+B0VCzxuCLW9oXaaIpenxj/OKhwfaz1IBCmfK4
 ylPL18vJim5MjA8NhoqAmcHtGBaKsh64PdAweC3NPxwyeLjXcC7q4Qzm/b62qG/d5bVHqj5xx3yuxU
 U/IVpx/m3+Mz13pMHOQi1SvoLQR1Nc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fast model was recently changed to reset system registers to 0 on
resume, exposing the fact that for SME we do not restore the
configuration of traps for extensions that add state.  Fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/sme: Restore SMCR on exit from suspend
      arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend

 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 15 +++++++++++++++
 arch/arm64/kernel/suspend.c     |  3 +++
 3 files changed, 20 insertions(+)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240129-arm64-sme-resume-3266150292b6

Best regards,
-- 
Mark Brown <broonie@kernel.org>


