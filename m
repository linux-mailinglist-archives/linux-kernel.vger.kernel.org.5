Return-Path: <linux-kernel+bounces-135643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3189C919
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E708AB226EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D31422B0;
	Mon,  8 Apr 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SFqy9yCM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6D1411EA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591773; cv=none; b=JhG4PIf/7U6/Iyd/Me2BNwG8vWeoGMepeR5FoCeU83hgE0eZJYfaX51zamzq7CoL2WcObXxPgeJ/qI4I22Oh8k9bdL5MhJ/utaVCMv14zs39cqrRth7MOb6gvAe4HGjK9UwufowLD7/0JFP925D7XIP5dWKIu85NCbS6eAgrcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591773; c=relaxed/simple;
	bh=vjjTYogJRZ/cNJXchl4GhHqilSsjZWJ6M7hg9rSsNCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bx9WMyU52wDal6vHpfEx+YloudIibi2jpDtpjwBM2tjR3vF0V7XBzErEeSQZeqCYOiwRhrWkOciW5SnrxDz4cYBATIwKNNJ5Ntbass3r8judpyjPnu9gCdhvqtXbTQg77X+yaLq3ITIJ4cwWFOvn5A2Ad+sTctnuoQjNc5CRg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SFqy9yCM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso1229369b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712591771; x=1713196571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3S+sayV8Xb4fBOHSM111duhifwyMfUVXCb44YuSt5A=;
        b=SFqy9yCMU11Y/NOlXu4XY3CFKOEZ8WkcdkYXKYakmRU4B6aTeGV3fmpLFgBXiPmaZJ
         uWF2u4uvxR+e6ldINRP5LBMNld8Zn1J+IZ+tYZYv+1FX9fDenRvxtA5rLmjr2rJlZ7RS
         rsLKY/DhEPLanfGC++OnquK3nCoYl/Qf14yYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591771; x=1713196571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3S+sayV8Xb4fBOHSM111duhifwyMfUVXCb44YuSt5A=;
        b=s+974cSP56zShmRzZGF/UTtRd34CkEkEapb82xd+J5Jxxx/S/OKsA69vrAQtXy9pH+
         Ow5Ai+iFhAjDsvkBfmKBNpkyFUlkRN7nFHXFAz4MjcpL1vaD9y0trc5fp+ipMKO3gIgu
         bKyehPArlLYum33Pk8pAPQkDJg3mc4K2PvSXJ8aepOsbgdcN2l9yPvHnbEtPZvMKalWE
         FVwYLZkGZlqxyPbtn5/y59sV7UOkfd7l5MadFMKl29LzS8jAX8TeHeRYXFJBtS8fNcy/
         sC8nN2IXbOU0mfBAHdeiYC7QuJ9x3Ater16tPWymcWP1eIIqwxW40dM0S4jcVWr2viiH
         9jQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsSL+Q0wJGvLLrV0YHOO6vnUfRP7uT6FyP1GOxijOCjOH8/z4wmZQHxwPrvuRYm3NorIR3CItW22XUQS8WGB1Mc24hIyd6vZMg4oAX
X-Gm-Message-State: AOJu0YwEU70or2cC4ooFLnNnOU8/u0eEXL9LrjPQLb/Nj6Oo3ZYxBk8A
	As72kr0cylvOcnhM4SU6BeOFL8ZOJ1nfXW+YAXbA9S9qyVAylZm18EhxzfMGkQ==
X-Google-Smtp-Source: AGHT+IFSU94hghksr4pU6DSn3YL0aeuWM0Ki29quuWZaYCGHog3UR5UilX0eyDeTOKdJQAO2AB9Zrg==
X-Received: by 2002:a05:6a20:c889:b0:1a7:a067:63f9 with SMTP id hb9-20020a056a20c88900b001a7a06763f9mr38586pzb.33.1712591771221;
        Mon, 08 Apr 2024 08:56:11 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id i4-20020aa787c4000000b006e64c9bc2b3sm6912402pfo.11.2024.04.08.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:56:10 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Print the memory decryption status just once
Date: Mon,  8 Apr 2024 11:56:05 -0400
Message-Id: <20240408155605.1398631-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stop printing the TT memory decryption status info each time tt is created
and instead print it just once.

Reduces the spam in the system logs when running guests with SEV enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 71ce046327cf ("drm/ttm: Make sure the mapped tt pages are decrypted when needed")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 578a7c37f00b..d776e3f87064 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -92,7 +92,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	 */
 	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		page_flags |= TTM_TT_FLAG_DECRYPTED;
-		drm_info(ddev, "TT memory decryption enabled.");
+		drm_info_once(ddev, "TT memory decryption enabled.");
 	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
-- 
2.40.1


