Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AA7DEF73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjKBKFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbjKBKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:05:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38561123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:04:59 -0700 (PDT)
Received: from [100.117.177.39] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37CBC66057B6;
        Thu,  2 Nov 2023 10:04:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698919497;
        bh=E0sL6G+czFLuYbXDvQo/UAY0A04xkQOoIzL7vzNyKX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TT7UpWIKrUIddQiKJAZCyR8glOIBAtyMVeFu1+p5wcr6ijb2TLm9pgIY8y8LUXsbN
         zpFXwO5letfElxzjalV+NOjlzcg1GV9ZaDRlQZ0HoCfEtS0oFpHIF9mgSLso/IDTlQ
         bT4ISO9QR7Z5VBm+uyE6aHumqWM1UCN4CHgFD9X18UrqnD6SeAOgOJWcs4tXkX42X/
         FU6WcsrKqNxTCCUGS5o80w0eKBo9Z5wWldFv15XaJpGCh+wGA7UDAem1f7s0C1E00r
         +9Mgw2vTlIFj02fFL22PTrhFbS6TUJD5Lkz6UFup3iznSwn6huoXXsPen24Tw4nkMq
         SwAPW7YEZJzrA==
Message-ID: <30b49da5-fc1a-3a18-7eeb-d5bbb08b3e9c@collabora.com>
Date:   Thu, 2 Nov 2023 15:34:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fs: udf: super.c: Fix a use-after-free issue in
 udf_finalize_lvid
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@google.com, zsm@google.com,
        syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
References: <20231030202418.847494-1-shreeya.patel@collabora.com>
 <20231031113754.vwrj3pubynb6bnef@quack3>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20231031113754.vwrj3pubynb6bnef@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/23 17:07, Jan Kara wrote:
> On Tue 31-10-23 01:54:18, Shreeya Patel wrote:
>> Add some error handling cases in udf_sb_lvidiu() and redefine
>> the descCRCLength in order to avoid use-after-free issue in
>> udf_finalize_lvid.
>>
>> Following use-after-free issue was reported by syzbot :-
>>
>> https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
>>
>> BUG: KASAN: use-after-free in crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
>> Read of size 1 at addr ffff88816fba0000 by task syz-executor.0/32133
>>
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
>> Call Trace:
>> <TASK>
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>> print_address_description mm/kasan/report.c:284 [inline]
>> print_report+0x13c/0x462 mm/kasan/report.c:395
>> kasan_report+0xa9/0xd5 mm/kasan/report.c:495
>> crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
>> udf_finalize_lvid+0x111/0x23b fs/udf/super.c:2022
>> udf_sync_fs+0xba/0x123 fs/udf/super.c:2378
>> sync_filesystem+0xe8/0x216 fs/sync.c:56
>> generic_shutdown_super+0x6b/0x334 fs/super.c:474
>> kill_block_super+0x79/0xd6 fs/super.c:1459
>> deactivate_locked_super+0xa0/0x101 fs/super.c:332
>> cleanup_mnt+0x2de/0x361 fs/namespace.c:1192
>> task_work_run+0x22b/0x2d4 kernel/task_work.c:179
>> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>> exit_to_user_mode_loop+0xc4/0xd3 kernel/entry/common.c:171
>> exit_to_user_mode_prepare+0xb4/0x115 kernel/entry/common.c:204
>> __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>> syscall_exit_to_user_mode+0xae/0x278 kernel/entry/common.c:297
>> do_syscall_64+0x5d/0x93 arch/x86/entry/common.c:99
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7e8195fb6e17
>>
>> Fixes: ebbd5e99f60a ("udf: factor out LVID finalization for reuse")
>> Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Thanks for the patch but not every syzbot report is actually a bug. In this
> case you can notice that udf_load_logicalvolint() is actually checking
> validity of the Logical Volume Integrity Descriptor. The fact that later
> udf_sb_lvidiu() call overflows the buffer size is caused by the fact that
> syzbot overwrites the UDF filesystem while it is mounted and so the values
> we checked are not the same as the value we later use. That is not a
> problem we try to protect against (it is equivalent to corrupting memory).
> I'm working on patches to so that syzbot can reasonably easily avoid
> creating such invalid scenarios but so far they did not land. So I'm sorry
> but I will not apply your fix.

Hi Jan,

Thanks for the information and it definitely makes sense to not let syzbot
create such invalid scenarios. Maybe we can add some kind of filtering 
in syzbot
for these kind of issues in future but I wonder how to even identify 
these reports from syzbot
which is purposely trying to do some memory corruption. It seems hard to 
identify them
without understanding what the reproducer is doing.
Maybe this is a question for the syzbot team.



Thanks
Shreeya Patel
> 								Honza
>
>
>> ---
>>   fs/udf/super.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/udf/super.c b/fs/udf/super.c
>> index 928a04d9d9e0..ca8f10eaa748 100644
>> --- a/fs/udf/super.c
>> +++ b/fs/udf/super.c
>> @@ -114,6 +114,10 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
>>   	partnum = le32_to_cpu(lvid->numOfPartitions);
>>   	/* The offset is to skip freeSpaceTable and sizeTable arrays */
>>   	offset = partnum * 2 * sizeof(uint32_t);
>> +	if (sb->s_blocksize < sizeof(*lvid) || (sb->s_blocksize - sizeof(*lvid)) <
>> +	    (offset + sizeof(struct logicalVolIntegrityDescImpUse)))
>> +		return NULL;
>> +
>>   	return (struct logicalVolIntegrityDescImpUse *)
>>   					(((uint8_t *)(lvid + 1)) + offset);
>>   }
>> @@ -2337,6 +2341,8 @@ static int udf_sync_fs(struct super_block *sb, int wait)
>>   		struct logicalVolIntegrityDesc *lvid;
>>   
>>   		lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
>> +		if ((le16_to_cpu(lvid->descTag.descCRCLength) + sizeof(struct tag)) > sb->s_blocksize)
>> +			lvid->descTag.descCRCLength = cpu_to_le16(sb->s_blocksize - sizeof(struct tag));
>>   		udf_finalize_lvid(lvid);
>>   
>>   		/*
>> -- 
>> 2.39.2
>>

