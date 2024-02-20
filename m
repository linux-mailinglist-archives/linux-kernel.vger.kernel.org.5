Return-Path: <linux-kernel+bounces-72520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D185B4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2471F21F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985185C60F;
	Tue, 20 Feb 2024 08:16:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64A53819
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416988; cv=none; b=TwRqlc/xl1ymx8oAA9B8ZvRaykkvviBuZx69jwuAVtf4GRBSMLc7h+J6hk0TqRFO4D6poggLqqeUZuGXcyaLMaBUVMOudd6v3yF+7xHbhS3Ln7tFoY8zg0lxFUQTmbgrMfPfWv8LMD5GH7e4Ph+Z2hozhq64lJmJXhCwg7W/qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416988; c=relaxed/simple;
	bh=g1EHi/WqOcNNnaGmzLYGdEE0tjJO8ATGZtEws8+sO2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D8LTtE+GIAmJ0jHFZ15VeQfbSs/4mo8fWFm/Snw9OPw/U2CT1hdsFWrBmusDrAWiBGB5E4Ss1kDyyXuMEI/xkDRmxBSb4eMxgPpRqOrx5ZDEXPCunNz08byB+bHQyvTfKSFWhljAqDK7rQPpkYL6wc2YD1/ZM821GbJsJu0FQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLIe-0003zU-Ax
	for linux-kernel@vger.kernel.org; Tue, 20 Feb 2024 09:16:24 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLId-001o51-UO
	for linux-kernel@vger.kernel.org; Tue, 20 Feb 2024 09:16:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9CD38292E29
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:16:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ACA61292E21;
	Tue, 20 Feb 2024 08:16:21 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aa76ddf2;
	Tue, 20 Feb 2024 08:16:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 20 Feb 2024 09:16:16 +0100
Subject: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAM9f1GUC/x2MQQqAIBAAvxJ7TrAtCvpKdDDbaglUXKkg/HvS3
 OYw84JQZBIYqxciXSzsXZGmrsAexu2keC0OqLHTiFpFcyuhJN6ePiS19dQMrV2XApQoRNr4+Yf
 TnPMHDt2Qr2AAAAA=
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=g1EHi/WqOcNNnaGmzLYGdEE0tjJO8ATGZtEws8+sO2M=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBl1F/Se2ksHfZe5EBj6QKPxoRNOdr4xE3O2uvaf
 MoZfkIDpPiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZdRf0gAKCRAoOKI+ei28
 bw12B/9VO1K8vR6SVTcAv/NKuk7fv9U6p4KoxoZRXV9l6BbMgaALSKomtAGh+77Opq5qFvmnF+t
 IMe0UCYYuiX52ijD/EsPtSOC6Z0x4tkezqYRStZBxl58888eFAC07sXpIEnkL8c81HisIAQZyo6
 L+Aqxt/cSZxOxJzZYWYJRjqZXpVGMnZQ8ykZw56VZteXejA3VmeBOkvakuGhC+wYe39ChdsxTuJ
 pgtZqPvvrfbym6f0QmZpfedFW6ulKffRlTUKulqT8079Sg1Nf6PkhZJH9QCnqzF1TyfJivJ9l2q
 WUiORXtLx0BJlD6t03nYNZug4ieMRDXFby+BORCSs3ylo7jm
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Reduce the scope of the variable "err" to the individual cases. This
is to avoid the mistake of setting "err" in the mistaken belief that
it will be evaluated later.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 897ffc17d850..2bb3eab98af0 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	struct raw_sock *ro = raw_sk(sk);
 	int len;
 	void *val;
-	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	switch (optname) {
-	case CAN_RAW_FILTER:
+	case CAN_RAW_FILTER: {
+		int err = 0;
+
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
@@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (!err)
 			err = put_user(len, optlen);
 		return err;
-
+	}
 	case CAN_RAW_ERR_FILTER:
 		if (len > sizeof(can_err_mask_t))
 			len = sizeof(can_err_mask_t);
@@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->xl_frames;
 		break;
 
-	case CAN_RAW_XL_VCID_OPTS:
+	case CAN_RAW_XL_VCID_OPTS: {
+		int err = 0;
+
 		/* user space buffer to small for VCID opts? */
 		if (len < sizeof(ro->raw_vcid_opts)) {
 			/* return -ERANGE and needed space in optlen */
@@ -839,6 +842,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 			err = put_user(len, optlen);
 		return err;
 
+	}
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);

---
base-commit: c8fba5d6df5e476aa791db4f1f014dad2bb5e904
change-id: 20240220-raw-setsockopt-f6e173cdbbbb

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



