Return-Path: <linux-kernel+bounces-72414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89985B2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F01F21F02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B71EB38;
	Tue, 20 Feb 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP2M/23H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76E1C2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410764; cv=none; b=m+JnGi+utjqa8Off5vqGwrCJdu3uHZTbBd63TQWTo9d/ubSLjuqLFG9/DockgBYi/88SUaIGJ6pTmlX87gha5tiKwGL23MTyF6Asn1qB5xIoFf3UooJ15YHDygeldxddzMgrPx/TSC39rfKp6qgywANi9zMELWjZH8a9k2Cu3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410764; c=relaxed/simple;
	bh=7FCbXtCQC8jbpAcxOBZSP4jrUqIhvyAjm9IBPtEbhfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CobrUqQBD9zS/jc+FVlF27S2F2lbAmU0pTHQRHVe3KV1Z6TlFga+ep1lVEpNftcrBv4fTmD0TpebzajXrJFnJyV6K3ttAU06P6tL4ZXqfGOA9rG7RZl0udbqef+3k6ueMevJzHy2KtD/dQ2GDCc0jsX8x3A/TUk0jbVrvEDeLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP2M/23H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0538BC433F1;
	Tue, 20 Feb 2024 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708410764;
	bh=7FCbXtCQC8jbpAcxOBZSP4jrUqIhvyAjm9IBPtEbhfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WP2M/23HX7YWMbhL8/Bow1LNmCxN2KckoW9qywyZ468y9WBPfOmJ02RukitahCCEH
	 HoLJZX8MZ1dnaWOF0Xh8oYkPxSPRQxu/X2MU1DWRqLDiiIkQgtP2KbysqsQ9ckfPnK
	 e1YvgDrpqZWls7lDz3PdguHxG5IPEB1bnSNbnALOZmIt1FyAD1r5j0S0rQNFmH2W3L
	 RsKBYYs/UyAAz4cFhVeu7aQTvg9Ir8FDi/UG25GGhrpXqQQ2XwQjFqh9F9A04afrBH
	 eZdN2W5fegnsIJC5bIPxO/g25SsrfhM7ED3ydxgj+Ogl+ylEMvQimx9qE8u7oT0mpG
	 zNoCwZwK6uy2g==
Message-ID: <c82f8a3f-0184-43c2-b67d-ca53338a153c@kernel.org>
Date: Tue, 20 Feb 2024 14:32:37 +0800
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
To: Zhiguo Niu <niuzhiguo84@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org>
 <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
 <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
 <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
 <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
 <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 13:34, Zhiguo Niu wrote:
> I think do f2fs_handle_error in __is_bitmap_valid is a good way.

Like this?

---
  fs/f2fs/checkpoint.c | 28 ++++++++++++++--------------
  1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 87b7c988c8ca..b8a7e83eb4e0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -155,21 +155,24 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
  		return exist;

  	if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
-		(!exist && type == DATA_GENERIC_ENHANCE)) {
-		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
-			 blkaddr, exist);
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		dump_stack();
-	}
-
+		(!exist && type == DATA_GENERIC_ENHANCE))
+		goto out_err;
+	if (!exist && type != DATA_GENERIC_ENHANCE_UPDATE)
+		goto out_handle;
+	return exist;
+out_err:
+	f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
+		 blkaddr, exist);
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	dump_stack();
+out_handle:
+	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
  	return exist;
  }

  static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
  					block_t blkaddr, int type)
  {
-	bool valid = false;
-
  	switch (type) {
  	case META_NAT:
  		break;
@@ -209,10 +212,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
  			dump_stack();
  			goto err;
  		} else {
-			valid = __is_bitmap_valid(sbi, blkaddr, type);
-			if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
-				(valid && type == DATA_GENERIC_ENHANCE_UPDATE))
-				goto err;
+			return __is_bitmap_valid(sbi, blkaddr, type);
  		}
  		break;
  	case META_GENERIC:
@@ -227,7 +227,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
  	return true;
  err:
  	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
-	return valid;
+	return false;
  }

  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
-- 
2.40.1



