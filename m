Return-Path: <linux-kernel+bounces-134423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66B89B151
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B8DB21DDF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B85D731;
	Sun,  7 Apr 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCyH/hjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394DC5B5DD;
	Sun,  7 Apr 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495511; cv=none; b=SFcY8IyYDKTi5rHUrUiwWAMoPrzPEKIP6p62XHOH/90QuDXW/KLKzdroXTECjhMiYCqw2p/S68F1tdoPxy8gIc3ehRUzzXBclO7z44fk7hPZIRBMfTLqANi28Woce+0wcV49DX5OmBK1Ow/smQBcpB+MxnT/uynNhT5DidG9XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495511; c=relaxed/simple;
	bh=KC/UifnnPfnTwICglxYgoxM1RbpOw+SI6kqdSrP9hPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j89+KIB2ckpPOBIa7RBV4vyfaQkY4PmFswo/twupa2zzI2u3VicyESFwTHiRn2dWOyROgLg9yV/didINgmtl8SnvMsPnPMKZ34LVcOYZoXP83G07s5HnFVZIDzGwDNLBdbCdTrSw8r6x7tVwOwcDyKJP355XXRoiSrtD1S1IwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCyH/hjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A967C433F1;
	Sun,  7 Apr 2024 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495511;
	bh=KC/UifnnPfnTwICglxYgoxM1RbpOw+SI6kqdSrP9hPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCyH/hjNjNS/6i7AkB0p0DItgfplOaI2HyRIThyJAPG6dmyx4R8igY+i++5Hp7Lyz
	 RNHKR9B+YH5g2Qew7272EFYDGBSNFQ0C2UkW1Rx8eJZo5ZGKoLMr9oSgHCqpDwaElh
	 qnOE0m6F3h73vlus4wQaGjWUJ1XR3DBniGz+X8mjjbOQsE8gG7rVr6NSwgS0IzpW1h
	 COfSTn0igAKxHlkLyOxzFlULZskSd9nMEstMzCpvX2kd8odiWnril6u2kpwszxOxbo
	 w7g4qo/0BEdpPgQYxE7rzNJBdh6QxJc5R45tWKrhJUCxQ+1hrE6qBVNWLTEMlSX2by
	 UM4BDWE/NQlPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	kuba@kernel.org,
	pagadala.yesu.anjaneyulu@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/25] wifi: iwlwifi: read txq->read_ptr under lock
Date: Sun,  7 Apr 2024 09:11:01 -0400
Message-ID: <20240407131130.1050321-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c2ace6300600c634553657785dfe5ea0ed688ac2 ]

If we read txq->read_ptr without lock, we can read the same
value twice, then obtain the lock, and reclaim from there
to two different places, but crucially reclaim the same
entry twice, resulting in the WARN_ONCE() a little later.
Fix that by reading txq->read_ptr under lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240319100755.bf4c62196504.I978a7ca56c6bd6f1bf42c15aa923ba03366a840b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index ca74b1b63cac1..0efa304904bd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1588,9 +1588,9 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		return;
 
 	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
-	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
 	spin_lock_bh(&txq->lock);
+	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
 	if (!test_bit(txq_id, trans->txqs.queue_used)) {
 		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
-- 
2.43.0


