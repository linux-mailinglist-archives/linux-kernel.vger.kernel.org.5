Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F27FE8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjK3F6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3F6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:58:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F0D7F;
        Wed, 29 Nov 2023 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QJtAxhbCHcDrRV4Aa254WKnp3BN8TL7k7TrxRHdBrhY=; b=YvcI6g1k+1eUV3+0avRYXIbOgG
        p2SZ0EUdc5F0Y5Dsotfba0WqgvlwAvBrQ4xJuspFrBleoX+qIxjRYMwUVVPVo6Om1xwX8Xy/5b/YZ
        WcE1eguohju0yxwfYWIoUD970pq9lENDeNg/EJK8H2PLH9zFdf4SbEtBJQBMpKtw3pG8bVBIwXsQd
        AkX+kHULUcvbO2egt+EZK5K1FriypfzKj94Q888niLbq4vpurdPvuRCa/ejdGdWr9G4SxL4m42NWu
        Dr7/fKAvGzKpUIXXDixkhDfj87s3zc4QyI4ZmCpIMnvxVw7goGuhHz3zALyr5lFPCDN9ijAdWE40Y
        Woz4/h/w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8a4c-009ziS-1M;
        Thu, 30 Nov 2023 05:58:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2] hv_netvsc: rndis_filter needs to select NLS
Date:   Wed, 29 Nov 2023 21:58:53 -0800
Message-ID: <20231130055853.19069-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rndis_filter uses utf8s_to_utf16s() which is provided by setting
NLS, so select NLS to fix the build error:

ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!

Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
v2: correct Subject prefix (Michael)

 drivers/net/hyperv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -3,5 +3,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
