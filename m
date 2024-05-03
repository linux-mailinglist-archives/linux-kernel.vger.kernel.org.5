Return-Path: <linux-kernel+bounces-168074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1E8BB355
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A801F230EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A612EBFB;
	Fri,  3 May 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEKFjTt/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013A1CD1F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761440; cv=none; b=fGs2I223Kj2/r+2AHL3lhvR5IIEL+PKJkTwGo0ARuewcba0Mqb9PvJtKgdDQ7YwE8Xe+qw3xu0mX+KLwsJaeJLaXBSF9J35kLfi8alZ7mG7jnGjbJOpRzTgVFQjQK8zttARsjx9lDX4kcilirdr5XEp18LqOrHJgWWw76AU3IT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761440; c=relaxed/simple;
	bh=wm5pk9S0/JQcuHXC+N1ugdSHVS+48gum9vVTthDqGHE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LK1VT+l+8207ubSAB4nckqcONg8EYBdED6GGv8wKi8QSFbcaxJImZPHpGfv6556oGKCxLfkREDdwi2w1lpBqgCKX099DxwaO3FeAKHck9lnrJ9+9grU9ICTAkz6ftGW3Yk4k00iBoC7q6vNvcL2vdWhro9M+FFcqDE4N6i/pTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEKFjTt/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so11392276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714761438; x=1715366238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnbX50dR3baSwjlitnZlT2KQP1Bjq1hEVDevUqr+0/8=;
        b=yEKFjTt/QInii+9ewC1xT/FkuV5uef/g3PPIUNc2dZiBgOAvUfcXwpNuHjJqFtN02q
         AcM+lL89z2KaUp46Mbv3JZ5D6uSyvBIxNgX4JTCIOMEGEwDYUEl7INfag6TbZlqidmR+
         vwggkYbzbSrlgPXhh0mEzo2SwFdoG6sqj9uhrPnq9G+FXtkCn+nsMoJmgZ3IyswqVehz
         CdwgRqPEOwnoxH8s0hrYAw+YjeplLxoDfQp5SsBCc9FH+gyCPh61solB/pRGtu54r7HE
         Vwe0pYHLEMbvhRZqZ/fS8gfEHhwhlXBJQjhimsaI3uNgOP7cyHwEk/aSCmsZcN6ybTYq
         OXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761438; x=1715366238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnbX50dR3baSwjlitnZlT2KQP1Bjq1hEVDevUqr+0/8=;
        b=TY4VliC3QSufCy07ljBL+KteVJ4Fmv+0sNvOPKdZ6AXqr2V/CU8VYK+DLb6cTzYpo2
         bTKcLtwlAFmZkhoHZS21CrrUHs0FCYsPgNG2ABGs1wle692ppvsQy2ce82Wa2Y/EgFq3
         dLcjdXzIDCiHLvVC9b768xS6LdiYfELvrQEAgSICihgr/s124ykaZOnMJDQMLGl2l3Gv
         VfnAiRNE+hpRZ0H4Vtw27a9dtyIz4llzGm1aYMOlXsv6f4pcXhY7BY/D6z7mB3yRazn4
         /Vxvrr7Usn3WEvX8H5BsH0hu995Fs/Bw/UAOUOVGAxsMZCUByB3B/y5kLF0z4+DmOBPw
         x5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Dmj91bgJgZ2rc6Rtosp0DnmExHF57vreQ0YBT4Zr/W2084YVgnexfHqKfTBIpgB2wvp5ETUXS7IJMoyF987t/DP8f9vxI94wSRMY
X-Gm-Message-State: AOJu0YyNqXzIiy53LZEXdGVSExhPTbB4FEb464AlOCzsU7V8Mf59Z1HM
	l8zBRUyQZsITiQrrQs2lU+jgb4UJblx3H2lPYmvws93EAIX5YrQT0PF2cWTmynXIF3btdb4ry7g
	FgfvpehmI2i1PAg==
X-Google-Smtp-Source: AGHT+IEGJ2S4zgk0AufQ45l1QpKrNKuLv5DVdMLyALhLjEW3+o5Sl1DK7KUfHw9Mvzh7OZLZuz0tF0RKftLW7XU=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:102a:b0:dd9:2782:d1c6 with SMTP
 id x10-20020a056902102a00b00dd92782d1c6mr1222431ybt.1.1714761438256; Fri, 03
 May 2024 11:37:18 -0700 (PDT)
Date: Fri,  3 May 2024 18:37:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503183713.1557480-1-tjmercier@google.com>
Subject: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
not cacheline-aligned") sg_dma_mark_swiotlb is called when
dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
of a scatterlist. It is never set for the direct path, so drivers
cannot always rely on sg_dma_is_swiotlb to return correctly after
calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
direct path like it is in the IOMMU path.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..52f0dcb25ca2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -12,7 +12,7 @@
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
-#include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include "direct.h"
 
 /*
@@ -497,6 +497,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			goto out_unmap;
 		}
 		sg_dma_len(sg) = sg->length;
+		if (is_swiotlb_buffer(dev, dma_to_phys(dev, sg->dma_address)))
+			sg_dma_mark_swiotlb(sg);
 	}
 
 	return nents;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


