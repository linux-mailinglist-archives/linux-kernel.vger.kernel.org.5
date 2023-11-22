Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFF7F4E34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjKVRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKVRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:21:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66B11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:21:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so15826445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700673664; x=1701278464; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVowPfOdM8wVDD7Ux+I97nRKLe3FJvmMPxWZObEYXX4=;
        b=MX4BbBxXUOHuFidLBa4CRy6+WzCpXfHATM2a6dzEstDLkOG3x43shZWpoZzAYYk1sO
         QGOTcO057sX722XS8qF90lSH6pweHqCqtYw7H7u3T3UG/IB59YMJui1g/XgzzeilceeH
         wiCqSNuCOh5r/2PrRMrsp/1pcGMKYzECjwBOy9/kLP0ybUTvq9UNZagiojhu8cd2Vq+f
         AHu5DFSAMwT0nWP9aXGx/jhxTe5+GC8LED58ak56EQrsDPK9z0BD6tCqCAM5zNK5jGdi
         oqPFrFusDB5VRvCrLkNNMcDRHvMTZF8zD7ZNoIoRDELEU+nuBJujUArw8UIQV3Fo4aqR
         5pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673664; x=1701278464;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVowPfOdM8wVDD7Ux+I97nRKLe3FJvmMPxWZObEYXX4=;
        b=CdsKdQiNoOpmCLEdwV2ugjz3ZQFb0EQSiKqP0/bpvRQM8Cih3159vza2bhW+TAghtj
         jY/KTaw2PrBD9xc7DsrcQer+XHtrB2/llks0RGRMS4XY/OdAtrcW+6ebe+88eCggIG7b
         tQmpxGcjsVyB4XwzSjD2Wuj0/2JvHehFB0TckkDYExkxmtq48l12GrSqSk3CpodmJSnJ
         Prh+4j0nvqlS8xbBCq5vQgDyrSfVfIOWNLgDMuo+l6m7qMxZ0CHQPNXyzBbdSCvdqDvc
         Hn5KraPUp0vFMUHzDHPvX3SOP4d1Un2o4CDAOLF7xWoSSf59Yh3owBDdN6d0rTRaWSCg
         O+Ug==
X-Gm-Message-State: AOJu0YwXAHXHvTKs+P4TlDj9Nrxqf9yCUivs6g8ZbpNtLrZOclhAMZJD
        Dv4NnYrgjiZe45A2PYKAoO0YfQ==
X-Google-Smtp-Source: AGHT+IHpvtyKjS/XNlh9N3GaVe0iUdniYNK9cEm7ZBSprV/wpsShgJIE5AGFN99iI+PQFty46k4Kmw==
X-Received: by 2002:a05:6000:128e:b0:332:ce86:cc35 with SMTP id f14-20020a056000128e00b00332ce86cc35mr1828909wrx.71.1700673663968;
        Wed, 22 Nov 2023 09:21:03 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:1dcf:36df:c2d9:af51])
        by smtp.gmail.com with ESMTPSA id d19-20020adf9b93000000b003316eb9db40sm15549737wrc.51.2023.11.22.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:21:03 -0800 (PST)
Date:   Wed, 22 Nov 2023 18:20:57 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH RFC 14/20] mempool: introduce mempool_use_prealloc_only
Message-ID: <ZV44eczk0L_ihkwi@elver.google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
 <9752c5fc4763e7533a44a7c9368f056c47b52f34.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9752c5fc4763e7533a44a7c9368f056c47b52f34.1699297309.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:10PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Introduce a new mempool_use_prealloc_only API that tells the mempool to
> only use the elements preallocated during the mempool's creation and to
> not attempt allocating new ones.
> 
> This API is required to test the KASAN poisoning/unpoisoning functinality
> in KASAN tests, but it might be also useful on its own.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/mempool.h |  2 ++
>  mm/mempool.c            | 27 ++++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index 4aae6c06c5f2..822adf1e7567 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -18,6 +18,7 @@ typedef struct mempool_s {
>  	int min_nr;		/* nr of elements at *elements */
>  	int curr_nr;		/* Current nr of elements at *elements */
>  	void **elements;
> +	bool use_prealloc_only;	/* Use only preallocated elements */

This increases the struct size from 56 to 64 bytes (64 bit arch).
mempool_t is embedded in lots of other larger structs, and this may
result in some unwanted bloat.

Is there a way to achieve the same thing without adding a new bool to
the mempool struct?

It seems a little excessive only for the purpose of the tests.
