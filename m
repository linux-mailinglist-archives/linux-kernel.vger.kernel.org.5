Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD67EE4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjKPQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:12:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E8B193;
        Thu, 16 Nov 2023 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lz9jtIq5mDaKC570N2BIf9wLXeeJJC+HK/9/2AmFe2Y=; b=G2Z0gmydhvRGXv3j/EgJ5/r98/
        JRxc7e8AgM7fcqr96CRTx3YKpfFGomG45ImrBNZ4AcVV1FfGosSfbRC8yoKwzUj6ZZbW1dwZEF7S4
        q9qEE0dqulvK+qgxAnWkD5ylAReeUZnnN9FJBEvgMiegE5we3Dt2xxNSrAgFUeDvC8ZYpcHZSfaAY
        QpEkCz2mMV0vk0HaibcjqwOhi2V/t85uf+djkOoj0Tdn4x4xy9hoYGPpfpvCoXh3JKgS3kKiDjS1H
        PTtt0rwS2L56Vez7EpKXi63vls+6/KPkNwFRKl+Plp3DJPStTfQ0XtXhIVmG1mC7+M+g4rxhvVT4R
        2sHkY/FQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3eym-003xSV-RC; Thu, 16 Nov 2023 16:12:32 +0000
Date:   Thu, 16 Nov 2023 16:12:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v3 1/4] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Message-ID: <ZVY/cAMFbkuKJF/Y@casper.infradead.org>
References: <20231110204119.3692023-1-willy@infradead.org>
 <20231110204119.3692023-2-willy@infradead.org>
 <52f481a3-bf4f-85ae-9ae6-10a23b48c7c5@redhat.com>
 <ZVPmCoLVXyShSrkN@casper.infradead.org>
 <72dced0f-6d49-4522-beeb-1a398d8f2557@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dced0f-6d49-4522-beeb-1a398d8f2557@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 08:17:32PM -0500, Waiman Long wrote:
> > > There are some inconsistency in the use of WARN_ON() and BUG_ON() in the
> > > assertions. For PREEMPT_RT, held_write is a BUG_ON. For non-PREEMPT_RT, held
> > > is a BUG_ON. It is not clear why one is BUG_ON and other one is WARN_ON. Is
> > > there a rationale for that?
> > I'll fix that up.
> The check for write lock ownership is accurate. OTOH, the locked check can
> have false positive and so is less reliable.

When you say 'false positive', do you mean it might report the lock as
being held, when it actually isn't, or report the lock as not being held
when it actually is?  The differing polarities of assert and BUG_ON
make this confusing as usual.

Obviously, for an assert, we're OK with it reporting that the lock is
held when actually it's not.  The caller is expected to hold the lock,
so failing to trip the assert when the caller doesn't hold the lock
isn't great, but we can live with it.  OTOH, if the assert fires when
the caller does hold the lock, that is not tolerable.

