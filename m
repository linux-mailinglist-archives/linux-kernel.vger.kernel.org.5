Return-Path: <linux-kernel+bounces-154235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FA8AD9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6692871E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EF1586C5;
	Mon, 22 Apr 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c43VIKTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956D15884B;
	Mon, 22 Apr 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830077; cv=none; b=TS8DQclxEnzbQSRQIu1ScyJC+MkZwcwAk2vbcd3DMlQ/PlH+62HAA2lW3CvK9x3HcKMigymb33BE2CzQrfZ6GwNwTQhzEIg4AZ2uz5DS8HPKMZlDbrFgJtIn6UEKEygPfePrAqj893YU2nLprXGiU9ckf3tHTzFKnw+IcxLJmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830077; c=relaxed/simple;
	bh=ORyF3E69A5jDJre8UM/0l1GJc/YxLifcAcCq/V7oblI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU+Ag8iKUq+yjQZv0kcl6GbzjLVwxJ9bBAuozC/zO8ReXaZw7ZAzKI2LnSNAfiT3+LQC/A+zjXp5EbDxJrN5JM8VZk8G2MxC+YUkd4sCdR1XslwOxavMvpp8NWG4U2uBEQ6oNbDlBG2n7vOVqzXwLQ63uScZh4d7+2uW6w+SLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c43VIKTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F1C2BD11;
	Mon, 22 Apr 2024 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830077;
	bh=ORyF3E69A5jDJre8UM/0l1GJc/YxLifcAcCq/V7oblI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c43VIKTj1xZZIiHah4bqEmaXrkfgL7I9hJ1aFhty6SvLvKnxLNazolPVp5u7qFMwT
	 NX4ITlEY09jlImVAn+dWgapXE7+c7ZWE9FeLLByuq/kvgN+Q85yauXhnsMM/kJTdNz
	 R37Mry5kKjAIPPmJS9JjTUVSDcjh74tYXd5JF3Thit9fNiv8qKvovi6vR3r/l2MIoR
	 PBSfA2uq+Wfx19QTbWt37Pq0NopLKy79kCo9b4zhWqjeh6noVpqklEO6LIBg1U7zfq
	 K03iryT/Slk936vRyX5o/828cEr4M8c3vI3RIk2NoLOv+8AnSwu9LMDbHWBaLD9q1d
	 bwFtPq4Kqe28Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Wachowski, Karol" <karol.wachowski@intel.com>,
	Wachowski@web.codeaurora.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>, stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 18/43] accel/ivpu: Improve clarity of MMU error messages
Date: Mon, 22 Apr 2024 19:14:04 -0400
Message-ID: <20240422231521.1592991-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: "Wachowski, Karol" <karol.wachowski@intel.com>

[ Upstream commit 3556f922612caf4c9b97cf7337626f8342b3dea3 ]

This patch improves readability and clarity of MMU error messages.
Previously, the error strings were somewhat confusing and could lead to
ambiguous interpretations, making it difficult to diagnose issues.

Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402104929.941186-6-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 91bd640655ab3..2e46b322c4505 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -278,7 +278,7 @@ static const char *ivpu_mmu_event_to_str(u32 cmd)
 	case IVPU_MMU_EVT_F_VMS_FETCH:
 		return "Fetch of VMS caused external abort";
 	default:
-		return "Unknown CMDQ command";
+		return "Unknown event";
 	}
 }
 
@@ -286,15 +286,15 @@ static const char *ivpu_mmu_cmdq_err_to_str(u32 err)
 {
 	switch (err) {
 	case IVPU_MMU_CERROR_NONE:
-		return "No CMDQ Error";
+		return "No error";
 	case IVPU_MMU_CERROR_ILL:
 		return "Illegal command";
 	case IVPU_MMU_CERROR_ABT:
-		return "External abort on CMDQ read";
+		return "External abort on command queue read";
 	case IVPU_MMU_CERROR_ATC_INV_SYNC:
 		return "Sync failed to complete ATS invalidation";
 	default:
-		return "Unknown CMDQ Error";
+		return "Unknown error";
 	}
 }
 
-- 
2.43.0


