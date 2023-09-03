Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC5790A79
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjICB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 21:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjICB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 21:28:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF4ACDD;
        Sat,  2 Sep 2023 18:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 919A6B80A71;
        Sun,  3 Sep 2023 01:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DAAC433C7;
        Sun,  3 Sep 2023 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693704511;
        bh=PYzRr9E8cinyUGbciMSTAcc9851e4REu2BnLaZ9VMlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l6jfIF/LtsRyZLppqhtVE2dsbR3+WUt/umN0R1j+xPsJA+699rmgtrU8iSnkAlzYj
         E3Xos0pol2gTGWxmfuGBgiKS7rtdTNC28qhkYGogJt2QE+wKgX1Jb0IA0KkKESL8vo
         j1fObggi1wXIGiXmIWlHo2RzDrhCSHU0bTd2tbxI=
Date:   Sat, 2 Sep 2023 18:28:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] rcu: Dump vmalloc memory info safely
Message-Id: <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
In-Reply-To: <20230830110402.386898-2-joel@joelfernandes.org>
References: <20230830110402.386898-1-joel@joelfernandes.org>
        <20230830110402.386898-2-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 11:04:00 +0000 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Currently, for double invoke call_rcu(), will dump rcu_head objects
> memory info, if the objects is not allocated from the slab allocator,
> the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> need to be held, since the call_rcu() can be invoked in interrupt context,
> therefore, there is a possibility of spinlock deadlock scenarios.
> 
> And in Preempt-RT kernel, the rcutorture test also trigger the following
> lockdep warning:

"possibility of deadlock" sounds like something -stable kernels would
like to have fixed.

Did you consider the desirability of a -stable backport?

If so, are we able to identify a suitable Fixes: target?
