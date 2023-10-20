Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136BD7D155F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjJTSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJTSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:02:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9ADD5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:02:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFADC433C9;
        Fri, 20 Oct 2023 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697824963;
        bh=0pd8oyJr8Z/2Zw3X/z3kmWzu508WFnpM4EOZnOcv7t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLZAT9s/4N6yBnQlsvKopCnL7ulX+4z0p8pH/yEGkOfPF7iqzGCYYJokZa3qR1pup
         nEsz2gGLNTWvMxLKPQC9uMF0Lcch/uTkeuGzfqfYxiV8snTBoIthW0uIZDS3qrm2nI
         c4i5fy3Y/tWT+0Sc1m254hXw3N1suzwa2k+ETC0FZ1iwwR9UEHyVN6vJffrbaAW6/V
         C2ACzK+zKD+62atm7qzQZVzbD7WhGMOLyfO7CrR+8x86rNCm82lD++1isx6cQKnM2/
         YB2ZEt8w3lBahnyuMmCohlLy4zqsGVX5Q6AoX/ibOojKyiqMZN0sBhXYCX+4YUNTQ3
         Y9dTbzG4UpcyQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date:   Fri, 20 Oct 2023 18:02:42 +0000
Message-Id: <20231020180242.64276-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020103036.027282d16aaf56498230cc12@linux-foundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 10:30:36 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 20 Oct 2023 17:19:01 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > The maximum nr_accesses of given DAMON context can be calculated by
> > > dividing the aggregation interval by the sampling interval.  Some logics
> > > in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> > > shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> > > agregation interval as samller than the sampling interval.  However,
> > > since nr_accesses is unsigned int while the intervals are unsigned long,
> > > the maximum nr_accesses could be zero while casting.
> > 
> > Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
> > for him.  I sure Andrew could add that on his own, but I want to minimize
> > Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
> > that doesn't help but only increasing your load.
> 
> Editing the changelogs is far quicker than updating a patch series ;)
> 
> btw, it's now conventional to add a link to the reporter's report.  The
> new "Closes:" tag, immediately after the Reported-by:.  But it's not a
> big deal.

Surely it is.  And in this case, the report was made privately, so no available
link.  I should have mentioned this early, sorry.  Anyway, thank you for your
help, Andrew :)


Thanks,
SJ
