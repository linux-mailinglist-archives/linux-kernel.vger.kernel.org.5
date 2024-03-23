Return-Path: <linux-kernel+bounces-112383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D7887925
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0AD1C20DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BE47A70;
	Sat, 23 Mar 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBl8ASJN"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499D4087A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204956; cv=none; b=b/e/SnGeh3bZ8/LMObdrgapQ1XJ1DkFFGfrtdF/v2BuTU+DlREJSgc4xDNhrNof+9AKoRL+suhjHgdIrReoCmAfOBf7GJk4XsO6rSlr7KRwATWRYTl2B7dKAu9ci7JlVuO+68paB+YbFgE3N2WDF72JqLDqfjj21TuGTss7pY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204956; c=relaxed/simple;
	bh=7ebCW7CbJwqVaMFygFZzBIye7OBbsT9h9qWSN+xPl6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmsXDw7/rN7495UcqjQ7OUDlOQjYmQimclthpjdKLbFT4QYPo03HfqA+umhcDyEnYaBGXmfunIOfWzJ5b/n+tiU4b9DpUHC/YWrZx/V5XA9fGGoJ1EQdUHxEqTnVXpjQ2Uj34pp2zlId9YqDdc+9MYhbU+G37rqViXQOcpqxCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBl8ASJN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso2013077a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711204954; x=1711809754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+94WYFP1QQfvIjnFljmvS0CS5jUyC1rwqJQLRlMyd0=;
        b=TBl8ASJNC02945N0mOHI9KKKP6GCt2NKXrtlLUvtaX2ezhg/6eWwAyXewi1inSnD02
         JKQge4HxSbrRl+FfjYthuAyYlhTBpeHtQuZ2/+HMToroP3AGlO2qLaBE2ZG5Uc85DdSO
         YS5dyANct53rulFLsk7M+g/jnjv9nqY09mx0it9S6xyEag7G6aEeGAH8kwp8T7KGWbfj
         wdDF2Y96o4siYVGdgqk22Iv2KxdAzERciOtjazBYvuTO+Md7RCOGyZSfLm27X89o1wOO
         85vIuOR7usPwqB5b6VRrfDoAZ9SXZHQJhtXamoTmfVKOdOsh6C5dft2jag43Tq5PQQ7T
         3o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204954; x=1711809754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+94WYFP1QQfvIjnFljmvS0CS5jUyC1rwqJQLRlMyd0=;
        b=CQ/ftLGvsVrQmado5PUOQJy/bz8sSYf4eglivUV7CUBBnI3EClc7JzzcJ/LB9uwRoS
         oZtKD12r9RoYGCLoEWAcJ01eWBuxDDVIlP0qqBQiAsYTAyho5TzUYwad5PpA9MmoKaGY
         3SQcLonF6sz3wSAjjC+FOKMsUVQOZP9tL23WqGuO4q/dJJVmtCd6clvccbzfI9XT0Zy9
         Y3H8Z+aQ+WEljGiuFNYv5HfL+w81+CuA/SLJ9E77/41LkjryIh6aIk/46N04p8VkJe3b
         KyOqvdCEuo0V+WU4KhCl4WqrEiA0XzEFlUh9hA70LQ6TSqpb94coDD5eFPMo2xItmbFH
         f9ig==
X-Gm-Message-State: AOJu0YzQ2Ay+o788ZmbgbB1J23D4XBypfsNPLTOIMgLzPozwTxKdv9Tr
	UqS6ZIlFer0EtqqWQ7MimBk7msZA+5k1/8znLrAieYzWoOqMBJcd
X-Google-Smtp-Source: AGHT+IFX02mlaGmJsMNvNeXHYwsn53DZYHmThGvTyHuaFMdlElExnvezssX2VkK58zCovfim1uCV6g==
X-Received: by 2002:a17:90a:a604:b0:29f:8d52:d5da with SMTP id c4-20020a17090aa60400b0029f8d52d5damr1958973pjq.22.1711204953858;
        Sat, 23 Mar 2024 07:42:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id so10-20020a17090b1f8a00b0029c5ed2c9b3sm3727427pjb.21.2024.03.23.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:42:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 3/3] uio_pruss: Fix build failure on 32 bit builds with 64 bit physaddr
Date: Sat, 23 Mar 2024 07:42:28 -0700
Message-Id: <20240323144228.3924542-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240323144228.3924542-1-linux@roeck-us.net>
References: <20240323144228.3924542-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Builds on 32-bit systems with 64 bit physical address fail with

drivers/uio/uio_pruss.c: In function 'pruss_probe':
drivers/uio/uio_pruss.c:194:34: error:
	cast from pointer to integer of different size

The conversion itself is safe since sizeof(phys_addr_t) it in general equal
to or larger than sizeof(void *). Solve the problem by double-casting the
conversion.

Fixes: 7722151e4651 ("uio_pruss: UIO_MEM_DMA_COHERENT conversion")
Cc: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/uio/uio_pruss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 72b33f7d4c40..b8fedb6b4f29 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -191,7 +191,7 @@ static int pruss_probe(struct platform_device *pdev)
 		p->mem[1].size = sram_pool_sz;
 		p->mem[1].memtype = UIO_MEM_PHYS;
 
-		p->mem[2].addr = (phys_addr_t) gdev->ddr_vaddr;
+		p->mem[2].addr = (phys_addr_t)(unsigned long)gdev->ddr_vaddr;
 		p->mem[2].dma_addr = gdev->ddr_paddr;
 		p->mem[2].size = extram_pool_sz;
 		p->mem[2].memtype = UIO_MEM_DMA_COHERENT;
-- 
2.39.2


