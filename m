Return-Path: <linux-kernel+bounces-113671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76328888E39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B841C2AF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A311DE9E1;
	Sun, 24 Mar 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZVo9yOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA6143895;
	Sun, 24 Mar 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320628; cv=none; b=sbgM3SHlpD/xHDOgn2hJgOUVhoCd6NIXD8TXVxgnn7HQ7Lx63EctWvBAskLHskkagISu2h8AWXBSX48mB/7T6/qygwTsOxCS2yFPxNuLI6wCfKLdEX07FppBO5Z+1YjwZ1mEvZ3AM4mTt2I/GsC9G7GBsxQ45onC9JGpoa9gbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320628; c=relaxed/simple;
	bh=500iziS17KIhNZFZcgB27dUjXGxBm1jMdkgOk0BtKh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ+1lUhSlSLGgnF4F0DPnhsVmShTqzDqZKrg5GcbAHMAGwDPE8JeqTY5z7OM0lFxF75Ubm3FmYmGjgizjuybpTDu0xqjIm2l+y4PKQHlioUmqTGh2D2pgI5jzH53Itej0LcsN9VPQN1JSG+KUcFKt2XpaU8xMtL45ZpZjzO3RzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZVo9yOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B5C43394;
	Sun, 24 Mar 2024 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320627;
	bh=500iziS17KIhNZFZcgB27dUjXGxBm1jMdkgOk0BtKh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZVo9yOC8lOSPAGbQ4jzOWbOrRVPM5f+x8CMMfOQ/UlrZpH8iF2eyYuOVwR6os486
	 ZzRrR0KTt66N4cih/gm6wRQm37c4DEuSEq7L3EKMKTDTcCmDvgkXn8ie/kr6MG5uPh
	 y4V8pj5YsnFkIhxLFjjsI7l4cOM/dAsbQFc7NVy/v6pfGlG5c6ukILgGPUbfs7IrjY
	 w8hihTVwZLr+eocNhzWAYNZN/pWhKtXn1Rsn7Ytmi/zhYuh5BERqI7aoKloZe6/pMw
	 PF9e6Stj73U8fzlva+XchLVFo1LgjzxhpQwpgWZHJnrJC0ZEGTEB0fQpktf9CLgVmX
	 dWl5zrTfM8ZJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 189/713] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 18:38:35 -0400
Message-ID: <20240324224720.1345309-190-sashal@kernel.org>
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
index 9160d81a871ee..55d2ed13a9c09 100644
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


