Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E307E022A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbjKCLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:22:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E1136
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:22:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c51682fddeso31612801fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010564; x=1699615364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPCpAYyXrmpvTCFWCPrCoA7Y/NUTFBtBJEwkbOnbvfc=;
        b=i1lM8GcKEXGwpvsZiOvYzJfWQLlBT9KM9zPSHcovcpVfOUEcHgN7soS4vRKA5n9vgc
         oibbMAybJzuywLWn1ucF7/Fwgc/Xi5gQ5Q0UzXZiWacRbR5saNA7w5rHCge9gIPSkd18
         DuuTj1n+o/OrYwetV7NaPbuyFpbK47WCv8+5y58RaIoiYLwJi7B0g1+r7B78TojyFXqO
         dh0fbG/Dulcp+rdFzBDseUH/J6zWx0IWgJJw5fuITipSpMvXQuyn0X1hl1pdDt7lDfZC
         QnZF4CERetnMm6Pw14pDpHRyqfZ/VBgDolq7OUVvcMm6ZPQE2KgHZolDtsjY/XNQ+bB4
         0biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010564; x=1699615364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPCpAYyXrmpvTCFWCPrCoA7Y/NUTFBtBJEwkbOnbvfc=;
        b=oEg+/hT348ZLRRdkq3j/OcBMs+Np4Ce/I7FdiDize7daJgS3MWASGLCWSqMyOp6TFV
         E+syW0ZbeTqHVcU7LlbiZWSN9Db5SEWQ2lsWpofUypRjpkN7Ld5mzM0flILhGfHAW8dQ
         T+8GrGss1dEnhx4S/Uz0hb1N3k8uqqYFVdXEvOfNSyNJ+Mp3kvrndIv/HqaRPdBRMUTs
         Uwko+OOXzFggBMQDyQSO7w6yJhwmqz2SEIvxDeYtK32nIjedwpwYUvyDrBWEzYKXnX23
         eRM0xpC/4O8K606O/SeZSn8xOduWW7FZzg0jdCNtFFUqxhoPDYE9Q03wvcvM3wk4/5Vm
         dx4w==
X-Gm-Message-State: AOJu0Yz/OvzB9JeGEQfAEa3McFVwQYr4vWeIOpT7NWbZM8+SyY5cjYB7
        az4PD4BvESgjw63NqSGtRAgT2A==
X-Google-Smtp-Source: AGHT+IFIZFoXGLwHbN1vbOa5GKa0O7Rxzp++onFknzG49QejR0WpxcOerL3lYrLgjbK1nj7lrwnLQA==
X-Received: by 2002:a19:7119:0:b0:509:dd1:74f8 with SMTP id m25-20020a197119000000b005090dd174f8mr871295lfc.2.1699010563946;
        Fri, 03 Nov 2023 04:22:43 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id u23-20020a2eb817000000b002c50ba4a047sm210102ljo.80.2023.11.03.04.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:22:43 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
Date:   Fri,  3 Nov 2023 12:22:37 +0100
Message-ID: <20231103112237.1756288-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crossbuilding selftests/bpf for architecture arm64, format specifies
type error show up like.

xskxceiver.c:912:34: error: format specifies type 'int' but the argument
has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
 ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
                                                                ~~
                                                                %llu
                __func__, pkt->pkt_nb, meta->count);
                                       ^~~~~~~~~~~
xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
 the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
 ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
                                    ~~~~             ^~~~

Fixing the issues by using the proposed format specifiers by the
compilor.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 591ca9637b23..dc03692f34d8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -908,7 +908,7 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llu]\n",
 			       __func__, pkt->pkt_nb, meta->count);
 		return false;
 	}
@@ -926,11 +926,11 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag invalid addr: %lx len: %u\n", addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag crosses frame boundary addr: %lx len: %u\n", addr, len);
 		return false;
 	}
 
@@ -1029,7 +1029,7 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
 			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n", addr);
+			ksft_print_msg("Last completion address: %lx\n", addr);
 			return TEST_FAILURE;
 		}
 
@@ -1513,7 +1513,7 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llu] expected [%u]\n",
 			       __func__, stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
-- 
2.42.0

