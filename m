Return-Path: <linux-kernel+bounces-55317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8E84BAEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2711C22EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9441350C4;
	Tue,  6 Feb 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkWsDSNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC72134CCA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236871; cv=none; b=GiaCOMR1kOUua9QHMDT/xFQ5Wq6uYh++WWI0SQWG2F1AlM3aWN9x1QNKjyx/w8X9/dltiECikGSH9iNYg9gFvjurfjJ6FoK6bs0eeYb30Bf5JKj7nxqh3ftHMeamO4MKvm8HNkk0PixRtZuURdP4wqVE/pFTyzN0j2uMB2SUtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236871; c=relaxed/simple;
	bh=fRog9coSpdrDKRPeW6Hy2Z/gSCmjUBq/+m0a/5NTav8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WHenfj5dAC3zHA8CzPn+3XLz3zzCFEeJIfPXzQ5It9iGQ9a+tCiaugs8uwAcjxwrRhA8jrrutBaCgmix1fp6wUx7ACi+rFtRw9cK1E7jr4K4qlu+5gs2sgpgO6EoKU540IOxmMYvBgHRbkWD9UYIlciodsvqc1ketilb7jUTZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkWsDSNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E20C433C7;
	Tue,  6 Feb 2024 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236870;
	bh=fRog9coSpdrDKRPeW6Hy2Z/gSCmjUBq/+m0a/5NTav8=;
	h=From:Date:Subject:To:Cc:From;
	b=OkWsDSNoWY8FCQEgO0G6MAYEFLmLRO8xubuBvugziOoPoxa+xMwSX76yMmr12AuKB
	 kDq4nVyMnVWtGMHzpaRfHUrGzzhT6psrIG9XSClj56+WQsNhVvaUU99P6DQah5GWlU
	 gGsYkPZI/lqtNyp0AqDZY1V1GMisS08d7ECGlwwWbGC/XZvnoqJQ1ttmomFFpyc8za
	 zD9VlzAQTImWKTEd4q7MWl9KhTA3gKPCF/rpLbsgBYjtCExQuaDtFRpqGgIzVNa2g0
	 fWO26Gk7/IXE4M9tSHl6nzEcewLCE6uesbB7YSyOxAB7YEaBRYumJK9xP+neZ//Ol9
	 9csjNBKuwt5ug==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Feb 2024 16:27:01 +0000
Subject: [PATCH] arm64/sve: Document that __SVE_VQ_MAX is much larger than
 needed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>
X-B4-Tracking: v=1; b=H4sIANRdwmUC/x3MQQqAIBBA0avErBswMxddJVqIjTWQGhoSSHdPW
 r7F/xUyJaYMc1chUeHMMTQMfQf2MGEn5K0ZpJBKSKHRJK8V5kJYTvTmQRu9p3CjVuTM6MSo5QQ
 tvxI5fv71sr7vBw/DDWdqAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fRog9coSpdrDKRPeW6Hy2Z/gSCmjUBq/+m0a/5NTav8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlwl4DLTjeWojBDQwiaeCesLKB01RBMye6iqVO9
 W/87/JHKN+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcJeAwAKCRAk1otyXVSH
 0F8KB/0dwrDLgl+VpeCMPKSQvsPK0/ZbXt8jR6xLiS04IOvrXQptZgBHtWmY/f5KIQSTdnRkHoj
 ksAn9CfWWvpUy91iB65q4RxXcGgSE+htmYdXM9ZxdV2RaAzTCVCyjtl6/npVzY4f91tUTx1oqXT
 h7QwjfMJCTjPfTHtHspOrjSA9WcBOKOqhCTsLxMlYg78TxnaJkSkiloydk3Epp7xUUcDK6JsKjX
 bfjBKLFnebOVearwBWJ5Dr3c4qGL8DuyQvVtQ5Ur5wu1TT7jL6IFNwu6IfVoQsalQ238+JpdS1H
 VG2dtOHIhTs2/EjyTMp99SfQqxjOzAw4CpymanzQw5TPUzev
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

__SVE_VQ_MAX is defined without comment as 512 but the actual
architectural maximum is 16, a substantial difference which might not
be obvious to readers especially given the several different units used
for specifying vector sizes in various contexts and the fact that it's
often used via macros.  In an effort to minimise surprises for users who
might assume the value is the architectural maximum and use it to do
things like size allocations add a comment noting the difference.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sve_context.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sve_context.h b/arch/arm64/include/uapi/asm/sve_context.h
index 754ab751b523..59f283f373a6 100644
--- a/arch/arm64/include/uapi/asm/sve_context.h
+++ b/arch/arm64/include/uapi/asm/sve_context.h
@@ -13,6 +13,10 @@
 
 #define __SVE_VQ_BYTES		16	/* number of bytes per quadword */
 
+/*
+ * Note that for future proofing __SVE_VQ_MAX is defined much larger
+ * than the actual architecture maximum of 16.
+ */
 #define __SVE_VQ_MIN		1
 #define __SVE_VQ_MAX		512
 

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240206-arm64-sve-vl-max-comment-64efa3f03625

Best regards,
-- 
Mark Brown <broonie@kernel.org>


