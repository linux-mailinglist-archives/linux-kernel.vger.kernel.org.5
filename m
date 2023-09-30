Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F77B3DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjI3Ccn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 22:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3Ccm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:32:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F7FA;
        Fri, 29 Sep 2023 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qJkG8I/rEuGYYioes7KPLs6fDLcC6dzRpzWtqeVUSY0=; b=hTjG9kLv0tHYq4giZb1fd9LN4U
        5NyoSkcLlIEqCknsra3pF91h1cgrpEOzOsII6mHrpaRxh38X9Sihhvr46UsHstGqPfRNAKvMjdNFD
        11SvwT2YqHmfAiQ2LzBCTDfjLP/4v0xxNW651hh8WBWcfOxBoeHhyw4z2ZLQOQitxBxahtp4iZa4K
        u8gKNo4v2snULtOge0pyBvs6A3bh296VgY++2t6z9NYJfhJpCP6xwETCAJq/fLPczDypXjBD+Fcbs
        /ZI0FAyzGZKzg3U8g428ceKiU1Cs177Nn/vt/o2ADtJ570c0ibuYK4f6zVWNlJ6xuocfUMaidTWaF
        D+fmTmrw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmPmX-008pFK-1W;
        Sat, 30 Sep 2023 02:32:37 +0000
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
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] hyperv: rndis_filter needs to select NLS
Date:   Fri, 29 Sep 2023 19:32:34 -0700
Message-ID: <20230930023234.1903-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
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
