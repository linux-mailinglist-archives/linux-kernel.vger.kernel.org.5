Return-Path: <linux-kernel+bounces-141560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C978A1FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31ECB22AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12E17C6A;
	Thu, 11 Apr 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSunOtQC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EC1773D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866353; cv=none; b=K7A+Dzf7ZHfguDfsUtw+MwSCsX9ZW0glIhHtQWzPcrrDEvAdCwAKZJwUT9rujMgIHQls5cvduplADXdRfKE8vlKjyJpeLgES1ICyei284rJb/44CdNkz5RuzNKQnnmumTQ/QhwkwywvfIENKAPfMQPdnJJGdodX/wbM1FPa/Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866353; c=relaxed/simple;
	bh=IOzWZkywOwA2ndhPjHmzQHWJ3c7dhd0+FGx+Rn/xt1s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FzvVUJ5DXp1/y3CWDqUqc0h9U96WlEzQUs6oBXHB13RJIy4X516KFNM9Va/gNT19Z8ScYMzON1yhSN2R8jYZYVc9EGHHwwpJKJczE/YdNrxrbmGlYxeA/XPL8VA9aHxjPnjUvbECFAHLuBh3H2FEBhFwo6FOo8F5eHbDYOE9HWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSunOtQC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso305083276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712866351; x=1713471151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2BoP91YkDa6Qt/uP+LjX8R6BByP1pkp+j1WZvkyP9c=;
        b=LSunOtQCeDJXWRMpWM0I9BZDPudqJhateHSTyy5LiNMp5LRgOi2UsqoZ7Rs0dg4QFP
         IQou8hmjncJR+3z1NMq31bFDRND0/+rDL72LZeBopzHnVOoYJvwi31u7V2idB1cyd9Bx
         e7hctJf6RcMTc8IEKlGV3shp1DKN9ic1Ii6YDq7id05dgRZdkrTzTdA5TlQfQ0+LO6jd
         r1LCUTit1XPtwJn6vmLhKmuleRtK5+3NaJH1AFbCrHOvXIJoGERVSLrFPYMILmM0uHH8
         r60VUq4+vgePfQCoKU0TEQkSXJPd74K9ITA9jcKKQkB4vUnKW4lj9bDpQO36WIPMhoX2
         JREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866351; x=1713471151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2BoP91YkDa6Qt/uP+LjX8R6BByP1pkp+j1WZvkyP9c=;
        b=jcfWBuEqnC1S0saZrwGFRYT48kYI8+Pj0+xjccvl2XknUrd6loqLoV1a2eXFogYiPe
         B3ZPmwzWqtSUDA38PbXBdv3O+rWW+nK2bXojhwphcpkJtM5kP8Cw4+zAsGZTH+BZC4NZ
         K6LG70xMYvriCZZTLUJ+GGXUk0jdW2aai3XWzd+uU0VnBsp/jxDrtq1ni87y29lq3y3O
         f1Kg/av3de1wvDOqQdFNXstzOml8BLtAhVshtOVLxL26rrN80vUNFmpOHsZcpOd2r7Jn
         V3tvxXnnDODILxUzdVokfqKIjWMf+CC3E7a0F2lQNd0m/vxO8b6Sq2x8K4xl/120bJGL
         uXfw==
X-Forwarded-Encrypted: i=1; AJvYcCWxcjwbPA+5yJrKJbTisGwUN2z10uvxy5hUrebSu13hEQeiWFTW/7pESTKr44ZH0ytGWB3t+P1juLS1H7zbzbhCeb7JO0vdZXQRJO6D
X-Gm-Message-State: AOJu0Ywkkpg1aADFe+apdKxinBZdvF/AmMCtDMFKQBo0KRc+RH8zAW+o
	sPOxVsuKuNdI7VsrMBobTiwkSHgbWfviECdIbKxN2E6PD4gpQxshuaH7Os0bJBXf2D2DgxleFkZ
	EeoWe1r4Xhg==
X-Google-Smtp-Source: AGHT+IHP35EiL8Z/ThcjwbVilIgOWIx7kty8BvrtYfdYdh6PolWqYRFhau0jCfMJznCy7ffkzl2wn12Va+2G0A==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:100b:b0:dcc:f01f:65e1 with SMTP
 id w11-20020a056902100b00b00dccf01f65e1mr157365ybt.8.1712866350713; Thu, 11
 Apr 2024 13:12:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 20:12:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411201224.1311198-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-core: Allow command duration limits detection for
 ACS-4 drives
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Even though the command duration limits (CDL) feature was first added
in ACS-5 (major version 12), there are some ACS-4 (major version 11)
drives that implement CDL as well.

IDENTIFY_DEVICE, SUPPORTED_CAPABILITIES, and CURRENT_SETTINGS log pages
are mandatory in the ACS-4 standard so it should be safe to read these
log pages on older drives implementing the ACS-4 standard.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index be3412cdb22e..c449d60d9bb9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2539,7 +2539,7 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 	bool cdl_enabled;
 	u64 val;
 
-	if (ata_id_major_version(dev->id) < 12)
+	if (ata_id_major_version(dev->id) < 11)
 		goto not_supported;
 
 	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE) ||
-- 
2.44.0.683.g7961c838ac-goog


