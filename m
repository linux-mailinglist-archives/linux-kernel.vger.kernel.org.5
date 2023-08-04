Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA3770C07
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHDWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHDWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECA4C04;
        Fri,  4 Aug 2023 15:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D3E62159;
        Fri,  4 Aug 2023 22:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3DEC433C7;
        Fri,  4 Aug 2023 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188931;
        bh=jNG5Ej8Kn886qqW53Bnjc+N9+7nU/vSckF6puKE8yO4=;
        h=From:Subject:Date:To:Cc:From;
        b=RSaowkPyeJoQe1u8mjy23ky1rQKFG3hI29du4iA8YRO7ICIz/pNoDUdxj+NovvYDI
         eTtH+E7beIBsiHpmc1J57C6YN+e7ABKI7gjLiCqOSlz2B28WnRLuYkGAXGOCh5eTSP
         6ci4F7cHwZFphdObELtZhcQQFC4d0kTGd1qDvsdWpeHUVij4hQK5xXz487W32dNtT5
         Dkxa8VWmyozsYbTfr4YmCzzCR+9IJTWQhBEjAw46VnZYlaDf+prieBEpv6foQybAaF
         Wg4gmyhwyNWPWsToIStjf0SfVRheKOoD5Zj6lHAmgzJFpVlyfcucAPUlFrwcuWaFcx
         bq/00I7VgdUXA==
Received: (nullmailer pid 2346972 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/6] dt: changeset fixes and cleanups
Date:   Fri, 04 Aug 2023 16:41:50 -0600
Message-Id: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5+zWQC/32OzQ6CMBAGX8Xs2ZXS+kM8+R6GAy1baDDF7DYEQ
 3h3C949zk4m3y4gxIEE7ocFmKYgYYwZ9PEArm9iRxjazKCVNqpSJbYJf0IooQ8zCdrb1VaVJ+f
 OBnJoGyG03ETXb+kwcle0qYg0p02/mfYuu2eduQ+SRv7sL0zldv27NpWo0F60MmS809o/BuJIr
 1OegXpd1y8KHP6M1AAAAA==
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

 drivers/of/base.c     |  87 ++++++++++++++++++-----------
 drivers/of/dynamic.c  | 149 ++++++++++----------------------------------------
 drivers/of/unittest.c |   4 +-
 3 files changed, 86 insertions(+), 154 deletions(-)
---
base-commit: 66a4210bc82e024e6de0f94298ad9230984a5924
change-id: 20230801-dt-changeset-fixes-b76b88fecc43

Best regards,
-- 
Rob Herring <robh@kernel.org>

