Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F003798326
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjIHHQq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjIHHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:16:45 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A619A8;
        Fri,  8 Sep 2023 00:16:40 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-58d40c2debeso17995797b3.2;
        Fri, 08 Sep 2023 00:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157399; x=1694762199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwxJqdgaKxlBJddMvg3cbLWlQQ2B9elRfFjjlHicF/4=;
        b=ULcIAie39VbXKxCgzvvG6h4PAoKcVHJbHn5rVa5HedUOFmz7fAylHS0D/DaiwgKVFM
         x+6ziX3oykNnNRuV5cBwCx3kz4HYeSahTEuEB+lehz4v55QTxXLO+bL2d+2Mw8jWwAe4
         C5biKSxb2HlEftf+r+4yY/6sq+IwId2Lbfyw+6i1d+ybvaIvJ0GUn1LvQncxf3tUaTXk
         I1YjOosZbzrSxOMPHQ9LnQbC3P8q+J5zN4jqbKqsHT5wzB6+nTqi4c4MK/idfFp8tlLZ
         bGxi4cXVmr4d5ZeBSV5ynJYHWcfZNRBWJi9+BPPT+5wsQpGSlwFnX5VFcCFWAnK7XRoR
         mw4w==
X-Gm-Message-State: AOJu0Yyv9tCKTMPAOnGuIZ89TdHaA86LRbOhpuvCjhO7PGkr8WbFsIiG
        fcoVb1dDjQSVc7cP3JtBjPn4kmvTs8PtrW0d
X-Google-Smtp-Source: AGHT+IGZW0B/nj3i2PT0p1GXsZK2zmhnVmfAMs+G8375PXE9HC5YboIjHWSYmB45SySh3t7ttXY3rQ==
X-Received: by 2002:a0d:d6d3:0:b0:59b:2458:f612 with SMTP id y202-20020a0dd6d3000000b0059b2458f612mr2019622ywd.28.1694157399541;
        Fri, 08 Sep 2023 00:16:39 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id y126-20020a81a184000000b0056974f4019esm306919ywg.6.2023.09.08.00.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:16:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58caaedb20bso18111427b3.1;
        Fri, 08 Sep 2023 00:16:38 -0700 (PDT)
X-Received: by 2002:a25:cbc8:0:b0:d7a:cb32:2747 with SMTP id
 b191-20020a25cbc8000000b00d7acb322747mr1684982ybg.17.1694157398059; Fri, 08
 Sep 2023 00:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
In-Reply-To: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 09:16:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUQ1rZj_9TLd3qjZ2knRK0npnTME9ijiU8qkPnKbyqmA@mail.gmail.com>
Message-ID: <CAMuHMdVUQ1rZj_9TLd3qjZ2knRK0npnTME9ijiU8qkPnKbyqmA@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 9:03 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> Smatch complains that the error path where "action" is invalid leaks
> the "ce" allocation:
>     drivers/of/dynamic.c:935 of_changeset_action()
>     warn: possible memory leak of 'ce'
>
> Fix this by doing the validation before the allocation.
>
> Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
