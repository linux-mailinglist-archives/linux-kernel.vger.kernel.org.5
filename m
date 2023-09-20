Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8A7A729B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjITGMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjITGMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:12:07 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D08F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:12:02 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4Rr7Ts2vPTzDqfj;
        Wed, 20 Sep 2023 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1695190321; bh=sOqNuutYvTFy5bCHZpYC06+WkQct7O1GJJ6LUpEjpv4=;
        h=From:Subject:Date:To:Cc:From;
        b=FBEXyDGqg9CpP2lxNAyNPERXt3OCywVSaROB6twCglRK2Yw6DvC7Hfgm6blm9Mty6
         BPO25NqIP8LQEy+V2jnQJwsM1uwfySu3w4c3SbiW/IXwZvrUkJE/zLWNkdpgYRLvyw
         J9o3ofk1qS9+v2O1EP8YaETpLIBf388xFzm3Sgf0=
X-Riseup-User-ID: AA6E7953033817810A380B10C6E1134D69C821369C3632F1DA6F752157C0C3DD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Rr7TZ3qMKzJmsF;
        Wed, 20 Sep 2023 06:11:46 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
Subject: [PATCH 0/3] Fix a couble of bugs in drm_kunit_helpers.c
Date:   Wed, 20 Sep 2023 03:11:35 -0300
Message-Id: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeNCmUC/x3LwQpAQBCA4VfRnE2NddjhVeSwMZjU0g5S8u42x
 6+//wGTpGLQFg8kudR0ixlVWcCwhDgL6pgNjlxNTcW4nlEPXIOFiJPeYsgs4pnIkWfI357kD3n
 r+vf9ANLoEQljAAAA
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Arthur Grillo <arthurgrillo@riseup.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset started when I found a use-after-free error reported by
KASAN while running some tests that did some mocking. When trying to fix
the initial problem, I found another noon-related one.

The second bug is just a wrong argument passed to a kunit_release_action
call. Patch #1 solves that.

Patches #2 and #3 solve the use-after-free bug. This error was a bit
trickier to find. Basically, the usual order in which the kunit_actions
run is the culprit, so #2 creates a helper function to reorder actions,
and #3 uses that helper.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Arthur Grillo (3):
      drm/tests: Fix kunit_release_action ctx argument
      kunit: Add kunit_move_action_to_top_or_reset() to reorder actions
      drm/tests: Fix a use-after-free bug in __drm_kunit_helper_alloc_drm_device()

 drivers/gpu/drm/tests/drm_kunit_helpers.c | 18 +++++++++++++++++-
 include/kunit/resource.h                  | 17 +++++++++++++++++
 lib/kunit/resource.c                      | 19 +++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
---
base-commit: 37454bcbb68601c326b58ac45f508067047d791f
change-id: 20230918-kunit-kasan-fixes-88ee78002078

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>

