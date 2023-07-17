Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E5755F37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGQJ1g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGQJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:27:29 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A01AC;
        Mon, 17 Jul 2023 02:27:20 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-cabf1dbafc4so4383808276.2;
        Mon, 17 Jul 2023 02:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586039; x=1692178039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQYPm/MJZFOigeBRJW1J/laJWDdn6N7XaMSfRCOMyFU=;
        b=YGgRLhuMpihgPtu41niXrfgqg5oTzzd5THKTuMoaAdugb3tiXOBYMICFsqrakf04mg
         NwsqPhprj5IY+UEAJ420oZ8Ta2BiKss8AsUydo4g1lri7FpPlqHJw/AASeTf4n1oyvHD
         AaALUgC3CmCb/HpqjxCEBvpkc4Y4Y3gGYfSSMk7EWRonjt9nV/pbZv/ne7ARucLVfPqz
         l0mqcLdSgROwABfADLNCx4kCHaSLqOjLIgi4SBXuz/X5WkqiKkOBPRJr2CheN4Bdf7FZ
         dDpSJOx3U2BWMb0OqQINxp2T26CriP3cUpRKKbCnHrEftwIrqNtgyuS2zMWU64CTbP6R
         erVQ==
X-Gm-Message-State: ABy/qLZcs7k5HjbfCs2VjLCSISRMMTWxb7yN/oWN+Fh3DlcMnema2rFU
        Vu1LgIL735ZX2PidgApA64oX3C4NhLZBwg==
X-Google-Smtp-Source: APBJJlEK3upjxMtN7NaTucBNzSRmB1n+kbDfpNJpF6u3EEb7zXNn5O4aTBdPcnP9R4cUHrHEsiVDHA==
X-Received: by 2002:a05:6902:542:b0:cc7:4dc4:d231 with SMTP id z2-20020a056902054200b00cc74dc4d231mr5655027ybs.13.1689586039303;
        Mon, 17 Jul 2023 02:27:19 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 124-20020a250882000000b00c4cda9d35desm2972494ybi.32.2023.07.17.02.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:27:18 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c7a5600d04dso4373898276.3;
        Mon, 17 Jul 2023 02:27:18 -0700 (PDT)
X-Received: by 2002:a5b:889:0:b0:c4e:3060:41f7 with SMTP id
 e9-20020a5b0889000000b00c4e306041f7mr10250753ybq.16.1689586038757; Mon, 17
 Jul 2023 02:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-4-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:27:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUB8g3jhGh7SJvv5OxfsHvHqRE=ANuPAHDxbS6tyTMcsg@mail.gmail.com>
Message-ID: <CAMuHMdUB8g3jhGh7SJvv5OxfsHvHqRE=ANuPAHDxbS6tyTMcsg@mail.gmail.com>
Subject: Re: [PATCH 03/10] spi: rzv2m-csi: Rework CSI_CKS_MAX definition
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate
> the serial clock (output from master), with CSI_CLKSEL_CKS ranging from
> 0x1 (that means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided
> by 32766). CSI_CKS_MAX is used for referring to the setting
> corresponding to the maximum frequency divider.
> Value 0x3FFF for CSI_CKS_MAX doesn't really means much to the reader
> without an explanation and a more readable definition.
>
> Add a comment with a meaningful description and also replace value
> 0x3FFF with the corresponding GENMASK, to make it very clear what the
> macro means.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
