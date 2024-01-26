Return-Path: <linux-kernel+bounces-40705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A883E463
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE6B282E63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6EB25115;
	Fri, 26 Jan 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itoCH0UH"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C524B3B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306265; cv=none; b=YvUX8v44s2MPhD+37VCE2Q3FXYbhZcFd0shwpaFfzLV6HTEuLYYLb/aGqg+4GsDVJdgyiuyMS6EgUu2hcngLVuRIvkvq2f1zGhgpA5Wxm1oqt5GZN9eRMKSbEUJ2xidrvlatStlnj4MCFbpuQpsROD+wT9tUoaEhhZclTZqqfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306265; c=relaxed/simple;
	bh=zO9cVAH7n733gpV+PNl/vPw5ydOQCNnJPy3qeP8X464=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BYWH77PRBgXgpl1eliFnPQsLMnow3Aassqnm4ZWxy08uPi0kx6hx00D+ZzMjYsiJyRI3FF8F8bu8aMimeZgHWf5uA2bNTAOXAFHnVYn6DngEsQux25I/5sOuKgrneMIkW05OG+zTkvBrndYx4B4tSnT9uZM3d3aPbR8xwnyG2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itoCH0UH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1675460a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706306263; x=1706911063; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZR76Mt8xziwfSistkUW1jBg0EL27dW4xkS7ZOhU810=;
        b=itoCH0UHLPK2tfZqErpSdrqAq04TrfgJD4hdPyOQLmMhUbY21TbkOOf16ANN77H/xc
         KkoIBUxq1zjMaCwRblenknEANQqp1lVaYEk4SH1lid3W1R0DmBLTs2doAhf0nZ5jFzX+
         guWF0G10Ubn5O74eLFtyIV85SJKFpGRrFuJS/GN/FjjkIRxH50knRGAYrXRTf5lyD9nU
         tvQuUNrpMJrfjM24HkLHxnz2NFuVd3LmkROn1bdQcES1uHyciKFLUULOkCO90p95StM9
         c7RRjRAiXbvdQaOYi4hTbMZohQAaoUgNq3bhL0y2LrvxL/y+g4JygYHS4B8na9VnRXlY
         Ggug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306263; x=1706911063;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZR76Mt8xziwfSistkUW1jBg0EL27dW4xkS7ZOhU810=;
        b=RFYbSz/xMBxQstP6w8cPG9KQU95rdWWlE/qqKwj4RQ9eMfW1acNcY3w/aHB2/IofvR
         SKlneTN41e/pIXeXRgPtDrEhglxEcplIoa1ADiOrWXpK8SOMQFmitA4xYDXcJbXuHzlW
         7oPAg7qVYGsqWZhYYHagfFq6rckbszb5aFpM0gEgKQyVuN2u53jVgUsSdnZDC9kfCweM
         1TJ5aeNrAcO3p+jDdv2Wd48aasIgHnskOTMRLZ/jwCJi3OqMXC2IQzhGaua5Jkm4hQys
         P803EusQAHQ/eGAYZMmD4va23BXE+UDlYlMxN+WCslb3EpoOTYK9WMyBCCD4xQUeckBd
         +9aQ==
X-Gm-Message-State: AOJu0Yw1WW5M9cfmMx7axUYzJ/ZSR9HsioPPFZeixT+4Q7eKzGDJ1Dmi
	RMvUmIlnWvxBQY7kveqnBIqaCYVDf+Nhy24HFCZUqape3yofTv86
X-Google-Smtp-Source: AGHT+IGRe9lNwNYtoL5Qoj4J8xH8ffCmWNPtVRKxJHGXuBP+pHiLKCfJAqcr7AiXGfUuHY5BJOGuPA==
X-Received: by 2002:a17:90a:c593:b0:290:8eb8:aca8 with SMTP id l19-20020a17090ac59300b002908eb8aca8mr608644pjt.21.1706306262887;
        Fri, 26 Jan 2024 13:57:42 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id su16-20020a17090b535000b00293851b198csm1627686pjb.56.2024.01.26.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:57:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Jan 2024 11:57:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH wq/for-6.9] workqueue: Drop unnecessary kick_pool() in
 create_worker()
Message-ID: <ZbQq1darzrS4wQzj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 6a229b0e2ff6143b65ba4ef42bd71e29ffc2c16d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 26 Jan 2024 11:55:46 -1000

After creating a new worker, create_worker() is calling kick_pool() to wake
up the new worker task. However, as kick_pool() doesn't do anything if there
is no work pending, it also calls wake_up_process() explicitly. There's no
reason to call kick_pool() at all. wake_up_process() is enough by itself.
Drop the unnecessary kick_pool() call.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to wq/for-6.9.

 kernel/workqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ee6aa1b897e0..b6b690a17f7c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2217,12 +2217,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
-	kick_pool(pool);
 
 	/*
 	 * @worker is waiting on a completion in kthread() and will trigger hung
-	 * check if not woken up soon. As kick_pool() might not have waken it
-	 * up, wake it up explicitly once more.
+	 * check if not woken up soon. As kick_pool() is noop if @pool is empty,
+	 * wake it up explicitly.
 	 */
 	wake_up_process(worker->task);
 
-- 
2.43.0



