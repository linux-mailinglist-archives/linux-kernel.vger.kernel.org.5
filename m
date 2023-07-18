Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908587577B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGRJTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjGRJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:19:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5B1BF1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:19:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9A16FF808;
        Tue, 18 Jul 2023 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689671951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZ0tsLSHYDdinW0/0PSHBjblW1PDJmeicsu1MK6xsHo=;
        b=CT8zw+LeHEjAlkRmAO6trQ+Y7PgX95BBLggVkp1O2D5aq9mec4Qk7pQbOVriI1Cb2LQjUX
        xjoaWjTwcg77DLUFdNYpluZq0Te6uErtV5HqM7OnKeSIEX7YmUbswaA9rQ3rLDr39LNKl1
        QYPvJ3dYYbG5mbUX5+yy17iflFTRXYa3acpg0hMwfnBpoThYuR8zDXD1acB+78jak4TKNM
        N5G/Vf2VolmNUjAldig0cTnt1C4wjik/A2A24vSQLOQCaUa5oiI2eY6MUjWrS9OfhNpeb6
        ltkVvNeeqKACXJ61a3tTDYuArkmDgWBHfGXIwvhKsjHMPRO3jydabU1hn7F+hQ==
Date:   Tue, 18 Jul 2023 11:19:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] Revert "nvmem: add new config option"
Message-ID: <20230718111906.7a69c320@xps-13>
In-Reply-To: <20230718084804.20139-1-zajec5@gmail.com>
References: <20230718084804.20139-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 18 Jul 2023 10:48:04 +0200:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
>=20
> It seems that "no_of_node" config option was added to help mtd's case.
>=20
> DT nodes of MTD partitions (that are also NVMEM devices) may contain
> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
> NVMEM core code from parsing them "no_of_node" was set to true and that
> made for_each_child_of_node() in NVMEM a no-op.
>=20
> With the introduction of "add_legacy_fixed_of_cells" config option
> things got more explicit. MTD subsystem simply tells NVMEM when to look
> for fixed cells and there is no need to hack "of_node" pointer anymore.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
