Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392497C47EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbjJKCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbjJKCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:44:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9439D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:44:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00df105f8so81021301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696992268; x=1697597068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfP08o9WTgZjhnwYY2YMLugpyMhSldsfMjRLs/4Yykg=;
        b=yW9to4aKDgZfl4xIZ7nkTwbAKhoMLZKkyxQsc2hysKZhmWQ8ItX/Fy33Mi9bxjm+aJ
         st+cQ0HlZrVzq2agUR2PeJOwg4BrE70aoEhCLRj0hzZrBC1zITtEuk/efeDMmxA8ucKa
         6ox962xpE5BS1m4cwTmIR9FmqU+pklgL80Pt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696992268; x=1697597068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfP08o9WTgZjhnwYY2YMLugpyMhSldsfMjRLs/4Yykg=;
        b=h5xPnUkAC5uQy1InUzF+UCAMtVAY3QIxNj6ZeplkAB5ksDCvpskwacoHK60a95R5by
         9YTSncWFd2FQs5noFKYscRKiZPfkdijwgIdGke59xfF9gB+/ffwWT+q/CRpLSC6Gn1yg
         sNVEb5FTYLiyYmv1pAwwi9PxhpsFUVUc3YNokOtX4uaEe2AAjowfOBIozTRATgOQTbSO
         Wlu/XUD0HyvOYLZspEVziG3L1wL8ARRKua4ryIzZm9FWQ7IAPkBuyKd8VN6xMn6xz76v
         VgSgTgXlsY/ogpQXNSWjZ3h1o3u3tDF0WJHcftJoTaUSWkLw+yh7GBaa6UnIqtzq+aU6
         i8+A==
X-Gm-Message-State: AOJu0YyNjoeyiXSFRJ5EyHiKplfeSscAvWCdzoSYSGJj6Apk0SXYUZvU
        HRzBPpOihrEfP5YmdnlUVufe7/veNiXNCOiFL6mPRQ==
X-Google-Smtp-Source: AGHT+IEjH14ZTyGUyfXOqAvZB6QgDxtkcp+eg2meOjmZxrUxcG6Y3RJwEU1Sg/YDewrwZkZ+eJ1n9IM63GXFrkK3u1k=
X-Received: by 2002:a2e:a1c6:0:b0:2bd:1fee:aacf with SMTP id
 c6-20020a2ea1c6000000b002bd1feeaacfmr15567601ljm.24.1696992268077; Tue, 10
 Oct 2023 19:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175203.943277832@linuxfoundation.org> <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver> <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
 <20231006175714.begtgj6wrs46ukmo@revolver> <7652477c-a37c-4509-9dc9-7f9d1dc08291@paulmck-laptop>
 <CAEXW_YS16NxPxg52T=3FcyZ2qocj36zKyhPnEQL3nBTbD-qJ-A@mail.gmail.com> <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
In-Reply-To: <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 10 Oct 2023 22:44:16 -0400
Message-ID: <CAEXW_YTYzoAfOcgYA-N7VJYJoZTVX2=GtDrZc19RXoAXidbvyA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
To:     paulmck@kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 9:20=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
[...]
> > > > How frequent is this function called?  We could check something for
> > > > early boot... or track down where the cpu is put online and restore=
 idle
> > > > before that happens?
> > >
> > > Once per RCU Tasks Trace grace period per reader seen to be blocking
> > > that grace period.  Its performance is as issue, but not to anywhere
> > > near the same extent as (say) rcu_read_lock_trace().
> > >
> > > > > > It's also worth noting that the bug this fixes wasn't exposed u=
ntil the
> > > > > > maple tree (added in v6.1) was used for the IRQ descriptors (ad=
ded in
> > > > > > v6.5).
> > > > >
> > > > > Lots of latent bugs, to be sure, even with rcutorture.  :-/
> > > >
> > > > The Right Thing is to fix the bug all the way back to the introduct=
ion,
> > > > but what fallout makes the backport less desirable than living with=
 the
> > > > unexposed bug?
> > >
> > > You are quite right that it is possible for the risk of a backport to
> > > exceed the risk of the original bug.
> > >
> > > I defer to Joel (CCed) on how best to resolve this in -stable.
> >
> > Maybe I am missing something but this issue should also be happening
> > in mainline right?
> >
> > Even though mainline has 897ba84dc5aa ("rcu-tasks: Handle idle tasks
> > for recently offlined CPUs") , the warning should still be happening
> > due to Liam's "kernel/sched: Modify initial boot task idle setup"
> > because the warning is just rearranged a bit but essentially the same.
> >
> > IMHO, the right thing to do then is to drop Liam's patch from 5.15 and
> > fix it in mainline (using the ideas described in this thread), then
> > backport both that new fix and Liam's patch to 5.15.
> >
> > Or is there a reason this warning does not show up on the mainline?
> >
> > My impression is that dropping Liam's patch for the stable release and
> > revisiting it later is a better approach since tiny RCU is used way
> > less in the wild than tree/tasks RCU. Thoughts?
>
> I think that this one is strange enough that we need to write down the
> situation in detail, make sure we have all the corner cases covered in
> both mainline and -stable, and decide what to do from there.
>
> Yes, I know, this email thread contains much of this information, but
> a little organizing of it would be good.
>
> Would you like to put that together, or should I?  If me, I will get
> a draft out by the end of this coming Tuesday, Pacific Time.

I apologize, I haven't been able to do any real work as I was OOO for
the most part due to dental issues. I am about 25% back now. I will
review your other email writeup and thanks for putting it together!

 - Joel
