Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF57D2F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJWJ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjJWJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:57:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8019270D;
        Mon, 23 Oct 2023 02:55:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1caad0bcc95so18177315ad.0;
        Mon, 23 Oct 2023 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698054958; x=1698659758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQc98ygW3JLH42W3zhpB97VN01RLRDxHg6oT7E9O25I=;
        b=kdOq8Y4E+MqqHNU5tJbOfqAHzn/BJoHC9xC8Pfn8l6uVGkepY0cBqHcQSukGuOVtZD
         HhQ7yGFGTRK+2Kd40YszPF1LFmz8iEAE7lDHrCzr1FTX9UDOicdoiYIopjEsChbAUKug
         nm9uq6N/5SXxgNA73kvEb83TjWzgj78uDQ5vFPgi9TSpBoESNjr/0qM5R56Hy/9E59hQ
         ILmO5pNWSCXAUR4UZ0M5/rM5oy1zrezi7VWM3t1VazwOOTzDaXrCN52BKwky+ZfAO3El
         vTQ6iE3VK4Ci7xaUaY/8LOYWvySLIgeGbV97DMkNSekOSGmjB0C5q0Oi1gEeWtXlZSmC
         aYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054958; x=1698659758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQc98ygW3JLH42W3zhpB97VN01RLRDxHg6oT7E9O25I=;
        b=P3RdBPnToEYQhGxtcEWTrAml+sNlGD7nTIox5NcncsWuN/NislWD9kw0j6/HIpyGwq
         8+FCViK+SvQPDGNjHy5WQYW3iw7TfyBvaSUL2xAHpTJ1sDOpn7i9HPjIMiajWfrKhUYi
         x1xziyk2SaCkgy7X7cekOfw9hk3fmjJMfCUIfn2GrgfuHbQcY2hDbezHN5Txvij3MAw7
         dskIkDB6GjZeLhtdX69P2M2okGtEWg4YQD3RbKt9jixyP0X0/IQfmcGGjt7av55y/Ph8
         T7zqPyn25cMWDWM9VnDQ2mKIMqP+s3SomAlyGtEgKAvEoGpS72bgWqZ2aDT9ggZMgXWR
         SJ1w==
X-Gm-Message-State: AOJu0Yz/c+Ii5vTI6FKrqxplIAxEEg348POGE0LVFZZUjRYGowLuaS4C
        1urGoMhthKfmIlDMKdYV0AA=
X-Google-Smtp-Source: AGHT+IGpNPCBH/J+R0/8EqTLT4a48xBXIsRodInJ6X+RLNsll8dbnMk+I3XiGBPa9M0eVOdtn3838w==
X-Received: by 2002:a17:902:dccd:b0:1ca:86db:1d39 with SMTP id t13-20020a170902dccd00b001ca86db1d39mr5628345pll.30.1698054958003;
        Mon, 23 Oct 2023 02:55:58 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b8b2a6c4a4sm5579414pli.172.2023.10.23.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:55:56 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     wojciech.drewek@intel.com
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: [PATCH net] ptp: ptp_read should not release queue
Date:   Mon, 23 Oct 2023 17:55:50 +0800
Message-ID: <20231023095549.719099-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, queue is not the memory allocated in ptp_read;
Secondly, other processes may block at ptp_read and wait for conditions to be 
met to perform read operations.

Reported-and-tested-by: syzbot+9704e6f099d952508943@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1

