Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFF756F22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGQVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:51:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0118B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:51:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4009ea1597bso35616261cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689630666; x=1692222666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxHcLFiWi1qv3gg07rbnC3PGfypMywDH/jm9GrEbEsI=;
        b=PrIrLbl61WfqvxPvTw244aArUIpbIIHoc1pMRUZrd3Lt9iiCKExp7VVWDrSh/kXfgj
         Gy1VxDqv0RZLanw8E8Y+hrwnxkAfaxnjXLsEsutLJrikmIYUtk8bnQZl4U7C0TtZGv90
         RiLU8trzykMk4gram4QXWlumvDRCLAz+NmJfKjsvJuOKxhQHD/GZNRDvdMxPgxwU0Kc/
         R1XmDCtRxmBj9v7vFQsdJpuJXcIzynJ/abbLJR4RH1ZHcAGYxB9ubH/WjK+bE8I19tsd
         zDUb1y/3pj87mwEM/gu+JyRHMh3ze9lRWjg2OfR9IWylOlbqfYPPr/iNUF2M8mX0FyYY
         NpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630666; x=1692222666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxHcLFiWi1qv3gg07rbnC3PGfypMywDH/jm9GrEbEsI=;
        b=JKb+c4kK/DvjiM8pdX1Zr7Mb5jEAghpGnJOBu19u2euiPZSX/RMo5W9vTcTMibZDiI
         FDb63nNT0yy8CfxHXP7d5M5AlbInz/JbD1kYphobzxcDCTm3DTs9oVlJ9iUG+80HqcJU
         TlUlmYH7RF/x6U+fgHkAghXBsYlx/2bK53av87aRxtbP3chvKXzdWzAyr0U7kdkqUwKj
         qKk8ovBoPkDDBI7nlMqCmUBanK+4JoAyleY/HvM9DFc+PEIOiNYdZgVnY4dLtINwpTkv
         FVR6wSsPMtTa3DjeK7sK6Z+tFE0BhtCLFK85HxBMaokt9xImBzhesJIhpCj9s/PEI3Hf
         ISog==
X-Gm-Message-State: ABy/qLa+RTQtohInec0spxLlcRRLmyN5qauc3G8dCYMOc+pT5DmnBglx
        APRJrIMQzfRKEIuHbaGboItmMg==
X-Google-Smtp-Source: APBJJlFeJ3yCCpSjrofyFbOP99jmm7G6o/8YQsmYu9r7Ws+184BUiWZGhETF7W3gxnN6P+jaz7333g==
X-Received: by 2002:a05:622a:1814:b0:403:b0f3:8a9 with SMTP id t20-20020a05622a181400b00403b0f308a9mr18684119qtc.61.1689630666751;
        Mon, 17 Jul 2023 14:51:06 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id br22-20020a05622a1e1600b0040399fb5ef3sm186057qtb.0.2023.07.17.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:51:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 17:51:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <20230717215105.GA909920@cmpxchg.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org>
 <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org>
 <ZLVnUhXeZ6ptNF2l@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVnUhXeZ6ptNF2l@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:07:46PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 17, 2023 at 12:02:27PM -0400, Johannes Weiner wrote:
> > -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
> > +	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
> >  		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
> >  		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
> >  		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
> >  		(p->flags & SWP_DISCARDABLE) ? "D" : "",
> >  		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
> > -		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> > -		(frontswap_map) ? "FS" : "");
> > +		(p->flags & SWP_PAGE_DISCARD) ? "c" : "");
> 
> Is it useful information (to the sysadmin) that zswap is enabled?  If so,
> we might want to print a "Z" instead of a "FS" here (would need to
> know whether enabling zswap succeeded ...)

I don't think it is needed in this particular place.

zswap prints to dmesg when it is initialized. And it's easy to runtime
check in sysfs or in /proc/meminfo if it's enabled - that's where I
would look first if I checked a system that's showing zswap issues -
not in the dmesg that may have long wrapped since swapon.

There is also a warning to dmesg if zswap fails to enable for a given
swapfile. But with the current page allocator implementation this
can't actually fail.
