Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4ED751A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGMHsH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGMHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:48:01 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7D1BD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:48:00 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-cb4de3bd997so91240276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234479; x=1691826479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoVtxTNWvg008uuVWjLTiXVz9X1mSZwOKq6tuE+zDB0=;
        b=iJo0328oiORRIQRYRl54/7EHz7TdmfXtCLpQxTA0op0HOq5P32TQ+rtWbBKTGmzb9X
         ZKtVdP0lleHXneE6K4Vomc4M/jfCGk3i1b/7Hsdf9J1Q5ciBJE9dQxeFwmJAxPLq4oyI
         bsyjFQgOzPcvbi4oE9yNhYhLerrIO51rxrDza9D/NsGNeqO3xgAQ/o7OXMvXnOwWiNkg
         tI2mpZUHXuyAqmBiMue7cbAC3rpTGc114M3r/yabKGaGg1munRDqQQ72IXmeC//7YB2c
         xXoSPSQr+LwrslfZVMkuxihNDSbzO8crpTEnVtzehm4BuY6gEq3G6BldOOGtB+fuGG+W
         64+Q==
X-Gm-Message-State: ABy/qLaPHGB8GUFeIpTzA9ICScauxl+8RvaXxPOkku5VVbbcEAVxhleT
        rr9Cfzh7rcCPiXTnogHpHW04V7D1zBx8V5kQ
X-Google-Smtp-Source: APBJJlHzAQg/t9Yo73CIMHZyCd8qKIqqG5T6IwpU0M9Yrr3xbm+MfCcok0jWjSJB+MaRDNL4VJOwDA==
X-Received: by 2002:a81:8348:0:b0:56d:2e66:4a3f with SMTP id t69-20020a818348000000b0056d2e664a3fmr4884696ywf.0.1689234479128;
        Thu, 13 Jul 2023 00:47:59 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g71-20020a81524a000000b0057a67df3308sm1608361ywb.101.2023.07.13.00.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:47:58 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-cb37a0ea5b3so237915276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:47:58 -0700 (PDT)
X-Received: by 2002:a25:ae5d:0:b0:bd6:a97e:3597 with SMTP id
 g29-20020a25ae5d000000b00bd6a97e3597mr4667504ybe.30.1689234478607; Thu, 13
 Jul 2023 00:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230712173916.168805-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230712173916.168805-1-Liam.Howlett@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 09:47:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXeZvCfW-gqQ2gsZ_84AthVw+vNmD3FxaLK3=mSKoV-pQ@mail.gmail.com>
Message-ID: <CAMuHMdXeZvCfW-gqQ2gsZ_84AthVw+vNmD3FxaLK3=mSKoV-pQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] maple_tree: Fix 32 bit mas_next testing
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 7:39 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> The test setup of mas_next is dependent on node entry size to create a 2
> level tree, but the tests did not account for this in the expected value
> when shifting beyond the scope of the tree.
>
> Fix this by setting up the test to succeed depending on the node
> entries which is dependent on the 32/64 bit setup.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/

s/Link/Closes/

> Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module testing")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

On ARAnyM:

    TEST STARTING

    maple_tree: 3804524 of 3804524 tests passed

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
