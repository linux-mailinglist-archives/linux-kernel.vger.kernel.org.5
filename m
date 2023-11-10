Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5197E81F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjKJSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKJSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:51:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F72FEDF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LSjiu5PwW127C9bZviFZwDU1KNrehXObzTk474onep4=; b=TZbKzbUXxrmYZmRPlGshsSFfYW
        bg8n59u/i6MZJNW+Csk6uJIRv2R4aFZA6pEu5pBdQHbQxVpjjuEWsJpnkXPkDpiBzNzwDsHM8ZNf0
        Y665S8SHd6/BbkCialvVo0eoigFuVfCBrl9q4AvBRVB0hdwn7YGF9hiSqtzHRNvabx5+VlVKB9xjS
        ONMYdAnVq8Kci6HOngxFk62RUzIa72EVMjWl+Wk6v4QJG7LBnxUUpSW6SriAMHcDHaNZl0Xu4SgZb
        sT2VByxpLRy731QJC2CGFL5P/4/U8hdHSZEY55jydwUH4RwOJ02BSu0ZQmOrydBYLIr7nsVALka+H
        gzJRyYgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1VyO-00EqYU-IO; Fri, 10 Nov 2023 18:11:16 +0000
Date:   Fri, 10 Nov 2023 18:11:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2 1/7] fs/proc/page: remove unneeded PageTail &&
 PageSlab check
Message-ID: <ZU5yROwNmTZpyxb8@casper.infradead.org>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:18AM +0800, Kefeng Wang wrote:
> After commit dcb351cd095a ("page-flags: define behavior SL*B-related
> flags on compound pages"), the slab could not be a tail, remove unneeded
> PageTail && PageSlab check.

No, that's completely wrong.

 * PF_NO_TAIL:
 *     modifications of the page flag must be done on small or head pages,
 *     checks can be done on tail pages too.

That's backed up by the code:

#define PF_NO_TAIL(page, enforce) ({                                    \
                VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
                PF_POISONED_CHECK(compound_head(page)); })

(enforce is set to 0 for the 'test')

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

NAK
