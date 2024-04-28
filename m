Return-Path: <linux-kernel+bounces-161308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A68B4A80
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F26B2135B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320E05026D;
	Sun, 28 Apr 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MJwmZXo/"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051044F8A3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714289295; cv=none; b=h1OtuIKwa7dfJe1o9/+9eKprz8gqXy/d0eVjFDCzG6TvFk14QgopMqIJjYStzSY/TWkzbf2z4LhRYHDdUH+xTt3rD7o9uJ48vadwBmTcZQDwTt2RUAO/zTQod0FOPtpV6+PB/GXJ2/zrrw2NXmyPUEwDQsyF1ZiumASH4UPWcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714289295; c=relaxed/simple;
	bh=sRR+OoNe+CJbOABxoZNaQT2CCvoMwl0YHxGhGd8xLdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L/LsaT8MDyNvSaTklreA7H/VheL5b4/+ymz5waB33aGeZp1DMl26cOnNd7pt/4WNEC0NjnR0znYEm8H9GUp6b0Gs0p8DxBEZzJ2X2DSSLJrl8wqZLX40paefU2TUqIs27xXCwBe8EiPGMFU7F481FjKoBA7+n5BvmexYzpyOXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MJwmZXo/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=WY9vcFIYHyY28AUyfY/N7+e9B4gmGc0udXw0k/OYO9k=;
	b=MJwmZXo/FWA/xvxxIJYUtL/nMMLvvp3LAUnu4qVhcNvOYcnSO41NGaQtA2SN1M
	28Ekgtsxqs+ufDdfiU6gWvIvN/NeTCCJuidGTQSfRMKxs+HcxB2D2TQ5VWwe9ZGi
	YylLXdNVlsbK619BrjJQAOnIWmTnRFq3r3q+s1QOLuur4=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDnL_lz+i1mKrimCg--.12082S2;
	Sun, 28 Apr 2024 15:27:48 +0800 (CST)
From: huanglei <huanglei814@163.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH] parport: Increase buffer max length to avoid memory out of bounds overflow
Date: Sun, 28 Apr 2024 15:27:43 +0800
Message-Id: <20240428072743.14556-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL_lz+i1mKrimCg--.12082S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7CFWfZw4kGr4UKr45Jrb_yoW8Gr4Upa
	98Krs0krZ8t3yUGw4kZwsI93yrXa97X3W8WF17G34akr4jqFn7ZFn0kF9FkF9Ygrs7uaya
	grs3Kr1UCr4jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgYFZUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbisBfO9mV4JHDwtwAAsR

From: huanglei <huanglei@kylinos.cn>

Most of the time，will use 64 bit address.
such as port->base=0xffffffc010e21280 and then use
len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi),
port->base convert to string is "18446743799114896000" add
port->base_hi is "0" and "\t" "\n" len will be 23.
But buffer the original max length is 20, length 23 is out of buffer.
So to make sure 64 bit address will not experience buffer overflow,
need increase buffer size to 32.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 drivers/parport/procfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..6722ae620b68 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[32];
 	int len = 0;
 
 	if (*ppos) {
@@ -171,7 +171,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[32];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.17.1


