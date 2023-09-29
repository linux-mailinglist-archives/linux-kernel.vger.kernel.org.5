Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9477B363B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjI2PDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2PDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02480F9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205201FB;
        Fri, 29 Sep 2023 08:03:53 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 529B13F5A1;
        Fri, 29 Sep 2023 08:03:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 00/17] firmware: arm_ffa: Add FF-A v1.1
 support(notification + new memory descriptor format)
Date:   Fri, 29 Sep 2023 16:02:49 +0100
Message-Id: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB7nFmUC/12OQQqDMBBFryJZN8VkYnS66j1KkTiZ1CxUSCRQx
 LvX2l1Xn7d4vL+JzClyFrdqE4lLzHGZD4BLJWh084tl9AcLXWuouxpkCK4vSqp+XtYYJCs1EJo
 G0WpxSIPLLIfkZhpPzRkmrbC1oNpBEXfUkAc2gTxy41uL1AUyX3WMeV3S+7xS9DGPXxUV/leLl
 rW0ARyQA9RAd5emKy2TeO77/gHHJphO1QAAAA==
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3926; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=hlrtkVs14qne9no7z22SDk+56gTWNGc6pIOnrJ7hWoM=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucuPA8MQYcxU7n25Hca+uKVBCB6u4xxm7Pt0
 8zfx7sZ8l2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLgAKCRAAQbq8MX7i
 mPdHEACCQ8UizQ8/eOzqo/7Kuqge6W3eCpCcynuYQVm6bzJcX1LF91Gr2D6Nfi2lHwPo5F9WCWP
 dGxL87OSdCGqxuTDPjYQFzxIPmtm571yez7/olGtUT2/9jGoQ6vaomOXNu3M+NVMDe5OhiSCKG1
 GbhoCN4RUFp03AWj/VIiwVttr/jErppMeROhsgDIebq2JxmJK7+2KyeJpwXcgPfuqTab4+i8NyA
 EBKujr4W/fWGROyT2gFNKfaW9xviw/wo16Q6KFbYgdP1od8OhnJt0ZHxMtuIIzt8rwut0yD2PAu
 g6ytPTHKJpBQ5WZDcQ0qMbUYeamMebY46O4y8Gr4pGpKAHEyB6VIRDQiFOPZE8EoE9KtbhSjlsM
 fH9TD1aGbV8INUSzvm5SpcAQD3vy9rBuAD6wS5egtG3WcXngTkP9OxXcflPKGgi4il+/RHMiKeL
 2eRs5FMzdA9WZAxCWW0aCCSfMKQ7qJ2aMfKmW9bG/ONtqJyEDbsejGxXmqF4IW/zRCIzbQjCxip
 mmKVdeAymV+TSR6PSOELjF1BywhAGJPNGXJcfguasHyySqT4YDhDTYpVaSvBOHf4oW5zQLNVRjR
 20q7QhZNmMBmBZrCUFjA8134kSUOhpC+Q3Gs+p4e64g07UKtqtXqv5loPdxDuR8A17V8xpGKpE6
 Ru7tVxaQ53nvCtw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds initial support for the notifications and memory transaction
descriptor changes added in FF-A v1.1 specification.

The notification mechanism enables a requester/sender endpoint to notify
a service provider/receiver endpoint about an event with non-blocking
semantics.

A notification is akin to the doorbell between two endpoints in a
communication protocol that is based upon the doorbell/mailbox mechanism.

The framework is responsible for the delivery of the notification from the
sender to the receiver without blocking the sender. The receiver endpoint
relies on the OS scheduler for allocation of CPU cycles to handle a
notification.

OS is referred as the receiver’s scheduler in the context of notifications.
The framework is responsible for informing the receiver’s scheduler that
the receiver must be run since it has a pending notification.

The series also includes support for the new format of memory transaction
descriptors.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Changes in v2:
- Added a fix for MEMORY LEND operation
- Upgraded the driver version
- Added support for the new format of memory transaction descriptors
- Remove unnecessary partition ID information in the notification
  callbacks
- Fixed setting up drv_info->sched_recv_irq before enabling the SGIs
- Added missing resetting of bitmap_created in notifications_cleanup()
- Added some comments about GICv3 and SGI assumption
- Removed partition ID from the notification hash table entries as
  they are redundant/incorrect. Added the notification type instead
  (SP/VM/Framework)
- Link to v1: https://lore.kernel.org/all/20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com/

Changes in v3:
- Fixed ffa_mem_desc_offset() to not use possibly unpopulated structure members
- Fixed the parameter of handle_notif_callbacks(), must be notification type
  instead of the partition ID.
- Fetch only secure partitions and SPM framework bitmaps until we add support
  to this driver run in other than NS physical instance.
- Swapped back PACK_TARGET_INFO() arguments which I swapped in v2 with some
  confusion during the review.
- Link to v2: https://lore.kernel.org/r/20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com

---
Sudeep Holla (17):
      firmware: arm_ffa: Update the FF-A command list with v1.1 additions
      firmware: arm_ffa: Implement notification bitmap create and destroy interfaces
      firmware: arm_ffa: Implement the notification bind and unbind interface
      firmware: arm_ffa: Implement the FFA_RUN interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_SET interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_GET interface
      firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface
      firmware: arm_ffa: Initial support for scheduler receiver interrupt
      firmware: arm_ffa: Add schedule receiver callback mechanism
      firmware: arm_ffa: Add interfaces to request notification callbacks
      firmware: arm_ffa: Add interface to send a notification to a given partition
      firmware: arm_ffa: Add notification handling mechanism
      firmware: arm_ffa: Simplify the computation of transmit and fragment length
      KVM: arm64: FFA: Remove access of endpoint memory access descriptor array
      firmware: arm_ffa: Switch to using ffa_mem_desc_offset() accessor
      firmware: arm_ffa: Update memory descriptor to support v1.1 format
      firmware: arm_ffa: Upgrade the driver version to v1.1

 arch/arm64/kvm/hyp/nvhe/ffa.c     |   8 +-
 drivers/firmware/arm_ffa/driver.c | 757 +++++++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h           |  78 +++-
 3 files changed, 818 insertions(+), 25 deletions(-)
---
base-commit: 2a4ec21976317b1ce8c5cd3e4fcd9e5d769c8fc4
change-id: 20230803-ffa_v1-1_notif-e11bc9459962

Best regards,
-- 
Regards,
Sudeep

