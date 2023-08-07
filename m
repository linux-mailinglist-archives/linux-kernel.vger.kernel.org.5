Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E137730BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHGU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHGU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:58:05 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D25E50
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:58:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 695E540E00B0;
        Mon,  7 Aug 2023 20:58:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k1a4WUfUNJwk; Mon,  7 Aug 2023 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691441879; bh=Fmf4mylQfj0W3cNLFzo56y1ShMEDu5cZQ4/QlemZDOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glaSD0k4UbRu/W2MVle9VkNpTSBni1U6BB/Wytd6yWVTHP4DZkqYCJEmZvjtLgeks
         9+7sFn7Zhi/OR7p9i+ipbmza7ad45ip+ItIYgqeiPiV7VTRx4cKFa1w6Qb8Mp157nB
         dHardTekbmqtRs+/vnblyAnuDxPTQMuwBqXAco5DQfE9eVUUPTnrLhPNr2Seg3IW5F
         Z7Yr6j8Yvtazw6JSgBxDjFCoXUREM/G3lfhVqHjhRAUUsYPHQjvfrMKrwmZQTBt9+E
         jScZ+d1/Yxt1Am4lVROxE3FsSOe9711+E6gmzL0yWz8AA/Octb/ZamsbP+FWJ+vW9Y
         pAQNOWTx4I/fhzoTMUm+sXHBdAIOhBTeyiiD4K3EEpAy+jy9LIKVFxgMOpq6wUwH+N
         ED2EBaXvBdztcA4oYhWjIe2EQQmcNXiLF6pT8k20A64h7mJZgUNtfG5uwJ5FwKjVn1
         jrTmQTIqh/9jNt30pvLtxxpvHo5dXCCKm2yE4tnuQw4GPIHWAJaSyy9Wxnf4XbCeyL
         oHWkDyTmaoaDhmT1uACxnf+nr3LBx6rR0APsRXBTWUR3Uk98QwqFDjbN14ThMLACru
         b7dgh1/h1PXdXOAWcVxH9qcVDneKmOz9+iN77oCVGx3Azkbcwg2oMqvpLEQZIpI35k
         ktc8FmvkekD6gLgXvY8UJV3o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60F0940E0194;
        Mon,  7 Aug 2023 20:57:53 +0000 (UTC)
Date:   Mon, 7 Aug 2023 22:57:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: potential null pointer dereference in setup_cpuid_table
Message-ID: <20230807205746.GJZNFaytU85YvQCd3C@fat_crate.local>
References: <0012c64a-26cb-131d-7abb-29f6741af944@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0012c64a-26cb-131d-7abb-29f6741af944@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:22:42PM +0100, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis with cppcheck found a potential null pointer dereference in
> function setup_cpuid_table in arch/x86/kernel/sev-shared.c as follows:
> 
>         if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len <
> PAGE_SIZE)
>                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
> 
>         cpuid_table_fw = (const struct snp_cpuid_table
> *)cc_info->cpuid_phys;
> 
> 
> cc_info is being null checked, so it's potentially null,

You mean, it is not null if the check passes?

> however, the assignment to cpuid_table_fw is dereferencing cc_info.
> Either cc_info is never null and the null check is redundant, or there
> is a potential null pointer dereference.

I'm not sure what you're asking. It is checked for !NULL in the if
clause.

Or are you missing the fact that sev_es_terminate() actually terminates
the guest so that if it is NULL, it won't ever be dereferenced?

Or am I missing something?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
