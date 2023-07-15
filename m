Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D86754CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGOWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:31:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84151993
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 15:31:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b3273074so14156601cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689460297; x=1692052297;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7MgboZx90jF0EJSqAzzEpTDlebQzsGpE8n/Cdx0a74=;
        b=b8RoTGCX7eaGsMYVj+LzjQRa5iRr8pH1/hQn+GKXAUnvQJIof5tsqtklxPOJNDVIg0
         VpbTwd9/4wauLBMt23b0oGTpvFfSz87nAWvqKNwwvLN/lb3twp62h1/QSiaKZAMm+8v7
         LkO/Luc+aICKNj6PvQVG+T08PYZIHxkbItTLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689460297; x=1692052297;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7MgboZx90jF0EJSqAzzEpTDlebQzsGpE8n/Cdx0a74=;
        b=kHty71/lkMPHFaDHbRp2uc512DCjX2JIb91c0zjBj+qDRhKAOcu06uhNt5ivBaMsUs
         EBavyyO7cktY0J9/0RRFrLILMTPlJhW4/RQo73Y3YFzcQUjEvF4cz61R4/VP30nL3tlq
         n3QTj5feNgPA59sic/Qzd/fU31qVVR6m2igj0tC4XuT7ckLOLZIIFE9geM8z1X5aIXW7
         klZb2LWrcXiOMAMVAZEGqiZGrsU03O2O7d81Ra2ei/+2Ad5BEhuVpVhGziXGwBTvpB/1
         r5OW3WwdjOfDqEjPGv6K5eR08pLTOp/wmwoAlC7BnFS3OFnViOGb6dAMShfkANUOc2E7
         YfQg==
X-Gm-Message-State: ABy/qLah4lGAM2Xn6NO9uf7J/T77tUOECFR0+ct2WAB/UnYdIAh9kBmQ
        ArIO35QaNYJ8gmvDC70D1stXvw==
X-Google-Smtp-Source: APBJJlFDWefjne9OHPac+LhYYpgi6Jym6LotxaBYaQbtFTensvWPHySO/TO+XMqHCR2nH17/ejWfoQ==
X-Received: by 2002:ac8:5ac9:0:b0:400:9f2c:1211 with SMTP id d9-20020ac85ac9000000b004009f2c1211mr8970043qtd.29.1689460296808;
        Sat, 15 Jul 2023 15:31:36 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.143])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05622a228e00b003f9e58afea6sm5097446qtb.12.2023.07.15.15.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 15:31:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Date:   Sat, 15 Jul 2023 18:31:24 -0400
Message-Id: <D077B8C8-41EB-4643-99A7-CA54F314218F@joelfernandes.org>
References: <ZLLjEVxM+kf84vgI@lothringen>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <ZLLjEVxM+kf84vgI@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 15, 2023, at 2:19 PM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Fri, Jul 14, 2023 at 09:02:43PM -0400, Joel Fernandes wrote:
>>> On Fri, Jul 14, 2023 at 8:01=E2=80=AFPM Frederic Weisbecker <frederic@ke=
rnel.org> wrote:
>>>=20
>>> On Fri, Jul 14, 2023 at 02:44:49PM -0400, Joel Fernandes wrote:
>>>> On 7/14/23 08:08, Frederic Weisbecker wrote:
>>>> One slight concern here though, where in the idle loop is the removed
>>>> statement "tick_program_event(KTIME_MAX, 1);" happening if the tick was=

>>>> already stopped before? If it is happening in tick_nohz_stop_tick(), do=
n't
>>>> we early return from there and avoid doing that
>>>> "tick_program_event(KTIME_MAX, 1);" altogether, if the tick was already=

>>>> stopped and the next event has not changed?
>>>>=20
>>>>        /* Skip reprogram of event if its not changed */
>>>>        if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
>>>>                /* Sanity check: make sure clockevent is actually progra=
mmed */
>>>>                if (tick =3D=3D KTIME_MAX || ts->next_tick =3D=3D  [...]=

>>>>                        return;
>>>>              [...]
>>>>      }
>>>=20
>>> Sure, if tick_program_event(KTIME_MAX, 1) was already called in the
>>> previous idle loop iteration, then there is no need to call that again.
>>>=20
>>> Or am I missing something else?
>>=20
>> Just take it with a grain of salt but I think you need to still call
>> tick_program_event(KTIME_MAX, 1) here for the case where the tick was
>> previously stopped, and then when the next tick fires (say after a
>> long time T), but that tick is a one-off and does not result in
>> restarting the tick -- then there is no one to call
>> "tick_program_event(KTIME_MAX, 1)".
>=20
> I'm a bit confused about that one-off thing. What can trigger that timer
> interrupt if it has been stopped?

It is the tick that has been stopped in this scenario.
The timer could still be armed to serve a future hrtimer?

I think the naming in the code for is a bit confusing for tick vs timer even=
t,
so I could be the confused one.

Thanks,

 - Joel


> One thing can happen though: a pending timer IRQ while we are stopping the=

> tick (IRQs are disabled in that idle loop portion). But then that pending t=
imer
> interrupt is not going to reprogram another one. So it remains stopped.
>=20
> Thanks.
