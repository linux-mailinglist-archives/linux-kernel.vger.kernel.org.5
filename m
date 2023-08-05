Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18948771109
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHERmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHERmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:42:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DFE76
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:42:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68783004143so2214795b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691257340; x=1691862140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DdQ17i05e7SXOOOl5eag5513m9DyQQ031lLX7RYOeM=;
        b=z4YGgwR2elh/iFIEMIUuNAj75llc2sReLBB/7yRb9iY10hRhPLGSIKMAOsbKqiruEJ
         e85zr/jUwZeceCfIFHWnSjwCUynVarvL9gIntTCBoIFNHDNG3jBkfvS5kuXKOkkRLlYc
         lQX4Zignzpz7MQw2vQs/TjRvy4buMPaSBMCEDzA/iNe60kq3H4nwf36F00sUo4Ia0Moy
         hNl0DKN8mImdD6VcaBgs8v6ftvL2fz6IkM7C2zySYqRW/cjpzZRqndVbN+QNqgBMKIWu
         CwKRaJCs6xZEaauXEJoVLEKvQN9IFredPVAFJgHzLGaaZAhLfvyyxaizTUbNx6B0qbCw
         6Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257340; x=1691862140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DdQ17i05e7SXOOOl5eag5513m9DyQQ031lLX7RYOeM=;
        b=CPRsanpZsHFJYA/3Nfa6CmyAT+FzWJ03ovseX6JAToplzOLd2Pt215ra+8nyqptM5P
         sGoAopUKoqk81/efvPkFuFvxOTQbsDoMqjhGZZ0Jc5aaRQhEv78pLq8oKBP5//gVRSYj
         PGWkRMqXizeP/apmMuCyYUvPB5idX36F/vNj+/IwQaeqI6D64IqzJy6/OKhuyiZX0N8s
         sE5WOT4+yGC5T3KnACFsUZD1+m76she88KzqSbGG5Lszas08vNtq3LeDpG1wTg4En0Pi
         ghN16XZ5CgEG1nZ1zEeJz1RyZW8Zbk6n7zOjYkTZOvVrktUT/9v/EL8UscSvZStIljuj
         6zDg==
X-Gm-Message-State: AOJu0Yyfryvi3/CmXNQzRJoASRBEACudKUQj/r7dqwE+TLRasCudbv/Q
        V4oPaTfn4wJhRLFEg6xZKz2t
X-Google-Smtp-Source: AGHT+IFKwnABP3vDMVazc2QTk+cvtQZ8yH68NQhgjQamItU7KcCa/d/HqrT5m1bOe/BPp6jzK4AlmQ==
X-Received: by 2002:a05:6a00:2d91:b0:687:29ce:2fa6 with SMTP id fb17-20020a056a002d9100b0068729ce2fa6mr4911550pfb.7.1691257340058;
        Sat, 05 Aug 2023 10:42:20 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.21])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006874a6850e9sm3363160pfd.215.2023.08.05.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:42:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/10] mtd: rawnand: qcom: Use EOPNOTSUPP instead of ENOTSUPP
Date:   Sat,  5 Aug 2023 23:11:41 +0530
Message-Id: <20230805174146.57006-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
References: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch complains over the usage of ENOTSUPP for new patches as below:

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

So let's fix the error code which is already present in qcom_check_op().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 29fcdac932f1..a7a9421ef003 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3040,7 +3040,7 @@ static int qcom_check_op(struct nand_chip *chip,
 			    instr->ctx.cmd.opcode != NAND_CMD_ERASE2 &&
 			    instr->ctx.cmd.opcode != NAND_CMD_STATUS &&
 			    instr->ctx.cmd.opcode != NAND_CMD_PAGEPROG)
-				return -ENOTSUPP;
+				return -EOPNOTSUPP;
 			break;
 		default:
 			break;
-- 
2.25.1

