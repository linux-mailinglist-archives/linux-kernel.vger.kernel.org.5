Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20FF805B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbjLEPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbjLEPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:13:12 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E616A9;
        Tue,  5 Dec 2023 07:13:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id DC2D9186C6E6;
        Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9eDwiS4dHQIg; Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 8F803186C626;
        Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DwjuzGuN3um3; Tue,  5 Dec 2023 18:13:11 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.79])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B6151186C6DF;
        Tue,  5 Dec 2023 18:13:09 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v2] cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()
Date:   Tue,  5 Dec 2023 18:12:20 +0300
Message-Id: <20231205151220.18463-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2e919694-e124-4864-aa02-01d47495032b@wanadoo.fr>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_of_clk_add_hw_provider() may return an errno, so
add a return value check

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dumm=
y clock provider")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: replace dev_err() with dev_err_probe() as=20
Christophe JAILLET <christophe.jaillet@wanadoo.fr> suggested
 drivers/cpufreq/scmi-cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufre=
q.c
index c8a7ccc42c16..4ee23f4ebf4a 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -334,8 +334,11 @@ static int scmi_cpufreq_probe(struct scmi_device *sd=
ev)
=20
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
-	if (of_property_present(dev->of_node, "#clock-cells"))
-		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+	if (of_property_present(dev->of_node, "#clock-cells")) {
+		ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: registering clock provider failed=
\n", __func__);
+	}
 #endif
=20
 	ret =3D cpufreq_register_driver(&scmi_cpufreq_driver);
--=20
2.30.2

