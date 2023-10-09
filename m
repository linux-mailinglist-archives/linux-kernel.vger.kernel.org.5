Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECF7BE9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378064AbjJISmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378344AbjJISm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:42:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5631A4;
        Mon,  9 Oct 2023 11:42:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2863AC433C7;
        Mon,  9 Oct 2023 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876929;
        bh=pOd28ycSTuXiUWMP0Dwr/hJLjUUz6PJ55hSKuTCzAb4=;
        h=Date:From:To:Cc:Subject:From;
        b=dUdg+Q1GNGEu1lG4+5q+dBKPNIXKRXg+XNVDksa9t4B7yiviWQtCOAEYsFdlTq1GV
         a8c30hvRV+VqasI0wjQscMsnPLVw2PCVmveO1LX2uC+HefZ7rUFM3x4psnjbOJeXsn
         RVL+eCQwM5t59B+3wZKf8Vk9PcVKwAr1feGMCQ+/X23ehYamX4NMhe4zcxeObIJYuZ
         m+7y9hN7iXY2bVOnXN+gfipCzwMYDdSZAfUt59Ayq2QGWKEXi0zsKtGEqLqtFZyTtG
         skqPReNdklQEKY5UJLnCdkpAlsZ1A4FispQQ2TP5Z3w6DYfaRO4BwKYTHH66QaZaTk
         s7dsg98nFck6Q==
Date:   Mon, 9 Oct 2023 12:42:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: venus: hfi_cmds: Replace one-element array with
 flex-array member and use __counted_by
Message-ID: <ZSRJfRdUXQOzagKr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array `data` in `struct hfi_sfr` is being used as a fake flexible array
at run-time:

drivers/media/platform/qcom/venus/hfi_venus.c:
1033         p = memchr(sfr->data, '\0', sfr->buf_size);
1034         /*
1035          * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
1036          * that Venus is in the process of crashing.
1037          */
1038         if (!p)
1039                 sfr->data[sfr->buf_size - 1] = '\0';
1040
1041         dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);

Fake flexible arrays are deprecated, and should be replaced by
flexible-array members. So, replace one-element array with a
flexible-array member in `struct hfi_sfr`.

While there, also annotate array `data` with __counted_by() to prepare
for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

This results in no differences in binary output.

This issue was found with the help of Coccinelle, and audited and fixed
manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index dd9c5066442d..20acd412ee7b 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -242,7 +242,7 @@ struct hfi_session_parse_sequence_header_pkt {
 
 struct hfi_sfr {
 	u32 buf_size;
-	u8 data[1];
+	u8 data[] __counted_by(buf_size);
 };
 
 struct hfi_sys_test_ssr_pkt {
-- 
2.34.1

