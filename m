Return-Path: <linux-kernel+bounces-76700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BF85FB38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DC7282769
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193C146916;
	Thu, 22 Feb 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="qndECMbC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187D3A8E4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612025; cv=none; b=gwi+5rP8mjUPk/oEebTjHgXLFX23D35HjpF2IQWGEqnlaDammEAFrUmlZgnAKUIJp9RV7iSqOX0sRIzHyLV0zvDpPuIhQ5nMSlFkTYX55lIzZnEuieZrNlnnNi7BhgO0q76PEKp3BGT9vy018yTZJVUVfFP9eLTI5OZIUuuD8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612025; c=relaxed/simple;
	bh=pnB1WntP8Gv1YFEo/aQKUWzFx6FkdUowbH2Vi8gU1tM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ixl+W7W44lcOaW0byFd/oiFEKHFVTFcA4Zr91aKnwmns7+L6vpIahbRf4Tu3368r8GF/sJEChNeo//4fRg1tzJ+5rh/sbXdG3oi7eyqHKEMG3qinMGQulMYKD5R9S3pUxvX5f2n0a09YN1GEuxnBkuyz3v8kfj7hF7muufUyEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=qndECMbC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4128f3ee934so653345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1708612022; x=1709216822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaJdrvK3hwGXTlliZOo/iLP2nid8OIwhuTfcu0ARwIs=;
        b=qndECMbC4lRP/qAdiRzX8cGgMAPoFUzORncgrURK7aUZHDnfVOm0BHi/0njjzCR8vW
         tfYJGktPe7FqLAeNixREj5uDXiMnjB3iWaMp2sl/6aK4olsvWC2e3muxe1xpKxgrpMWK
         vxtNB8Gu0Y1/s1YL3pbwZE9kc9LsNDlkWi3n3w0baFEEmNIzV84krPLsJ9W351m70U+7
         qG0ulJ/klWTrLKxu4wlhWpP9QdK2R1I0OvQfw5yOigu4AmWzNo8sddfMFwymKBaVg+A/
         p5n0KQuQEOw0Z2SJyLmol7SW3eeA63C5W3B3s2u4YPqSl5xuMlvDqZB8TkHIONLDOoED
         y7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612022; x=1709216822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaJdrvK3hwGXTlliZOo/iLP2nid8OIwhuTfcu0ARwIs=;
        b=LdetgRSUQ1QZKDgYNFT2Hd1zlx/xR2+yzzaZIvtURmWOBfnickqsvTKg2tFZM/Fh8Q
         +PopbQgS5wSGf5+fa87b8DYKJo16NlpXhA0XnuBKWEksFFqKS7/K21kG+H2+nRxnbdS8
         KiJ0Hu8rVq+DUtX5duSNxLCsiyFoCV4T3ty64RPy/hagkpNg779jPIYj8UldM7fXF0Tw
         DW7+SVPV8V1+f3WXK1CX64ZYVXd09k8phJfYRThr8mbDyTbK91ahHH4HcV0PFpdYYrsq
         ru+wdBibV2c+sD5H4HJWiwT0jftvZU50hw2xK8t8H5GMqX8+8hKF6as/eeBWCTFjkCpx
         TXKA==
X-Forwarded-Encrypted: i=1; AJvYcCVKTJ0T7L8GGp0NsuVnCOMjiyD0FxTIYh10gsqzHQYboxGCGyixJd26RvH9JWfxAImPnVxu4UjTmzDLFmQMWa8IgOWgvCXFirHM68LV
X-Gm-Message-State: AOJu0YxBdZudoEDbDpP9L/B3HFp0QweY6p/JiJ5sFqeUFy/CD3i7gX5y
	7mxA5Fwl2LIjLMLcpU58HMomORDMaKrnbI8/YTFgThBb/jyVS/rhiPU+fSJVs4o=
X-Google-Smtp-Source: AGHT+IHKOBZVzHbJOfZyzZmyamercWbjonP0JEztuzdcHC6Uh8OuigGbTZ8CeuOR3g6hnYdepp+IDw==
X-Received: by 2002:a05:600c:511f:b0:40e:b313:b8db with SMTP id o31-20020a05600c511f00b0040eb313b8dbmr18990068wms.28.1708612021753;
        Thu, 22 Feb 2024 06:27:01 -0800 (PST)
Received: from bell.fritz.box (p200300f6af115800c74ac0a438dbc23e.dip0.t-ipconnect.de. [2003:f6:af11:5800:c74a:c0a4:38db:c23e])
        by smtp.gmail.com with ESMTPSA id ay25-20020a05600c1e1900b00411d3a414c6sm262913wmb.47.2024.02.22.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:27:01 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Nick Dyer <nick@shmanahar.org>,
	Brad Spengler <spender@grsecurity.net>,
	Sasha Levin <sashal@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal
Date: Thu, 22 Feb 2024 15:26:54 +0100
Message-Id: <20240222142654.856566-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling irq_domain_remove() will lead to freeing the IRQ domain
prematurely. The domain is still referenced and will be attempted to get
used via rmi_free_function_list() -> rmi_unregister_function() ->
irq_dispose_mapping() -> irq_get_irq_data()'s ->domain pointer.

With PaX's MEMORY_SANITIZE this will lead to an access fault when
attempting to dereference embedded pointers, as in Torsten's report that
was faulting on the 'domain->ops->unmap' test.

Fix this by releasing the IRQ domain only after all related IRQs have
been deactivated.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
Torsten, could you please confirm (again) that this patch, instead of
[1], fixes the bug for you?

[1] https://lore.kernel.org/lkml/e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain/

 drivers/input/rmi4/rmi_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395..42eaebb3bf5c 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -978,12 +978,12 @@ static int rmi_driver_remove(struct device *dev)
 
 	rmi_disable_irq(rmi_dev, false);
 
+	rmi_f34_remove_sysfs(rmi_dev);
+	rmi_free_function_list(rmi_dev);
+
 	irq_domain_remove(data->irqdomain);
 	data->irqdomain = NULL;
 
-	rmi_f34_remove_sysfs(rmi_dev);
-	rmi_free_function_list(rmi_dev);
-
 	return 0;
 }
 
-- 
2.30.2


