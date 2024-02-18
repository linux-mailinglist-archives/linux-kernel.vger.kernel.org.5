Return-Path: <linux-kernel+bounces-70608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34538599C7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1216281715
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B276037;
	Sun, 18 Feb 2024 22:21:14 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542C745F8;
	Sun, 18 Feb 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294874; cv=none; b=h/dpz4qza7HxsTjMYNNmBg/jkdsOPXTPz4HcdZaJZrHRk7eA9J+QwvtCiP0ijmLPlxfSnnLwu5DB3JPW84z8JWZIcH7ogOh/HpnBb7MC2XUycn/NLuj1vz/2UJmu7cUQTxOI4oEZNGI4CBH6+5qbfk84/WeWEY61f5BHSdwgf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294874; c=relaxed/simple;
	bh=+stEjvwEshPruJnaSd7743lZYwerj31wMavbwUiF8lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMdcFGeziHoCeiPlLnOew0XGSLB1ChGph5ISBwi5k9uPwcw/p0doFrtG3jB7Xff9q5pqP1FAoC9A145Jw35QUcJH+TTnDTHPrdREsy0a5QUNH3WONGTT+iCUseUpX4j/5Tff2/1h+djy9Tgr20Ij6cCWrEbp/CWcmJ32S25YIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id CE2C414033C; Sun, 18 Feb 2024 23:21:05 +0100 (CET)
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
Subject: [RFC PATCH 2/6] ucsi_ccg: Cleanup endianness confusion
Date: Sun, 18 Feb 2024 23:20:35 +0100
Message-Id: <20240218222039.822040-3-lk@c--e.de>
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

When storing the cci value in the op_region struct it is
converted from host to little endian. However, the value is
read from hardware that is little endian according to the spec
and it is never converted to host byte order. However, the
value is used as if it where in host byte order.

Additionally, the message_in buffer is a byte array.
Any endian interpretation depends on the current command and
must be done in the ocntext of that command.

While all the UCSI world seems to be little endian and there
are many other endian issues if this is not true, this
particular value is treated with endian awareness, so it should
at least be done correctly.

Add the missing conversion from little endian to host byte order
when reading the CCI value from hardware. Additionally, make the
message_in buffer an u8 array and adjust the size macro accordingly.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index dda7c7c94e08..709295948c65 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -192,10 +192,10 @@ struct ucsi_ccg_altmode {
 	bool checked;
 } __packed;
 
-#define CCGX_MESSAGE_IN_MAX 4
+#define CCGX_MESSAGE_IN_MAX 16
 struct op_region {
 	__le32 cci;
-	__le32 message_in[CCGX_MESSAGE_IN_MAX];
+	u8 message_in[CCGX_MESSAGE_IN_MAX];
 };
 
 struct ucsi_ccg {
@@ -678,6 +678,7 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CCI);
 	struct ucsi_ccg *uc = data;
 	u8 intr_reg;
+	__le32 __cci;
 	u32 cci = 0;
 	int ret = 0;
 
@@ -690,9 +691,10 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	else if (!(intr_reg & UCSI_READ_INT))
 		goto err_clear_irq;
 
-	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
+	ret = ccg_read(uc, reg, (void *)&__cci, sizeof(__cci));
 	if (ret)
 		goto err_clear_irq;
+	cci = le32_to_cpu(__cci);
 
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
-- 
2.40.1


