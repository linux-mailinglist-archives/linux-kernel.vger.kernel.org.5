Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1037C6707
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjJLHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjJLHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:45:55 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFDEB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:45:54 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E7A4740E0196;
        Thu, 12 Oct 2023 07:45:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y-Tu1NrUSDq8; Thu, 12 Oct 2023 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697096750; bh=Eu3ZBxNKXwBJrRsvuzwKzxYy0t1l06kZ/jHAue3rPI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3eGvedO2tbEQiE6u5U1zqHkX1uQwlN6PPiRzjQqQAQ47vvy1sFSYaixQ7plg09HE
         AgpEJX4801byNeI2Izd3EnZxNgyvyN1KBm8cRyVW57wkp7bMc9miSECGAvDtuk131i
         E3pX5Ylomve2eUDRp4KJBNCuHJ+qxNiK0iq5CF4NsMenESmacQaJtcExbdBtGVGv9Z
         hCmWsHhAEHECI+YxNMPUQL/5VchZEb0HzMT6Pu7JmigLfLrcsk08eV1dNVzNE1RRPU
         1PGODVovfbWior64egZjQ6rDCv9GFXzNIdASDDjQhgBLlrtHEx1nyrQC2mnnlN5czN
         R4er+Caoo88LHYd0ukV8RcJ7oEQ5akFk0eRE7WJJWBis3kxyKFzYW2S6DlNSwikPnD
         ypn8yof441h2xcSwW47w7RaTlJIeWvvIoxZqP9bjHh8yu7tAJIrR/doxnvOwVo25Ee
         104N0wKr5LHSxAZezvYW0Fn4NCnsXWKHAiq08BSlaA8gXZCUp8aERgjAueVCgFDaUQ
         ZbLWGvFzt7mCePtV0YnULpoz/R4B7fo5Dl7Sljbkn3m14aEj3O5hw5A0TOmOjCXqAB
         o7sy2EYefqI0pSdgl14fiL1eUdYI18fJNsAI6eSUe64HgYX23G9xpaLfo+0+icSyP/
         IXVA3P7pLnNgp2RkXJiJBdjc=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9ABF40E00B3;
        Thu, 12 Oct 2023 07:45:41 +0000 (UTC)
Date:   Thu, 12 Oct 2023 09:45:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        thomas.lendacky@amd.com, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH v4 01/14] virt: sev-guest: Use AES GCM crypto library
Message-ID: <20231012074539.GCZSekIxe9KM1lG9eC@fat_crate.local>
References: <20230814055222.1056404-1-nikunj@amd.com>
 <20230814055222.1056404-2-nikunj@amd.com>
 <20231011185607.GVZSbvx8rJ8DXPqYfg@fat_crate.local>
 <3b484a1a-e6dc-3b73-ba1d-72fd6ba38ebe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b484a1a-e6dc-3b73-ba1d-72fd6ba38ebe@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:10:43AM +0530, Nikunj A. Dadhania wrote:
> Ard had added the library specifically for this use case, this was the first 
> discussion thread: https://lore.kernel.org/all/c6fb9b25-a4b6-2e4a-2dd1-63adda055a49@amd.com/
> 
> Should I add the above link instead ?

Please read up on what a Link: tag is used for.

> static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
> {
> 	return snp_dev->ctx->authsize;
> }

Or simply not use a one-liner function at all.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
