Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9680F3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjLLREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjLLREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:04:15 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494F99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:04:21 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d8a772157fso51640937b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400660; x=1703005460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kldGEgyoOibSxMWFBb5z8YejTwIf3uVcbk6Oh/hN9Oo=;
        b=BYbIlyGimLCfnnMBCstZyG1WCR0veNsYLjAQNHF/GhHy7TtnDvPxCuLMtVe/uoEOiW
         YWJLf7IRp8+1bPLiiWV2exdg9bOPf4tYgOBKE6TdQ3Ei6newKN8llltCm1IRMY829zH2
         w2KiVuTCt+QxARSX2L5FMNrh/8xaBHSHAF1IcxDMaIddm4LcHdVisKDD1HtCYWD7BChU
         baHSsiwNdRchdNSUqS7KPC66/0J09S/tIKQom44HGiBo+znAtH4Zzj44Sc+rcadt22C8
         dtIOeO2nBwF+Je4FI7JXb1I60i813ztg17tuFzbAmhruOP/qjK+Itec5K22knhdSuFQ4
         WIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400660; x=1703005460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kldGEgyoOibSxMWFBb5z8YejTwIf3uVcbk6Oh/hN9Oo=;
        b=oNGL8uxT7US2Vqxyj4UE/2Usiz5nUGd4Rjm9MCN0H09qlsgUocvoPurkoqvysGfJ7q
         APVZvOxuuy1sNyH5ap1C+/1ngVoXBVg4zBmtNVoWxcW2gKRYEGD3sGOFkaqGS3oYqewx
         c1tejnjSK6qHZ6NUL7gy6Scs7pZabjeXvNCJjsL2Ju9LpdHhb5GJ1/lTMbdareBB8FS7
         /QTYSN5RxofjsL//uQQpKA8xzSC9J9x08huOP4sUs5G9i8UIXdyJ4WpYHiOL6dFzb0TG
         3tTYoNtlFWgejfzz/gnoLYVT6uqWFjasbiQQ3AKRSFetxW8V5ZRSc32GHUPPykkQNwKv
         umLw==
X-Gm-Message-State: AOJu0YzBQIO7j+Vn937cQWwRDBMU5vviGw+Own0dBeJ1m0GHUQQ9FKwh
        l3Q734BiN4YQEcZyxMMfPLk=
X-Google-Smtp-Source: AGHT+IFWH6/vpQQQrPWtk+4gn7HZfaiCZ30scpSfifzwcicOPVy2NCfcxIC4JcQe8368Ue6cKZL/aQ==
X-Received: by 2002:a81:5c82:0:b0:5d7:1941:aab with SMTP id q124-20020a815c82000000b005d719410aabmr5721824ywb.70.1702400660301;
        Tue, 12 Dec 2023 09:04:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id w204-20020a8149d5000000b005d35a952324sm336901ywa.56.2023.12.12.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:04:19 -0800 (PST)
Date:   Tue, 12 Dec 2023 09:04:19 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 2/7] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-ID: <ZXiSk9J2ZBdsTnk0@yury-ThinkPad>
References: <20231212042108.682072-1-yury.norov@gmail.com>
 <20231212042108.682072-3-yury.norov@gmail.com>
 <ZXgsDcM21H/2BTck@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXgsDcM21H/2BTck@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:46:53PM +0800, Ming Lei wrote:
> On Mon, Dec 11, 2023 at 08:21:02PM -0800, Yury Norov wrote:
> > The loop starts from the beginning every time we switch to the next
> > sibling mask. This is the Schlemiel the Painter's style of coding
> > because we know for sure that nmsk is clear up to current CPU, and we
> > can just continue from the next CPU.
> > 
> > Also, we can do it nicer if leverage the dedicated for_each() iterator,
> > and simplify the logic of clearing a bit in nmsk.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index ee272c4cefcc..10dead3ab0e0 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -30,14 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  
> >  		/* If the cpu has siblings, use them first */
> >  		siblmsk = topology_sibling_cpumask(cpu);
> > -		for (sibl = -1; cpus_per_grp > 0; ) {
> > -			sibl = cpumask_next(sibl, siblmsk);
> > -			if (sibl >= nr_cpu_ids)
> > -				break;
> > -			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
> > -				continue;
> > +		sibl = cpu + 1;
> 
> It doesn't have to 'cpu + 1', see below comment.
> 
> > +
> > +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
> > +			cpumask_clear_cpu(sibl, nmsk);
> >  			cpumask_set_cpu(sibl, irqmsk);
> > -			cpus_per_grp--;
> > +			if (cpus_per_grp-- == 0)
> 
> 			if (--cpus_per_grp == 0)
 
That's right, I'll send a new version this weekend.

> > +				return;
> 
> I think for_each_cpu_and() should work just fine, cause cpu has been cleared
> from nmsk, so the change can be something like, then patch 1 isn't
> necessary.
 
It works just fine except that it's O(N^2), where O(N) is easily
achievable. Again, it's not about performance, it's about coding
habits.
 
> 		for_each_cpu_and(sibl, siblmsk, nmsk) {
> 			cpumask_clear_cpu(sibl, nmsk);
>   			cpumask_set_cpu(sibl, irqmsk);
> 			if (--cpus_per_grp == 0)
> 				return;
> 		}
> 
> 
> Thanks,
> Ming
