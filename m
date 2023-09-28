Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A87B2290
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjI1QiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1QiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:38:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37464193;
        Thu, 28 Sep 2023 09:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6124EC433C7;
        Thu, 28 Sep 2023 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695919090;
        bh=+pR8qTsnL2KdGPFPcXEQBLdZz545KfukXsurVyoKH7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Byq60xxiXtkUaPao9CHLMM6/ZD4JUm1Fi51Ys170+hT7Jr9h8MLvsYenIUwL6QCLN
         /pvKH0udwL+Ie7QkkNcK9vJa2M54GwBOUdm1ShpLMLiN6cXCjc6an8WrE1qnXZKhdD
         6liogk84HhVpZdEcYrUxIpAzIjGuochwQdz0SCpA=
Date:   Thu, 28 Sep 2023 09:38:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Yang Shi <yang@os.amperecomputing.com>, hughd@google.com,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        osalvador@suse.de, aquini@redhat.com, kirill@shutemov.name,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
Message-Id: <20230928093809.75de08561b0fa1af03bf4a89@linux-foundation.org>
In-Reply-To: <CAJuCfpExMWXHfZjgZ=UKf4k=zxrNOLx2R-a_wQdZ3O_+JTOq4w@mail.gmail.com>
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
        <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org>
        <90fc0e8d-f378-4d6f-5f52-c14583200a2e@os.amperecomputing.com>
        <CAJuCfpExMWXHfZjgZ=UKf4k=zxrNOLx2R-a_wQdZ3O_+JTOq4w@mail.gmail.com>
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

On Wed, 27 Sep 2023 14:39:21 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > >
> > >> The code should conceptually do:
> > >>
> > >>   if (MPOL_MF_MOVE|MOVEALL)
> > >>       scan all vmas
> > >>       try to migrate the existing pages
> > >>       return success
> > >>   else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
> > >>       scan all vmas
> > >>       try to migrate the existing pages
> > >>       return -EIO if unmovable or migration failed
> > >>   else /* MPOL_MF_STRICT alone */
> > >>       break early if meets unmovable and don't call mbind_range() at all
> > >>   else /* none of those flags */
> > >>       check the ranges in test_walk, EFAULT without mbind_range() if discontig.
> 
> With this change I think my temporary fix at
> https://lore.kernel.org/all/20230918211608.3580629-1-surenb@google.com/
> can be removed because we either scan all vmas (which means we locked
> them all) or we break early and do not call mbind_range() at all (in
> which case we don't need vmas to be locked).

Thanks, I dropped "mm: lock VMAs skipped by a failed queue_pages_range()"
