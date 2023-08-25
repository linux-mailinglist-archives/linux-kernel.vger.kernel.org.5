Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883557887C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbjHYMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbjHYMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:49:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51AD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qrjV5LfbhE2I0hjArcTr3nf3ghXpZRO6ca+q7nCkmwE=; b=rGoKp+E+1vIvHTH06YcdIjXD7G
        D9aHo/wY6h4lA6ZOiQvEVqOLXTNR0pKSBC92wS6dg9SXxq1csBZfQ9YXr9sgdwKSqWovZPp5j8+3v
        XoPFWs/DofgF9c8I6se5aJ0IT8W88ttJjAFUik3k2WhF5K/P4uvczw3cfHL1JzGovpSdCa1hRowc5
        hGkGzZVTttb9rJk78+KL7i+ptfcLNwGagxtX1YED6MiyvQVQDRWtevUkyOX3oiElJQuo3JuhETN2V
        oTn9/HW30O3WS7OUCmLjfZEZAN/LDNBzSC39c81eNTWndVIjHr3mzN2JAqsH7sYr7ROoGyCkFv52u
        Vq4e6MaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZWFX-00HAwg-S4; Fri, 25 Aug 2023 12:49:15 +0000
Date:   Fri, 25 Aug 2023 13:49:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <ZOijSwCa9NFD6DZI@casper.infradead.org>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
 <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wrote:
> Especially, we do have bigger ->huge_fault changes coming up:
> 
> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infradead.org
> 
> If the driver is not in the tree, people don't care.
> 
> You really should try upstreaming that driver.
> 
> 
> So this patch here adds complexity (which I don't like) in order to keep an
> OOT driver working -- possibly for a short time. I'm tempted to say "please
> fix your driver to not use huge faults in that scenario, it is no longer
> supported".
> 
> But I'm just about to vanish for 1.5 week into vacation :)
> 
> @Willy, what are your thoughts?

Fundamentally there was a bad assumption with the original patch --
it assumed that the only reason to support ->huge_fault was for DAX,
and that's not true.  It's just that the only drivers in-tree which
support ->huge_fault do so in order to support DAX.

Keeping a driver out of tree is always a risky and costly proposition.
It will continue to be broken by core kernel changes, particularly
if/when it does unusual things.

I think the complexity is entirely on us.  I think there's a simpler way
to handle the problem, but I'd start by turning all of this "admin and
app get to control when THP are used" nonsense into no-ops.
