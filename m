Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA19A78271B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjHUKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHUKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:32:39 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA648F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:32:34 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 72422FA99D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:32:32 +0100 (IST)
Received: (qmail 31727 invoked from network); 21 Aug 2023 10:32:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Aug 2023 10:32:32 -0000
Date:   Mon, 21 Aug 2023 11:32:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
Message-ID: <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> In this patch series I want to safeguard
> the free_pcppage_bulk against change in the
> pcp->count outside of this function. e.g.
> by BPF program inject on the function tracepoint.
> 
> I break up the patches into two seperate patches
> for the safeguard and clean up.
> 
> Hopefully that is easier to review.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>

This sounds like a maintenance nightmare if internal state can be arbitrary
modified by a BPF program and still expected to work properly in all cases.
Every review would have to take into account "what if a BPF script modifies
state behind our back?"

-- 
Mel Gorman
SUSE Labs
