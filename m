Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838207A2459
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjIORLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjIORLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:11:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EDE6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:11:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso2440519276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694797874; x=1695402674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOqFz4mwu4R8vVhIHYO47D/MyrIS2uBdDRxhIpCvwuY=;
        b=JwG+DbNsDLV9VBySrOCi5UcX1b+LS9Fwx3tlhXxoP8wrVMUFqFAwOMejtEb2gnVkhh
         d4ShbJCa06o/n1ggzQ/CQQJxq+ejRVKK6k0sX0LPfwcAMiEK5Y+Rx668AlEldyo2vGmP
         cRxKD4u3FMNiMQj6seoRTGyQa3dAXr++DZiiJEGrBfZXfkjcamOIhtBdZ8Rj3HQINyvy
         LjGi0T5bySYIJZY4kmMzR3qGl91DR+ZgR8AtVVt0UZbXgoZDzWyogNN13Vbo1FSX7CxD
         QGiOB/LXNv6ZPGwkx5y89+wXYETRyBNcBt1jS6VymByrj4DLXTcfroic3NF28O9705zB
         6seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797874; x=1695402674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOqFz4mwu4R8vVhIHYO47D/MyrIS2uBdDRxhIpCvwuY=;
        b=Ye2hv8D/5azhcH/yJ/nyL45HCD4pamMgHRPvyPnWZea3/mKNDeviVjb5DYNDI14B6Z
         R13hhTG3b2T9s6C//hxlmfkARqszTe/vJRsXpS20Li7hC2Ix2HOwlWb8bjSPRsm6JJnl
         htcr8VV0xC3xvN3T8EAKTHvL1vS7t7+uUMdjHvcFv+tVmQ008dJxJqoghKanta3pliZC
         5V1+BdkNSh9Q/CZMxjJlZ/aZke4wVd6wQMsZzc5KexpikhMDQJFe8xnmPB+Bn8z3RfRh
         cit3jzyY8X+NzDr0poBaSWk1RZnZnrJY320+BZUnA/312XesVe4QVYNOK2q6TOQ5naPZ
         mDOw==
X-Gm-Message-State: AOJu0YwwSY6rdKL/r6T1IDIdZRbMu7BCaFEfJgxZzqdh3dwJwOYpIwi6
        mos+zYm48/GwIDbykMmWuD5+gktCN8gUWw==
X-Google-Smtp-Source: AGHT+IG7rGE3Ztuz1Grnmkp8w2vtWInjs5QzEYeJJbfCf6lDpmA/8jA7FGucjoqfvQlgDMwKTaP3deHGl0CsJQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with SMTP
 id m10-20020a056902118a00b00d80183c92b9mr60345ybu.4.1694797874299; Fri, 15
 Sep 2023 10:11:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:11:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171111.4057930-1-edumazet@google.com>
Subject: [PATCH] scsi: iscsi_tcp: restrict to TCP sockets
From:   Eric Dumazet <edumazet@google.com>
To:     Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Chris Leech <cleech@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
pointing to non TCP socket (af_unix for example).

Return -EINVAL if this is attempted, instead of crashing the kernel.

Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator: Initiator code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/iscsi_tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9ab8555180a3a0bd159b621a57c99bcb8f0413ae..8e14cea15f980829e99afa2c43bf6872fcfd965c 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -724,6 +724,10 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 		return -EEXIST;
 	}
 
+	err = -EINVAL;
+	if (!sk_is_tcp(sock->sk))
+		goto free_socket;
+
 	err = iscsi_conn_bind(cls_session, cls_conn, is_leading);
 	if (err)
 		goto free_socket;
-- 
2.42.0.459.ge4e396fd5e-goog

