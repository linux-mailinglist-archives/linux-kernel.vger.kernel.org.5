Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18A78DC39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjH3SoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbjH3MRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:17:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A91B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:17:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so84315831fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693397850; x=1694002650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D8Njhns0o4ZXlGI4JVLpfsWYsYkQtkNq/+nuGr1lhk=;
        b=sPUBDGG+Wu6dU49eF5DfJhUY+bvvTY88SzbQpheSYYWdNaNqb5cDcGnhi+1uyXNa6+
         QkUmtmZ9+vYlM86YvhfsDfU5Ld5+Bk6I6etE3Pc280NGQSLpiI9JUTOq9DTTjR0e8q52
         ta3tsbNo4XvI5PIe35A2ypw6Lv+ysjgxf4uS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693397850; x=1694002650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D8Njhns0o4ZXlGI4JVLpfsWYsYkQtkNq/+nuGr1lhk=;
        b=BY9pkUdIvawCRUQPsTimXsa2LZybEeh5k37Suu1Gc3XHGCtn9BIRr6rm4e+JUi2S6r
         jdKNgjTwmeGIA5w5PHKLO2ogvDxQVqYI5ey2XYMBV3JxFVIO67PxfosZTMgmCh8ACLrn
         HFAbMPwAv0YchttC1blUw+p285CBRGgRwL1u0aYoVzCtqUp2pm/mYuYPxLvTBQ8sB5Az
         NnOQHiQqFr3Gry8mRoL/x6KGI2AIEliVw0oLE0ekTMlU7wefhJm7mEh9B506R72hvX0V
         Cbao5Z8lJ+cIZxrEFHRz69G4dBUJ8PrODukyRpuO5VbzYZmrsqZqVpqfS1JziI6f2P5o
         Q+dA==
X-Gm-Message-State: AOJu0YyOsN7QBdLv71jPuy3lxh0B+KpbAEc0iXaYD2QvyuIKkQbwTk1V
        0UzSgpPfD33Zqk1rtXMX4HIhOwk6vTitm1w2wIuELw==
X-Google-Smtp-Source: AGHT+IHU5zsWZXoLfZWVx357d+myi6P73wk6EBsN8w4djwvSLtWEVOLMa6fA+veIiDvfTjCmxYlKRVMpX2aZ9hvMH0o=
X-Received: by 2002:a2e:9796:0:b0:2bc:f40b:574c with SMTP id
 y22-20020a2e9796000000b002bcf40b574cmr1814357lji.42.1693397849451; Wed, 30
 Aug 2023 05:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org> <ZO8xHT5HUDTSVUai@casper.infradead.org>
In-Reply-To: <ZO8xHT5HUDTSVUai@casper.infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 08:17:18 -0400
Message-ID: <CAEXW_YRvCQP+eoWmbnEwXs925xXQYPDuCp+iyzWeo8HY9dq+Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
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

On Wed, Aug 30, 2023 at 8:08=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
> >
> > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

> I once started writing something similar, but got distracted and the
> immediate problem got solved a different way.
>
> It does make me wonder if we couldn't make this tree RCU-safe, but
> that's obviously a much larger job.

Yes, that would be nice.

 - Joel
