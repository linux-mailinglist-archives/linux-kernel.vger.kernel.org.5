Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BA7829F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjHUNFd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 09:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjHUNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:05:32 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5881E8;
        Mon, 21 Aug 2023 06:05:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5922b96c5fcso5806827b3.0;
        Mon, 21 Aug 2023 06:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623124; x=1693227924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR9gHaaKDvQvLcKdj0k3UlblFmMZfcK00r7C+p/LPYc=;
        b=M27OMBmb8Eql/h0+885maJxU28Is9CTNoQBTq0z+2CEvRNMWqoq8VmoHWkEOImrF9l
         gppjYGvjfSVihsG/SgF3JWdzgW3E/ioCziTJxB+/3yIo/4su2ggkjfA5dm9326vSzQJH
         6nI7UbMnMgH+jtU0knvN+WHAvFkeYIMZ/QE2V72oqhJNTZ3UkmPzalYZv9oaeJwELhAU
         hAwNj+i9Gat0LAeiLekrfX6iKymWo8unnaXTBs/LUyVAeTigtB5luNm2Q12NiWwhdAt0
         5VRJLkNwkTbpeUHkTIkglFgX/aDIkTYMt1F0z5z4FRj/+D8ziZlZq6ghONMqWQygODSm
         t+ig==
X-Gm-Message-State: AOJu0YwdgWyOuR0BNvuGU13fsJ/bu3ZF6gkuEP+/R5Xlmnl7v0hYUorA
        3ZQeatXZuDQ6z+RKUZKL7mlfh5zYNtY/Mw==
X-Google-Smtp-Source: AGHT+IFsPamHt6ysB9zujtLvy1L805W9GiEYjX/Nh3gClPQgFYDzGYrx8twQ/YUTGh8/Ab4SGCfHdg==
X-Received: by 2002:a81:4e86:0:b0:58d:70b4:233a with SMTP id c128-20020a814e86000000b0058d70b4233amr8148886ywb.37.1692623124650;
        Mon, 21 Aug 2023 06:05:24 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id u189-20020a0debc6000000b005843155e284sm2208919ywe.49.2023.08.21.06.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:05:24 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d45caf42d73so3242822276.2;
        Mon, 21 Aug 2023 06:05:24 -0700 (PDT)
X-Received: by 2002:a25:b196:0:b0:d0c:753:11d0 with SMTP id
 h22-20020a25b196000000b00d0c075311d0mr7491897ybj.64.1692623123989; Mon, 21
 Aug 2023 06:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org> <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 15:05:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXi+fAH=sqMb941BGNidg=GtLiByPtMpoHX4Bf-5Cjv4A@mail.gmail.com>
Message-ID: <CAMuHMdXi+fAH=sqMb941BGNidg=GtLiByPtMpoHX4Bf-5Cjv4A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your patch!


On Fri, Aug 18, 2023 at 10:41 PM Rob Herring <robh@kernel.org> wrote:
> The changeset code checks for a property in the deadprops list when
> adding/updating a property, but of_add_property() and
> of_update_property() do not. As the users of these functions are pretty
> simple, they have not hit this scenario or else the property lists
> would get corrupted.
>
> With this there are 3 cases of removing a property from either deadprops
> or properties lists, so add a helper to find and remove a matching
> property.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Perhaps this needs a Fixes tag?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
