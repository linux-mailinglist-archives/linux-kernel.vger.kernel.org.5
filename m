Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DE8012F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjLASph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:45:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9910D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:45:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E70FC433C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701456340;
        bh=xsaxZc0KDMl85GF4GH4Yoo9cd+8f9Y9i3cFqKb8mFrs=;
        h=From:Date:Subject:To:From;
        b=bIHd+PIqaCH3KnUpbCBl/xHTAwBfq3OB/8Wc2UWOxQV8/2xeJC82EkJCqh7CYKH8t
         0Ybt0MpspXxSmiuCr9e4/4s0X29us2ApQCYm/6pAMjvk7SB9YRp44m3yY0pdvuQLkC
         vf2uzSTHbXQFd2C/uWcd/Ai3HfmD6Do2cLqb0jnPXokNuG7xqEGgzrKQPnRQEkto7N
         D/c8zI9hCLWeTRb28aj7GSHQzUEO2nJWU67EVxKZzixRqvYqSFRo88h6Pt/CzS+SoI
         4EHXQ04WtNPmH2GKrKcrHyRWl6ieQGeIyy31PK8w3Nd8SxTMCXA9wQZWv/0VdmjWNP
         84UiccT5y1i+Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c9d1b07e79so24808181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:45:40 -0800 (PST)
X-Gm-Message-State: AOJu0YzFqqcM2D1X1AU1qMdMlDdQoLLa12ffLc9AVrzm82soIChLOw4L
        Y0/uZnG/vka3cCDySvfhB3vmknWiSOhgQZuuVT0=
X-Google-Smtp-Source: AGHT+IHHFfIYdRRF3S+2hYnc2dtPmvnqPIpc7Viu8sxWAf3ai/PBrkpJwU71/1qcoEyLerTrOY63GOqIszZqwTdZN6E=
X-Received: by 2002:a2e:8185:0:b0:2c9:bc36:89c4 with SMTP id
 e5-20020a2e8185000000b002c9bc3689c4mr1232506ljg.0.1701456338890; Fri, 01 Dec
 2023 10:45:38 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Dec 2023 03:45:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com>
Message-ID: <CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com>
Subject: Question about BUILTIN_DTB support in RISCV
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a question about CONFIG_BUILTIN_DTB for riscv.

Please see this commit history.


[1]
2d2682512f0faf4d09a696184bf3c0bb6838baca
added built-in DTB support, attempting
to include multiple DTB into vmlinux
by using SOC_BUILTIN_DTB_DECLARE() macro.


[2]
d5805af9fe9ffe4a9d975e9bc39496f57a161076
pointed out that choosing the correct DTB
is impossible. It fell back to the single
built-in DTB support, like other architectures.

[3]
0ddd7eaffa644baa78e247bbd220ab7195b1eed6
added BUILTIN_DTB support for sifive and microchip,
while apparently multiple DTBs are embedded into vmlinux.



So, how does it work?


With
CONFIG_ARCH_MICROCHIP_POLARFIRE=y
CONFIG_ARCH_SIFIVE=y
CONFIG_BUILTIN_DTB=y

7 DTB files are embedded in vmlinux.


masahiro@zoe:~/ref/linux(master)$ riscv64-linux-gnu-nm -n vmlinux |
grep -A15 dtb_start
ffffffff82112620 D __dtb_start
ffffffff82115a2c D __dtb_mpfs_icicle_kit_end
ffffffff82115a40 D __dtb_mpfs_m100pfsevp_begin
ffffffff82118b3b D __dtb_mpfs_m100pfsevp_end
ffffffff82118b40 D __dtb_mpfs_polarberry_begin
ffffffff8211b9c2 D __dtb_mpfs_polarberry_end
ffffffff8211b9e0 D __dtb_mpfs_sev_kit_begin
ffffffff8211e7bb D __dtb_mpfs_sev_kit_end
ffffffff8211e7c0 D __dtb_mpfs_tysom_m_begin
ffffffff8212162e D __dtb_mpfs_tysom_m_end
ffffffff82121640 D __dtb_hifive_unleashed_a00_begin
ffffffff821236af D __dtb_hifive_unleashed_a00_end
ffffffff821236c0 D __dtb_hifive_unmatched_a00_begin
ffffffff8212621b D __dtb_hifive_unmatched_a00_end
ffffffff82126220 D __dtb_end


In my understanding, the first one
(mpfs-icicle-kit.dtb) is always used.

You cannot use the other 6 DTBs.
Am I missing something?



arch/riscv64/boot/dts/canaan/Makefile
is correct because only one DTB is embedded
if CONFIG_ARCH_CANAAN_K210_DTB_SOURCE contains
a single word.



-- 
Best Regards
Masahiro Yamada
