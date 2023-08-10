Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE67778195
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjHJT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjHJT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:29:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD5213B;
        Thu, 10 Aug 2023 12:29:50 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTUL1001578;
        Thu, 10 Aug 2023 14:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691695770;
        bh=z/2gB2XzfcpGA6vkwKsgngyfd5rcVNHFkyNX2yelrLE=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=QTN8EHaUnDEoNECsH/ozXQM5linCtq1EQLwUOgeKKwFtZpjjXRurnuEvlCRKbRj93
         CdW/OOUugelAjHZliwv/c4JWHQtcXaRfUrmgPofjtTTu89j35G+o4BgI4ityEzR/u+
         WtgdC6pBeYhzBNJKev4iWEy1ds7fuxNXBZfmVxyc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AJTUxx008379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 14:29:30 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 14:29:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 14:29:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTTKn047039;
        Thu, 10 Aug 2023 14:29:30 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 11 Aug 2023 00:58:48 +0530
Subject: [PATCH v2 1/6] lib: add ISO 3309 model crc64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v2-1-4152b987e4c2@ti.com>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691695767; l=3827;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=RZqzNA6aIm6Y82QKZBpy0JA1A4wMZh1Ggib2+HlobIs=;
 b=rwRjN0C+andFVEwDIgrDnSUCssei8ltIMcGjUB/gb0TEbgJdvmxtlHXWlY+cQfV1R628IaNqx
 wmbJKJj1BbxClWqrpQgZK/LQGVyzGsJsEUy1kROn+mmQZf21wjrulYH
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the polynomial to the crc64 table generation, and provide a
generic library routine implementing the algorithm.

64-bit cyclic redundancy checks (CRC) according to the ISO 3309 standard.

The ISO 3309 64-bit CRC model parameters are as follows:
    Generator Polynomial: x^64 + x^4 + x^3 + x + 1
    Polynomial Value: 0x000000000000001B
    Initial value: 0x0000000000000000
    Reflected Input: False
    Reflected Output: False
    Xor Final: 0x0000000000000000

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 include/linux/crc64.h |  1 +
 lib/crc64.c           | 27 +++++++++++++++++++++++++++
 lib/gen_crc64table.c  |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index e044c60d1e61..70202da51c2c 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -10,6 +10,7 @@
 #define CRC64_ROCKSOFT_STRING "crc64-rocksoft"
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
+u64 __pure crc64_iso_generic(u64 crc, const void *p, size_t len);
 u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
 
 u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
diff --git a/lib/crc64.c b/lib/crc64.c
index 61ae8dfb6a1c..e066c8b2a511 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -22,6 +22,11 @@
  * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
  * x^7 + x^4 + x + 1
  *
+ * crc64iso[256] table is from the ISO specification polynomial
+ * defined as,
+ *
+ * x^64 + x^4 + x^3 + x + 1
+ *
  * crc64rocksoft[256] table is from the Rocksoft specification polynomial
  * defined as,
  *
@@ -63,6 +68,28 @@ u64 __pure crc64_be(u64 crc, const void *p, size_t len)
 }
 EXPORT_SYMBOL_GPL(crc64_be);
 
+/**
+ * crc64_iso_generic - Calculate bitwise ISO CRC64
+ * @crc: seed value for computation. 0 for a new CRC calculation, or the
+ *	 previous crc64 value if computing incrementally.
+ * @p: pointer to buffer over which CRC64 is run
+ * @len: length of buffer @p
+ */
+u64 __pure crc64_iso_generic(u64 crc, const void *p, size_t len)
+{
+	size_t i, t;
+
+	const unsigned char *_p = p;
+
+	for (i = 0; i < len; i++) {
+		t = ((crc >> 56) ^ (*_p++)) & 0xFF;
+		crc = crc64isotable[t] ^ (crc << 8);
+	}
+
+	return crc;
+}
+EXPORT_SYMBOL_GPL(crc64_iso_generic);
+
 /**
  * crc64_rocksoft_generic - Calculate bitwise Rocksoft CRC64
  * @crc: seed value for computation. 0 for a new CRC calculation, or the
diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
index 55e222acd0b8..ec2add75ec8b 100644
--- a/lib/gen_crc64table.c
+++ b/lib/gen_crc64table.c
@@ -17,9 +17,11 @@
 #include <stdio.h>
 
 #define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
+#define CRC64_ISO_POLY 0x000000000000001BULL
 #define CRC64_ROCKSOFT_POLY 0x9A6C9329AC4BC9B5ULL
 
 static uint64_t crc64_table[256] = {0};
+static uint64_t crc64_iso_table[256] = {0};
 static uint64_t crc64_rocksoft_table[256] = {0};
 
 static void generate_reflected_crc64_table(uint64_t table[256], uint64_t poly)
@@ -82,6 +84,9 @@ static void print_crc64_tables(void)
 	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
 	output_table(crc64_table);
 
+	printf("\nstatic const u64 ____cacheline_aligned crc64isotable[256] = {\n");
+	output_table(crc64_iso_table);
+
 	printf("\nstatic const u64 ____cacheline_aligned crc64rocksofttable[256] = {\n");
 	output_table(crc64_rocksoft_table);
 }
@@ -89,6 +94,7 @@ static void print_crc64_tables(void)
 int main(int argc, char *argv[])
 {
 	generate_crc64_table(crc64_table, CRC64_ECMA182_POLY);
+	generate_crc64_table(crc64_iso_table, CRC64_ISO_POLY);
 	generate_reflected_crc64_table(crc64_rocksoft_table, CRC64_ROCKSOFT_POLY);
 	print_crc64_tables();
 	return 0;

-- 
2.34.1

