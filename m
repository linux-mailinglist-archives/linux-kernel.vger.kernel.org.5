Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD17DBE73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjJ3RDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3RC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:02:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020CAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:02:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc3216b2a1so10470575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698685375; x=1699290175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXEikiGWleMG1vf5W2vMzUdql/v6NvL8kEAoxYpaxGU=;
        b=VK0GmCIqP71zu24avvtvpELgK1nDWRPyEDcao85bHQManbbYIEmWkeOa6gb47ZmwaL
         O3vqnpgZWnsqld8viqVyx9w8rkLq74J6uJZZMH1Sv+HAF+tN+cqTFz+ZlGjMXtRL8/HS
         Sv29lLAUEb1RJia7bDuFvC0+x3IP/6fVP0hgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685375; x=1699290175;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXEikiGWleMG1vf5W2vMzUdql/v6NvL8kEAoxYpaxGU=;
        b=WPtROoHrIBIrj4Wjw/M0hZrIJnZu9+j2ADT213iidJu8K/sER4QhV9gcxm6EPGTi6d
         m6JFGqiTAi2B6qxKALKiKdP/uVfK3+ufUZ5WTzOi9mdCcxAgMqPD1/JsJkq7taRGb+Yv
         DwOR150/J+DcUOBTQ3yBUf+eQYVNOzRA8SVdVe6wTW0O1D54sEnBty8tBuLEQRiAJRo8
         6HwOejs7ZSvORSahjTjR0LXDa2sd2ilP0fDoPmXNUXyEmEYzKqnAQGrPuip4C+isidxQ
         i80iCBSSQjR+h2py1cVNnTBnL/maMV3zkw3AD3U6/cfyPmHI7RIWzEaNIventFl/QN6U
         ZBFw==
X-Gm-Message-State: AOJu0YyukY0UhAMN/QJVAdypfsPYyTyUNINvi3bAlc6Gb++3J5oo3C3s
        eJmBK8LqLRsw35Qelk7lJoUpVA==
X-Google-Smtp-Source: AGHT+IEDfkFK/YUrGM5UVqR7nWfsnnWui07nD9uJwqnxipParAfYoa5K9tzNeGPq+fqfK/2ui1LKuA==
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id u4-20020a170902bf4400b001cac4908537mr7821244pls.14.1698685375020;
        Mon, 30 Oct 2023 10:02:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001c625d6ffccsm2627300plg.129.2023.10.30.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:02:54 -0700 (PDT)
Date:   Mon, 30 Oct 2023 10:02:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Baoquan He <bhe@redhat.com>,
        David Windsor <dwindsor@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Lukas Loidolt <e1634039@student.tuwien.ac.at>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@amd.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xiubo Li <xiubli@redhat.com>, linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening updates for v6.7-rc1
Message-ID: <202310300946.C0E11C5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening updates for v6.7-rc1. As always,
changes made outside of the more traditional kernel hardening areas of the
tree are patches that were either explicitly asked to be carried by the
respective maintainers or were reviewed by others but ignored by regular
maintainers for the duration of the development window. One of the more
voluminous set of changes is for adding the new __counted_by annotation[1]
to gain run-time bounds checking of dynamically sized arrays with UBSan.

Thanks!

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler_attributes.h?h=v6.6#n97

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc1

for you to fetch changes up to 9cca73d7b4bfec75b2fcef751015f31691afa792:

  hwmon: (acpi_power_meter) replace open-coded kmemdup_nul (2023-10-24 14:10:53 -0700)

----------------------------------------------------------------
hardening updates for v6.7-rc1

- Add LKDTM test for stuck CPUs (Mark Rutland)

- Improve LKDTM selftest behavior under UBSan (Ricardo Cañuelo)

- Refactor more 1-element arrays into flexible arrays (Gustavo A. R. Silva)

- Analyze and replace strlcpy and strncpy uses (Justin Stitt, Azeem Shaikh)

- Convert group_info.usage to refcount_t (Elena Reshetova)

