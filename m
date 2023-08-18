Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71478145D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380005AbjHRUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379996AbjHRUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D13C3E;
        Fri, 18 Aug 2023 13:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3C2617F0;
        Fri, 18 Aug 2023 20:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32F9C433C8;
        Fri, 18 Aug 2023 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391268;
        bh=WE9GdKedY0emopTr/mvPIRbpVTkJ4T2T0VGKmW2AUj0=;
        h=From:Subject:Date:To:Cc:From;
        b=tsL8mpebVofrk6FU/aaLpACk29i5Wol9y5KH6cB/ATjfKJrgdAr2r1CMqg1gjpNda
         fI9OfgixKd1wVndkv6P4NNKkSOu5aA9/fxYN2MFJzp2C3Ut0hXl6sjAF3+46f+cDsg
         gP39yjgEtfRf/MMmwuSsVWM5Gj8r6ow2OmJ3+beskXnfEqhK5fb2DF68L90zZBBXCk
         6ohm9a0qsQBg/dKgjxPaPEdz1AZns/kIKbMMF91R6Rz1ssCmlNVEUwuvbdylx4uo9G
         d3YY+Sc9UR0ABjS2aPtT4y+JjzlxIJe6If8rSr5FHeAo/JSxqdGFDtDKZQFRy2s68S
         xMeJv20433ZfA==
Received: (nullmailer pid 545135 invoked by uid 1000);
        Fri, 18 Aug 2023 20:41:06 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/6] dt: changeset fixes and cleanups
Date:   Fri, 18 Aug 2023 15:40:55 -0500
Message-Id: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfX32QC/4WOyw7CIBBFf8WwdiwPa6sr/8O4KDC0pIYaIKSm6
 b8LdeVGl3duzrmzkIDeYiCX3UI8Jhvs5HIQ+x1RQ+d6BKtzJpxyQVvKQEf4FAEjGDtjANmcZNs
 aVOooSAZlFxCk75waCjpOvq90rBzOsdRPjxuXu9s958GGOPnX9kJi5fpzLTGgIGtOBQqjODfXE
 b3DxyHPkOJL/L+DZ4fisqGsbs4a8cuxrusb68xrOhgBAAA=
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert's locking fix[1] prompted my closer look at 
__of_changeset_entry_apply() and related functions. The result is a 
couple of fixes I found and some refactoring that unifies the "old 
dynamic API" and the changeset API implementations.

[1] https://lore.kernel.org/all/c593d8389352c574b5be69d4ca4810da13326a50.1690533838.git.geert+renesas@glider.be/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- Drop print changeset entry pointers
- Add bounds check for action value
- Further rework deadprops helper to remove a property from either list
- Keep existing style for deadprops loop
- Link to v2: https://lore.kernel.org/r/20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org

Changes in v2:
- Rework debug printing to fix issues with pr_debug() not having a 
  return value with dynamic debug
- Split action print refactoring into separate patch from fix
- Make removing property from deadprops a helper function
- Rework __of_add_property()/__of_update_property() exit code
- Link to v1: https://lore.kernel.org/r/20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org

---
Rob Herring (6):
      of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
      of: dynamic: Refactor changeset action printing to common helpers
      of: dynamic: Fix race in getting old property when updating property
      of: dynamic: Move dead property list check into property add/update functions
      of: Refactor node and property manipulation function locking

 drivers/of/base.c     |  92 +++++++++++++++++-------------
 drivers/of/dynamic.c  | 153 +++++++++++---------------------------------------
 drivers/of/unittest.c |   4 +-
 3 files changed, 88 insertions(+), 161 deletions(-)
---
base-commit: 66a4210bc82e024e6de0f94298ad9230984a5924
change-id: 20230801-dt-changeset-fixes-b76b88fecc43

Best regards,
-- 
Rob Herring <robh@kernel.org>

