Return-Path: <linux-kernel+bounces-5481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91710818B28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F68B286D50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BB1CAA3;
	Tue, 19 Dec 2023 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY5mpPxm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002071CA85
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF64BC433C9;
	Tue, 19 Dec 2023 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702999497;
	bh=qK6fcLZbrwOVOezRdvRUvaswX/bcYxsDd54Ws22dFDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dY5mpPxmRg45jRMaYdDIidCd6Fb7OGS4flgm6YP1PcIMveLiNUy+Z59wp75S2pcV4
	 xGN8dNfhQkPoF0feRcftrPkxNKlKedfOa0XEMjgtlzk4El9yZhNETtz0sx94b7LLYf
	 pn1ROSw/kdLZb0fmJ9yJh3rzeH94t/6wnefurHmgBT+UtuZ449onyPmeWQz+jOimZt
	 CNWrZsjuAhJcjXgGYmafD/pzVGWudme61nfYj8MBxJSej5G5/Cui1nJSu8YHUzp9Rs
	 qdLrBK+XTiYIhJF/ntnakiUJjmoITaVSZuZLZksEP22dtfa0dkMlDVswaIptXhbxIu
	 ShzlptRjMAGnw==
Message-ID: <cac5bf07-9091-40b7-8fb2-01f7a032d2ef@kernel.org>
Date: Tue, 19 Dec 2023 23:24:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] f2fs: show more discard status by sysfs
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com>
 <6c553a75-4842-4b28-9725-ba5e297ff793@kernel.org>
 <CAHJ8P3LgQB9Q_TQj0nmjKXLsk95uVA2xvPXdvpK8Gjsonz-fHg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LgQB9Q_TQj0nmjKXLsk95uVA2xvPXdvpK8Gjsonz-fHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/19 12:09, Zhiguo Niu wrote:
> On Tue, Dec 19, 2023 at 12:00 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2023/12/19 10:21, Zhiguo Niu wrote:
>>> The current pending_discard attr just only shows the discard_cmd_cnt
>>> information. More discard status can be shown so that we can check
>>> them through sysfs when needed.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>> changes of v2: Improve the patch according to Chao's suggestions.
>>> changes of v3: Add a blank line for easy reading.
>>> changes of v4: Split to three entries
>>> ---
>>> ---
>>>    Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
>>>    fs/f2fs/sysfs.c                         | 33 +++++++++++++++++++++++++++++++++
>>>    2 files changed, 48 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> index 4f1d4e6..606a298 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> @@ -159,6 +159,21 @@ Date:            November 2021
>>>    Contact:    "Jaegeuk Kim" <jaegeuk@kernel.org>
>>>    Description:        Shows the number of pending discard commands in the queue.
>>>
>>> +What:           /sys/fs/f2fs/<disk>/issued_discard
>>
>> Add them to /sys/fs/f2fs/<disk>/stat/?
> I just want to keep them consistent with the entry "pending_discard"

There are too many entries in root directory of f2fs sysfs entry, so I
created the 'stat' sub-directory for later all read-only stat-related
entry. I think it's fine to create new discard stat entries there.

Thanks,

> if they are split to 3 entries.
> they are all discard related infos.
> Thanks
>>
>> Thanks,
>>
>>> +Date:           December 2023
>>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
>>> +Description:    Shows the number of issued discard.
>>> +
>>> +What:           /sys/fs/f2fs/<disk>/queued_discard
>>> +Date:           December 2023
>>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
>>> +Description:    Shows the number of queued discard.
>>> +
>>> +What:           /sys/fs/f2fs/<disk>/undiscard_blks
>>> +Date:           December 2023
>>> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
>>> +Description:    Shows the total number of undiscard blocks.
>>> +
>>>    What:               /sys/fs/f2fs/<disk>/max_victim_search
>>>    Date:               January 2014
>>>    Contact:    "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 7099ffa..666efdd 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -143,6 +143,33 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>>>                                &SM_I(sbi)->dcc_info->discard_cmd_cnt));
>>>    }
>>>
>>> +static ssize_t issued_discard_show(struct f2fs_attr *a,
>>> +             struct f2fs_sb_info *sbi, char *buf)
>>> +{
>>> +     if (!SM_I(sbi)->dcc_info)
>>> +             return -EINVAL;
>>> +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
>>> +                             &SM_I(sbi)->dcc_info->issued_discard));
>>> +}
>>> +
>>> +static ssize_t queued_discard_show(struct f2fs_attr *a,
>>> +             struct f2fs_sb_info *sbi, char *buf)
>>> +{
>>> +     if (!SM_I(sbi)->dcc_info)
>>> +             return -EINVAL;
>>> +     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
>>> +                             &SM_I(sbi)->dcc_info->queued_discard));
>>> +}
>>> +
>>> +static ssize_t undiscard_blks_show(struct f2fs_attr *a,
>>> +             struct f2fs_sb_info *sbi, char *buf)
>>> +{
>>> +     if (!SM_I(sbi)->dcc_info)
>>> +             return -EINVAL;
>>> +     return sysfs_emit(buf, "%u\n",
>>> +                             SM_I(sbi)->dcc_info->undiscard_blks);
>>> +}
>>> +
>>>    static ssize_t gc_mode_show(struct f2fs_attr *a,
>>>                struct f2fs_sb_info *sbi, char *buf)
>>>    {
>>> @@ -1025,6 +1052,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>>>    F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>>>    F2FS_GENERAL_RO_ATTR(main_blkaddr);
>>>    F2FS_GENERAL_RO_ATTR(pending_discard);
>>> +F2FS_GENERAL_RO_ATTR(issued_discard);
>>> +F2FS_GENERAL_RO_ATTR(queued_discard);
>>> +F2FS_GENERAL_RO_ATTR(undiscard_blks);
>>>    F2FS_GENERAL_RO_ATTR(gc_mode);
>>>    #ifdef CONFIG_F2FS_STAT_FS
>>>    F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>>> @@ -1084,6 +1114,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>>>        ATTR_LIST(max_ordered_discard),
>>>        ATTR_LIST(discard_io_aware),
>>>        ATTR_LIST(pending_discard),
>>> +     ATTR_LIST(issued_discard),
>>> +     ATTR_LIST(queued_discard),
>>> +     ATTR_LIST(undiscard_blks),
>>>        ATTR_LIST(gc_mode),
>>>        ATTR_LIST(ipu_policy),
>>>        ATTR_LIST(min_ipu_util),

