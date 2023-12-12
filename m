Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9280E514
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbjLLHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbjLLHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:50:24 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC9BE;
        Mon, 11 Dec 2023 23:50:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyLlE91_1702367425;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyLlE91_1702367425)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 15:50:27 +0800
Message-ID: <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
Date:   Tue, 12 Dec 2023 15:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Curtin <ecurtin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Daan De Meyer <daan.j.demeyer@gmail.com>,
        Stephen Smoogen <ssmoogen@redhat.com>,
        Yariv Rachmani <yrachman@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Douglas Landgraf <dlandgra@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Pavol Brilla <pbrilla@redhat.com>,
        Lokesh Mandvekar <lmandvek@redhat.com>,
        =?UTF-8?Q?Petr_=C5=A0abata?= <psabata@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Neal Gompa <neal@gompa.dev>,
        nvdimm@lists.linux.dev
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
 <ZXgNQ85PdUKrQU1j@infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZXgNQ85PdUKrQU1j@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/12 15:35, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 08:50:56AM +0800, Gao Xiang wrote:
>> For non-virtualization cases, I guess you could try to use `memmap`
>> kernel option [2] to specify a memory region by bootloaders which
>> contains an EROFS rootfs and a customized init for booting as
>> erofs+overlayfs at least for `initoverlayfs`.  The main benefit is
>> that the memory region specified by the bootloader can be directly
>> used for mounting.  But I never tried if this option actually works.
>>
>> Furthermore, compared to traditional ramdisks, using direct address
>> can avoid page cache totally for uncompressed files like it can
>> just use unencoded data as mmaped memory.  For compressed files, it
>> still needs page cache to support mmaped access but we could adapt
>> more for persistent memory scenarios such as disable cache
>> decompression compared to previous block devices.
>>
>> I'm not sure if it's worth implementing this in kernelspace since
>> it's out of scope of an individual filesystem anyway.
> 
> IFF the use case turns out to be generally useful (it looks quite
> convoluted and odd to me), we could esily do an initdax concept where
> a chunk of memory passed by the bootloader is presented as a DAX device
> properly without memmap hacks.

I have no idea how it's faster than the current initramfs or initrd.
So if it's really useful, maybe some numbers can be posted first
with the current `memmap` hack and see it's worth going further with
some new infrastructure like initdax.

Thanks,
Gao Xiang


