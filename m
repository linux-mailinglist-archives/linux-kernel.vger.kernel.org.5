Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6C76A72B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHACrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHACru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:47:50 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE24114
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:47:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vojef4e_1690858064;
Received: from 30.221.145.62(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vojef4e_1690858064)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:47:46 +0800
Message-ID: <2d554e41-16d8-706d-20ae-4b03894384c0@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 10:47:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
 <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
 <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On 7/30/23 10:28 PM, Thomas Weißschuh wrote:
> Hi Gao!
> 
> On 2023-07-30 22:01:11+0800, Gao Xiang wrote:
>> On 2023/7/30 21:31, Thomas Weißschuh wrote:
>>> On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
>>>> Later we're going to try the self-contained image verification.
>>>> The current superblock checksum feature has quite limited
>>>> functionality, instead, merkle trees can provide better protection
>>>> for image integrity.
>>>
>>> The crc32c checksum is also used by libblkid to gain more confidence
>>> in its filesystem detection.
>>> I guess a merkle tree would be much harder to implement.
>>>
>>> This is for example used by the mount(8) cli program to allow mounting
>>> of devices without explicitly needing to specify a filesystem.
>>>
>>> Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
>>> break when the checksum is removed.
> 
>> I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
>> checksum instead (e.g. just sum each byte up if both
>> EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
>> ignore checksums completely at least in the kernel) if the better
>> filesystem detection by using sb chksum is needed (not sure if other
>> filesystems have sb chksum or just do magic comparsion)?
> 
> Overloading EROFS_FEATURE_SB_CSUM in combination with
> COMPAT_XATTR_FILTER would break all existing deployments of libblkid, so
> it's not an option.
> 
> All other serious and halfway modern filesystems do have superblock
> checksums which are also checked by libblkid.
> 
>> The main problem here is after xattr name filter feature is added
>> (xxhash is generally faster than crc32c), there could be two
>> hard-depended hashing algorithms, this increases more dependency
>> especially for embededed devices.
> 
> From libblkid side nothing really speaks against a simpler checksum.
> XOR is easy to implement and xxhash is already part of libblkid for
> other filesystems.
> 
> The drawbacks are:
> * It would need a completely new feature bit in erofs.
> * Old versions of libblkid could not validate checksums on newer
>   filesystems.

Thanks for pointing this out.   we indeed need further discussion for a
better solution.

As mentioned previously, we don't want two hashing algorithms dependency
for erofs.  The best idea as far as I can come up with is that,
introduce a new feature bit indicating XOR hashing algorithm for the sb
checksum, while the original EROFS_FEATURE_SB_CSUM is not set.  As for
the old version libblkid, only fs magic is available for the fs type
detection, not perfect but in a best-effort way.

-- 
Thanks,
Jingbo
