Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759877086F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHDTCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHDTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5D4C02;
        Fri,  4 Aug 2023 12:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AEA262107;
        Fri,  4 Aug 2023 19:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FC6C433CB;
        Fri,  4 Aug 2023 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691175698;
        bh=+aqxYP0WIXKt/aVVR7CXVv0DxplPSOZR8YmmkbVOuh0=;
        h=From:To:Cc:Subject:Date:From;
        b=YxcdCHBVvfxp2zhzD+Y41QobKpU37X7K1i9jtKw2hkXvkhe9NHa9KopEtsCdkJN0C
         YBfTVIicxKTerdTwW9Y5HMThPAddYR24tE+7Gt7876izm87OPwDjoGaZAK8VRnZBey
         /fnB7mM9u8UsNOu4mJPu/2pkEf8EzU3J7/l7wc7r53mGPIcN5EcgVJIiSGYCeITL9e
         uYZo9JIFOs4RcvCEikRaggPjQy8JjJXV6AMuCRM0yrW+K+n3oqXUZeOLIMqHF4kdch
         UuLmrSauE+VNysDLSkHB8UUkKaCSWnrxN8J730o8emfcXk4fQOXXY+MmW93HlntMWY
         eF4zFaDxIFtvw==
Received: (nullmailer pid 1936746 invoked by uid 1000);
        Fri, 04 Aug 2023 19:01:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt: dt-check-compatible: Find struct of_device_id instances with compiler annotations
Date:   Fri,  4 Aug 2023 13:01:29 -0600
Message-Id: <20230804190130.1936566-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regex search for declarations of struct of_device_id was missing
cases that had a compiler annotation such as "__maybe_unused". Improve
the regex to allow for these. Use '\S' instead of specific characters to
shorten the regex. That also finds some more compatibles using '.'
characters.

Unfortunately, these changes add ~400 more compatibles without a
schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/dt-extract-compatibles | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
index a1119762ed08..9df9f1face83 100755
--- a/scripts/dtc/dt-extract-compatibles
+++ b/scripts/dtc/dt-extract-compatibles
@@ -25,8 +25,8 @@ def parse_of_declare_macros(data):
 def parse_of_device_id(data):
 	""" Find all compatible strings in of_device_id structs """
 	compat_list = []
-	for m in re.finditer(r'of_device_id\s+[a-zA-Z0-9_]+\[\]\s*=\s*({.*?);', data):
-		compat_list += re.findall(r'\.compatible\s+=\s+"([a-zA-Z0-9_\-,]+)"', m[1])
+	for m in re.finditer(r'of_device_id(\s+\S+)?\s+\S+\[\](\s+\S+)?\s*=\s*({.*?);', data):
+		compat_list += re.findall(r'\.compatible\s+=\s+"(\S+)"', m[3])
 
 	return compat_list
 
-- 
2.40.1

