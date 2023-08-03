Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A876F2EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjHCSny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjHCSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C344B9;
        Thu,  3 Aug 2023 11:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C8C60C5B;
        Thu,  3 Aug 2023 18:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF3FC433C8;
        Thu,  3 Aug 2023 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088137;
        bh=E13f4XBINKwXmrolwOxdI7zeDdmYnT7QBMuC4NsAbn4=;
        h=From:Subject:Date:To:Cc:From;
        b=UT/rUOqjJh2Qp4O1QkQDWJ1OHYtbRJjv2EuvrN6+Zkc69+83mhNAPo5H/A4V3bq22
         fC1WyoQ6zvCZ/Zg+LwR3SZ+pNHlrn78QA2miZ2rbBS93ELNVyxiXBhGXNJCMYUUnXZ
         fU/Y/yA+QyFVEMg3WcYoJpedQps2+0O+JeOmSusaLZv2i1YsFA6qTi0N1zE/2FgUpf
         K6ep0HLuYSYiojSLIexHts1kDuAPBfH4ixczRWTZT6mIHufy7Joremde7ILqdpFcy7
         zlTO9V9cVAomN8n1bYdhZpvsr1RciPyiBgWBe6tXY8OAsHkO9I4VAz61i07hfNHuk2
         Z7bTs4O7xLSrQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] arm64/ptrace: Fixes for more SME only streaming SVE
 cases
Date:   Thu, 03 Aug 2023 19:33:20 +0100
Message-Id: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDyy2QC/x2MywqDMBAAf0X27EISHzX+SvEQ0m27h0bZLUGQ/
 LvR0zAwzAFKwqQwNwcIZVZeUxXbNhC/IX0I+VUdnHGdmYzDIL+xxzfvuP0lRELVTJhWvODtMI2
 d9Q/vBqiLTaiW9/65lHICaDPtFm4AAAA=
To:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E13f4XBINKwXmrolwOxdI7zeDdmYnT7QBMuC4NsAbn4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBky/UDgaBFFzyHLkNMXv57+sOYQmesz/pRXgYE4DqJ
 cDrhuSCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMv1AwAKCRAk1otyXVSH0C3LB/
 42lnC+vzVXQ/wlS9T6chEkrROSYob4mID3emSnxstXT2atXPfM8NcfSv0XwtKE4M4ohjj8vHKhxOrV
 H8sr4nzl3DqVZgS3X3FT/TDSRT8J3atrBs8eZLLtmFEwk2fFpx2HZqk/W1rN6hie99yJ5E8y6UIdx/
 h2r8I9PjYXMKHkJx54UhCgedbVZnYnVklabMOZzgcdAxxe3P7Re2ep1i+UQ0MlG+lqT108fsd1lwrq
 YwFpDQJDq7Io28p3P5mU5zciJRMTjdG7+PzDWgmBIIo8taiswhcxaakepOhr+/jAR05LtcQRVPw35B
 rOU+99AMok+nBsbmzr52ZSZNfRRfMv
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

When we added support for streaming mode SVE there were several missed
cases around ptrace, address them.  Some could be seen on systems which
do physically have SVE, others would only impact SME only systems.  The
Fixes: tag is a bit conservative for the SME only cases but it seems
like the safest and clearest choice.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      arm64/ptrace: Don't enable SVE when setting streaming SVE
      arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
      arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE

 arch/arm64/kernel/fpsimd.c | 7 ++++---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 2 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230802-arm64-fix-ptrace-ssve-no-sve-915863197925

Best regards,
-- 
Mark Brown <broonie@kernel.org>

