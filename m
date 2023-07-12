Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F5750FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjGLRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjGLRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:34:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831B1FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b74209fb60so2782001fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689183264; x=1691775264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KC5NZX32e9wpP9t7OccUoxNgiPdVaAw53ZnY1DABzIo=;
        b=V5ei7qNp77i5LTBoJFTJBlueVE62Zfg06qBd0j+zE8znnYY9LXT/fYSf1p95hiyxQW
         2lYLhSVEEhldICudGrrNlWo0o6dw1coTWb/UQjMpL6ua6nGPz6RSZ43NaBi8S1T5Hs4w
         KZhaSW/RMSIpEHO+VxPp5rwa+kr3FA/3RaW34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183264; x=1691775264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC5NZX32e9wpP9t7OccUoxNgiPdVaAw53ZnY1DABzIo=;
        b=danjnoAv1k53dlHbTPWdh8HUFDzPonBzJjP1oHQ6eBTEbTl+QIla9AIe7q0AVu9Eau
         jBTVkmNeOLfkpGfTJy9TsXdFwisIvhyWa3pFYz8HBXGaqGKUVIl+L/Dizr0eA7nkiTtx
         vhnaHpHjHc6HyhKsWONi0lWytrRD/RAHRp+nHTz2uZMw6O5wZ0080wJGhiS9M3vOCpE6
         ys+WzAxDibEoCzxsXKEi+r2aW/wFUuxdb9FpMy/TC201Tw/6iMUwL+J9rPt+rUzuYvKm
         GLzUH/8B6tWvubKAwEnByb9Uege5TU/AHor8ghrsFqmSlZ2QPUEIZtzMt96lWR3qAibI
         kLMw==
X-Gm-Message-State: ABy/qLY9MI5CY8krIMXRnMFUaawsXeMWZNJL0ipMTr4RIaO5xnIoCNe6
        HTORqpiTn3FA6EWdHY8iiJMi4x+7hP+6NXM2KQZo9jG+
X-Google-Smtp-Source: APBJJlGlJXtHp4Uai+zwNRbLbGnH3IkWnpl11hnfbv5rwYHob4nKzaIvW6fiBO5ZZ4pgKYPM54Z/2w==
X-Received: by 2002:a2e:86d8:0:b0:2b7:364e:91ec with SMTP id n24-20020a2e86d8000000b002b7364e91ecmr3208448ljj.13.1689183264547;
        Wed, 12 Jul 2023 10:34:24 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090670c300b0099307a5c564sm2831275ejk.55.2023.07.12.10.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:34:23 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so3304805a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:23 -0700 (PDT)
X-Received: by 2002:aa7:dc0d:0:b0:50b:c693:70af with SMTP id
 b13-20020aa7dc0d000000b0050bc69370afmr19367439edu.2.1689183262818; Wed, 12
 Jul 2023 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info> <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <20230712164546.GA31434@lst.de> <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
 <20230712165721.GA31965@lst.de>
In-Reply-To: <20230712165721.GA31965@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 10:34:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
Message-ID: <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 09:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jul 12, 2023 at 09:51:52AM -0700, Linus Torvalds wrote:
> > Christoph, you are *literally* involved in a discussion where this is the case.
>
> Yes.  But that's not never ever.  Enterprise storage devices have been
> pretty very good at it, because it is part of the purchase specs.

Your basic logic is lacking.

"Humans are animals" and "Some animals have four legs" are both
undeniabvly true.

That still does *not* mean "Humans have four legs".

And yet hat is *literally* the kind of nonsense you are spouting.

I very much say that "some devices will not have UUID's".

That's a *FACT*.

You then say "Some devices have UUID's, so all devices must have UUIDs".

That's *STUPID*.

Can you really not tell the difference?

           Linus
