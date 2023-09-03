Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F0790A88
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 04:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjICCDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjICCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 22:03:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE5138
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 19:03:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c3df710bdso225897f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693706619; x=1694311419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGDSQJiXQuoyWps/ytd/2WoWtJYP1mDXQdaj2jxTaeg=;
        b=dLMQrH/8OwZlxhwU1EibFBg03eD6pe2Z3+LrC41KcQwMmaAdAdPSe7dhgaNDQvT7Mv
         jyP6FrqV78hYpHUtlwU1mC4E7FgdMRRW1rRbT1qUyuhllzlK1Rj5YOhGnCjptHHA6sJz
         /hZwfF4haFBCtkLeSAVAhGXIFM1sjf0XquByk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693706619; x=1694311419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGDSQJiXQuoyWps/ytd/2WoWtJYP1mDXQdaj2jxTaeg=;
        b=dSK1t1o+v6POZTz8uC8UiMDsjzOsqxCHrk/cr7m6tRAsrIi9QdjSIwDQZwXHgUVJ9z
         OmM5TYJuXWAmsuEBAYLDK61X2lK0cREaCcNbr3J/zFbM2b8o0gNLa2gt6IaaHOT0LAZb
         wifeO1V4mrVgFAfSHR2HBfHOSV7TQ76VLbKl9PxeF+xYHUU819AIntg/6uDLfj6UBkmR
         Ejik0jbPJG7fVA9ffSV+OANgTTbAwi6JkRWaLE33bZgm3Elpftt/FjmJ6wj/ZKb7wGq7
         vZogE6wEphWvZ+Eh2iRq5r+GUDhlszKatyykn9bbpCYnKnO51mZee8lLLOdhtPq3k5BL
         FyZw==
X-Gm-Message-State: AOJu0Yx1SOfCfLtNdKL4gs7Sq7bOOtq9U/4nnijdhFqjw2MA6hJ3Nvda
        yeOtgTTMnynGDqWs+aGYWd1FrX53p+5+B4PT0pHpnw==
X-Google-Smtp-Source: AGHT+IGQsIsQewNGMCxECvHe8qzSJVIhzfT9nCmpKPZkBWgm+NlAYIiR8ejmECFslO7nvNY8+QSayp+yc9vuJD8tiT4=
X-Received: by 2002:adf:ebcd:0:b0:313:eaf5:515 with SMTP id
 v13-20020adfebcd000000b00313eaf50515mr4322055wrn.6.1693706619010; Sat, 02 Sep
 2023 19:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org>
 <20230830110402.386898-2-joel@joelfernandes.org> <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
In-Reply-To: <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 22:03:28 -0400
Message-ID: <CAEXW_YQB4qahh4FZrtw3AOsxwRw7-Bd1YXULCBOE2K9j81Oqag@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu: Dump vmalloc memory info safely
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 9:28=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 30 Aug 2023 11:04:00 +0000 "Joel Fernandes (Google)" <joel@joelfe=
rnandes.org> wrote:
>
> > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > memory info, if the objects is not allocated from the slab allocator,
> > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > need to be held, since the call_rcu() can be invoked in interrupt conte=
xt,
> > therefore, there is a possibility of spinlock deadlock scenarios.
> >
> > And in Preempt-RT kernel, the rcutorture test also trigger the followin=
g
> > lockdep warning:
>
> "possibility of deadlock" sounds like something -stable kernels would
> like to have fixed.
>
> Did you consider the desirability of a -stable backport?
>
> If so, are we able to identify a suitable Fixes: target?

Good point, it should be:
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")

I am currently reworking the patch as Vlad was also concerned about
(the existing) issue of accessing vm_struct fields without holding the
lock [1].

I will add this fixes tag to both patches for the v3 on the respin.

Thanks!

 - Joel
