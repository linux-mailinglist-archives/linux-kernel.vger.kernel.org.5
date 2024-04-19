Return-Path: <linux-kernel+bounces-151415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA538AAE93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2D1C2089A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A385656;
	Fri, 19 Apr 2024 12:35:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507380022
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530148; cv=none; b=A136ZNudWsSiqEJa7z7eom9In32AKG86/UHgjeZm9vEQy48ig+pcIZX2wGpF86vsJtpfgaWU+T3BdTN584NAqh3R4y1zVFJfoP/WE904GdouZhSf8xMBy4z26cVVohtBuhIGZMHwaFAdxZgNarAJyTXv595pAa0+v4k0JO7HTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530148; c=relaxed/simple;
	bh=GtxZQqgspqslmybbA9LI8ksFMPIvaK2pnMI+CrANGpM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okPoqwdC7EtcU+qURHEXKK8eWSLjbSUiFd3B5K5iE2/T0Eb4TMAYm22PzxZodh410Tu+LrtEghDkd8rP3jqDG73ZVsSSTK6XiKeqGqJMw17D5KrXlt/AM8TqwLl6CIU5TZwdfHYmVKZjKyOoH0S+kEWX7Jmq/XQSoU75nc9ZHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLYvH4K5szdb00;
	Fri, 19 Apr 2024 20:32:43 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id D821E18007B;
	Fri, 19 Apr 2024 20:35:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 20:35:38 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH -next v3 0/2] erofs: reliably distinguish block based and fscache mode
Date: Fri, 19 Apr 2024 20:36:09 +0800
Message-ID: <20240419123611.947084-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hi Christian,

As your original patch had some "DOS line endings", I failed at am it, so
manually changed the relevant content when making v2, which caused Author
to be modified, I just noticed this and corrected it, apologies for that.

Changes since v2:
  Get rid of erofs_fs_context.

Changes since v1:
  Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
  modifying fc->sb_flags.

V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
V2: https://lore.kernel.org/r/20240417065513.3409744-1-libaokun1@huawei.com/

Baokun Li (1):
  erofs: get rid of erofs_fs_context

Christian Brauner (1):
  erofs: reliably distinguish block based and fscache mode

 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 124 ++++++++++++++++++++------------------------
 2 files changed, 55 insertions(+), 76 deletions(-)

-- 
2.31.1


