Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3B79E656
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbjIMLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbjIMLP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:15:28 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A6943A80;
        Wed, 13 Sep 2023 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bDy3C
        q2YQhbVtoUt+lT0pWPEDX4HUTZEgRPrWwjDd6A=; b=ev1veh9phKwc0o8RTamuM
        OUHg0aazumdiKVKRFcTibs88fGMkALYdl6NAxiAIau/9smyuwPEmZlKBLTaxjKEm
        ZHUOj856Zmezo80dPV80/Ek8dVIVWAWSkXVRZUYJXLDe7RbXqsH6DE/nbYEnuF8s
        RNQ66H/RdrTfC2SDlmzRgk=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [39.144.190.18])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wCHgihVmQFl1KHJBw--.22725S2;
        Wed, 13 Sep 2023 19:13:26 +0800 (CST)
From:   liubaolin12138@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pan.guihua@datatom.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1 v1] scsi: qla2xxx: fio at the same time delete acl hung
Date:   Wed, 13 Sep 2023 19:12:50 +0800
Message-Id: <20230913111250.23378-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHgihVmQFl1KHJBw--.22725S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW7XF43CFy3XryxAF18Xwb_yoWrtrWDpF
        WrX34rCayrJFWq9ay8JFW5urnIya1xtry7Kas7Wa93KF1Dtr9rAF1jqFyfZF9xAa4kCr4x
        JF4DtFyfKa1UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgeOJUUUUU=
X-Originating-IP: [39.144.190.18]
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbBDgvVymI0VOUNSQABs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Liu <liubaolin@kylinos.cn>

initiator exec fio test,at the same time target delete
acl hung,the targetcli process in D state.
After a period of time,the kernel dmesg encountered a
hang trace log.
the hang trace log as follows:
[ 2090.123825] INFO: task targetcli:4594 blocked for more than 120 seconds.
[ 2090.123859]       Not tainted 4.19.90-52.26.v2207.ky10.x86_64 #1
[ 2090.123914] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2090.123939] targetcli       D    0  4594   4245 0x00000080
[ 2090.123941] Call Trace:
[ 2090.123950]  __schedule+0x290/0x760
[ 2090.123956]  ? walk_component+0x12c/0x350
[ 2090.123957]  schedule+0x29/0xc0
[ 2090.123959]  schedule_timeout+0x1ee/0x3a0
[ 2090.123964]  ? __kfifo_to_user_r+0xa0/0xa0
[ 2090.123965]  ? __percpu_ref_switch_mode+0xd0/0x170
[ 2090.123969]  ? __inode_wait_for_writeback+0x7f/0xf0
[ 2090.123971]  wait_for_completion+0x12c/0x190
[ 2090.123977]  ? wake_up_q+0x70/0x70
[ 2090.124009]  core_tpg_del_initiator_node_acl+0x8b/0x120 [target_core_mod]
[ 2090.124017]  config_item_put.part.4+0x7e/0xd0
[ 2090.124021]  configfs_rmdir+0x229/0x340
[ 2090.124023]  vfs_rmdir+0x7a/0x140
[ 2090.124025]  do_rmdir+0x1ee/0x220
[ 2090.124029]  do_syscall_64+0x5f/0x240
[ 2090.124031]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Guihua Pan <pan.guihua@datatom.com>
---
 drivers/scsi/qla2xxx/qla_os.c     |  5 +++++
 drivers/scsi/qla2xxx/qla_target.c | 10 +++++++++-
 drivers/scsi/qla2xxx/qla_target.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 50db08265c51..056e9089403e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1891,6 +1891,11 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 				}
 				cmd = (struct qla_tgt_cmd *)sp;
 				cmd->aborted = 1;
+				cmd->trc_flags |= TRC_CTIO_ABORTED;
+				cmd->cmd_sent_to_fw = 0;
+				qlt_unmap_sg(vha, cmd);
+				ha->tgt.tgt_ops->free_cmd(cmd);
+
 				break;
 			case TYPE_TGT_TMCMD:
 				/* Skip task management functions. */
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2b815a9928ea..49cb725d8bd9 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -542,6 +542,11 @@ static void qla2x00_async_nack_sp_done(srb_t *sp, int res)
 	    "Async done-%s res %x %8phC  type %d\n",
 	    sp->name, res, sp->fcport->port_name, sp->type);
 
+	if (!vha->hw->base_qpair) {
+		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		return;
+	}
+
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	sp->fcport->flags &= ~FCF_ASYNC_SENT;
 	sp->fcport->chip_reset = vha->hw->base_qpair->chip_reset;
@@ -2477,7 +2482,7 @@ static int qlt_pci_map_calc_cnt(struct qla_tgt_prm *prm)
 	return -1;
 }
 
-static void qlt_unmap_sg(struct scsi_qla_host *vha, struct qla_tgt_cmd *cmd)
+void qlt_unmap_sg(struct scsi_qla_host *vha, struct qla_tgt_cmd *cmd)
 {
 	struct qla_hw_data *ha;
 	struct qla_qpair *qpair;
@@ -3246,6 +3251,7 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	uint8_t scsi_status)
 {
 	struct scsi_qla_host *vha = cmd->vha;
+	struct qla_hw_data *ha = vha->hw;
 	struct qla_qpair *qpair = cmd->qpair;
 	struct ctio7_to_24xx *pkt;
 	struct qla_tgt_prm prm;
@@ -3256,6 +3262,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	if (!qpair->fw_started || (cmd->reset_count != qpair->chip_reset) ||
 	    (cmd->sess && cmd->sess->deleted)) {
 		cmd->state = QLA_TGT_STATE_PROCESSED;
+		qlt_unmap_sg(vha, cmd);
+		ha->tgt.tgt_ops->free_cmd(cmd);
 		return 0;
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 354fca2e7feb..3644ab140ff9 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -1059,6 +1059,7 @@ extern int qlt_abort_cmd(struct qla_tgt_cmd *);
 extern void qlt_xmit_tm_rsp(struct qla_tgt_mgmt_cmd *);
 extern void qlt_free_mcmd(struct qla_tgt_mgmt_cmd *);
 extern void qlt_free_cmd(struct qla_tgt_cmd *cmd);
+extern void qlt_unmap_sg(struct scsi_qla_host *vha, struct qla_tgt_cmd *cmd);
 extern void qlt_async_event(uint16_t, struct scsi_qla_host *, uint16_t *);
 extern void qlt_enable_vha(struct scsi_qla_host *);
 extern void qlt_vport_create(struct scsi_qla_host *, struct qla_hw_data *);
-- 
2.39.2

