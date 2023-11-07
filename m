Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC57E34E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjKGFmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKGFl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:41:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CFA3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:41:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc7077d34aso39649565ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335715; x=1699940515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pExvke3GKwm6jtHaNZg1/ZMBq7AhDlo616RHMYvk8Os=;
        b=zECazyZkSEwGo2WDNPRsBJwchIdMH1INpWksJlI+WThUpjOi1mj4h7Jy1eb00aOP7c
         UJZHvPBdThutmJpZ4IXbatyYE5ulsDNMQtV3NDc3++mKVdh44DHLGtr3cr33PedT5ddG
         WCWLiGFPFuScaJ14ihElMsRuKJVSbv0TDMuE5eOvmfIMHj4omnseH3ujhN4Tf7a+ZUSA
         gY66vIH3YgmXtvEpby8SnQ3Hhq4MrG2F9Ulxu6th7ji9HBbUZL3kv4W9sBIC1XSX6A/F
         w8cl7VcKjxowbNhF/vjVC903fswUGR4kmMd97miAnZvd/f4nG1IEzUIXhleW2eg3RWXd
         Hxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335715; x=1699940515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pExvke3GKwm6jtHaNZg1/ZMBq7AhDlo616RHMYvk8Os=;
        b=TwsAx51X8wBjHMhg5lHACr4CIUka/B8ppBlAJwb16Rq0kAlGx3GEM2hjZbrCiF4Utp
         tjw3YvIK1nOC903M597h/kYB0WiUTNzdFlxLwL6qdAer6VMQrP30sUx71JfmhNvXhRZi
         irU1gVWyHGs1Z/amGuZP0OFXFfiDmEXH5uOkdoSmSLbN5pvYNgtCQJSJ38n8djg4mxTh
         bIzID2r98T/EBsBlTHcSWf0Vna6FlDn0movMrl9MaKMwSoTzyMt8w++r+69i7rxm1jIV
         w/em1uTT9PINhUp3RnQh57qOC4pX4ZwBKKkP3WuLmGsf6OfDokGmV2pQdivuCsZICC1r
         owtw==
X-Gm-Message-State: AOJu0YziHarUZrg5fSdC/aNTizzbPRJ95AQQ6xWkBtUndpb0Jrw9c6bL
        4C6s4vPsIwwSAKZrc3DkRNmGnQ==
X-Google-Smtp-Source: AGHT+IFdea4yzI7GPObmuTsq/mBvJoa5rARaHepV+KKGzYbir/SO+EUPrFJTlGB61+xnOdLFavmc0g==
X-Received: by 2002:a17:903:44:b0:1cc:2ee4:c9bd with SMTP id l4-20020a170903004400b001cc2ee4c9bdmr19634115pla.11.1699335715163;
        Mon, 06 Nov 2023 21:41:55 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:41:54 -0800 (PST)
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
Subject: [PATCH v10 0/5] introduce tee-based EFI Runtime Variable Service
Date:   Tue,  7 Nov 2023 14:40:51 +0900
Message-Id: <20231107054057.1893-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
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

This series introduces the tee-based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

This driver depends on the tee-supplicant. When the tee-supplicant
stops, this driver needs to be unbound from user-space script or tool,
relevant patch is posted[1].

[1] https://lore.kernel.org/all/20231102073056.174480-2-sumit.garg@linaro.org/

Changelog:
v9 -> v10
- patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
  is removed

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

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 616 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 fs/efivarfs/super.c                          |  45 ++
 include/linux/efi.h                          |  12 +
 8 files changed, 951 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: 5329aa5101f73c451bcd48deaf3f296685849d9c
-- 
2.39.2

