Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B475F69A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGXMnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGXMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:43:06 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD24126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:43:04 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e908:444e:5a23:b79e])
        by baptiste.telenet-ops.be with bizsmtp
        id R0j22A00H26vpYY010j2rR; Mon, 24 Jul 2023 14:43:02 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qNuty-002O66-6f;
        Mon, 24 Jul 2023 14:43:02 +0200
Date:   Mon, 24 Jul 2023 14:43:02 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.5-rc3
In-Reply-To: <20230724122626.1701631-1-geert@linux-m68k.org>
Message-ID: <88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org>
References: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com> <20230724122626.1701631-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.5-rc3[1] to v6.5-rc2[3], the summaries are:
>  - build errors: +5/-0

   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 583:25, 493:25

mips-gcc13/mips-allmodconfig

Full context:

     In function 'fortify_memset_chk',
 	inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
 	inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
     /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
       493 |                         __write_overflow_field(p_size_field, size);
 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     In function 'fortify_memcpy_chk',
 	inlined from 'memcpy_toio' at /kisskb/src/arch/mips/include/asm/io.h:494:2,
 	inlined from 'translate_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:955:3,
 	inlined from 'ray_hw_xmit.constprop' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:912:12:
     /kisskb/src/include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
       583 |                         __write_overflow_field(p_size_field, size);
 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Single-element flexible array abuse in drivers/net/wireless/legacy/rayctl.h:tx_msg.var

   + error: modpost: ".L856" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A

parisc-gcc13/parisc-allmodconfig

   + {standard input}: Error: Missing symbol name in directive:  => 1096
   + {standard input}: Error: unrecognized symbol type "":  => 1096

sh4-gcc12/sh-allmodconfig (ICE)

   + {standard input}: Error: unknown opcode:  => 1091

sh4-gcc13/sh-allmodconfig (ICE)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6eaae198076080886b9e7d57f4ae06fa782f90ef/ (all 235 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fdf0eaf11452d72945af31804e2a1048ee1b574c/ (161 out of 235 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
