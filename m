Return-Path: <linux-kernel+bounces-114170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0F8888D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4592897C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF7206078;
	Sun, 24 Mar 2024 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3bDG5Xh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831CD2057F8;
	Sun, 24 Mar 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321491; cv=none; b=rSq41UWjuigL4TyBBCz7p7x3M2vwUPSBkp2Denmz1cSdLG3wBi903UtJdv2VoNWvZuS0hPDVy3G1rZtKs0ZvsCJ95N0ZrIZ4WzW+PYBYpp1LW16Agi0sWZqD6weRbW5TVdiEGFx3izlUJ07e1+D2g72qCuCWuyh4DOY1sHoabfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321491; c=relaxed/simple;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcJMHpSyQ1laggAkFeLE+c7/SJE9/e3hJE61LWJsEiBe/6cS5bFMi9Imq9oOWMXhvSmjHeGm2sUacetGros+Ks89AucmqmFUXW4sEKG8l5dnUjZynNh+hZDXR2hsXdwaWFZSElCCvCL+Xc3e451E3TJ8ezKk4phuxP29zMTNK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3bDG5Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F7C433C7;
	Sun, 24 Mar 2024 23:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321491;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3bDG5XhP8y9pTqwOCJEGnlVojj9qIhi93MwWdn3EVz0XTkYvgS0mveV81oETMG5d
	 UIl+y0mTpTcyE7MqqKtWFBVVaAfss0u/RZfgI4Tl9wQEl2Yu+evIkCH/9KiMrKBZqK
	 tMnVW2vS3PkgP5ZeHIPX/Wdm+AXGPqQ3mHxmWEOXeH8QUoxff+COjzvSdymf56g1qb
	 DqO8NWZqyYx+Fo1awKO2NtEUkl+7tiI6kaVkcKRaIfD9EzXxbrAQ67czOxefPfM/TO
	 IuDJWE9R+08JNndr4M4Kk6k/b+mpzcA6GC1L/rlZjucovj+vfw7khhyRFQ4fHoFyRT
	 Cu0rNkNCNLyTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 216/638] wifi: iwlwifi: mvm: Fix the listener MAC filter flags
Date: Sun, 24 Mar 2024 18:54:13 -0400
Message-ID: <20240324230116.1348576-217-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 4cdb86487e3eaddb4b3a7df30ae709e810aac84b ]

One of the flags was from the wrong API.

Fixes: 9be162a7b670 ("wifi: iwlwifi: mvm: add support for the new MAC CTXT command")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240208185302.a338c30ec4e9.Ic2813cdeba4443c692d462fc4859392f069d7e33@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index f313a8d771e42..ad78c69cc6cb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -167,7 +167,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
 
 	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_PROMISC |
-				       MAC_FILTER_IN_CONTROL_AND_MGMT |
+				       MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT |
 				       MAC_CFG_FILTER_ACCEPT_BEACON |
 				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
 				       MAC_CFG_FILTER_ACCEPT_GRP);
-- 
2.43.0


