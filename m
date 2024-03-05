Return-Path: <linux-kernel+bounces-93109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE76A872B24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C54B27DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA713340A;
	Tue,  5 Mar 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n9Cl1Ynq"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD712E1FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681688; cv=none; b=Cn06aRlGg+uepQZqHwnAZMw1tuX33e9EIlwYiZcDnG/A2EXdpNGp4ZnQyBibv3U93dtYaJGidK+G7t2ieIydL/gKeS+ufVq3wvZRa2D16VsIhpeKyjeWYiRQm2jwWmbw9NPKsLQNIqWtC7wbHClHNFEpDLqgK+i8CRsPFErmnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681688; c=relaxed/simple;
	bh=OsMSw4z6iWbxTXjZg30kuZBO6Vj6czVVXXM7+X4U6u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYK0sK51C+5lpXegxXDjRM5K5I0LG8Q1Evtg3eJ6Yt/+6jPVlzfmclCsxUgDsrkFXHRg5g+ux4amoZ4R4BbVmT9cGaG6z7bo1y+6wyCDRISkcURzYI2eUMsvLFMtfACfcaJWsKp64f7hiq+ivC7KCb5JsdyiWAQwDYJv/snx9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9Cl1Ynq; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c83708311dso346330039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681685; x=1710286485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCz/Py0Ns2mXKbBtgurW4Nm4I/8gG7F1BHKnQ6umRVY=;
        b=n9Cl1YnqtavUFx/nHKyUvlMLgiyCyrvc5GiNlDu/8dsOET9tLPbNfYjIQ7IE0ePgU2
         TAY3mqLUeQ13yUrqMSOCxO36q0AXXQ3Jf5eES4omXjO5Lw/587CmnSYxCD3OCfAD4UU0
         nrMHydCiinMFxWxQ1ugKOFp2h9C2Qskn/s8/TuCbdSbFMJfswMBdqkz5xw9TqHSW+FrH
         I/gXvLlvWqgk1zyjaZibNv8pRFxG1cOYJe3d+NoX78SMTJ4WlMNkqUKEQ3+flw6PZLsK
         H494wLgdpivqBd7VknN6DyhdcDIeug/F+YFNIC/zjoYootf6EV43vRGTqlmj0HL7/yyg
         EPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681685; x=1710286485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCz/Py0Ns2mXKbBtgurW4Nm4I/8gG7F1BHKnQ6umRVY=;
        b=Nuy3cXJKVVavdDwUMne9yPCC1kQm2xL/zDYjdtYofjzTDTd0iuQ8oFlWSq0zCpt8wP
         QsHruLkX4walfzhCRBbzvj7rPg5S59+zP4Tit7lCw+pxe4Nl4E07TT5we0WRpQpdXPPw
         yvC61FVs/5O4PO0CQlfXq3OHFQuOGXLLUBr/FFUyNX/YM89xjgjqD+2D6ibI8ZpOhFt8
         V8p53uRZ3rC2ntR4XHAZIo8nTUbb1dEBTUtVGay1kEXhynKryqSZRl4KwP069mlR8nhX
         j/Cn8VefxzpQMtPZ9z6A12KDaduc59DmY5sLiVhsX6Zc6ci6UP62ALym0UF+V/J5fWGZ
         rqMw==
X-Forwarded-Encrypted: i=1; AJvYcCXf3BZbAjSDBGqBDrGQnLBswyvhz0hOx92Oogu6D/VQMxmg0MUem0jb7y3KLcznj6bL4MXXOOfy8ZqfjC81tE5kwjdfmS/dU7g8j4hr
X-Gm-Message-State: AOJu0Yxa1gE5Xl5OUS0w58ROl1CdENHP9togw0Uh/5shJiMreJVU/yMY
	dSZg5i+xfVrbZ54474QFdxRqqP4n7XMskF422ioZ/1Etw6dv5Z7OmV2dr8v/NuZvhKrb9/u1Vim
	7WStbd309+mSFMYTJ7iZe/g==
