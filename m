Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F880A405
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjLHM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjLHM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:58:01 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF510FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:58:07 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CAB640E00C9;
        Fri,  8 Dec 2023 12:58:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y9u_JkUi1icS; Fri,  8 Dec 2023 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702040283; bh=wrlfwePnzXcJn+nBLV+1nLiGWgvuAEWCyKA5BbFh85Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2tY2fSu4SNqZeerLk3iNOKwmheMH+RoBhQdvSJgskODe97/8LOMxKOUz0VqX8eWj
         fbCit3rsVu1cnwDfzsWQ/nsfUN752woaB6tOcmrmiJNpmfTyPD+hDtqE1G4lJv9Sdz
         BhZajkoqCWj1iXHY4d13oaMN0bjfRqiG2GqA0eeChuZ8Bp6g1FL9nLKyZNKdrg7Mgc
         h3Ck4z8lonjV+BIGKpbbVRV2pLAQRYnrh+lz8xDN+recgSS8b+6WjzFrxcV9qbnYIW
         rJxLrHNeRq8SiOnMQ8Dlxj3d35bJLvqkWZquE+w1jJ7iyuL0RzUQ+Gj4LwzKqAuqaO
         RA98S/BUtN4+7flMvDVeruATkoxzYj3xXmQC8ZU66hTmMfmxCm1LPcrsCigfKYtuvl
         8XIFJwiiw54LaROOGTSSMDMNjWPlBI54UmdLJD+o+1xYttX3/pzuUD7bFaDQhdQdoY
         5Sk/h/J0kvhCn5kZprFO2y2WXJLzDPinfm1KD+SixhcsYZSTna38nP76HBhAmsg0DM
         u7sHdW3rrpO8/18NdSck1xYjhGduDKgJR3qIEl/G7Idm2jTN9w9OpACVqbfcVvhS9x
         bf2Bk/EG2YpMYSM22mzFU4jejFI2/W/JDXxUzQ233N1vGyZ2Bi04AMmQzkTWaUSSaa
         QLIk7pSgPYHyGCOOQdIyRfOk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551BE40E00C7;
        Fri,  8 Dec 2023 12:57:51 +0000 (UTC)
Date:   Fri, 8 Dec 2023 13:57:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20231208125745.GAZXMSyfSPdD9i3Qnb@fat_crate.local>
References: <20231129133332.31043-1-jgross@suse.com>
 <20231129133332.31043-5-jgross@suse.com>
 <20231206110843.GCZXBWO12KW2aDq+MO@fat_crate.local>
 <cb98079d-1cbe-4034-8c55-5e71b790a887@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb98079d-1cbe-4034-8c55-5e71b790a887@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:53:47PM +0100, Juergen Gross wrote:
> Took me a while to find it. Patch 5 was repairing the issue again

Can't have that. Any patch in any set must build and boot successfully
for bisection reasons.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
