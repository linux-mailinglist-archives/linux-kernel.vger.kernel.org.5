Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA1806349
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376280AbjLFAQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbjLFAQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993118F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:16:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D9C433CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701821807;
        bh=KB2h573VWm7p5NE2V/A12yXhGDfVWtxxezLZetMV8EM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cUXTiceLGbO5lenVZeMmlWo7vqYqauEDVukhkO+OIlX+n3D42i2bqWUcnBqozO6XU
         7IYf1+ps/u/H1NiaE1OiWxZClyIV0+4Mjt2tGYpp7HDv7XaISi5Bb5HawwLkSr+9oR
         mACXKjaqBM/BVenr6cTyV8yRm2/huC+WqGIPZ+tw18vxO00rGeYH+AkfNAMJgghTOP
         XVDhFG1NZcX6nmt2DMcc6llm9CyDnGxUxOXs8WKNXyppSxGNsnm+iu5FM9oXPv61SD
         JeLXq5kDsXM+mFp7IOElJukd2Lp8AO81UTP/jHUaJxxPa2I9tdKWdf7Ur4JWAC1Dcz
         SXhHQ+u/HinLA==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28652d59505so4165052a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 16:16:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yz/Z/n0coKXgGBkzu7snCKYsTh2r0GZxE76ueHA2MA3b0mWArUy
        HMXxQs37j1PdeE7GCJL4LE6qx+QsqJS9oegQpNdK+g==
X-Google-Smtp-Source: AGHT+IHu5BtCSU0pVaHo7hstQQoCt4LP6AEcx7PGgCpGRGvVdybIR+82gCeElLUDiOxMjsGNu7AQ9eX7JuRo5PsoG5A=
X-Received: by 2002:a17:90a:19d6:b0:286:f166:679f with SMTP id
 22-20020a17090a19d600b00286f166679fmr91628pjj.49.1701821806793; Tue, 05 Dec
 2023 16:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
 <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com> <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com>
In-Reply-To: <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 5 Dec 2023 16:16:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
Message-ID: <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 5:39=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> > > memcg as a candidate for the global limit reclaim.
> >
> > Very minor nitpick. This patch can fold with the later patch that uses
> > it. That makes the review easier, no need to cross reference different
> > patches. It will also make it harder to introduce API that nobody
> > uses.
>
> I don't have a strong preference one way or the other :) Probably not
> worth the churn tho.

Squashing a patch is very easy. If you are refreshing a new series, it
is worthwhile to do it. I notice on the other thread Yosry pointed out
you did  not use the function "mem_cgroup_tryget_online" in patch 3,
that is exactly the situation my suggestion is trying to prevent.

If you don't have a strong preference, it sounds like you should squash it.

Chris

>
> >
> > Chris
> >
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 7bdcf3020d7a..2bd7d14ace78 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_=
cgroup *memcg)
> > >         return !memcg || css_tryget(&memcg->css);
> > >  }
> > >
> > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg=
)
> > > +{
> > > +       return !memcg || css_tryget_online(&memcg->css);
> > > +}
> > > +
> > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > >  {
> > >         if (memcg)
> > > @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct me=
m_cgroup *memcg)
> > >         return true;
> > >  }
> > >
> > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg=
)
> > > +{
> > > +       return true;
> > > +}
> > > +
> > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > >  {
> > >  }
> > > --
> > > 2.34.1
> > >
>