- Add __counted_by annotations (Kees Cook, Gustavo A. R. Silva)

- Add Kconfig fragment for basic hardening options (Kees Cook, Lukas Bulwahn)

- Fix randstruct GCC plugin performance mode to stay in groups (Kees Cook)

- Fix strtomem() compile-time check for small sources (Kees Cook)

----------------------------------------------------------------
Azeem Shaikh (2):
      init/version.c: Replace strlcpy with strscpy
      kobject: Replace strlcpy with strscpy

Elena Reshetova (1):
      groups: Convert group_info.usage to refcount_t

Gustavo A. R. Silva (5):
      nouveau/svm: Replace one-element array with flexible-array member in struct nouveau_svm
      nouveau/svm: Split assignment from if conditional
      drm/gud: Use size_add() in call to struct_size()
      usb: atm: Use size_add() in call to struct_size()
      ima: Add __counted_by for struct modsig and use struct_size()

Justin Stitt (13):
      um,ethertap: Replace deprecated strncpy() with strscpy()
      auxdisplay: panel: Replace deprecated strncpy() with strtomem_pad()
      bus: fsl-mc: Replace deprecated strncpy() with strscpy_pad()
      cpufreq: Replace deprecated strncpy() with strscpy()
      cpuidle: dt: Replace deprecated strncpy() with strscpy()
      firmware: tegra: bpmp: Replace deprecated strncpy() with strscpy_pad()
      HID: prodikeys: Replace deprecated strncpy() with strscpy()
      hwmon: (ibmpowernv) Replace deprecated strncpy() with memcpy()
      hwmon: (asus_wmi_sensors) Replace deprecated strncpy() with strscpy()
      EDAC/mc_sysfs: Replace deprecated strncpy() with memcpy()
      isdn: replace deprecated strncpy with strscpy
      isdn: kcapi: replace deprecated strncpy with strscpy_pad
      hwmon: (acpi_power_meter) replace open-coded kmemdup_nul

Kees Cook (32):
      hardening: Provide Kconfig fragments for basic options
      MAINTAINERS: hardening: Add __counted_by regex
      accel/ivpu: Annotate struct ivpu_job with __counted_by
      MAINTAINERS: hardening: Add Gustavo as Reviewer
      ocfs2: Annotate struct ocfs2_slot_info with __counted_by
      ceph: Annotate struct ceph_osd_request with __counted_by
      afs: Annotate struct afs_permits with __counted_by
      afs: Annotate struct afs_addr_list with __counted_by
      usb: Annotate struct urb_priv with __counted_by
      usb: gadget: f_fs: Annotate struct ffs_buffer with __counted_by
      usb: gadget: f_midi: Annotate struct f_midi with __counted_by
      drbd: Annotate struct fifo_buffer with __counted_by
      dm raid: Annotate struct raid_set with __counted_by
      dm crypt: Annotate struct crypt_config with __counted_by
      dm: Annotate struct stripe_c with __counted_by
      dm: Annotate struct dm_stat with __counted_by
      dm: Annotate struct dm_bio_prison with __counted_by
      nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
      NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
      sparc: Annotate struct cpuinfo_tree with __counted_by
      hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
      virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
      KVM: Annotate struct kvm_irq_routing_table with __counted_by
      irqchip/imx-intmux: Annotate struct intmux_data with __counted_by
      drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
      mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
      randstruct: Fix gcc-plugin performance mode to stay in group
      string: Adjust strtomem() logic to allow for smaller sources
      MAINTAINERS: Include stackleak paths in hardening entry
      virtio_console: Annotate struct port_buffer with __counted_by
      kexec: Annotate struct crash_mem with __counted_by
      reset: Annotate struct reset_control_array with __counted_by

Lukas Bulwahn (1):
      hardening: x86: drop reference to removed config AMD_IOMMU_V2

Mark Rutland (1):
      lkdtm/bugs: add test for panic() with stuck secondary CPUs

