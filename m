Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6074875666B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjGQOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjGQOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:31:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E921995
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:31:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE74A1F74C;
        Mon, 17 Jul 2023 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689604302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imDGqPTJIK6gJD4cw9W8VVyoXH0zQoowq8bBZZ0GObI=;
        b=nbYVYEi8UzXvu9DXftf0FyJUgklpQzg9ua2lfFEoqtEi33fa3VNT8MMo/2aq009DR2A4Ge
        COCxzzPg1EBq0Yfw2HbTgpAsJ5G98/JUibgy7K+lI+VZuLoGRXMKvwHfWDXwZRiR69OlqG
        3lLaLd/+/MdoiAiyB36m1Qd/oxQaxME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689604302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imDGqPTJIK6gJD4cw9W8VVyoXH0zQoowq8bBZZ0GObI=;
        b=OmdRuOwt//vPDWbn+Ffomwm7YookiCfjuAMOH3t2oE5VTYdO1UGPZU0DxY51ZI3P/HnMss
        08aAe71uNPHAoODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 713A8138F8;
        Mon, 17 Jul 2023 14:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0Q8YGs5QtWRxcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Jul 2023 14:31:42 +0000
Message-ID: <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
Date:   Mon, 17 Jul 2023 16:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: kill frontswap
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org> <20230717141250.GA866068@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230717141250.GA866068@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 16:12, Johannes Weiner wrote:
> On Sat, Jul 15, 2023 at 04:42:13AM +0100, Matthew Wilcox wrote:
>> On Fri, Jul 14, 2023 at 03:46:08PM -0400, Johannes Weiner wrote:
>> > diff --git a/mm/zswap.c b/mm/zswap.c
>> > index 62195f72bf56..1b0128060792 100644
>> > --- a/mm/zswap.c
>> > +++ b/mm/zswap.c
>> > @@ -2,7 +2,7 @@
>> >  /*
>> >   * zswap.c - zswap driver file
>> >   *
>> > - * zswap is a backend for frontswap that takes pages that are in the process
>> > + * zswap is a cache that takes pages that are in the process
>> >   * of being swapped out and attempts to compress and store them in a
>> >   * RAM-based memory pool.  This can result in a significant I/O reduction on
>> >   * the swap device and, in the case where decompressing from RAM is faster
>> > @@ -20,7 +20,6 @@
>> >  #include <linux/spinlock.h>
>> >  #include <linux/types.h>
>> >  #include <linux/atomic.h>
>> > -#include <linux/frontswap.h>
>> >  #include <linux/rbtree.h>
>> >  #include <linux/swap.h>
>> >  #include <linux/crypto.h>
>> 
>> To make this patch compile, I had to add zswap.h to the include list.
> 
> I can fix that up, but I'm curious what kind of failure you saw. It
> built fine for me, not even a warning.

I get warnings but only with W=1 (worth fixing up though).

  CC      mm/zswap.o
mm/zswap.c:1203:6: warning: no previous prototype for ‘zswap_store’ [-Wmissing-prototypes]
 1203 | bool zswap_store(struct page *page)
      |      ^~~~~~~~~~~
mm/zswap.c:1382:6: warning: no previous prototype for ‘zswap_load’ [-Wmissing-prototypes]
 1382 | bool zswap_load(struct page *page)
      |      ^~~~~~~~~~
mm/zswap.c:1470:6: warning: no previous prototype for ‘zswap_invalidate’ [-Wmissing-prototypes]
 1470 | void zswap_invalidate(int type, pgoff_t offset)
      |      ^~~~~~~~~~~~~~~~
mm/zswap.c:1487:6: warning: no previous prototype for ‘zswap_swapon’ [-Wmissing-prototypes]
 1487 | void zswap_swapon(int type)
      |      ^~~~~~~~~~~~
mm/zswap.c:1502:6: warning: no previous prototype for ‘zswap_swapoff’ [-Wmissing-prototypes]
 1502 | void zswap_swapoff(int type)
      |      ^~~~~~~~~~~~~

 

