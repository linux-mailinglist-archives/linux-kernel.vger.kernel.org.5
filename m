Return-Path: <linux-kernel+bounces-27815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA382F649
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2531C23D84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC042D635;
	Tue, 16 Jan 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmAMsNb7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5A2D627;
	Tue, 16 Jan 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434268; cv=none; b=XkGLsFE6ScNreEn/lfM0ZvJCyzW1UFjtmCWlwaqZ72U/1CNSa0L6ZtGslDt6WmG31yp6S8Kn8SEy8Cx6/upsX5F3y2/appryTPdqquV33r5UkKIk0Z0dZCSZOBp8yAsLJktWPK/lnmVs4u/cVrChMDE3JxM9MWEPQqRz2H6yjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434268; c=relaxed/simple;
	bh=rBoYvdVS2YzR0spwdUAt2VoFNa3jDoAge0YXkInyX40=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=VzmStTB4VdtdzAybuq4GcEYmnLR8SU4ciYw81R8U/384gew23p2KBEjLPUCRDxAszQCJI9G1ICls2CnAWZjsOP3kOKjW9wck/Us+XxW/8bcKxzXHSehfVOj8HT5JoKPUsKsCAn3oOgVtXQVzKMkhDi7M8OWGuqXT4tgSJE2yoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmAMsNb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AAFC433C7;
	Tue, 16 Jan 2024 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434268;
	bh=rBoYvdVS2YzR0spwdUAt2VoFNa3jDoAge0YXkInyX40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmAMsNb7tVWHBTJL3kbnAb3a0WaT01oiSwMFOpJOhOk3B24fq4Ep3DovPPRxAYRRp
	 TzXLJn2yb5J+1qTmARvpqvOxuaBs9XQinHYHgEPDlknrtJhaYfqJt8t0w9AWNB7trI
	 vWQKmmJ2OOWUb7/d90nBTQTa5kUpS0M61gu/C1OMm2nXHavJbeUn2MieIBQQcvVbsV
	 /SgKpdRTjP467CSnMvSan2f4aa+j1hI7MymZXWo4kVXZTftoDVp2AQ1UEM1LUkcJV5
	 mCgn2yrp3rXZUNod8+Irvb7x4vAEt6xPayKEujOLqImKQDs8JIICGFgLaZtOcKPQjF
	 UTRXc3oNLYMSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	fabrice.gasnier@foss.st.com,
	quic_jackp@quicinc.com,
	saranya.gopal@intel.com,
	quic_linyyuan@quicinc.com,
	andriy.shevchenko@linux.intel.com,
	minhuadotchen@gmail.com,
	johan+linaro@kernel.org,
	robh@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 044/108] usb: typec: ucsi: fix UCSI on buggy Qualcomm devices
Date: Tue, 16 Jan 2024 14:39:10 -0500
Message-ID: <20240116194225.250921-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 1d103d6af241dbfc7e11eb9a46dff65db257a37f ]

On sevral Qualcomm platforms (SC8180X, SM8350, SC8280XP) a call to
UCSI_GET_PDOS for non-PD partners will cause a firmware crash with no
easy way to recover from it. Since we have no easy way to determine
whether the partner really has PD support, shortcut UCSI_GET_PDOS on
such platforms. This allows us to enable UCSI support on such devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231025115620.905538-2-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c       |  3 +++
 drivers/usb/typec/ucsi/ucsi.h       |  3 +++
 drivers/usb/typec/ucsi/ucsi_glink.c | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61b64558f96c..5392ec698959 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -578,6 +578,9 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 	u64 command;
 	int ret;
 
+	if (ucsi->quirks & UCSI_NO_PARTNER_PDOS)
+		return 0;
+
 	command = UCSI_COMMAND(UCSI_GET_PDOS) | UCSI_CONNECTOR_NUMBER(con->num);
 	command |= UCSI_GET_PDOS_PARTNER_PDO(is_partner);
 	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 474315a72c77..6478016d5cb8 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -317,6 +317,9 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
+
+	unsigned long quirks;
+#define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
 };
 
 #define UCSI_MAX_SVID		5
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 4853141cd10c..53a7ede8556d 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -6,6 +6,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/usb/typec_mux.h>
@@ -296,11 +297,19 @@ static void pmic_glink_ucsi_destroy(void *data)
 	mutex_unlock(&ucsi->lock);
 }
 
+static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
+	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{}
+};
+
 static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 				 const struct auxiliary_device_id *id)
 {
 	struct pmic_glink_ucsi *ucsi;
 	struct device *dev = &adev->dev;
+	const struct of_device_id *match;
 	struct fwnode_handle *fwnode;
 	int ret;
 
@@ -327,6 +336,10 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	if (ret)
 		return ret;
 
+	match = of_match_device(pmic_glink_ucsi_of_quirks, dev->parent);
+	if (match)
+		ucsi->ucsi->quirks = (unsigned long)match->data;
+
 	ucsi_set_drvdata(ucsi->ucsi, ucsi);
 
 	device_for_each_child_node(dev, fwnode) {
-- 
2.43.0


