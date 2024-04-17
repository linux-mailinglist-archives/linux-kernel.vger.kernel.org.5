Return-Path: <linux-kernel+bounces-148412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7429B8A8239
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50851C22DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DD13CA9E;
	Wed, 17 Apr 2024 11:39:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25184E15
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353943; cv=none; b=rgetBex5UAlyDLSO9OhQpIzZY9Pz4yrO1oAO4/g5EZOARAT7SIiLxKXMexO2kxUEm0LBeJ7X6x7KUf2pALeOa+k7tvf/DoNvOi+7G7pv/cEzPY7x1gJgJm6s1P+Fr453SEYfHKOyvp/OUKfEE9rw1Ykew0jrhp9G1xc2eYOF8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353943; c=relaxed/simple;
	bh=h5EC7q98U2GwMcxqPEpZHXfJRLGRetzbo7g0quOIuHo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=suC0+tEwKQjZw2c/Q6DYpuShCHpXVP6Iq7VXyrNSV4nyN9JZFEkrkZ1oFncXWBu12/BeHD5kbGVvdvW2tj3dxlsaGeKf1dIzy2t7UuL0M+16NTaG5Mq41h0ahD/yH2iiYIlYTAP0j37XgjX9TFlP9WIVSX2gDiMOALk2m9ucNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VKJN80vj2z1xtxF;
	Wed, 17 Apr 2024 19:19:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 727FE1A016F;
	Wed, 17 Apr 2024 19:22:15 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 19:22:14 +0800
Subject: Re: [PATCH V3] ubifs: correct UBIFS_DFS_DIR_LEN macro definition and
 improve code clarity
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240417092727.3803910-1-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e4bd7fcd-f740-b2f1-ad20-63860db9fa38@huawei.com>
Date: Wed, 17 Apr 2024 19:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240417092727.3803910-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/17 17:27, ZhaoLong Wang Ð´µÀ:
> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
> debugfs directory name, has an incorrect formula and misleading comments.
> The current formula is (3 + 1 + 2*2 + 1), which assumes that both UBI device
> number and volume ID are limited to 2 characters. However, UBI device number
> ranges from 0 to 37 (2 characters), and volume ID ranges from 0 to 127 (up

UBI device number ranges from 0~31? UBI_MAX_DEVICES(32)
> to 3 characters).
> 
> Although the current code works due to the cancellation of mathematical
> errors (9 + 1 = 10, which matches the correct UBIFS_DFS_DIR_LEN value), it
> can lead to confusion and potential issues in the future.
> 
> This patch aims to improve the code clarity and maintainability by making
> the following changes:
> 
> 1. Corrects the UBIFS_DFS_DIR_LEN macro definition to (3 + 1 + 2 + 3 + 1),
>     accommodating the maximum lengths of both UBI device number and volume ID,
>     plus the separators and null terminator.
> 2. Updates the snprintf calls to use UBIFS_DFS_DIR_LEN instead of
>     UBIFS_DFS_DIR_LEN + 1, removing the unnecessary +1.
> 3. Modifies the error checks to compare against UBIFS_DFS_DIR_LEN using >=
>     instead of >, aligning with the corrected macro definition.
> 4. Removes the redundant +1 in the dfs_dir_name array definitions in ubi.h
>     and debug.h.
> 5. Removes the duplicated UBIFS_DFS_DIR_LEN and UBIFS_DFS_DIR_NAME macro
>     definitions in ubifs.h, as they are already defined in debug.h.
> 
> While these changes do not affect the runtime behavior, they make the code
> more readable, maintainable, and less prone to future errors.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---

Please add change log v2->v3 next time.
>   drivers/mtd/ubi/debug.c | 4 ++--
>   drivers/mtd/ubi/ubi.h   | 2 +-
>   fs/ubifs/debug.c        | 4 ++--
>   fs/ubifs/debug.h        | 7 ++++---
>   fs/ubifs/sysfs.c        | 6 +++---
>   fs/ubifs/ubifs.h        | 7 -------
>   6 files changed, 12 insertions(+), 18 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

