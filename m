Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862117F08F6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKSU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSU4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:56:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09C115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K2UUUKZDs86DqLJwfJUbwqH9tdoEHH2Sfe13rGBM3MQ=; b=iZTb7wMnS0rIEO8XUBHZdY2Y2Y
        viDQ3g36LuUdwMM7eA4c7yJLd32QYPu9aM4/uvEsSgRmd+lMBpMavthHoZksXkZrun2o846YBQOOj
        xqFTdmGzZL0M+/yJpuNF3/Q2W8727vY/hZcTeIGVpOIKWCjflM4Il47ZLUM6A/36qfNodcDK69Qcn
        zoZ3a7AChlyW9te40JV+piKkgAE2DylVbgYg2rLX7vFLSTHSgc1OoI+2lRX3JCG/bx0Qi5urxxmKR
        F+/JNxvaYZtGZIG07ctrkif+NqwJW+7U3SHKrKK3NOc5sK28BLKco0jMVwCInTNU/H8A4/MgcPlG3
        utdhhyGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r4opV-0032da-18; Sun, 19 Nov 2023 20:55:45 +0000
Date:   Sun, 19 Nov 2023 20:55:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm/swap: fix a potential undefined behavior issue
Message-ID: <ZVp2UE+MqkifJG4B@casper.infradead.org>
References: <20231119194740.94101-1-ryncsn@gmail.com>
 <20231119194740.94101-2-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-2-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:47:17AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> When folio is NULL, taking the address of its struct member is an
> undefined behavior, the UB is caused by applying -> operator
> to a pointer not pointing to any object. Although in practice this
> won't lead to a real issue, still better to fix it, also makes the
> code less error-prone, when folio is NULL, page is also NULL,
> instead of a meanless offset value.

Um, &folio->page is NULL if folio is NULL.  The offset of 'page' within
'folio' is 0.  By definition; and this will never change.
