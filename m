Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831AA7888BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbjHYNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbjHYNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:18 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B514E6F;
        Fri, 25 Aug 2023 06:33:16 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1D4FA201BB.A2555
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 1D4FA201BB;
        Fri, 25 Aug 2023 15:33:14 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970394;
        bh=y3u0nX3ul5ivumfYWCjSC3RyTGxb8qELHwEuTshYGl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BlJbFuM2UC6V3HcaXbAXsMhYNSUURsHMq6NS26Tq7anvA5EGmQSjiLVJO54laZtcn
         1UgslRkEKvubdvbNVwPKsqAwUEndg5MkIbkK4qtOnIQY6Zr22Cs5b73JoNSEHT5g3a
         YxiJRyH8IoiLLwqD2ow4FiCch8ykMNSFfeoOXtlQ=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id D5F42D4EBC7EE;
        Fri, 25 Aug 2023 15:33:13 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 04/13] selftests/sgx: Fix linker script asserts
Date:   Fri, 25 Aug 2023 15:32:43 +0200
Message-Id: <20230825133252.9056-5-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINED only considers symbols, not section names. Hence, replace the
check for .got.plt with the _GLOBAL_OFFSET_TABLE_ symbol and remove other
(non-essential) asserts.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.lds | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 62d37160f59b..6ffdfc9fb4cf 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -35,8 +35,4 @@ SECTIONS
 	}
 }
 
-ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
+ASSERT(!DEFINED(_GLOBAL_OFFSET_TABLE_), "Libcalls through GOT are not supported in enclaves")
-- 
2.25.1

