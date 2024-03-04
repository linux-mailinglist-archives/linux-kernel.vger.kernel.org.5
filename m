Return-Path: <linux-kernel+bounces-91344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5F870FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22871F2142D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9647BAFB;
	Mon,  4 Mar 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rcYLe3e"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3B7EF10
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590122; cv=none; b=a3Cug4FifYaBM26+I4wVJ0BU17BJrEa7d7bWFpCs12A3smb6JWEDhk9yD8ejoWGNdxHg+rp5n37awVihEgOp4YvNLgVIbKlsdaBDAxlEruZkSNrZJCGVYnYPcDVWkklxkSTi/ATuNE1uSXxk43abmsg7u+e9RbXNDGAaM9d/1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590122; c=relaxed/simple;
	bh=k2RsKVsqn0SP6W3+GcW/+9UaRpSxki2AedJQ+0T1tis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDH0MVtDwG8DjNSdahfRNyETElPNBDMV3aWGg35T8aPUT3r5/s1UBwUf65Pn3bjiTZJPSeV+d8FNi563SVUQZMtlUD3rZ81kMVluXFRD6+mbGkiudQVPGDiXbvmKsbP0Cc7LruPmMpyrHugm/Fa15SJKMiqlUNVbZCKFlt/hRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rcYLe3e; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so6015521276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590119; x=1710194919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BOHqZcuLWtFyhT4gaG3Cu9uWAk1ebaqFWaPcojfGUM=;
        b=4rcYLe3eKUErXai23zunRAGizqBe2Zj1IhUCSk00l+gyZc6OtX7u0H78rboYT/DtD/
         vINoZT6ZkkkY2xJRReZAbBHXWymHFSRSc5+ZYtMpjD2/OV8+QIGqblDoy65c9ibp8Q6Z
         7FlS2bDBRxmCvxKQ5EzPcLkhZQQYK7zoxnTqfW7Nc14xN2hDPaYalkkEYX6+bfyYcdae
         KOlHMZhI4poYEikDdJ0zg4ZPT/kIcpsrdmvHHUkSU6QwZS35sQZZuT1TOxlMeId3HWni
         9iitkZd4xSIx5dHNVihsPKCrTrtZ6EhxZGQZ0cICF+bZ7Gs3nT5K25jo6AQPanN56T+F
         fmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590119; x=1710194919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BOHqZcuLWtFyhT4gaG3Cu9uWAk1ebaqFWaPcojfGUM=;
        b=tuwxlcdZI2CnQ8lNixKfZCgro+Y/5Y15teL6HHyqH9zYr2CBGkWQFUN05v1f03jpGD
         KwhMO6uJDnqD+UHY8r67ANXv0fsUAXTF0ojVb8kBPCajgVG+X/6+4eV2Ksnq8UDUPpNP
         opc2th4f1F2JFeY/l8t4pVxGK9KFXQgKR+YWUBU6mz6IR71QpHFwM38GwsLSouLJ2Jem
         3WfeCijyRb2D4RlIfnzikvXuuKmJx3mtQIEjoyTVEO5r4/mFtnnDBnYeLyNW7ZSpL4+R
         Iebz4K8h/bWx0iEHBKE+wIkpS9gqWOlVFk/+epvPuA2d6OG/QMufy8akbd6BF1FLqqk+
         vvBw==
X-Forwarded-Encrypted: i=1; AJvYcCUJXLXTj4aDZyg7IAep7ykV4EBS0ObjIjQDHUO09bOqgF2+IvuBkLxOowUR7TGhBsEf9wn3IdD8gmPcKDKuN8L7cCst85h1K806WwrH
X-Gm-Message-State: AOJu0YzKHgA5ym9Z0cAD/tWCHzw5Was5vJgz1hjYN0Qp5UWg5SC1Xk73
	bfDg/gKb5POIZS1a3us7S5e81habM6KkWX9VhB0MdFsR1yxnqZEPRbxkqldFwcQ2Cx/2c5EHR8J
	sxFL396Yevg==
X-Google-Smtp-Source: AGHT+IFKnkpuBehKxAI5KNP9ibb1U2ESkcGB5dQvh7Jo0lfObivCLCwOiAc4Lh6eu52G+uxOMieIcl2LF17sIA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr444115ybe.8.1709590118871; Mon, 04 Mar
 2024 14:08:38 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:15 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-8-ipylypiv@google.com>
Subject: [PATCH v4 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/isci/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..8658dcd61b87 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -149,6 +149,11 @@ static struct attribute *isci_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(isci_host);
 
+static const struct attribute_group *isci_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template isci_sht = {
 
 	.module				= THIS_MODULE,
@@ -176,6 +181,7 @@ static const struct scsi_host_template isci_sht = {
 	.compat_ioctl			= sas_ioctl,
 #endif
 	.shost_groups			= isci_host_groups,
+	.sdev_groups			= isci_sdev_groups,
 	.track_queue_depth		= 1,
 };
 
-- 
2.44.0.278.ge034bb2e1d-goog


