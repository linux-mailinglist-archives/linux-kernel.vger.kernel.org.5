Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719C7AEAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjIZK6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:57:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A2101;
        Tue, 26 Sep 2023 03:57:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5c91bec75so58687725ad.3;
        Tue, 26 Sep 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725873; x=1696330673; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjoNcHNpSndbmROelnkAs9z2pMPBqViv/3mMpfzHcDI=;
        b=HhA/AH+HKx5baG3aDbhCPF8xm6+w77wf9fbNvj4m0MRV9mi+66Z0tvFR42HbgCPKH3
         /L6JvLfHz0uw+fgK44OZtTYpglKx5+Nbt8MytEn1ohDoGoaKHtoKo6QABbOWkuzqvZvL
         USqR17uSvn9rkTf2pprXF1Kr73izDP0E+JdC9dgcJo5WeYjx29M4ff5paoJsMdWUJ4IZ
         3gHY4ubtyBLdNrGkH/S/sQVhHgLgo1fD27F4y8YWv7zegjtjeqecQOdektgKzNfy+cK+
         ljFjtOPu6pQqC3tPy429zGv/e0jeMrbcg/92/htZvHk6mB270+2AstzClRangqQWwCau
         YQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725873; x=1696330673;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjoNcHNpSndbmROelnkAs9z2pMPBqViv/3mMpfzHcDI=;
        b=QAbXtoqmqO9HPNaWy3pwNTuq+pN7O6w7LVyGG96fhuu3AwLF0dFsQ0D6OLpP9K8BUc
         0T2Rb9ST1603Azeb7+iUm/m53bApDoCa8oarlNxfJfi0Qglhr7TjKtyyCOjhcMFhrKVe
         RWJGNzr6QRo1xG5j6gkD30I+f1LeePz5fSHPedxqxjKm7s6p3ca1qZBN07OQwWRQhmIN
         PeWpuaRQ1ONw3yfEA2hOgFVn/BR+Rh+I23W3m0P5aoW8fZccy7/PVsoU4l9g/SZKrOTP
         EvV45SVCeBGNYgS/p6sqafLMxGuke2wpiP2pHtjUrYeuP8g2weyDr2mVZOzAW2biKhXl
         LLcQ==
X-Gm-Message-State: AOJu0YwQ79tGCQDzusutk+BCKUzmZpxk3Vu5FOkVlvsfI83Stky0NJRC
        uWp9p6ASq75it/Mg4jEl6AA=
X-Google-Smtp-Source: AGHT+IEQFAiqu0pWO1taS10G4nOQB5oW4bLmRUqPIg4USAiB+tdqjNA4RCW1DUHvYMBE7csBQ9L3NQ==
X-Received: by 2002:a17:902:c3d1:b0:1c3:8464:cabd with SMTP id j17-20020a170902c3d100b001c38464cabdmr6900788plj.12.1695725872792;
        Tue, 26 Sep 2023 03:57:52 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001b5247cac3dsm10648393pli.110.2023.09.26.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:57:52 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Date:   Tue, 26 Sep 2023 10:57:32 +0000
Message-Id: <20230926105732.10864-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer interrupt ax25_ds_timeout() could introduce double locks on
&ax25_list_lock.

ax25_ioctl()
--> ax25_ctl_ioctl()
--> ax25_dama_off()
--> ax25_dev_dama_off()
--> ax25_check_dama_slave()
--> spin_lock(&ax25_list_lock)
<timer interrupt>
   --> ax25_ds_timeout()
   --> spin_lock(&ax25_list_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_bh()
on &ax25_list_lock inside ax25_check_dama_slave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/ax25/ax25_ds_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ax25/ax25_ds_subr.c b/net/ax25/ax25_ds_subr.c
index f00e27df3c76..010b11303d32 100644
--- a/net/ax25/ax25_ds_subr.c
+++ b/net/ax25/ax25_ds_subr.c
@@ -156,13 +156,13 @@ static int ax25_check_dama_slave(ax25_dev *ax25_dev)
 	ax25_cb *ax25;
 	int res = 0;
 
-	spin_lock(&ax25_list_lock);
+	spin_lock_bh(&ax25_list_lock);
 	ax25_for_each(ax25, &ax25_list)
 		if (ax25->ax25_dev == ax25_dev && (ax25->condition & AX25_COND_DAMA_MODE) && ax25->state > AX25_STATE_1) {
 			res = 1;
 			break;
 		}
-	spin_unlock(&ax25_list_lock);
+	spin_unlock_bh(&ax25_list_lock);
 
 	return res;
 }
-- 
2.17.1

