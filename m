Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052C781556
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbjHRWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHRWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E93ABC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h8zRGeP3ZXbzncyEMShArWnr9NNS+NPyIty1H6pPQQw=; b=UPDWe0V5HmrjDaRkHvstOlw2UU
        VLFSAFsn56TL2fZg2Ogb48GYLLKBspzO3HBGx4jOZrI8T9YN+Ed00iK3JLrM58Z+65V4Kgt9X8Eta
        5D3YpzNt3tqOs3LQ289ti/XSl9k7HZq8sndCNCp2y44kIjgzxpvdv78X6LvXOHPpY0QoLi9hnWzwW
        jN65u5IUeAsYFx5NpxfFo9ru7otlRQLQ2Hgy9Qw9fZWy3WXNyvjYMGXuvVvvDPZ4ABEJyJNUKFHuM
        TnQWzragzh+JYWV0lpyEKBzpUZz3PTdimDUEHhZYYW858jvIGEwTXMO5DqAn+AGuHSIcWxWaql+Ag
        ri3qPQbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX7mE-00ByUr-9I; Fri, 18 Aug 2023 22:17:06 +0000
Date:   Fri, 18 Aug 2023 23:17:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] smaps: set THPeligible if file mapping supports
 large folios
Message-ID: <ZN/t4sgCe5lsFUpR@casper.infradead.org>
References: <20230818211533.2523697-1-zokeefe@google.com>
 <20230818211533.2523697-2-zokeefe@google.com>
 <CAAa6QmSN+7zWTMhYY9rEBf8U5xZ3kwfZXUuvT=ZGmEXLpNm0Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmSN+7zWTMhYY9rEBf8U5xZ3kwfZXUuvT=ZGmEXLpNm0Kg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:14:02PM -0700, Zach O'Keefe wrote:
> Sorry -- noticed only too late that there are still many
> false-negatives for THPeligible, since by this point in the function
> we've already applied sysfs and prctl restrictions, which file-fault
> ignores. VM_HUGEPAGE also needs to be checked for the file-fault case.

I'm not entirely convinced that unifying all of these things leads
to code that's simpler to understand.

> On Fri, Aug 18, 2023 at 2:15 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > File-backed memory can be backed by THPs either through collapse, when
> > CONFIG_READ_ONLY_THP_FOR_FS is enabled, or through fault, when the
> > filesystem supports large folio mappings.
> >
> > Currently, smaps only knows about the former, so teach it about the
> > latter.
> >
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > ---
> >  mm/huge_memory.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index cd379b2c077b..d8d6e83820f3 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -136,7 +136,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> >                          */
> >                         !!vma->vm_ops->huge_fault :
> >                         /* Only regular file is valid in collapse path */
> > -                       file_thp_enabled(vma);
> > +                       file_thp_enabled(vma) ||
> > +                        /*
> > +                         * THPeligible bit of smaps should surface the
> > +                         * possibility of THP through fault if the filesystem
> > +                         * supports it.  We don't check this in fault path,
> > +                         * because we want to fallback to the actual ->fault()
> > +                         * handler to make the decision.
> > +                         */
> > +                        (smaps && vma->vm_file &&
> > +                        mapping_large_folio_support(vma->vm_file->f_mapping));
> >
> >         if (vma_is_temporary_stack(vma))
> >                 return false;
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
