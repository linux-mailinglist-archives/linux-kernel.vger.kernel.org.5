Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7725C7E9263
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjKLT4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLT4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:56:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDD136
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:56:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFABC433C7;
        Sun, 12 Nov 2023 19:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818966;
        bh=1C1MtKpveJD7sT2SfOQ62rJYeWw1bMc/CqvKgThfMCY=;
        h=From:To:Cc:Subject:Date:From;
        b=TQ2myIiV5uNBkEXu368kssk8OZ+f1FbRv2+7LKxwyINFP7t7TyuGTKQDWi5r6XGUd
         m69TSleYR+GV7CSGBPNptdcpfOPOKnfnzl8uzILtV5IEHNA3sinlcNp2ElwYAyh4Sn
         dr8wwb9bH4z5ZjArfn5V9xnKf22Ah1PBWFTfvOeVcZh7scO14NaOuHos8rspFEXCuG
         NLkcB1bBWmIn4ZT6NjinYyuKv3jp3cOOAblYd2KeTYfLJqvjt/2aGcJkq3BzbVVSrt
         7B2PTgY5WB3Sj4ntiiEXdthfNFcyIns98hiXr8DJFkPk8AcEBJNb6dDcD/PrSo/acY
         sdj9acMinucjA==
From:   SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sj@kernel.org
Subject: [RFC IDEA] DAMOS-based Tiered-Memory Management
Date:   Sun, 12 Nov 2023 19:56:02 +0000
Message-Id: <20231112195602.61525-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


There were a few attempts to use DAMON at tiered memory management, from the
pretty early days of DAMON[1].  I also wanted to dive deep on this topic[2] but
didn't get time for this, unfortunately.  Meanwhile, a few people thankfully
shared their own approaches and results with me, sometimes in public, and
sometimes in private.

They used varying approaches and the results were also very different.  Some
folks achieved nice results, while it was only waste of time for someone.
Nonetheless, what I commonly heard about from such grateful sharing was the
difficulty of DAMON tuning[3,4].  My proposal for the tuning difficulty wa
auto-tuning DAMOS aggressiveness based on feedbacks, which could be provided by
user, or DAMON can collect on its own.  It is still not done, but an early
version of the implementation has recently shared.  I'd like to share my
humble concept level idea of using the auto-tuning feature for somewhat
reasonable or at least worthy to try DAMOS-based tiered memory management.

Background
==========

Please read DAMOS auto-tuning RFC patchset[1]'s coverletter and the first patch
for the overall concept and the implementation detail.  In short, the feature
allow users define aimed system status (e.g., 0.05% memory PSI and/or 50% free
memory ratios), and let DAMOS control its aggressiveness on its own to achieve
the goals.  If it is under-achieving the goals, DAMOS increases its
aggressiveness, and vice versa.  Under the limited aggressiveness, DAMOS
applies the action to pages that more prioritized for the action.  For example,
colder pages are more prioritized for 'pageout' action.

DAMOS-based Tiered-Memory Management Idea
=========================================

The idea is to set DAMOS schemes for each tiered memory node, like below.

1. If the node has a lower node, demote cold pages of the
node to the lower node using DAMOS, colder pages first.  Let DAMOS auto-tune
the aggressiveness of the demotion scheme aiming small amount of (e.g., 5%)
free memory of the current node.

2. If the node has a higher node, promote hot pages in the node to the upper
node using DAMOS, more hot pages first.  Let DAMOS auto-tune the aggressiveness
of the promotion scheme aiming high utilization rate (e.g., 96%) of the upper
node.

The aims of the demotion scheme and the promotion scheme are set to conflict a
little bit, like above example.

Discussion
==========

The simple scheme can be easily extended to multiple tiered memory nodes.
Higher node will keep high utilization with relatively hot pages, while lower
nodes will have only relatively cold pages that cannot be accommodated in
higher nodes due to out of the space.

Because the utilization goal and the free memory goal overlap, DAMOS will
continue moving cold pages down and hot pages up.  Since the demotion is for
coldest pages of the node, and the aggressiveness auto-tuning will make the
aggressiveness under the small overlap small, the overhead will be only modest.

If the system needs to being memory frugal, we may apply
Access/Contiguity-aware Memory Auto-Scalaing (ACMA)[6] to the lowest node.
Note that ACMA removes unnecessary memory blocks one by one and add those back
as needed.  As a result, the system will have only necessary nodes.

Request For Comments
====================

This is in very early stage.  No enough survey of related works is done, and no
implementation of the demote/promote DAMOS action are made.  An early version
of the aim-oriented DAMOS aggressive auto tuning is available, though.  I even
have no good test setup for tiered memory system.  That said, I hope to get any
comments or concern about this humble early idea if someone have.  That's not
to only make it success as is, but rather to learn from you and develop it
together, or even fail fast.

Example Operation Scenario
==========================

