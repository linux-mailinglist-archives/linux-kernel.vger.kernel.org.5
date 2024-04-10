Return-Path: <linux-kernel+bounces-137999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7B89EAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17963282EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0722618;
	Wed, 10 Apr 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qft2KHiF"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32531427B;
	Wed, 10 Apr 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730977; cv=none; b=Bi8Vg9k1HYCs/aZZLh5H9hIeFWY7UpuPwuqfsFZvMOTZGwJp/kD1VDKNJlPThPj5kYXFhWUn6vBKc7JBqiPFg7aXc4oYlFX+Hv9SjWs3trRbmQFzonkzgQvpZHNEXXmTyneQMYRZXCQiGW5L313M2jRSDxS+NcUtMVLmivVulCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730977; c=relaxed/simple;
	bh=Ev47tvx7JfofKBhk6oSCIjZTqrZBBLZvAPDIHTSABL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pV76STRekTzt75YGpGUK7JAsIikkFmYPjkBhL9JDR6gDZOXMy2bvUUPVWeq5iXHgUqDsqaGDJJ2g6pSiWWAZFdVaXTa60613JkekphAURw6/UTBMTxEvd6ZcOKD/QJNrpI1bf6+DFgnY2GUkzanGOBP/lLZlysEyQQuKuV1vtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qft2KHiF; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712730972; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PvEQZq7/sWs0gwfpV9IvtL45iTzbI63TfJE3CNaP/so=;
	b=Qft2KHiF32qbuFabGERo7wtzg/Hkf4dqBUzrosC9I6tCmEt/gmovf8i8Sfw0npDkCghBf2NfXPRRwrpC2/kUxeHP7yEj8LRGmADul6Gc+FdseLEvHMSboVwRehx08+s9mcXvutKJKrwlqdvzpzk8YrHNRVoaqXirk6ULv3alSck=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4Gt47I_1712730970;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4Gt47I_1712730970)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 14:36:12 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
Date: Wed, 10 Apr 2024 14:36:00 +0800
Message-Id: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AEST V2 was published[1], add V2 support based on AEST V1.

Fix some code styling issues as well.

Change from v1:
- fix error variable name in struct acpi_aest_node_interface_64k. 

[1]: https://developer.arm.com/documentation/den0085/latest/

Ruidong Tian (2):
  ACPICA: AEST: Fix coding style at struct definition
  ACPICA: AEST: Add support for the AEST V2 table

 include/acpi/actbl2.h | 132 +++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 33 deletions(-)

-- 
2.33.1