Ricardo Cañuelo (1):
      selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config

 MAINTAINERS                                   |  6 ++
 arch/arm/configs/hardening.config             |  7 ++
 arch/arm64/configs/hardening.config           | 22 ++++++
 arch/powerpc/configs/hardening.config         | 10 +++
 arch/sparc/kernel/cpumap.c                    |  2 +-
 arch/um/os-Linux/drivers/ethertap_user.c      |  2 +-
 arch/x86/configs/hardening.config             | 14 ++++
 drivers/accel/ivpu/ivpu_job.h                 |  2 +-
 drivers/auxdisplay/panel.c                    |  7 +-
 drivers/block/drbd/drbd_int.h                 |  2 +-
 drivers/bus/fsl-mc/dprc.c                     | 12 ++--
 drivers/char/virtio_console.c                 |  2 +-
 drivers/cpufreq/cpufreq.c                     |  4 +-
 drivers/cpuidle/dt_idle_states.c              |  4 +-
 drivers/edac/edac_mc_sysfs.c                  |  4 +-
 drivers/firmware/tegra/bpmp-debugfs.c         |  4 +-
 drivers/gpu/drm/gud/gud_pipe.c                |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c         |  5 +-
 drivers/hid/hid-prodikeys.c                   |  8 +--
 drivers/hwmon/acpi_power_meter.c              |  5 +-
 drivers/hwmon/asus_wmi_sensors.c              |  2 +-
 drivers/hwmon/ibmpowernv.c                    |  2 +-
 drivers/irqchip/irq-imx-intmux.c              |  2 +-
 drivers/isdn/capi/kcapi.c                     |  4 +-
 drivers/isdn/mISDN/clock.c                    |  2 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c          |  2 +-
 drivers/md/dm-bio-prison-v1.c                 |  2 +-
 drivers/md/dm-crypt.c                         |  2 +-
 drivers/md/dm-raid.c                          |  2 +-
 drivers/md/dm-stats.c                         |  2 +-
 drivers/md/dm-stripe.c                        |  2 +-
 drivers/misc/lkdtm/bugs.c                     | 30 +++++++-
 drivers/reset/core.c                          |  4 +-
 drivers/thermal/qcom/tsens.h                  |  2 +-
 drivers/usb/atm/usbatm.c                      |  3 +-
 drivers/usb/gadget/function/f_fs.c            |  2 +-
 drivers/usb/gadget/function/f_midi.c          |  4 +-
 drivers/usb/host/ohci.h                       |  2 +-
 drivers/usb/host/xhci.h                       |  2 +-
 drivers/virt/acrn/acrn_drv.h                  |  2 +-
 drivers/virt/acrn/mm.c                        |  2 +-
 fs/afs/internal.h                             |  4 +-
 fs/nfs/filelayout/filelayout.h                |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.h        |  2 +-
 fs/ocfs2/slot_map.c                           |  2 +-
 include/linux/ceph/osd_client.h               |  2 +-
 include/linux/crash_core.h                    |  2 +-
 include/linux/cred.h                          |  7 +-
 include/linux/kvm_host.h                      |  2 +-
 include/linux/platform_data/gsc_hwmon.h       |  2 +-
 include/linux/string.h                        |  7 +-
 init/version.c                                |  6 +-
 kernel/configs/hardening.config               | 98 +++++++++++++++++++++++++++
 kernel/cred.c                                 |  2 +-
 kernel/groups.c                               |  2 +-
 lib/kobject_uevent.c                          |  8 +--
 scripts/gcc-plugins/randomize_layout_plugin.c | 11 ++-
 security/integrity/ima/ima_modsig.c           |  6 +-
 tools/testing/selftests/lkdtm/config          |  1 -
 tools/testing/selftests/lkdtm/tests.txt       |  3 +-
 60 files changed, 280 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/configs/hardening.config
 create mode 100644 arch/arm64/configs/hardening.config
 create mode 100644 arch/powerpc/configs/hardening.config
 create mode 100644 arch/x86/configs/hardening.config
 create mode 100644 kernel/configs/hardening.config

-- 
Kees Cook
