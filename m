Return-Path: <linux-kernel+bounces-73944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7A85CDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B700D1F24BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC77EF9CC;
	Wed, 21 Feb 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R9oBRzmt"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174717BBA;
	Wed, 21 Feb 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481910; cv=none; b=TCbnBmcXzNzx68LmxP7Ea5pQVYHJZkGRze6kklY/dUSbZ9Z+nYEDd0y9MdRwFiFMb+YzeY0capeYhII2Q0/87g/zuB3cfDTlYa1V0w7O1fw2CCYXfEKaVLTjS5nGZVojGZMhFyvGPGbJtehrXVgwqSBwWYkaleJJe/oWhbrdqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481910; c=relaxed/simple;
	bh=rRqpE8h/KNn+FQIAVNM5vudNpdCVfCEusK6cOl+XA6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjcCL2EaWGuw7EYblxyajZDDKQdPZgkej8N4v1B8Z6/IZh0ZkUNqUCGHIf7fF8oc9TVEkEqGusOjiVsteRXQ8SQM5OEhWxWu5ZELhP4EISyswiC3ogHi5/FFfb0CSqmGdDLKLR1dGcoGTrUff8aKGC4KDGe8Wpjic2w2li9dXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R9oBRzmt; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708481905; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u91vHPmTfNCmbDbQ1w3BDcSiany6MNqpaa6ax/w7hOY=;
	b=R9oBRzmtj6TSc3lSFdTXsxrkQe1zJcI4CJqRT6qXmxd0e2Uhdm/B3N7GKqlc6dWynV7RiXFE96e7cP2BQWgehxpa0mAlBy6A7X7hr5RKAWDUW2DNGguk5mD5O+hzqT+X9p8pQi6b9MvD5d1VxlbUNRVUVbnrezcHDbWOplpijP0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0yLCp9_1708481903;
Received: from 30.97.48.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0yLCp9_1708481903)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 10:18:24 +0800
Message-ID: <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
Date: Wed, 21 Feb 2024 10:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix refcount on the metabuf used for inode
 lookup
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, stable@vger.kernel.org,
 kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240220191114.3272126-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240220191114.3272126-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sandeep,

On 2024/2/21 03:11, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Many thanks for the catch!

> ---
>   fs/erofs/namei.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index d4f631d39f0f..bfe1c926436b 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -132,7 +132,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>   
>   			if (!diff) {
>   				*_ndirents = 0;
> -				goto out;
> +				if (!IS_ERR(candidate))
> +					erofs_put_metabuf(target);
> +				*target = buf;
> +				return de;
>   			} else if (diff > 0) {
>   				head = mid + 1;
>   				startprfx = matched;

The fix is correct, yet I tend to try to reorganize this snippet for
simplicity, how about the following diff (untested)?

If it looks good to you, could you resend a formal patch? Thanks!

Thanks,
Gao Xiang

  fs/erofs/namei.c | 29 ++++++++++++++---------------
  1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..9fb2d627578e 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -129,25 +129,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,

  			/* string comparison without already matched prefix */
  			diff = erofs_dirnamecmp(name, &dname, &matched);
-
-			if (!diff) {
-				*_ndirents = 0;
-				goto out;
-			} else if (diff > 0) {
-				head = mid + 1;
-				startprfx = matched;
-
-				if (!IS_ERR(candidate))
-					erofs_put_metabuf(target);
-				*target = buf;
-				candidate = de;
-				*_ndirents = ndirents;
-			} else {
+			if (diff < 0) {
  				erofs_put_metabuf(&buf);
-
  				back = mid - 1;
  				endprfx = matched;
+				continue;
  			}
+
+			if (!IS_ERR(candidate))
+				erofs_put_metabuf(target);
+			*target = buf;
+			if (!diff) {
+				*_ndirents = 0;
+				return de;
+			}
+			head = mid + 1;
+			startprfx = matched;
+			candidate = de;
+			*_ndirents = ndirents;
  			continue;
  		}
  out:		/* free if the candidate is valid */
--
2.39.3

