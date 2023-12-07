Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93548808F07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443541AbjLGRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443514AbjLGRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:42:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C310FC;
        Thu,  7 Dec 2023 09:42:59 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14C1021CBA;
        Thu,  7 Dec 2023 17:42:58 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2586413907;
        Thu,  7 Dec 2023 17:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 2JB6Oh8EcmUeYwAAn2gu4w
        (envelope-from <lduncan@suse.com>); Thu, 07 Dec 2023 17:42:55 +0000
From:   <lduncan@suse.com>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dbond@suse.com, hare@suse.de, cleech@redhat.com,
        michael.christie@oracle.com, Lee Duncan <lduncan@suse.com>
Subject: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
Date:   Thu,  7 Dec 2023 09:42:34 -0800
Message-Id: <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701540918.git.lduncan@suse.com>
References: <cover.1701540918.git.lduncan@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[mac.com];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         FROM_NO_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[17.15%]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of lduncan@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=lduncan@suse.com
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 14C1021CBA
X-Spam-Score: 15.00
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Duncan <lduncan@suse.com>

Some iSCSI initiators send SCSI PDUs with the "immediate" bit
set, and this is allowed according to RFC 3720. Commands with
the "Immediate" bit set are called "immediate commands". From
section 3.2.2.1. "Command Numbering and Acknowledging":

   The target MUST NOT transmit a MaxCmdSN that is less than
   ExpCmdSN-1.  For non-immediate commands, the CmdSN field can take any
   value from ExpCmdSN to MaxCmdSN inclusive.  The target MUST silently
   ignore any non-immediate command outside of this range or non-
   immediate duplicates within the range.  The CmdSN carried by
   immediate commands may lie outside the ExpCmdSN to MaxCmdSN range.
   For example, if the initiator has previously sent a non-immediate
   command carrying the CmdSN equal to MaxCmdSN, the target window is
   closed.  For group task management commands issued as immediate
   commands, CmdSN indicates the scope of the group action (e.g., on
   ABORT TASK SET indicates which commands are aborted).

This fixed an issue with fastlinq qedi Converged Network Adapter
initiator firmware, trying to use an LIO target for booting. These
changes made booting possible, with or without ImmediateData enabled.

Signed-off-by: Lee Duncan <lduncan@suse.com>
Reviewed-by: David Bond <dbond@suse.com>
---
 drivers/target/iscsi/iscsi_target.c      | 12 +++---------
 drivers/target/iscsi/iscsi_target_util.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 1d25e64b068a..f246e5015868 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1060,13 +1060,6 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					     ISCSI_REASON_BOOKMARK_INVALID, buf);
 	}
 
-	if (hdr->opcode & ISCSI_OP_IMMEDIATE) {
-		pr_err("Illegally set Immediate Bit in iSCSI Initiator"
-				" Scsi Command PDU.\n");
-		return iscsit_add_reject_cmd(cmd,
-					     ISCSI_REASON_BOOKMARK_INVALID, buf);
-	}
-
 	if (payload_length && !conn->sess->sess_ops->ImmediateData) {
 		pr_err("ImmediateData=No but DataSegmentLength=%u,"
 			" protocol error.\n", payload_length);
@@ -1255,14 +1248,15 @@ int iscsit_process_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 	/*
 	 * Check the CmdSN against ExpCmdSN/MaxCmdSN here if
 	 * the Immediate Bit is not set, and no Immediate
-	 * Data is attached.
+	 * Data is attached. Also skip the check if this is
+	 * an immediate command.
 	 *
 	 * A PDU/CmdSN carrying Immediate Data can only
 	 * be processed after the DataCRC has passed.
 	 * If the DataCRC fails, the CmdSN MUST NOT
 	 * be acknowledged. (See below)
 	 */
-	if (!cmd->immediate_data) {
+	if (!cmd->immediate_data && !cmd->immediate_cmd) {
 		cmdsn_ret = iscsit_sequence_cmd(conn, cmd,
 					(unsigned char *)hdr, hdr->cmdsn);
 		if (cmdsn_ret == CMDSN_ERROR_CANNOT_RECOVER)
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 91a75a4a7cc1..546816b3de86 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -285,13 +285,19 @@ static inline int iscsit_check_received_cmdsn(struct iscsit_session *sess, u32 c
 int iscsit_sequence_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf, __be32 cmdsn)
 {
-	int ret, cmdsn_ret;
+	int ret, cmdsn_ret = CMDSN_NORMAL_OPERATION;
 	bool reject = false;
 	u8 reason = ISCSI_REASON_BOOKMARK_NO_RESOURCES;
 
 	mutex_lock(&conn->sess->cmdsn_mutex);
 
-	cmdsn_ret = iscsit_check_received_cmdsn(conn->sess, be32_to_cpu(cmdsn));
+	/*
+	 * Check the sequence number iff we are not in an immediate command.
+	 * See rfc3730 Section 3.2.2.1. Immediate commands can be outside
+	 * the normal range.
+	 */
+	if (!cmd->immediate_cmd)
+		cmdsn_ret = iscsit_check_received_cmdsn(conn->sess, be32_to_cpu(cmdsn));
 	switch (cmdsn_ret) {
 	case CMDSN_NORMAL_OPERATION:
 		ret = iscsit_execute_cmd(cmd, 0);
-- 
2.43.0

