Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB357D8FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjJ0H1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjJ0H1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:27:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A673192
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:27:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2800dfa0dd6so253968a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698391621; x=1698996421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=58u3hL7CWznGApXZAFRx1yH6mLt0u2d4Caaa5jYtwE8=;
        b=g7LQDJ9Meg+uYLPej/GoVI3B5LrpohPOPFB4M0ltll9MZIYM+O5G6OqJvjHHph8ZCN
         wQ+WVlvQgmgN7ocg0x9r7DJ0fIcH6Mjx4ah/Jm8IfPLqSXd7fCbDiLQAJCui1VNcnG/Y
         XMhHKdh9x5BnDs5Ky1XSBe7cXxVHr+99dH5WdpVkGglPQtIPlGBh1ry/hwVJPt9YNfJh
         g/fMh6WcVdj5cYLTo/OhmmCfKzgyMbuS4ffjULHIfpQYofptZA7svOakwYOl36kChf7r
         tAMRGDvipTascDkSqq2qSC2OtdLwIxpT3qW99567xLbm+zb5X5JaZAOpPvWzW/XkCqFQ
         buIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698391621; x=1698996421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58u3hL7CWznGApXZAFRx1yH6mLt0u2d4Caaa5jYtwE8=;
        b=dszdH2wxFSPOw9w2lhMjtJLjEUIam7RKprXcvStqIQ0weU9U+LAfD7HI4txIA/0E81
         e6k6++ydLpSZb69Ub7/XauUeFlzgBHZ5wtgHWWv2uZj5EXKIlsMCCPYLI6uMFd4Agkd2
         nCfnZHJvSByLacA1hnS9OecpDXjAS5b6MvJrynYsG2Zo4prRgNjJ9Bu9X3VlfT+Ql2sW
         aPeM/yjXBhl/v/G+RFHboYH18hTm21CNTUHHzkonNssK1mOF3juk99vsqb9Vw3T/7Nn5
         vvaG1RSg+eOL2DZ2xcOAhOhw/njklsQvge+kwx8Hvb4C0y11/v0PYqhvF5azVRVjEZcG
         Dldw==
X-Gm-Message-State: AOJu0YyyRjySZPFqUN0/p8SMnX6U5RnABdM4rfVy0PKnc+2kFRETByh7
        pMaprrdZqnStEJ4TCAAgoAaygVS5UGqUJCow8snnWw==
X-Google-Smtp-Source: AGHT+IHyCv2Ya3XYbS1wbdukSecdQ9PPjuAGO07974SCybUpb3kFZxqttmAIypgdmGXrwZelU4icWdFKtWH7vyoMg4Q=
X-Received: by 2002:a17:90b:1a8d:b0:27d:3968:8366 with SMTP id
 ng13-20020a17090b1a8d00b0027d39688366mr1838181pjb.8.1698391621475; Fri, 27
 Oct 2023 00:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org> <ZS_C7ej5jDNICLkA@hera>
In-Reply-To: <ZS_C7ej5jDNICLkA@hera>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Fri, 27 Oct 2023 16:26:50 +0900
Message-ID: <CADQ0-X8fEUw2pkeWRKGsYs8cNfDnyM=ibj9emZ5Q0zL9btdz=A@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] introduce tee-based EFI Runtime Variable Service
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias,

On Wed, 18 Oct 2023 at 20:35, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san,
>
> I found some time to do some extended testing here's what I found
>
> Switching the permissions from RO->RW when the supplicant is started works
> correctly
> # mount | grep efiv
> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> # tee-supplicant -d
> [   77.374878] efivars: Unregistered efivars operations
> [   77.381604] Use tee-based EFI runtime variable services
> [   77.386862] efivars: Registered efivars operations
> # mount | grep efiv
> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> I didn't test unbinding yet, but I assume it's going to work fine and
> remove the efivar ops.
>
> Reading an writing non-authenticated EFI variables seems to work fine.
> I verified this with U-Boot and the BootOrder changed correctly.
> # efibootmgr -o 0001,0002,0000
> BootCurrent: 0002
> BootOrder: 0001,0002,0000
> Boot0000* nvme 0:1
> Boot0001* nvme 0:2
> Boot0002* debian
> # efibootmgr -o 0002,0000,0001
> BootCurrent: 0002
> BootOrder: 0002,0000,0001
> Boot0000* nvme 0:1
> Boot0001* nvme 0:2
> Boot0002* debian
>
> Writing authenticated EFI variables works the first time.
> I also dumped those variables from both Linux and U-Boot and they matched
> # efi-updatevar -f PK.auth PK
> # efi-updatevar -f KEK.auth KEK
> # efi-updatevar -f db.auth db
>
> But removing the PK at runtime fails.
> # efi-updatevar -f noPK.auth PK
> # Failed to update PK: Operation not permitted
> My guess is that the EDK2 code prohibits that, but we need to check why
> this is happening.  I also got similar failures trying to update KEK and db.

"# efi-updatevar -f noPK.auth PK" does not reach the kernel efivarfs code.
With strace, error occurs when efi-updatevar tries to open
/sys/firmware/efi/efivars/KEK-*** file.
I guess O_TRUNC option in open() is not required?

openat(AT_FDCWD,
"/sys/firmware/efi/efivars/KEK-8be4df61-93ca-11d2-aa0d-00e098032b8c",
O_RDWR|O_CREAT|O_TRUNC, 0644) = -1 EPERM (Operation not permitted)
write(2, "Failed to update KEK: ", 22Failed to update KEK: )  = 22
write(2, "Operation not permitted\n", 24Operation not permitted
) = 24
exit_group(1)                           = ?
+++ exited with 1 +++

