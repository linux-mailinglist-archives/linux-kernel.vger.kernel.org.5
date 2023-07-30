Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46E7685E1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjG3OBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3OBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:01:22 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A261B1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:01:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoVu1lI_1690725672;
Received: from 192.168.75.41(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoVu1lI_1690725672)
          by smtp.aliyun-inc.com;
          Sun, 30 Jul 2023 22:01:13 +0800
Message-ID: <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
Date:   Sun, 30 Jul 2023 22:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
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


Hi Thomas,

On 2023/7/30 21:31, Thomas Weißschuh wrote:
> On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
>> Later we're going to try the self-contained image verification.
>> The current superblock checksum feature has quite limited
>> functionality, instead, merkle trees can provide better protection
>> for image integrity.
> 
> The crc32c checksum is also used by libblkid to gain more confidence
> in its filesystem detection.
> I guess a merkle tree would be much harder to implement.
> 
> This is for example used by the mount(8) cli program to allow mounting
> of devices without explicitly needing to specify a filesystem.
> 
> Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
> break when the checksum is removed.
I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
checksum instead (e.g. just sum each byte up if both
EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
ignore checksums completely at least in the kernel) if the better
filesystem detection by using sb chksum is needed (not sure if other
filesystems have sb chksum or just do magic comparsion)?

The main problem here is after xattr name filter feature is added
(xxhash is generally faster than crc32c), there could be two
hard-depended hashing algorithms, this increases more dependency
especially for embededed devices.

Thanks,
Gao Xiang
