Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED17834DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjHUVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHUVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:24:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C1196
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:24:28 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f4141f776so8075846d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692653067; x=1693257867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhXvrVKWjJEImcnH7m8xq+sQtObtON+yOAMQVEiOYUc=;
        b=lmLT+k2ikCeNIU5piTFU4Jj9zEZibqgqh0rpxcdbNgmBCGDt4BPUEjapCIC5In8NZt
         4QvhDEx25oA8G91WA2t9AJIEE487XPM1FUUKevPIhSlyVKo95x7IaqaVypB4r91ANi0a
         tw/0gPKbv0e0RNhgPheBioJrQ+FNUcll0s+Nyw5miaEQom1KWytt6fRaoqJ0FHoDP3UL
         773IxR9H6TfZKlC2s0FJmljnYIjTRj8g9SMZog/1xCzwwdYheexBoV9G9tzsNaNexwCs
         GAZ1gRsSVzPXBroxRUlwqbFuBHZmS6t+SeQVYLzP26veMayO/zZ0nJA7a2Cg3iH/a8Hj
         mcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653067; x=1693257867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhXvrVKWjJEImcnH7m8xq+sQtObtON+yOAMQVEiOYUc=;
        b=e1em+6yVpBYlImsml1eZgAzihYyjfplUIdoR1mwxruCoHjvKBS2vTRSFKsfZiHkc9n
         +7SeEORu7hiENiPLPBzj1RykKJBqg2ssFwVCm3N9qjmLcZAeFOttgRF9om9KCB/PZ6BF
         53lYNG6/vCZSXHzQvluJFpSuApMmMa1LloZGHpGfk9FIm8Tru9DxNIh/160n+zm9vQXX
         wXl7S44q8fzfxQUWZHbWva7vsv79roa0MAeCL8KxbMKFUOFUIfKeCIWZZbm/WQmhMZ1e
         1ZMMxCaegjRooQhmfcf2yzmYkriThXvu0J/h/WwVeO4x/cXouyoKb/uRQiHkQGcnh7Ff
         +kcQ==
X-Gm-Message-State: AOJu0YwvE30Fs5LdkVgaH6tRBHxpq7UvTMyyeZJ+em9wQ1N0TueHdtdo
        o4ekJSRG3fqvpjTE7xtwRE+IMg==
X-Google-Smtp-Source: AGHT+IGhGpl/fnZbs6G6vdtraEc+HyLFYsuEC9rcQup4HmrqsYeooGRk5W+6ABFHoQ61vBBuxrAHKA==
X-Received: by 2002:a0c:df05:0:b0:64a:f26a:632 with SMTP id g5-20020a0cdf05000000b0064af26a0632mr9506269qvl.30.1692653067222;
        Mon, 21 Aug 2023 14:24:27 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id k17-20020a0cf291000000b0063d47a29e6fsm3222256qvl.55.2023.08.21.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:24:26 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:24:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/page_alloc: use get_pfnblock_migratetype to avoid
 extra page_to_pfn
Message-ID: <20230821212426.GE106501@cmpxchg.org>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
 <20230811115945.3423894-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811115945.3423894-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:45PM +0800, Kemeng Shi wrote:
> We have get_pageblock_migratetype and get_pfnblock_migratetype to get
> migratetype of page. get_pfnblock_migratetype accepts both page and pfn
> from caller while get_pageblock_migratetype only accept page and get pfn
> with page_to_pfn from page.
> In case we already record pfn of page, we can simply call
> get_pfnblock_migratetype to avoid a page_to_pfn.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
