Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808977EA3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKMTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:22:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2456F1BB;
        Mon, 13 Nov 2023 11:22:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E9D31F6E6;
        Mon, 13 Nov 2023 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699903320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adgK/oEUvJ96k3bu6IhQ1zQnzB57QPKsQCEOFsuv7V4=;
        b=28lSfBuhMsCaei3CG97i4BeDaKPjM5+djVViqAxRphX+6iZNpiLG/3lZ0N7QQfBGb6XY+W
        9+GxpxnKgWxTjMVbHW+ia7J7LCyTr2kMmyPqSZsp4RbNSE05/cp3kha9IaxIsXXmy8NrjQ
        dZRwzyxpTHTgXA0+KwvsOj5t/VkB0vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699903320;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adgK/oEUvJ96k3bu6IhQ1zQnzB57QPKsQCEOFsuv7V4=;
        b=DfEEX/Jgi+PngvPrI95d0ExO/2sXJnZ78orFxBSjcCzB3Fu77WkfCPlMz3A4M6tNRiEMJy
        GO7XAoDcZxTm5eDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F7881358C;
        Mon, 13 Nov 2023 19:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQShDlh3UmWTPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:22:00 +0000
Message-ID: <7379e9e0-1143-6310-0b48-8e8228701011@suse.cz>
Date:   Mon, 13 Nov 2023 20:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Hemment <markhemm@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-30-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-30-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/23 20:13, Vlastimil Babka wrote:
> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
> properly).
> 
> RIP SLAB allocator (1996 - 2024)
> 
> Cc: Mark Hemment <markhe@nextd.demon.co.uk>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  CREDITS                  |   12 +-
>  include/linux/slab_def.h |  124 --
>  mm/slab.c                | 4026 --------------------------------------
>  3 files changed, 8 insertions(+), 4154 deletions(-)
>  delete mode 100644 include/linux/slab_def.h
>  delete mode 100644 mm/slab.c
> 
> diff --git a/CREDITS b/CREDITS
> index f33a33fd2371..17597621202b 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -9,10 +9,6 @@
>  			Linus
>  ----------
>  
> -N: Matt Mackal
> -E: mpm@selenic.com
> -D: SLOB slab allocator
> -
>  N: Matti Aarnio
>  E: mea@nic.funet.fi
>  D: Alpha systems hacking, IPv6 and other network related stuff
> @@ -1572,6 +1568,10 @@ S: Ampferstr. 50 / 4
>  S: 6020 Innsbruck
>  S: Austria
>  
> +N: Mark Hemment
> +E: markhe@nextd.demon.co.uk
> +D: SLAB allocator implementation

Hm this address bounced, but I found markhemm@googlemail.com (now CC'd) on
lore from 2022, can I use it, Mark? Thanks!
Link to whole series:

https://lore.kernel.org/all/20231113191340.17482-22-vbabka@suse.cz/T/#t

> +
>  N: Richard Henderson
>  E: rth@twiddle.net
>  E: rth@cygnus.com
> @@ -2437,6 +2437,10 @@ D: work on suspend-to-ram/disk, killing duplicates from ioctl32,
>  D: Altera SoCFPGA and Nokia N900 support.
>  S: Czech Republic
>  
> +N: Matt Mackal
> +E: mpm@selenic.com
> +D: SLOB slab allocator
> +
>  N: Paul Mackerras
>  E: paulus@samba.org

