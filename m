Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B977F349
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349609AbjHQJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349644AbjHQJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4252712
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861E96624C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FB1C433C7;
        Thu, 17 Aug 2023 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692264574;
        bh=ATFhiqQYGtf7XSdLFtfhm7uPNRDZX+9/ckUNnAISAaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/yMp9yjVqE9oCBvNELwGcrG5nrZe0FTtWKEC7JDtkAJvbXyPiJCmE2pImgd2e2fw
         iAf0bmFgkCgps1N86jj5fsmdFysRtqNVwaeHl3jonDVUsg66+L3Fd6hPQHaqaaV9x2
         lQ5RoEvwAnsbC3zLgOCabnCqH9mHwVsfTfJ6EmQ4cMa+6U+MoUBKu2K0uMeMfiu5lT
         zrg5s7udb1a15t/Uwt6C2vviMTaHNvl3Y6RGgJaAcpSeRU9tpVcFJLLOE4Yz/SDehF
         vxBphZCvJUo8+ICHr5NWNvUud2j3xewhsMLwxxJ01cvuSxvZP0JpXqVpLlV8LKjCbf
         e3BkN9Zff3vaw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qWZJr-005dbs-OY;
        Thu, 17 Aug 2023 10:29:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kvmarm@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: nv: select XARRAY_MULTI to fix build error
Date:   Thu, 17 Aug 2023 10:29:29 +0100
Message-Id: <169226452281.2753740.17444795240191131192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816210949.17117-1-rdunlap@infradead.org>
References: <20230816210949.17117-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rdunlap@infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 14:09:49 -0700, Randy Dunlap wrote:
> populate_nv_trap_config() uses xa_store_range(), which is only built
> when XARRAY_MULTI is set, so select that symbol to prevent the build error.
> 
> aarch64-linux-ld: arch/arm64/kvm/emulate-nested.o: in function `populate_nv_trap_config':
> emulate-nested.c:(.init.text+0x17c): undefined reference to `xa_store_range'

Applied to next, thanks!

[1/1] KVM: arm64: nv: select XARRAY_MULTI to fix build error
      commit: 60046980bf60ed8846113b484d666a5fdf413be4

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


