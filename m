Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B187D9E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjJ0Qfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjJ0Qfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:35:46 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B593;
        Fri, 27 Oct 2023 09:35:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF2C3240003;
        Fri, 27 Oct 2023 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698424539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ypzr29bYsfto7zJdkTiCmiQMxRqBdoXZjILJ3Cdczu4=;
        b=jzL9fFbAcpLhIm4Kqq5eXAeAeebXHy7V89wLncM3opOJrDAH5R6z0ztYpj0NE8FK7Gh8/j
        B4a9Zj6+7nKSKkkE37bBouPdlv7uDhylqJLdOxmuXo+lx4nMzfzde1RE2Mvcv22TZ1CJgd
        rVK7cQpNPvGh57TU9Falu7t8toB9g3m30Je6T6Ho+m6FYfa3IWBL5X8ejawPeC0yhZPu5v
        YiM9U7OBc8z8CNKRpdod6e763MQ5KBegsYPjpKBMgEjhsExxA8n2f8TaS7gf4TLitHG6Ax
        6WwXtsJnzKWZs2BtU/E3sUMLEElzcNtBnwo80Y2qO+zMZ4y+4pqHIG/7AxMDmw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/5] MIPS: Fix kernel in XKPHYS
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
Date:   Fri, 27 Oct 2023 18:35:38 +0200
Message-ID: <875y2s81lx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun,


> Hi all,
>
> This series fixes support for loading kernel to XKPHYS space.
> It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].
>
> Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
> QEMU patch on the way.
>
> Gregory and Vladimir, do let me know if I missed anything.

Thanks for this series, I reviewed it and tested it on my platform, so
you can add for all the patches:

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

However I add to fix the patch " MIPS: Handle mips_cps_core_entry within
lower 4G", I think you missed a case. I will comment on it.

Gregory


>
> Thanks
> - Jiaxun
>
> [1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/
>
> Jiaxun Yang (5):
>   MIPS: Export higher/highest relocation functions in uasm
>   MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
>   MIPS: Fix set_uncached_handler for ebase in XKPHYS
>   MIPS: Handle mips_cps_core_entry within lower 4G
>   MIPS: Allow kernel base to be set from Kconfig for all platforms
>
>  arch/mips/Kconfig               | 18 +++++++++++++----
>  arch/mips/include/asm/mips-cm.h |  1 +
>  arch/mips/include/asm/uasm.h    |  2 ++
>  arch/mips/kernel/genex.S        | 19 +++++++++++++----
>  arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++------
>  arch/mips/kernel/traps.c        | 36 +++++++++++++++++++++++----------
>  arch/mips/mm/uasm.c             |  6 ++++--
>  7 files changed, 82 insertions(+), 27 deletions(-)
>
> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
