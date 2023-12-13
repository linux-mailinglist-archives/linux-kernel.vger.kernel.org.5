Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF1811292
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjLMNOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:14:13 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F01B2;
        Wed, 13 Dec 2023 05:14:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A082340E0030;
        Wed, 13 Dec 2023 13:14:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GT50Oo9WgEvs; Wed, 13 Dec 2023 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702473250; bh=m2snrppLQ7GTbGpSnqzWduu6Z0rGzXlyux9VTZ0teF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtR1/pN6HJ+38oCwud2VWssYqwBAGXGNFjhPj5M+/gzmyTotisNMx51V4ZuygiAhj
         UDDVw2o/RxtoXiOoAGibgqf+LkFQSNPF0Mqga6slVaN6pXpeaAqf9e/ByYcWPaRbjP
         63tdnmsm3H4q+jxWKJ/HVM/MAtDe7WmObmazeXW2Ys05UZzkNtGWBiFO2pxoI6ZJ9j
         vyy33lAM3lpQEuQJmDcf9jHftEqjXTip9jsyMZ2F8YhY0i6OcIreQO9Md2WJVxITzB
         hC66vHDr0HRdrC5baLAsDYbY3wH5PcNxNAi8KPum9cmYnF32vbl6osIrYPsBN7S+Ri
         /jNY3hpOVzAhdNjbJPD5bBWz0ZAz/FYH4C3Ij/WZnzHXVMLomoxHkAZJrcaF0Zgh9K
         IWw12YvyYswU6RH5x/4fpNrEjM65JjQn/sLU7mRVTcsk4q41cQZOPO346kFyR6Qepy
         11NCpORCOZaBq+OGzt0AxzSwY7mMKWvvswnFd0NABatriQ40Ul2LjYCRxv7uJWYwtT
         BumMhFE7yqHqfuo6/ViXrILggitr/pHWjw5F/i6um8chigPENSYGb4h62JRRTV58Pp
         sUwV6zYLiQnMGmsfweu5LErKSq8BLkcw3qzLxkXFeWP8zITx9NHemwrffa4S1IHFIw
         x3elfcbKifriX76sdfvL2kA0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F1EA40E00CB;
        Wed, 13 Dec 2023 13:13:29 +0000 (UTC)
Date:   Wed, 13 Dec 2023 14:13:24 +0100
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
Message-ID: <20231213131324.GDZXmt9LsMmJZyzCJw@fat_crate.local>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-5-michael.roth@amd.com>
 <0b2eb374-356c-46c6-9c4a-9512fbfece7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b2eb374-356c-46c6-9c4a-9512fbfece7a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:51:58PM +0100, Paolo Bonzini wrote:
> On 10/16/23 15:27, Michael Roth wrote:
> > From: Brijesh Singh <brijesh.singh@amd.com>
> > 
> > Add CPU feature detection for Secure Encrypted Virtualization with
> > Secure Nested Paging. This feature adds a strong memory integrity
> > protection to help prevent malicious hypervisor-based attacks like
> > data replay, memory re-mapping, and more.
> > 
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> > Signed-off-by: Ashish Kalra <Ashish.Kalra@amd.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> Queued, thanks.

Paolo, please stop queueing x86 patches through your tree. I'll give you
an immutable branch with the x86 bits when the stuff has been reviewed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
