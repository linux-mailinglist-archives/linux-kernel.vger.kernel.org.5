Return-Path: <linux-kernel+bounces-97801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187F876FB3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3A6B2123D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA41374DD;
	Sat,  9 Mar 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RDC0D1vF"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F428364AE;
	Sat,  9 Mar 2024 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971877; cv=none; b=edpc4823Ejahs8mH/EA0QCoLrZT/unQoL8OmUx2eAsssHQPN9G2SM7hjU1nq7ciP1NHut8oht9v0W1exBclfAi+ENWHMZIRHvw7GjvZXGZgaHn5rKRo1OtmkqD1I2ixMjAVCVczjdb/P/c13yAAMbrxMy82drV8IZc74oWewbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971877; c=relaxed/simple;
	bh=cDO2Te7lO44GLVYSRD//KsMpMyh8mecbnh83ZhCAac0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mte51Kl5+lWgKJTUsQ+l+BQcKPidItGAa1DudKiExjHBm+1w/fNvDxr/b+sEdjJvUTN3MhD0Nm/dASYuVfQdkKJNr8CMF7v/+fmfGcHyT2MYQ/KvL6isFUNEGuR0NJ8CYMhGicYLDPiOlnokNrZdIg2G5C8kVrigXXUMJbhSFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RDC0D1vF; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709971875; x=1741507875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDO2Te7lO44GLVYSRD//KsMpMyh8mecbnh83ZhCAac0=;
  b=RDC0D1vFGhswzP26iBa2UZiOgv1A+OlyYOzuwk02GzaChdYAPBj80zVI
   OgXpgB3nfNoErPnVmzUDuzEAuhvrStMnh4up8A3WE+VBDGmhSc+wEcW0I
   2WZ8Qpbv1oO/9FBIzs4/ifj+jaalSY0cJ7cSGO52iq9cX831a3yCP40pr
   YFRUUUgWl5e5EHctO9Qd5bIdAHGgWTgyp1i51XbLY37R9NlejMdKMC6ak
   veo4PlILQkVXnNVGvPhhI81t+UK4wd3EZCrh4VZ0w6yf9f3QqcWsJoXoe
   j2SIN/ZWhtuIJmj5GTOZr6Qj2oWWNvfflH7Qd2ZlxSqYhaS4AsuIqGQne
   A==;
X-CSE-ConnectionGUID: EXYOOE8dQJmFZfvJsIYFVg==
X-CSE-MsgGUID: gZEYeHqKSImZNh8u1jHKkw==
X-IronPort-AV: E=Sophos;i="6.07,112,1708358400"; 
   d="scan'208";a="11183729"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 16:11:13 +0800
IronPort-SDR: fuAjn3nv/qtndFzusvef3R4TeFjv33eRItBxPy6nML0IETmLZNP3kgvJv+YwMm03+uyovAaqQ+
 maB1du7OT6rw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 23:14:40 -0800
IronPort-SDR: Egci0/n0bfpdifaEKUGq5PX14+w8l5hBPaaD2r/dNwjVR8nejS1eKFziwy5LHZrtteamnW/wjZ
 NLBH72Hy+Q3w==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2024 00:11:12 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 1/4] scsi: ufs: Re-use device management locking code
Date: Sat,  9 Mar 2024 10:10:59 +0200
Message-ID: <20240309081104.5006-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309081104.5006-1-avri.altman@wdc.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group those 3 calls that repeat for every device management command into
a lock and unlock handlers.

Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 69 ++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 21429eec1b82..983b7b8e3c7c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3272,6 +3272,20 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 	return err;
 }
 
+static void ufshcd_dev_man_lock(struct ufs_hba *hba)
+{
+	ufshcd_hold(hba);
+	mutex_lock(&hba->dev_cmd.lock);
+	down_read(&hba->clk_scaling_lock);
+}
+
+static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
+{
+	up_read(&hba->clk_scaling_lock);
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  * @hba: UFS hba
@@ -3294,8 +3308,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
@@ -3312,7 +3324,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 out:
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -3383,8 +3394,8 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 
 	BUG_ON(!hba);
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3426,8 +3437,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 				MASK_QUERY_UPIU_FLAG_LOC) & 0x1;
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3457,9 +3467,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3489,8 +3498,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 	*attr_val = be32_to_cpu(response->upiu_res.value);
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3553,9 +3561,8 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 	hba->dev_cmd.query.descriptor = desc_buf;
@@ -3588,8 +3595,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 
 out_unlock:
 	hba->dev_cmd.query.descriptor = NULL;
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -5070,8 +5076,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 	int err = 0;
 	int retries;
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	for (retries = NOP_OUT_RETRIES; retries > 0; retries--) {
 		err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_NOP,
 					  hba->nop_out_timeout);
@@ -5081,8 +5087,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 
 		dev_dbg(hba->dev, "%s: error %d retrying\n", __func__, err);
 	}
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+
+	ufshcd_dev_man_unlock(hba);
 
 	if (err)
 		dev_err(hba->dev, "%s: NOP OUT failed %d\n", __func__, err);
@@ -7209,8 +7215,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
@@ -7275,7 +7279,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -7314,13 +7317,11 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 		cmd_type = DEV_CMD_TYPE_NOP;
 		fallthrough;
 	case UPIU_TRANSACTION_QUERY_REQ:
-		ufshcd_hold(hba);
-		mutex_lock(&hba->dev_cmd.lock);
+		ufshcd_dev_man_lock(hba);
 		err = ufshcd_issue_devman_upiu_cmd(hba, req_upiu, rsp_upiu,
 						   desc_buff, buff_len,
 						   cmd_type, desc_op);
-		mutex_unlock(&hba->dev_cmd.lock);
-		ufshcd_release(hba);
+		ufshcd_dev_man_unlock(hba);
 
 		break;
 	case UPIU_TRANSACTION_TASK_REQ:
@@ -7380,9 +7381,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u16 ehs_len;
 
 	/* Protects use of hba->reserved_slot. */
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
-	down_read(&hba->clk_scaling_lock);
+	ufshcd_dev_man_lock(hba);
 
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
@@ -7448,9 +7447,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 		}
 	}
 
-	up_read(&hba->clk_scaling_lock);
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
+
 	return err ? : result;
 }
 
@@ -8713,9 +8711,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 	if (dev_info->wspecversion < 0x400)
 		return;
 
-	ufshcd_hold(hba);
-
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
 
 	ufshcd_init_query(hba, &request, &response,
 			  UPIU_QUERY_OPCODE_WRITE_ATTR,
@@ -8733,8 +8729,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
 			__func__, err);
 
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 }
 
 /**
-- 
2.42.0


