Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D975B7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGTTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGTTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:22:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C388D171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:22:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso75941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880959; x=1690485759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacBuQPmaTbg0zMPyJfZlxsv5lt3ViODtkIRDulzhHs=;
        b=E/1t3ntk/ROfOq0NxRVzaZGOQmS0fbflKbT5fuUtIrEPWVe0msQz4PFZdmoKFgoT+K
         4hdX+Vr+qjYB/H18OSNxVOeX+fnRWnwnauDd01Wdvzy07Ih88dpkXC17UPwwt3Uajxg+
         OOCiBtSo+KvcPWxuzYHJ2+D9XcSMuhwBLf0RYWW5lwMyzGZIDyfdxoDNA9fygY0yW4Ky
         oWbiHGY/k8ALT7xqHaZRqdYzMB49y9lH0cg5qejymAa01RK3tZpszbJvgZblNhFd9VdV
         2/HdHxEKMGWwcg7BsBhlPoZKHTQc5W2hdO51RwBzDQJ6TOA7/+MNQu76+XIA+FMvOiVE
         tQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880959; x=1690485759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacBuQPmaTbg0zMPyJfZlxsv5lt3ViODtkIRDulzhHs=;
        b=N+Xl6/ceQTo2EThsqYjX3skp8TkMUe7C/PJGSXu73sZV5H2kybo6VM3GeCLTHVSBhD
         iWG5QCXoDOxohS6raTGJdTENcjXOVImJayfMVYOHrcoOXOisXJwdZalcmT7rFZxMDFLr
         u89Q5c5oDrKQd9JNHowS730nB4yn5GLLeY7X0Hh3NvmjWhSYDLm/6h2X3t/XZMXiDMTp
         FW/u3aPfSig0p/cF6sxHAFb80xiEPdDQ15LOBVlJUvGP3I9E4iwhMoY2E/Dg3a8PCfuW
         PpasH6X1fjrvixI43yyggXWvtF8FlAhJBdLKZ+aBaQWb14paBGBRF2A0rACRrubY9NxW
         ZjSA==
X-Gm-Message-State: ABy/qLY7xW7orZU2IS08Igk4a8kZZ6/aPfnrqbbOK7e4PZQm+qpSCitj
        9Fgf+Uu77x++lRnMkKhuMkfqQRdB15KGjf8qbN003Q==
X-Google-Smtp-Source: APBJJlHr3QDZlQT/T2FTm6Y0rEg87Rb8pyQFJApkDLa5645mm6jQKvaBY3GDo3mFWO1c+f+tQBuX9l568tX79MbGhfU=
X-Received: by 2002:a05:622a:14c7:b0:3f8:5b2:aef0 with SMTP id
 u7-20020a05622a14c700b003f805b2aef0mr36407qtx.24.1689880958746; Thu, 20 Jul
 2023 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
In-Reply-To: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 21:22:27 +0200
Message-ID: <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmail.com> w=
rote:
>
> Hi,
>
> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first ite=
m in hlist_nulls_for_each_entry_rcu=E2=80=9D)
> and a related discussion [1].
>
> After reading the whole discussion, it seems like that ptr->field was cac=
hed by gcc even with the deprecated
> ACCESS_ONCE(), so my question is:
>
>         Is that a compiler bug? If so, has this bug been fixed today, ten=
 years later?
>
>         What about READ_ONCE(ptr->field)?

Make sure sparse is happy.

Do you have a patch for review ?


>
>
> [1] https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glapto=
p/
>
> Thanks,
> Alan
