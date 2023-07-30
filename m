Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360C76861E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjG3O4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjG3O42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:56:28 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4026170C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:56:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoW3cYo_1690728979;
Received: from 30.27.65.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoW3cYo_1690728979)
          by smtp.aliyun-inc.com;
          Sun, 30 Jul 2023 22:56:21 +0800
Message-ID: <abe47891-3bcf-6f0c-d71f-e7bbe24999d4@linux.alibaba.com>
Date:   Sun, 30 Jul 2023 22:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
 <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
 <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
 <ab54e2a5-ecbf-508f-b382-05648fb3a36c@linux.alibaba.com>
 <498e86f9-a7c3-4689-b277-319633a11789@t-8ch.de>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <498e86f9-a7c3-4689-b277-319633a11789@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/30 22:49, Thomas Weißschuh wrote:
> On 2023-07-30 22:37:19+0800, Gao Xiang wrote:
>> On 2023/7/30 22:28, Thomas Weißschuh wrote:
>>> On 2023-07-30 22:01:11+0800, Gao Xiang wrote:
>>>> On 2023/7/30 21:31, Thomas Weißschuh wrote:
>>>>> On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
>>>>>> Later we're going to try the self-contained image verification.
>>>>>> The current superblock checksum feature has quite limited
>>>>>> functionality, instead, merkle trees can provide better protection
>>>>>> for image integrity.
>>>>>
>>>>> The crc32c checksum is also used by libblkid to gain more confidence
>>>>> in its filesystem detection.
>>>>> I guess a merkle tree would be much harder to implement.
>>>>>
>>>>> This is for example used by the mount(8) cli program to allow mounting
>>>>> of devices without explicitly needing to specify a filesystem.
>>>>>
>>>>> Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
>>>>> break when the checksum is removed.
>>>
>>>> I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
>>>> checksum instead (e.g. just sum each byte up if both
>>>> EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
>>>> ignore checksums completely at least in the kernel) if the better
>>>> filesystem detection by using sb chksum is needed (not sure if other
>>>> filesystems have sb chksum or just do magic comparsion)?
>>>
>>> Overloading EROFS_FEATURE_SB_CSUM in combination with
>>> COMPAT_XATTR_FILTER would break all existing deployments of libblkid, so
>>> it's not an option.
>>
>> I think for libblkid, you could still use:
>>    EROFS_FEATURE_SB_CSUM is not set, don't check anything;
>>    EROFS_FEATURE_SB_CSUM only is set, check with crc32c;
>>    EROFS_FEATURE_SB_CSUM | COMPAT_XATTR_FILTER (or some other bit) is
>> set, check with a simpler hash?
> 
> We could change this in newer versions of libblkid.
> But we can't change the older versions that are already deployed today.
> 
> And the current code does
> 
> if (EROFS_FEATURE_SB_CSUM)
>    validate_crc32c();
> 
> So to stay compatible we need to keep the relationship of
> EROFS_FEATURE_SB_CSUM -> crc32c.

Yes, you are right, thanks for reminder.  We really need a new bit
for this.

> 
>>> All other serious and halfway modern filesystems do have superblock
>>> checksums which are also checked by libblkid.
>>>
>>>> The main problem here is after xattr name filter feature is added
>>>> (xxhash is generally faster than crc32c), there could be two
>>>> hard-depended hashing algorithms, this increases more dependency
>>>> especially for embededed devices.
>>>
>>>   From libblkid side nothing really speaks against a simpler checksum.
>>> XOR is easy to implement and xxhash is already part of libblkid for
>>> other filesystems.
>>>
>>> The drawbacks are:
>>> * It would need a completely new feature bit in erofs.
>>> * Old versions of libblkid could not validate checksums on newer
>>>     filesystems.
>>
>> just checking magic for Old versions of libblkid will cause false
>> positive in which extent?
> 
> Hard to tell for sure. But it would not surprise me if it would indeed
> affect users as experience has shown.
> 
> Imagine for example erofs filesystems that have then been overwritten
> with another filesystem but still have a valid erofs magic.
> With the checksum validation the new filesystem is detected correctly,
> without it will find the old erofs.
> 
> Sometimes the files inside some filesystem look like the superblock of
> another filesystem and break the detection.
> 
> etc.
> 
> Having some sort of checksum makes this much easier to handle.

Yes, but just checking magic for old versions of libblkid for new
generated images only.

I'm not sure about this all (I just suggest that we might need a simpler
algorithm like XOR instead for sb_chksum otherwise it seems too heavy),
let me just drop this commit from -next for further discussion.

Thanks,
Gao Xiang
