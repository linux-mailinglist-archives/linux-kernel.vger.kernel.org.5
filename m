Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A87EEC71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKQHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:06:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC6D51
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:06:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a909b4e079so24788507b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700204764; x=1700809564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ag4QJwAFTMvtxQitzc3wtKGcikFcJHkhggRFwsEsrq0=;
        b=wYbcyismUeYAijn1luK7Jw1lzwWusAjVrj34nY4wxVco1FKhDa1tQ252xFXxT1EaZY
         JpK4j5T68fvlPrFG9X7rP/8qqIouLoUsCiOXgsYOwXP/3h2ilAtJoMyo+p7irUL2qqS/
         nIPu+hR0Y54VkQo+WjHrfhZINVbN/Mooa4TqJCr4/zbLXPO/d1fO3DfZra/7tdPaW+8h
         ko7qxLAzUfDNek/mwFF2T3ejAWC3PRPsoTVMvTCt96zfP7BOsMy/wtNp3A/PUwbqWqpd
         0NtI2LEXNeizVfmMFuwqTfSFxga5ldIN7xm4+FIF2jCj/eQAZh2qxqWjGHDAx9yyPrbr
         OcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700204764; x=1700809564;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ag4QJwAFTMvtxQitzc3wtKGcikFcJHkhggRFwsEsrq0=;
        b=KkCXZcx6jGkKH1b1+ah1LdwQXUibJlKKBwB110tiWw3xgIEJcbQxgntYP2yaEG6ZJO
         8c19bMv1w6fU4optIVHEYvSoWiKQRQzZYRUAoCGyJSuB6YP3lxEGWTANk0Tsi5erDsbh
         /dKY0z9tZcL+opiEoS/8DTK5d7JZDPsMNk9+fB0WOSrDRQIXw4S010YpjPgyyjYUFowo
         YSNc2h3+qwaIqdhvLmDAXJQtLv1WCg10XVp3zfccgh8Dm6khGUKAvhLxdHLE8q9kdO3L
         VvbmTbTvZbw9rJC4OMgEcdIHJ1K5eAEUNl+kVQjMFV/xqWF6mlLjMe0I594Trxt6mdJ0
         NYJw==
X-Gm-Message-State: AOJu0YyZUCghq6/XdiU3mZ2LU+SIOVsI6iBS1VYtUuik8nwYCMwlYGPm
        RjdcVn8cqCmEdi/xTbYiP3Gbm4QaQ2AZv40=
X-Google-Smtp-Source: AGHT+IFlg4APaNYf7GwSTUnP88nwpRaVjMbWzpUCF47Lp2ZpGyDFLNx6bFd/UNTDKzI78d+cxFGju9X2VC/9kkc=
X-Received: from jlw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:41a])
 (user=jinliangw job=sendgmr) by 2002:a5b:151:0:b0:d9a:468f:480e with SMTP id
 c17-20020a5b0151000000b00d9a468f480emr420396ybp.5.1700204763883; Thu, 16 Nov
 2023 23:06:03 -0800 (PST)
Date:   Thu, 16 Nov 2023 23:04:57 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117070457.1970786-1-jinliangw@google.com>
Subject: [PATCH] mctp-i2c: increase the MCTP_I2C_TX_WORK_LEN to 500
From:   Jinliang Wang <jinliangw@google.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>
Cc:     William Kennington <wak@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jinliang Wang <jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original value (100) is not sufficient for our use case.
For example, we have 4 NVMe-mi devices on the same i2c bus.
When sending namespace create Admin command concurrently, they
will send 4x4KB data to device concurrently, which may be
split into 4x(4KB/64B)=256 packets.

Tested:
Before the fix, we will see below message in kernel log when
concurrently sending namespace create commands to the 4 NVMe-MI
devices on the same i2c bus:
kernel: i2c i2c-6 mctpi2c6: BUG! Tx Ring full when queue awake!

After the fix, the error message is gone.

Signed-off-by: Jinliang Wang <jinliangw@google.com>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b37a9e4bade4..b658aa040620 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -34,7 +34,7 @@
 #define MCTP_I2C_BUFSZ (3 + MCTP_I2C_MAXBLOCK + 1)
 #define MCTP_I2C_MINLEN 8
 #define MCTP_I2C_COMMANDCODE 0x0f
-#define MCTP_I2C_TX_WORK_LEN 100
+#define MCTP_I2C_TX_WORK_LEN 500
 /* Sufficient for 64kB at min mtu */
 #define MCTP_I2C_TX_QUEUE_LEN 1100
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

