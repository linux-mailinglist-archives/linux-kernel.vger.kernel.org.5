Return-Path: <linux-kernel+bounces-25128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2082C84F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEB91C22CBB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2382382;
	Sat, 13 Jan 2024 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rdKavcU9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cF5g6XDE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42376366;
	Sat, 13 Jan 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E803C222E3;
	Sat, 13 Jan 2024 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705105510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llJkPYV5jeYOy9aHiG/8PJePMPfFmAmBUSss2Ss3Zo0=;
	b=rdKavcU9ZgLcsQev/eu1Abe5xB9BgJn96sugN3iNDcDC6LDrOCPY5A0sn8MmpRw2d6z8Et
	lFxXFBsYrZ3j+r5cQYFRSuwbsB8WiGzCT93HRRo5RGKKIQ4ducGa6QWnXmWnFGM9CNig3d
	CWMSzL2xEVrggx3Ex0tkdNzlVXR2bdE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705105509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llJkPYV5jeYOy9aHiG/8PJePMPfFmAmBUSss2Ss3Zo0=;
	b=cF5g6XDEUa0GznWCk7ht5oyccWtOrAerizvUlfp+KwoKPoKRRKP6snvmEDPOyRbxad6m6E
	XS9s2yrt4inybcTl+Ma2ydWgvOPcgn1NM1hJqPL0Mg5x2aDFRhYpREO4f4XsOn3kOOI2kp
	IfSn6hXCViwkeyCxM93T/G77VSLs+hA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A08C213676;
	Sat, 13 Jan 2024 00:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mm98JWXYoWXIGQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Sat, 13 Jan 2024 00:25:09 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	afaerber@suse.com,
	ivan.ivanov@suse.com
Subject: [RFC PATCH] rpmsg: glink: Add bounds check on tx path
Date: Sat, 13 Jan 2024 01:25:05 +0100
Message-ID: <20240113002505.15503-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Add bounds check on values read from shared memory in the tx path. In
cases where the VM is misbehaving, the transport should exit and print a
warning when bogus values may cause out of bounds to be read.

Link: https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/commit/32d9c3a2f2b6a4d1fc48d6871194f3faf3184e8b
Suggested-by: Chris Lew <quic_clew@quicinc.com>
Suggested-by: Sarannya S <quic_sarannya@quicinc.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 drivers/rpmsg/qcom_glink_smem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Why RFC? The patch is adopted from the link above. It would be good to
asses whether such conditions can also happen with rpmsg glink.
(And if so, whether the zeroed values are the best correction.)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 7a982c60a8dd..3e786e590c03 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -146,6 +146,11 @@ static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
 	else
 		avail -= FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE;
 
+	if (avail > pipe->native.length) {
+		pr_warn_once("%s: avail clamped\n", __func__);
+		avail = 0;
+	}
+
 	return avail;
 }
 
@@ -177,6 +182,10 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
 	unsigned int head;
 
 	head = le32_to_cpu(*pipe->head);
+	if (head > pipe->native.length) {
+		pr_warn_once("%s: head overflow\n", __func__);
+		return;
+	}
 
 	head = glink_smem_tx_write_one(pipe, head, hdr, hlen);
 	head = glink_smem_tx_write_one(pipe, head, data, dlen);
-- 
2.43.0


