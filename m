Return-Path: <linux-kernel+bounces-72220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47385B0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021721F236F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006D2C18E;
	Tue, 20 Feb 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFF+bwTk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6298493
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396604; cv=none; b=j/ICtO+VA6j30l5KIRS0YDpJJbXhCBttpUWym6+KsGXavyIDae4AVozsH0JvLqp9pVZTJItt4hKgE0IF42mP+RwLA6dMjhloQjAxXySXyesvLwNqDSaUuOEeWGPWZTX5/IG9XmTA3mXKiP6lqozOVK8WYYp+NKsNVLOsDwylX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396604; c=relaxed/simple;
	bh=iSqzuEwP5M5h88YQ8/0qjtxCe233s6JS7YQMV0b2XT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kscm3by7NL2gkAUiuTtrnv/Rt62rsfRhCzq2jEIKx6OqPKrE90bjhd36nobeAVw9FhCseQW5yR0zd/wdFpShgmD8W5hdhe2DPU9e/mLKWQgrJsp1yUgWljeCPKRo8mCGwogHxTbO7fQuTXfq9gW9u9Wtyf6Z12KFhKe+2X6wAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFF+bwTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C43C433F1;
	Tue, 20 Feb 2024 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708396604;
	bh=iSqzuEwP5M5h88YQ8/0qjtxCe233s6JS7YQMV0b2XT0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CFF+bwTkDYEfAGpoNEmpskKPYUwflaqHqw2rJ+jEHkpin693UEE3uhkcmzzKxn4q4
	 Q3uVA7eXjoc2mMdK5nFTqjEdJsjweTE2HVOF2zcmfR9xTylHXy2Xm51rkSZr7StZl/
	 w5Zi1ZQl+gWFOAQdwYMHt25duTo2eJDfMgSYa95lVhURM42tf9zF8ccptG0K4pH07A
	 b0bUdk/b+qMpu8DYejrUW2eu/26FQ58O+UcNl6ZIx2VYIlpWQm5FFD3NCWrdmENfz0
	 DqhwhqSUcwfuRbXZLcsm3VPRcj9/Ldnz/mAGGRskBUt74vZzseZveYcBzMCLPj16Qd
	 1Zd2V5BCYj+Yg==
Message-ID: <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
Date: Tue, 20 Feb 2024 10:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org>
 <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
 <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
 <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
In-Reply-To: <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/19 22:36, Chao Yu wrote:
>>>> Please think about how to optimize this, which is really ugly now
---
  fs/f2fs/checkpoint.c | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 87b7c988c8ca..089c26b80be3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -135,7 +135,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
  }

  static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
-							int type)
+						int type, bool *record_error)
  {
  	struct seg_entry *se;
  	unsigned int segno, offset;
@@ -160,6 +160,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
  			 blkaddr, exist);
  		set_sbi_flag(sbi, SBI_NEED_FSCK);
  		dump_stack();
+		*record_error = true;
  	}

  	return exist;
@@ -209,10 +210,13 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
  			dump_stack();
  			goto err;
  		} else {
-			valid = __is_bitmap_valid(sbi, blkaddr, type);
-			if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
-				(valid && type == DATA_GENERIC_ENHANCE_UPDATE))
+			bool record_error = false;
+
+			valid = __is_bitmap_valid(sbi, blkaddr, type,
+							&record_error);
+			if (!valid || record_error)
  				goto err;
+			return valid;
  		}
  		break;
  	case META_GENERIC:
-- 
2.40.1


