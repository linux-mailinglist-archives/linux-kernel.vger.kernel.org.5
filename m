Return-Path: <linux-kernel+bounces-120269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACED88D520
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE84B21A29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7122F02;
	Wed, 27 Mar 2024 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u2cZT3LK"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED12F9F7;
	Wed, 27 Mar 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511110; cv=none; b=aQycm6r4TOEgUhAVY6OxAq2cItIRdzC3/XlZxrMPxzwqAjC7i8GXf+O4hTDh0oANd/kNjt7b2D0uZNcH19jVGJRWqjB2WYt7/lhykQ+XR0PaN4Tp1GV8o0pVCL0KsS0TmAoFwFDRggdjQmE3SEyzewsw1i7Qd8Qc2lllv5tLW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511110; c=relaxed/simple;
	bh=FTfNqGqoX1C/4a+e1EpbARAV4+MoXh44WYcFwmpSE3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCJwfsVfBNuIVXJRaXe+8tXUvkPAtJttpNcp3J//T2l7b1UWXcHglwWqBxUzRo0MKoqHJIuJ4YA9uRQaRFu3+AjYHt8AilaJla14PHdorX0O7E/w1ddRHEwyESbEXcvekRS9IxVlKTVXu3J2E9aSaf4uEy+HSSBYwcfyXFP1lw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u2cZT3LK; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711511105; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/xH8idhK+SSwSloy8fkS97DHK7CSC0wqGIH5jrYLSWk=;
	b=u2cZT3LKtnZSzavjHq9XtCbmx51wKmzX0Yhk5B4N/H8Xtpu4d7Fumyx90O2W17DZaaQULg4uVVoWWmcR552RHymGAwh18T/jQBxzv67xkDIKZQOPJUwHQmgKhb4vdYBf7QWOWAGXxoWWx9i3A6sUmx8cdn4Yzo5oEL1qa086wLk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NLs0l_1711511102;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W3NLs0l_1711511102)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 11:45:04 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidond@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 0/2] ACPICA: AEST: Support AEST V2
Date: Wed, 27 Mar 2024 11:44:58 +0800
Message-Id: <20240327034500.95601-1-tianruidong@linux.alibaba.com>
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

[1]: https://developer.arm.com/documentation/den0085/latest/

Ruidong Tian (2):
  ACPICA: AEST: Fix coding style at struct definition
  ACPICA: AEST: Add support for the AEST V2 table

 include/acpi/actbl2.h | 132 +++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 33 deletions(-)

-- 
2.33.1


