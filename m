Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78E7798A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjHKUhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHKUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:37:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71345120;
        Fri, 11 Aug 2023 13:37:12 -0700 (PDT)
Received: from localhost (unknown [86.122.17.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 659C266071A1;
        Fri, 11 Aug 2023 21:37:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691786230;
        bh=mtF0mCsh4R/MZePtjuIheuk3+v28lUM1yrXv3yXp1jQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dzFp1qFm0XV6kq4YGRuxCTmeLxZ7DiFsmH45CbDchgvXl46jP8q7mg7X1enhBaM37
         ucvVjNcMBgZ/g0znpcLqLevXgpAB34ZaTFL+aYPTolEMGrS3SEJoceCaNjFARafEXy
         kZ/p/AgECnLWDy/B4pk/EU475IM4zKsPZmNXxeK0T80+YtgOanxaaz1fOVq7GnDtbq
         TPzvFHY9ieXOuVg/5MrUa/z86aNRN5Gxj8MUOO01n8hRxgaL/dUtwKjj0cuNio4Xa5
         Nm/b6qUiC7uwcXcMtEhK90Mg1pMPDv69dNESTJ/iragpDTox4RsZh6QAH5RPFw/32k
         B2Z/s3ZAOS/mQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com,
        stable@vger.kernel.org
Subject: [PATCH] x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
Date:   Fri, 11 Aug 2023 23:37:05 +0300
Message-ID: <20230811203705.1699914-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix") provided a fix
for the Zen2 VZEROUPPER data corruption bug affecting a range of CPU
models, but the AMD Custom APU 0405 found on SteamDeck was not listed,
although it is clearly affected by the vulnerability.

Add this CPU variant to the Zenbleed erratum list, in order to
unconditionally enable the fallback fix until a proper microcode update
is available.

Cc: stable@vger.kernel.org
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b55d8f82b621..70f9d56f9305 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -73,6 +73,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static const int amd_div0[] =
-- 
2.41.0

