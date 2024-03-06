Return-Path: <linux-kernel+bounces-93196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D5D872C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863CF285C92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A491BDE2;
	Wed,  6 Mar 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8jNQqeK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159E1B96E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688167; cv=none; b=ifuFCONqCaKGETPAI3V3S9O61aWJPRVtUA2GPggXtGj6VwCdwgnBNqgaxF+k3UnV7xVE2B1eAyCg8IyskX434MGtwwPjG6fgkVVuUDtOLuMynvwmwx4oE3UvlrowokcSOpWacq6frxy/7wgsBmwGJW9TCDAut/NJVhjJ7FG9Rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688167; c=relaxed/simple;
	bh=ZQgGWVSWytcgK5MJZ6jggoBjQfFJugefhTJSzcVcgYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQvPTq24EpMH0mLjVNSbLuPMWEmLf+WHQS+jGw/u+8piL0IUK0aoyF12a+UBxLUrTF9K++5m7T6gaX4alHRrTmMFmQeJ4qc8W2asL1M0eecrTP1kV2sz7DOu/DLlpCvkriVdhSwhAY4llOVt58MMYkix4n4l0Wl43LSNm9o2zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8jNQqeK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so10531995276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688164; x=1710292964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=k8jNQqeK7gQKIbzMge/onFNDkBDQoWlKZc9e1Yu5CHgqUsTYSSqY8AvFKi/KUny4DT
         eopA1+krKRaFD23m9rv6jQF0VejsCHmxr5u0R4oLH64/KmvAcIQjvVSnFCrglueIk5rE
         +811v4ySFHjV5W/G5zybxXKbGN0RpuM7A38KXr+KiDdgsOLYSVDgsScifR4XuFNE/Ofe
         fR2HaeDOz1SeyUQvp1ZJTkm1mPCMLLlTWozsmEswBw3jTw0VlgxDspSE6qhgysp/RktO
         u8X9t2eA4dFH37vUCJ8LIM+t+2ck2ck3LO5L1Yc3Yl86HRj1EiYR+uMWrGhWMAau+QtH
         BaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688164; x=1710292964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=G6g/kq0wJHR3x/brMUnH7HIEzvWlP3dxbVk+UrbnsQi/VWcO3XNRZmOBHADQeNNx/j
         ECycuclrg059vUfhhy3oWwWyjKaXTyfS+t2yVrA/k53bN0P84hKt1AIgh3SRtr0GI8k4
         w3VTALpCBNHPbc8raIOiG0wddUuYr/5ivbTXbNDE0fPcIqvicrVIAPxjoNRY5YR6lIVW
         LKd+0D2ZhwV98qHLpNU04ncR7hkYQ0v/kuaPfii5gvz9GRbF6XSczothfkUyDIrSvBgN
         EkgB/oO/eMX0NewJwCE1cVIQJrq5AQ8smxtEmhc6BbzkRFEilSfBa1FHTfzKvz6Y+sw7
         6Qhg==
X-Forwarded-Encrypted: i=1; AJvYcCUIAciyGJtIuw6qcpEQDiJinf0iy9f0XatD5zn7XkHlGMDmLc3pPwooNWNrUkIDQY3eSmwrNbfLSdZAgqpG4C4GL0NhqySzdt0T4pvP
X-Gm-Message-State: AOJu0YwnNpviDxYHBgVL4FtwYSablv4XFWJ262cMgnfw+wKtZHng/FIG
	i9l329F2cEoWK23+YYoV48gq6+a0bylgW3wjijomLHQ5BspRtrjb8aP70ek0UN/3CIEKgF4dAwJ
	uRsAa9gDWnA==
X-Google-Smtp-Source: AGHT+IHdUO0CSTTXSxP9RMH2G/OtJPNDHKSmhMwQ7efvIbVrkR+X7rTKxQ+kI29DRE6cGTrNY3Jc+MzpCV3TDQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:728:b0:dc2:1f34:fac4 with SMTP
 id l8-20020a056902072800b00dc21f34fac4mr3554574ybt.2.1709688164688; Tue, 05
 Mar 2024 17:22:44 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:26 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-8-ipylypiv@google.com>
Subject: [PATCH v7 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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


