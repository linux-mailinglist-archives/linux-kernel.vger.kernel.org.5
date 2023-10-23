Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19B7D28AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjJWCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJWCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:46:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE7DB;
        Sun, 22 Oct 2023 19:46:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cacde97002so13130625ad.2;
        Sun, 22 Oct 2023 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698029187; x=1698633987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQc98ygW3JLH42W3zhpB97VN01RLRDxHg6oT7E9O25I=;
        b=H5y4JAOjGyldnWkTB5K9YPjM+gM+dlRdI98jek4ccCmB2ESWyXP5eQ27RTVCoD5IEz
         u+tas+VpGfQVg6+DwgQf5sEJqc5sbloAeYnlCjEnUZfWu2xyvvnxvYvWDYS/hqsbFxee
         vIZC67evt59ZkGyF8QtqRZYqCNHPYHhu/oRu4xjdsnBVbb/xqq84tN30S33ZGpF40HjE
         hjDBSpChZYvRcaDzxUOXQstEPMnGB/yK8gZxDksqg59Ax3MWcMhGF89hLUExW4+MtSCj
         O1RrJoCyS4U2N223BD65iTADCza7WE2um1XjOjgWf7DFeKfdPMtX6abAgS69WHyjWBbq
         h0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698029187; x=1698633987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQc98ygW3JLH42W3zhpB97VN01RLRDxHg6oT7E9O25I=;
        b=i5qPA2Xwvh/MbVI1T4XsZhqO4mP2375m+fLZOcQnWmgkw55rJQccydoq2kvxZsuqVN
         +MuHaQd3TLXmz1SKixquuxljq3xt1gqXFGUgNrPy1cCdc4Qhk9zw+N0DcRktlnNcGBrF
         S1ZtOyA3ujBu42RSEEXbtjf0PZebh3yGvFeDlipa7ChjO46z8l6DoyoTfZaMq0mfdFKz
         KYIejyKL3y++JmDvu4ZsCVZ1AdoR7RWGx+6VBe166cYQd5YED4hqWG+8ggX9Vf3lygIk
         vpAgSoPXA3ukIYX7TOJY9pxdl9KR97UxsHNap94NAdRVDo9HJKKALrU9L8nY3K6HP1sF
         0DFA==
X-Gm-Message-State: AOJu0YwB3rjzdTCd51N8B2AEOSrS9b/5IPyVK4zoR7uTubDXN4Ddedl+
        G017VG5JC+UqMbUzIkwwTIjB5ta6fbgHDw==
X-Google-Smtp-Source: AGHT+IHNn4PQ/fdf1Gn5Ydr4cBx5xYUk3BPGPRSzdZ3Th2zqPumSc531z2wlOXGLhgZRtaN3qYZK2Q==
X-Received: by 2002:a17:903:22c7:b0:1ca:8e79:53af with SMTP id y7-20020a17090322c700b001ca8e7953afmr6247201plg.3.1698029187468;
        Sun, 22 Oct 2023 19:46:27 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001ba066c589dsm5022017plj.137.2023.10.22.19.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 19:46:26 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     syzbot+9704e6f099d952508943@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] ptp: ptp_read should not release queue
Date:   Mon, 23 Oct 2023 10:46:23 +0800
Message-ID: <20231023024622.323905-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000002e8d4a06085267f3@google.com>
References: <0000000000002e8d4a06085267f3@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

