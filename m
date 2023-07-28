Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9031766D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjG1Me3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjG1Me1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:34:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D1F2688
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:34:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 125BD1C0004;
        Fri, 28 Jul 2023 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690547664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOQi55zewL8qDptR460/yfCRJyoOKkayv9fPyXa6DvI=;
        b=E6jAVUvWvvRPAdGB9s2caDim+QvPBAlxu3STNwAvcnZMv3DnSfMZ/ht9/g2bH/T7MqUyiM
        mKkFkOiIhtFI/O+iFLS9/wLVLPqp6NYlcUPRJmU1YQYUhTFqMD/8XPQk/xOI6GRE0stYse
        5Orn0kWGINlJPik8H82GdGbFPm7kjHHJ/NEBtKvTGaoGcDGhYsX91GNrnLngWH00/jt4GM
        OMd7CgJ+8qNFCqT71FQRFNMwZ2Ui58PvF0DBGNdTcYwcTkVy2bIdg6aoC1BPCRwPJ2lu0F
        Bx/zWFnECCtKRWvZvyp1MjWqj47QnipXiAT4vwKBAcZQrZDVqo0YdxmRxoa2Dg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        kernel test robot <lkp@intel.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix build error
Date:   Fri, 28 Jul 2023 14:34:18 +0200
Message-Id: <20230728123419.640606-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728093810.2985324-1-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4622daf4b5c89cd6a689910c523b8185b8a20338'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 09:38:10 UTC, Arseniy Krasnov wrote:
> Fixes the following build error:
> 
> drivers/mtd/nand/raw/meson_nand.c:244:59: error: initializer element is not a compile-time constant
> static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
>                                                           ^~~~~~~~~~~~~~~~~
> 
> Fixes: 0e1db39336d8 ("mtd: rawnand: meson: support for 512B ECC step size")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307281007.MMuVjmJ9-lkp@intel.com/
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
