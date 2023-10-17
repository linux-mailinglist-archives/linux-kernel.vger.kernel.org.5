Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DB7CCA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQSUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjJQSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:20:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1503C9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:20:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5995aa42so7799001276.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697566833; x=1698171633; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cogZn6SR2Hrm3xwpZC/9u1+k1saONFiJF3pmAllmSYA=;
        b=OJ7VhqFYvc7y9VXkTowPxf9eo2598iYFLcoo6Wz3YzrRqXIjEiaGUk3rX8F6VXXm+V
         slVA/qE3GARelgEnRMRGwQk/sHypIplRyoP7iFFWNixvhwU2A0LtXmM4kZluRzO1Pn1e
         ZeuYaUL9s/am4uV6BFk8/+Mpn3FjbCReaQLhVc7M0oUmEkta0414h/A4m61x/K0e6Yq4
         OkXgx4YWU1Eux6/Su/4Qk2LCm9Ut5nZquLasFipiIyXSGdR+qGfu+QVUwI5FSBpfLILm
         xp9iYXjB/RM4CSLcdmCyD2PLiC8xN85JwJliq7VAHUAerhg9Wi0nCVbAoeoy4aRAfgkv
         09mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697566833; x=1698171633;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cogZn6SR2Hrm3xwpZC/9u1+k1saONFiJF3pmAllmSYA=;
        b=I6IVhCObO+9yh5qlmc6PBdU2hRg/BUzuZ/SYUz3FFzCCdc50EXUZJqGP84rTY7zX7e
         ryXYJtjHMunDUscaSNbRa1QwwCg/n02khhLArg50N2e3wq6b48fCMxxGbWHZVobZNQME
         DRkVoq2LxYtqUxbCOjlIkV9Ba3mMWb1fbxbNju3+hxeLj4agCZFNv2Bt1Uv//ly+dxQj
         TEzJtnqnvfbEdTkqTKkFgkp5YFTIeQiHlED3iB2kNQrj7/R93llKujkMIhNpxK+udGEk
         82FXj4OKMLuAQv1F6TM/MblwNkLTxwfntnjdznsq5OB/pLnQaqTM8yJTEVzbPMqC6xKO
         j7Kw==
X-Gm-Message-State: AOJu0Yx4726fHiibWVbJWM3AE+Q/9FwJOQJxs0zBpAroP0rumsfqwwlG
        mA8ZbFJp6cn2jQ5r8mkPFitJPIsjE7o2LPIPmQ==
X-Google-Smtp-Source: AGHT+IEpgKHFswJWt16YETcyCpL2RTWhu2Rca3LfIdPF0vh7gFgWhUwDiXg6AYDmdBtS+FxsRbSWaLdeSBlJ4FshJw==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:72:205:c52:2f36:304a:2c97])
 (user=danielmentz job=sendgmr) by 2002:a25:6984:0:b0:d8b:737f:8240 with SMTP
 id e126-20020a256984000000b00d8b737f8240mr61351ybc.0.1697566833277; Tue, 17
 Oct 2023 11:20:33 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:20:26 -0700
Message-Id: <20231017182026.2141163-1-danielmentz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
From:   Daniel Mentz <danielmentz@google.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Daniel Mentz <danielmentz@google.com>,
        Mars Cheng <marscheng@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yen-lin Lai <yenlinlai@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utf16s_to_utf8s does not NULL terminate the output string. For us to be
able to add a NULL character when utf16s_to_utf8s returns, we need to
make sure that there is space for such NULL character at the end of the
output buffer. We can achieve this by passing an output buffer size to
utf16s_to_utf8s that is one character less than what we allocated.

Other call sites of utf16s_to_utf8s appear to be using the same
technique where they artificially reduce the buffer size by one to leave
space for a NULL character or line feed character.

Fixes: 4b828fe156a6 ("scsi: ufs: revamp string descriptor reading")
Reviewed-by: Mars Cheng <marscheng@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Yen-lin Lai <yenlinlai@google.com>
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8382e8cfa414..5767642982c1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3632,7 +3632,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		 */
 		ret = utf16s_to_utf8s(uc_str->uc,
 				      uc_str->len - QUERY_DESC_HDR_SIZE,
-				      UTF16_BIG_ENDIAN, str, ascii_len);
+				      UTF16_BIG_ENDIAN, str, ascii_len - 1);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ret; i++)
-- 
2.42.0.655.g421f12c284-goog

