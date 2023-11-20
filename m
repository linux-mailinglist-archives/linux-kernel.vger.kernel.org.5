Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40007F1909
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjKTQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjKTQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:46:26 -0500
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E8D6F;
        Mon, 20 Nov 2023 08:45:40 -0800 (PST)
Received: from [10.28.138.152] (port=50740 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r57Ox-0000kZ-BK; Mon, 20 Nov 2023 19:45:36 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1104.mail.hosting.nic.ru (Exim 5.55)
        with id 1r57Ox-002hz6-0z;
        Mon, 20 Nov 2023 19:45:35 +0300
Message-ID: <958b96ee-9224-4289-a3f6-b654d2b49f13@ancud.ru>
Date:   Mon, 20 Nov 2023 19:45:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH v2] power: reset: msm: Process register_restart_handler()
 error
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If registering restart handler fails for msm-restart result is not checked.
It may be irrelevant now (as stated in comment to register_restart_handler,
the function currently always returns zero), but if the behavior changes in
the future, an error at registration of handler will be silently skipped.

Add return error code and print error message too debug log in case of
non-zero result of register_restart_handler.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 18a702e0de98 ("power: reset: use restart_notifier mechanism for 
msm-poweroff")

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
v2: remove superfluous initialization, use specialized error handler for 
probes,
set poweroff handler regardless of restart handler registration failure
as Sebastian Reichel <sebastian.reichel@collabora.com> suggested.
  drivers/power/reset/msm-poweroff.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c 
b/drivers/power/reset/msm-poweroff.c
index d96d248a6e25..0d568805e70e 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -35,14 +35,17 @@ static void do_msm_poweroff(void)
   static int msm_restart_probe(struct platform_device *pdev)
  {
+	int ret;
  	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(msm_ps_hold))
  		return PTR_ERR(msm_ps_hold);
  -	register_restart_handler(&restart_nb);
-
  	pm_power_off = do_msm_poweroff;
  +	ret = register_restart_handler(&restart_nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register restart 
handler\n");
+
  	return 0;
  }
  -- 2.34.1