Let's suppose a system is having a DRAM and a CXL-based slower node, each can
accommodate 10 pages.

And the system is configured as the idea is proposed above.  The free memory
ratio and memory utilization ratio goals are set as 5% and 96%.  That is, we
have the demote DAMOS scheme for DRAM node, and promote DAMOS scheme for CXL
node.

Let's also represent the hotness of each page in five level, from 0 (cold) to 4
(hot).  And let's represent free pages as 'F'.

Then a state of the system may represented like below:

    Node 0 (DRAM): 43210 43210  (100% util,   0% free)
    Node 1 (CXL):  FFFFF FFFFF  (  0% util, 100% free)

Cold Pages-only Pingpong
------------------------

Since DRAM node is having 0% free memory ratio, which is under-achieving the
goal of the demote scheme, demote scheme is activated.  Meanwhile, since DRAM
node utilization ratio is 100%, which is higher than the goal of the promote
scheme (96%), the promote scheme does nothing.  Hence, cold pages in Node 0 are
demoted, colder one first.

    Node 0 (DRAM): 4321F 43210  ( 95% util,   5% free)
    Node 1 (CXL):  FFFF0 FFFFF  (  5% util,  95% free)

The goal of demote scheme is met, so demote scheme stops.  The DRAM utilization
ratio is below the promote scheme's goal (96%) now.  So the scheme is activated
and promote hot pages of the node, more hot one first.  It promotes the coldest
one in this case, though, since that's the only one page that can be promoted.

    Node 0 (DRAM): 43210 43210  (100% util,   0% free)
    Node 1 (CXL):  FFFFF FFFFF  (  0% util, 100% free)

Then promote scheme again deactivated, and demote scheme activated.  Coldest
page demoted.

    Node 0 (DRAM): 43210 4321F  ( 95% util,   5% free)
    Node 1 (CXL):  FFFFF FFFF0  (  5% util,  95% free)

Then promote scheme again activated, and demote scheme deactivated.  The
hottest page in CXL memory promoted.  The hottest page is the colest one in CXL
node this time again, though.

    Node 0 (DRAM): 43210 43210  (100% util,   0% free)
    Node 1 (CXL):  FFFFF FFFFF  (  0% util, 100% free)

In this way, DRAM node keeps high utilization ratio with only hot pages, while
only cold pages move back and forth between the two nodes.

Handling of Hotness Changed Pages
---------------------------------

Let's assume the two cold pages are in CXL node.

    Node 0 (DRAM): 4321F 4321F  ( 90% util,  10% free)
    Node 1 (CXL):  FFFF0 FFFF0  ( 10% util,  90% free)

And let's assume the demoted pages become hot.

    Node 0 (DRAM): 4321F 4321F  ( 90% util,  10% free)
    Node 1 (CXL):  FFFF3 FFFF2  ( 10% util,  90% free)

The promotion scheme will promote the hottest page.

    Node 0 (DRAM): 43213 4321F  ( 95% util,   5% free)
    Node 1 (CXL):  FFFFF FFFF2  (  5% util,  95% free)

The other page in CXL also get promoted following the goals.

    Node 0 (DRAM): 43213 43212  (100% util,   0% free)
    Node 1 (CXL):  FFFFF FFFFF  (  0% util, 100% free)

Now, the demotion scheme demotes cold pages of the DRAM node, not the now-hot
just promoted pages.

    Node 0 (DRAM): 432F3 43212  ( 95% util,   5% free)
    Node 1 (CXL):  FFF1F FFFFF  (  5% util,  95% free)

Unless the now-coldest pages be hot, only they will continue being promoted and
demoted.

Extension
---------

The schemes can be extended for more than two nodes scenario.  For example,
below system can be configured.  Let's assume CXL2 node is slower than CXL
node.

    Node 0 (DRAM): 44444 4443F  ( 95% util,   5% free)
    Node 1 (CXL):  33333 3321F  ( 95% util,   5% free)
    Node 2 (CXL2): 11111 100FF  ( 90% util,  19% free)

A demote scheme for Node 0, which aims 5% free memory rate of Node 0, is
configured.

For Node 1, two schemes are made.  One promote scheme which aims 96%
utilization of Node 0, and one demote scheme which aims 5% free memory of
Node 1.

And Node 2 also has one promote scheme which aims 96% utilization of Node 1.

In the way, higher nodes get high utilization with hot pages.  If working set
is enough to be accommodated in 95% of highest node, all working set will be
placed in the node.


[1] https://lore.kernel.org/linux-mm/cover.1640171137.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/20230105221109.53398-1-sj@kernel.org/
[3] https://lore.kernel.org/linux-mm/20230219203138.4873-1-sj@kernel.org/
[4] https://lwn.net/Articles/931812/
[5] https://lore.kernel.org/damon/20231112194607.61399-1-sj@kernel.org/
[6] https://lore.kernel.org/damon/20231112195114.61474-1-sj@kernel.org/