X-Google-Smtp-Source: AGHT+IHg0I14q/uq1iOXxVZ/7MUvTrMtE2B2cT+hC15fDY+B3hGbY752uu2ZyIfVlk86YppQd1jP3G63j24k66Vpxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:e0d:b0:7c8:264a:8c45 with
 SMTP id gp13-20020a0566020e0d00b007c8264a8c45mr72249iob.4.1709681685585; Tue,
 05 Mar 2024 15:34:45 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:39 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=6820;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OsMSw4z6iWbxTXjZg30kuZBO6Vj6czVVXXM7+X4U6u0=; b=yFz+ZNCjXqzkg2Y1+WAxa057MaLfkBRd65XWFzulVwXxiDf5n3QvmIwTtlL8S/RT1Ao0b6bub
 SgIj+Z7PxHyCyQr7LEoG9QIUAtNgzOLVs4yZd3iG5z0q/fg43YRZnzG
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-4-5b78a13ff984@google.com>
Subject: [PATCH v3 4/7] scsi: qla4xxx: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Replace 3 instances of strncpy in ql4_mbx.c

No bugs exist in the current implementation as some care was taken to
ensure the write length was decreased by one to leave some space for a
NUL-byte. However, instead of using strncpy(dest, src, LEN-1) we can opt
for strscpy(dest, src, sizeof(dest)) which will result in
NUL-termination as well. It should be noted that the entire chap_table
is zero-allocated so the NUL-padding provided by strncpy is not needed.

While here, I noticed that MIN_CHAP_SECRET_LEN was not used anywhere.
Since strscpy gives us the number of bytes copied into the destination
buffer (or an -E2BIG) we can check both for an error during copying and
also for a non-length compliant secret. Add a new jump label so we can
properly clean up our chap_table should we have to abort due to bad
secret.

The third instance in this file involves some more peculiar handling of
strings:
|	uint32_t mbox_cmd[MBOX_REG_COUNT];
|	...
|	memset(&mbox_cmd, 0, sizeof(mbox_cmd));
|	...
|	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
|	if (param == SET_DRVR_VERSION) {
|		mbox_cmd[1] = SET_DRVR_VERSION;
|		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
|			MAX_DRVR_VER_LEN - 1);

mbox_cmd has a size of 8:
|	#define MBOX_REG_COUNT 8
.. and its type width is 4 bytes. Hence, we have 32 bytes to work with
here. The first 4 bytes are used as a flag for the MBOX_CMD_SET_PARAM.
The next 4 bytes are used for SET_DRVR_VERSION. We now have 32-8=24
bytes remaining -- which thankfully is what MAX_DRVR_VER_LEN is equal to
|	#define MAX_DRVR_VER_LEN                    24

.. and the thing we're copying into this pseudo-string buffer is
|	#define QLA4XXX_DRIVER_VERSION        "5.04.00-k6"

.. which is great because its less than 24 bytes (therefore we aren't
truncating the source).

All to say, there's no bug in the existing implementation (yay!) but we
can clean the code up a bit by using strscpy().

In ql4_os.c, there aren't any strncpy() uses to replace but there are
some existing strscpy() calls that could be made more idiomatic. Where
possible, use strscpy(dest, src, sizeof(dest)). Note that
chap_rec->password has a size of ISCSI_CHAP_AUTH_SECRET_MAX_LEN
|	#define ISCSI_CHAP_AUTH_SECRET_MAX_LEN	256
.. while the current strscpy usage uses QL4_CHAP_MAX_SECRET_LEN
|	#define QL4_CHAP_MAX_SECRET_LEN 100
.. however since chap_table->secret was set and bounded properly in its
string assignment its probably safe here to switch over to sizeof().

|	struct iscsi_chap_rec {
	...
|		char username[ISCSI_CHAP_AUTH_NAME_MAX_LEN];
|		uint8_t password[ISCSI_CHAP_AUTH_SECRET_MAX_LEN];
	...
|	};

