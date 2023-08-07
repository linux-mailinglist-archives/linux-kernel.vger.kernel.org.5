Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B7771941
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHGFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:08:17 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C1610FD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:08:14 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-47-64d07c3b9fd9
Date:   Mon, 7 Aug 2023 14:05:31 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20230807050531.GB49200@system.software.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
 <7023C1AF-6C9B-4544-8EC4-0BB790C1E338@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7023C1AF-6C9B-4544-8EC4-0BB790C1E338@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXC9ZZnoa5NzYUUg70zWSzmrF/DZvFiQzuj
        xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaL67seMloc7z3AZPH7B1B2zhQri5Oz
        JrM48Hos2FTqsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTx2PrT0mHcy0OP9vqtsHlt/2Xl8
        3iTn8W7+W7YAnigum5TUnMyy1CJ9uwSujOcbTrAWLGep+La+kamBcTtzFyMHh4SAicS9Q/Zd
        jJxgZkvfOkYQm0VAReL08a8sIDabgLrEjRs/mUFsEQFFiUP774HVMAtcYZH4Oo8PxBYWiJE4
        seUzE4jNK2Ah8XbyeqB6Lg4hgamMEje6b0MlBCVOznzCAtGsLvFn3iWwG5gFpCWW/+OACMtL
        NG+dDbaLU8BOYu7Wy2CtogLKEge2HWcCmSkh0M8u0br+BjvE0ZISB1fcYJnAKDgLyYpZSFbM
        QlgxC8mKBYwsqxiFMvPKchMzc0z0MirzMiv0kvNzNzECI3BZ7Z/oHYyfLgQfYhTgYFTi4W04
        fD5FiDWxrLgy9xCjBAezkgjvvCdAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tS
        s1NTC1KLYLJMHJxSDYwLzmalnNw73+ta+XS3QBE57ZZHr3+Y1l9/G+zH/Ef6Q+S97EyB4K2T
        vxw4s0JDsTEr1DJxKrezpNmdQrUJ9Yf5Xuz/vc04uVcm4J7kqjslD7/8PPZh/v3cFw6aM/cd
        WPG9c/eriQE9XssqdYPma3puUi5zL9O98ZRFOzboj6Cg3xy1ayeyc1KVWIozEg21mIuKEwFN
        4viIvAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrGtdcyHF4P92E4s569ewWbzY0M5o
        8XX9L2aLp5/6WCwOzz3JanF51xw2i3tr/rNanN+1ltVix9J9TBbXdz1ktDjee4DJ4vcPoOyc
        KVYWJ2dNZnHg81iwqdRj8wotj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOkx72Sgx/t9V9k8
        Fr/4wOSx9Zedx+dNch7v5r9lC+CN4rJJSc3JLEst0rdL4Mp4vuEEa8Fylopv6xuZGhi3M3cx
        cnJICJhItPStYwSxWQRUJE4f/8oCYrMJqEvcuPETrEZEQFHi0P57YDXMAldYJL7O4wOxhQVi
        JE5s+cwEYvMKWEi8nbweqJ6LQ0hgKqPEje7bUAlBiZMzn7BANKtL/Jl3CaiIA8iWllj+jwMi
        LC/RvHU22C5OATuJuVsvg7WKCihLHNh2nGkCI98sJJNmIZk0C2HSLCSTFjCyrGIUycwry03M
        zDHVK87OqMzLrNBLzs/dxAiMqGW1fybuYPxy2f0QowAHoxIPb8Ph8ylCrIllxZW5hxglOJiV
        RHjnPQEK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MB79
        EW614ZDPpZP9z8uj5VglLs579PDZqz4JS5b326Xa5xe+tXGTTDdeOWPrsucXPVdxX1V4OjHk
        OMuuc1vfTFSe0hnmmpF1tzF/3v6n6lp3M9T4j3K07o+veqH/2tdyr1n4BCavOyl3A5ao+txd
        51THf7TObIpodYJmyWzN62pJkqfXaj961anEUpyRaKjFXFScCAAKeW/NpAIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:32:30PM +0000, Nadav Amit wrote:
> The patch in its current form, I am afraid, is very very hard to review.
> It is way too big and is missing comments. Having CONFIG_MIGRC makes no
> sense (I guess it is intended to be a “chicken-bit”). Variable and
> function names are not informative. The memory barriers are handle
> improperly (please check again the smp_mb__after_atomic() rules).

I checked it. I found what I was wrong at. Thank you for pointing it out.
I will fix it from the next spin.

	Byungchul
