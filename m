Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10723768C49
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGaGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGaGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:50:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE31A5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:50:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso9495515ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786251; x=1691391051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcaSH+xAT+b5wVpK8POC10eQBnpVHRHNmuLx6GhPb68=;
        b=auBIuu3b4cSfQ3gpIvHYKCevfsUjoIPARKH7iBZfpzCrl2cdD+E9HVOYxTQyPyRKnR
         jy8N8KNxPqFw04J2aZaPzQo0vx6hLB4t3F4xH3imt7Mg3OIH0iKhrkijRpIEhKVeEVBV
         qiHiB3rxpJavLVsI9BEWXgGm3WQrVhUE+7Gd5q9CNl8x7HB1nttGGOlxrT78XIskocof
         dEi2oZKcPfJI/WoJmrdEdqOTqEgc4FD7XmavWRGk1pJ81md7Oixu+sr2lIfvJmk6//DJ
         wdTHbm4Ocgb4TDvEXohZ8szkBt61kLSCKY8KKiC+660FNiiXVFRbYelqPz5b69FaUBed
         NWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786251; x=1691391051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcaSH+xAT+b5wVpK8POC10eQBnpVHRHNmuLx6GhPb68=;
        b=AM9dodswhX+QJaYY/8SumBeHUFfp2Fb2I4JYb8u5PGsoGGmgTExxEO8ykrCUMBoxWz
         sTHPPuDhfd1bs57W6DmBBmlW56mvpcxw2DkJ/IP3d/8/y7E2O8AtaYLF7DSiZyzfOuf/
         GsPYT+IcJ9y/+LCnBX6i9Ow2u05g/SjOa1APYGdbM2F2iZL3dUgk9YXyUTY4s9LN8mwu
         OrOwuRw1tg6VUpb2OLCIxIqq6+Pfn8yLU3F+SrCctlYI86F8FfCn1rZcFsYIdX1skPnN
         IxbV3kIHQlmkZV3D3DnN1Kk32d2xdLxw7GneaGwoDLKGtHjeJz7tZmmSa2PR1b+GNcS7
         yyuA==
X-Gm-Message-State: ABy/qLYf75ZhHNNt8UhdNeENyjzU5Fvxr0hNcr5uT+/en6FRFxRK+Cvr
        cNAHl4+VQDMW8/to+SY539WqXSdHE+JBvyNiHqo=
X-Google-Smtp-Source: APBJJlFRkKvvYc+VbOnQZyP4leL9g7z4uTLBlp3QQL117K/amsLVALCNlH0WafUmbOxyxanafSHzpg==
X-Received: by 2002:a17:902:e88f:b0:1b5:26d4:517d with SMTP id w15-20020a170902e88f00b001b526d4517dmr9001601plg.29.1690786251093;
        Sun, 30 Jul 2023 23:50:51 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001b8ad8382a4sm7706245plb.216.2023.07.30.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 23:50:50 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 0/5] introduce tee-based EFI Runtime Variable Service
Date:   Mon, 31 Jul 2023 15:50:35 +0900
Message-Id: <20230731065041.1447-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the tee based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
v6 -> v7

Patch #1-#4 are not updated.
Patch #5 is added into this series, original patch is here:
https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas@linaro.org/

There are two issues in the v6 series and v7 series addresses those.

1) efivar ops is not restored when the tee-supplicant daemon terminates.
 -> As the following patch says, user must remove the device before
    terminating tee-supplicant daemon.
    https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/

2) cause panic when someone remounts the efivarfs as RW even if
SetVariable is not supported
 -> The fifth patch addresses this issue.
   "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
    not supported"

Changelog:
v5 -> v6
- new patch #4 is added in this series, #1-#3 patches are unchanged.
  automatically update super block flag when the efivarops support
  SetVariable runtime service, so that user does not need to manually
  remount the efivarfs as RW.

v4 -> v5
- rebase to efi-next based on v6.4-rc1
- set generic_ops.query_variable_info, it works as expected as follows.
$ df -h /sys/firmware/efi/efivars/
Filesystem      Size  Used Avail Use% Mounted on
efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars

v3 -> v4:
- replace the reference from EDK2 to PI Specification
- remove EDK2 source code reference comments
- prepare nonblocking variant of set_variable, it just returns
  EFI_UNSUPPORTED
- remove redundant buffer size check
- argument name change in mm_communicate
- function interface changes in setup_mm_hdr to remove (void **) cast

v2 -> v3:
- add CONFIG_EFI dependency to TEE_STMM_EFI
- add missing return code check for tee_client_invoke_func()
- directly call efivars_register/unregister from tee_stmm_efi.c

rfc v1 -> v2:
- split patch into three patches, one for drivers/tee,
  one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
- context/session management into probe() and remove() same as other tee
client driver
- StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
- use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
  this file does not contain op-tee specific code, abstracted by tee layer and
  StMM variable driver will work on other tee implementation.
- PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
- implement query_variable_store() but currently not used
- no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
  Other tee client drivers use 0 instead of using TEEC_SUCCESS
- remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
error message

Ilias Apalodimas (1):
  efivarfs: force RO when remounting if SetVariable is not supported

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 fs/efivarfs/super.c                          |  45 ++
 include/linux/efi.h                          |  12 +
 8 files changed, 973 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: 2e28a798c3092ea42b968fa16ac835969d124898
-- 
2.30.2

