Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853937D83F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjJZNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJZNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:40 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97907D5E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:55:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:32d3:3cb9:edce:43ae])
        by michel.telenet-ops.be with bizsmtp
        id 2dva2B0022XL1Wb06dvaV2; Thu, 26 Oct 2023 15:55:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0pa-007YxK-1z;
        Thu, 26 Oct 2023 15:55:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0pi-00HArv-0X;
        Thu, 26 Oct 2023 15:55:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] scripts: dt_to_config: Fix nul-separated compatible values
Date:   Thu, 26 Oct 2023 15:55:31 +0200
Message-Id: <7da12517180c0330d96cd0e3d48382191748a1a7.1698328110.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698328110.git.geert+renesas@glider.be>
References: <cover.1698328110.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using dt_to_config on a DTB:

    -------------- : /soc/adc@10059000 : renesas,r9a07g043-adc\0renesas,rzg2l-adc : no_driver : no_config : none

When using dt_to_config on a DTS:

    +M------------ : /soc/adc@10059000 : renesas,r9a07g043-adc : no_driver : no_config : none
    +Md-c--------- : /soc/adc@10059000 : renesas,rzg2l-adc : drivers/iio/adc/rzg2l_adc.c : CONFIG_RZG2L_ADC : none

As of commit 32b9c61307629ac7 ("Preserve datatype markers when emitting
dts format") in dtc v1.4.7, "dtc -O dts" no longer outputs compatible
properties containing multiple values as multiple strings.  Instead, it
outputs single strings, where the individual values are internally
separated by an escaped nul character.

Fix this by translating nul-separated compatible values to the
traditional multi-string format before splitting them.

Fixes: f858927fd6ce394a ("scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/dtc/dt_to_config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/dtc/dt_to_config b/scripts/dtc/dt_to_config
index 299d1c2b20d7785a..563362f363e8cec1 100755
--- a/scripts/dtc/dt_to_config
+++ b/scripts/dtc/dt_to_config
@@ -748,6 +748,7 @@ sub handle_compatible()
        $pn_arg{node}         = $node;
        $pn_arg{node_enabled} = $node_enabled;
 
+       $compatible =~ s/\\0/", "/g;
        my @compatibles = split('", "', $compatible);
 
        $compatibles[0] =~ s/^"//;
-- 
2.34.1

