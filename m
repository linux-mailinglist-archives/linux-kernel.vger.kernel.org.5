Return-Path: <linux-kernel+bounces-74781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AB85D9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9354D288AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3687BB04;
	Wed, 21 Feb 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bt8o5309";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="37NDVbFc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MKJ/wCRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PKerYLw1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760E6A8D6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521857; cv=none; b=KwOeG3egMKdQH82atVZAfpKc7YYgnBhKsnuui3ezsyeZ8D3CSKoAPBcmyf4UU2cWMhNwTTtZ3V9808qCEDLIUFM+HsRgeJgBNtVMKZBdeNakKWqHe/9Td1tHjPg0MJBoJMAc200/V7j1+itDoafEJViCFPHQmZGzhrIwabplxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521857; c=relaxed/simple;
	bh=VokIuFmjRuTnELHVhNy8KTjZw+Ey716JcRtQTW4xQYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgd3qkGGUDBnRE7phiJibJoLjqn+32EZ4EWNcvKjpDyBSQht7NGpiPZb5F+7cR2IxO6ucd765zL1wKd717KASuQqt/Ev1POblGK3fC50Nvn34KdNeOcV1qqBCuMf48t9FvdgDacmNGktWaKen0LD0q/hIEL9/mYkjmFJB1t+SiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bt8o5309; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=37NDVbFc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MKJ/wCRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PKerYLw1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 247821FB5E;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=bt8o5309p5HfE53G3rEFxXwSbAAxJboiVUs27Iu9P6kjOAMg3p1GgKNbLwIQufdq1SxIpb
	MVFyReJfjdMqHGPOq9eX7BNX6eJvq0NMuFKDgY8TPrkbCKqn14coihhNJa7sg3pLcbij+s
	iGiRW6TLrMqTgCoLFWph6NrC/q6DjS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=37NDVbFcDWC/JTQoD5OOrpEv7n8FA/UVC6L4ZHlm8tLFyzGO3y2uiisR3VTBUppd2agNqU
	4UJRIZkemj/BxkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=MKJ/wCRS0lVQ3GQtDP5UabvLYVHP3t3K10yzf0yV8z3AV7W/VBKZhZXAlJBEmWmxMbD4vx
	hEN6B5iUuWp5Y4JlmKDtj7Q4g0IWQJCNwkwJIQnoiBihjdc6h3t+etjTt5/hJu7nkxK5a0
	dqTBoBg4oSTbo9IyVsIlSjPhWuRJ65c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=PKerYLw1o//fpgFUqZVkTBIU+dzuk5jnfTbSrAPM9aDNHL885fdNA9w4dOXlfAssmup0M1
	byC6AiyTyScCfGDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 100FE13A25;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1lc3An351WUVPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/5] nvme-fc: rename free_ctrl callback to match name pattern
Date: Wed, 21 Feb 2024 14:24:00 +0100
Message-ID: <20240221132404.6311-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
References: <20240221132404.6311-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.52
X-Spamd-Result: default: False [3.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.18)[70.40%]
X-Spam-Flag: NO

Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
pattern for the callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657b..a5b29e9ad342 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2428,7 +2428,7 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
  * controller. Called after last nvme_put_ctrl() call
  */
 static void
-nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
+nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
@@ -3384,7 +3384,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
+	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
-- 
2.43.1


