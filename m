Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE517B4364
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjI3Tsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Tsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:48:53 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908094
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 12:48:51 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qmfwq-0005GD-2p;
        Sat, 30 Sep 2023 15:48:20 -0400
Message-ID: <e8d03f63e92eac885b37562efcb5a6fe8f783cc2.camel@surriel.com>
Subject: Re: [PATCH 1/3] hugetlbfs: extend hugetlb_vma_lock to private VMAs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Date:   Sat, 30 Sep 2023 15:48:20 -0400
In-Reply-To: <20230930022842.GA82828@monkey>
References: <20230926031245.795759-1-riel@surriel.com>
         <20230926031245.795759-2-riel@surriel.com> <20230930022842.GA82828@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 19:28 -0700, Mike Kravetz wrote:
> On 09/25/23 23:10, riel@surriel.com wrote:
> 
> 
> In reply to patch 1, I suggested the changes:
> 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f906c5fa4d09..8f3d5895fffc 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -372,6 +372,11 @@ static void
> > __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
> >                 struct hugetlb_vma_lock *vma_lock = vma-
> > >vm_private_data;
> >  
> >                 __hugetlb_vma_unlock_write_put(vma_lock);
> > +       } else if (__vma_private_lock(vma)) {
> > +               struct resv_map *resv_map = vma_resv_map(vma);
> > +
> > +               /* no free for anon vmas, but still need to unlock
> > */
> > +               up_write(&resv_map->rw_sema);
> >         }
> >  }
> 
> However, the check for 'if (__vma_private_lock(vma))' was dropped.

Oh ugh. I definitely added that in somewhere, but must
have committed that to the wrong git branch :(

Let me send out a new version with that change.

Sorry about that.

-- 
All Rights Reversed.
