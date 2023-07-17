Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1275597A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGQCXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:23:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FFEB1A7;
        Sun, 16 Jul 2023 19:23:02 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8DxPOsDprRkc8EFAA--.10055S3;
        Mon, 17 Jul 2023 10:23:00 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8wCprRk9gYxAA--.30213S2;
        Mon, 17 Jul 2023 10:22:58 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: processor_core: LoongArch: Get physical id from MADT table
Date:   Mon, 17 Jul 2023 10:22:58 +0800
Message-Id: <20230717022258.2579631-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8wCprRk9gYxAA--.30213S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr4ftFWUCFWkZw13Wr13WrX_yoW5XryrpF
        yUK3s8K3W5WFsFqw1fJayrWFWYq3y8ua4SgFZ7G343K3W8GryFqFWfJryagFyDAF4Fk3y2
        vr48tFy8WFW8ZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ACPI Spec 6.5 chapter 5.2.12.20, each processor in LoongArch
system has a Core Programmable Interrupt Controller in MADT table,
value of its type is 0x11 in the spec and defined as enum variable
ACPI_MADT_TYPE_CORE_PIC in Linux kernel. Physical id can be parsed
from MADT table for LoongArch system, also it can be parsed from
MAT table for hotplug cpu. This patch adds physical id parsing for
LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
Changes in v2:
 Refresh the changelog and add detailed description of acpi spec
 about MADT table for LoongArch system.

 Add comments in function map_core_pic_id.
 
---
 drivers/acpi/processor_core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index d6606a9f2da6..7dd6dbaa98c3 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -132,6 +132,30 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
 	return -EINVAL;
 }
 
+/*
+ * Retrieve LoongArch CPU physical id
+ */
+static int map_core_pic_id(struct acpi_subtable_header *entry,
+		int device_declaration, u32 acpi_id, phys_cpuid_t *phys_id)
+{
+	struct acpi_madt_core_pic *core_pic =
+		container_of(entry, struct acpi_madt_core_pic, header);
+
+	if (!(core_pic->flags & ACPI_MADT_ENABLED))
+		return -ENODEV;
+
+	/* device_declaration means Device object in DSDT, in LoongArch
+	 * system, logical processor acpi_id is required in _UID property
+	 * of DSDT table, so we should check device_declaration here
+	 */
+	if (device_declaration && (core_pic->processor_id == acpi_id)) {
+		*phys_id = core_pic->core_id;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 				   int type, u32 acpi_id)
 {
@@ -165,6 +189,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 		} else if (header->type == ACPI_MADT_TYPE_RINTC) {
 			if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
 				break;
+		} else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
+			if (!map_core_pic_id(header, type, acpi_id, &phys_id))
+				break;
 		}
 		entry += header->length;
 	}
@@ -216,6 +243,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 		map_x2apic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
 		map_gicc_mpidr(header, type, acpi_id, &phys_id);
+	else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
+		map_core_pic_id(header, type, acpi_id, &phys_id);
 
 exit:
 	kfree(buffer.pointer);
-- 
2.27.0

