Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2667A0144
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbjINKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjINKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:09:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF11BE7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:09:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8DCC433C7;
        Thu, 14 Sep 2023 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694686186;
        bh=gUbRN8m3uh1PBa4fIwtZN8QV0v0cMfq7gaLEwIHoSRc=;
        h=From:Subject:Date:To:Cc:From;
        b=AyY1MMONwQr4O/kY+4soWVpgRFQ+fadiwJK4rdqwUKLlTY4xT96ZxVhLDnUvMXqOq
         LHWbZXHzLGkZHHtegMk/GAhSdZM0ya63L916IlLC261N5crqZvJzZd1nsmNzXY/LXq
         PDpR+z1DHNPMuhN7yl4tHCcq+818wBbZR1UGI+5lLLE6hZX9RZrg4P0ffKOf+Rcbc6
         9smThA/qAuZVgXG31ylysoBhrD4oZlN2L4CSDXOCqlMU93OTBXQwSB7lnUdTQMgFcg
         Ur3UG2kNFDdiraBermXJU5nzcKTdljpmNxU2ua0nXl70KqXphlKb7KyLO0UOAn6jk0
         5ex4ddZw1DeJg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64: Add some missing userspace ABI documentation
Date:   Thu, 14 Sep 2023 11:09:28 +0100
Message-Id: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANnbAmUC/x3MywqAIBBA0V+JWTegGb1+JVqYjjmLHmhEIP570
 vIs7k0QKTBFmKoEgR6OfB4Fsq7AeH1shGyLoRGNEqNUqMPetehI3+hXg/Y0KAZSVvatdHaFEl6
 BHL//dF5y/gAr81d7ZAAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gUbRN8m3uh1PBa4fIwtZN8QV0v0cMfq7gaLEwIHoSRc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAtvmwml7s/YA6LV7RN8GZUREjZY7z+avwQg4XvjN
 Ufg7V1eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQLb5gAKCRAk1otyXVSH0JbzB/
 9k6Prf/pI1sqSANoF0biL+mYLGq5YqWHEuCm19Vqb/qkVtIa9xu0A/o9Co+9ePZuJ/ooFV96ne0SY0
 46WvAjdMSVv5mBWosAF1YdRTwEVwDeekCreZwDy/BcKqjNOlKoYGFh4r+N1u29Rt7rlng7GkZ+EVMW
 s7LEMCJJcfTH5td6HO59cmVnnsu5XkxngQMyl4v/GMr4ZWiTzymUOdORMm91c22MfE1lVG20KoS5AT
 o/chzZfQ54Eus/tQ75TSzHuxIN+GslLiBLvtHSae3oSyzn1cw54RIRGluU2iq2jyOB/EHF5LBY1z4Y
 eBhn9pOMpgrjmEWWDbtEoKEan/b7G7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that we've added HWCAP2_HBC without updating the
documentation, and in the process also noticed that some user visible
fields in ID_AA64ISAR2_EL1 are not documented.  Fix these issues.

Given the lack of any automatic generation or auditing there's almost
certainly more fields that are broken in cpu-feature-registers.rst, I
didn't check any other registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/hbc: Document HWCAP2_HBC
      arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1

 Documentation/arch/arm64/cpu-feature-registers.rst | 10 ++++++++++
 Documentation/arch/arm64/elf_hwcaps.rst            |  3 +++
 2 files changed, 13 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230913-arm64-feat-hbc-doc-08e3d1741fdb

Best regards,
-- 
Mark Brown <broonie@kernel.org>

