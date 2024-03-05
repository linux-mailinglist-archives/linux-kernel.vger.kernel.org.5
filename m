Return-Path: <linux-kernel+bounces-93128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33570872B64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF481F2495F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D0134CDB;
	Tue,  5 Mar 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwmBL62y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EA12E1C8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683122; cv=none; b=KnrgqvJU9uVuJVibn9V9LKk3pEwm6cendHIRwhFKGams7l25GzJZ3cAA6t5eXiwx+IQenXI7ziWJ7RfuCufY2qO140dm1ndqty9owS4UhvL9CHFrNgIAmbJYqVDI1ZQs+amyfJ0plz1NGWkyOVTT5j51+seKHqR9FBrwH+xLaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683122; c=relaxed/simple;
	bh=maF5o+8NzF6pdVwJjN4aGBE4hXXZ0tcVypbGypFOmGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIWJo65BaxL2cnTSi3dvw7f1BPBg10PMvseNVShbst+JQB6tnlGTnwic6QFXF9KSLQEghNLmyOCRjJ8B8QbM9SypPNoJTwTvln3A6d46B6Ku5WJ/GiIBJyF5mDOUBeeZ1aAmDyQc/8eTVKPZZAR6hPWYuXc0pvvIilAJ6umoDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwmBL62y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a1063919so25484317b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709683119; x=1710287919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D3wwHTaGXoUxTIIC0KnLIe431yjbfic0tFZoCaTHSU=;
        b=kwmBL62yWFGTAH54KJPWim18ayjDRUwI1RDXQDaHZPYts7ekjH+NuG+j+GPhySutez
         LVjkL0okArCbPtiVQQuZICrSzwrbzmMHc8hUkbQS8w1AwLjlixqvrDhN9Ia+M+lJCeMg
         uiSxLV7Uy3ThTmK/qqpPYj7t3p1lVkuCb+X1zMvKpLfuJEy0Jfy/2rIoBVtGLQNc6gDu
         u/eQYx1DrKYM9NujnBTOivXegazpIZ/dDNca6Huahy+a5DNH1qqmVSgfWbA5UHJtsMjh
         UJfPCLjF0ANSjCmA9RR/pVJaExelndBRgNZCyEhTV4Jxh5gMPVTc6w6lT7KXUR70dId0
         qh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683119; x=1710287919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D3wwHTaGXoUxTIIC0KnLIe431yjbfic0tFZoCaTHSU=;
        b=WuRmcwiKe6pruEHrw+HPejTEhzwSHVeFxPTzEwOXNrRRQrbDsty5KKgjPldcCHXihs
         iwQ/YS/YXk4cg7FhDuLyYdS14xo7xy4LdUKZ8wpszv/672kUoMow6sV5jdySe3rwO9aw
         hycdbgTDy1+kxpwO3RSQZbIZfSqS0IavwOfKLgQB+Uev7awRf/WT8DthzcNt+WQNqZAM
         ITDp4eLPTrDm9SaIBUzzYvoHsu+Cxfsw4moUWP8A87f93pP5Fc3TThfu0tVpYotnZPzH
         uhDjwiSo8/bP4v8qe5dQJ8Yyraqsqnzd+hz33Fx2fMt0fJZsQWS3JhKfC75TxUVxBpd/
         rzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3/+SW3w7B/SOgIaim+K8fkb7OHutrlw1JXMuKq0G67wvhc5wYGw4GmMqBg5ycng74VqqHSt0tUDQwHwp44003QAK1JRpL2DpLVN2S
X-Gm-Message-State: AOJu0YzHppjAhItaUy8MHvcl0xRWKHbYxxLC2dW+AwBMY1kX2nBxkzXU
	os/qFgNmLeHzLd+O6kTwmfc6Z3m0cRVd7CpCKd5ACLH7stojsE7qKJ+y0DAaqXLFVXgKhnlSuLY
	sZoNpbLrRyQ==
X-Google-Smtp-Source: AGHT+IEh4EOkCQAW7SnanA8bB430w4xh23BQshDhLIDYxxe1IBICBWObTrhgrFis2i70uNCJX6d2c6KwUnqvMg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:150d:b0:dc6:fa35:b42 with SMTP
 id q13-20020a056902150d00b00dc6fa350b42mr3669159ybu.2.1709683119712; Tue, 05
 Mar 2024 15:58:39 -0800 (PST)
Date: Tue,  5 Mar 2024 15:58:20 -0800
In-Reply-To: <20240305235823.3308225-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305235823.3308225-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305235823.3308225-6-ipylypiv@google.com>
Subject: [PATCH v6 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 73b378837da7..b5d379ebe05d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v2_hw);
 
+static const struct attribute_group *sdev_groups_v2_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
@@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v2_hw_groups,
+	.sdev_groups		= sdev_groups_v2_hw,
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b56fbc61a15a..9b69ea16a1e6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v3_hw);
 
+static const struct attribute_group *sdev_groups_v3_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
 
 struct hisi_sas_debugfs_reg_lu {
@@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v3_hw_groups,
+	.sdev_groups		= sdev_groups_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
 	.host_tagset		= 1,
-- 
2.44.0.278.ge034bb2e1d-goog


