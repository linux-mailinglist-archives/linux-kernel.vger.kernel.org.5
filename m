Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089B7F6191
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbjKWOeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14FA4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700750077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJ7Ki4jyK6CXGE03cStoDbMuXGPhHn+xPGZmYbAaox4=;
        b=hexg4HNFGBtv4hhRUJOOYdtgRyQwSKP8CMTHOBAg1KKGQG89SG9RodxBRh93yavwBWk3JV
        b+RnvM8iCa+HZKco7xOpoBFt3OtfhCosM0p2l99bUgtMkh7/YJ6FR5SbZwg8WAAyDHJUoj
        exCj/Yq3xq1xp5C3HvZrJVrUHckyuLI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-OVDu2MyKNjy1mi6Ay-g-BA-1; Thu, 23 Nov 2023 09:34:36 -0500
X-MC-Unique: OVDu2MyKNjy1mi6Ay-g-BA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a00d0011a3bso59556766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750075; x=1701354875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ7Ki4jyK6CXGE03cStoDbMuXGPhHn+xPGZmYbAaox4=;
        b=BcwZSSfB+WcW8mkKZNjGCf+tsmkPOHUtOxC2VA9ey/gYz3WFqyb2QbpDLNibyYTXCK
         S3e2izA94gT1487WPLRdH5je9Aw/2kN7hGF/R9MxDiluTNNKFjyDBqWb3ZnAHp+8oNT2
         ST6fAorLZ2eqcZRigLSn4HLgeRUtZOgQUnCk4FL8AZ+cwUmddHvjugVKJUzGpCys9v0D
         T1fxZYKFmrqUERCaIGWfgepn4A5c9pi2d+v1KGvh/quQ6vRslVOi/POxoFM7tFL4g21R
         tOVEVVfBwV9iovC8PKS3Hsdeyk8t2oN8dbbFmgOtzxwLx8vfUe2dEsnltMp3z2lZIL8W
         l43w==
X-Gm-Message-State: AOJu0YxrZ5PsEP/vi8srjEKqyTEm9s/h6tUw8gHRiB1Kh6Tjta8UvKF9
        h5QyOhj3l0Ska+nCkvNYKYZ7xmHBOCNw4a4fG7zKAeBXoUiaptZRBv/KK46FYaR/jZ9AqYdG7QB
        KtkJLhJH7QnvVn1JIK6kmskp39bpHOuc46ET/g/iW
X-Received: by 2002:a17:906:10d9:b0:9fd:8d07:a3ad with SMTP id v25-20020a17090610d900b009fd8d07a3admr4074583ejv.17.1700750075156;
        Thu, 23 Nov 2023 06:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJGIgYt3XV572SfRjarH9RjhlJNwD5AtR5SICWYkEEOs2fQ/XmS1ZzGbCjAF0HNd+6pHOl5+0CkBtgRGOD50s=
X-Received: by 2002:a17:906:10d9:b0:9fd:8d07:a3ad with SMTP id
 v25-20020a17090610d900b009fd8d07a3admr4074560ejv.17.1700750074891; Thu, 23
 Nov 2023 06:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
In-Reply-To: <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
From:   Valentin Schneider <vschneid@redhat.com>
Date:   Thu, 23 Nov 2023 15:34:23 +0100
Message-ID: <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To:     Eric Dumazet <edumazet@google.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, 20 Nov 2023 at 18:56, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
> >
> > @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int=
 timeo)
> >                 if (state =3D=3D DCCP_TIME_WAIT)
> >                         timeo =3D DCCP_TIMEWAIT_LEN;
> >
> > -               /* tw_timer is pinned, so we need to make sure BH are d=
isabled
> > -                * in following section, otherwise timer handler could =
run before
> > -                * we complete the initialization.
> > -                */
> > -               local_bh_disable();
> > -               inet_twsk_schedule(tw, timeo);
> > -               /* Linkage updates.
> > -                * Note that access to tw after this point is illegal.
> > -                */
> > +              local_bh_disable();
> > +
> > +               // Linkage updates
> >                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> > +               inet_twsk_schedule(tw, timeo);
>
> We could arm a timer there, while another thread/cpu found the TW in
> the ehash table.
>
>
>
> > +               // Access to tw after this point is illegal.
> > +               inet_twsk_put(tw);
>
> This would eventually call inet_twsk_free() while the timer is armed.
>
> I think more work is needed.
>
> Perhaps make sure that a live timer owns a reference on tw->tw_refcnt
> (This is not the case atm)
>

I thought that was already the case, per inet_twsk_hashdance():

/* tw_refcnt is set to 3 because we have :
 * - one reference for bhash chain.
 * - one reference for ehash chain.
 * - one reference for timer.

and

tw_timer_handler()
`\
  inet_twsk_kill()
  `\
    inet_twsk_put()

So AFAICT, after we go through the hashdance, there's a reference on
tw_refcnt held by the tw_timer.
inet_twsk_deschedule_put() can race with arming the timer, but it only
calls inet_twsk_kill() if the timer
was already armed & has been deleted, so there's no risk of calling it
twice... If I got it right :-)

