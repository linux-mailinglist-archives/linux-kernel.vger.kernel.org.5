Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D880094C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378470AbjLALGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378447AbjLALG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:06:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB2197;
        Fri,  1 Dec 2023 03:06:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701428792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEhlj+ipjqr4tEgJOcMvjQsGJg7PSMW3Lo0ITUjqyJ8=;
        b=gVfDLjU5umc+p3JXfSXFKIMVGVVvh/YAfNpBHT1q4t9H27RaW8vqhGxIzPvK5LwXvQwvdF
        /JYPTDKNgMJUwy1VQmekKDtiuw9J5MRT8kLobRdLxKlvOUfGx43e57Db2Cd7dAx9syetOZ
        BU7cmbjv5BmHUc0EAy6VO+z0aR26jT/u8M8FH2BQ6+zo9e37Okp4KeSLznfNh/tj+3D+nn
        JUnzrC6xa7Oy2ZtOmEpsPXJWO6wneo3/X5sumqAOekkfTiY5vVbLzAykjFEs+lfH/gjvHp
        2hQwTTxf7jJz2QGhGaXroHm9dcH/i6GePiLaIo9jyy0ijxHr/8RoxXDlbrf0jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701428792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEhlj+ipjqr4tEgJOcMvjQsGJg7PSMW3Lo0ITUjqyJ8=;
        b=supcOG+ERH+rcQKMhNStZbjQi0qWHuaxf3SWtVLs0rM9jaVZ7Iy5x6/vAzCqSSHennIM26
        dvRnrytMPd0gRKCA==
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 08/21] drivers: base: Implement weak arch_unregister_cpu()
In-Reply-To: <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
Date:   Fri, 01 Dec 2023 12:06:31 +0100
Message-ID: <87sf4mxjuw.ffs@tglx>
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

On Tue, Nov 21 2023 at 13:44, Russell King wrote:
> ---
> An open question remains from the RFC v2 posting: should we provide a
> __weak stub for !HOTPLUG_CPU as well, since in later patches ACPI may
> reference this if the compiler doesn't optimise as we expect?

You mean:

extern void foo(void);

    if (!IS_ENABLED(CONFIG_FOO))
    	foo();

The kernel uses this pattern for years and if someday a compiler starts
to fail to eliminate the call to 'foo()' for CONFIG_FOO=n then you
already get hundreds linkage fails today.

So adding one more in later patches won't matter much :)

