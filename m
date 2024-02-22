Return-Path: <linux-kernel+bounces-77350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F3860430
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2D21C25724
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6312D1F8;
	Thu, 22 Feb 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qtf83WGJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407673F25
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635488; cv=none; b=UZ0OZq01Hw6Gl4payZfRShcKGXa25WR49puaCLCrGLXFBp/moMWVMNUstJLCUBpvxE+M2QnnglDZu9DMsfI2tFEO6RTOzshmQkzOGcU4kaJZcs6rF8kuoc8hTF0f5M6Hi5pMrqkLv6pc1d0lYaPQVcnTyqMBSc221wNqCngwlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635488; c=relaxed/simple;
	bh=8AOYIiYLdFhowt9vL8ZH3qzA0/HjkqpcByU2fn+xKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdtX5zK+Q2LBizF+ES4kVLEGvnCyBI7cR2GGOHojcaB/6RXW8OpoKBheyhnTRpqXwJErFTvriSf/+cKkti8xP8OSWX0sSgQaPRE6efRXSPLalms0itzv80VoJy4u1kiBVeVQ3SQoJNu/AyTjb0pnUV1dXUvtMDv0aQIM9aeTaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qtf83WGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708635485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEhg1fEN1oSGXEFibAbstnmrTa0iSbY2Or+wv+pBoNo=;
	b=Qtf83WGJSCITK8iNqLZxnBpxh96/zEQsDC9SDht9qRuSMPgpCjqeFOCt3x6DWz53UzlaRK
	/2Ch9sPtlbHnkwlAayyfPILZPs3zyyqy7o+ylF5ShzFnyFAEWsjj3nTJJ/jKFilMYxOFkY
	y+9KxJ5QVJta/mu55dFPyv7nhTCSqj0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-VLi1i6T_PcGzEAjbf4fkGg-1; Thu,
 22 Feb 2024 15:58:00 -0500
X-MC-Unique: VLi1i6T_PcGzEAjbf4fkGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DED493806061;
	Thu, 22 Feb 2024 20:57:59 +0000 (UTC)
Received: from ibm-p8-16-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F96310DD4;
	Thu, 22 Feb 2024 20:57:59 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: ilpo.jarvinen@linux.intel.com,
	shravankr@nvidia.com
Cc: davthompson@nvidia.com,
	ndalvi@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH 2/2] platform/mellanox: mlxbf-pmc: Ignore unsupported performance blocks
Date: Thu, 22 Feb 2024 15:57:30 -0500
Message-ID: <f8e2e6210b43e825b69824b420c801cd513d401d.1708635408.git.luizcap@redhat.com>
In-Reply-To: <cover.1708635408.git.luizcap@redhat.com>
References: <cover.1708635408.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Currently, the driver has two behaviors to deal with new & unsupported
performance blocks reported by the firmware:

 1. For register and unknown block types, the driver will fail to load
    with the following error message:

    [ 4510.956369] mlxbf-pmc: probe of MLNXBFD2:00 failed with error -22

 2. For counter and crspace blocks, the driver will load and sysfs files
    will be created but getting the contents of event_list or trying to
    setup the counter will fail

Instead, let's ignore and log unsupported blocks. This means the driver
will always load and unsupported blocks will never show up in sysfs.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index b71636eb3db1..746567767e5b 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1043,6 +1043,11 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
 	return events;
 }
 
+static bool mlxbf_pmc_event_supported(const char *blk)
+{
+	return !!mlxbf_pmc_event_list(blk, NULL);
+}
+
 /* Get the event number given the name */
 static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 {
@@ -1761,6 +1766,9 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	struct mlxbf_pmc_attribute *attr;
 	unsigned int i = 0, j = 0;
 
+	if (!mlxbf_pmc_event_supported(pmc->block_name[blk_num]))
+		return -ENOENT;
+
 	/* "event_list" sysfs to list events supported by the block */
 	attr = &pmc->block[blk_num].attr_event_list;
 	attr->dev_attr.attr.mode = 0444;
@@ -1840,7 +1848,7 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, unsigned int blk_num)
 
 	events = mlxbf_pmc_event_list(pmc->block_name[blk_num], &count);
 	if (!events)
-		return -EINVAL;
+		return -ENOENT;
 
 	pmc->block[blk_num].attr_event = devm_kcalloc(
 		dev, count, sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
@@ -1878,7 +1886,7 @@ static int mlxbf_pmc_create_groups(struct device *dev, unsigned int blk_num)
 	else if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_REGISTER)
 		err = mlxbf_pmc_init_perftype_reg(dev, blk_num);
 	else
-		err = -EINVAL;
+		err = -ENOENT;
 
 	if (err)
 		return err;
@@ -1983,6 +1991,10 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 			return -ENOMEM;
 
 		ret = mlxbf_pmc_create_groups(dev, i);
+		if (ret == -ENOENT) {
+			dev_warn(dev, "ignoring unsupported block: '%s'\n", pmc->block_name[i]);
+			continue;
+		}
 		if (ret)
 			return ret;
 	}
-- 
2.43.1


