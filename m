Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9737FCAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjK1XPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1XPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:15:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D63198
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:15:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cff3a03dfaso12635685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701213311; x=1701818111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3be5l7zWLVegxTtJOgwtKmg34W7xS/UCXFOLhz7t7M=;
        b=iAms4LqzIla9BaXfSTUFLDP/8x6jgPvjI1gxPfepGjf+rDBXdUSpLTcTgHOAgtwJDl
         iPzIwDmYCq4PCRW3+wGYdNgAQ7mgrnbzuPl5vQ+YUOEw+4t+capbvadkpylSwsdvrknd
         9cv/pHkY850HP4xxctqSlBUd6rk0OKKR2E+expf5vYAzwLK1EKpBmq8bTjAlRWtL4hN/
         aFNEep02ec3o8ml4sfl18yHAHjS0tQym+YqbFwjrbDzFAP5jjxTeYVQEo2C8HVjwASIb
         flmbQrEK5INBMED0X5R+Sg6oq08lPqkYMZl2eNdnxS3NMgAbcLKKNqtSVOFIrmynG992
         RRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701213311; x=1701818111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3be5l7zWLVegxTtJOgwtKmg34W7xS/UCXFOLhz7t7M=;
        b=m2Cep/hKGd679VbiMtc0cKx1rtGuaWnUwZdsVRY8rI0HEN2nbazUlVjC55qxf6VGle
         bhRv8UsXt84wZEdbPeQVlFO0WtjJBHWkmgaGSVwW3R4ZKbfBiDJcE0r2t/JMl1jfgb7c
         NqHggRmlq0tIYqiICmCgsWf19iAjUY4EDkyAChurMEWBx8t1iJ+y0NyI3iikMNpsIYOa
         Kbce+QP+W2YVyN5SEmBUOutjWOKdt/NusMhiHV1lYd+gRnJFfCW8Vt+Z8gFwJFZwHyJo
         s60pqpAB07UyJdv+sDpswZYCoKbm0Vnae3Fi9WlAaOAVqNleqAebhxcE+XyQXDQZNtFs
         bGeg==
X-Gm-Message-State: AOJu0Yw4TusZimX0EeZ5sOA0UYhjsoVYwLYbgtVnPkaUOcw2Rq3VMHem
        6SD3NY/19ZRk8yCOaTN0eU0=
X-Google-Smtp-Source: AGHT+IGvSYtCf/BJGL3DG4UkyjnqeannmtbQikWpytaLSrS/BscVlzjFFaxgko9czgx54VcQ8wPsqw==
X-Received: by 2002:a17:902:c713:b0:1cf:9ebf:8c with SMTP id p19-20020a170902c71300b001cf9ebf008cmr13768957plp.56.1701213311376;
        Tue, 28 Nov 2023 15:15:11 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:8fd0:78d2:c604:3ac8])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001c5fe217fb9sm10808862plg.267.2023.11.28.15.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:15:10 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Nov 2023 15:15:08 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWZ0fJP9wq65rXtM@google.com>
References: <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWRdG49vlGzSY_Uj@tiehlicka>
 <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWW95JPQ1B0cVPY-@tiehlicka>
 <ZWZtdQKSSnLC8kZ6@google.com>
 <CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:05:29PM -0800, Yosry Ahmed wrote:
> On Tue, Nov 28, 2023 at 2:45 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Nov 28, 2023 at 11:16:04AM +0100, Michal Hocko wrote:
> > > On Tue 28-11-23 09:31:06, Huang, Ying wrote:
> > > > Michal Hocko <mhocko@suse.com> writes:
> > > [...]
> > > > > Right. On the other hand we could be more aggressive when dropping the
> > > > > swapcache. Is there any actual reason why we cannot try to folio_free_swap
> > > > > even when mem_cgroup_swap_full == F?
> > > >
> > > > If there are plenty free space in swap device, why not take advantage of
> > > > it?
> > >
> > > Maybe a stupid question but what is the advantage of keeping around in
> > > the swap cache?
> >
> > If the page is shared, we avoids addtional IO to bring them back so
> > swap cache.
> 
> I think this case is actually necessary for correctness, not just to
> avoid additional IO. Otherwise subsequent swapins will create new
> copies of the page, right?

I think if the page was shared by MAP_SHARED, then, yes.
I think if the page was shared by MAP_PRIVATE but CoW(e.g., fork), then, no.
