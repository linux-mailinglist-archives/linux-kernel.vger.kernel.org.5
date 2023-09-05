Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04C1792A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjIEQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352421AbjIEFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:48:19 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D3CCB;
        Mon,  4 Sep 2023 22:48:14 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 813A042438;
        Tue,  5 Sep 2023 10:48:05 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693892886; bh=FNIibyarmPCAlhz6Ut7njgzIVJSbI2KFycVZdOK+Y8k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZlMQIahqivMg5qgf4HoCWwNlGJ03pf471cQDuEwJx7eg2FFqLsfB+p6Dn9jLI1ohH
         q7aGcA7ag4Rzpa1fSjoYQSZQqH4jtO2ynnx6vL06jcQVg3VyeoSM61Ekm7KlpE8V3v
         8N6olMj+YTBh+Kc3q/NqLD5m57tUuLjKP7MLcTxNl+oRIAVfbCquRTOaKc7sgHzcI5
         9OQLvd/3+anY8jPRVFPvFJ3BhdZNfh9PB7aQN4IDPlAWY0QFZZt4Uz8wm9jlKVdwqs
         vZZaiem5q2TGK4OWeKe1cslsD7i5HTBN4AwfhBQTvOiUfneXkIOZ2ewWHQBnszLo2E
         GRoO0WQVC3D0g==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 10:47:21 +0500
Subject: [PATCH 2/4] remoteproc: qcom: pas: Add sc7180 adsp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v1-2-dfea7699da7b@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=FNIibyarmPCAlhz6Ut7njgzIVJSbI2KFycVZdOK+Y8k=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9sES7EB1wq5B6UO4nxi+pLIbjxoV1BRiWJzeX
 okiqqJyVpuJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPbBEgAKCRBDHOzuKBm/
 dbCxD/90/GNdCviEIycmofOnR8rYkSftPyXtRHnzgUntdy8H20yUGhHe0q1UmN2flbrbw6ZhV7d
 k+sj71GUx4CWh8/VjFGLA4bY7e6t6HXocvoRPa6bfeawLfLC1wRQ8965NUN562a7XxhV6yo7ev4
 RYU2O7qYMW6RI11DWigOkiowBKNYMa4pT6d0C/zF5fBmBerUp7me3NZRU5OFmS/HLMDX2EO8amD
 V61jjzE/SHXlsY5AZx7h+PlhPuDH6ZcXBcnzEIP1qR2I4rI0Dxlg5GDZ+uaItPnfq/G+vvQZwmW
 ju4kFtIVJkW0xN0ghJCybu4PCaSMpmmFaJzJ6NWj6o+a9+dDCNaCHUQfXJwfHsED6F/4eY54zW8
 KTN/GqXZMmBV20SfzYaKn4yeH21mb4mDXwTklM7Q2jYTtAsCPszqpM7KD6+BnC2/WDyNAfSapSh
 dzDt8YZde6XCu4bMx4oHRilaXI2YZqYzChQPhL/Y4CmZFUB7dC+I3aa6c4kVREB+6X09Xs7AQ3z
 sVNly0RjFQq1HS4+O9TYj+QY6qhk40SW82qsNmu/3VDxvhZunTeid8ss8whTRBruDIjFTMWytGT
 QMSHWXgPFyl+128+BY85pASUoIEf5h7KxRgeApWVlpa5SCo2+572EGCIUoh8LSDLnX4mEz6ARw8
 Mwil35HAz196peg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 has a dedicated ADSP similar to the one found in sm8250.
Add it's compatible to the driver reusing the existing config so
the devices that use the adsp can probe it.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b5447dd2dd35..55fafc68200e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1161,6 +1161,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
 	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
 	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
+	{ .compatible = "qcom,sc7180-adsp-pas", .data = &sm8250_adsp_resource},
 	{ .compatible = "qcom,sc7180-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sc7280-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sc8180x-adsp-pas", .data = &sm8150_adsp_resource},

-- 
2.41.0

