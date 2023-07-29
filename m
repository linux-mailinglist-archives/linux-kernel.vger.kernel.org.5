Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF62767A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjG2AwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjG2AwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:52:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744D4ED2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0wWBrgJmDz8vNioLPvZ7zs17z+DjGgVgGJutHe403bI=; b=DAgMrl3JkbZs+KCaWX1+F2NZ1z
        PcxOVZsyjLzc1qYhqPCk9PzcK4gtont3vucKMrOtH6RT0JMSqmsqnC5529uXsEY5j73s/bGiWhk7l
        4JOmVvGAw3EgpMVqhe/NhKCiz8Hophzn5kyDHC/nDMBcYknk8BLZJ7o0fU5IKz0OEfyz4ADgab7m3
        KllwofHsQeeLcsuqZGs0COx+s5k5hCOg7mFaNHKJRkqSwRqzaApo07D3R1inMiOhgOXW+RirAYJQO
        2wAMw8DR4ZkLPjTyx6z0V+TBUZiCcqQTR/r0HJ1OQqm0ANIFiLdiVfmR5QlTM1zZTIy6jATwaVP3w
        8wD3hJeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPYA7-009CJy-4G; Sat, 29 Jul 2023 00:50:27 +0000
Date:   Sat, 29 Jul 2023 01:50:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>
Cc:     Steven Price <steven.price@arm.com>, zhengqi.arch@bytedance.com,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Message-ID: <ZMRiUw8TGdbDsj1t@casper.infradead.org>
References: <c7dbaa5e-f5ae-5dc5-4063-b8099a3058e0@arm.com>
 <20230726000827.724389-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726000827.724389-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:08:26AM +0000, Joan Bruguera Micó wrote:
> Hmmm, indeed linux-next crashes with a null pointer dereference when
> calling `ida_free(..., -1)`.
> 
> It appears to me that 69cb69ea5542 ("ida: Remove assertions that an ID was
> allocated") didn't intend to make `ida_free(..., -1)` invalid; after all,
> it was authored & introduced immediately after fc82bbf4dede ("ida: don't
> use BUG_ON() for debugging") whose commit message calls for making it
> legal, with Matthew's support.
> And the referenced Bluetooth HCI code that also calls `ida_free(..., -1)`
> is still there, as far as I can tell ([1]).
> 
> Rather, probably the `((int)id < 0)` was accidentally dropped, or the idea
> was that it would be handled by the `not_found:` label in `ida_free`, but
> for that to work you'd need to change the `!test_bit(bit, bitmap->bitmap)`
> condition to `!bitmap || !test_bit(bit, bitmap->bitmap)` since otherwise
> `bitmap->bitmap` is a null pointer dereference.

I've been in two minds about that patch ever since I wrote it.  I've
dropped it from my tree for now.

But, er, you have pointed out a bug which is that we don't handle
!bitmap properly.  That should be fixed.
