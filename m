Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3B806FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378335AbjLFMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbjLFMhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:37:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC1D4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:37:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A7C433C8;
        Wed,  6 Dec 2023 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701866264;
        bh=ADJ2QTgdrL4qnigrFQHFb2Ou59LIW/2P5BY+VaVUnI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqStE1Fje2FGe68gp0llFETF/lI7zCt6KDJO/DA8l7htMiMHkVP5pFCGhPpzkZE6+
         OLhZ7Qv8k2kRAzI0NgPlsCDy5yO7DxLtXndtu7ZQpRpSxx4nmct6h91JWitQP+7PbO
         t+Y3B8voX+GchPJJXMfZRkMuOLq35zi3F/apKfacUBNYaEU5xLrnZy3AA9pP/0jm1E
         MVB/lxNzKRvD/fYGBtSAgWfx+GvxFUOuSTlBwriNJTGhG7MCE1yxBcLrkiqzgfFc8o
         dqEAeiRCPlWg3EbghGzd6bH1nd9pIWZKfsAyzvtUcjZATiM6IswXXxoo5rXE56/hTS
         K8Fg5gea4PwKQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom_stats: add AOSS_QMP dependency
Date:   Wed,  6 Dec 2023 13:37:07 +0100
Message-Id: <20231206123717.524009-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206123717.524009-1-arnd@kernel.org>
References: <20231206123717.524009-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using the QMP functions fails in a built-in driver when QMP is a loadable
module:

aarch64-linux-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_ddr_stats_show':
qcom_stats.c:(.text+0x6f4): undefined reference to `qmp_send'
aarch64-linux-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_stats_probe':
qcom_stats.c:(.text+0x117c): undefined reference to `qmp_get'

Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index bf213b514a52..a55f9d6c392a 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -222,6 +222,7 @@ config QCOM_STATS
 	tristate "Qualcomm Technologies, Inc. (QTI) Sleep stats driver"
 	depends on (ARCH_QCOM && DEBUG_FS) || COMPILE_TEST
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP || !QCOM_AOSS_QMP
 	help
 	  Qualcomm Technologies, Inc. (QTI) Sleep stats driver to read
 	  the shared memory exported by the remote processor related to
-- 
2.39.2

