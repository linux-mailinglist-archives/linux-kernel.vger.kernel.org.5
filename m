Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB97A7010
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjITBrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:47:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33558B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B6fVdNZavzGdJHgGmbvTSHR7vKQueME4Vv6cC0tZ1qI=; b=kMnSvMEjsSMH6Z7QfusCGBOms+
        Gdbdv6aeEs/qiWyqoDDHobGO6H5wZsHycQ3ZMUTfiq5KPl4odKm7tUi0l/ozj3GSocfzV7GtJ8aGa
        HkoxCz6Q+EWm0uNzvo2yZXpO9W95DVyl8sg0USmq8Urzkj/d/33z9JmFVp2enSaOCUaB/XoGpQh6z
        bbY4SSE8HxsFjVuDXbDagT9knRYvqlrkK9AJnlHUaSBIn1ULhJxPilluhbIssbeA/Lu7egeE22MGW
        z/Z+rS05DVbsY+cZxWiDf+SyX8xL7d7SxOfnHvYSN1HG41r7PYlN5e3/pFOsLDmCjf6fOlFueZU7y
        FCu5Tx9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qimJC-0030pn-Sb; Wed, 20 Sep 2023 01:47:18 +0000
Date:   Wed, 20 Sep 2023 02:47:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZQpPJtWh/rdrbUPm@casper.infradead.org>
References: <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
 <ZP/wLVg1JCvhaEKm@casper.infradead.org>
 <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
 <381e4ccd-47ee-955b-f7af-fe192bea0cd4@intel.com>
 <f40677ee-8b8e-b719-24ed-662c219c6989@intel.com>
 <2897a87d-ce56-fa40-8195-6e9c1a9de6a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2897a87d-ce56-fa40-8195-6e9c1a9de6a4@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:29:18AM +0800, Yin Fengwei wrote:
> 
> 
> On 9/20/23 00:11, Dave Hansen wrote:
> > On 9/18/23 18:11, Yin Fengwei wrote:
> >>> I will find a test machine to measure the performance difference of these two
> >>> versions by using xfs + will-it-scale. Will keep you guys updated.
> >> I'd like to move this bug fixing forward. Based on the test result here:
> >> https://lore.kernel.org/linux-mm/124631ab-eb4c-6584-12d4-f3c91e69c873@intel.com/
> >> There is very small performance delta between your version and Dave's.
> >>
> >> What do you think if we propose to merge Dave's version? Or do I need collect
> >> more data? Thanks.
> > 
> > I honestly don't feel that strongly about my version versus Matthew's.
> > I like mine, but I'll happily ack either approach.
> > 
> > The thing I care about the most is getting the bug fixed ... quickly. :)
> Same in my side.

I'm just redoing the commit message now.
