Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AEE7FDB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjK2PZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjK2PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7306BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34D4C433CB;
        Wed, 29 Nov 2023 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271507;
        bh=kG2+ej6cJ+ghQo+0P11j+c5Gws+B/g/6ONT5dR7kBSg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dGCduNIIvZgqq/TxuYMezF3tHg4UfzJwkO+QFU+etNx5EnXi07/Dq/aHCLz5bQzqu
         gK9S/QFt7JL+C3Pw8OcXQ87oMJ47zQu7+pjtlmEvITlVIbzQm2JrmWf6/+nmUkP3ei
         48NIvmprJGh8PHWIGPSIkreSxwNU6dSty+MOxBErDg7y53pMTifxQPTeCRBnV8HQoY
         lrEs1zX8tXjYCh8sdzhrL3rczWjkrjGNKX+62qTgcpCcT6+MDHCbOBfPWbB0JeCdxE
         q+4/+TJh42PO2n+dmLa7RUMdn56EBVFUDhr8aQB/dwvilxA+g/qkGw0nttTgwOtdne
         nzqoAeVbNJyLg==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:28 +0100
Subject: [PATCH 03/12] selftests/hid: base: allow for multiple
 skip_if_uhdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-3-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1211;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=kG2+ej6cJ+ghQo+0P11j+c5Gws+B/g/6ONT5dR7kBSg=;
 b=cRFybPnwZ68SH5mCbsRVxDJcFgImN6Y5PIICvbba808TbqdFz1Ch3p8CQc+UIyA6tVhJaY+bY
 zLd5oD03G7bD+zF5g/bCAs6eMhzDrtSDwOw2wyqAvs2ZkwA226KbLuS
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can actually have multiple occurences of `skip_if_uhdev` if we follow
the information from the pytest doc[0].

This is not immediately used, but can be if we need multiple conditions
on a given test.


[0] https://docs.pytest.org/en/latest/historical-notes.html#update-marker-code

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 1305cfc9646e..5d9c26dfc460 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -238,8 +238,7 @@ class BaseTestCase:
             try:
                 with HIDTestUdevRule.instance():
                     with new_uhdev as self.uhdev:
-                        skip_cond = request.node.get_closest_marker("skip_if_uhdev")
-                        if skip_cond:
+                        for skip_cond in request.node.iter_markers("skip_if_uhdev"):
                             test, message, *rest = skip_cond.args
 
                             if test(self.uhdev):

-- 
2.41.0

