Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223287CA380
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjJPJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJPJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:07:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447FAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:07:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E00C433C7;
        Mon, 16 Oct 2023 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447221;
        bh=vAcbyIOjw+AfWx5J2hAtjpDPMhfYDMRRsuqGfoxZOdE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tb73q4b432ITZ5MH14wlBR79fZaalJVSJg8mrF2qZBXgSeyGe0HN0vqyVoQmn3Dan
         yFdSivbWmot7QQs/d1dBUQ5tj/VjVCykPATcwUtcZacbTPl7h9FD777Hsfyr5k9SlY
         h5vz16bagkss48SsndbZO6lGWydvE0sVQpYX5f1NO9gDl/C2vkjvbQTY+Zs5s11LlE
         VBMDNK+nYNg7nNioI7rRsvpZ64Cn31lLKtC+wYc89ZiNs4prU12zgeQITtiG4kZY0h
         Tg1g22XH7t3pGURRYFVSPGjmynGlUKU7h7PC1E3zCjTIj2Bh5porivNN3eyZTXyqXI
         EYTHmjhmHX5cw==
Message-ID: <4409f648-40f6-c28a-ebe0-d2c69ecd11fc@kernel.org>
Date:   Mon, 16 Oct 2023 17:06:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] f2fs: fix error path of __f2fs_build_free_nids
Content-Language: en-US
To:     Zhiguo Niu <niuzhiguo84@gmail.com>
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1697194703-21371-1-git-send-email-zhiguo.niu@unisoc.com>
 <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org>
 <CAHJ8P3J+Rnx4dUDGesdrtajDdP_SxDaM6yyYbHRt4ij_wVGhsg@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J+Rnx4dUDGesdrtajDdP_SxDaM6yyYbHRt4ij_wVGhsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhiguo,

On 2023/10/16 17:02, Zhiguo Niu wrote:
> Dear Chao,
> 
> On Mon, Oct 16, 2023 at 3:37 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2023/10/13 18:58, Zhiguo Niu wrote:
>>> SBI_NEED_FSCK should be set for fsck has a chance to
>>> repair in case of scan_nat_page fail in run time.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>
>> Hi Zhiguo,
>>
>> Can you please check below update?
>>
>>   From 9a3459d2d62a12f8708d72aa7808a1def9f9d92f Mon Sep 17 00:00:00 2001
>> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Date: Fri, 13 Oct 2023 18:58:23 +0800
>> Subject: [PATCH] f2fs: fix error path of __f2fs_build_free_nids
>>
>> If NAT is corrupted, let scan_nat_page() return EFSCORRUPTED, so that,
>> caller can set SBI_NEED_FSCK flag into checkpoint for later repair by
>> fsck.
>>
>> Also, this patch introduces a new fscorrupted error flag, and in above
>> scenario, it will persist the error flag into superblock synchronously
>> to avoid it has no luck to trigger a checkpoint to record SBI_NEED_FSCK.
>>
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>    fs/f2fs/node.c          | 11 +++++++++--
>>    include/linux/f2fs_fs.h |  1 +
>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index a2b2c6c7f66d..57d9dd3a43bc 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2389,7 +2389,7 @@ static int scan_nat_page(struct f2fs_sb_info *sbi,
>>                  blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
>>
>>                  if (blk_addr == NEW_ADDR)
>> -                       return -EINVAL;
>> +                       return -EFSCORRUPTED;
>>
>>                  if (blk_addr == NULL_ADDR) {
>>                          add_free_nid(sbi, start_nid, true, true);
>> @@ -2504,7 +2504,14 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
>>
>>                          if (ret) {
>>                                  f2fs_up_read(&nm_i->nat_tree_lock);
>> -                               f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
>> +
>> +                               if (ret == -EFSCORRUPTED) {
>> +                                       f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
>> +                                       set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +                                       f2fs_handle_error(sbi,
>> +                                                       ERROR_INCONSISTENT_NAT);
>> +                               }
>> +
>>                                  return ret;
>>                          }
>>                  }
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 07ed69c2840d..039fe0ce8d83 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -104,6 +104,7 @@ enum f2fs_error {
>>          ERROR_CORRUPTED_VERITY_XATTR,
>>          ERROR_CORRUPTED_XATTR,
>>          ERROR_INVALID_NODE_REFERENCE,
>> +       ERROR_INCONSISTENT_NAT,
>>          ERROR_MAX,
>>    };
>>
>> --
>> 2.40.1
> 
> Thank you for your updates and these updates are more reasonable based
> on the latest code.
> In addition,  I also modified the following code after I checked the
> related flow of f2fs_handle_error.
> ERROR_INCONSISTENT_FOOTER is reused here,   any suggestions for this?
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d9e6087..94f5c7f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1467,6 +1467,7 @@ static struct page *__get_node_page(struct
> f2fs_sb_info *sbi, pgoff_t nid,
>                            ofs_of_node(page), cpver_of_node(page),
>                            next_blkaddr_of_node(page));
>          set_sbi_flag(sbi, SBI_NEED_FSCK);
> +       f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
>          err = -EINVAL;

err = -EFSCORRUPTED;

>   out_err:
>          ClearPageUptodate(page);
> 
> If you have no other suggestions, I will update the "PATCH V2"

How about changing above code in separated patch?

Thanks,

 > Thanks!
