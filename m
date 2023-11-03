Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0977E0117
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjKCH06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjKCH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:26:56 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D7184;
        Fri,  3 Nov 2023 00:26:51 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1efa01323b4so987930fac.3;
        Fri, 03 Nov 2023 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698996409; x=1699601209; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAgvdtIcQPX971sbAD4m0YcUgmn+p4/agvvmTkVVwws=;
        b=RIxMLPHcWnl2PvPYRttSRvVoJ71fezeH+pUmynO6wnZEwNJkGKUYGpu/XnrMCcSgdR
         5hABNVLR12X5MVGR7H1/BiPz4aeb7NFWXPHq/7rFvZ60GDzPwO1Dv/jpHI0pQsKnEViq
         AidaSjhfsRtcD9uLTpSlg7kemYMSW9MEnuKUZedGmKfEOjD5BzHHMme/ZCvX0uu+KCzQ
         Jyy5aVz+ZMbHynohgfU/tF5I+7d1oUfStfnPeIu9LyzRfaQ/1bNjxVfxQE8H79lTrgsr
         uDxSYVTf+Raf2dpZU7DtRCSr2On7t8dzmQvTwXNnHKCN4X2IFL0bLSvHgt3WjQ39F8Cw
         QTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698996409; x=1699601209;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAgvdtIcQPX971sbAD4m0YcUgmn+p4/agvvmTkVVwws=;
        b=f5YAwpNy0c2fOh03FW7aIqYgD//XYRY5j5aEa9xvAnOKd3byTHZtS5Q0JWsRRNqxGp
         h/o2rI/RPisU5TpbGDk3gy1xQNDzZm+S7fwZXFBsFFWWCZs1bjhecQ25pu2D9PH1OtgO
         QRy9oZyL7YhTWStoxaOY7puX2hE62xjVQFvByvZTd9OKZfOJx6Z2ZzI9KoTlmuJ3Cks2
         CCb45+OF4QovuA3lqO4SklQcDYUwjlQejN6Y0EfDSh6BMyy7sfMh4VCYia0ZL2h9sJxX
         bcZIvvrSdNmzeVI8dovFjEwRtBeL1KHPkeJe+aMUvP/rPAd1+lXtM5inel1EfJEnOTCe
         pLgQ==
X-Gm-Message-State: AOJu0YxKf9EH3lmZ60Wvix3DXO0zIHwSFR1hB0uFqjEHlnuGAxndNESX
        LPNcbJ3AYgAErQ5OETscgA4=
X-Google-Smtp-Source: AGHT+IFwJ+9a0PGhf6eIhUKgqYa6i/e/+Vw1PCvPybsGRuqpj6rL00zS+20NIBi4ezOYdzJRt1MXjg==
X-Received: by 2002:a05:6871:723:b0:1ef:a87f:5d52 with SMTP id f35-20020a056871072300b001efa87f5d52mr20315557oap.6.1698996408708;
        Fri, 03 Nov 2023 00:26:48 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a63cf43000000b0056c2f1a2f6bsm773341pgj.41.2023.11.03.00.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 00:26:47 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Add fqs_holdoff check before the fqs_task is created
Date:   Fri,  3 Nov 2023 15:26:39 +0800
Message-Id: <20231103072639.11426-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rcutorture tests that support fqs operations and set fqs_duration
greater than zero, the fqs_task kthread will be created. but if the
fqs_holdoff is not set, the default value is zero, this cause fqs_task
enter a long-term busy loop and won't voluntarily give up the CPU until
stopped by kthread_stop(). this commit therefore add for fqs_holdoff check
before the fqs_task is created, make sure the fqs_task is created when
the fqs_holdoff is also greater than zero.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 83999e57b3ea..9f0e6c1cad44 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3886,7 +3886,9 @@ rcu_torture_init(void)
 	}
 	if (fqs_duration < 0)
 		fqs_duration = 0;
-	if (fqs_duration) {
+	if (fqs_holdoff < 0)
+		fqs_holdoff = 0;
+	if (fqs_duration && fqs_holdoff) {
 		/* Create the fqs thread */
 		firsterr = torture_create_kthread(rcu_torture_fqs, NULL,
 						  fqs_task);
-- 
2.17.1