|	strscpy(chap_rec->password, chap_table->secret,
|		QL4_CHAP_MAX_SECRET_LEN);

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/qla4xxx/ql4_mbx.c | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c  | 14 +++++++-------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index 249f1d7021d4..75125d2021f5 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -1641,6 +1641,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 	struct ql4_chap_table *chap_table;
 	uint32_t chap_size = 0;
 	dma_addr_t chap_dma;
+	ssize_t secret_len;
 
 	chap_table = dma_pool_zalloc(ha->chap_dma_pool, GFP_KERNEL, &chap_dma);
 	if (chap_table == NULL) {
@@ -1652,9 +1653,13 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 		chap_table->flags |= BIT_6; /* peer */
 	else
 		chap_table->flags |= BIT_7; /* local */
-	chap_table->secret_len = strlen(password);
-	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
-	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
+
+	secret_len = strscpy(chap_table->secret, password,
+			     sizeof(chap_table->secret));
+	if (secret_len < MIN_CHAP_SECRET_LEN)
+		goto cleanup_chap_table;
+	chap_table->secret_len = (uint8_t)secret_len;
+	strscpy(chap_table->name, username, sizeof(chap_table->name));
 	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
 
 	if (is_qla40XX(ha)) {
@@ -1679,6 +1684,8 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 		memcpy((struct ql4_chap_table *)ha->chap_list + idx,
 		       chap_table, sizeof(struct ql4_chap_table));
 	}
+
+cleanup_chap_table:
 	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
 	if (rval != QLA_SUCCESS)
 		ret =  -EINVAL;
@@ -2281,8 +2288,8 @@ int qla4_8xxx_set_param(struct scsi_qla_host *ha, int param)
 	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
 	if (param == SET_DRVR_VERSION) {
 		mbox_cmd[1] = SET_DRVR_VERSION;
-		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
-			MAX_DRVR_VER_LEN - 1);
+		strscpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
+			MAX_DRVR_VER_LEN);
 	} else {
 		ql4_printk(KERN_ERR, ha, "%s: invalid parameter 0x%x\n",
 			   __func__, param);
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 675332e49a7b..17cccd14765f 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -799,10 +799,10 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
 
 		chap_rec->chap_tbl_idx = i;
 		strscpy(chap_rec->username, chap_table->name,
-			ISCSI_CHAP_AUTH_NAME_MAX_LEN);
-		strscpy(chap_rec->password, chap_table->secret,
-			QL4_CHAP_MAX_SECRET_LEN);
-		chap_rec->password_length = chap_table->secret_len;
+			sizeof(chap_rec->username));
+		chap_rec->password_length = strscpy(chap_rec->password,
+						    chap_table->secret,
+						    sizeof(chap_rec->password));
 
 		if (chap_table->flags & BIT_7) /* local */
 			chap_rec->chap_type = CHAP_TYPE_OUT;
@@ -6291,8 +6291,8 @@ static void qla4xxx_get_param_ddb(struct ddb_entry *ddb_entry,
 
 	tddb->tpgt = sess->tpgt;
 	tddb->port = conn->persistent_port;
-	strscpy(tddb->iscsi_name, sess->targetname, ISCSI_NAME_SIZE);
-	strscpy(tddb->ip_addr, conn->persistent_address, DDB_IPADDR_LEN);
+	strscpy(tddb->iscsi_name, sess->targetname, sizeof(tddb->iscsi_name));
+	strscpy(tddb->ip_addr, conn->persistent_address, sizeof(tddb->ip_addr));
 }
 
 static void qla4xxx_convert_param_ddb(struct dev_db_entry *fw_ddb_entry,
@@ -7792,7 +7792,7 @@ static int qla4xxx_sysfs_ddb_logout(struct iscsi_bus_flash_session *fnode_sess,
 	}
 
 	strscpy(flash_tddb->iscsi_name, fnode_sess->targetname,
-		ISCSI_NAME_SIZE);
+		sizeof(flash_tddb->iscsi_name));
 
 	if (!strncmp(fnode_sess->portal_type, PORTAL_TYPE_IPV6, 4))
 		sprintf(flash_tddb->ip_addr, "%pI6", fnode_conn->ipaddress);

-- 
2.44.0.278.ge034bb2e1d-goog


