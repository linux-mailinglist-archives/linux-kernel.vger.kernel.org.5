Return-Path: <linux-kernel+bounces-4692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134928180AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A281C21A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CF6FAE;
	Tue, 19 Dec 2023 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qvKgtpWO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D740BE79
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FRq7rIyAdCta3FRq7rLpYg; Tue, 19 Dec 2023 05:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702960580;
	bh=kg/q7rumzOx8Hl24GKVNgl/RrROwUKqK72wc4kbD3sE=;
	h=From:To:Cc:Subject:Date;
	b=qvKgtpWOoj4dZ6kz4iXiJrNQqE7l3qQNPalzgKRK2QqVljEog23aA11MgO7OVjQ4D
	 lV5bX8/tbcJ/oDgVc6LS+kvq0WvMWudFPLUREHVM+0pnJN/2m3TyAEwWD2mOExtGgF
	 ZeviyBnp6Z3OXgfwMrJH77HwMlVG//CwBUHbOAIPJKPYFZXArSWbqd/WHkQzlnEaJR
	 JBtoBYIUO49hcNIaz+uCnD5dn10f4do3kKO/bmmD1fNmopn9rtycfW7Hl+gazmAggz
	 3WZW4OcUBMJURMzxqbPBGM66x+YPhUrmo8hup1dejIGSdFbMQeDHdUGtpuPf3n3nXu
	 jXMgpqka5E5BQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 05:36:20 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Make QMI message rules const
Date: Tue, 19 Dec 2023 05:36:17 +0100
Message-Id: <7d0660a356a148bb800dcb0e211eca4886785a6c.1702960557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct qmi_elem_info")
allows QMI message encoding/decoding rules to be const, so do that here.

Before:
======
$ size drivers/slimbus/qcom-ngd-ctrl.o
   text	   data	    bss	    dec	    hex	filename
  30354	   1993	     96	  32443	   7ebb	drivers/slimbus/qcom-ngd-ctrl.o

After:
=====
$ size drivers/slimbus/qcom-ngd-ctrl.o
   text	   data	    bss	    dec	    hex	filename
  30738	   1593	     96	  32427	   7eab	drivers/slimbus/qcom-ngd-ctrl.o

Compile tested only.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 77aa6d26476c..efeba8275a66 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -220,7 +220,7 @@ struct slimbus_power_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -262,7 +262,7 @@ static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
@@ -284,7 +284,7 @@ static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -324,7 +324,7 @@ static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
-- 
2.34.1


