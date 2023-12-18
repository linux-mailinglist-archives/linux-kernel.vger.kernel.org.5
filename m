Return-Path: <linux-kernel+bounces-2974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C17816568
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F21F218DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952E6FBA;
	Mon, 18 Dec 2023 03:34:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF96FBF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vye9d5e_1702870475;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vye9d5e_1702870475)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 11:34:36 +0800
Message-ID: <874cce7f-4545-450f-9d6b-4f3e3357281b@linux.alibaba.com>
Date: Mon, 18 Dec 2023 11:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: fix getting incorrect page mapping during
 page migration
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
 ziy@nvidia.com, xuyu@linux.alibaba.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <e60b17a88afc38cb32f84c3e30837ec70b343d2b.1702641709.git.baolin.wang@linux.alibaba.com>
 <ZXxn/0oixJxxAnpF@casper.infradead.org>
 <ZXxqTjZR0OAvjaXr@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZXxqTjZR0OAvjaXr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/2023 11:01 PM, Matthew Wilcox wrote:
> On Fri, Dec 15, 2023 at 02:51:43PM +0000, Matthew Wilcox wrote:
>> I'm not saying no to this fix, but dump_mapping() is supposed to be
>> resilient against this.  Is the issue that 'dentry' is NULL, or is it
>> some field within dentry that is NULL?  eg, would this fix your
>> case?
> 
> Uh, dentry is an on-stack dentry.  So obviously it's a pointer within it
> that's NULL.  Maybe this, having stared at the implementation of %pd?

Yes, I think below check can avoid crash of dentry_name() used by '%pd'. 
Maybe we should also initialize on-stack dentry by
struct dentry dentry = { };

I can send a patch with your suggestion. Thanks.

> +++ b/fs/inode.c
> @@ -588,7 +588,8 @@ void dump_mapping(const struct address_space *mapping)
>          }
> 
>          dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
> -       if (get_kernel_nofault(dentry, dentry_ptr)) {
> +       if (get_kernel_nofault(dentry, dentry_ptr) ||
> +           !dentry->d_parent || !dentry->d_name) {
>                  pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
>                                  a_ops, ino, dentry_ptr);
>                  return;

