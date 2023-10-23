Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA67D36A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjJWMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjJWMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:32:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA5FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJFY8X0LVejcCRBFVYdhIF1qXCBsVefytU23IKc3AY4=; b=qMrKioZ+x8FlO4QCP58tEBEdnK
        MuV1OP0aqxem9GNl9HkQSsV3LuPI7opMOYbUJXuqdjvhWN9UIG8YrO3/HEZ1S/4A3t0914/4y7g6b
        1X9LoLwDXHXdggeSFK81VDAVnD8uaImDf1tH06nPdS+EDDHBiMso0rlWPzynJaiVWKoUcNG1RrAuE
        PsPl5wKUcX5z2a2RcczktTc83UfMWUN0imZkJCPy9NuZgVSsQLtp1US6VXlOj0Y2iqNJYd0O3uRrm
        66byqAykzfgIddcH7u/MriOFZvGlgbaOTPFC5v8nYv5wzH7qVUuqfvOQBjNmVm2kZBImEfF9I0tbY
        HhbLqPOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1quu6d-00DmuI-Vb; Mon, 23 Oct 2023 12:32:27 +0000
Date:   Mon, 23 Oct 2023 13:32:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v2 1/6] slub: Keep track of whether slub is on the
 per-node partial list
Message-ID: <ZTZn23OzQfAm6epp@casper.infradead.org>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <20231021144317.3400916-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021144317.3400916-2-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 02:43:12PM +0000, chengming.zhou@linux.dev wrote:
> +++ b/include/linux/page-flags.h
> @@ -478,6 +478,8 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
>  	TESTCLEARFLAG(Active, active, PF_HEAD)
>  PAGEFLAG(Workingset, workingset, PF_HEAD)
>  	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
> +	__SETPAGEFLAG(Workingset, workingset, PF_HEAD)
> +	__CLEARPAGEFLAG(Workingset, workingset, PF_HEAD)

This makes me nervous.  The __ versions can only be used when there are
guaranteed to be no other accesses to the flags.  It's never going to
be the case that we want code to call __folio_set_workingset().

_Assuming_ that it's safe to use the non-atomic flag setting, I'd
rather see this done as ...

static inline void slab_set_node_partial(struct slab *slab)
{
	__folio_set_workingset(slab_folio(slab));
	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
}

