Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB417A71EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjITFXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjITFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CEDC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1gBHFx2tI6V5P6z+m3jp+VBtTa+R50589jc6SHRpnzE=; b=BcU6wf2Ltl/WTOUgR2MqZvZQZJ
        4y79NyIocfLB4sXv3rM34I6yaE9N3gGEjjEYUWK2eCEnR0EosCDdtfnGtEdAMquZlW+nWVzegS5fl
        gpnZqJJaM6hv53IAVaiUEwyFr151sR8ScnVFUDAmNAtQ8lXH3+gC5xG4DRE3f8R+t6ptAsAnGog6w
        hGuUtrdlOP24U0WqT8hhmf6GGo28M80oL+jgOu0DGxOOxExuRXC2pj+Pu11WNK5bwP6BqAaXCAeWt
        7xnq+hREFRrJ7FElrBnc4nPKIPra5VPDl/ole3sg5LpR0wn93ZlHh3Tl702MSNKTsQjJEnAD6OK86
        9iIj74yQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipej-001tym-2l;
        Wed, 20 Sep 2023 05:21:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 13/16] xtensa: iss/network: make functions static
Date:   Tue, 19 Sep 2023 22:21:36 -0700
Message-ID: <20230920052139.10570-14-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make 2 functions static to prevent build warnings:

arch/xtensa/platforms/iss/network.c:204:16: warning: no previous prototype for 'tuntap_protocol' [-Wmissing-prototypes]
  204 | unsigned short tuntap_protocol(struct sk_buff *skb)
arch/xtensa/platforms/iss/network.c:444:6: warning: no previous prototype for 'iss_net_user_timer_expire' [-Wmissing-prototypes]
  444 | void iss_net_user_timer_expire(struct timer_list *unused)

Fixes: 7282bee78798 ("xtensa: Architecture support for Tensilica Xtensa Part 8")
Fixes: d8479a21a98b ("xtensa: Convert timers to use timer_setup()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -201,7 +201,7 @@ static int tuntap_write(struct iss_net_p
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -441,7 +441,7 @@ static int iss_net_change_mtu(struct net
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
