Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52474811D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjLMSyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjLMSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:54:10 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CEB2;
        Wed, 13 Dec 2023 10:54:17 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F63840E00CB;
        Wed, 13 Dec 2023 18:54:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zcoG-nFJKqRJ; Wed, 13 Dec 2023 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702493652; bh=e8bfGWqQN7jlEtFTw8d4r238b6Fxps9y+tq5Io28pc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXaP/+FbQNMwCok52oVms60raXIzpNrcn6C1msPBFP16C6xPhDXgtGL+GYz+x5E+0
         l6AOXSLgWbEaGwG8GAjkmDLoR6eqKJZO8cb+AMzilLSoMazjwWHgf9STXDsOKtEh76
         HimWjiZwf62VtXnzdU6Z/2/8dbeYqs2do8BuszSxR4mjBRbw126uAIGlVgPlK6iU7+
         E7qi+bgtiMQaDzPdAGwZBnQdfThGizgdwCDclUEBLi+PpyDwSfS9CvSoEGzAI04+lO
         bZ9pROCPQIoAawMIS+9dPulUiYLN0zmTUh1unxtB/iShJTI5wI6BUtf3v59xd6eVN7
         BY2lgPAGZl39yYzsNeHW6R2b650YUWykd0kkZdnMFPINLy8kiGqJpT7/FSii5eSHKC
         d4BnojkUm/Xy85qs4br4KoR1EYV7PqXCFjeKA4f6BlkAZRrGzFgg94AmPGgiQyELo3
         l4YkkdKX3BHrefOYp3eXpygrDFySXD9IoQIoGDUmWAoNTc3F3U3ojcKX9Cvt2C+cYO
         2f/o5KYscSu/daZcGnfboAa3C8DCDuyMQ8ert2AgryZ72eHmRB96dbAQx3IxJuzghS
         0f00YqTMHhOWdaR0Z3Qtel14h1zTzT7Lk8TA8LQJs3SYDbjxEqaRtsncV0HN4XMC94
         nLjoNX1NlmyFijuh9Sr5lavU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73AE840E0140;
        Wed, 13 Dec 2023 18:53:30 +0000 (UTC)
Date:   Wed, 13 Dec 2023 19:53:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
        nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>
Subject: Re: [PATCH v10 04/50] x86/cpufeatures: Add SEV-SNP CPU feature
Message-ID: <20231213185325.GJZXn9pbqnjBGrQv4A@fat_crate.local>
References: <20231016132819.1002933-5-michael.roth@amd.com>
 <0b2eb374-356c-46c6-9c4a-9512fbfece7a@redhat.com>
 <20231213131324.GDZXmt9LsMmJZyzCJw@fat_crate.local>
 <40915dc3-4083-4b9f-bc64-7542833566e1@redhat.com>
 <20231213133628.GEZXmzXFwA1p+crH/5@fat_crate.local>
 <9ac2311c-9ccc-4468-9b26-6cb0872e207f@redhat.com>
 <20231213134945.GFZXm2eTkd+IfdsjVE@fat_crate.local>
 <b4aab361-4494-4a4b-b180-d7df05fd3d5b@redhat.com>
 <20231213154107.GGZXnQkxEuw6dJfbc7@fat_crate.local>
 <e4b8326b-5b7b-4004-b0e1-b60e63bdcdd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4b8326b-5b7b-4004-b0e1-b60e63bdcdd1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 06:35:35PM +0100, Paolo Bonzini wrote:
> 1) patch 4 should have unconditionally cleared the feature (until the
> initialization code comes around in patch 6); and it should have mentioned
> in the commit message that we don't want X86_FEATURE_SEV_SNP to be set,
> unless SNP can be enabled via MSR_AMD64_SYSCFG.

I guess.

> 2) possibly, the commit message of patch 5 could have said something like
> "at this point in the kernel SNP is never enabled".

Sure.

> 3) Patch 23 should have been placed before the SNP initialization, because
> as things stand the patches (mildly) break bisectability.

Ok, I still haven't reached that one.

> Understood now.  With the patch ordering and commit message edits I
> suggested above, indeed I would not have picked up patch 4.

In the future, please simply refrain from picking up x86 patches if you
haven't gotten an explicit ACK.

We could have conflicting changes in tip, we could be reworking that
part of the code and the thing the patch touches could be completely
gone, and so on and so on...

Also, we want to have a full picture of what goes in. Exactly the same
as how you'd like to have a full picture of what goes into kvm and how
we don't apply kvm patches unless there's some extraordinary
circumstance or we have received an explicit ACK.
  
> But with your explanation, I would even say that "4/50 needs to go
> together with the rest" *for correctness*, not just to mean something.

Yes, but for ease of integration it would be easier if they go in two
groups - kvm and x86 bits. Not: some x86 bits first, then kvm bits
through your tree and then some more x86 bits. That would be
a logistical nightmare.

And even if you bisect and land at 4/50 and you disable AIBRS even
without SNP being really enabled, that is not a big deal - you're only
bisecting and not really using that kernel and it's not like it breaks
builds so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
