Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E9793395
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjIFCMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:12:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD84DA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:12:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so338329a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 19:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693966366; x=1694571166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWT7++n+zVvklEefJPIi9Tys81Ri3CixU2e/UUrQWJE=;
        b=dcYJvzQU5HQHpKuukHSUZ2X6y7aleM5KPPddY1mIq51SakMHcQa37Yrz+No/IGTCoE
         1bnxTi1KI1Sbg5XjHlsCar1RUloMz6LH8yjggdbNfCYpbvuQ1SfhbWwsLYDl5gR7pocR
         KTNSuuQDolFhdQVth8OJ76LypPtm0eXb0Sk97aOZ6lJQKRNrnlONzEpkCNdwlgBNs4NE
         w+n6vUk+V0GO913GTjixTD2r++uvAeXpU6V1IVDirL7DKWbu3VoGnk4DjkniTnHSt1BA
         D0tjxRLovKTq4Lr5unycvio+Iu0pMUKZyhggBwcUfIUd98aFFe5LA5/sAFz5oTEJdmLB
         lQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966366; x=1694571166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWT7++n+zVvklEefJPIi9Tys81Ri3CixU2e/UUrQWJE=;
        b=MCqcQ/kfBHvAmJuyP5OlygTKK6kc3Iw8X4MhDuRI16ciGmn5WGTahaqw2C+WD3ABLc
         DWqBO7u8SvnH2x85md6XxxeyD51y1iaixCdLIrg3DfDsC2fPvt1IRR2VKdGYR7aTRB3u
         eoZNQ3EoXhc9Wf1xD52oiccl/hGq/ud8naOM2cE+SCfMQlHG+9RPeYic1vCxgEmf7YIP
         qXzAMMcYh5H+HIw25a3uThkc4F8Ooi6oLqtNpngs96bh6xkXV81O++Fj+jj/gjkA0Nbi
         wYl9U+2o1+0X6djdhDoAZeE4TSzYBe99r18CP1NuPCTggJ7MecWSqD3z3bR2dNhGqqIG
         skCg==
X-Gm-Message-State: AOJu0Yy3UD6akJ9fSvx3oLUSfuDj9sIAOK+CKReRqHSHrFgk1B46eOyj
        XDqt597FIglwgRbY9Wrv2G1swlECx0r6M7JeRh0=
X-Google-Smtp-Source: AGHT+IFGMArrBT3R6B505eGOc/DQvEfD9F0b9PyKfMMSWyavTM6rMFXrazbs1hAs7+aC4gCZ3U2yT7Ne9XfISEtY7+c=
X-Received: by 2002:a17:90a:9a87:b0:26b:513a:30b0 with SMTP id
 e7-20020a17090a9a8700b0026b513a30b0mr20134034pjp.10.1693966366409; Tue, 05
 Sep 2023 19:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com> <ZPd4yKqbvBNGV7cL@slm.duckdns.org>
In-Reply-To: <ZPd4yKqbvBNGV7cL@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 6 Sep 2023 10:12:34 +0800
Message-ID: <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello,
>
> On Sat, Sep 02, 2023 at 07:50:26PM +0800, Zqiang wrote:
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index c85825e17df8..f3f9c9222070 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4609,6 +4609,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
> >               free_percpu(wq->cpu_pwq);
> >               wq->cpu_pwq = NULL;
> >       }
> > +     wq_unregister_lockdep(wq);
> > +     wq_free_lockdep(wq);
> > +     free_workqueue_attrs(wq->unbound_attrs);
> > +     kfree(wq);
>
> So, this would fix the bug but it's quite confusing because we end up taking
> two separate error handling paths and alloc_and_link_pwqs() ends up freeing
> stuff allocated outside the function. Wouldn't it be enough to flush the
> pwq_release_worker after apply_workqueue_attrs() failure so that the cleanup
> operation ordering is maintained?

Hello, Tejun

Flush the pwq_release_worker is insufficient, the call_rcu() is
invoked to release wq
in pwq_release_workfn(), this is also asynchronous.


Thanks
Zqiang

>
> Thanks.
>
> --
> tejun
