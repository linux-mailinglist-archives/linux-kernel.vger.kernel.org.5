Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4A780E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377789AbjHROlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbjHROlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78313D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:41:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74709C0006;
        Fri, 18 Aug 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnWLZlTRklyIq0gsggN9dgk+3faULATNeMM2pNJ88wI=;
        b=X53g3EnPtfUJXK6TOLZketkkLshIxL6N+tjsmJPq7tuxg4aq40EyHPmoP5BVJMmV3nZxMa
        +0TN8cLFzCK/JmR7Nj2KlZhFCsGak9ezL9t0u7OgpCfulQtxidzB5k8lUVpJ7+Awkt7mWz
        t1qWKh0hJ69tJSd649DBuMeou8/YS27juKbC5K+v0Ua4cFIfVVQY6hKarWeP76cMX13bWO
        ySeSpa2B0L4haMysf/MZaU4j7q1AA/wTmtuQ7Eg0NUHTKzfehWd35H/X11ya3frSwpTXNX
        dKu2WOkyYGqClCORWDI3L80pQ/52YsY5X6kNUE4KwfBb6CuXiOiocZjJ8j5Z3w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Justin Stitt <justinstitt@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] mtd: rawnand: fix -Wvoid-pointer-to-enum-cast warning
Date:   Fri, 18 Aug 2023 16:41:04 +0200
Message-Id: <20230818144104.145820-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <20230817-void-drivers-mtd-nand-raw-vf610_nfc-v2-1-870a7c948c44@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b9e002a34420e5ba25d4283be870c48e0c9e005f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-17 at 17:52:21 UTC, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/mtd/nand/raw/vf610_nfc.c:853:17: warning: cast to smaller integer
> |               type 'enum vf610_nfc_variant' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         853 |         nfc->variant = (enum vf610_nfc_variant)of_id->data;
> 
> This is due to the fact that `of_id->data` is a void* while `enum vf610_nfc_variant`
> has the size of an int.
> 
> Cast `of_id->data` to a uintptr_t to silence the above warning for clang
> builds using W=1.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
