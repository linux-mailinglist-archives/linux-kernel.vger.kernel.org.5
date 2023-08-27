Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8080789BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjH0HBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjH0HBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:01:13 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5557120
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693119668;
        bh=+ot+3z3mVTLDEEncOWnDAWXh3xGx1r1ZiCwPpdCrlOM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=NrYBSfBmb6Ij9R794s8ITdRO/MVhZHMPHa5QLah0NfXs0+MG+a9KEMhhbekVfbLEh
         tckY8V86BoGwccovIkUQ/p2Iqk6fi++lJA9qrhrsXgOT+rjerpAW17nnDFPyjndLw9
         VyD7OrhoKfk5ArciVtBlqWkOqaF+euKNV5TuLQSs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7EA5B1286BF2;
        Sun, 27 Aug 2023 03:01:08 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 4cPpxqQQYMgj; Sun, 27 Aug 2023 03:01:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693119668;
        bh=+ot+3z3mVTLDEEncOWnDAWXh3xGx1r1ZiCwPpdCrlOM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=NrYBSfBmb6Ij9R794s8ITdRO/MVhZHMPHa5QLah0NfXs0+MG+a9KEMhhbekVfbLEh
         tckY8V86BoGwccovIkUQ/p2Iqk6fi++lJA9qrhrsXgOT+rjerpAW17nnDFPyjndLw9
         VyD7OrhoKfk5ArciVtBlqWkOqaF+euKNV5TuLQSs=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AC33A1286B03;
        Sun, 27 Aug 2023 03:01:06 -0400 (EDT)
Message-ID: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.5-rc7
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 27 Aug 2023 08:01:03 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three small driver fixes and one larger unused function set removal in
the raid class (so no external impact).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bao D. Nguyen (1):
      scsi: ufs: mcq: Fix the search/wrap around logic

Neil Armstrong (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5

Zhu Wang (2):
      scsi: snic: Fix double free in snic_tgt_create()
      scsi: core: raid_class: Remove raid_component_add()

And the diffstat:

 drivers/scsi/raid_class.c     | 48 -------------------------------------------
 drivers/scsi/snic/snic_disc.c |  3 +--
 drivers/ufs/core/ufs-mcq.c    |  6 ++++--
 drivers/ufs/host/ufs-qcom.c   |  2 +-
 include/linux/raid_class.h    |  4 ----
 5 files changed, 6 insertions(+), 57 deletions(-)
j

With full diff below.

James

---

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 711252e52d8e..95a86e0dfd77 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -209,54 +209,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index e429ad23c396..4db3ba62fcd3 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -303,12 +303,11 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
-		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
 		spin_unlock_irqrestore(snic->shost->host_lock, flags);
-		kfree(tgt);
+		put_device(&tgt->dev);
 		tgt = NULL;
 
 		return tgt;
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 6fb0e007af63..386674ead7f0 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -580,7 +580,6 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	struct utp_transfer_req_desc *utrd;
-	u32 mask = hwq->max_entries - 1;
 	__le64  cmd_desc_base_addr;
 	bool ret = false;
 	u64 addr, match;
@@ -608,7 +607,10 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 			ret = true;
 			goto out;
 		}
-		sq_head_slot = (sq_head_slot + 1) & mask;
+
+		sq_head_slot++;
+		if (sq_head_slot == hwq->max_entries)
+			sq_head_slot = 0;
 	}
 
 out:
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d6fd4c3324f..c1557d21b027 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -321,7 +321,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
 
-	if (host->hw_ver.major == 0x05)
+	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 
 	/* make sure above configuration is applied before we return */
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 6a9b177d5c41..e50416ba9cd9 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-

