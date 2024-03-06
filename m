Return-Path: <linux-kernel+bounces-93192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410C872C20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30F1B231AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73517BB9;
	Wed,  6 Mar 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rh1Aqv4e"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650BA134A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688158; cv=none; b=r50cJ/YoRJBqzahXpjiCLqzKqOGLEPiBpU2tToHA2ELhc/WqZGSczH31xvKFwaSerqxdLAT7UbKZHxa7T+EAGgssOzqyEuo5NayzlTfh8qorzs44Cj1swfdi50dKa9R7VM4l6DuxB11kdFxVU/brdEUkeLYhwdwguM8uS2eExGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688158; c=relaxed/simple;
	bh=eNWF6foC4RAjM/7mIBIDm6Ws+q1aoKRiMrqNZ34dkrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hbzx8L0g7ho+qkccb2r3iHU/ETyIW25f8a7yT/1MIMKQTRd7hQ0qqnK00ZcRC9H4mKbrF6pQnModz2FlRZpSlYKCUA8KI4TIx4Asks+UNpB43PRRL8rPLkef8EhoZ2m4RHCbVUqv1LRprJO81Tmcc3i1RIuq6EzAh6FBl+4r7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rh1Aqv4e; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so110915417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688156; x=1710292956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=djrkg2o6GYfOpuFfrfroOSUyfmqyZMD72kLam/QnMds=;
        b=rh1Aqv4eXPnrUGTyaL7W06vu5m5oG0CNiB3SW4g44mFwWDT14P5qotLkk5hmi/D6z6
         Nlr3btXAN0858M79zia9hPseaUzkmPo6xGgb6hHgzKAOU4H4OC5UdUf5hWRaWy4ijF+D
         NvjZN5J6okVSrUPOrFgqHJ10dCXQnZ+6ruAOCYPkrDPf+SSNkFNd8HLcLuI7J8pFMweQ
         bgPylctqGzYrUle3WYoWv1VJYzCNWoNRCvy06bJtmUzlk/QmyZYL2IyCr5xKBt2VCSbZ
         3hZioJJloYy1cSdQJjPp/97h+zH1ViB9+tJjiZzCPCsheG6fDEatEnEl87B7zq3iITW8
         EZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688156; x=1710292956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djrkg2o6GYfOpuFfrfroOSUyfmqyZMD72kLam/QnMds=;
        b=BS/+28m5M9HBfNuRqKpoHA+dB1tCTgmuL6aLgPSxZU0E+5jnvXtIxr2KThY8QSnHx3
         x5SOjR+kVAtL7lIjiulPNZlFUOWlkk3F8uyTUFjbvRvcSDIPozzX5r+LW6kl7S9CYTlH
         5Xo9ZwgptJa2Cxiqnyn1HpVqMsmaMfiObiMJ+EoU/9IC20cDdYHlK/fPgxi1iqIUK845
         Tzs8yDXfRqGITTnPYcWXqKSFmiFWbS+DR2akjVnRMBjsTyL9LnPX9A7JVnBfQWk4E+DM
         rGTx7Z/4ykDFhF3hFz9P52OWcxrcA+MRdYMNOmJl5Y8f7wE7A/lvqr5JmpsNxNd4Ycb0
         WNew==
X-Forwarded-Encrypted: i=1; AJvYcCV1w/tOpyUghS4ZZpcLaeQDiLktKGEacjsyUtVPmy/5FwdfBWTj+FaOFxuZj1dBM2ehATh4TU5GxA5gMFFoUQKBmmdDhXCpDl7NhWXr
X-Gm-Message-State: AOJu0YxFUkuSqRVWkr1Bq0tOwjLCyz3lzR5cqdxLys9YAcSqL6svjaJC
	DRGebwZp1abn2jgXm0ouWoWVL4qRMgln5ahmSY+FCC5TzAHWbrPQESgvEfIii0Z5rQwQYD+hE/3
	q/m/J3X1qcg==
X-Google-Smtp-Source: AGHT+IEghJ9PK/cUoNltMVXmRLwQJyqnNza3sX0GvOvMSKx9Y/m0pcuh+FPl6LfR7gKE5mmkr4x2Cht5mrrCRw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a81:9958:0:b0:609:1fd9:bbf with SMTP id
 q85-20020a819958000000b006091fd90bbfmr3386990ywg.3.1709688156555; Tue, 05 Mar
 2024 17:22:36 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:22 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-4-ipylypiv@google.com>
Subject: [PATCH v7 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Jack Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
 drivers/scsi/pm8001/pm8001_init.c | 1 +
 drivers/scsi/pm8001/pm8001_sas.h  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 5c26a13ffbd2..9ffe1a868d0f 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] = {
 	&pm8001_host_attr_group,
 	NULL
 };
+
+const struct attribute_group *pm8001_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ed6b7d954dda..e6b1108f6117 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= pm8001_host_groups,
+	.sdev_groups		= pm8001_sdev_groups,
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
 	.map_queues		= pm8001_map_queues,
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 3ccb7371902f..ced6721380a8 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm8001_ha);
 void pm8001_free_dev(struct pm8001_device *pm8001_dev);
 /* ctl shared API */
 extern const struct attribute_group *pm8001_host_groups[];
+extern const struct attribute_group *pm8001_sdev_groups[];
 
 #define PM8001_INVALID_TAG	((u32)-1)
 
-- 
2.44.0.278.ge034bb2e1d-goog


