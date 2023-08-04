Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4076FA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHDHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjHDHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:03:45 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8F2D54
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:03:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0774360009;
        Fri,  4 Aug 2023 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691132620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtoxHNBucH0u6+GLGpFCwr/GAeii+9yfYYmXNFb3Tqg=;
        b=oQDYcPJ9pLvKhBJFz2vSMdCa4nwmzTA7sJUS9WciKrYLG/WKr5HaWtadvXDH7kdlrZXaHK
        kM/UYMxHGfma1Lj7NKXHZszqoeU9UK/WBnewFFp+svhoNSMcj9MZqglkoR70wRqoMaCFV+
        15tNra9V3oy3J46DdFU4m1FhPUzlfxk3Uay/23B2GUwiv+1P5bgK0AMuhwRDyasgwYMdND
        p4FYTDv8MdbFg0AWlAfp9+qUiQxPF6EPigh/qxuJVYfBs3JcK91IvbJdnlMJAwaNYQfhAC
        aMkd/ePIYU8YZ2YiLM2zz1KVK2no9sF6cZHvIwcAVB4wUXg+7X5E2+k1rswcAw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH v2] mtd: fix use-after-free in mtd release
Date:   Fri,  4 Aug 2023 09:03:35 +0200
Message-Id: <20230804070335.369834-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731115836.542747-1-alexander.usyskin@intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e9714c22c1a8238a85d069b1517941fc723312f7'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 11:58:36 UTC, Alexander Usyskin wrote:
> I case of partition device_unregister() in mtd_device_release()
> calls mtd_release() which frees mtd_info structure for partition.
> All code after device_unregister in mtd_device_release thus
> uses already freed memory.
> 
> Move part of code to mtd_release() and restict mtd->dev cleanup
> to non-partion object.
> For partition object such cleanup have no sense as partition
> mtd_info is removed.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
> Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
