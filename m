Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529587DBD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJ3P7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjJ3P7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:59:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E908DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c115026985so1095054b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698681557; x=1699286357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wX1AJg/7WQTyp4dl4Ewe3drkgowrgy6jLa6X6sDxKqU=;
        b=h9s18Suj46VVSHdpoOJqzi/5MIckvn43zLcCGl6kATBemuwaKOmFLLNFrxAiprsAqW
         fSPRKx9xLuhaoHIcwvGsYE8Ypx5I1RtszsjgW2BdDo4gAKB08nOS+XQLeXWFhtu0Gkp0
         06rlp9+7sFV1gpfBBIjduOiRe5s9Fcnojxp9OIu9vvrSyLVSKBSFukHj0QAG3693HTxx
         PRHFGdzan20mTQautqo7tsvVu+qioSBU4PLB7q6HpA26UUEMT2pvWr552Ib4G+DrGhcd
         vRCxuvoHcs2BvZMCxFxUEas7VSNDaXApEmUEGPVIfdEr+sVpDhTUxCUl/RBo72UdDwSb
         PAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681557; x=1699286357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX1AJg/7WQTyp4dl4Ewe3drkgowrgy6jLa6X6sDxKqU=;
        b=ELPUsKUATuwdc42iSIHjUoK0jsKeHaZHdcXDQDfF+Vhe+kqlDnJKp7efdjr4DNp3XF
         6qEiTPADuDbBTW/ch5f1FbjFb739vZcUcHjeIStGcVLQALr6jcfVOeKhWSBzwE/c6VgL
         eUDRROCO8oTN5olCedAabpoovojKNut+wGvS+VrBlINSL+3g6ecQ/QVKmqzWPajXBH6Z
         Nhl0+zxJNbxCixX5QLphkIzKY8PofB9RvwiE8oBmMHApms13Fv+3MotJrjhpEa51RUI/
         /VmYQjWgfAa83BCl19pfdv/3PWRDruqh100pcW6o1ynHBb1K1JAz4cNXL3SFAicwaQ1R
         cxbA==
X-Gm-Message-State: AOJu0YzQq5ONmy9Ewn1NUFqYH7pr6Xu5/pD/rM2/t/uAzKsv43CiYRTE
        e7zh0pIy8cHJ3Pg29AmHhbTgVw==
X-Google-Smtp-Source: AGHT+IH2kgaKhkTEDN7eH+jlARmCJJxlK/ipJqVsaHUAM1Z4y88SPqNh4hLO1FsdtHlSTydt54QlUw==
X-Received: by 2002:a05:6a00:814:b0:6bb:aaf:d7db with SMTP id m20-20020a056a00081400b006bb0aafd7dbmr13941747pfk.29.1698681557500;
        Mon, 30 Oct 2023 08:59:17 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006c148c6767bsm176632pfh.218.2023.10.30.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:59:17 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/2] tee: optee: Fixes for supplicant dependent enumeration
Date:   Mon, 30 Oct 2023 21:28:59 +0530
Message-Id: <20231030155901.80673-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024

Fix this by separating supplicant dependent devices so that the
user-space service can detach supplicant devices before closing the
supplicant. While at it use the global system workqueue for OP-TEE bus
scanning work rather than our own custom one.

Changes in v3:

- Split patch into 2 separate ones, one for supplicant fix and other for
  the workqueue. 

Changes in v2:

- Use device names to separate out tee-supplicant dependent devices via
  this patch.
- Since user-space service is aware about tee-supplicant lifespan, so
  allow the user-space service to unbind tee-supplicant dependent
  devices before killing the supplicant. Following command has to be
  added to the tee-supplicant service file.

  $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" == *"optee-ta-supp-"* ]]; \
        then echo $(basename "$dev") > $dev/driver/unbind; fi done

Sumit Garg (2):
  tee: optee: Fix supplicant based device enumeration
  tee: optee: Remove redundant custom workqueue

 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/device.c        | 13 ++++++++++---
 drivers/tee/optee/optee_private.h |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.34.1

