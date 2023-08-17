Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423D677F25B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbjHQIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349061AbjHQInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:43:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981022D73
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:43:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74A5A1BF20D;
        Thu, 17 Aug 2023 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692261798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZTPzGWR823YG5jFJrtbSl0SkHcpjEiMeVAQSp30Zyg=;
        b=AXCaItneDiKmQZVzmSpvvVUGf/dhoyBk23IuegiE10XZWy/0yMUgAyYaoC7FPkhcDpLQv5
        KPgswpVotS+ApFCCfTjOz1oKns26teIl1mvr/mvXRlVbm2UXc96N7FIhh/3HKVkeT8b9Ai
        mjQ45ai64+wazBScB76VV5fmQacVd9MXJM2jFHyzhWNHNcgkZfPhDy6beiwYw75yRb4V9X
        gENUL2m3FBeh+k7506ftz7X/52ysnNTgrF6t+VbruaaVszkz5L/ao83cBdNCKW96K5GoPq
        aIlueyUYxwkChF4XXUc8g5a79Ay90iySe6Bgg3mNICpvSFXYqxq7TSxFoOvWig==
Date:   Thu, 17 Aug 2023 10:43:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230817104316.0ac684d0@xps-13>
In-Reply-To: <20230815-void-drivers-mtd-nand-raw-vf610_nfc-v1-1-7cc65314c56c@google.com>
References: <20230815-void-drivers-mtd-nand-raw-vf610_nfc-v1-1-7cc65314c56c@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

justinstitt@google.com wrote on Tue, 15 Aug 2023 20:58:47 +0000:

> When building with clang 18 I see the following warning:
> |       drivers/mtd/nand/raw/vf610_nfc.c:853:17: warning: cast to smaller=
 integer
> |               type 'enum vf610_nfc_variant' from 'const void *' [-Wvoid=
-pointer-to-enum-cast]
> |         853 |         nfc->variant =3D (enum vf610_nfc_variant)of_id->d=
ata;
>=20
> This is due to the fact that `of_id->data` is a void* while `enum
> vf610_nfc_variant` has the size of an int. This leads to truncation and
> possible data loss.

Can you please update this commit log to what Krzysztof suggested in
the "mtd: maps: fix -W<foo> warning" thread?

> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: There is likely no data loss actually occurring here due to the
> fact that `enum vf610_nfc_variant` only has a few fields which are not
> nearly large enough to cause data loss. This patch helps towards the
> goal of eventually enabling this warning.
>=20
> Also, should we use `unsigned long` here instead of `uintptr_t`? I've
> seen maintainers request both and I'm flipping a coin here.

I'm fine with uintptr_t.

Thanks,
Miqu=C3=A8l
