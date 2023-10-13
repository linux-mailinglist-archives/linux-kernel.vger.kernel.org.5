Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9C7C7ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJMHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjJMHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:46:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474DB8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c894e4573bso14082855ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183177; x=1697787977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewp5d0GdnTaPJ/PGFKxoqno7I2L0UuFeVNMjQ7iyAbQ=;
        b=TwV8O1NCR8WbVqmH+a39lbV7DwZmsuMUrYit/mUP1a7GI1duNhl76B03aD/15a5v8h
         +B1erdKOXAjqMxzkSozP7vispS5QzUmO5z6/Mfo2YV2MLFlufeqT7MPzHHmJFNQ2MMn0
         Ax72DZ8EzPEtW/8KMi4lxLBhQy9DAe57p8Jp0mnXhGD88QU3nkIDVJ9EzEepjekKlOli
         3Vkkm+2lLr5K3o5u29n6mKpsiYs7aJ9dscnOCVrK3Cric5q9FsuiMiSwWHOyrb9YTjFC
         QLsRTN+NMQsK5DszqeIgGGYm1oxIB4tUDHVZbeH4wSNgcm6rny/RF6DclhoQgBORYM+K
         uuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183177; x=1697787977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewp5d0GdnTaPJ/PGFKxoqno7I2L0UuFeVNMjQ7iyAbQ=;
        b=L8Al8buiROE4kZCZRzCG/8HUADIb/0eMP1jypxLeKP3+Oq4RJJEdj6v6v/qhZdtWRy
         My9M6zgh3z0x9Hq45xlQanQdq/MON5TwxeKrLzScK/w3MTnXqdWcei+ZnEH0OxZuOE22
         a8CyF1tAcjNeXaUs/+whIqLP8ZTX4Ll0Hyq+5erFscI+b76EhuFo/yUDT49WfHxIqsQK
         5vaGV60OORa/lzTSpJWgiYdvhIg4G8neTaBwhM7DGCJV8YuohBPoDtoa9grPCN9V9gc/
         81JEzh0uwfChHMRTlJQWigNIs4QQF2AXGGR6CTHIUtTiZ8g69VEboO4E7yGhkKUHUWvM
         GsUQ==
X-Gm-Message-State: AOJu0YyS3SXWr63AaPIelIuQkwlFvnLYD7IGX2lzl4cj2aON/qQjFZE0
        CFXX7yCwsKk8cAqpPDA+qIKsVg==
X-Google-Smtp-Source: AGHT+IGT6nxLk3DZAQUnvrGVjzjDYVEjVPuinYPPMvbgUag9oy3N9gJQRDf3hvc4ijlNOZeJ2wXXLQ==
X-Received: by 2002:a17:903:234e:b0:1c6:1fc3:6857 with SMTP id c14-20020a170903234e00b001c61fc36857mr29805484plh.27.1697183177427;
        Fri, 13 Oct 2023 00:46:17 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001c9ccbb8fdasm3200548plg.260.2023.10.13.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:46:16 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 0/6] introduce tee-based EFI Runtime Variable Service
Date:   Fri, 13 Oct 2023 16:45:33 +0900
Message-Id: <20231013074540.8980-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
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

This series introduces the tee based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
v8 -> v9
- patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
  is newly added
- remove !EFI_VARS_PSTORE Kconfig dependency, we have added a non-blocking
  set_variable and it just returns EFI_UNSUPPORTED.
- remove obvious comments

v7 -> v8
Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
- fix typos
- refactor error handling, direct return if applicable
- use devm_add_action_or_reset() for closing of tee context/session
- remove obvious comment

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

Masahisa Kojima (5):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag
  tee: optee: restore efivars ops when tee-supplicant stops

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 617 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 drivers/tee/optee/supp.c                     |   4 +
 fs/efivarfs/super.c                          |  45 ++
 include/linux/efi.h                          |  13 +
 9 files changed, 957 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: b691118f2c44d16b84fc65b8147b33620eb18cac
-- 
2.30.2

