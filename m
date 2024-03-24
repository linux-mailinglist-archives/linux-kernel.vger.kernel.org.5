Return-Path: <linux-kernel+bounces-115800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC836889938
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C938CB3D527
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46B3736DE;
	Mon, 25 Mar 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIUI9NNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD21145FE7;
	Sun, 24 Mar 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322045; cv=none; b=QkejbkkwV6zSc7geVR4r+BAZieU6jqUj4Df63Aghx87VEoYL4HVocm2XhKB2t2sjw8XLRDB/QoAuz8WbrtHFLmx0BBgndsZCp9KjEZ2Xlm3lykElISTPeJBmv3QshcHDCNyCx2zpAoI0BH29OVGsKoiQhQ0LiDKZVf/2dMYFCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322045; c=relaxed/simple;
	bh=BQQFxfC6hnWa2hVMYnRycBC5lDGGb9w3JnhkFlXJojA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaceHvq9jNp2325Pn+4QeaIz7Erap8tKGzpv0f/9KTuPgXUVqV7PZ3n6oVI2uYVcWRTJoT39biwKz+BaJ2P+RObA9s9r5Vpy4MwAGO8jy2P8uDLd6iwPB3OoJI7r+lQ+reBF5TMcobvksvxlYtxmge55NHl9pr23fFD293osyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIUI9NNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53816C43394;
	Sun, 24 Mar 2024 23:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322045;
	bh=BQQFxfC6hnWa2hVMYnRycBC5lDGGb9w3JnhkFlXJojA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIUI9NNwyk+s8U/wBeV6kfhfibp9d69MiSUM/8eSGFSkdxAgXv5HWG5NSYk3ezWev
	 DIHKTtU3kDTDi5hqyUWrzw7gsiSKKWTdVTA8yOnb5hW6FWo3lMfkj37OsrhQ4oGz+B
	 QWS7TuMW4sRRLFLaoTO5xS97eV9UPB6IK3sYkBvuepW9QiXmcfLv2fe4X6rns0D48n
	 BIAfNadX2AbXYXzCSKuKIbJXXhSkd34+zz0D19IS6Iaw3WeLE+xM88/QQZnwK7ldaL
	 D6pGVPVa0To8CYXiAAhbeoVnFmeXt3YzqZJ7Hm2Z80T+hSasNHaNP+8P5Z8bgo61it
	 /ocSOrZpqXuBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/451] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 19:06:33 -0400
Message-ID: <20240324231207.1351418-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit ea1d166fae14e05d49ffb0ea9fcd4658f8d3dcea ]

The iwl_fw_ini_debug_info_tlv is used as a string, so we must
ensure the string is terminated correctly before using it.

Fixes: a9248de42464 ("iwlwifi: dbg_ini: add TLV allocation new API support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240128084842.be15e858ee89.Ibff93429cf999eafc7b26f3eef4c055dc84984a0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 5979d904bbbd2..677c9e0b46f10 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -103,6 +103,12 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
 	if (le32_to_cpu(tlv->length) != sizeof(*debug_info))
 		return -EINVAL;
 
+	/* we use this as a string, ensure input was NUL terminated */
+	if (strnlen(debug_info->debug_cfg_name,
+		    sizeof(debug_info->debug_cfg_name)) ==
+			sizeof(debug_info->debug_cfg_name))
+		return -EINVAL;
+
 	IWL_DEBUG_FW(trans, "WRT: Loading debug cfg: %s\n",
 		     debug_info->debug_cfg_name);
 
-- 
2.43.0


