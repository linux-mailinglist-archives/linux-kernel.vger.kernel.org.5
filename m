Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0147A5217
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjIRSeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIRSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:34:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F810F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:33:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0e7e3d170so22735ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695062039; x=1695666839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKTgwH+a7GA+sqcUVWql5MlsB+4X33g9465h/429Hc0=;
        b=eY+SONDkdvjVZnQUD/Fa+usiIdFmyQ3XnUt5s4HnxwXaL25VjpVDGr0KgPf9jWnGpa
         /45Rl1e1IzZtlLB+k5mV0BpXO9Lj/puMycaKLhJlDYXlThLov54Vt/NhiOD6TCC+NeB/
         cDX4KClRmgmsd/ssbribrZPW+LjyPV1ur46ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062039; x=1695666839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKTgwH+a7GA+sqcUVWql5MlsB+4X33g9465h/429Hc0=;
        b=xDE785RKdK7bT+vX93c5dQtr//Ty3hW4iiKmp1mrpXa79I27m9NXYgXPGdeC1i9Pbw
         hS6wvCF3ichSoOKHodnq5tN5TssV+WsdMsRE/HQlpFfU2AypDR4aawhvDu3tXAvFrgtD
         rByywMdwUGon+4hVzz5SvTVL1e7KjdhIAgDmpU/bLznBRmotX4f0CHlTjwUPExH68l4A
         mgbQYCi3xtx2744J9yIfbYT83U9wjOFjshELhMSyHfnlJJE7KDeqIepjw2+88bO9e0XT
         N7P7UDHXxvVCP30AVvTPuwTKIwrlJDQq2pa2Y6EM/YOie3amrLqSbtNBCuql0VCNetiq
         nKog==
X-Gm-Message-State: AOJu0YwImlNyJC+aXtIrrjRa1jr+q7N1AeYLwhjtd7L6zgHUrzBmTOMo
        SQyU3fPbdZDvDB4MyOql+bzojPjkliMrjRW3dlf7bQ==
X-Google-Smtp-Source: AGHT+IG9iiAMseb4ZhGyHZ3N9oA8N0efd7OyAIeu0TwA2wzqNBLYcNnR5qYso1PzbWQf4f8ZoUvyOG8za+GE/Uy6LvY=
X-Received: by 2002:a17:902:cecc:b0:1c5:59ea:84c3 with SMTP id
 d12-20020a170902cecc00b001c559ea84c3mr17897plg.21.1695062038771; Mon, 18 Sep
 2023 11:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230606035442.2886343-1-grundler@chromium.org>
 <4fa1e0fe-eec4-4e5c-8acd-274a039c048a@ixit.cz> <CANEJEGt-6+AGGSdZb9OTv3UrBn1fFFqk=A6TdYjBsq4SqTTxsA@mail.gmail.com>
 <3c3f9a2ee7f9effe7cf9d1077652e85de0eae66c.camel@xry111.site>
In-Reply-To: <3c3f9a2ee7f9effe7cf9d1077652e85de0eae66c.camel@xry111.site>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 18 Sep 2023 11:33:47 -0700
Message-ID: <CANEJEGtSFAGEvKS0fJd_5OapXGeyWDZeJQYVZ7X_+wUOXBSK8A@mail.gmail.com>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as KERN_INFO
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Grant Grundler <grundler@chromium.org>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        oohall@gmail.com, rajat.khandelwal@linux.intel.com,
        rajatja@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 4:42=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Mon, 2023-08-14 at 08:40 -0700, Grant Grundler wrote:
> > On Sat, Aug 12, 2023 at 5:45=E2=80=AFPM David Heidelberg <david@ixit.cz=
>
> > wrote:
> > >
> > > Tested-by: David Heidelberg <david@ixit.cz>
> >
> > Thanks David!
> >
> > > For PATCH v4 please fix the typo reported by the bot :)
> >
> > Sorry - I'll do that today.
>
> Hi Grant,
>
> Is there an update of this series?

Sorry, while I had good intentions, my work has completely derailed my
attempts to make time for this. :(

I'll give this another run.

I'm also not offended if someone else picks this up and improves the situat=
ion.

cheers,
grant

>
> My workstation suffers from too much correctable AER reporting as well
> (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
> Generate Correctable Errors" and/or the motherboard design, I guess).
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
