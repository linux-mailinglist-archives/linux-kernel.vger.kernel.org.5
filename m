Return-Path: <linux-kernel+bounces-150356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D798A9DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271771F23640
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF316F85A;
	Thu, 18 Apr 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn9CNOmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08A16C44E;
	Thu, 18 Apr 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452292; cv=none; b=HbnHvkXEgHaXaECNBFqB6bMHFSACJhLc/i1bqMaui+5zMOYrN7l1NtZ1QK4meHZad0jCg6Iskfc2/LYB0R+sC9wzB6wSEU3txVRbxzevTv/IVRFd96Jxbo8WEdzqPqsmxUsHOm7pYKZM8KVikHxMoZwiIOnPKzdq2TEEfaeZlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452292; c=relaxed/simple;
	bh=UK8vqYDQnVb4UuEiWOQ7/t28ga5C7zQ4CaigIsh4k3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayoeMhg9TC0O1DBYGedMdjcNivRaax4H7TBHdYu5PR0dWubVdOS3Mkb1fspACFGv8AkhrkAY5pI968y7jFTrQF2chU4V0An1hyhXpVG9wQTLxM6BL16+hD4QNoYRUzddnR3UjQlXReeMNEbuyJ1uS8xlriRpzKVcQ3mOu15/OhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn9CNOmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E47CC3277B;
	Thu, 18 Apr 2024 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452292;
	bh=UK8vqYDQnVb4UuEiWOQ7/t28ga5C7zQ4CaigIsh4k3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn9CNOmAuEatBytm3HjuegWQ0hIru7pceldtn92AnbKt2+bU2CWWXMS58cDbEstNa
	 9NQmyobuAmOc6OGSdMulV7gOBVmdhtUVJbraIF4tlLIlRFOD4xDuRije705U/Vn0an
	 t9LEzzXyVmHgdbjVkEhYLl5Y3S2dXHfTEb8X1mzBbiTfoMgoBFjkSvCPy67vnhQlZU
	 QiIhMH+X/MFz+gvBiBpGEVwzOKflLtkw4R8VMqqgVMqhi5Xiww2kCdzVGkq6I3W59r
	 c2MVgh53JAle7ZUoOyQkZbWxw7dgXsVImfnJEmwy7tZffSev2kF5QJ/iOpAY+FyIbv
	 xG8RM5UA+V5qQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rxTDK-000000001DR-2XFV;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: typec: qcom-pmic: fix use-after-free on late probe errors
Date: Thu, 18 Apr 2024 16:57:29 +0200
Message-ID: <20240418145730.4605-2-johan+linaro@kernel.org>
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

Make sure to stop and deregister the port in case of late probe errors
to avoid use-after-free issues when the underlying memory is released by
devres.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index e48412cdcb0f..d3958c061a97 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -104,14 +104,18 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 
 	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_unregister;
 
 	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_stop;
 
 	return 0;
 
+port_stop:
+	tcpm->port_stop(tcpm);
+port_unregister:
+	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
 	fwnode_remove_software_node(tcpm->tcpc.fwnode);
 
-- 
2.43.2


