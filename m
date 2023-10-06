Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521A7BC0F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJFVIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjJFVIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:08:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D259BE;
        Fri,  6 Oct 2023 14:08:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE07C433C7;
        Fri,  6 Oct 2023 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696626518;
        bh=9BZJKDvYId5mTUI/VJ4lTfM8ilKtayFSoGbiLtqREq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nYSvxJyec3IzHIU6njiyA9wPXgtaeINBNOahtcTtBy9+2BT8dPfyxfbLnT1/krQks
         9bwzY9MoB2+3vdaH94yQsrezbRC1C2xKLTOHrlZBTSE6si1q1G+T0x8rU1a5rpGh9z
         QWIZna64U8bKGxeKGJKvJvq4f9Lt9hCpOQ5E1/ok=
Date:   Fri, 6 Oct 2023 14:08:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Message-Id: <20231006140834.07110f7008677c646af1694d@linux-foundation.org>
In-Reply-To: <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
        <20230929183041.2835469-3-Liam.Howlett@oracle.com>
        <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 09:21:22 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >
> >                 remove_next = true;
> >                 vma_start_write(next);
> > -               ret = dup_anon_vma(vma, next);
> > +               ret = dup_anon_vma(vma, next, &anon_dup);
> >                 if (ret)
> >                         return ret;
> 
> Shouldn't the above be changed to a "goto nomem" instead of "return ret" ?

It looks OK to me as-is - dup_anon_vma() leaves anon_dup==NULL
when it returns error.
