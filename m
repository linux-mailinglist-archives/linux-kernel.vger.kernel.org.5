Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910387516CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjGMDfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjGMDf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:35:28 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FEC1FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:35:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnFF9iv_1689219321;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnFF9iv_1689219321)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 11:35:22 +0800
Message-ID: <440b56d9-eb9a-48a8-1042-b202c875dc02@linux.alibaba.com>
Date:   Thu, 13 Jul 2023 11:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] erofs: update on-disk format for xattr name filter
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
References: <20230712115123.33712-1-jefflexu@linux.alibaba.com>
 <20230712115123.33712-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230712115123.33712-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/12 19:51, Jingbo Xu wrote:
> The xattr name bloom filter feature is going to be introduced to speed
> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> lookup when running "ls -lR" workload.
> 
> There are some commonly used extended attributes (n) and the total
> number of these is approximately 30.
> 
> 	trusted.overlay.opaque
> 	trusted.overlay.redirect
> 	trusted.overlay.origin
> 	trusted.overlay.impure
> 	trusted.overlay.nlink
> 	trusted.overlay.upper
> 	trusted.overlay.metacopy
> 	trusted.overlay.protattr
> 	user.overlay.opaque
> 	user.overlay.redirect
> 	user.overlay.origin
> 	user.overlay.impure
> 	user.overlay.nlink
> 	user.overlay.upper
> 	user.overlay.metacopy
> 	user.overlay.protattr
> 	security.evm
> 	security.ima
> 	security.selinux
> 	security.SMACK64
> 	security.SMACK64IPIN
> 	security.SMACK64IPOUT
> 	security.SMACK64EXEC
> 	security.SMACK64TRANSMUTE
> 	security.SMACK64MMAP
> 	security.apparmor
> 	security.capability
> 	system.posix_acl_access
> 	system.posix_acl_default
> 	user.mime_type
> 
> Given the number of bits of the bloom filter (m) is 32, the optimal
> value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).
> 
> The single hash function is implemented as:
> 
> 	xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
> 
> where `index` represents the index of corresponding predefined short name
> prefix, while `name` represents the name string after stripping the above
> predefined name prefix.
> 
> The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
> used to give a better spread when mapping these 30 extended attributes
> into 32-bit bloom filter as:
> 
> 	bit  0: security.ima
> 	bit  1:
> 	bit  2: trusted.overlay.nlink
> 	bit  3:
> 	bit  4: user.overlay.nlink
> 	bit  5: trusted.overlay.upper
> 	bit  6: user.overlay.origin
> 	bit  7: trusted.overlay.protattr
> 	bit  8: security.apparmor
> 	bit  9: user.overlay.protattr
> 	bit 10: user.overlay.opaque
> 	bit 11: security.selinux
> 	bit 12: security.SMACK64TRANSMUTE
> 	bit 13: security.SMACK64
> 	bit 14: security.SMACK64MMAP
> 	bit 15: user.overlay.impure
> 	bit 16: security.SMACK64IPIN
> 	bit 17: trusted.overlay.redirect
> 	bit 18: trusted.overlay.origin
> 	bit 19: security.SMACK64IPOUT
> 	bit 20: trusted.overlay.opaque
> 	bit 21: system.posix_acl_default
> 	bit 22:
> 	bit 23: user.mime_type
> 	bit 24: trusted.overlay.impure
> 	bit 25: security.SMACK64EXEC
> 	bit 26: user.overlay.redirect
> 	bit 27: user.overlay.upper
> 	bit 28: security.evm
> 	bit 29: security.capability
> 	bit 30: system.posix_acl_access
> 	bit 31: trusted.overlay.metacopy, user.overlay.metacopy
> 
> h_name_filter is introduced to the on-disk per-inode xattr header to
> place the corresponding xattr name filter, where bit value 1 indicates
> non-existence for compatibility.
> 
> This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> compatible feature bit.
> 
> Reserve one byte in on-disk superblock as the on-disk format for xattr
> name filter may change in the future.  With this flag we don't need
> bothering these compatible bits again at that time.
> 
> Suggested-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

