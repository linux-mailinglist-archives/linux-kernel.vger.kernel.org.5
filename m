Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C07E5516
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKHLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbjKHLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:21:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BE186
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:21:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23FC433CA;
        Wed,  8 Nov 2023 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699442498;
        bh=QvsTGBMyqYpxG6wP7fIuna1QJ2h+U8Zr4q9TDrPobzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gWlcNiqSDq4qFVyFdJfl776u13v1D3lGiyXuHJFmCgwKAgfldkN6uhd82YmHop11n
         ZEarMs8JL6qSsl42zZIzZTJU1/8sGKMavpJESNw8NzDgKSU+l77sm9gAX5vXmOe1XU
         OgJKpF3GiYvn4tnDoNJVI81qZuCgCcJ5BICEMhJ5Ne55F6KpbBSyA8va+wkU7zfa+O
         KH/t10/9RZnvi9LxpfO20JL9kQaZVd3dcssNOKSt8HA3TzSGip+jPDVl3sh6ORcczj
         5mUR9TxtbBWl51iP4IsxeO5J4LYC+Q2DTN5ihLDIGVMpaCyQ4h1CAVej0dwivDr3Am
         B73P5g3RoDlBw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so92527471fa.3;
        Wed, 08 Nov 2023 03:21:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yzs7TwPMygzYUJc6/Bv+zW6dib99Aaf079cZhtHngYZtbWNbS2u
        aSOEVC+JigNEkf1+f9ekRzcZ/gXKDA6nU4iJ1u0=
X-Google-Smtp-Source: AGHT+IHKnW94kmpfk41V+VUBlyb5MZkNOu6rsHPRwJbnCNLDFUUTlJmQcw/1/mXOa4hPXI6dgkL15ag2oOUH+v6SQfo=
X-Received: by 2002:a2e:9c50:0:b0:2c5:32b:28ea with SMTP id
 t16-20020a2e9c50000000b002c5032b28eamr1380107ljj.32.1699442496753; Wed, 08
 Nov 2023 03:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20231103151354.110636-1-michael.roth@amd.com> <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
In-Reply-To: <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Nov 2023 12:21:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Message-ID: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, stable@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/3/23 16:13, Michael Roth wrote:
> > When a task needs to accept memory it will scan the accepting_list
> > to see if any ranges already being processed by other tasks overlap
> > with its range. Due to an off-by-one in the range comparisons, a task
> > might falsely determine that an overlapping range is being accepted,
> > leading to an unnecessary delay before it begins processing the range.
> >
> > Fix the off-by-one in the range comparison to prevent this and slightly
> > improve performance.
> >
> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> More justification for introducing a common ranges_overlap() helper somewhere :)
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks, I'll take this as a fix.


> > ---
> > v2:
> >  * Improve commit message terminology (Kirill)
> > ---
> >  drivers/firmware/efi/unaccepted_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index 135278ddaf62..79fb687bb90f 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >        * overlap on physical address level.
> >        */
> >       list_for_each_entry(entry, &accepting_list, list) {
> > -             if (entry->end < range.start)
> > +             if (entry->end <= range.start)
> >                       continue;
> >               if (entry->start >= range.end)
> >                       continue;
>
