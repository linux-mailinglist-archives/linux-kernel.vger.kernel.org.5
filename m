Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F727DCBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbjJaLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbjJaLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25291
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698752187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+lL+Q2dnjvFrizecz2Z0hUXkvjCaGk0oW8++C5Yujg=;
        b=QdRimquENXUyOjz4keCe6yhedArM1jHh27oxb8CrkKKFMKTgeUOiOw0mzF4mKQi5C8qxVE
        AYySMLUjKlKergJ7PA7mYhIsnvwZK9PhhiJI+Y5qsP2gDgQyUJnHa0Ksnrq88Hvf9Yp9L/
        KYQ0FDYaP1uoskg59RHWVMyPh9PgdGU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-bhC_U1T6NqeP1TkXy9_sSQ-1; Tue, 31 Oct 2023 07:36:26 -0400
X-MC-Unique: bhC_U1T6NqeP1TkXy9_sSQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41e3e4aa311so67498361cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752186; x=1699356986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+lL+Q2dnjvFrizecz2Z0hUXkvjCaGk0oW8++C5Yujg=;
        b=fHArFvj82H6dI2UI5H3ux69T/rAy0vk149XiIocvyyPgS8g/ENAYwgNxtSl451I3v/
         UYdOVtXs0fCKbJ+ZKogNkPXcqdeKhkhhfStixDLnU46OQGmCLHNGrgPcJSp6LMiSZaRR
         Xo9SdZvRPPPIOhLg9o21SdfFECWbp+6TOYmRFfa1EXAx4BASBwvh0JUE6nhRT/8lI8A+
         4frMF4X4ksEZoKnsbhkNpMJh8e5ebA6R90TPrnKchBsTu3c6cPH9bZeMjGc7GzR6L+pu
         dYmbhyg0nu7PoY+eGsGT+obVGQZfI2iSW76E4jB2UpD2h6v5Ue75KM4nlUZ11wKoVXmU
         6bug==
X-Gm-Message-State: AOJu0YxwWkGqPKh79grtFFJ1LrU2R7dGaoq+13LPwUU88UVlmBsAzyqG
        zFDGImxi+2qOpBJTXJyUs8yuCTMBrE7mhYhSDm6J3LckOUT9INbAZpYaljCSL60PYfEph1SMHfe
        aKVmenvIj6ASePJee9JP8WpGbJCTVjwk057qYZb/G
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id c7-20020a05622a058700b0041e1dffbed5mr14275936qtb.37.1698752186190;
        Tue, 31 Oct 2023 04:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8yZ+fxqoz8BLYpCiQtmPTJK1Gfi4emk9EK+fyGfYUrs1zHX9WUBWj45KuPPTBuKDsJ/teSu4Xv+EGBQDnRsI=
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id
 c7-20020a05622a058700b0041e1dffbed5mr14275925qtb.37.1698752185870; Tue, 31
 Oct 2023 04:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org> <20231007155957.aPo0ImuG@linutronix.de>
 <20231009180937.2afdc4c1@kernel.org> <20231016095321.4xzKQ5Cd@linutronix.de>
 <20231016071756.4ac5b865@kernel.org> <20231016145337.4ZIt_sqL@linutronix.de> <20231031101424.I2hTisNY@linutronix.de>
In-Reply-To: <20231031101424.I2hTisNY@linutronix.de>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Tue, 31 Oct 2023 08:36:14 -0300
Message-ID: <CAAq0SU=sWL8u5QwyzKS1osnRQDejx337HCz9kYLmiNeqPJvFXw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or optional).
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Come On Now <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 7:14=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-10-16 16:53:39 [+0200], To Jakub Kicinski wrote:
> > On 2023-10-16 07:17:56 [-0700], Jakub Kicinski wrote:
> > > On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > > > > Do we have reason to believe nobody uses RPS?
> > > >
> > > > Not sure what you relate to. I would assume that RPS is used in gen=
eral
> > > > on actual devices and not on loopback where backlog is used. But it=
 is
> > > > just an assumption.
> > > > The performance drop, which I observed with RPS and stress-ng --udp=
, is
> > > > within the same range with threads and IPIs (based on memory). I ca=
n
> > > > re-run the test and provide actual numbers if you want.
> > >
> > > I was asking about RPS because with your current series RPS processin=
g
> > > is forced into threads. IDK how well you can simulate the kind of
> > > workload which requires RPS. I've seen it used mostly on proxyies
> > > and gateways. For proxies Meta's experiments with threaded NAPI show
> > > regressions across the board. So "force-threading" RPS will most like=
ly
> > > also cause regressions.
> >
> > Understood.
> >
> > Wandere/ Juri: Do you have any benchmark/ workload where you would see
> > whether RPS with IPI (now) vs RPS (this patch) shows any regression?
>
> So I poked offlist other RH people and I've been told that they hardly
> ever test RPS since the NICs these days have RSS in hardware.

Sorry, Juri is in PTO and I am just back from sick leave and still
catching up. I've been contacting some QE people, but so far it is
like you said, no stress test for RPS. If I have some news, I let you
know.


>
> Sebastian
>

