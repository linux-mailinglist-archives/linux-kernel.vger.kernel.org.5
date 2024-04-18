Return-Path: <linux-kernel+bounces-150355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6A8A9DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C657EB26925
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0716F858;
	Thu, 18 Apr 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGPfueHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CC16C451;
	Thu, 18 Apr 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452292; cv=none; b=VYnf8SVhVQWWDMHx4uYMZtYNCQxPHopZFbvofHPcecSVt/1Di5EApzsER908EqTXeV3N44erLnkiPiv6Y28HsnF0sirIguKtzkaFB1Un9HZTzX9EogbuKAp2dQg+qMoAw1nJS51iiNxKlZjCzKk6mVdgq12fBQKNTtJNKJEZNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452292; c=relaxed/simple;
	bh=7w01AiG11Y7amIIDkVp7Po/rT6bsXkEo2AhSc//sXgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrRNlgNffAVHolSe8mDOHqaNBshgZFvt+McBMGZu334g0LDKkhsx0jlIhvTafGBq5JHJp3DlH0ZzFQMX59unj+ppifTN3dWIxoqhYHIWeQe8DHolRpZYx9amxYI856MQhtQeeanWn2yzAHWL1YTjt8SXGxPPNpvIcf3d2Xaialk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGPfueHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106E1C4AF0C;
	Thu, 18 Apr 2024 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452292;
	bh=7w01AiG11Y7amIIDkVp7Po/rT6bsXkEo2AhSc//sXgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGPfueHzJOPx7dUM8DqwQ2dk78uCt5nikkbAQpTi3dY8RhP3WEvCTqqNNehyPMb+R
	 1Ie+rJDj6tDsJPTyMSMvJ37OQsqF1wTXiMYSlFG9EBU4WBeeG4Knyv6q//d9647hr8
	 ZHM/IfXkGjDktkDHm6WCBxwDgeQfNg4waOvOVvNyWUU825UaXbWiCAF1B+zielsGw5
	 CG/1plURpp4WurkDQ2GUBVVqjSH0Mv4fp+fa13nI9N2xt5wb6y4Jdum0651LjKaMz5
	 TXIhQIS8rpC49HP0YxloM+kSuM1MkyNp4ugHYRH8Ae0VbHVdxIZ1GP9zOAXlBg/Hez
	 NxpRuLu9qPmOA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rxTDK-000000001DT-2uhC;
	Thu, 18 Apr 2024 16:58:14 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] usb: typec: qcom-pmic: fix pdphy start() error handling
Date: Thu, 18 Apr 2024 16:57:30 +0200
Message-ID: <20240418145730.4605-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418145730.4605-1-johan+linaro@kernel.org>
References: <20240418145730.4605-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move disabling of the vdd-pdphy supply to the start() function which
enabled it for symmetry and to make sure that it is disabled as intended
in all error paths of pmic_typec_pdphy_reset() (i.e. not just when
qcom_pmic_typec_pdphy_enable() fails).

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index 6560f4fc98d5..5b7f52b74a40 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -475,10 +475,8 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
 
 	qcom_pmic_typec_pdphy_reset_off(pmic_typec_pdphy);
 done:
-	if (ret) {
-		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
+	if (ret)
 		dev_err(dev, "pdphy_enable fail %d\n", ret);
-	}
 
 	return ret;
 }
@@ -524,12 +522,17 @@ static int qcom_pmic_typec_pdphy_start(struct pmic_typec *tcpm,
 
 	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
 	if (ret)
-		return ret;
+		goto err_disable_vdd_pdhy;
 
 	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
 		enable_irq(pmic_typec_pdphy->irq_data[i].irq);
 
 	return 0;
+
+err_disable_vdd_pdhy:
+	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
+
+	return ret;
 }
 
 static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)
-- 
2.43.2


