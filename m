Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25CE78DE03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbjH3S4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbjH3NJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:09:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A6124
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:09:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so85132791fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693400979; x=1694005779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UTTWFj2vKP575z4DigdGNUxxYXECz/tkiCbjV/NlsQ=;
        b=YEfqzUX0PinnIG6JUOKqSyJ+a6Whay2re+eB/UNZwI9oHf6bzX1gYrTSfY3h8ky4Yu
         cM2vkklpamm6PVzujlpyKbniUoNCdGF9uL4RzsNGTC81JWsAczAwiBYM4x7lH7UluLzZ
         HClUXv9ayTk3BVaHDfpgeK2JtVCuwIlYXSoS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400979; x=1694005779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UTTWFj2vKP575z4DigdGNUxxYXECz/tkiCbjV/NlsQ=;
        b=fffMUEqR8b0Ndy4wx0Pqcv/ggTOj4+pMNAL2Pccmm0QoIGzcJU51MWc5VifdVLepp9
         2zZDiqNrg5bKDjeecsx7MjemGFG969oEC34gPnquJsJYRrUlrvqN8Ta3gH0/6bOUS4cn
         IV7ATy5RNkPPqiRy32Y3j5yqZwLOz4c0DE/uISfQctOz8udGAC3DqKYnigsi+BjHe8sc
         GXjr/9br26e7mRM4D5SZ06W3mBIHbnYzoLKNfz4X9nP8TbkHtOfs4F44pe+2hwza9vSB
         piqWnZIXMmGS637ShVnhchtkGVBxWJ/7Ff24IGu45N5wE/9CQDBbJ707+9T/UJZXhy3z
         SggQ==
X-Gm-Message-State: AOJu0YzUNOCGFGiXhmEyImbvO7Wq9k/q1DdRo5+5Djt9oTLqxdYBr1y3
        EMeTofKByAoFzzdf7L0RC4s41sVwIYMuyaiY8ke5/To1NfS4Ps7kOhs=
X-Google-Smtp-Source: AGHT+IFug5Pn0iCtcHTxdYxtn/dxRL6m7q37tl1uS0fITM+sBu4ZDYI6ADuJFmJtHXSl++R49UIn01Vju8rKW4euhUs=
X-Received: by 2002:a2e:7308:0:b0:2b9:ee3e:2412 with SMTP id
 o8-20020a2e7308000000b002b9ee3e2412mr1914441ljc.22.1693400978045; Wed, 30 Aug
 2023 06:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org> <ZO86ik6QWamW2u/j@infradead.org>
In-Reply-To: <ZO86ik6QWamW2u/j@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 09:09:27 -0400
Message-ID: <CAEXW_YTkejk872nJYTZ0HtMYLRswOjSPJyFz=HZjLKWUmy9GPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Aug 30, 2023 at 8:48=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
>
> Seems like 2/2 to actually use this is missing?

1/2 itself uses it.

And then 2/2 is here which does additional improvement courtesy of Zqiang:
https://lore.kernel.org/all/20230830110402.386898-2-joel@joelfernandes.org/

I used git send-email with cc-cmd set to get_maintainer.pl script.

thanks,

 - Joel
