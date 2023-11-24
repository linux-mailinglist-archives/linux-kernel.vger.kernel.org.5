Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B817F8501
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjKXUAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKXT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:59:59 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3010F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:00:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc79f73e58so357725ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700856006; x=1701460806; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oLbycN29uJfWyZm+/IDaK7m6t28x0cL7RXdnq9lRqo=;
        b=MawKUcPxIPZ44iXvVkgO9/IB6rAtIXUApdhSvAisDXF3NO5datlgMRDkZluI73K7LX
         WlDgickfCrWCHobp4gha9xYpT3LQlbftz5jVE+6HmsYBfQl39a0uYD6newFFc4ogHeRX
         1J4teiI9Nj/wTNwMQD3XBdcXuANeG5osxU4M5gHrcOdOlKT7tCkBA29EhlBFyOhbw8kK
         1PM7LNm2g+AgZIkd/9nNazQgQzO41co3BNpJlJl0J8BghYw5GEFr2f1HkqzK9d54eNhh
         ZAyS/O4YawnKvKnfvYhZZvCcop+37wKq685mQXH37jjqbrAaRw3fOaUmU1LVJ0NaZiiw
         qyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700856006; x=1701460806;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oLbycN29uJfWyZm+/IDaK7m6t28x0cL7RXdnq9lRqo=;
        b=YzUlkTJNQXXrbDjtCLbfYutkXBgx0Jh6y8zKYoqKo1DDXdIiCVPgjXWZs8ZRvBj6Hh
         dOEi3pL+alheQuGhNMFJ4UYzZEMDhB9pPtJmZ+FTBHIK7GnMSMjrOI7PPv4VD7aHqfex
         81QnnDo0XK+GUaTQsJ7FFaNsr45yvASWPX+FUeYQO9VfqyCaX9wRdTOTww9F6cuoJBUH
         F7+um8a6Lt8TNbxMjNpmV2ac3qjTyyvVVA2a/AbLs+FY5evM9ZFmBi/MhEJ/WRiLNZCZ
         7xyJImeR4XQDXF0vVpz/pCxxQ7bN7/XDTQD6VOcUdYGl2tfVJ/TPVJsk56VUGHcRXnEo
         rU4w==
X-Gm-Message-State: AOJu0YzvNYn7RUyfm44MI2XaRvvNQ2kH4yi+OOlo6A6k0jVEzID4EIxw
        ScMfRMqtAKbMGtDRGeLWp65QeQ==
X-Google-Smtp-Source: AGHT+IEF4KSXIKeS3jBpise+BcAfhqDaZwd8VXvQl29NoGokCEsou4jNbrtkqZ8BQrD+7h3FRJqxvQ==
X-Received: by 2002:a17:902:ea07:b0:1cf:6aff:ed80 with SMTP id s7-20020a170902ea0700b001cf6affed80mr690360plg.17.1700856003309;
        Fri, 24 Nov 2023 12:00:03 -0800 (PST)
Received: from [2620:0:1008:15:d807:a0b3:20ea:f28f] ([2620:0:1008:15:d807:a0b3:20ea:f28f])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902b60b00b001b89466a5f4sm3549207pls.105.2023.11.24.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 12:00:02 -0800 (PST)
Date:   Fri, 24 Nov 2023 12:00:02 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
In-Reply-To: <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
Message-ID: <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
References: <20231123133036.68540-1-gang.li@linux.dev> <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com> <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com> <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
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

On Fri, 24 Nov 2023, David Hildenbrand wrote:

> On 24.11.23 20:44, David Rientjes wrote:
> > On Thu, 23 Nov 2023, David Hildenbrand wrote:
> > 
> > > On 23.11.23 14:30, Gang Li wrote:
> > > > From: Gang Li <ligang.bdlg@bytedance.com>
> > > > 
> > > > Inspired by these patches [1][2], this series aims to speed up the
> > > > initialization of hugetlb during the boot process through
> > > > parallelization.
> > > > 
> > > > It is particularly effective in large systems. On a machine equipped
> > > > with 1TB of memory and two NUMA nodes, the time for hugetlb
> > > > initialization was reduced from 2 seconds to 1 second.
> > > 
> > > Sorry to say, but why is that a scenario worth adding complexity for /
> > > optimizing for? You don't cover that, so there is a clear lack in the
> > > motivation.
> > > 
> > > 2 vs. 1 second on a 1 TiB system is usually really just noise.
> > > 
> > 
> > The cost will continue to grow over time, so I presume that Gang is trying
> > to get out in front of the issue even though it may not be a large savings
> > today.
> > 
> > Running single boot tests, with the latest upstream kernel, allocating
> > 1,440 1GB hugetlb pages on a 1.5TB AMD host appears to take 1.47s.
> > 
> > But allocating 11,776 1GB hugetlb pages on a 12TB Intel host takes 65.2s
> > today with the current implementation.
> 
> And there, the 65.2s won't be noise because that 12TB system is up by a snap
> of a finger? :)
> 

In this single boot test, total boot time was 373.78s, so 1GB hugetlb
allocation is 17.4% of that.

Would love to see what the numbers would look like if 1GB pages were
supported.
