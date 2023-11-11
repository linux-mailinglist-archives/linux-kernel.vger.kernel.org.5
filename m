Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB337E8B15
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjKKNsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:48:36 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682003A9D;
        Sat, 11 Nov 2023 05:48:31 -0800 (PST)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 81E533F66F;
        Sat, 11 Nov 2023 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699710509;
        bh=lP4YnLK406Oh78dHgIFdBe0DQkFdIy6q256xnJqXUJg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jXlV0bfrtyG/viewh3F6JofLzBzG5iQNPrui0+u0dNvPV32UNht5POgl1n6pwoy2T
         KZB+4NDPNDrfCkpGqCNJsFWZdz6IyF5W6Bxae5oTTqKFaXZKfNhw6HFtZAyFxg58/a
         yVbbtRo8IgY2qbM3XRBgSkr6I5FMqHmFwDawOH7chRIPZkgFXn3xLQQsxQulm7kolk
         ZG/muAJK3GU4HLGYhcr970+/U+apNC4nFvkq7Kvc+VLlmzASZQXNU7yGACunxxVT5r
         NtUnesC2aOS2tWz7Kg/XLfZuBITM7Gpl44ND7kgdRBUDnrXUip6fgp4qNLDLje4JL0
         Z56S0NeRW0FKQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
Date:   Sat, 11 Nov 2023 14:48:27 +0100
Message-Id: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ACPI 6.5 specification the component Entry starts at
offset 36 in the XSDT table which is not a multiple of 8. Hence we must
mark the structure as packed.

We did not see an error due to the incorrect packing yet as in
acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
Entry.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/actbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..1a37ac378765 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -148,7 +148,7 @@ struct acpi_table_rsdt {
 struct acpi_table_xsdt {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u64 table_offset_entry[1];	/* Array of pointers to ACPI tables */
-};
+} __packed;
 
 #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
 #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
-- 
2.40.1

