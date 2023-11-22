Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50B87F3ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKVAm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:42:26 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBA112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:42:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2ea7cca04so4037304b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700613742; x=1701218542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JAG0RDoM6r+OhcBNCljqVXixFJN9onE/iS8GXZuAZc=;
        b=J8kBBzXNLvaLzzItbZ6aiB87DxoMjhSXat/Mmm9YQExy3E3RcYeTGt+nkBO6NxqWfA
         VPNPDZYFNVP9FUqYg03bsV1XkDv0HTyhGQVcx9vX6LF0ONJkf/VOdMnD1McMurjfkEFx
         Ku8fYwMMW6mqIeMr8EzT04k2zKMOVhLxCmbp5aE92Vm3nuLSUU5GO8XTCxrhXNk0WWSX
         En2EFu79XuCuv/xfDk2kMTIyOZ2G6EMt0vZYBSn88rUcpe4dvZ7V1Up/MMxIDe62l1ZV
         CejkP9hYykrU+xNVFjW57jGM+cL2vC7AXdZT54rRJHH+N2Wx1teMhM4r/BtLBFKhyXBH
         XR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700613742; x=1701218542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JAG0RDoM6r+OhcBNCljqVXixFJN9onE/iS8GXZuAZc=;
        b=feI3WE0TPS++46MEgxS3dSgTmfxgc9/SzhzAs8uEb5oc2G0+foWRnMI1Knpn0EsFCF
         qTTj8KTazDyVyW4auuhuqQM3i7RWaUl9exMS89lYVm4ZiNcHkf+Vb8SpQSgtHFHmKW8g
         gCD4bKbLrfWT1jfr3Mp1yXCj/1KsLu/WVcRDEhW7O9RCxNkTub/pzEWbNMraSijZgJY5
         Pnrst1Z8+B+phFCssxZs21MnSCpuH3ex03CBZPaKSM0F3l6lPFsXokVZdsBEeuN7mPvJ
         vKwwc1BbX5lfLEqFN1oYhEO9Cnjz0G0iu0c2czEScAjDxU6xVvND3VlUK8+P2lxl5FzE
         Elcw==
X-Gm-Message-State: AOJu0Yxh7RnHW1hO8hVPFQ6BqxOke6y2mUfETRIVGRLXQBV5a35UqS9o
        UXXts+oKUt6mwISf3Ideq1cuDNdKaot51d78tX8yyQ==
X-Google-Smtp-Source: AGHT+IFtjceUKgV711uY05lmug8NPHDY9L8jlpd8D8wBrSUqKZ6rNZvgEDLVfLqCG+sn6SOl8BLolA==
X-Received: by 2002:a05:6808:1693:b0:3b8:3ba9:b14b with SMTP id bb19-20020a056808169300b003b83ba9b14bmr1311964oib.43.1700613741892;
        Tue, 21 Nov 2023 16:42:21 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z128-20020a636586000000b005b856fab5e9sm8382145pgb.18.2023.11.21.16.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 16:42:21 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net] net: axienet: Fix check for partial TX checksum
Date:   Tue, 21 Nov 2023 16:42:17 -0800
Message-ID: <20231122004219.3504219-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a typo, the code checked the RX checksum feature in the TX path.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 82d0d44b2b02..bf6e33990490 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -822,7 +822,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
-- 
2.42.0

