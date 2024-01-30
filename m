Return-Path: <linux-kernel+bounces-44311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3E842055
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC143B2FF06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA336A012;
	Tue, 30 Jan 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kk54gtem";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/FPxM7rK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kk54gtem";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/FPxM7rK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540C6775F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608196; cv=none; b=SWgR3Rc85f8gJgQM2iSlJv0K/P0c8xYayrZRD4AC7/uLAUzsHh1hL+OdhMeSE/O2MbjJTzRFuk9XLsu61p2hzKpTh8MM4urDRUU0EhNYMJXJjavNuZa7KYrqbn1qDhY+vkcKu8BZvKsF/TiXTf7rIxNgvidkZQMpj9B9lC1UaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608196; c=relaxed/simple;
	bh=mIZwEJGfu9NaCJqxMhgK8ij1RIeQD9q3/C0X3SvSVUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSSVlSB6JqT1ZBXgB5EuGvu8eK0710OZAfip5uu7zOLq/BF/Ce2i7DmcRxiXpLrGnWz+b9FV7kj8tdcYT6rPNd/b/V7XVwCY5K9MQ/Q2dOD40K5cekgfmoHeiZaaOG76P4+NBmDX7AEa5oOVneLR+3Q6Pe4yskm5Ewad1hBJnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kk54gtem; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/FPxM7rK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kk54gtem; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/FPxM7rK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 068E31F83F;
	Tue, 30 Jan 2024 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArsBVr4X2W3cBS3yrpUYNRtEX4mV/KoxFRj8N6+pwMQ=;
	b=kk54gtemSwGYIp4SkoPy6OEMRUHyd3dEDz3e+ZXMs8X60BtGZFqNnx7WiVmqxzJKCDjQIr
	NN7IiMX/3SUnCvwCEOuVi5mcq0y6O2FJFV99/xzIKJDDFayU7lIs2P4uKJiYMEirWvwd9E
	+o+GM9hgW4aT/71vMSfaYd9rLS9+onw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArsBVr4X2W3cBS3yrpUYNRtEX4mV/KoxFRj8N6+pwMQ=;
	b=/FPxM7rKSN973FmMkaA5HCNavTR8MiRdIzDhIqBhAVpM/v27F0ETJ9RmjWD6kuU+fW71H2
	0N5kEjkarjYV+TBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArsBVr4X2W3cBS3yrpUYNRtEX4mV/KoxFRj8N6+pwMQ=;
	b=kk54gtemSwGYIp4SkoPy6OEMRUHyd3dEDz3e+ZXMs8X60BtGZFqNnx7WiVmqxzJKCDjQIr
	NN7IiMX/3SUnCvwCEOuVi5mcq0y6O2FJFV99/xzIKJDDFayU7lIs2P4uKJiYMEirWvwd9E
	+o+GM9hgW4aT/71vMSfaYd9rLS9+onw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArsBVr4X2W3cBS3yrpUYNRtEX4mV/KoxFRj8N6+pwMQ=;
	b=/FPxM7rKSN973FmMkaA5HCNavTR8MiRdIzDhIqBhAVpM/v27F0ETJ9RmjWD6kuU+fW71H2
	0N5kEjkarjYV+TBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E84B913462;
	Tue, 30 Jan 2024 09:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 08dCN0DGuGWXbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 08/12] nvmet-fc: do not tack refs on tgtports from assoc
Date: Tue, 30 Jan 2024 10:49:34 +0100
Message-ID: <20240130094938.1575-9-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130094938.1575-1-dwagner@suse.de>
References: <20240130094938.1575-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.83%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.88

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 849d9b17c60a..fe3246024836 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1107,12 +1107,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1142,8 +1139,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
@@ -1180,7 +1175,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
-- 
2.43.0


