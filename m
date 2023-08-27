Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D060789DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjH0NIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjH0NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63696EC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F22FD61561
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D53DC433C8;
        Sun, 27 Aug 2023 13:07:56 +0000 (UTC)
Date:   Sun, 27 Aug 2023 16:07:55 +0300
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH] mm/kmemleak: Move up cond_resched() call in page
 scanning loop
Message-ID: <ZOtKq99/aZCNkav6@arm.com>
References: <20230825164947.1317981-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825164947.1317981-1-longman@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:49:47PM -0400, Waiman Long wrote:
> Commit bde5f6bc68db ("kmemleak: add scheduling point to kmemleak_scan()")
> added a cond_resched() call to the struct page scanning loop to prevent
> soft lockup from happening. However, soft lockup can still happen in
> that loop in some corner cases when the pages that satisfy the "!(pfn &
> 63)" check are skipped for some reasons.
> 
> Fix this corner case by moving up the cond_resched() check so that it
> will be called every 64 pages unconditionally.
> 
> Fixes: bde5f6bc68db ("kmemleak: add scheduling point to kmemleak_scan()")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
