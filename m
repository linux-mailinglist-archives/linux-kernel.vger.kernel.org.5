Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35D3791A4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350867AbjIDPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:10:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17758BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DJJHJ+QymPIKxYSrYEByrV1EJIZ8oJGKczAbfnVY+xY=; b=qLGMBYEEmw96TWHhMfbl8ouiyV
        p+BJUoYsgPwRQqRCw/CqUtdDpkVAj/umLaRpAJ4En3BoCzVxrDbKR4wQnw70goUKcXBuvcegnqaVZ
        ZgNu+L6AlMMrgqTuAU0xUzXIPvDd4HnkLambqz+kpYgE5uw6SVEcz+bZ34YN484WVE/DM7aml0XA1
        QA/0mXv64wdHUAV5x08yT7F7WogIw4PO36cqZvaXKELyUh4tUFMMGOM9QFOqsvyifQ/tEjJ2lsxQv
        ywKMhlwd/cbTUS118xx76Cneg83j61kr+IHvPE492WP8h+z5WhwFhCPJllPhUo59+3zaJga0HAtvr
        wOPcK1sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdBDM-00H9gc-Si; Mon, 04 Sep 2023 15:10:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7892D3005B2; Mon,  4 Sep 2023 17:10:08 +0200 (CEST)
Date:   Mon, 4 Sep 2023 17:10:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] Revert "locking/rwsem: Remove reader optimistic
 spinning"
Message-ID: <20230904151008.GA25717@noisy.programming.kicks-ass.net>
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CGME20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf@epcas2p1.samsung.com>
 <20230901010704.18493-2-bongkyu7.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901010704.18493-2-bongkyu7.kim@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
> This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
> 
> In mobile environment, reader optimistic spinning is still useful
> because there're not many readers. In my test result at android device,
> it improves application startup time about 3.8%
> App startup time is most important factor for android user expriences.
> So, re-enable reader optimistic spinning by this commit. And,
> the later patch will make it optional feature by cmdline.

I'm not seeing any mention on how this interacts with all the rwsem work
that has been done since that commit, like the handoff rework.

Why is a straight revert a sane thing at this point?
