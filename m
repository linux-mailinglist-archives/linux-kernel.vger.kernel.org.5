Return-Path: <linux-kernel+bounces-74590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C768285D673
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815E52843ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F403EA9D;
	Wed, 21 Feb 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ei6sfyYP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818EBE7E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513629; cv=none; b=nnJS3kozO3NAEo57Uu21MxNyRDCdLQHnIUtvNw2bg5aPRfskelrrGqCP/DXHv7Q65tgxd9DbIAmFb8NFppAx/fAvu4lbQt5lrwengXAGOixmj8Pjr+xDGw/75w7XMJeoZbPkQeBMNwukB6ft115bckzN95CWwaYiJcZLTuV7OZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513629; c=relaxed/simple;
	bh=oeT8D95NKe7pIr4hfviYGvVnoPtzduZq0zmxcgxK1g0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkT/hZFfDP5PaCxHsbn9B/4Dmt4Nk1CTIx8HkkslfyKXSe8wT6UwDWnYQvOzV74dw7RZ1JMiE97rW802LRGgS8dGBB1fE+srezsogw1as0h54OM7MwKUps3MbcsCT44e16hEe3fWEqf+6+iUo7rLdAqSXGoq53/coC7RJgAhVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ei6sfyYP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so27905795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513627; x=1709118427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brEb9TnfGp5/yuMw230xLgH6JsFOFAcbGsSGw6+DLbM=;
        b=Ei6sfyYPVQIgbHxOaEKn4MeLTfX6zCqOOjumEJhzCp3S+VKuZOn9sEVbhwuXEWHJTq
         TN798aq/gfE+VOhlvbOPwygk+w0ekyKTzQnA66Wl5j0UB2/wzZYgDDf5HBrSOzTVhfnf
         U28UCV7YwV4vRvLTCkbDBispGqF1xSrDgQIa4O5dsQgBiozzfYWkLuDf6FX8iVZ4ZmBz
         9fsXhkgnJQ8rINvoeiZi7we0i29qnFQxiv/B9ppQKY+ZiVqYAjUb90/P8CsR195pTDXj
         p3Da2G7IBIdlHDZtymllx/ixpTUrr3ICA8hfWSWun7jmMH0xcYPRectFzyCCZHQiqwKg
         89XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513627; x=1709118427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brEb9TnfGp5/yuMw230xLgH6JsFOFAcbGsSGw6+DLbM=;
        b=Z5HwUp7ncDCUtdWPLY21iBwmIsACrfhNLyHAuLQyfKVybL+NxZNexRRPv0IG3xNRIw
         T2fBWuow+Xb1Nz7EIlNOLprIJRx+e+5yWR/jXpQUYQv3/SVVoAG88YK+qUQEqTXmsuTz
         cfAsc9cWOeiy9MFVautL8/P5UI4LQcHpLn74vJpxuWzNnNzY7lE30WbMRnyveq602hnI
         y7x660yKFL0wgClZNlabP/IxXGMRhdjFmdc4vPuSPixzlA2b1o9L73fFQXGfqg+iKq1N
         i5XghA1ryf55qrSYKUOL+JvbZWgu6yc8s1JwM9jA1nPtmqkW7aiAnfXcSfnRXYIUgSbp
         HPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyzHVrNphPkdzgu6d19nUGCyR8JQvRDSTTxeVQ6GZipMVtkil7J1STx5ZcPeu/n8lenkdS1VZcCXKPwWQXGf6k35pwb3oY4pTguY8d
X-Gm-Message-State: AOJu0Yz/OXqakQfa31D4xX8apRIUZX77dcERAxOf+kdQMfFjz3nVw8Ng
	fguXA9HUc1nFXllXSCYhMrV748YXgqyQXlkWoyfIb+3lAYJFZJWrv7+yOahQa6g=
X-Google-Smtp-Source: AGHT+IFOfFUYOzmRcjcrUyMEhlZGMmrIiea4+cj0ZpJzxUHDRfvHzhLGB9dcIaitxNGbEeNYh65O8Q==
X-Received: by 2002:a17:902:e951:b0:1dc:1b14:dc9f with SMTP id b17-20020a170902e95100b001dc1b14dc9fmr4338016pll.67.1708513626789;
        Wed, 21 Feb 2024 03:07:06 -0800 (PST)
Received: from localhost.localdomain ([114.103.193.174])
        by smtp.gmail.com with ESMTPSA id ja12-20020a170902efcc00b001d9d4375149sm7873686plb.215.2024.02.21.03.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:07:06 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
Date: Wed, 21 Feb 2024 11:06:58 +0000
Message-Id: <20240221110658.529-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The accelerator device can provide multi-queue and bind to
the same domain in multi-thread for better performance,
and domain refcount takes care of it.

'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
removes the possibility, so fix it

Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
v2: Instead of checking ret == -EBUSY, 
    change iommu_attach_device_pasid return value from -EBUSY to 0
    when pasid entry is found, and refcount++ when return

 drivers/iommu/iommu-sva.c | 2 +-
 drivers/iommu/iommu.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..20b232c7675d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
+		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..a16ade93db25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3551,7 +3551,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
 	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+		ret = xa_err(curr) ? : 0;
 		goto out_unlock;
 	}
 
-- 
2.34.1


