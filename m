Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B77615DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjGYLds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjGYLdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:33:46 -0400
Received: from mail-m2838.qiye.163.com (mail-m2838.qiye.163.com [103.74.28.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027619C;
        Tue, 25 Jul 2023 04:33:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.217.162.127])
        by mail-m2838.qiye.163.com (Hmail) with ESMTPA id 5757C3C03CC;
        Tue, 25 Jul 2023 19:33:38 +0800 (CST)
From:   "jirong.feng" <jirong.feng@easystack.cn>
To:     martin.petersen@oracle.com, michael.christie@oracle.com,
        mlombard@redhat.com, d.bogdanov@yadro.com
Cc:     dongsheng.yang@easystack.cn, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "jirong.feng" <jirong.feng@easystack.cn>
Subject: [PATCH RFC] scsi: target: iscsi: Handle abort for ICF_OOO_CMDSN cmds
Date:   Tue, 25 Jul 2023 11:33:35 +0000
Message-Id: <20230725113335.194721-1-jirong.feng@easystack.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0pKVkkYQh4dTh5LHU0YTVUZERMWGhIXJBQOD1
        lXWRgSC1lBWUpMSlVJSkxVSk1JVUpJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
        Y+
X-HM-Tid: 0a898cd3815c8420kuqw5757c3c03cc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6ERw4SDEyIkwJMjo9CAML
        EA9PCQlVSlVKTUJLSUNPQ0pCSEpJVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
        C1lBWUpMSlVJSkxVSk1JVUpJTFlXWQgBWUFJSEhLNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a connection closes with an ICF_OOO_CMDSN cmd being aborted, then
rx thread will wait for the abort cmd to complete. At the same time,
the abort kworker is waiting for the ooo cmd's completion. Since rx
thread is waiting too, that ooo cmd can never reach to completion, so
is the abort cmd, causing both rx thread and abort kworker hanging
indefinitely.

Add handling in TCM of the abort for the ICF_OOO_CMDSN cmds at
connection closing moment to make it possible to release them.
---
 drivers/target/iscsi/iscsi_target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b516c2893420..27edc5eb9e6e 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4236,7 +4236,8 @@ static void iscsit_release_commands_from_conn(struct iscsit_conn *conn)
 			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
 
-		if (cmd->se_cmd.t_state == TRANSPORT_WRITE_PENDING) {
+		if (cmd->se_cmd.t_state == TRANSPORT_WRITE_PENDING ||
+		    cmd->cmd_flags & ICF_OOO_CMDSN) {
 			/*
 			 * We never submitted the cmd to LIO core, so we have
 			 * to tell LIO to perform the completion process.
-- 
2.25.1

