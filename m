Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C397D5A91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjJXSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:34:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49B9F;
        Tue, 24 Oct 2023 11:34:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso54636a91.0;
        Tue, 24 Oct 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698172452; x=1698777252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eInzOmV9CI5bvKZsQcE1o+qh/nZEiz4SXYl0oOFUVx8=;
        b=KoHLe3mEcIszexE7BQOHOietAwA7IgBuZR5a088f+TEqfqLyAjbmoGaSsYOb3SxOfX
         8WxO/07819+H1bcCnXbBaoSi9TdJzlX7CTqaf3fklgvLmzlcqIEi9ZsuejACKZlkILvo
         WmyiqJ2P7HRIYMVppfuzxkg/eOsiCBP26EFQac7YRjpMc3loKeD7b42QzpGgF73Wp0hm
         Mnh5TGlgbawXdCPU5yG8U6A4O8D21AJA3IHtbmGCduYM7rx0HNHKBEO/MPfIaYGNnHqN
         JLjHDt5IeLGwXDEzsCqGGhc9pA6i2h581iKwZ785JPLqy9QexmsRZR9I40PsZoRdPKyl
         6N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172452; x=1698777252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eInzOmV9CI5bvKZsQcE1o+qh/nZEiz4SXYl0oOFUVx8=;
        b=pN/dBjpV3LOVOBmW1t++WMEHG3fUij3zNMmdXlXDdvEjlSqrI9Y/W8vLoM/jhJ0z6H
         /4NzhN0ZbfEYCyx4Pfs8bTCjfDnKja2i7UnqLveq8mdNE3OfQV/q/nxqi+nsNmwPCgmJ
         6jCYWMkk+zxROjH1TMOuJMLQkkLkQijZR7rEIDLy/Ug1ISA0nLjD8aNxkyJ1OMMy80Yb
         Z3rz6R5UdxHKVhxtDoyjIQASbrmcTx4U1Nh1UAyj40ihVvFYl1CRkoUWo/4O3TlfoV9/
         XdoxAAoho/r99AWuHg5mV9VhyQZ0yKnDtUiLHpcWD0M2zC+ba5ccFF6j+ZRHQk7LIL8Z
         HSPQ==
X-Gm-Message-State: AOJu0YxbpSVSOwweGJqvrQ5uL2Ea9KH3GggvkhqIALrR1DxRSPwq3W6/
        sT0xiJ2FazrgyZeKY+qg7kg=
X-Google-Smtp-Source: AGHT+IF4B61LYgmB49ohAKA6Ab4qdJgSoPOKtvhEF36Uzskljg76AFvZn6JVPokXIAcmZCWGFM0fSw==
X-Received: by 2002:a17:90a:9a6:b0:27c:fa8f:4e91 with SMTP id 35-20020a17090a09a600b0027cfa8f4e91mr22597340pjo.23.1698172452246;
        Tue, 24 Oct 2023 11:34:12 -0700 (PDT)
Received: from brag-vm.. ([117.243.121.127])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0027476c68cc3sm7202125pjb.22.2023.10.24.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:34:12 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, peter.wang@mediatek.com,
        beanhuo@micron.com, quic_nguyenb@quicinc.com,
        Arthur.Simchaev@wdc.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs/core: ufshcd: Conversion to bool not necessary
Date:   Wed, 25 Oct 2023 00:04:01 +0530
Message-Id: <20231024183401.48888-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A logical evaluation already results in bool. There is no need for using
a ternary operator based evaluation and bool conversion of the outcome.

Issue identified using boolconv.cocci Coccinelle semantic patch.

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 406885671665..bbd8e83be6c6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2406,7 +2406,7 @@ static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
 				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
 				    REG_CONTROLLER_STATUS);
-	return ret == 0 ? true : false;
+	return ret == 0;
 }
 
 /**
-- 
2.34.1

