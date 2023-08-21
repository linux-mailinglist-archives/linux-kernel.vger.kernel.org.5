Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419DA782841
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjHULwR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHULwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:52:16 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE15BC;
        Mon, 21 Aug 2023 04:52:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59209b12c50so12513267b3.0;
        Mon, 21 Aug 2023 04:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618733; x=1693223533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKiRSzZfVO1mON5oFmy7ruqhTcZMc5q1W3MkhGY1hqI=;
        b=JKNh1UsPe19LAoprfvdGlXkt5WbpvN6BvJsBgAK1+xBRY1a8yfVX26UaG6bG6zVPPJ
         grJ+UWxgjbOP3Dz4T+dXpFaxjTbeJLGKhH0ZS39mhjCuTy7jrOr4A2da0bex8IYH5b41
         GQw84TlDhJ+d7skIyQDZCU9bdEOD3Pv5yoDoVNO0iFQZzRvMTogSnYRM7l7PXy21JvnR
         SxWzIH7OwPWc1qMtlQ2eiEztUbUpfAGRWQksDlnfp8+UMehe0UbugJTfFLKxPjjYBCL+
         z/BL7GJ1iVhrAn5YHmmVFu3MoL0DVNT23SttldDcEQXF50dJe4C32zHG8fxf81syBfwQ
         PAbA==
X-Gm-Message-State: AOJu0YxTI/xiyrHw1zIDdc2ZEMEMNt52uP+UC5QLXkanH1VwqPFLxNh2
        2ez2aIInd5/5a8+HxI+ypn64wqqhfU7GiA==
X-Google-Smtp-Source: AGHT+IHaBEZaHQs7FNfmUKEQ+EP5knyqzMpKlOADf4/7fDgL1c5rP9TIcyRGM+9JoJp2LspbZP9eoQ==
X-Received: by 2002:a81:5248:0:b0:57a:8de9:16a3 with SMTP id g69-20020a815248000000b0057a8de916a3mr6487760ywb.8.1692618733671;
        Mon, 21 Aug 2023 04:52:13 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l68-20020a0dc947000000b005772fc5912dsm2179456ywd.91.2023.08.21.04.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 04:52:13 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso3169516276.0;
        Mon, 21 Aug 2023 04:52:13 -0700 (PDT)
X-Received: by 2002:a25:938c:0:b0:d62:7dad:8ae1 with SMTP id
 a12-20020a25938c000000b00d627dad8ae1mr6036588ybm.20.1692618732930; Mon, 21
 Aug 2023 04:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org> <20230801-dt-changeset-fixes-v3-2-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-2-5f0410e007dd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 13:52:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5PCHWb9o=6NSwEsFY8aGGNX17b7-mdaoszzAP-aUZyQ@mail.gmail.com>
Message-ID: <CAMuHMdW5PCHWb9o=6NSwEsFY8aGGNX17b7-mdaoszzAP-aUZyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the update!

On Fri, Aug 18, 2023 at 10:41 PM Rob Herring <robh@kernel.org> wrote:
> While originally it was fine to format strings using "%pOF" while
> holding devtree_lock, this now causes a deadlock.  Lockdep reports:
>
>     of_get_parent from of_fwnode_get_parent+0x18/0x24
>     ^^^^^^^^^^^^^
>     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
>     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
>     fwnode_full_name_string from device_node_string+0x1a0/0x404
>     device_node_string from pointer+0x3c0/0x534
>     pointer from vsnprintf+0x248/0x36c
>     vsnprintf from vprintk_store+0x130/0x3b4
>
> Fix this by moving the printing in __of_changeset_entry_apply() outside
> the lock. As the only difference in the the multiple prints is the

scripts/checkpatch.pl says: WARNING: Possible repeated word: 'the'

> action name, use the existing "action_names" to refactor the prints into
> a single print.
>
> Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v6 (v3 in this series):
>  - Add check on 'action' bounds. As action is only set in
>    of_changeset_action(), add the check there.
>  - Drop printing the changeset entry pointer

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
