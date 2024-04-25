Return-Path: <linux-kernel+bounces-158306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EE78B1E19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB17F1F241A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70285C51;
	Thu, 25 Apr 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QyZCjowV"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC128F7;
	Thu, 25 Apr 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037682; cv=none; b=O80xLksafUvCRuTotBBsTGgwS1Q7eq74ec0lMh3PtIHml1vzJiuSFJHtV9bJ4aa2SCO/Vcu3K/LM8wwSU7DGwUaCF54+pgLDDGiw4hj0CWJKxd1g6xke/w/zEsmKAO3a0qNmxS74u9cg/yJkDz5Xu7xKtUSE2MVASnJ4DzLkrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037682; c=relaxed/simple;
	bh=EuhJ5pCSf56nOe7Um3HD/ln5MpIugZZ8IutpRcMayJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRvJw99KRrK9RH5EO/AMAfnFgSZyAKHu88XviqtGXnXikB5g74pHQfnBSZm7TBy+qcCEU2YoPSC1H+so84bVIOy3A3sblDOeGvxWjPnoo+3Petqz+syQz5TPM0qbn9Jbq4HQiQ7WnZCh1ggba/rhWeTq9/haFwaMfWd0vW0YVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QyZCjowV; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714037672; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TlpWMGUo05cehXHx5vwtwe5vwkVUkHCY0eMZXZFb4oo=;
	b=QyZCjowV8rtIsTmciVAGSHg9zeDtdu15ZW6sczUaiu+lYdKXHiyoobJktvnLML76Z8udUX0c0KvJgpHaqp0wFxfJiRGQWMPfeZadeCyjl67XMnVmv/63BIu5Ud0FOy+vdxMh8/ITnBYwTVPU4X0GNg0C0Tyoh4g2sinE5GBPfaM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5F1EHS_1714037668;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W5F1EHS_1714037668)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 17:34:31 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v3 0/1] ACPICA: AEST: Support AEST V2
Date: Thu, 25 Apr 2024 17:34:25 +0800
Message-Id: <20240425093426.76130-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AEST V2 was published[1], add V2 support based on AEST V1.

Change from v2:
- delete patch which not merged to ACPICA.
- rebase on top of linux-next.
Change from v1:
- fix error variable name in struct acpi_aest_node_interface_64k. 

[1]: https://developer.arm.com/documentation/den0085/latest/

Ruidong Tian (1):
  ACPICA: AEST: Add support for the AEST V2 table

 include/acpi/actbl2.h | 88 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

-- 
2.33.1