We can use "efivar" instead to remove the keys. It also works for KEK and db.
# efi-updatevar -f PK.auth PK
# efi-updatevar -f noPK.auth PK     <--- it does not work
# efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
<--- it works

>
> But the most worrying thing is this. From Linux program KEK and db
> # efi-updatevar -f KEK.auth KEK
> # efi-updatevar -f db.auth db
>
> Reboot the machine and U-Boot complains when it tries to populate the
> runtime vars with:
> Loading Linux 6.6.0-rc2-00654-g82a013b37495 ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> Can't populate EFI variables. No runtime variables will be available <-- This

I could not reproduce this issue.
I tried the following command then reboot the board. Linux boots fine.
 # efi-updatevar -f KEK.auth KEK
 # efi-updatevar -f db.auth db

I also enroll the PK, then UEFI secure boot works.
Signed grub and signed kernel boot in UEFI secure boot enabled.

Are there any additional steps to reproduce?

Thanks,
Masahisa Kojima

>
> If you rewrite those vars from the U-Boot shell everything seems to come
> back to normal
> => tftp  $loadaddr 192.168.49.5:noKEK.auth && setenv -e -nv -bs -rt -at -i $loadaddr:$filesize KEK
> => tftp  $loadaddr 192.168.49.5:nodb.auth && setenv -e -nv -bs -rt -at -i $loadaddr:$filesize db
> => tftp  $loadaddr 192.168.49.5:KEK.auth && setenv -e -nv -bs -rt -at -i $loadaddr:$filesize KEK
> => tftp  $loadaddr 192.168.49.5:db.auth && setenv -e -nv -bs -rt -at -i $loadaddr:$filesize db
>
> Loading Linux 6.6.0-rc2-00654-g82a013b37495 ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
>
> Let me know if you need any more information
>
> Regards
> /Ilias
> On Fri, Oct 13, 2023 at 04:45:33PM +0900, Masahisa Kojima wrote:
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v8 -> v9
> > - patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
> >   is newly added
> > - remove !EFI_VARS_PSTORE Kconfig dependency, we have added a non-blocking
> >   set_variable and it just returns EFI_UNSUPPORTED.
> > - remove obvious comments
> >
> > v7 -> v8
> > Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> > - fix typos
> > - refactor error handling, direct return if applicable
> > - use devm_add_action_or_reset() for closing of tee context/session
> > - remove obvious comment
> >
> > v6 -> v7
> > Patch #1-#4 are not updated.
> > Patch #5 is added into this series, original patch is here:
> > https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas@linaro.org/
> >
> > There are two issues in the v6 series and v7 series addresses those.
> >
> > 1) efivar ops is not restored when the tee-supplicant daemon terminates.
> >  -> As the following patch says, user must remove the device before
> >     terminating tee-supplicant daemon.
> >     https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
> >
> > 2) cause panic when someone remounts the efivarfs as RW even if
> > SetVariable is not supported
> >  -> The fifth patch addresses this issue.
> >    "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
> >     not supported"
> >
> > v5 -> v6
> > - new patch #4 is added in this series, #1-#3 patches are unchanged.
> >   automatically update super block flag when the efivarops support
> >   SetVariable runtime service, so that user does not need to manually
> >   remount the efivarfs as RW.
> >
> > v4 -> v5
> > - rebase to efi-next based on v6.4-rc1
> > - set generic_ops.query_variable_info, it works as expected as follows.
> > $ df -h /sys/firmware/efi/efivars/
> > Filesystem      Size  Used Avail Use% Mounted on
> > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
> >
> > v3 -> v4:
> > - replace the reference from EDK2 to PI Specification
> > - remove EDK2 source code reference comments
> > - prepare nonblocking variant of set_variable, it just returns
> >   EFI_UNSUPPORTED
> > - remove redundant buffer size check
> > - argument name change in mm_communicate
> > - function interface changes in setup_mm_hdr to remove (void **) cast
> >
> > v2 -> v3:
> > - add CONFIG_EFI dependency to TEE_STMM_EFI
> > - add missing return code check for tee_client_invoke_func()
> > - directly call efivars_register/unregister from tee_stmm_efi.c
> >
> > rfc v1 -> v2:
> > - split patch into three patches, one for drivers/tee,
> >   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> > - context/session management into probe() and remove() same as other tee
> > client driver
> > - StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
> > - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
> >   this file does not contain op-tee specific code, abstracted by tee layer and
> >   StMM variable driver will work on other tee implementation.
> > - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> > - implement query_variable_store() but currently not used
> > - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
> >   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> > - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> > error message
> >
> > Ilias Apalodimas (1):
> >   efivarfs: force RO when remounting if SetVariable is not supported
> >
> > Masahisa Kojima (5):
> >   efi: expose efivar generic ops register function
> >   efi: Add EFI_ACCESS_DENIED status code
> >   efi: Add tee-based EFI variable driver
> >   efivarfs: automatically update super block flag
> >   tee: optee: restore efivars ops when tee-supplicant stops
> >
> >  drivers/firmware/efi/Kconfig                 |  15 +
> >  drivers/firmware/efi/Makefile                |   1 +
> >  drivers/firmware/efi/efi.c                   |  18 +
> >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 617 +++++++++++++++++++
> >  drivers/firmware/efi/vars.c                  |   8 +
> >  drivers/tee/optee/supp.c                     |   4 +
> >  fs/efivarfs/super.c                          |  45 ++
> >  include/linux/efi.h                          |  13 +
> >  9 files changed, 957 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> >
> > base-commit: b691118f2c44d16b84fc65b8147b33620eb18cac
> > --
> > 2.30.2
> >
