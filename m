Return-Path: <linux-kernel+bounces-113018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE968880CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E11C2127B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3F4E1A8;
	Sun, 24 Mar 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6wvVavK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68583137907;
	Sun, 24 Mar 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319829; cv=none; b=XIcsJ3zpBmJstS1Qnh6cnG3rI3XDIhXJjfEiLiRnm3xjZkHpAdSO5gy6T2qS67DFunEK8asbh1nXVLrSC10Nn2qrxtV5IV7Dm3TfbtC/QV5lXRgJcY8rK2baBci+OwhLu5mTpndnuMhrbKGPHKHlny7YSoE1OwYVsmjHIi+tZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319829; c=relaxed/simple;
	bh=afXxZDuytKdo2b9kX8f74F3OLY83odqcQkTH0+MIdeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTZdnEUs9IK64Jw6UqPuBmKGZLHZjEflvKly8jQFtiHj9ProgLPJmPqvXzGQMGuTjryNfXwawgw5v0zqX0gEsAAV2fEcUMMrWXuNmrjTb8goOtTtd3PtXtmqycGgyvF4Wwm5xYRIpgpP2b80sc9AWr/DIRe9ghcdj/1JyAnf2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6wvVavK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2C6C433C7;
	Sun, 24 Mar 2024 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319829;
	bh=afXxZDuytKdo2b9kX8f74F3OLY83odqcQkTH0+MIdeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6wvVavK2NqTDt/omJukgnuy4LwgYAxxLFj+D6QvlZGOKjETJkjEQX22UY6WyMVhR
	 fah7WHP8m0lwztq4glgw9zcxTL5A6mbdzYmoMp1SvSAbFpiRtn1Ljg/WGoAwWWePCw
	 fJASypTfTKryt1HPdEAIDyPcmk1pLFXqijIo+Fq0BBxAm3GzWywhQ0aekSmUmGBGWQ
	 9ZfuwYEV0hAf+tHM8w2HDTzWz6LkvTCD0O7I6CIPAmGEUodvn0PCBXehov8oVHvz8q
	 LYcFl6VNp3wZSjkHC2jC/CXOR1SYYTnXLQCgyVDpK7KJBBTTPGCUWvihPeyKOwKD8d
	 L9n/ZtAG2hAyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 131/715] wifi: iwlwifi: always have 'uats_enabled'
Date: Sun, 24 Mar 2024 18:25:10 -0400
Message-ID: <20240324223455.1342824-132-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f639602a58e7564dd091c7c0793f61042bad9bb6 ]

We check this in code that'd be complicated to put under
ifdef (CONFIG_ACPI), so just always have 'uats_enabled'.

Fixes: 4a9bb5b4d949 ("wifi: iwlwifi: fw: Add support for UATS table in UHB")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.bdc5fb20f00a.I902d801d79873c5c9cd51cef8e8226e2acefe88d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 357727774db90..baabb8e321f8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -173,9 +173,9 @@ struct iwl_fw_runtime {
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	u8 reduced_power_flags;
-	bool uats_enabled;
 	struct iwl_uats_table_cmd uats_table;
 #endif
+	bool uats_enabled;
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
-- 
2.43.0


