Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AAE7FFFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377342AbjLAAAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjLAAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:00:20 -0500
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD910E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:00:26 -0800 (PST)
Date:   Thu, 30 Nov 2023 19:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701388824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Ly5aykKHFfeWxXNnEM/rLM4wsOswGs38cnjAVJoN6U=;
        b=oy2SsPwAS+wnMk6eQgAOX2ZsDsMdkgzCngfRilNcFjWaSrqowK94gyQKQqWyUZE1X1JCZ3
        P6WoZubAsbHlA3q/LRExV9TuL97AC6IRoFydHo+bw3LND2ZBKUzh5qV1lLj0Bx7cPvPtPZ
        VfYRwDlDiPOLDQvDEutKQ+ONsaeJW3g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231201000020.2jwcdup7pklqoudf@moria.home.lan>
References: <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:01:23AM -0800, Roman Gushchin wrote:
> Ok, a simple question then:
> why can't you dump /proc/slabinfo after the OOM?
> 
> Unlike anon memory, slab memory (fs caches in particular) should not be heavily
> affected by killing some userspace task.

Well, currently the show_mem report dumps slab info if unreclaimable
slab usage is over some threshold (50%?). So it already does what you
describe - sometimes.

One of the patches in this series trims that down to make it more
useful; reporting on only the top 10 slabs, by mmeory usage, in sorted
order and with human readable units.
