Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ACE781D98
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHTLht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHTLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 07:37:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2017A1AC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xN0fwt/STADs0Ec2XQkK4ix6J4ApFx0uohiaM3xLkWw=; b=ZtMNdze+d/bULpG639C77uwsGD
        9kKjTv2GTLUXyAbNoiUfcSCWJL04AChXWEEPJrpsPo8djuZzrUNp4QNI4ZNGDodU+yvfTCcIi4MlV
        8W4IE0eQgwObYpEPwp34OtJa/+T59ZyNAgzdYfQp5tGyyaOM/KVd2pb5FRYecBEgPkmNfgt5YiNXa
        /68IfgPGghj9NfVB/yoSh2T6O1W4+tFrDaMZ+mIjEbvElgkOF6v6D/3/Sd0YkrWSyuyaz+QMsKVgY
        0exvE8sSsfPlGSCYhw4kv149EiVGuMbKvpNyeIon3MdAGrO2Go7eunta/UBE+bkdc5uZMWIRSSBm9
        RndrMOnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXgjp-003q7c-If; Sun, 20 Aug 2023 11:36:57 +0000
Date:   Sun, 20 Aug 2023 12:36:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <ZOH62Zi/yao/oC8y@casper.infradead.org>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820104303.2083444-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
> Should the trylock succeed (and thus blocking was avoided), the routine
> wants to ensure blocking was still legal to do. However, the method
> used ends up calling __cond_resched injecting a voluntary preemption
> point with the freshly acquired lock.
> 
> One can hack around it using __might_sleep instead of mere might_sleep,
> but since threads keep going off CPU here, I figured it is better to
> accomodate it.

Except now we search the exception tables every time we call it.
The now-deleted comment (c2508ec5a58d) suggests this is slow:

-       /*
-        * Kernel-mode access to the user address space should only occur
-        * on well-defined single instructions listed in the exception
-        * tables.  But, an erroneous kernel fault occurring outside one of
-        * those areas which also holds mmap_lock might deadlock attempting
-        * to validate the fault against the address space.
-        *
-        * Only do the expensive exception table search when we might be at
-        * risk of a deadlock.  This happens if we
-        * 1. Failed to acquire mmap_lock, and
-        * 2. The access did not originate in userspace.
-        */

Now, this doesn't mean we're doing it on every page fault.  We skip
all of this if we're able to handle the fault under the VMA lock,
so the effect is probably much smaller than it was.  But I'm surprised
not to see you send any data quantifying the effect of this change!

