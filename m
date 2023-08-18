Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90F9780E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377783AbjHROlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377778AbjHROlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:06 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19B13D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:41:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C3484000B;
        Fri, 18 Aug 2023 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzX5gdoM5Yb2BGcVq37IpqionhzjbjtyvP3bnUvQiDw=;
        b=V87xDitMUJrKWq1YkcG7Wsyxo2OQedOTU68DgooM0ImRY44bfh8wkRsM7HLAJwElq39AGw
        PU3iW4u5nZMtWbVzmRFewIS0cLYSn43ActAK8jeCR23NgYzrwR1QJxEahFY4lUhwXosWM2
        oH7hvIzsBAfWqnIdlfjziCyfNze8isSRP/17HLcd2ETibq4emfsr+cx3VEQWMY12Xyzpi5
        TRPGFtZ8P8bZiOGILbotojeTQMcSGNF8GASdtuyOMg+FgwrR3u5JcExuSp/CAQAa7NgQgO
        4C2PTs5oP+ISlghU1+NgGEoXFPfUl4O+DfBIThD10n5QswTMkFskD2eVbgpV4g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Justin Stitt <justinstitt@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
Date:   Fri, 18 Aug 2023 16:40:59 +0200
Message-Id: <20230818144100.145691-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <20230816-void-drivers-mtd-maps-physmap-versatile-v2-1-433a25272bfa@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a417ab334dccb603f6296cbf04c9f8059bc252eb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-16 at 18:26:44 UTC, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/mtd/maps/physmap-versatile.c:209:25: warning: cast to smaller
> |               integer type 'enum versatile_flashprot' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         209 |                 versatile_flashprot = (enum versatile_flashprot)devid->data;
> 
> This is due to the fact that `devid->data` is a void* while `enum versatile_flashprot`
> has the size of an int.
> 
> Cast `devid->data` to a uintptr_t to silence the above warning for clang
> builds using W=1.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
