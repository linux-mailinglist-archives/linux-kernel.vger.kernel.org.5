Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E767EA9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjKNEp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:45:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B003124
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:45:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc34c3420bso39825985ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937149; x=1700541949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBMZCd1RTYcku4fr+eS/5T5vGEq4PYQLNXmfcgCc7wA=;
        b=OSi1MVa9q3OgTaatfrhWgq/PWqv3k2u+7sJbNRozGNotiSRIjT8JjyIkpLzed6imT+
         MmokGqjCFRSRT+DHxPHepyFG4zYFCeBh6XldHC0E8p4oaKQLv6fr86rkI+L3hhEy+4XP
         aE6a31r/1X/0AZO79uagGZoBOFCGa4v/JKFY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937149; x=1700541949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBMZCd1RTYcku4fr+eS/5T5vGEq4PYQLNXmfcgCc7wA=;
        b=kjz0tzCbw5ksjbdDyFv+cOi3dRy1E3P/hJvDnsuirMYdfy6IQTFoxIj8Vy3p1FwS+W
         q0bNiVgedLvKlkIAXHGk+71pQe3miwGX95/jkqzfVZRGKjm+4xBbhfD76Fg9bgCWnjF7
         XrpGweSiw5Ny12DpUaSua01xBDubEz2D3zpVPaECg7apZ2zYOBoOwBKwOHUK/x6D/X3y
         VBydPNy6ZBiRBOVtSA+dnKNoE4EGAKuEDUwREup0CBgB/0pRNgnYjhnYU7nwG7Jqm9lg
         +L2zpOZyKhrxaofVqzeO0IGocEeF8HLCCnUOOODa8T8FNi91aTJfYkKCHFeIocJGPFs/
         V4EQ==
X-Gm-Message-State: AOJu0YwM3MCeg8YzWowGVXM/p2x8ca4u1LjzAaGTHy4v+BfReMv3sN70
        9XOaqiyxK0Q0MIwp0T40wcQcTw==
X-Google-Smtp-Source: AGHT+IEsjAp3cBiJSP3PyvVvmPuSm+aeTJB4FD5LC9ruHOoqYzxrBqIrhGMYXmyQPi4w72yy/WPkjg==
X-Received: by 2002:a17:902:8542:b0:1c3:1f0c:fb82 with SMTP id d2-20020a170902854200b001c31f0cfb82mr968412plo.41.1699937148885;
        Mon, 13 Nov 2023 20:45:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001c55e13bf2asm4804097plr.283.2023.11.13.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:45:48 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:45:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 15/20] mm/slab: move kfree() from slab_common.c to slub.c
Message-ID: <202311132045.D84400ED@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-37-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-37-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:56PM +0100, Vlastimil Babka wrote:
> This should result in better code. Currently kfree() makes a function
> call between compilation units to __kmem_cache_free() which does its own
> virt_to_slab(), throwing away the struct slab pointer we already had in
> kfree(). Now it can be reused. Additionally kfree() can now inline the
> whole SLUB freeing fastpath.
> 
> Also move over free_large_kmalloc() as the only callsites are now in
> slub.c, and make it static.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
