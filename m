Return-Path: <linux-kernel+bounces-84321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22286A4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EEB282695
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3744C7B;
	Wed, 28 Feb 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFf2d9Um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3F4A1A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083387; cv=none; b=GPLZjargb8WPPKGlpDM8TzWsrhkRDOWqawee9K102U+790pOmn1YBceqMSh78Hc3EukGT5yHaA9QhCt1YdxcBYDUhKiWLXc7BItz8tEMnaDuybz+R5BTYl7pkKdB8ddkdIBAoe7KaWK3xVNPuiekN3le2FMiD3daLwpllzK2VQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083387; c=relaxed/simple;
	bh=4RHgr8hwDvio26ZjrRIEjc1o1G4N6nvQ/z/qnal8zlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDsvC5tMwsDbqMqxeq828hHOxUrUQXylLcxdttGv4YNTXBxAJG1RdglxTbwmKnngUfyEXeLz84R4RK/D1y+zbryfU7q8AEHYvWZrSBe0evYytbm40X0Bx2jFpZKEqKAEc4hEFpH3j9/N+imx0u9pw9UDDxpwpIljBHoldBDghr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFf2d9Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B199CC433C7;
	Wed, 28 Feb 2024 01:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709083386;
	bh=4RHgr8hwDvio26ZjrRIEjc1o1G4N6nvQ/z/qnal8zlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hFf2d9Um1oLNPRpQKwnRWsQgSWfnZfclDq0mK6uTwtQon9JUl+0N2jeaceBhPe05M
	 +vNnLXQX+wCmKoVURItJ/yK7HRp19OAihBvkFMe8jFpp1a1FCRuhh+hykv+OI25i/A
	 de/BQ+qe6lWSR0IaGtrEME3ITZTIky0q/fBaDXjBmaB0zjcH2J4vEmKl0fFC1UFD8b
	 sfbiirOm495Y+vaDUJ9XwIYvUiw6kin3Ou81XN8YGvgX61zUILXkQbjtieERJ5QJKB
	 iC//ROnMNLxAaqwr801NkdP2V93BnnPpunLHarxr1USwTjfEw6HrgcfoNOhjO9esy1
	 ch64RekLx9hmw==
Message-ID: <bdacbc3c-87c0-42b7-980b-9f9830ab994c@kernel.org>
Date: Wed, 28 Feb 2024 09:23:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] f2fs: fix to don't call f2fs_stop_checkpoint in
 spinlock coverage
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240222121851.883141-1-chao@kernel.org>
 <20240222121851.883141-2-chao@kernel.org> <Zd4g2SgQn3v_ZJMj@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd4g2SgQn3v_ZJMj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/28 1:50, Jaegeuk Kim wrote:
> On 02/22, Chao Yu wrote:
>> f2fs_stop_checkpoint(, false) is complex and it may sleep, so we should
>> move it outside segmap_lock spinlock coverage in get_new_segment().
> 
> Chao, I merged this patch into
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=f3b576d209983b5d6e1cb130bfc8ca1f0bbcad6d

It's fine to me.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/segment.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index d0209ea77dd2..8edc42071e6f 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2646,6 +2646,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>>   	bool init = true;
>>   	int i;
>> +	int ret = 0;
>>   
>>   	spin_lock(&free_i->segmap_lock);
>>   
>> @@ -2671,9 +2672,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   		secno = find_first_zero_bit(free_i->free_secmap,
>>   							MAIN_SECS(sbi));
>>   		if (secno >= MAIN_SECS(sbi)) {
>> -			f2fs_stop_checkpoint(sbi, false,
>> -				STOP_CP_REASON_NO_SEGMENT);
>> -			f2fs_bug_on(sbi, 1);
>> +			ret = -ENOSPC;
>> +			goto out_unlock;
>>   		}
>>   	}
>>   	segno = GET_SEG_FROM_SEC(sbi, secno);
>> @@ -2704,7 +2704,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
>>   	__set_inuse(sbi, segno);
>>   	*newseg = segno;
>> +out_unlock:
>>   	spin_unlock(&free_i->segmap_lock);
>> +
>> +	if (ret) {
>> +		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
>> +		f2fs_bug_on(sbi, 1);
>> +	}
>>   }
>>   
>>   static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
>> -- 
>> 2.40.1

