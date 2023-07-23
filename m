Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3839275E502
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGWVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGWVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:17:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F80E52
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:17:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583c48a9aa1so9688587b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690147077; x=1690751877;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ClyfQRII0KmHt/9r+i0dJc4DTXIAKS+yHZIsBKwm8b0=;
        b=j4Iv6UMTgCAZpk+GOIgvsm5SoPDEVKa3yHiChXovsJAjaTsKLJwsd6ihUoZgOjn+Ei
         Vz0OupFPWW5drRE02+02C4o/WHFDB0+U866ETV6R0Yczyow+OkhWAWipQTgPKGWtvXxf
         1v4TkIjz34NedtuvYZz1EE6ltvXutCWxKUx30amy68jnkyL0qJceNKs0XL1SBjDispzB
         aPYZb7nWmTAmehxMKTA3ln7V6SO3HTCTyAuS3MQdS92h+Pvm4YL8FbFUfMH4KeXvxmMA
         hXJmpRFEU0oLsSpUWkNSVXWjtEh6IQwoKU7dfhEDFz169mbC82/XQVjKgiic5ZgNfG9l
         ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690147077; x=1690751877;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClyfQRII0KmHt/9r+i0dJc4DTXIAKS+yHZIsBKwm8b0=;
        b=jdAjjhorfUZs+c8v67CcvGW7zsrAXslMRYZJ24+WVU/X/Jgy1AIkTKNnwnNOVqURqR
         YNE2wbdNjo5qC3f2/djbzshdRoNYNWI7LW7JIQAMMyxDLN+MI+i5StAHVrDLx1pYrsr4
         yQU44CGrcUech4/iohkAsUCw4rhHGrqa+J8CF/yJon/gx2p8tSfLIiO0jWR8ufE8tYyb
         H+AcbnYzKO5BMfJLX72gbDRSH4mjIu+Kn8V1fKE3WFSywJuC4dVw6UWBFz1Ut8I6NWBa
         3KV9sZOT5+bjPD6X7tdKamQc0bAClAeffy8f8C6oLZgZ/PhmPkfLtGUGA+HRAF/YMjOG
         USDg==
X-Gm-Message-State: ABy/qLZGdVEvGiZcZtNKQlT1RkNRQW62WEQuOLA9uV+OPswKn9ORuOpY
        2pX/Ec9UbXvGcQ7PaYyNjUb1ng==
X-Google-Smtp-Source: APBJJlHahDDGpI2cgHome4itZU+LQz7FHUyWtt38KqofgJTDGg3Tf49kES+F1V1vdSJSSh1GFcGSJw==
X-Received: by 2002:a81:6a45:0:b0:577:3c17:5b2c with SMTP id f66-20020a816a45000000b005773c175b2cmr4330199ywc.27.1690147077357;
        Sun, 23 Jul 2023 14:17:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b185-20020a0dd9c2000000b005707b90331dsm2411955ywe.10.2023.07.23.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 14:17:56 -0700 (PDT)
Date:   Sun, 23 Jul 2023 14:17:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Laura Abbott <labbott@fedoraproject.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, regressions@lists.linux.dev
Subject: [PATCH mm-hotfixes] mm/pagewalk: fix EFI_PGT_DUMP of espfix area
Message-ID: <22bca736-4cab-9ee5-6a52-73a3b2bbe865@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting x86_64 with CONFIG_EFI_PGT_DUMP=y shows messages of the form
"mm/pgtable-generic.c:53: bad pmd (____ptrval____)(8000000100077061)".

EFI_PGT_DUMP dumps all of efi_mm, including the espfix area, which is
set up with pmd entries which fit the pmd_bad() check: so 0d940a9b270b
warns and clears those entries, which would ruin running Win16 binaries.

The failing pte_offset_map() stopped such a kernel from even booting,
until a few commits later be872f83bf57 changed the pagewalk to tolerate
that: but it needs to be even more careful, to not spoil those entries.

I might have preferred to change init_espfix_ap() not to use "bad" pmd
entries; or to leave them out of the efi_mm dump.  But there is great
value in staying away from there, and a pagewalk check of address
against TASK_SIZE may protect from other such aberrations too.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/
Fixes: 0d940a9b270b ("mm/pgtable: allow pte_offset_map[_lock]() to fail")
Fixes: be872f83bf57 ("mm/pagewalk: walk_pte_range() allow for pte_offset_map()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pagewalk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 64437105fe0d..2022333805d3 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -48,8 +48,11 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (walk->no_vma) {
 		/*
 		 * pte_offset_map() might apply user-specific validation.
+		 * Indeed, on x86_64 the pmd entries set up by init_espfix_ap()
+		 * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW clear),
+		 * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk them.
 		 */
-		if (walk->mm == &init_mm)
+		if (walk->mm == &init_mm || addr >= TASK_SIZE)
 			pte = pte_offset_kernel(pmd, addr);
 		else
 			pte = pte_offset_map(pmd, addr);
-- 
2.35.3

