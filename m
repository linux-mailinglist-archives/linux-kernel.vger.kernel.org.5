Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E117ADC83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjIYP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjIYP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:59:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA7B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A7AC433C7;
        Mon, 25 Sep 2023 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695657545;
        bh=RrtU4RECwP4yzk+K9XzYnJXLXX3xo09O9R98nMyytTY=;
        h=From:To:Cc:Subject:Date:From;
        b=Adys9/F3M27GS5RkwihTaM+15EOZe0NoXZRfBW44jWh/4iZgMZKGQiwtiLFmEFe4h
         GrYPKAY8ly1lmpAoolOo8ypEQjWeCAqyTqwAB9Q1M9Rqu4MLN1RBSOKAdth7yokiZm
         ZkhqrtOyVcR6oMSvDzV8b6tKxve6HsHRYALXckry1DzFgfSacu/ostOrnGliGiGbZh
         HrNTKf2/FPad5fLLS3VSxkrlG5hbZWNAQplFDuHL5cZr+QFBEpkfMAuK5UNM/LwQJw
         PGTA8bsbRiEdcoJ1XMIrci4AN7UEs9WLkIjNysN+wl4wqlhvqVs/6HbUcCSmNdXpCo
         mYnAGuYGoxwkg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alan Brady <alan.brady@intel.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Phani Burra <phani.r.burra@intel.com>,
        Joshua Hay <joshua.a.hay@intel.com>,
        Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
        Madhu Chittim <madhu.chittim@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] idpf: fix building without IPv4
Date:   Mon, 25 Sep 2023 17:58:44 +0200
Message-Id: <20230925155858.651425-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added offload code fails to link when IPv4 networking is disabled:

arm-linux-gnueabi-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o: in function `idpf_vport_splitq_napi_poll':
idpf_txrx.c:(.text+0x7a20): undefined reference to `tcp_gro_complete'

Add complile-time checks for both CONFIG_INET (ipv4) and CONFIG_IPV6
in order to drop the corresponding code when the features are unavailable.
This should also help produce slightly better output for IPv4-only
kernel builds, if anyone still uses those.

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6fa79898c42c5..140c1ad3e0679 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2770,8 +2770,10 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (!(csum_bits->l3l4p))
 		return;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = IS_ENABLED(CONFIG_INET) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
+	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
 
 	if (ipv4 && (csum_bits->ipe || csum_bits->eipe))
 		goto checksum_fail;
@@ -2870,8 +2872,10 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (unlikely(!rsc_seg_len))
 		return -EINVAL;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = IS_ENABLED(CONFIG_INET) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
+	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
 
 	if (unlikely(!(ipv4 ^ ipv6)))
 		return -EINVAL;
-- 
2.39.2

