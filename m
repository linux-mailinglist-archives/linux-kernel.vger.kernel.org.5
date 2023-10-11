Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4187C5A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjJKRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:16:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974409D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:16:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BA2C433C7;
        Wed, 11 Oct 2023 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697044601;
        bh=TEhjbZnKeCuYcpy8YH4MZnjE3TXkJzgENB/x7EN+cuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1J9d6+7zMUgTcVgfTY5jOcVYBvPnpzXdjNrzds9YjcySqZ7KT97+bH1Z6EcIdbmls
         DgwNkBrZFJMkupYWIiQr5j8JkMR4hP/gCvVZaPjYj79TWFeSas2SDZ0pChVFp8sWkW
         POoR0ykaPJ4dZmeUAfuvbnpC/+HPLG4piV8DatsA=
Date:   Wed, 11 Oct 2023 10:16:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
Message-Id: <20231011101617.2f814633defaa13e77308d9b@linux-foundation.org>
In-Reply-To: <20231011124610.4punxroovolyvmgr@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-2-ying.huang@intel.com>
        <20231011124610.4punxroovolyvmgr@techsingularity.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 13:46:10 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -676,12 +676,15 @@ enum zone_watermarks {
> >  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
> >  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
> >  
> > +#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
> > +
> 
> The meaning of the flag and its intent should have been documented.

I need to rebase mm-stable for other reasons.  So let's please
decide (soon) whether Mel's review comments can be addressed
via add-on patches or whether I should drop this version of this
series altogether, during that rebase.
