Return-Path: <linux-kernel+bounces-134447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0B89B19C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59377281729
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9680BF8;
	Sun,  7 Apr 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwy5vPC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23388061F;
	Sun,  7 Apr 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495570; cv=none; b=OiAelZ6d899tiZQ/tUSmoa2gTihtfG+bnFClhw8MiFT+3TJXqg8xJSBk7UMWzchBfFC469qAei4GyTi/KkoqhggiUWa/2KY/FnslvofIpvhCXrp1+AFtEYMegq/8KtFQRU2FL3nbd4qkZRVR+SaIXppSZsLodVSPUEhI7c6Qk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495570; c=relaxed/simple;
	bh=KC/UifnnPfnTwICglxYgoxM1RbpOw+SI6kqdSrP9hPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWa2FFTYZf4nDBN+xBU5FCa3DsOoZT7PgUYhQSGvYn3XMEMNh5ZIWvwBKDdIJVWx308EdsDeLtuLZ68vVk7WYhfG8Hc+AE/kQvzLDkpz0KmAnsEAXmcmxonJbkJLVrqO4A01SlUnm5Ss0/dZYCkai+HuAOI+FoiPHs8JbxO0eOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwy5vPC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E2C433F1;
	Sun,  7 Apr 2024 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495570;
	bh=KC/UifnnPfnTwICglxYgoxM1RbpOw+SI6kqdSrP9hPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwy5vPC4MIMEeSfmoeCnWveus2KlnnmoIlCyTLrinaNIrB3qpHQtHunMCeJZaSMzO
	 FCgeOHSQPaM4/PSuTScTvOJbze6Y9YODaS0RfWsERcyZtOqR0AemLQO+2OEgBQHmuw
	 CJ6Q5wOTNDTw2eaulJUCI75o10zNIT4+T7sMxZgRVg52UGQE3pzAsBwpcCo8yQJayv
	 jHozhbGee5f9qlKWLQ66vWje+i24CjSLQZWVB4FfN7Cz2RKzmJUf74VzSBlwMYCaeF
	 RRiE3fnM1CRpFcd6gr3azewsktdxh8sGO3V4cPdSfkd9DBBBJPo09IyUu5Jo2lJ0yN
	 CaQxl6huEQR0w==
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
Subject: [PATCH AUTOSEL 6.6 12/22] wifi: iwlwifi: read txq->read_ptr under lock
Date: Sun,  7 Apr 2024 09:12:11 -0400
Message-ID: <20240407131231.1051652-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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


