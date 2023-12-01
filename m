Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3A8008C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378384AbjLAKpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378344AbjLAKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:45:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8110D7;
        Fri,  1 Dec 2023 02:45:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701427507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEECtfSCuNJnYbbSSxaa7Yhx563AZhnbYIPY9oqxOFE=;
        b=T3NEQtyO3UjVNcOPdRfDLPqBbceTA/S3RG5pLrN/U1R54Q2+LC7E1qyZMq6Qdr2Lwq04Q7
        o3RbMWPKuiDtnTWhcOihAwr10MgQL4MPJzwPuXjSE8T6gp+VGjfk6u/Ymyla3VOKfAsmmc
        Ccc1ZPp7aRV0WvqXtoVD6atSILRTlOYC+gmZcP1quvkiE5ooEnP1dGy3CQhMQmnhHkyoNi
        fjrSBFLZgwtCeutL0TuwQN8B6ZHMA2t6ITEqL89vyADio0MnrI5DVfPUnv3HUa3tTRDL7e
        +EhhGYzs843vvIZov1ZEMz4EArysm5xib9rklBXUl6z6IburTOa1nE4pPpkQBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701427507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEECtfSCuNJnYbbSSxaa7Yhx563AZhnbYIPY9oqxOFE=;
        b=5ivKSLWokv5u4EWLeFetTD8/zTFsnE28leOpFAM1uIFAuW0E1rMX60gedKhj/gj0RQebhI
        nzpCyFo1nVj5NNDA==
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/21] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
In-Reply-To: <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
Date:   Fri, 01 Dec 2023 11:45:06 +0100
Message-ID: <87v89ixkul.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups. However, attempts to discuss this just end
> up in a black hole, so this is a non-starter. Thus, if this needs
> to be done, it can be done as a separate patch.

Offline CPUs have 0 capacity by definition....
