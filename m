Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2687800664
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377931AbjLAI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:59:14 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C275A8;
        Fri,  1 Dec 2023 00:59:19 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8BxuOhloGllYSg+AA--.22465S3;
        Fri, 01 Dec 2023 16:59:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxG9xkoGll4ndRAA--.49050S2;
        Fri, 01 Dec 2023 16:59:16 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        zhaotianrui@loongson.cn
Subject: [PATCH v2 0/2] LoongArch: KVM: Add LSX,LASX support
Date:   Fri,  1 Dec 2023 16:46:17 +0800
Message-Id: <20231201084619.2255983-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxG9xkoGll4ndRAA--.49050S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaotianrui <zhaotianrui@loongson.cn>

This patch series add LSX,LASX support for LoongArch KVM.
There will be LSX,LASX exception in KVM when guest use the
LSX,LASX instructions. KVM will enable LSX,LASX and restore
the vector registers for guest then return to guest to continue
running.

Changes for v2:
1. Add interface to return CPUCFG2 features which have
been supported by current KVM to user space. So that
user space can get CPU features such as FPU,LSX,LASX
whether support by KVM.
2. Add CPUCFG2 checking interface to check that if the
value which is passed from user space has any errors.
3. Export both _restore_lsx_upper and _restore_lasx_upper
to keep consistency.
4. Use "jr ra" instruction to repalce "jirl zero, ra, 0".

Changes for v1:
1. Add LSX support for LoongArch KVM.
2. Add LASX support for LoongArch KVM.

Tianrui Zhao (2):
  LoongArch: KVM: Add LSX support
  LoongArch: KVM: Add LASX support

 arch/loongarch/include/asm/kvm_host.h |  18 ++-
 arch/loongarch/include/asm/kvm_vcpu.h |  22 ++++
 arch/loongarch/include/uapi/asm/kvm.h |  19 ++--
 arch/loongarch/kernel/fpu.S           |   2 +
 arch/loongarch/kvm/exit.c             |  36 ++++++
 arch/loongarch/kvm/switch.S           |  36 ++++++
 arch/loongarch/kvm/trace.h            |   6 +-
 arch/loongarch/kvm/vcpu.c             | 153 +++++++++++++++++++++++++-
 8 files changed, 276 insertions(+), 16 deletions(-)

-- 
2.39.3

