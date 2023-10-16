Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49D7CA429
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJPJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjJPJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:29:24 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A694128;
        Mon, 16 Oct 2023 02:29:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 117C224000C;
        Mon, 16 Oct 2023 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzhn3DjNSC33v2hlK3z5m8ef6dw4MhEJceWy7BvoV6U=;
        b=gQZRvonJzMX6QAVE0fEIHrohBTTG8kozKJatzGb3Ka3isRzFqed2Y+zVFkVyv/6MhZztdD
        h4oYN2hVTLhddyKydQw8TWSJbcxHNc02HnQYDVJa0U5TVxowg5uT1uDGfbKOLXKOtXxZfi
        11hzDxUdH/3vtSkW+vrThYfsm6qprxcWIjtLv4+W1yXwSZ4E/HQonQ0pOWooa7kx4Eqzhz
        oOShHGPRapwd0+jYqeXsFCswsE5zVg2VcXjUXy6/2W0lhC5nVeUF2KikMDcfTSieLkSF+E
        V56rY1aKk7quCobXEcDYfa2wQtOYF0yPJaq+uBgQKa5DrJnIymNiO8djUIT9Ow==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: rockchip: Use struct_size()
Date:   Mon, 16 Oct 2023 11:29:16 +0200
Message-Id: <20231016092916.289194-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1cfa2f76afb1fdedfbcbd83973a233e60c3e7add'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-01 at 07:44:04 UTC, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Also remove a useless comment about the position of a flex-array in a
> structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
