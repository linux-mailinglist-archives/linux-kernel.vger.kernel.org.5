Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58417A562F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjIRX0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:26:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089797
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:26:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A5C433C8;
        Mon, 18 Sep 2023 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695079578;
        bh=w+5TKw8eUWwc8FHE2rQiN6hONxiw9+38NV0cSqf+vKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcf1GV3g9AXCbaBrCamMwmbJMPgdvctzIvLG4CXdC43p/yVVvJUEkS9nLhTkFTZPm
         a1aNoKayVy+1yroTYwgXBHOBKVbJms04hxop74czjslZWfNOq1z2qncZfp4hBQTbtq
         YQHlZi6bHJxnwo7ls2HE0RB/Y8DaKbTthdP34a8U35/qd/SVqvkAESGXdNvwgzS1G8
         QZ4Fc8bzkHEZzlJzbGbYpDJsd81kCEMy8fXSmaLIr4hON6tjFLlQEIyzOmwje9y3Pc
         x9kwBoMyf5Kf7P1Txe+fYpaL2pjEOSGhwu99O97oBwVR35+sFzXFuEqKA25lX+EPVF
         bOCKkfEJsG+0A==
From:   SeongJae Park <sj@kernel.org>
To:     =?UTF-8?q?=E6=9D=A8=E6=AC=A2?= <link@vivo.com>
Cc:     "SeongJae Park" <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
        "open list:DATA ACCESS MONITOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource . kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Mon, 18 Sep 2023 23:26:15 +0000
Message-Id: <20230918232615.60499-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2feda3fb-7306-4ee7-9be3-a3990b6e9c43@vivo.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huan,

On Mon, 18 Sep 2023 12:12:01 +0000 杨欢 <link@vivo.com> wrote:

> 在 2023/9/18 20:08, 杨欢 写道:
> > 在 2023/9/18 19:11, SeongJae Park 写道:
> >> Hi Huan,
> >>
> >> On Mon, 18 Sep 2023 17:49:34 +0800 Huan Yang <link@vivo.com> wrote:
> >>
> >>> si_meminfo() will read and assign more info not just free/ram pages.
> >> Nice catch :)
> >>
> >>> For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
> >>> is ok to save cpu.
> >>>
> >>> Signed-off-by: Huan Yang <link@vivo.com>
> >>> ---
> >>>    mm/damon/core.c | 10 ++++++----
> >>>    1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >>> index bcd2bd9d6c10..1cddee9ae73b 100644
> >>> --- a/mm/damon/core.c
> >>> +++ b/mm/damon/core.c
> >>> @@ -1278,14 +1278,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
> >>>    	return true;
> >>>    }
> >>>    
> >>> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> >>> +static unsigned long __damons_get_wmark_free_mem_rate(void)
> >> Nit.  s/damons/damos/ would look more consistently, in my opinion?
> > HI, SJ, sorry, what's this mean?
> 
> Haha, I get, yes, damos is better. If you agree with below, I will 
> resend a new, rename to
> 
> __damos_get_wmark_free_mem_rate.
> 
> >>>    {
> >>> -	struct sysinfo i;
> >>> +	return global_zone_page_state(NR_FREE_PAGES) * 1000 / totalram_pages();
> >>> +}
> >>>    
> >>> +static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> >>> +{
> >>>    	switch (metric) {
> >>>    	case DAMOS_WMARK_FREE_MEM_RATE:
> >>> -		si_meminfo(&i);
> >>> -		return i.freeram * 1000 / i.totalram;
> >>> +		return __damons_get_wmark_free_mem_rate();
> >>
> >> Since __damons_get_wmark_free_mem_rate() is just one line function and
> >> damos_wmark_metric_value() is the only user of the code, I think we could just
> >> writ the code here?
> >
> > I do this in mine first patch, but then, I fold this into
> > "__damons_get_wmark_free_mem_rate"
> >
> > due to I think the "__damons_get_wmark_free_mem_rate" may change the
> > meaning for furture,
> >
> > and may si_meminfo will come back soon?(If we need more info to get the
> > rate?). And, also, the
> >
> > static function If just some user use, it will be inline, so, I just
> > think fold it will be better.
> >
> > Do you think so?

Unfortunately I don't think so.  What would be the future use case that would
require changing the meaning of the metric?  I cannot imagine those off the top
of my head.  Even if such use case is found, such change would be a
user-visible behavioral change, which we would like to avoid.  If such change
is really needed, I think we would keep the current metric as is and create an
alternative metric that having the new meaning.  Anyway, we can think about
such case when it really happened.

Also, the current code is doing the calculation in damos_wmark_metric_value().
If there is no specific reason to split the logic out to a new function, I'd
prefer keeping the overall structure as similar as is now.

Please let me know if I'm missing something.


Thanks,
SJ

> >
> > Thanks,
> >
> > Huan
> >
> >>>    	default:
> >>>    		break;
> >>>    	}
> >>> -- 
> >>> 2.34.1
> >> Thanks,
> >> SJ
> >
> 
> 
