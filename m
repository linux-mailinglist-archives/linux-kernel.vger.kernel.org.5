Return-Path: <linux-kernel+bounces-77067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174428600D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DFB1C25A49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1A15B11C;
	Thu, 22 Feb 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip/RahWO"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F515AADC;
	Thu, 22 Feb 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625677; cv=none; b=hsPplpYOEX0/Nn3HDxkrlp46/bDqfQOiyN79Z5M9qtpwLeuzlrRtfmEWcawKO91zsbq8fX/Rj/1aS+7VMen7oXkiaYehDS0Dm4+CBBpr7yeWw7iqRE7Usnuoo9CPSFF137aU5VzyK6K4E4IFksUSf8hIKZw+vgWUqp5csFCFlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625677; c=relaxed/simple;
	bh=hehS0w6hO7FJGuyL37cinIR04O81xbUbwcQ8/IF9q30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skcxczrLe1GFwMPA+dZtXEg+UWTOFjZiTOjGU/T6X6e09Be5GM7PHWwNLrtJSUml141WA8wnSeLuiuHHqoU5LGUFv/IV8kBR6UqRvvksGQWUqly9XA+Ex/jwztEzU+mf3klayBhAH3vrR9CsIc1ZVSR9XV3gFAcgtvFkPw0K/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip/RahWO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512cba0f953so83801e87.2;
        Thu, 22 Feb 2024 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625674; x=1709230474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBJgQUpt9QPAedIUl/F1sU9yR+N7bF2zoeqIhscgJyQ=;
        b=ip/RahWOByIQSo5VQwepSsBNIq1JyStsxebrp2ZB1QlN+AXLfINa5vFudlI8PHn7Gp
         gv/pY7fWo3V+vwP+rakFxeNAN3ZRHuLX1vjz+kv53f+FdF6+gQquYQhrXZd/3CkZiKWN
         pKax6BV3f7qGhldr+viKfJoqUHHEMOBDXESsG3UqrcMCTy5yxoH5a10Iu0W+WUcUxes7
         a0ER1ueNdDwtO42Z7w/9QNuTAXXEIrM/gyiXXn4+qyTMUqkU+H3776HcS92rSbTla/7J
         /Qe9tAyR4WljrCcUV4xubHX5E2O4vlX00Nq/HZ98fUg8x5EG0yheMQfNHH4nkIYr1R6w
         nmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625674; x=1709230474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBJgQUpt9QPAedIUl/F1sU9yR+N7bF2zoeqIhscgJyQ=;
        b=xCWl7U2aqGAchC1vmwAuHbdfbC8QFYulNdsBPc6jLwOMtKkisDmF75ocJc1rVqVP91
         TnWJgWPmahubW+j87fjuz/XuLgARxDdrzAD3BRTE2QZ3q/1+YnzBUyEVs8yarrKbReX0
         shL7QvSPGi4lNyrTgceoz2jT65reQ6slmTYzRRz4nCQny/kwC39Zu8KuHdHgtIUmotbv
         oY2K564LjSJrIrU/BzaOEaPVz5493QKVya2J88XDyWCINF0ZhF1pOl8y3k+v8QAl9G/3
         1bXZxITNszeIC6ypWJw+gCX57CfsYtUqdfvJF8lMa1ACt9HYa/b4FFbImJRzmMPahvyG
         SHKA==
X-Forwarded-Encrypted: i=1; AJvYcCXTlrFT9QCZ0grR+fqLx6K6bRyAclaHp4irSZPSLK7iuJ552jStrsl6IQcr/DUmpZpgAAiP7tRYmyAs2JvDVNFRD0N3y+o5vbCyextwFmv4c2upI2h6Fm4dOM8ntGFIObgXavipLmKzZg==
X-Gm-Message-State: AOJu0YyU2+l5pc1sE66bslRFFk7/V85w2bev5UeHpm+A4g3HXOo44Yc9
	ugmB5j5jPT7HZ8dWFRcBDqD7Lw9zuWaDtxo8HeWCtxdWgSWgIOuA
X-Google-Smtp-Source: AGHT+IHKAOKhAnBFoPeZwONNUJ2X2BwTf+yE6S14EUUfcztnzHrErdARP1//97DTkUotDbqufLNMLg==
X-Received: by 2002:a05:6512:3ba2:b0:512:a2c7:e44c with SMTP id g34-20020a0565123ba200b00512a2c7e44cmr12225023lfv.20.1708625673758;
        Thu, 22 Feb 2024 10:14:33 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q25-20020ac246f9000000b00512b0462438sm1744919lfo.116.2024.02.22.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:32 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/20] EDAC/synopsys: Use platform device devm ioremap method
Date: Thu, 22 Feb 2024 21:12:52 +0300
Message-ID: <20240222181324.28242-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DW DDRs CSRs resource descriptor is used by the devm_ioremap_resource()
function invocation only in the driver probe method. Thus convert the
platform_get_resource() and devm_ioremap_resource() couple to just a
single devm_platform_ioremap_resource() method call.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 9f79f14e57b2..6976ef84e952 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1334,11 +1334,9 @@ static int mc_probe(struct platform_device *pdev)
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
-	struct resource *res;
 	int rc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-- 
2.43.0


