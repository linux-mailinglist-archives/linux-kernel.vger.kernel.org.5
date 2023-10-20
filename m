Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AF7D14E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377919AbjJTRam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjJTRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:30:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E59A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:30:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D8BC433C7;
        Fri, 20 Oct 2023 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697823037;
        bh=cJeCmKC38qm90zyfdcG4SUKfILLYa+5rU2Q+LCqJ8lM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XIbOXKykVs348OUb2DLZnFwaZAO6yQOODMlyMioGr7OgM6CvBy+LNZcvXM0I9N1U1
         9N94CneC/tHv2yls/XwFziprrJXA1NQGwu7D3VG75vhzQMvmrGovs7eabtAjPKjT/x
         ncOf/qPcc1NjxqBFZynMjaCLtE3pn3839yr3DUfw=
Date:   Fri, 20 Oct 2023 10:30:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses
 overflow
Message-Id: <20231020103036.027282d16aaf56498230cc12@linux-foundation.org>
In-Reply-To: <20231020171901.63994-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
        <20231020171901.63994-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:19:01 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > The maximum nr_accesses of given DAMON context can be calculated by
> > dividing the aggregation interval by the sampling interval.  Some logics
> > in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> > shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> > agregation interval as samller than the sampling interval.  However,
> > since nr_accesses is unsigned int while the intervals are unsigned long,
> > the maximum nr_accesses could be zero while casting.
> 
> Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
> for him.  I sure Andrew could add that on his own, but I want to minimize
> Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
> that doesn't help but only increasing your load.

Editing the changelogs is far quicker than updating a patch series ;)

btw, it's now conventional to add a link to the reporter's report.  The
new "Closes:" tag, immediately after the Reported-by:.  But it's not a
big deal.
