Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1F7EF607
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjKQQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjKQQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:20:03 -0500
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A45A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:20:00 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 96A741C464C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:19:58 +0000 (GMT)
Received: (qmail 21917 invoked from network); 17 Nov 2023 16:19:58 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.19])
  by 81.17.254.26 with ESMTPA; 17 Nov 2023 16:19:58 -0000
Date:   Fri, 17 Nov 2023 16:19:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] mm: page_alloc: correct high atomic reserve
 calculations
Message-ID: <20231117161956.d3yjdxhhm4rhl7h2@techsingularity.net>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <905d99651423ee85aeb7a71982b95ee9bb05ee99.1699104759.git.quic_charante@quicinc.com>
 <20231116095901.72oqtjoiqzt3tfhj@techsingularity.net>
 <ZVYQihO8lsI5_JJc@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZVYQihO8lsI5_JJc@tiehlicka>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 01:52:26PM +0100, Michal Hocko wrote:
> On Thu 16-11-23 09:59:01, Mel Gorman wrote:
> [...]
> > This patch in isolation seems fine with the caveat that such a small
> > system may find the atomic reserves to be borderline useless.
> 
> Yes, exactly what I had in mind. Would it make sense to reserve the the
> pageblock only if it really is less than 1% of available memory?

I'd have no objection with the caveat that we need to watch out for new
bugs related to high-order atomic failures. If ths risk is noted in the
changelog and that it's a revert candidate then any bisection should
trivially find it.

-- 
Mel Gorman
SUSE Labs
