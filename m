Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1FA76EF30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjHCQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjHCQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE230C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691079218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBGgPFoZzZurgnvdLr2MN4Fp3sMcoIPkqmKxp6vR8Tk=;
        b=OaEUAdm2ZBPfMQuFubVxwTt801x2nffLCOcg3J90JvTxz6+FC3JFKAdDhMPp3+IZJvOVNa
        JEty4vYM93xuRcuvCFdltXgIw2Oofgd/ulDripzSEcKrtiW24Nmv9PM4Xq5pFalTzlz/UV
        PwpTBO9n0Ruu/FkfArOy4/ukApRjLMg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-2uw0WLnIM3ypBK4a4JqNLA-1; Thu, 03 Aug 2023 12:13:36 -0400
X-MC-Unique: 2uw0WLnIM3ypBK4a4JqNLA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fdb989957so12988331cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079216; x=1691684016;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBGgPFoZzZurgnvdLr2MN4Fp3sMcoIPkqmKxp6vR8Tk=;
        b=BkyFVitDWd5OAC9QVamDIT+GcXSxFV9kQC6wC8ys8FX7GgTARRAgLozcr4AgH5MNO8
         Gki6CiOmIMc8o36S+N5KEz4rQNLIEWjRt0+d9nxDGiHYyEj9jzWj3KEOPrmUDgl+iWYz
         LOBeBzpU9nFkdlDT/VWMf+fClApeGwW4s4LeVDypC3sESkZ7FVyGK64wY+qRBu74YL9G
         E94KBD/endujis4HVbTgmc5EUMimGc0Ncj2qZ7dbV5eb99laOx0WB9KiF42e7sIH2NzC
         oFfIw22obF+xlliubs7q78GXKFOY6cKgAwnbHXTejgbSE2taT2HjcVOQIvc0PFLfcZaO
         pxIw==
X-Gm-Message-State: ABy/qLZ33935LgO7DQMs6vAsbI7dXZuPZ+Vo6RAJOW08FYoyyZvjHqJo
        JeKT7fCOE4qu5hiAeXXMzwvhrX2pYINL7nlHXFpmc7cJ3WvUINQyzAFbnVbtk+gdd0iNVOcpEIB
        zpVwmSOqJt+X4Kvq4ylBd2aI2
X-Received: by 2002:ac8:5fca:0:b0:403:3583:68eb with SMTP id k10-20020ac85fca000000b00403358368ebmr24199813qta.19.1691079216162;
        Thu, 03 Aug 2023 09:13:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3VdgGbifhJIhxq1FGS+26MJbVd4+Viv/OOetM8WvY43XGRx4v0KOquoaKU5NzhJrJGpt3Vg==
X-Received: by 2002:ac8:5fca:0:b0:403:3583:68eb with SMTP id k10-20020ac85fca000000b00403358368ebmr24199801qta.19.1691079215899;
        Thu, 03 Aug 2023 09:13:35 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id h9-20020ac87769000000b004035843ec96sm29261qtu.89.2023.08.03.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:13:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:13:26 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_basic false positives
Message-ID: <tqt5od6fuwid5qf2vjhkxef2swlccpki5oikx4pdoabyycrdpe@kzx2rpscvwgs>
References: <20230801135632.1768830-1-hannes@cmpxchg.org>
 <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:39:28AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 01, 2023 at 09:56:32AM -0400, Johannes Weiner wrote:
> > This test fails routinely in our prod testing environment, and I can
> > reproduce it locally as well.
> > 
> > The test allocates dcache inside a cgroup, then drops the memory limit
> > and checks that usage drops correspondingly. The reason it fails is
> > because dentries are freed with an RCU delay - a debugging sleep shows
> > that usage drops as expected shortly after.
> > 
> > Insert a 1s sleep after dropping the limit. This should be good
> > enough, assuming that machines running those tests are otherwise not
> > very busy.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I am putting together something more formal, but this will certainly
> improve things, as Johannes says, assuming the system goes mostly
> idle during that one-second wait.  So:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Yes, there are corner cases, such as the system having millions of
> RCU callbacks queued and being unable to invoke them all during that
> one-second interval.  But that is a corner case, and that is exactly
> why I will be putting together something more formal.  ;-)
> 
> 							Thanx, Paul
> 
> > ---
> >  tools/testing/selftests/cgroup/test_kmem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index 258ddc565deb..1b2cec9d18a4 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -70,6 +70,10 @@ static int test_kmem_basic(const char *root)
> >  		goto cleanup;
> >  
> >  	cg_write(cg, "memory.high", "1M");
> > +
> > +	/* wait for RCU freeing */
> > +	sleep(1);
> > +
> >  	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
> >  	if (slab1 <= 0)
> >  		goto cleanup;
> > -- 
> > 2.41.0
> >

The same issue exists in the test case test_kmem_memcg_deletion. I
wouldn't mind posting the patch, but it seems you want to propose
something more formal. Let me know your opinion.

Thanks,
Lucas

