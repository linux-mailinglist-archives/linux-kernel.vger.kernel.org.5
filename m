Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32E756E43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGQUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63292191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2102C61233
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D6AC433C8;
        Mon, 17 Jul 2023 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689625993;
        bh=0L4rzdFIpNjuoVjGBLJeqycUXeNM9eoCxaTwaIYNRAw=;
        h=From:Subject:Date:To:Cc:From;
        b=PDpdFcdaknv61TrHPQ/5C9nDPuEEK2ndUzBVRaBxijNxZgoMyvDHARmVIybFy1gDT
         dnfv0KIrV4b2fUdNTv9GhFCe8ysEtpfF3myopX1N4faB/C1VtjQSHQDOo9znPC6I8l
         UsJvHSc61gKL674glSJMpJonW0qiLpC57jEEBcL0hXUqKM1G5b/04pZIZpX9/t5y66
         pI8xWl/wpvJ8c+OLIRIf+W43U919hOHQoThgrYUVnP0guRpfq5pOaSnMJ8UKAPf+AY
         6RjHEn5IIsZ9zMQQ0vL869P9no49FGFhSffnY+PdGG92n2rfauJWrXzlL5nPJzsIha
         uNVMcnsa3gKTQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] regmap: Add interface for checking if a register is
 cached
Date:   Mon, 17 Jul 2023 21:33:02 +0100
Message-Id: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6ltWQC/x2MywqAIBAAf0X23EL2MOxXooPYqktkoRCB9O9Jh
 znMYaZApsSUYRYFEt2c+YxVZCPABhM9IW/VoWu7vp2kwkT+MBdaYwNhxe6onNK9doOkbYQaXok
 cP/90Wd/3A5kJhLlkAAAA
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0L4rzdFIpNjuoVjGBLJeqycUXeNM9eoCxaTwaIYNRAw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktaWE0PV8fiHE+4Js3G/p5QP5gwc0nXg+zpR5Q
 cIX5iLcBMeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLWlhAAKCRAk1otyXVSH
 0GQSB/wMO/T1ZL7PngGGld7rnQe97ZB9EseO7p1nbUMPZxoz9RF6gc9ICtFFjCSEmpWI6n6iNQZ
 J2bjge8lUMQbBtBbfWmBSsPnEdxk2B6Du3FqPEdVLF0W52B3IoG+DqDxleJ4/8qSLqgLmfbzFss
 CN/grgcymOgblRULNSQrkBi1wGp+nHCa5jdAsTzpqL4CGLlp1JuzUW7fh5kiClLdIXC11nSXsnm
 bvQMmyPRlr3QiZH8sxraheQliy/rMJQUadAwwdmpmhSeAEQ5vm1tn2YBOBHrlm8W7vVrSxceteJ
 hhqm+Edq1zSG2DhbWQvtx1STt4cDMaqx5fxv4s5QrkHdXcH8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA has a use case for checking if a register is present in the cache
which it awkwardly open codes with use of _cache_only() and a read,
provide a direct API for this.

---
Mark Brown (3):
      regmap: Let users check if a register is cached
      regmap: Provide test for regcache_reg_present()
      ALSA: hda: Use regcache_reg_cached() rather than open coding

 drivers/base/regmap/regcache.c     | 23 ++++++++++++++++++++++
 drivers/base/regmap/regmap-kunit.c | 40 ++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h             |  1 +
 sound/hda/hdac_regmap.c            |  9 +++------
 4 files changed, 67 insertions(+), 6 deletions(-)
---
base-commit: 3953d5c79c21defa716624a8623c4157c0f2fee0
change-id: 20230716-regmap-cache-check-6f6939f41ed5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

