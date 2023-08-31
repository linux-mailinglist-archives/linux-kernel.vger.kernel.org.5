Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5278E73D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbjHaHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHaHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:35:05 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5613D1A3;
        Thu, 31 Aug 2023 00:35:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 89B74604DE354;
        Thu, 31 Aug 2023 15:34:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH 2/2] ACPI: OSL: add __printf format attribute to acpi_os_vprintf
Date:   Thu, 31 Aug 2023 15:34:56 +0800
Message-Id: <20230831073456.1713093-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc and W=1 option to compile kernel, warning happends:

drivers/acpi/osl.c:156:2: error:
function ‘acpi_os_vprintf’ might be a candidate for ‘gnu_printf’
format attribute [-Werror=suggest-attribute=format].

Allow the compiler to recognize and check format strings is safer.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f725813d0cce..357f1325485d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -149,7 +149,7 @@ void acpi_os_printf(const char *fmt, ...)
 }
 EXPORT_SYMBOL(acpi_os_printf);
 
-void acpi_os_vprintf(const char *fmt, va_list args)
+void __printf(1, 0) acpi_os_vprintf(const char *fmt, va_list args)
 {
 	static char buffer[512];
 
-- 
2.30.2

