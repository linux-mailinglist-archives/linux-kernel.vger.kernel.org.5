Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82B803F53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345476AbjLDUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjLDUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:31:51 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C2B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:31:55 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-42552cfee32so11615931cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701721915; x=1702326715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id0A3lPUtQng12VZaa5ELLdYETtg+mY4YWeeL/hdTB8=;
        b=cbhdkNjmP4c7ebttSktKQo9x1uibuNsK+64UIEQfBV4AllnCZNRk4XTqRpSgJCm91d
         jbo7DuAzgcAV//5DRbM3HNAepkAQU68EzQ4Um4xjyCAK1rjX6cnxqW1M9e2PHS4KA6LZ
         L+987kdZ02b5YsxPF5mizPuSnTPSdlFNqCls6w6ey9T4zrc/vJ3M9a1bkyWSZLQZBjCq
         Fa7IEnj8Oc6vXPS0J7M9oownvvn5NPLPf5/onNFq7KoFWaUthePo1mnlOzwDIapSPqSF
         GH1jS0xLPbNCRLRKi1pJEG76Hm2rNO/1XWMQ6U/+XYAWKFRK92OePpDxtkEYPxMQpcrr
         nVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721915; x=1702326715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id0A3lPUtQng12VZaa5ELLdYETtg+mY4YWeeL/hdTB8=;
        b=Un/iC0i6PrBNhXKCZFb86TPssqJhWg7sdgp4k+IQK+5tiOEOgRKCU65w+AlvCENwBM
         wsREUh1ClmtZbMaz6JKR8HcZXLkCGF8c8Q4LtKu50W6ODxH0XMpmOrDv9/xNGlhoRw/q
         uDrAOFuOdwPbUxofWEngEMsU0roHRpq4DBVRCkOK0pNA1qMp+7nsXoZ7aYLffx7OjT6V
         y8HcTrM9bhF5xNE+CHFl+1UFOtR8lYOS7ZN5c94HJnFgGQeDvax+6cm60fJMsRekb6J1
         d2YZoGRoIh3bpzfEYIg0skL+h9zrcjStSflF3jDIzjeiNa7kN6g2KoQ2pVA04NHGZ0K1
         4OBg==
X-Gm-Message-State: AOJu0YwImWOpC6ISRTTgG+BXiZAJAHTlCDDi7KR8Zk/M/bthV7y+xGjw
        qzZU1r2Ph6s82njwvMpo6pOBaE543YjWaIMHwwE+RQ==
X-Google-Smtp-Source: AGHT+IG9zqUF3niMJwuQ5C+wqvtP2tD3MC5Fp+mckTJdlEQhrXoY/Uh6svtdslAMunyoI0IBX/qfzNNmqoBPj/fYhEQ=
X-Received: by 2002:a05:622a:1749:b0:425:4043:5f07 with SMTP id
 l9-20020a05622a174900b0042540435f07mr192980qtk.69.1701721914961; Mon, 04 Dec
 2023 12:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20231130200900.2320829-1-pasha.tatashin@soleen.com> <20231204154614.GO1489931@ziepe.ca>
In-Reply-To: <20231204154614.GO1489931@ziepe.ca>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 Dec 2023 15:31:17 -0500
Message-ID: <CA+CK2bCbyO+rXpHJ0AN4F9nzqMKbMnN7g5J_O2dMJGKoB8dC7w@mail.gmail.com>
Subject: Re: [PATCH] vfio: account iommu allocations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 10:46=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Nov 30, 2023 at 08:09:00PM +0000, Pasha Tatashin wrote:
> > iommu allocations should be accounted in order to allow admins to
> > monitor and limit the amount of iommu memory.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > This patch is spinned of from the series:
> >
> >https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@sole=
en.com
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you,
Pasha

>
> Jason
