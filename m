Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DE783DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjHVK3d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjHVK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:29:31 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125FE4B;
        Tue, 22 Aug 2023 03:28:57 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so3137565fac.0;
        Tue, 22 Aug 2023 03:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692700137; x=1693304937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsbuYvLkHCqEgs9rtro3s+O6SiQIK8Nmj+hy3dIrz14=;
        b=jfmMbmfpfmZkCbzT/C6mrdix2ZSErIjFVFE9xcZczj2JFY5zaFAomV5dckUwWTk0IN
         4k4qr8K68MErUFkgjnR//Syf/Bftk0fOfg+jMGz/gLca7qdPDEg5RrM76vG0vs2Mkpgn
         3/DeSbWzJL1JZe5ulNMrXUZyl36+H88qPkeZw8u/WN7narSEposbmH1u+jRDXwCm4jII
         w1ly1sKFk+7Vk+ATeMnSt5NtHkXxltyqskxJBzL0nki/JfhXIU/oiDDYDh3J5+Q4f6UF
         l+67oN2rdO5B8OIpCq5O4reAidAAuRWPSDLIhUXzwhYkSA0bxuVYVx5vyH+xEkBjyF+b
         ldmA==
X-Gm-Message-State: AOJu0YwzZUlP/JH8sttG0svKrFyHg7VpVxR7lBSf6cmVqfaZDmdKVe8o
        f774/Vo0N+5X/2DW24//XLBsi+DPH9PQzg==
X-Google-Smtp-Source: AGHT+IE7Y2sxaXwTsePaxMeT5fcVy66s+VPGs1BYfGFxKybmtPE0wR/Gd9inOnaTnp3jLZWi55n4yw==
X-Received: by 2002:a05:6870:a48e:b0:1bb:4ec1:50ae with SMTP id j14-20020a056870a48e00b001bb4ec150aemr11009094oal.24.1692700137228;
        Tue, 22 Aug 2023 03:28:57 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id ec40-20020a0568708c2800b001cc6b64d5f3sm3253946oab.44.2023.08.22.03.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 03:28:57 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56ffe7eee6fso1884609eaf.1;
        Tue, 22 Aug 2023 03:28:57 -0700 (PDT)
X-Received: by 2002:a05:6358:52d4:b0:139:cdc2:e618 with SMTP id
 z20-20020a05635852d400b00139cdc2e618mr9632089rwz.8.1692700136852; Tue, 22 Aug
 2023 03:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
 <20230821023928.3324283-2-peng.fan@oss.nxp.com> <169265161637.2283882.6488993918028899667.robh@kernel.org>
In-Reply-To: <169265161637.2283882.6488993918028899667.robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Aug 2023 12:28:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyVeaKTX3ZyWU56xM4CPCyQF=i-AhDKwyN6C2cJTB=iA@mail.gmail.com>
Message-ID: <CAMuHMdWyVeaKTX3ZyWU56xM4CPCyQF=i-AhDKwyN6C2cJTB=iA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] of/platform: increase refcount of fwnode
To:     Rob Herring <robh@kernel.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, isaacmanjarres@google.com,
        conor+dt@kernel.org, rafael@kernel.org, devicetree@vger.kernel.org,
        jeremy.kerr@canonical.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk, arnd@arndb.de,
        hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>,
        ulf.hansson@linaro.org, linus.walleij@linaro.org
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

On Tue, Aug 22, 2023 at 1:33 AM Rob Herring <robh@kernel.org> wrote:
> On Mon, 21 Aug 2023 10:39:28 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > commit 0f8e5651095b
> > ("of/platform: Propagate firmware node by calling device_set_node()")
> > use of_fwnode_handle to replace of_node_get, which introduces a side
> > effect that the refcount is not increased. Then the out of tree
> > jailhouse hypervisor enable/disable test will trigger kernel dump in
> > of_overlay_remove, with the following sequence
> > "
> >    of_changeset_revert(&overlay_changeset);
> >    of_changeset_destroy(&overlay_changeset);
> >    of_overlay_remove(&overlay_id);
> > "
> >
> > So increase the refcount to avoid issues.
> >
> > This patch also release the refcount when releasing amba device to avoid
> > refcount leakage.
> >
> > Fixes: 0f8e5651095b ("of/platform: Propagate firmware node by calling device_set_node()")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  - Move amba device changes to patch 1/1
> >
> > V2:
> >  - Per Andy's comment, use of_fwnode_handle(of_node_get(np))
> >  - release amba device of_node refcount when releasing amba device, this is
> >    done from code inspection, no test.
> >
> >  drivers/of/platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Applied, thanks!

Good to see this got applied!

I had missed this fix, and spent quite some time investigating why multiple
overlay add/removal sequences caused a crash.  Only after I had
written a reproducer unittest[1], I managed to bisect the issue,
and found Peng's fix. Thanks!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

[1] "[PATCH] of: unittest: Run overlay apply/revert sequence three times"
    https://lore.kernel.org/all/a9fb4eb560c58d11a7f167bc78a137b46e76cf15.1692699743.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
