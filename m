Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC9758104
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGRPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjGRPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:33:27 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C91BD7;
        Tue, 18 Jul 2023 08:33:01 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-443571eda4dso1817855137.2;
        Tue, 18 Jul 2023 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689694363; x=1692286363;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFG0v+zWj5Us2ybIpEvaX66lFIHyK6OlaRxVcde7KSc=;
        b=R6LcQTBoQIabOw7L5lHt5phv0vDyNHm77UTipCuTD42Ayw1TnYZUoOyqq0hc3bqzj6
         DGEV0R3Mqrv8ospCkIBjX2hdqApO2SH+9YbrEparhmmisveiM9GB7QiP4gfOS0BKVoKn
         Z4z1+nJklvGNP5Ieo2EKojw1fg9WT5S4s32YUi0vJpPp4uZYGJoudXCV1uoxBCF+nVu9
         JFLumNwSQn+DFA0AY8HYqYDlLnck2pBVi1PDpnWik60kbCNfUhCpyeP7aptRMOOmiVbV
         7PVwBU4iVONMax780WJXgIJkx82uVtaa2HG4vUywJRGzMm7otUAUGtKAsRTC+36yDb06
         z+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694363; x=1692286363;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFG0v+zWj5Us2ybIpEvaX66lFIHyK6OlaRxVcde7KSc=;
        b=KjWdC4hr2HCe4aDsDQgv7/EyzWiShWnn1BHEWVxag9QIWUZK2/WDktS5UBa0twXLrI
         Voq7gtpbG7tSMtBnr6GKlgFNX0BbRBwdU1zuDryXxil6ozsdbhhTn4gYTlCpEDhddEA5
         5NqISme6YUFw8Vk23HYSOj9Gfj56UYIXGmudzpqsFgtPO2R+YCxOnRmCULJwusAseiNa
         XcTU2Vijwlzg7ek4dyuWNsUzksNN2zMIIefXTAziiL7tokysG+oyK27ffRGnHDMPLs2d
         02dp1udBxHCG9U0Luizbvl5aoTsKJyXNboO6C8oTc92WzRHyIjUeamA6aVbbbq4+/zCb
         rJQQ==
X-Gm-Message-State: ABy/qLaTzJnwlclX+S+Ddd9Eha/gqGQMpkS9rBuaM9Gk1Lw+mMOTXIGS
        g12akjzq5j00vWfezjuUGoaXyeguSGCNbNXPM6Q=
X-Google-Smtp-Source: APBJJlG7xhqmpvxA2a+d/nPoPsxZ8VwdP+RJ8Vg09AHQMV/eROqDtj8rPx+KlPXhR4ivwS61JGW5IvVwcNOD+PjnkvE=
X-Received: by 2002:a05:6102:4ba:b0:444:ca59:57a6 with SMTP id
 r26-20020a05610204ba00b00444ca5957a6mr8743768vsa.8.1689694363020; Tue, 18 Jul
 2023 08:32:43 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 18 Jul 2023 17:32:32 +0200
Message-ID: <CAJ2a_Dd-piQ51dqptuhJ8pXm+4HrFAcdbA-ESd8YwNO3qHnJrA@mail.gmail.com>
Subject: Re: [PATCH] security: keys: perform capable check only on privileged operations
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-21 at 02:04 +0300, Jarkko Sakkinen wrote:
> On Thu, 2023-05-25 at 17:25 -0400, Paul Moore wrote:
> > > A minor inconvenience is the number of needed arguments (and the
> > > actual code after inlining should be the same to the inner scope in
> > > the end).
> >
> > Well, lucky for you, Jarkko and David maintain the keys code, not me,
> > and Jarkko seems to like your patch just fine :)
> >
> > Jarkko, I assume you'll be taking this via the keys tree?
>
> I just picked it and mirrored to linux-next.
>
> I think it is super important change because it tones down the human
> error (a little bit at least). You could say improves user experience
> kind of I guess :-)
>
> BR, Jarkko

Kindly ping; I do not see this patch applied anywhere.

Regards,
       Christian
