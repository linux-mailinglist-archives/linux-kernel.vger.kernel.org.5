Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7B775098
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHIBys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHIByq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:54:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA11BDA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:54:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fe9c38800so39177911cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691546085; x=1692150885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPdHd3dHPLZ4M3JoFcie+26YcC9WO5uy2oLMLgktoeI=;
        b=OU3PSnnA00wAD10NZkfWd21vL8EzaIUAZtK+Qg7OMsNa9tJ/PkC4Et4gk6V+RsacaT
         QeYfVgRon03GTnp/cj88633IUJcgit8913i2Cw/86xL5dNLWc2Kt+e91+rTFBlFuVl5s
         tgEGB4vqxxiEqwsgIxq/FU8BRCr0yG0s67BkYJrLc1jNnOIIciBj32xh4Wd6WwhcXIq7
         RYd6+XFIM0zT8y2yxtidAoH4bmIFdVhIVDz7F5YbPhgJtS9IzrslMBinuvqfP15LVlJB
         6Sbkw8ZdCxShv1ceZeHFJqe9hrzKyOOuIyJeVS2dsmQ4VDHcQhD3pSwnHVScn+Wxo9Yb
         fDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546085; x=1692150885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPdHd3dHPLZ4M3JoFcie+26YcC9WO5uy2oLMLgktoeI=;
        b=ib+ae3NrCZq9IQ3VlsBCwz0mqSD7rvH1fsmwVO3APqIx46CCpb2M4mqa5YO7BLPLDo
         xkX0qXeIAL8mzX/rStt/DKdhQtsqBh52xJHL7j/rDa2frrAt8ycVKklk6v7fbc+G647d
         8prOOwleZTcwBBAmTFB+NHWnL1BVtKnFqfYoXh8y/quhIcFYSq/ehAMSHA/2I8JOT7WV
         7TjEpajtSpcgmxp1VX1SAaSHpdnomWBsq89LRq9zDBVPcdqwMlTnz0HQ37XvGuQPQhoC
         7o27y+a6BlB5K8jQyDFJVVe923Wf6U9xt0WfjG56rZ+5x32/NmtqQhp6fEHdkWRK9uxz
         extA==
X-Gm-Message-State: AOJu0YxjjZpjlP0k5MVlpIkhhSX6KgztEdeUuof3qyXr/4qmO57sQJOx
        T7cN0sFiHb0qZtSUb646XaeDHq249+Z3OldnXrDtLA==
X-Google-Smtp-Source: AGHT+IEYGschKJ5T3qO7w+VCCOczmPOzdCdurely6UZuaq78UNQd+9aB6v5d7ZiOrZpB79QILDgfYlosNVDERg0QFRc=
X-Received: by 2002:a05:622a:1309:b0:40f:f860:f047 with SMTP id
 v9-20020a05622a130900b0040ff860f047mr1903567qtk.56.1691546084960; Tue, 08 Aug
 2023 18:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072625.2109564-1-nick.hu@sifive.com> <20230808-pristine-celibate-60957ea523c0@spud>
In-Reply-To: <20230808-pristine-celibate-60957ea523c0@spud>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Wed, 9 Aug 2023 09:54:34 +0800
Message-ID: <CAKddAkA3giaG6kjcxsaA9c4TpemKThPyAzb6+Sv4ug7S7kUm=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sifive: Add suspend and resume operations
To:     Conor Dooley <conor@kernel.org>
Cc:     zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor


On Tue, Aug 8, 2023 at 4:44=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Aug 08, 2023 at 03:26:25PM +0800, Nick Hu wrote:
> > If the Sifive Uart is not used as the wake up source, suspend the uart
> > before the system enter the suspend state to prevent it woken up by
> > unexpected uart interrupt. Resume the uart once the system woken up.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Where is patch 2/2?
This was my bad. There is no patch 2/2. I'll correct it in V2.

Nick
