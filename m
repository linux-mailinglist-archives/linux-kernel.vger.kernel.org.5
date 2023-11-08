Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EF7E5C7E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjKHRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:35:37 -0500
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 09:35:30 PST
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3E1FC8;
        Wed,  8 Nov 2023 09:35:30 -0800 (PST)
Received: from [10.28.136.255] (port=50502 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r0mLO-0006Tf-Br; Wed, 08 Nov 2023 20:27:59 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1105.mail.hosting.nic.ru (Exim 5.55)
        with id 1r0mLO-0000zR-1w;
        Wed, 08 Nov 2023 20:27:58 +0300
Message-ID: <feeb1a89-59bd-4fd6-81a5-1d828f95b0f0@ancud.ru>
Date:   Wed, 8 Nov 2023 20:27:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] power: reset: msm: Process register_restart_handler() error
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Pramod Gurav <pramod.gurav@smartplayin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If registering restart handler fails for msm-restart result is not checked.
It may be irrelevant now (as stated in comment to register_restart_handler,
the function currently always returns zero), but if the behavior changes
in the future, an error at registration of handler will be silently skipped.

Add return error code and print error message too debug log in case of
non-zero result of register_restart_handler.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 18a702e0de98 ("power: reset: use restart_notifier mechanism for 
msm-poweroff")

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/power/reset/msm-poweroff.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/msm-poweroff.c 
b/drivers/power/reset/msm-poweroff.c
index b9a401bd280b..5877a1ba2778 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -35,11 +35,16 @@ static void do_msm_poweroff(void)
   static int msm_restart_probe(struct platform_device *pdev)
  {
+	int ret = -EINVAL;
  	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(msm_ps_hold))
  		return PTR_ERR(msm_ps_hold);
  -	register_restart_handler(&restart_nb);
+	ret = register_restart_handler(&restart_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register restart handler, %d\n", ret);
+		return ret;
+	}
   	pm_power_off = do_msm_poweroff;
  -- 2.34.1

