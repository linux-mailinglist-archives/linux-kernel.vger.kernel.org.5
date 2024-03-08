Return-Path: <linux-kernel+bounces-96550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13DB875DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593B61F22A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27B36134;
	Fri,  8 Mar 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhMvwzu7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AA3611E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878840; cv=none; b=A6jrQ2y96eVEF+XLTpblc3Ss3lxHDD5x7Gy66QIE8P/MEdzC8HlMNpLqIPL5SUXk5ATr7ooyvr+IEOL1Q07ihnBQd60D+tqfp2I6IJBl12dAjM2m/r88TY1CrmCR+0dbVcYqCllaKvTj3DTbJ/C1Sl6XqWoT3pQr5Bg3ZdDT6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878840; c=relaxed/simple;
	bh=APt9nw3iUKosH6rfvav1qdlGVyqi/IlhhjgYZZfNE5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfEAGto82BNWtbd3LC0LUHHaEGjHWejrCrczyLKJP/rlBqUYgUYMjVnqKo0qYfxOXb45YpY01u+rnVCE6teSWgC+6my7pRIX489rJYDO3hOYsM3qh286Gi1bkysg46WW68s1+rqCOuXD8uFZX5Yw9BV0JjfKRTOzLlFBRvffxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhMvwzu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078C5C433F1;
	Fri,  8 Mar 2024 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709878840;
	bh=APt9nw3iUKosH6rfvav1qdlGVyqi/IlhhjgYZZfNE5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JhMvwzu75vexwGA5XzB+R6ylBhI0lqs3sN6u5DHe4KGwhWryea2zpbIOkCRuA+fdf
	 8Jl8D84Xu89gZnrgRknzV04h9xQnYte2lwok+dlxQLz0Jl/I3R4HcXec1hxPCayIL6
	 Lh8LaS8te3qQf7HyGxLQf28rQCDs02vp70RDKpZl1KyPFC+7HZ+QG6RLyXcuxer2LA
	 NfHhvBiGLeEFg2u1kp2zyRqNi5Xv+BSZqIGInmNGDbWPds1pbDtfONc+8pmJrC5trI
	 kX0r5YbOdo02x6u/9qxjf4fYWEj6+F2rOqGVPpY51XS+i9TfbODVfiij6WndZD3MpY
	 K+dvnxu0H3O6A==
Message-ID: <73296ac6-8b00-4131-ab78-a127cdbff4b9@kernel.org>
Date: Fri, 8 Mar 2024 14:20:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] f2fs: fix to wait page writeback before update
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20200618063625.110273-1-yuchao0@huawei.com>
 <20200618235932.GA227771@google.com>
 <f5bbb14b-52a0-9697-a8fe-c3e39f78b0a5@huawei.com>
 <20200619054922.GC227771@google.com>
 <3634ef79-5903-449d-0d52-3d5566481863@huawei.com>
 <20200619224755.GA60059@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20200619224755.GA60059@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2020/6/20 6:47, Jaegeuk Kim wrote:
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index 3268f8dd59bb..1862073b96d2 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -1250,6 +1250,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
>>>>>>   				f2fs_put_page(psrc, 1);
>>>>>>   				return PTR_ERR(pdst);
>>>>>>   			}
>>>>>> +			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
> 
> Do you mean pdst can be under writeback?

Jaegeuk,

Look back this again, is it possible that pdst is writebacking
in below race condition? or am I missing something?

Thread A				GC Thread
- f2fs_move_file_range
  - filemap_write_and_wait_range(dst)
					- gc_data_segment
					 - f2fs_down_write(dst)
					 - move_data_page
					  - set_page_writeback(dst_page)
					  - f2fs_submit_page_write
					 - f2fs_up_write(dst)
  - f2fs_down_write(dst)
  - __exchange_data_block
   - __clone_blkaddrs
    - f2fs_get_new_data_page
    - memcpy_page

Thanks,

