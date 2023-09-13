Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B979F3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjIMVkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:39:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6B1724;
        Wed, 13 Sep 2023 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=48r3LmrgWqvz5u5eIUpGGEPK/Lk9nbvvc+00TP93HT4=; b=Ly53LDjNPUK0msN20agsJpsFB9
        tu4g3paJXuQX0CBlid9vm9cOfN03q5znld30M+1NwbjwQsX2mFB2j8m2YOepDPLFmKKzhT0VBDY7/
        jEUjb0cEd1O5vI49ztluO98TzjOtx3Sz+g/0ZmrjDYQVVzqRKUNv/RRZATv6k2hyVXb1qZO5peiDF
        VIJlofYQDAXrtdnFCCXcVMu/A++ydwfEEfulzVk09HgBwcPPgxIWmtO941FwpZYjeG0FGisgcHGud
        zE+MCSYnk0Y3okBn+vPICWqaU5SHHjAUIm9c6d90m9Z8E/Ka9pwCJqL5QsBolgExKkrYOmhbLyfDn
        QrdDR+Iw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgXaS-006l98-18;
        Wed, 13 Sep 2023 21:39:52 +0000
Message-ID: <28c68588-401e-4207-8b83-f68761f0a137@infradead.org>
Date:   Wed, 13 Sep 2023 14:39:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
 <20230913210829.zkxv6qqlamymhatr@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230913210829.zkxv6qqlamymhatr@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 14:08, Josh Poimboeuf wrote:
> On Tue, Sep 12, 2023 at 04:36:55PM -0700, Randy Dunlap wrote:
>>
>>
>> On 9/11/23 22:26, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230911:
>>>
>>> New tree: bcachefs
>>>
>>> The bcachefs tree gained a semantic conflict against Linus' tree for
>>> which I applied a patch.
>>>
>>> The wireless-next tree gaind a conflict against the wireless tree.
>>>
>>> Non-merge commits (relative to Linus' tree): 4095
>>>  1552 files changed, 346893 insertions(+), 22945 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>
>> on x86_64:
>>
>> vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> 
> Here ya go:
> 
> ---8<---
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()
> 
> In general it's a good idea to avoid using bare unreachable() because it
> introduces undefined behavior in compiled code.  In this case it even
> confuses GCC into emitting an empty unused
> bch2_dev_buckets_reserved.part.0() function.
> 
> Use BUG() instead, which is nice and defined.  While in theory it should
> never trigger, if something were to go awry and the BCH_WATERMARK_NR
> case were to actually hit, the failure mode is much more robust.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: bch2_bucket_alloc_trans() falls through to next function bch2_reset_alloc_cursors()
>   vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Josh.


> ---
>  fs/bcachefs/buckets.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
> index f192809f50cf..0eff05c79c65 100644
> --- a/fs/bcachefs/buckets.h
> +++ b/fs/bcachefs/buckets.h
> @@ -180,7 +180,7 @@ static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_waterma
>  
>  	switch (watermark) {
>  	case BCH_WATERMARK_NR:
> -		unreachable();
> +		BUG();
>  	case BCH_WATERMARK_stripe:
>  		reserved += ca->mi.nbuckets >> 6;
>  		fallthrough;

-- 
~Randy
