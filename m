Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587B77FDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354238AbjHQSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354385AbjHQSWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:22:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222333A80
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:21:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso1354117b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296468; x=1692901268;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1Ja32sydfixX+83wX7h07TiF6qtFK7RLvIEmQEzvNQ=;
        b=EGY/X/6YVNMl9wzbAPSer6AbPxtT5SVrmVIrLiBJ4HefEC6GJnzjLMx63wS78W8BZH
         ZO9oTY/H9wO9usAxg5l79kKbNGet0y3WIkBtpAWsgCn7Hj+1NdW7fQhkCVSJxyVPT5yu
         dlfwCrhLlEsovyvOhNMR7htDif1TP5vOX/VCy9+XPNJ0juLdtELvNQ45X4zZWNK6557O
         1wW1MKBqJp+8NGvevNI48itGw+hQJj3lyhNkBQRxNx05/MvfElFUN4v24zbJ9cOiBaNr
         IyfMdlMTbRNI8c5EpG4lObiBkYhELtMefggRYEu1hh/UywHXvZge7lz5/bxxYOP+3Ara
         bOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296468; x=1692901268;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1Ja32sydfixX+83wX7h07TiF6qtFK7RLvIEmQEzvNQ=;
        b=YmmehCvBpdS6GOeAom2BiEawmJU0dlkqL4HKbLS94GNsHr6D7LROGxMC5wZgAwzVX4
         f87gqu1Zh5YhF4Nu2nucQm8dpNye2g/CapoYHaUY/Fe4HSFXhZRQ2lPNqJUL8oKBoDYC
         sPQawUcDw8fFySWOjaQ9DdqXrBVLqflpZaVnBIUMa4leI+m1iHPl8vRvdxCeIBPdiZ4J
         igINrs/l/SaphhJn6bpvj0dwFli6bQSYzURLdlEaHDGvWfDLi+UuEHzsdPv7Rvcjpdny
         xOgWPcgzVdIx7nQaPBuMzg9Houf2G1/gxzjja/JOgJUi07TIKrqbPcrd34r27tkqkkdt
         evtw==
X-Gm-Message-State: AOJu0YytyMS9oGz+fFOt1gFiKFgxvp2iNKDF6A43fyEWlQv/OJJwasne
        K1kvMxhEj/ahvpZRDwAZHhcYTavv0Ad5
X-Google-Smtp-Source: AGHT+IG5oEIYVufYiNHO2XFMNMZIFA74NFPMUaOU4Q20FHYiA1poZhFU8Xuk/H5EktVEHQ/iC3xspN6l8hDZ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:4304:0:b0:581:3939:59a2 with SMTP id
 q4-20020a814304000000b00581393959a2mr2498ywa.3.1692296468378; Thu, 17 Aug
 2023 11:21:08 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:22 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817182055.1770180-1-mshavit@google.com>
Subject: [RFC PATCH v1 0/8] Install domain onto multiple smmus
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This series refactors the arm-smmu-v3 driver to support attaching
domains onto masters belonging to different smmu devices.

The main objective of this series is allow further refactorings of
arm-smmu-v3-sva. Specifically, we'd like to reach the state where:
1. A single SVA domain is allocated per MM/ASID
2. arm-smmu-v3-sva's set_dev_pasid implementation directly attaches that
   SVA domain to different masters, regardless of whether those masters
   belong to different smmus.

If armm-smmu-v3-sva is handed iommu_domains that have a 1:1 relationship
with an MM struct, then it won't have to share a CD with multiple
domains (or arm_smmu_mmu_notifiers). But to get there, the arm-smmu-v3
driver must first support domains installed on multiple SMMU devices.

This series depends on the CD table ownership refactor: https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
as well as the VMID IDA patch: https://lore.kernel.org/all/169087904450.1290857.11726985177314533259.b4-ty@kernel.org/#r

This series is also available on gerrit: https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24829/6

Thanks,
Michael Shavit


Michael Shavit (8):
  iommu/arm-smmu-v3: Add list of installed_smmus
  iommu/arm-smmu-v3: Perform invalidations over installed_smmus
  iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
  iommu/arm-smmu-v3: check smmu compatibility on attach
  iommu/arm-smmu-v3: Add arm_smmu_device as a parameter to
    domain_finalise
  iommu/arm-smmu-v3: Free VMID when uninstalling domain from SMMU
  iommu/arm-smmu-v3: check for domain initialization using pgtbl_ops
  iommu/arm-smmu-v3: allow multi-SMMU domain installs.

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  62 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 348 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 320 insertions(+), 111 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
prerequisite-patch-id: f701e5ac2cce085366342edff287a35d1cb82b9c
prerequisite-patch-id: c8d21ff19c2c1dd18799a6b83f483add654d187e
prerequisite-patch-id: 6ebba95cb12a723645843b4bd1bc45c94779d853
prerequisite-patch-id: 3f767e1c37d2996323c4f6d2a2d1912ab75281f7
prerequisite-patch-id: 5a4109fa3e22e2399ad064951c2ca1aeba4a68f7
prerequisite-patch-id: c4b3bd34b8be7afebd3e44bc4ec218d74753ce77
prerequisite-patch-id: 6d89e53518d25ac983ac99786950ee1a558c271f
prerequisite-patch-id: 447219e565cadc34b03db05dad58d8e5c4b5a382
prerequisite-patch-id: 63adb2c3f97d4948d96a0d5960184f5ac814d7f7
prerequisite-patch-id: e71195fcf1aa56d8ef9d7403b9e4492c17b8fb84
prerequisite-patch-id: ba82add44850bf8fb271292020edb746aef93a65
-- 
2.42.0.rc1.204.g551eb34607-goog

