Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C078E0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbjH3Uag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbjH3UaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:30:19 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF4CFC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:28:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34cafafa50eso357315ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1693423602; x=1694028402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1jYqqYryQFVoqC0CvIasISxt5p5l9C337JF0IzaaeQ=;
        b=AR2B+O1qqsO7VhfIGlSNTCIlhPsRCyWk3wjRLJxgXGAdWxCSsTrD7WP9mzErnguHiR
         McFJMVVvtxum3pWex6KaBLUZIy6uXmblIJTt6ctafcmyDotq/KDj3V1SylFPEZNkUhgw
         npwV5CSqiVPxF66vUKpQuFgj7a2DU6k46IFvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423602; x=1694028402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1jYqqYryQFVoqC0CvIasISxt5p5l9C337JF0IzaaeQ=;
        b=TrXiok8wubg0cUrkB90y3zIV19m+EHkTEteivigXmxs8RXvocMPcavTTbUZ2om9HhF
         QIZDENHK2D7S7bZGa6Jf/RTsr4tL8pLqwL9mKRHW1N++qQlHslJg+yzbyMONJQRvQ6MT
         e0Hu86zUki+vCIi9C+6kAN6Z+844ZN8xdklo7Ric0KHs/Ht3e9hM5+N8HwVJUqX/N5di
         S5bPpYsGrZ73YQez7EU/UW/1zHbEDZq5bzZtmBL3sKyCFV0bmDUCtkiVZ71H92axwCfj
         HPEfHeSj3tnbAq56BEIKXq5Y+3Iy1agxf63fJHsMlRaLjDwQvlILJcR605QVDPLbNSQB
         Kqbg==
X-Gm-Message-State: AOJu0YyC8BDM9i48QyrO5Xqob+EwdVIC2gBg3wmEB3SL3OOoSuZgZCB1
        6IZWElixFEDaDvsh4NqOCKHiDaw907szROllmd8=
X-Google-Smtp-Source: AGHT+IEOQuaCPRSlM4hl/aNm6eNbq7glyuDloY1WGu09H10YoJhpVGz0OCCWbXl2tZAJMU+ICD6XIA==
X-Received: by 2002:a92:ce8a:0:b0:347:7421:9d85 with SMTP id r10-20020a92ce8a000000b0034774219d85mr3271193ilo.29.1693423602581;
        Wed, 30 Aug 2023 12:26:42 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:4be::79:1b])
        by smtp.gmail.com with ESMTPSA id m2-20020a924a02000000b0034ac1a32fd9sm3918084ilf.44.2023.08.30.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:26:42 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:26:39 -0500
From:   Frederick Lawler <fred@cloudflare.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZO+X75hK24e0Plgk@CMGLRV3>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <ZMHkLA+r2K6hKsr5@casper.infradead.org>
 <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
 <ZMJizCdbm+JPZ8gp@casper.infradead.org>
 <ZM0t8rYZewA3dO0W@CMGLRV3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0t8rYZewA3dO0W@CMGLRV3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Fri, Aug 04, 2023 at 11:57:22AM -0500, Frederick Lawler wrote:
> Hi Matthew,
> 
> On Thu, Jul 27, 2023 at 01:27:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 27, 2023 at 11:25:33AM +0100, Daniel Dao wrote:
> > > On Thu, Jul 27, 2023 at 4:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> > > > > We do not have a reproducer yet, but we now have more debugging data
> > > > > which hopefully
> > > > > should help narrow this down. Details as followed:
> > > > >
> > > > > 1. Kernel NULL pointer deferencences in __filemap_get_folio
> > > > >
> > > > > This happened on a few different hosts, with a few different repeated addresses.
> > > > > The addresses are 0000000000000036, 0000000000000076,
> > > > > 00000000000000f6. This looks
> > > > > like the xarray is corrupted and we were trying to do some work on a
> > > > > sibling entry.
> > > >
> > > > I think I have a fix for this one.  Please try the attached.
> > > 
> > > For some reason I do not see the attached patch. Can you resend it, or
> > > is it the same
> > > one as in https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 ?
> > 
> > Yes, that's the one, sorry.
> 
> I setup a kernel with this patch to deploy out. It'll take some time to
> see any results from that. I did run your multiorder.c changes with/without
> the change to lib/xarray.c and that seemed to work as intended. I didn't see
> any regressions across multiple seeds with our kernel config.
> 
> Fred

We deployed out the xarray lib fix to our fleet and didn't notice any more
issues cropping up wrt this error among other oddities. LGTM

Fred
