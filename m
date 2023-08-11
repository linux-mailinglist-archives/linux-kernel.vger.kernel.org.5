Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9E778E65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjHKL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjHKL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:56:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7928120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdcade7fbso261479666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691755012; x=1692359812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcPdZ2nGxjXBiRr9VgUDUf+2/h+oYQAJVXrn/kAMSKY=;
        b=mtbWXaTnOWz2UBNDIj7Py9lRxlm59CI8VyQAcyOT4mJ7ucw8tUxqjAbyGpvrEmDYRF
         fhF6IR20W9KSQZRlExFMEwdA7rfoX1o2PEo+ChUSQDsDQxJ/RFfzzI5ZZb3uY0Yqgh3i
         oLwfYJ6SppX6/IuzbQloo0bez+S7AnQCA5T92IwiRuqFDSpi+/n1ydumBMdS1e5T/Fvy
         ODJNch1RBOircYPR9/FGzFnCWvQLsRcE7MJNR1xH12IfqQUXKbOGrxTj0E6x2NWUCSEA
         ON5OmThwydny6yw4Sf3Ernz+HuyCQK/Jlqi4RYbBzryJ6mZkEwMGw7fgymH4LF4KafU9
         L5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755012; x=1692359812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcPdZ2nGxjXBiRr9VgUDUf+2/h+oYQAJVXrn/kAMSKY=;
        b=bmLhBaLfmjKtjrfhd/dTPc5fGRGfr4KNq9yZ2l4rXq+6xZTLk5fh+l5JoSXlL6wZ48
         nMPYo9yjOaryYk4HivG1WJqfCh4lklG75VBvdr9BYUmdCVbJWM4rWkQ4PoYTKZfdTXAh
         1tq75wsZNGXqgMuDQqWnztwIK791swWyS1W1SrYGk+CGkyMFJxWAXTc7K/Se5Uz25wrv
         9IFHmJOWX9Bn8W8XryTOWfxM2QW8YDU9P1aqlLWNgWNfWZOWiQ2kuvThOfXtTy2ROxIT
         ze6owuhPEciMhS5kjgp4ocWp3xXXEzsHwacgSvLNZ6mn3+YANCkytkwvFrWmMu+DGscO
         G9jw==
X-Gm-Message-State: AOJu0YzvLmxsg3n+EJqTela+/+aw0AKNV6TBGykm0OdWzrdz+IvTaao/
        7aJOx/zPd6wtw7NIYrV+2pxwVw==
X-Google-Smtp-Source: AGHT+IFhxxvnRqxptZVAyz9MunaXK7HUcUK2LI63uCPy/Om+NAaO3v2u66BqqR0VJVIugWk7DCp5RA==
X-Received: by 2002:a17:906:1db1:b0:997:deb1:ff6a with SMTP id u17-20020a1709061db100b00997deb1ff6amr1450934ejh.22.1691755012496;
        Fri, 11 Aug 2023 04:56:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm2165395ejq.190.2023.08.11.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:56:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] misc: fastrpc: Pass proper scm arguments for static process init
Date:   Fri, 11 Aug 2023 12:56:43 +0100
Message-Id: <20230811115643.38578-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
References: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Memory is allocated for dynamic loading when audio daemon is trying
to attach to audioPD on DSP side. This memory is allocated from
reserved CMA memory region and needs ownership assignment to
new VMID in order to use it from audioPD.

In the current implementation, arguments are not correctly passed
to the scm call which might result in failure of dynamic loading
on audioPD. Added changes to pass correct arguments during daemon
attach request.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8183c55283fb..42c4f603ec81 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1324,13 +1324,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	return 0;
 err_invoke:
 	if (fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+		u32 i;
 
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
+		for (i = 0; i < fl->cctx->vmcount; i++)
+			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
 		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 						(u64)fl->cctx->remote_heap->size,
-						&fl->cctx->perms, &perm, 1);
+						&src_perms, &dst_perms, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
-- 
2.25.1

