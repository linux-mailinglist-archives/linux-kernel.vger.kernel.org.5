Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24627CA736
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjJPL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPL4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6445129
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697457324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LMLuJaoV57Wcr8aZZNrwu7qwYblvpG+Vtuy3ujdjNsA=;
        b=RLdt0Cd5MjWgKPPU5ZtRX2sxMmIrB8RYUmSndAjv114/InkxdTPMWUpWx6FQGZChFBrgle
        CC/pGEFDa5kYqv3B3xT8P6Cmq29kh7XL+/hbxL1EWvkhJqRE4QHbwMKINO17jluGx4XYcd
        u6SFaZ5wZYcgjL9OkZeGComlZjyd73g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-9UCyG2oSNf2_0_zcLJ07KQ-1; Mon, 16 Oct 2023 07:55:22 -0400
X-MC-Unique: 9UCyG2oSNf2_0_zcLJ07KQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41b1f81f3f1so51042641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457322; x=1698062122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMLuJaoV57Wcr8aZZNrwu7qwYblvpG+Vtuy3ujdjNsA=;
        b=mqLUV+DqcS27Y491wQXi5xWTJYWdxfh1rLzOcwnDstvkyc3rqh7nDSF6g0RR1syBxj
         /72PRgLVdHYKswMZbIWj/K5578a5CuPFhN1rSBeWSYOpinG3r3FRnDwNAPLWktbhN7Yh
         xOQJxjaHMphyHc/sBQoc1gwMzkr/DCyU+Bj21my4t2lR9wLE1qcLGyp+hUcm3/SctIVJ
         FcjW55uOoovrT52/chBuJ+QE1zRBahsSdZK2GpqUltDVPVaoGnqdhUN5R3W2Qm69l/A+
         HkaT00/JVo3nTOFHR03B1FI3ef4SmshleUmKBOlxIZumA2sg3NQ5DM/KkUq2YOJ11Xjy
         ajpQ==
X-Gm-Message-State: AOJu0YwkHG3og0UHkJPnB7BWxGjQnyP2lP1E1wWY1P26hC+pBvW8Rkgj
        u+BjmTMowmp+TPqr1c50tJDEXq5ZHOPGPg8WqRFGcKlPw+j6ZQL3O+AkX9hCFOGJ6G5aqYJ1n10
        UhAW7Svj/cU/i4ZIQSuUUbeO+
X-Received: by 2002:ac8:5fc1:0:b0:418:162e:6a5d with SMTP id k1-20020ac85fc1000000b00418162e6a5dmr40355019qta.67.1697457321730;
        Mon, 16 Oct 2023 04:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7bKAHQAoDbs/ePFybLjdjR4Sjj0jshB3lRwoxAg6H5eTLRu5GFAyFYQWGQ2J3u86nt8HUmQ==
X-Received: by 2002:ac8:5fc1:0:b0:418:162e:6a5d with SMTP id k1-20020ac85fc1000000b00418162e6a5dmr40355007qta.67.1697457321437;
        Mon, 16 Oct 2023 04:55:21 -0700 (PDT)
Received: from optiplex-fbsd (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id w42-20020a05622a192a00b004181a8a3e2dsm2979923qtc.41.2023.10.16.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:55:21 -0700 (PDT)
Date:   Mon, 16 Oct 2023 07:55:18 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Audra Mitchell <audra@redhat.com>
Cc:     linux-mm@kvack.org, raquini@redhat.com, akpm@linux-foundation.org,
        djakov@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix page_owner's use of free timestamps
Message-ID: <ZS0kpkHkmaAQStV7@optiplex-fbsd>
References: <20231013190350.579407-1-audra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013190350.579407-1-audra@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:03:44PM -0400, Audra Mitchell wrote:
> While page ower output is used to investigate memory utilization, typically
> the allocation pathway, the introduction of timestamps to the page owner 
> records caused each record to become unique due to the granularity of the
> nanosecond timestamp (for example):
> 
>   Page allocated via order 0 ... ts 5206196026 ns, free_ts 5187156703 ns
>   Page allocated via order 0 ... ts 5206198540 ns, free_ts 5187162702 ns
> 
> Furthermore, the page_owner output only dumps the currently allocated 
> records, so having the free timestamps is nonsensical for the typical use 
> case.
> 
> In addition, the introduction of timestamps was not properly handled in
> the page_owner_sort tool causing most use cases to be broken. This series
> is meant to remove the free timestamps from the page_owner output and
> fix the page_owner_sort tool so proper collation can occur.
> 
> Audra Mitchell (5):
>   mm/page_owner: Remove free_ts from page_owner output
>   tools/mm: Remove references to free_ts from page_owner_sort
>   tools/mm: Filter out timestamps for correct collation
>   tools/mm: Fix the default case for page_owner_sort
>   tools/mm: Update the usage output to be more organized
> 
>  mm/page_owner.c            |   4 +-
>  tools/mm/page_owner_sort.c | 212 +++++++++++++++++--------------------
>  2 files changed, 100 insertions(+), 116 deletions(-)
> 
> -- 
> 2.41.0
> 

Thank you, Audra.

Acked-by: Rafael Aquini <aquini@redhat.com>

