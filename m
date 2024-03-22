Return-Path: <linux-kernel+bounces-110884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D1886537
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9285BB22B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770754688;
	Fri, 22 Mar 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ppHwERJ+"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3D387
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075102; cv=none; b=MuOGygoZAfnlbyVehHw04jrJEfjPmXK12l2x/sORydJ21VWSGwGBnhKr0wDMTFs7c1EJJPc8qGBNAvPj6HpCsKmfDX4kXhf3rmNSwxVe9iBIUQwXGBMU/b3AVwQ6+wk5MijE2qUB/V6QMG3gE+Kc/0AJhsDzE3yMwRZurFN3JQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075102; c=relaxed/simple;
	bh=hbMBqp1L5tPgF5RfvNy4jdUY1gkApGXhR91Ftknm/J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otSJ/tt7xIMLVTkvfFOHwYUV4n9GXMU6StDTDjQkVx80QR/sV4j1jBwiX+iHveZqVON4tRkR65f8WSbzj5koDIsHvpyg0qyxX1xdU9kR9HWxYETWQTNNV8ssr2aGFbv0EF8yhqCU7Yw0XCGJ/5sChDqoBUL1Cr7gi+/1z/PF5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ppHwERJ+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alibaba-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711075091; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/BKF+Lmv7DzWepLEL6NR0Sdzy44W84qh6o/ulQjR0Lk=;
	b=ppHwERJ+4TfAS4YD0n482A7LLb932xQUhu+bii/B1tyL77ucXMHDfle5PEIsoqSvgeBs++z2ky5mrXvqSGe7uVYMCYpBQuYvg4Z7D1lyZiyeH0IL+YkmkquoyUWW/6VeqP+1yYlDMuIY99/DqwhecuGXbPNYSGoQFp9swhK4S4k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W30Q322_1711075090;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W30Q322_1711075090)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 10:38:11 +0800
From: "huangguanrui.hgr" <huangguanrui.hgr@alibaba-inc.com>
To: yuzenghui@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix double free on error
Date: Fri, 22 Mar 2024 10:38:10 +0800
Message-Id: <20240322023810.62914-1-huangguanrui.hgr@alibaba-inc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <aac642a4-85a1-6df4-1192-638ce0d5086e@huawei.com>
References: <aac642a4-85a1-6df4-1192-638ce0d5086e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We notice that:
In its_vpe_irq_domain_alloc, its_vm is from args, But in its_vpe_irq_domain_free,
its_vm is from domain->host_data.

Will these two values be different? For example, when other bugs occur?
If these two values is different, I think we can't handle these 2 cases together.

	if (err)
		its_vpe_irq_domain_free(domain, virq, i);
Because these will lead a memleak.

So I think that check the bitmap is a safe way to fix this. If bitmap is empty, that means 
its_vpe_irq_domain_free handles same its_vm which comes from its_vpe_irq_domain_alloc.

Thanks,
Guanrui

