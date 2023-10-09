Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30DD7BE7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377864AbjJIR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbjJIR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:26:00 -0400
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 10:25:58 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D71B0;
        Mon,  9 Oct 2023 10:25:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78F5540E01A5;
        Mon,  9 Oct 2023 17:25:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u7iDZ9zhtPck; Mon,  9 Oct 2023 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696872352; bh=gijAMajM/qK5RS4HM86GXIGhtdXfDGU+FXlKqSNTHVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+0v3jmxQwJVT49/4+GxxxtlEf0Fk1tZ8lEF3dYrq6PD8kg9noirQ/5TDRCm6D9NI
         IUPVHHTQRXjhsCCBSJNPRHXp7Ima1Pc5oJX58xXtw9ePs/CW2DAl1KdAJQoVmrvH05
         irwAn1Xrbcj6PGSSMizdaWfC3sPoy2LmgnD4MwR48k8phpveKdWGHVX8ybbdYCkKxj
         10kEZ62hRY91hPc9tcKHKJLJRPq927ERUA4APnF8mVHVRvnxNVK2rWJrdRQL+AXUdC
         UvbvyymUV5Xs2kCFQR5mwC9qX1RNcF7KMV99/ZJ1yZKAe9hm6ysJ/POwb3TJWaPry5
         5z/GED9B6Ce5xWJneDXvPQUUGpIxh4DGrm8G4eUuN47rfavLsLZ9gzqMUP0m3g7nQ2
         6Jdg8usZ/y+jJ4I53f8/GYLoRVtIRhLLfyYmrMmSrO6BJOMA+cPX0PqpXK4Wmtbkz9
         hSu+kL4QMKBEvkTe3Ncqht5vsj5Ji4XZtt63qEyv7iVpkON0x64mVePRPFNzypj47Q
         trNnwSyUKH1kshtSU9Q8H3Rk7uig2aeXjGUgu1GElm27XEYzkoFXGImzfobTkB4JKl
         HxH7L1ISVnTqGj4FH7ZjTu1lhAAXvciDcvnZCJw0/Eosrnz5X3qVGmacl0EqMiPh0t
         oH0Bs8T8P7I6HlhTl42kaWD8=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 660BA40E0177;
        Mon,  9 Oct 2023 17:25:18 +0000 (UTC)
Date:   Mon, 9 Oct 2023 19:25:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Message-ID: <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003235430.1231238-6-babu.moger@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:54:25PM -0500, Babu Moger wrote:
> rdt_enable_ctx() enables the features provided during resctrl mount.
> 
> Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone.
> 
> Introduce rdt_disable_ctx() to refactor the error unwinding of
> rdt_enable_ctx() to simplify future additions. This also simplifies
> cleanup in rdt_kill_sb().
> 
> Remove cdp_disable_all() as it is not used anymore after the refactor.

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

Check your whole series.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
