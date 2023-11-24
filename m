Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB37F8421
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjKXTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbjKXTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:24:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE52705
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:24:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce5b72e743so357325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700853853; x=1701458653; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iV+h/GERYU+xzqS4h/e6iaA5vcvPRqW2veORCSlxiZU=;
        b=Ios1IsoV9FOWTR+0Xwb9sxp/qc/5SzYMBoq+yB6BtAqVJfNVUyUDhEAgmuwTOCV4IQ
         sugpGF1ijM+ZDryK9bFmCMAZ0HuHjOGQ0h7tAi0gVotaFUlm3ZAkCs+jc6KubyqR3wah
         e97snplHiH93CEn/JEgowMoDMI5wMx7iKXyZs+RFthES/mlaIlm9mW/m2fGKnmCv7odY
         r8vDMbc3m3hSCALfY1TN4pl8wgV+4HI49Pvo2Cshk8TENAeShv61DfJ8UG2nq08AubWp
         /q5Qv8sXtqFOEGXBPW0EJ2s8KoDJItHA4KG12+DQT683lD261pybWkIz8saNF3V/PMng
         GRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853853; x=1701458653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iV+h/GERYU+xzqS4h/e6iaA5vcvPRqW2veORCSlxiZU=;
        b=FzNaSJFjnLQSVNhJmu2G/dde16JpE0pG1ghCU8wE8ve2ciZzcL/F+2PY0WPWNC6NBT
         r/PE/lu5oBed4IhSJ91sA5GwDLLG56wJtdptNAvItSmlx1/gyTQ1PPP8Abm37Cv4SfDL
         mJ8P/pxpAm4ipA6gw368z6olVvh/L+QflBIUuc/6+jjY9h+4fS3qupwwTWVGU3a7MiDn
         EIWrMTiG+yhMqnYT+X1ZsTqfZp9AJ9DVdjBGryeYMcRijBRElsAy1S87HEdeSE1fmjsW
         G3zEMfjmoiGDsZToREUZguDr3uvsm9V6ApsK+6b+Hrj6qdXsJz+Z2777u4FJ15OqaikU
         3nrQ==
X-Gm-Message-State: AOJu0YwUjFQ9epS/0GeJbIc+4+k/ZNX4V+oza7NclZ0gmcTnv/lfk7AM
        3EtONK8qo7gcD41nIzQr0HLBdQ==
X-Google-Smtp-Source: AGHT+IHxtQwLayMbsHkGP+YBDxOvy4bqVyotdY+j3i01Owt+P8HBq9fJw5ny7BGGqYyv53MAxv0dJQ==
X-Received: by 2002:a17:903:60b:b0:1cf:6d8c:c903 with SMTP id kg11-20020a170903060b00b001cf6d8cc903mr689618plb.15.1700853853092;
        Fri, 24 Nov 2023 11:24:13 -0800 (PST)
Received: from [2620:0:1008:15:d807:a0b3:20ea:f28f] ([2620:0:1008:15:d807:a0b3:20ea:f28f])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001cf53c235c6sm3597218plb.34.2023.11.24.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 11:24:12 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:24:11 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, david@redhat.com, vbabka@suse.cz,
        hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] mm: page_alloc: correct high atomic reserve
 calculations
In-Reply-To: <1660034138397b82a0a8b6ae51cbe96bd583d89e.1700821416.git.quic_charante@quicinc.com>
Message-ID: <ed9a9e39-2828-50cd-9030-4d5b3503e800@google.com>
References: <cover.1700821416.git.quic_charante@quicinc.com> <1660034138397b82a0a8b6ae51cbe96bd583d89e.1700821416.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 24 Nov 2023, Charan Teja Kalla wrote:

> reserve_highatomic_pageblock() aims to reserve the 1% of the managed
> pages of a zone, which is used for the high order atomic allocations.
> 
> It uses the below calculation to reserve:
> static void reserve_highatomic_pageblock(struct page *page, ....) {
> 
>    .......
>    max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> 
>    if (zone->nr_reserved_highatomic >= max_managed)
>        goto out;
> 
>    zone->nr_reserved_highatomic += pageblock_nr_pages;
>    set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>    move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> 
> out:
>    ....
> }
> 
> Since we are always appending the 1% of zone managed pages count to
> pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
> nr_reserved_highatomic is incremented/decremented in pageblock sizes.
> 
> Encountered a system(actually a VM running on the Linux kernel) with the
> below zone configuration:
> Normal free:7728kB boost:0kB min:804kB low:1004kB high:1204kB
> reserved_highatomic:8192KB managed:49224kB
> 
> The existing calculations making it to reserve the 8MB(with pageblock
> size of 4MB) i.e. 16% of the zone managed memory.  Reserving such high
> amount of memory can easily exert memory pressure in the system thus may
> lead into unnecessary reclaims till unreserving of high atomic reserves.
> 
> Since high atomic reserves are managed in pageblock size granules, as
> MIGRATE_HIGHATOMIC is set for such pageblock, fix the calculations for
> high atomic reserves as,  minimum is pageblock size , maximum is
> approximately 1% of the zone managed pages.
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: David Rientjes <rientjes@google.com>
