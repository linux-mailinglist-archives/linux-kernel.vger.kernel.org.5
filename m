Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B997F00B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjKRPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKRPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:53 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9310F7;
        Sat, 18 Nov 2023 07:51:41 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5c9169300caso5651217b3.2;
        Sat, 18 Nov 2023 07:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322699; x=1700927499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH/C2GbGilv4dEVGrlEtm1neXP6vUXqVIR2w3PMGoMU=;
        b=l1wglQacW5bOp1InX5DIoQdvtQBnkVSQYzCPO11Q64OYnQnkYSOLykca4riSKSiBkk
         E0BU9SRbJi+7G8534ABotGg3Mi4jtFnH7arCjWR/tcvS0LpKeEm0ct1F0IpC06WMJgC1
         24PVVzDzyCB2fwWj+cN2t2tu7ddqB4tf0JH+ArX30sMP+e6A5xoXjQemJnzFZ9DgdeeU
         e/aOO+iJn/v/eQ2+nBd8kn6ROXq7O95FlDHrwCafcpeevlKZ5pv6h2WHLKra0cEXtHug
         GwTPHVVre3UOlyXXBJTgPB+eMq0WT++SfG3j3repoa7Z0nH2Hks66sza2TwOuzOhN7VD
         4+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322699; x=1700927499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH/C2GbGilv4dEVGrlEtm1neXP6vUXqVIR2w3PMGoMU=;
        b=VxEm2Df9RIjMC2a0y94OFs8TXVij0mgoEl7ir/ixFvKMUrF0XzMMtCfeFtzMIUYpRb
         oFmpjZ2Kk5+r86s5KNBEkN5WRXIVgAvW1QnJkooA19IvhX2MlZdQw8ZPC8fAmdIQKdx1
         B6oRVTpg31E6h6UHm/0/9g/MSLEcG4ymS+QAehWOCs0qzXQ2aPduhUmWE9lY2/gO+1m8
         c407Gli2AkKgnBJLb5HLv5cmdjfd0LIJ18Cs5zwVPdTMRs4qJY26IhRn8dtG3Dd/x3Rz
         bFjOOnzlOfq8vLqRB0EIdm0oTho+JcwoTx+yFMleaRzHnyVgRkvwd/1WwWtTcy5iNEAz
         vr0w==
X-Gm-Message-State: AOJu0YzbVYSm83orr5EYTVRziJ757bp+/ifrP4F7NbhoZXmL8M32dy3l
        JQ465BX+rojqgqkl2hMJUmN+EchTly22GOfN
X-Google-Smtp-Source: AGHT+IH8iE5pRuee+JQIvG8dc4ZEm5Lvvk2s9b3hTX2Ou24/UpkP0ESpVFcnBMmBTlDyte+avOB5TA==
X-Received: by 2002:a25:ac89:0:b0:da0:c744:3211 with SMTP id x9-20020a25ac89000000b00da0c7443211mr2333419ybi.2.1700322699285;
        Sat, 18 Nov 2023 07:51:39 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id l129-20020a257087000000b00d8168e226e6sm1005873ybc.47.2023.11.18.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:38 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 20/34] tty: nozomi: optimize interrupt_handler()
Date:   Sat, 18 Nov 2023 07:50:51 -0800
Message-Id: <20231118155105.25678-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In exit path of interrupt_handler(), dc->flip map is traversed bit by
bit to find and clear set bits and call tty_flip_buffer_push() for
corresponding ports.

We can do it better by using for_each_test_and_clear_bit(), because it
skips already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/nozomi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 02cd40147b3a..de0503247391 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1220,9 +1220,8 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
 
-	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+	for_each_test_and_clear_bit(a, &dc->flip, NOZOMI_MAX_PORTS)
+		tty_flip_buffer_push(&dc->port[a].port);
 
 	return IRQ_HANDLED;
 none:
-- 
2.39.2

