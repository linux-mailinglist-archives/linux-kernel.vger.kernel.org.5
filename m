Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12777D5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjHOW2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjHOW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:27:55 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B5B1BFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:27:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c68c79befso4739247b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692138473; x=1692743273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kY8kU69GDJUJ7+R5pknqqvh2AZUBumVN8OS68K0+MY=;
        b=H7tXeonSCquKg5AN0QNsHMQVIBdXDcs1LV0ZUmVB53pLGrJdXGf9EVp1Rqrh7eYr3r
         D1+Xaa9DWahcxAYd/BfvH8gpW1EDGtuFb8rEIYX6rH4F+2OB0YA7fwlRuedLUhtuFG9f
         yhPEMGb+t3OkEAcRmsmB4oWuwBYGgUJE2WGhx2+Dww5M5ur0A/k2uSgE6wFIDMs9KwcL
         7KgwxczOlpCWWb1xuKrLXgncEPrjR5oH8mzxfIYCjrapBFEAYx/WOlnLDAxoSWH8C7Ub
         AMapce/two7o039ktZEDZGGYq3W5k0gIPiIrZMfGYWQ9LmMxVWgIaN4rLiweyKqSILNo
         Ukwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138473; x=1692743273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kY8kU69GDJUJ7+R5pknqqvh2AZUBumVN8OS68K0+MY=;
        b=kjtgGKUunOPAF8YU6rdAL87GF9TsdxX3pvkjHnSV5v/FL6u2NHUC1EHR2RjkcU46Fi
         77an29cwPKwpYj+UFF5oZYkqK4IIZU/7Z0jJ9opyzkQOX54MouSs8wXHo0STrSIaTbJ2
         0cicfV4IYNI9AHoCjt4h0nQNqEZOdRhkQnBydbmjP05jU647KslFXsdDE3TMIpMh9xub
         KvTUJwf1uoH0al8U5JQc6OJly/biPUeOPcc0/G/x2auhKYoo3qvYXq9tnbqRE5iWwind
         h6v21/s8ofh+n6oAZCAYEcyhthjcEO41pF5GJLGJ1W2Z1t9uOAzBM1+oKjW6CzBi7ch2
         /Lyg==
X-Gm-Message-State: AOJu0YxhutR7yJuadNp0jsS23OonWdIw/GnxPLM8RHaMyf5Nwjj2y6ew
        UmSApjoerNJbVFY6srP625DC1+bmNAOqUD19n9ff
X-Google-Smtp-Source: AGHT+IGDT9WCmFX3f04gJ9axQtaQzS0X8fIxSAPsF8jgsCRv6mq072IFO2z58cS3DS66MoOtzwvyZTBcIasZhjt+6s0=
X-Received: by 2002:a0d:eac9:0:b0:583:4e2e:9da0 with SMTP id
 t192-20020a0deac9000000b005834e2e9da0mr16525221ywe.1.1692138473661; Tue, 15
 Aug 2023 15:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230815205917.1504837-1-andrew.kanner@gmail.com>
In-Reply-To: <20230815205917.1504837-1-andrew.kanner@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Aug 2023 18:27:43 -0400
Message-ID: <CAHC9VhRRcMQhbobpGZy0ha3saOJ4Ke1CCnExKSJq1E2jXCU3NQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] netlabel: KMSAN warning
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 4:59=E2=80=AFPM Andrew Kanner <andrew.kanner@gmail.=
com> wrote:
>
> Recently I started to use KMSAN and found the warning in
> security/selinux/hooks.c which triggers each time I use the official
> guide to run syzkaller reproducers
>
> Link: https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.=
md#run-a-c-reproducer
>
> I'm not quiet confident what are the rules in security subsystem. It's
> not a bug, but a warning which is triggered by KMSAN for the argument
> of the security_net_peersid_resolve() which was not initialized. It
> will not affect anything inside this function, at least with the
> current order of checking the variables, which might eventually
> change.
>
> Please reply if you're ok with such not-a-bug fixes. Otherwise I'll
> just ignore this warning in my experiments with KMSAN.

I think the answer is going to depend on the particular "bug" and the
patch required to resolve it.  In this particular case I think the
patch is okay so I went ahead and merged it, although I did remove the
"Fixes" tag as the current code isn't broken.

In general, if a test tool dumps an error or warning for something
under security/ and you aren't sure if it's valid or if we need to
resolve it upstream, you can always send us an email and ask what to
do :)

--=20
paul-moore.com
