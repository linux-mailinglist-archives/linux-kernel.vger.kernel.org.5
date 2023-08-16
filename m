Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7777EB72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbjHPVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346401AbjHPVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:09:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261D1B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=keV/R45xM8Nm30Fi0j4Ibn0ibMz4oLujD7VmK8UEXNQ=; b=oVGCoyCLlwNz2cvu1/JZTDs/n9
        Qgtxkh2JrpjmyNgXKqNLsqPE4kR79M8ULyuaufy1m02D2kN1unQu9p0DuykdQZKjbuHUynzuv6ySE
        ZLwDyG9Tmq9s7koSNNpu/ojRVASaYPRhjej/2nsQ0QizX+RXzwUsZw5tuQiQ9gvaP6lcrpq/uzUWu
        T3Ehl7XkU430WENlbvqphlp04zoSwlA4vUMDs2rBqj09MvHfXrN2WnnYXI7tDXkhHMPBAkdElsZXn
        JMt5CWFuIltKtY1tXGL7P2AUw91YZdQ9ZLX5cMA+isWfm+7tPenhyPD5PnwdY3bWhuWCfALKgKXnK
        iBR19YYQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWNm2-0050rm-18;
        Wed, 16 Aug 2023 21:09:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] KVM: arm64: nv: select XARRAY_MULTI to fix build error
Date:   Wed, 16 Aug 2023 14:09:49 -0700
Message-ID: <20230816210949.17117-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

populate_nv_trap_config() uses xa_store_range(), which is only built
when XARRAY_MULTI is set, so select that symbol to prevent the build error.

aarch64-linux-ld: arch/arm64/kvm/emulate-nested.o: in function `populate_nv_trap_config':
emulate-nested.c:(.init.text+0x17c): undefined reference to `xa_store_range'

Fixes: d15fe1b2d2cc ("KVM: arm64: nv: Add trap forwarding infrastructure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kvm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -43,6 +43,7 @@ menuconfig KVM
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
 	select INTERVAL_TREE
+	select XARRAY_MULTI
 	help
 	  Support hosting virtualized guest machines.
 
