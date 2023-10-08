Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6417BCDF5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjJHLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJHLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:08:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFEAC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oTvayMyjZo46AUHzE0UGk+kG6LLog/ryuQyAlblwuSY=; b=Hh6kLE76ItQrwxVzXND+nZwmEB
        GmbATU0ZUEzitwFxti1OYJ/vSZ3UJnRkSgR1AfuHSC8OfwCtcSr1j4Zkpp45C5zt2eQRmt0HO5IKw
        t0BmlxIQjGkhHtFrQmOwg/2b1gBnG4nls4unkqK+5PXhOM1AKlvHVl+eveAUH8ahxEOD7Sh0QQGrx
        7Jjt/QI57Y9pllTZyYcCLB6JFCBw9coioNun7uguq/hrLP/gh0wPlYYiQAT55I6lt0vrFK0eSltfb
        9Gb5ZIM6F/DN2DH0X+aVUcsLrVDLZ6K3GEnvCF5WSknJNngQdYCbr+NAOVYjFZncSpu2UgCeL79RF
        19GMkYGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpRdV-009RlG-4b; Sun, 08 Oct 2023 11:07:49 +0000
Date:   Sun, 8 Oct 2023 12:07:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, hughd@google.com, peterx@redhat.com,
        mike.kravetz@oracle.com, jgg@ziepe.ca, surenb@google.com,
        steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wanbin.wang@transsion.com,
        chunlei.zhuang@transsion.com, jinsheng.zhao@transsion.com,
        jiajun.ling@transsion.com, dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: Re: [RFC PATCH 4/5] mm: add page implyreclaim flag
Message-ID: <ZSKNhZldD8P3l7hA@casper.infradead.org>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
 <20231008095924.1165106-5-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008095924.1165106-5-lincheng.yang@transsion.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 05:59:23PM +0800, Lincheng Yang wrote:
> Add implyrecalim flag means that the page is reclaim from the user advise.
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a2c83c0100aa..4a1278851d4b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -138,6 +138,7 @@ enum pageflags {
>  #endif
>  	PG_hot,
>  	PG_cold,
> +	PG_implyreclaim,
>  	__NR_PAGEFLAGS,

Can you do all of this without adding three page flags?  We're really
tight on page flags.  At a minimum, this is going to have to go behind
an ifdef that depends on 64BIT, but it'd be better if we can derive
hot/cold/implyreclaim from existing page flags.  Look at the antics
we go through for PG_young and PG_idle; if we had two page flags free,
we'd spend them on removing the special cases there.

