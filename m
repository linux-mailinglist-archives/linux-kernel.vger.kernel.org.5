Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4697F84DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjKXTok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:44:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C14893
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:44:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce5b72e743so358865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700855085; x=1701459885; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJe1cTUwmVFg6ikVC/lcaSHTAPPpULPQy7PDbLjWEk=;
        b=LwIfEkis/Li33WnC6NEA7W5d4sksY/lKCp4N3LSRlpgN1OLDzL5+Gm1BikOqS2cj/9
         FwGtOJCY4KH9y3puDOLy1SJ8yrc85NTSGKVLnG/8v3qaycb5gNCJs9BbtUOnf4LZAoGf
         kwlR879RnjzS7LtLCwukSwqyQ9Gogj/Wq64mtN9HImJlmAa0hqnOlUTxZSRW8cx9XT3u
         CQRaCInAjNeFPlBbknhRP2cxeaK0KQCxW+tQI4GpPbNU40DtV4QEw2JHJ6XFyztXa726
         CDu2nHO38VfOam7AaRuAa8wE1F36zcIxe7fXkGDaRsGCkpNvPW9iJCtA8dAbf2aLh7Kw
         MJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700855085; x=1701459885;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJe1cTUwmVFg6ikVC/lcaSHTAPPpULPQy7PDbLjWEk=;
        b=N4GVaTq9T/49lvl4bXxM6z3nWN7LazQp5iZitfrzUtffdL/UmACrI2s0qfpwyOCFNy
         hxIRsRLAIL6pHmqkhUbo3+gpWpMVysyS72AVMimAjQvh3sviPE3OWW1/cyf4ajtE8/Js
         ZLWv4JlZSOKwlnnMZu5/fUqOv/mtQ5CTLV32+aF6ox6OHiS7d5LmmXcyf3uiMJ1oXNrL
         2MBkXKzv2xGqFGYn1rvoG/kUrTWg6sYViFPLyYiNwllqbAm1YdZezEUl+JqDJl5Vau6N
         DqCgYxurKZS5WdOgKK6UcYID+uVO4yBxB3m4Ds2sV6uEfD6wd+f8vGM/31FYcdiHNloV
         v50w==
X-Gm-Message-State: AOJu0Ywpqkby5n6DbsG97+IHRAnbsPFi9+RrV6o2vSYcB+shGN9U5Qpu
        UV1WBY8YCBQIZRUpvsL8HBSktg==
X-Google-Smtp-Source: AGHT+IH0k42WBbKtozlNqbG7QJC35OPgY972kv9kDmDxplkj0CdVXeD1A4NZmU0Q7tEfZ0OWOTcqHQ==
X-Received: by 2002:a17:903:4d1:b0:1cf:a032:aeff with SMTP id jm17-20020a17090304d100b001cfa032aeffmr198568plb.11.1700855084806;
        Fri, 24 Nov 2023 11:44:44 -0800 (PST)
Received: from [2620:0:1008:15:d807:a0b3:20ea:f28f] ([2620:0:1008:15:d807:a0b3:20ea:f28f])
        by smtp.gmail.com with ESMTPSA id hq19-20020a056a00681300b006cbb80e4577sm3190013pfb.210.2023.11.24.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 11:44:44 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:44:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
In-Reply-To: <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
Message-ID: <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
References: <20231123133036.68540-1-gang.li@linux.dev> <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, David Hildenbrand wrote:

> On 23.11.23 14:30, Gang Li wrote:
> > From: Gang Li <ligang.bdlg@bytedance.com>
> > 
> > Inspired by these patches [1][2], this series aims to speed up the
> > initialization of hugetlb during the boot process through
> > parallelization.
> > 
> > It is particularly effective in large systems. On a machine equipped
> > with 1TB of memory and two NUMA nodes, the time for hugetlb
> > initialization was reduced from 2 seconds to 1 second.
> 
> Sorry to say, but why is that a scenario worth adding complexity for /
> optimizing for? You don't cover that, so there is a clear lack in the
> motivation.
> 
> 2 vs. 1 second on a 1 TiB system is usually really just noise.
> 

The cost will continue to grow over time, so I presume that Gang is trying 
to get out in front of the issue even though it may not be a large savings 
today.

Running single boot tests, with the latest upstream kernel, allocating 
1,440 1GB hugetlb pages on a 1.5TB AMD host appears to take 1.47s.

But allocating 11,776 1GB hugetlb pages on a 12TB Intel host takes 65.2s 
today with the current implementation.

So it's likely something worth optimizing.

Gang, I'm curious about this in the cover letter:

"""
This series currently focuses on optimizing 2MB hugetlb. Since
gigantic pages are few in number, their optimization effects
are not as pronounced. We may explore optimizations for
gigantic pages in the future.
"""

For >1TB hosts, why the emphasis on 2MB hugetlb? :)  I would have expected 
1GB pages.  Are you really allocating ~500k 2MB hugetlb pages?

So if the patchset optimizes for the more likely scenario on these large 
hosts, which would be 1GB pages, that would be great.
