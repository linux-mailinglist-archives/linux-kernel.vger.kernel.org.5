Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980EB801342
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379321AbjLATBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLATBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:01:01 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA6D63
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:01:07 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 60AE840E024E;
        Fri,  1 Dec 2023 19:01:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wBCvJPFLXd3I; Fri,  1 Dec 2023 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701457263; bh=wk9DOemrdJn7SRHDilSiP6PeViaO6gLWGKWuwRBqRoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJEsUsLPInXxceDDcnf+HkWTke0LXbbSwoLM3d/xsbWkY7yq5YGsbJ1tGHgrFvCyR
         T/vwA43jg9o4KyAAXW2FWpl3TyB5JcmNQgkBrzq1v3YUZKQg5GNBwVZKIpRr15Upf1
         CgZQxNB5Xo8DvlXHPUxnNobntS/meLt2ZwzF8xRTGmbkuiHk+TqsQFMgLbHXc2DO1O
         1/I0Lgwn6M7dnpJbFZPusTjrgxGLCy5fyIasJ9ePmT+XTrvRoNRYdEaP2K342R3oJx
         y+1MQN9yIz3QXnO774PXwpw0AJiSdMRF0iMcfATXS1h/KHa2Tz1WxZfXNLxp2AJob0
         VQJdK047PZlZuhFW9SP/SlbZWu58vHDnaGPy4XpA3hN5H/t2Lt1AZi9OyxNPCCgzd1
         MNY6s9lPYXQuVny+s+1ybvdFPLl8yhyCkA1TKEYkL7ooElEHJ+GwZMk0r9rtRhhioT
         3aRICUFktd71t88ZxPSYqFEjCs8ay2KRtfUNMRGXxbSO6bh4ElMOVCZM7tHrxo2tg4
         lhCWqzP4xmNgrkptQ/eBaCo8gJX/WDPprT2JqyQOOeIj9FsBM/1L8eip9mXhxOKosb
         58whQ7Dfbqx5L3D/XGtoSzzVrRWXoWlEqixE+gCC1UNE/7AAcmkFWV8gjXfTFS14uy
         ge5y5DWriOid4ovg3At1ZrNw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D977740E0239;
        Fri,  1 Dec 2023 19:00:53 +0000 (UTC)
Date:   Fri, 1 Dec 2023 20:00:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Filippo Sironi <sironi@amazon.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-edac@vkeg.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Message-ID: <20231201190053.GFZWotZTBdOdTZN3L/@fat_crate.local>
References: <20231201112327.42319-1-sironi@amazon.de>
 <ZWos70EKhlAl2VPb@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWos70EKhlAl2VPb@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:58:55AM -0800, Tony Luck wrote:
> But this does seem a worthwhile change to help diagnose things if late
> load is somehow only applied to some subset of CPUs.

We already do that, see load_late_stop_cpus().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
