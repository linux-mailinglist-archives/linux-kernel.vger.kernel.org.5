Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363C37FE012
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjK2TED convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 14:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjK2TEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:04:01 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67EF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:04:07 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so2048551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284645; x=1701889445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6e/iPHotyGLxRcZFDNDxbxKjcI1VVeudET2V0CiNRw=;
        b=nWvOINyxBDPWWPGPzf5xuL9JLLtU/DYVvXlD547xbdforIlglbix1pLxGYLk+lTOrU
         D1r51Ks8n1chNDopVxr5WlSpphKeGT+/6U6T8bWUQA2KxzHZjOzQfzeBo+ACVl8Jytht
         1PhIZmRJGvJ9mkt5A+zu21WFMSfChHxjO1rH9xLIL4R0WwDXXjqDzdu1btTo4y/P4JYg
         CdbiUSdEQmKfeEs7XOwsu8Gh6DDa31V2y50nzbZGp3xnszhBVg+1EsWQi9/5u15MbjcL
         BxuKVUumPExm4xeCqrG3SIkH8qdFymGcu3MJhd6KaBXboavz0sIgNklqRhoUlqe6XlfE
         nU3w==
X-Gm-Message-State: AOJu0Yz5dVFf8xpGKHXMhv3So9omAE8lWxgzU4NKyST6uQC5PGwdnGDv
        qdnNdfwnJeyg9eWMoa9EeGOEt0xQbQ8dW8fxhA==
X-Google-Smtp-Source: AGHT+IFZbYy0xwGTrEdISZZupZsQXl2gjBcYvUS3srlgKW0bTVN7ZheGcoVR4CI2Tf1Dtro+/cESGQvLdpW8A+Cx3MI=
X-Received: by 2002:a2e:7203:0:b0:2c9:bf97:81d1 with SMTP id
 n3-20020a2e7203000000b002c9bf9781d1mr1818071ljc.27.1701284645142; Wed, 29 Nov
 2023 11:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
 <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com> <2166103.irdbgypaU6@fdefranc-mobl3>
In-Reply-To: <2166103.irdbgypaU6@fdefranc-mobl3>
From:   Christopher Li <chrisl@kernel.org>
Date:   Wed, 29 Nov 2023 11:03:52 -0800
Message-ID: <CANeU7QmJg3XSxfNQhrd-gDeT8_cWSO+t-WyEXvf9TWHYXKY6OA@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
To:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Nov 29, 2023 at 3:41 AM Fabio M. De Francesco
<fabio.maria.de.francesco@linux.intel.com> wrote:
> > > The kernel virtual addresses returned by these two API are
> > > only valid in the context of the callers (i.e., they cannot be handed to
> > > other threads).
> > >
> > > With kmap_local_page() the mappings are per thread and CPU local like
> > > in kmap_atomic(); however, they can handle page-faults and can be called
> > > from any context (including interrupts). The tasks that call
> > > kmap_local_page() can be preempted and, when they are scheduled to run
> > > again, the kernel virtual addresses are restored and are still valid.
> >
> > As far as I can tell, the kmap_atomic() is the same as
> > kmap_local_page() with the following additional code before calling to
> > "__kmap_local_page_prot(page, prot)", which is common between these
> > two functions.
> >
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 migrate_disable();
> >         else
> >                 preempt_disable();
> >
> >         pagefault_disable();
> >
>
> This is what I tried to explain with that sentence. I think you overlooked it
> :)

I did read your description. It is not that I don't trust your
description. I want to see how the code does what you describe at the
source code level. In this case the related code is fairly easy to
isolate.

>
> BTW, please have a look at the Highmem documentation. It has initially been
> written by Peter Z. and I reworked and largely extended it authoring  the
> patches with my gmail address (6 - 7 different patches, if I remember
> correctly).
>
> You will find there everything you may want to know about these API and how to
> do conversions from the older to the newer.

Will do, thanks for the pointer.

Chris
