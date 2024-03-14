Return-Path: <linux-kernel+bounces-103178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FDC87BBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33EB1C214E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C756EB62;
	Thu, 14 Mar 2024 11:30:17 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6E0D36E61E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415817; cv=none; b=Jzc91aniuXMRxl7pFEdH3k+e/ih+ReoXxoTifeP/U8/8N07AcGziPukHDWPtbiGuGUdkHQBjYT5YSvbQUye2ob9UcVQ3QQLpUQiYOTU3f/6hNqM8K+TZMmjD/v7qT1J4HRPBzAY6OSqNOgDM1NXxiQwUrUH/RIBc4htwVv4sO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415817; c=relaxed/simple;
	bh=BV17QkmH0U2ifAlcV0mMWZci/Qg+LWsIi8yRH+XAR2A=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d43UMTjia5GyLZofulxrguMZnatnu8XirI6oEaePqfUp1rymmeW5DEb+TKKrp3BcbCNRANqVmAD6ET/krUEARQBnzHmE6h2wIDUaFZsr8L5J40H7uBqMxvQsQBeHi/Bapr06iEGIt1iLExNUfWo3pf23u1rb6KMFeWcik9bzSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 25E0818A2B6AAC;
	Thu, 14 Mar 2024 19:27:05 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 19:27:04 +0800
Date: Thu, 14 Mar 2024 19:26:53 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <akpm@linux-foundation.org>, <peterz@infradead.org>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <zyhtheonly@gmail.com>,
	<tiozhang@didiglobal.com>, <zyhtheonly@yeah.net>
Subject: [PATCH] bottom_half: remove local_bh_enable_ip
Message-ID: <20240314112653.GA8027@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, peterz@infradead.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	zyhtheonly@gmail.com, zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Remove local_bh_enable_ip since there is no caller.
We can refactor this when there is a first use-case.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 include/linux/bottom_half.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d9..48df8e669bb3 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -23,11 +23,6 @@ static inline void local_bh_disable(void)
 extern void _local_bh_enable(void);
 extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
-static inline void local_bh_enable_ip(unsigned long ip)
-{
-	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
-}
-
 static inline void local_bh_enable(void)
 {
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
-- 
2.17.1


