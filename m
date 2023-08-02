Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8FF76D3C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHBQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjHBQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:33:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF122708
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:33:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583fe0f84a5so84463587b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994015; x=1691598815;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6zG3aq7HgfULOpkFpLUP7eMNeijJeNMHjEYaAiVC6hQ=;
        b=VuCZEi145qhlUcAKcTZDji6pWfBPamaj2odFWMmJhROdRY5IEUvKCu4CVGkJMpZ+wB
         V9rniI3v59jvL/q2jFKgHiUMRB5PHUW/8r5sNbVrzqqN6WBvWMHeUFf4wHStBJnJF8Z4
         NtcuRdUF1vQDTb5QNnOwOX0jT91LCLaTTlqbKMffe2CysvvgIGkjlsmU2dTPrbH0FK7h
         ZG0NE6YPGwn/jUk4ypNSrQ8XXVjLKFeETmeg3ajoxxmAcdZp219qB/BqnuwoGcl8oyPU
         d1q7akoDxCf3+oTZDEPi0YE2KhlPpZsKzNeSKy6CdvhCz5jfIF7XM3I+wYHI5NyzUi2R
         iloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994015; x=1691598815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zG3aq7HgfULOpkFpLUP7eMNeijJeNMHjEYaAiVC6hQ=;
        b=XRnbB0OdfeTd8Bp119IJwe8zjH39jAOAEw3VECxD+r8lMzdbM6NCpoQAZ4Xkv5iqVk
         fmHBEaDVmqoLILPlbX4QgWt9yirOltUDV5wwPyODiQZZUDG6MXvj1PxdRPwlF07Dstof
         mYQWT1PjNa9OPwNP2MHWp/cPIj2Nvmy1JMAGNJspp4yJjo2j/qF9R6QSRBTiMbyIll5n
         3JxwpgyxbtQV/LdEo1f/3bo3LkeS6QgPZ1Uzmasg5GXzA7sm3rPR9SoK+WZQH/AQa4na
         nDouP7SDhaUKXLSc4wDZQk9eL+8Oc/kRMI7bK293L6NFLyu7n99a873yXfzwgQt0ry5H
         HTAw==
X-Gm-Message-State: ABy/qLZrfjxa0tX1RG/B0zv7hrHuXeoNebsC5723zwsybA+0z9LPrOYc
        k15reFIQl3DC+ATs+9DPBs/eWmak5s5g
X-Google-Smtp-Source: APBJJlGO1qCeBmmjOPcirlf8Jm42kHHvIm0fpZyq1d6XLYjTuQYoD9pmW78dseekgWdVk/XG6XLb4eg4QhV4
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:db82:0:b0:d0e:d67d:6617 with SMTP id
 g124-20020a25db82000000b00d0ed67d6617mr120144ybf.4.1690994015388; Wed, 02 Aug
 2023 09:33:35 -0700 (PDT)
Date:   Thu,  3 Aug 2023 00:32:28 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802163328.2623773-1-mshavit@google.com>
Subject: [PATCH v4 0/8] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series refactors stage 1 domains so that they describe a single CD
entry. These entries are now inserted into a CD table that is owned by
the arm_smmu_master instead of the domain.
This is conceptually cleaner and unblocks other features, such as
attaching domains with PASID (for unmanaged/dma domains).

This patch series was originally part of a larger patch series that
implemented the set_dev_pasid callback for non-SVA domains but is now
split into a distinct series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top for testing:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/5

Thanks,
Michael Shavit

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.
- Link to v3: https://lore.kernel.org/all/20230801183845.4026101-1-mshavit@google.com/

Changes in v3:
- Add a helper to write a CD to all masters that a domain is attached
  to.
- Fixed an issue where an arm_smmu_write_ctx_desc error return wasn't
  correctly handled by its caller.
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.
- Link to v2: https://lore.kernel.org/all/20230731104833.800114-1-mshavit@google.com/

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.
- Minor changes
- Added commit to rename remaining usages of cdcfg to cd_table
- Link to v1: https://lore.kernel.org/all/20230727182647.4106140-1-mshavit@google.com/#r

Changes in v1:
- Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
- Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
- Split off as a distinct patch series from https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (8):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  33 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 234 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 3 files changed, 147 insertions(+), 142 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

