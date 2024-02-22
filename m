Return-Path: <linux-kernel+bounces-75876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EECE85F02B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4021F217FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71317C62;
	Thu, 22 Feb 2024 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgxftMf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE5179A1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573862; cv=none; b=EmB6JWJBmameiSl95TTx2DHqyZCtYF9X5GRbjquWwro96zhIGXGfy4OUXf7tE5p6uqvhhqi5h6hHLuk+x2PyOb9FEBkHPvPglUfsEl5hOLaGac++aLJhkivhn57KQYUsQUWyPuLF1zjFgPv6udoc411ncmGmTuk6VhTa+7J081I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573862; c=relaxed/simple;
	bh=AmuEmjS5wBqNkgpz1y48vQc7UX9xpoy7av58HWxwi4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUzsRUl9TStCHArszXO8C1VY+wDjMUN652tHbh8SPaFSzths2u43YkLLMNGuG8dHyMuQvcoSDHv+u/54hEkjKm2004a5McGW0lLEIW+BA3/UGWz9r1VhcDWg4PLNOlA63tc/XyjKFwWQzNugV+Yb6eLudKXb8ova7OgdN9rR6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgxftMf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12172C433C7;
	Thu, 22 Feb 2024 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573862;
	bh=AmuEmjS5wBqNkgpz1y48vQc7UX9xpoy7av58HWxwi4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgxftMf3qeKrempOip8cL2/wXV7Qe0jKIMhcyAMmARCfJBqkTlYH7pfkD6F/QEDTZ
	 2P0ENRO11mjnDNpCv7hBGSawqvMBUrKwIvKAyo8lWWM1ybhvBEaAxO17MqZhTpa5s8
	 p4M1UQxwr01Lyoo4Uq20z67ck3iuY3rBdOeZyv+q33OuN679bVcPNzASn9v8iNGGta
	 uZq3IHdkZiDV/rOlrAxoIpn+TDNnHXI7kWqvZLTjHfXKS5A0y2ZupIrqsVtIe3TzlI
	 02OEpLQLbaRfGSfvs/CNkUNZ5ABrzh6snjKoCgdgR9X5wQp4Gt7agAOY/qc7C/+elu
	 HdnajIsAvdc4w==
Message-ID: <c0adebd6-8aa3-4704-b429-a14775ed2dcb@kernel.org>
Date: Thu, 22 Feb 2024 11:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
 <c2ab9d88-b947-42e5-a1a2-204d58e0c1a8@kernel.org>
 <CAHJ8P3+LGb7pQyLVjsxYvLHgO87Wn41VRhVZ_kkvcdqC8y=5Lg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+LGb7pQyLVjsxYvLHgO87Wn41VRhVZ_kkvcdqC8y=5Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/22 10:15, Zhiguo Niu wrote:
> 
> 
> On Thu, Feb 22, 2024 at 9:37 AM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
> 
>     On 2024/2/20 14:11, Zhiguo Niu wrote:
>      > There is low probability that an out-of-bounds segment will be got
>      > on a small-capacity device. In order to prevent subsequent write requests
>      > allocating block address from this invalid segment, which may cause
>      > unexpected issue, stop checkpoint should be performed.
>      >
>      > Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.
>      >
>      > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com <mailto:zhiguo.niu@unisoc.com>>
>      > ---
>      > changes of v4: use more suitable MACRO name according to Chao's suggestions
>      > changes of v3: correct MACRO spelling and update based on the lastes code
>      > ---
>      > ---
>      >   fs/f2fs/segment.c       | 7 ++++++-
>      >   include/linux/f2fs_fs.h | 1 +
>      >   2 files changed, 7 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>      > index c25aaec..e42e34c 100644
>      > --- a/fs/f2fs/segment.c
>      > +++ b/fs/f2fs/segment.c
>      > @@ -2665,7 +2665,12 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>      >       if (secno >= MAIN_SECS(sbi)) {
>      >               secno = find_first_zero_bit(free_i->free_secmap,
>      >                                                       MAIN_SECS(sbi));
>      > -             f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>      > +             if (secno >= MAIN_SECS(sbi)) {
>      > +                     f2fs_stop_checkpoint(sbi, false,
>      > +                             STOP_CP_REASON_NO_SEGMENT);
> 
>     We should relocate stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT) outside
>     segmap_lock spinlock, due to it may sleep in f2fs_flush_merged_writes().
> 
> Indeed it is. How about the following fix?
> @@ -2665,11 +2665,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>          if (secno >= MAIN_SECS(sbi)) {
>                  secno = find_first_zero_bit(free_i->free_secmap,
>                                                          MAIN_SECS(sbi));
> -               if (secno >= MAIN_SECS(sbi)) {
> -                       f2fs_stop_checkpoint(sbi, false,
> -                               STOP_CP_REASON_NO_SEGMENT);
> -                       f2fs_bug_on(sbi, 1);
> -               }
> +               f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>          }
>          segno = GET_SEG_FROM_SEC(sbi, secno);
>          zoneno = GET_ZONE_FROM_SEC(sbi, secno);
> @@ -2700,6 +2696,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>          __set_inuse(sbi, segno);
>          *newseg = segno;
>          spin_unlock(&free_i->segmap_lock);
> +       if (secno >= MAIN_SECS(sbi))
> +               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);

How about this?

---
  fs/f2fs/segment.c | 12 +++++++++---
  1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0209ea77dd2..8edc42071e6f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2646,6 +2646,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
  	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
  	bool init = true;
  	int i;
+	int ret = 0;

  	spin_lock(&free_i->segmap_lock);

@@ -2671,9 +2672,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
  		secno = find_first_zero_bit(free_i->free_secmap,
  							MAIN_SECS(sbi));
  		if (secno >= MAIN_SECS(sbi)) {
-			f2fs_stop_checkpoint(sbi, false,
-				STOP_CP_REASON_NO_SEGMENT);
-			f2fs_bug_on(sbi, 1);
+			ret = -ENOSPC;
+			goto out_unlock;
  		}
  	}
  	segno = GET_SEG_FROM_SEC(sbi, secno);
@@ -2704,7 +2704,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
  	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
  	__set_inuse(sbi, segno);
  	*newseg = segno;
+out_unlock:
  	spin_unlock(&free_i->segmap_lock);
+
+	if (ret) {
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
+		f2fs_bug_on(sbi, 1);
+	}
  }

  static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
-- 
2.40.1

> 
>     Thanks,
> 
>      > +                     f2fs_bug_on(sbi, 1);
>      > +             }
>      > +
>      >       }
>      >       segno = GET_SEG_FROM_SEC(sbi, secno);
>      >       zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>      > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>      > index 9b69c50..755e9a4 100644
>      > --- a/include/linux/f2fs_fs.h
>      > +++ b/include/linux/f2fs_fs.h
>      > @@ -75,6 +75,7 @@ enum stop_cp_reason {
>      >       STOP_CP_REASON_CORRUPTED_SUMMARY,
>      >       STOP_CP_REASON_UPDATE_INODE,
>      >       STOP_CP_REASON_FLUSH_FAIL,
>      > +     STOP_CP_REASON_NO_SEGMENT,
>      >       STOP_CP_REASON_MAX,
>      >   };
>      >
> 

