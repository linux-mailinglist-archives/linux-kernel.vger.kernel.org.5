Return-Path: <linux-kernel+bounces-70607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B004F8599C5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB071F212F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE676023;
	Sun, 18 Feb 2024 22:21:14 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F6745D7;
	Sun, 18 Feb 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294873; cv=none; b=PCiofYbiDor9OXtRd2tN122CdPy0e25VO/w48CAT6u1xPA68wP43X2TxYjbkC8Pcy9H0cpQfxgeGGvJ0T5DzBXX2yjFkIOYcXtHdzkzsaCg8bzxYXNzxDA4NxkYwXHJOEGW0pEJgu19MyWSHUCOermL/DRTiZ6q6uLkMCZQMZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294873; c=relaxed/simple;
	bh=+oUmu5Lwbn9zC+hXil5i/V1qhWii7H7GOEZRyRLVGsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Saj8JFilm4DfvwJffk3vsjEcDaTgUttyFEliUthI05bqPl6bBWFuNOcP9RqZci3VeAdHh9kzLvjHsqMucmUYinIvTXW4TzcxB0e9uf4QjJS76AgBEb9BDpYfxVCMTMLUfhBziQ3wGCDWM7szUbZuNt/B69IZqUsojCOLBcdoHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id E687C14028D; Sun, 18 Feb 2024 23:21:04 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Min-Hua Chen <minhuadotchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [RFC PATCH 1/6] usb: ucsi_glink: Fix endianness issues
Date: Sun, 18 Feb 2024 23:20:34 +0100
Message-Id: <20240218222039.822040-2-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240218222039.822040-1-lk@c--e.de>
References: <20240218222039.822040-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse complains that some little endian header fields
are assigned from plain integer values.

Add the proper cpu_to_le32() calls.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 0bd3f6dee678..0a0d08467c56 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -85,9 +85,9 @@ static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
 	unsigned long left;
 	int ret;
 
-	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
-	req.hdr.type = MSG_TYPE_REQ_RESP;
-	req.hdr.opcode = UC_UCSI_READ_BUF_REQ;
+	req.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_USBC);
+	req.hdr.type = cpu_to_le32(MSG_TYPE_REQ_RESP);
+	req.hdr.opcode = cpu_to_le32(UC_UCSI_READ_BUF_REQ);
 
 	mutex_lock(&ucsi->lock);
 	memset(ucsi->read_buf, 0, sizeof(ucsi->read_buf));
@@ -122,9 +122,9 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 	unsigned long left;
 	int ret;
 
-	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
-	req.hdr.type = MSG_TYPE_REQ_RESP;
-	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
+	req.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_USBC);
+	req.hdr.type = cpu_to_le32(MSG_TYPE_REQ_RESP);
+	req.hdr.opcode = cpu_to_le32(UC_UCSI_WRITE_BUF_REQ);
 	memcpy(&req.buf[offset], val, val_len);
 
 	reinit_completion(&ucsi->write_ack);
-- 
2.40.1


