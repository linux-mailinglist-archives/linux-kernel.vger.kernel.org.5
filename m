Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8447C68F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjJLJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjJLJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:03:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA7E7;
        Thu, 12 Oct 2023 02:03:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af5fd13004so443986b6e.0;
        Thu, 12 Oct 2023 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697101418; x=1697706218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzVb0vhkKTU8KCtwfAzDZ8IflC6qM4IfCofuFQAqWtA=;
        b=QbyJM8Tb1FkpysZnnBsLcReSywvqKbqZLqmy9461F5QMsI/4jNdqm5QowRWohM1px/
         u623ozevra5l9pGhUSp+AKWq1/UesXEPv2vMFbVAISCWjDDqIGLu6VkGlRZE2tG1fA0D
         5SoPISKmXBRZyLRq1XMUAgrMD3vOjVO/ue17Sd1PedQkdDDBYcvrYoC7C4PGF4mUmzdP
         EpZh4yOEDzRZyNe2D5tD+avNbQMic8U0bRBYsBeXCbxNsdhgINDs6OOyAX3SQEa1T6Iq
         D9C/jGXrwldLMKqq6sq5Tg+aAw6lFt1a7iRp273pzZSOPgcCeENljM9vRXuywxjtc4hg
         15mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101418; x=1697706218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzVb0vhkKTU8KCtwfAzDZ8IflC6qM4IfCofuFQAqWtA=;
        b=uSY8g5UZX/uRGVT1hn0+Gk2ZNGu6+V2SmrzxKYeR0oT12F9a51JelrlUUpwcJsM4/Y
         2ernb8azoRBJVDTCRJB785p4LwjzhuVe3xh4YCt0+ZwNP5h9i6o7g8mS/nW0aYqc9ctN
         lvPzqCBRNJ8tNf9hgYwubVuy4y0iy7qcYqYFM3KMIt2tq4zgcT/SMMu+t4cBsHVt6bVU
         gVpj0Aix1N+H7YPMGXvM3tsDelPJNKzVdUDknLRimZfDXz6nhNbeABnBvsRzBhbK1NGu
         K5fKTIxsIYrlQfJOKP3Xh7php6FQ4pEsJ1ifrIRFtl8+0jCzUAPXRuZGD/VZMDGLixXq
         Gexg==
X-Gm-Message-State: AOJu0Ywa0jIQ0YgPJ9h2mywsgvptvn3At5v6oJCduyKkYB/51N/pY9GF
        dm+HGa9e6KO9KBx2qAZG9uI=
X-Google-Smtp-Source: AGHT+IFZPAv8fSDpyr9L424jpdJT5iixbs95Q1Hn3Kr/5p4A+D01DpflPRL1xGcYz8dznNOIAYlijA==
X-Received: by 2002:aca:2308:0:b0:3ae:55e6:1e34 with SMTP id e8-20020aca2308000000b003ae55e61e34mr23199116oie.58.1697101418473;
        Thu, 12 Oct 2023 02:03:38 -0700 (PDT)
Received: from localhost.localdomain ([61.16.102.74])
        by smtp.gmail.com with ESMTPSA id ey5-20020a056a0038c500b0068ff6d21563sm11857363pfb.148.2023.10.12.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:03:38 -0700 (PDT)
From:   Liansen Zhai <zhailiansen@gmail.com>
X-Google-Original-From: Liansen Zhai <zhailiansen@kuaishou.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhailiansen@gmail.com, yuwang@kuaishou.com, wushukun@kuaishou.com,
        Liansen Zhai <zhailiansen@kuaishou.com>
Subject: [PATCH net-next,v2] cgroup, netclassid: on modifying netclassid in cgroup, only consider the main process.
Date:   Thu, 12 Oct 2023 17:03:30 +0800
Message-Id: <20231012090330.29636-1-zhailiansen@kuaishou.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When modifying netclassid, the command("echo 0x100001 > net_cls.classid")
will take more time on many threads of one process, because the process
create many fds.
for example, one process exists 28000 fds and 60000 threads, echo command
will task 45 seconds.
Now, we only consider the main process when exec "iterate_fd", and the
time is about 52 milliseconds.

Signed-off-by: Liansen Zhai <zhailiansen@kuaishou.com>
---
 net/core/netclassid_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index d6a70ae..d22f091 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -88,6 +88,12 @@ static void update_classid_task(struct task_struct *p, u32 classid)
 	};
 	unsigned int fd = 0;
 
+	/* Only update the leader task, when many threads in this task,
+	 * so it can avoid the useless traversal.
+	 */
+	if (p != p->group_leader)
+		return;
+
 	do {
 		task_lock(p);
 		fd = iterate_fd(p->files, fd, update_classid_sock, &ctx);
-- 
1.8.3.1

