Return-Path: <linux-kernel+bounces-115375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82456889C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB60FB411C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591721F30D4;
	Mon, 25 Mar 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcCzmNJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615083A14;
	Sun, 24 Mar 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320633; cv=none; b=grberrzKoTw5cNsVYhxgstXHR0D0lGBbT5Ab/yW1lhnHi/6Pu6Lfx8bcSFNfPuwQOGeP6Bu7wE0blV0UDm4i8+Qf4grLNFtnl0p6Euv/8YheNFKxG5V+E1Wt9NIxvDYIZBHMeMNn0tSVEhjqbx7MCWHzkRKyyzePkY8l2/6T8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320633; c=relaxed/simple;
	bh=afXxZDuytKdo2b9kX8f74F3OLY83odqcQkTH0+MIdeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE4Yh1VdTeK64StQ4EbN/y8t0f7/lueZyHR9c0kvu0HM7huIQRykRLYbeaJkbWxcT14cpXSngS9uty+lUC/9lNUGUbsyPmTwELZ1emnFs2WLohjctxQaWtI4hIzmnG29pilCKpBmJqAPCMnE04JmAmS1+3jAX3wF411fwcxZCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcCzmNJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE6FC43390;
	Sun, 24 Mar 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320632;
	bh=afXxZDuytKdo2b9kX8f74F3OLY83odqcQkTH0+MIdeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcCzmNJeQSqGrXmOqica05m8Nr6S6aHWIC/G+oEXhRuQ56jD0aHiV55aa3XvkJLqC
	 LzR8yj8XTpPS2b9GOAvK6nb5SdMuscjHuHgzUqwXWIczxVfxFHMuUBflzYJBlmoobt
	 QetNKUu6maSnTOm9L75qORiVwFAlup3+uBz6XoSCbJmh/q/hdUkTMhPUhKrdjumaPU
	 m40mOuTkeuHvEKsOcfQ2ExQffkaMSw2JSngfFz/NUiBjARxOq/o8Z1ZyxtABFOnENz
	 aIlJD9/Ih30D2CdB1YGazU8yZ2J3SXYGdKUdbWNTnMY4fqrgAiKyoxWH7Eb/UcMGQY
	 6dtfP1OTWcO9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 194/713] wifi: iwlwifi: always have 'uats_enabled'
Date: Sun, 24 Mar 2024 18:38:40 -0400
Message-ID: <20240324224720.1345309-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


