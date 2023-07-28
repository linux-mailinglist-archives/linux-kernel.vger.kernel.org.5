Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2A766B56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjG1LEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjG1LEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E72703
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C902620EE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E0C433C7;
        Fri, 28 Jul 2023 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690542292;
        bh=vVWkci1WwNLwwdMkSRyKEv2sVf5zEl+LCr+XUX42JUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plphevbzTjSV37PCFXvsNQlzC/EvZJRTZScGE9bIM/OQ2xl97bUbgVy6hpMNnnv/4
         XlnX/pACjixCo6RKsp0M/DgKm0XF6WN0ddA2Hxl8fRIeqsvZSmvXbMyctQLkbTJr3s
         SCM/YC8jlQ07NiIWlVl5pwBbnnrnmJvPQjgJV6BC75B0iztsF2AvrXCqDWd1rGSomt
         S1C8bBFSyXAYSNnoqch1jD611+ohDyuvuFPX2h5n+2tubtTpdecjQa6K/j2I613Mij
         ad+H9p+G6ku4iu/21smstd7ywgZwAeainC+lYpJ28jvFmBiX2qaOselkQlt5tPYXwz
         8O6+fWKlvGUYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qPLH8-0003KT-BQ;
        Fri, 28 Jul 2023 12:04:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.linux.dev, Shaoqin Huang <shahuang@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] KVM: arm64: Use the known cpu id instead of smp_processor_id()
Date:   Fri, 28 Jul 2023 12:04:47 +0100
Message-Id: <169054228043.973403.12196964393493377750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727090754.1900310-1-shahuang@redhat.com>
References: <20230727090754.1900310-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, shahuang@redhat.com, will@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 05:07:54 -0400, Shaoqin Huang wrote:
> In kvm_arch_vcpu_load(), it has the parameter cpu which is the value of
> smp_processor_id(), so no need to get it again. Simply replace it.

Applied to next, thanks!

[1/1] KVM: arm64: Use the known cpu id instead of smp_processor_id()
      commit: 1ba11daef0a9b062e40b5393d285c82ab6483730

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


