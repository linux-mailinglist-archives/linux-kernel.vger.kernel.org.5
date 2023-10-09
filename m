Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0D7BE8C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377367AbjJIRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377363AbjJIRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:54:17 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3E7B0;
        Mon,  9 Oct 2023 10:54:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9441240E01AE;
        Mon,  9 Oct 2023 17:54:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0CiAvHbR9mVC; Mon,  9 Oct 2023 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696874049; bh=i/j0OqkNn03WF1sTLiFxayA42GEe0D2CmVhv18YAMgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsEnz61PR/B5T5JdHZ9FYwMe9UJ2S3Y7D8QbMKeLWsdXMLp6KX91r5/zn63sYZtbw
         mw3WsGZgj6x2kmVAGTW5v0RromlYDdectq0JWxrc13RpQgMw0SmKVw5OpbMfW69kyp
         99ywaB3HU83V0owlWOUVgF05UcAF1QulhDTNey/Q44DW0TSgWCHwCaNPR4mRowb/Ew
         9JyNNMVkTm25AfQLOUY0+HAxqo4dQ9xre1+dbLi5+ojuyl3T1aiLszOT9VsDQYdUx3
         h5h+QeyphhYcZbVQ+rY0gC+bwhiHSK6dkg/VyEwv0XjeeeSul+eH0P9G5WzSBECIWs
         XhYQLzmMxn0D37lBVTbGJBeyh19FU5DKCz/LrvS5Rq1jPKqnrB2LVYLgolNxqau3fd
         DMyHl4AXV7PJF6sXr8U8YWG+/TNySO2yQQpklUasVaKJyFhKyVgzHexTl6lYI/heO9
         o1LdaFLoXYW4NEISqGOMBgK/zsRkqvJvaXZgXcREGhxAo/Vr9Vgcmll0qx5PdqHszq
         2BaYACUJ8RlDSoC4EpaUXu7+qcLO2D4twWf/tHwHtul9gndkh/jp1po7eQSMKAmqvx
         lYx3AhKeYYgg/K6aDFttLXU5+rOjpAJ8S8m/M4UKR0Y6nYIpP+KcnKV/ZxWkoBSifx
         MfmLmkoN6mYqWNy93g3sA7SM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C5C940E0187;
        Mon,  9 Oct 2023 17:53:35 +0000 (UTC)
Date:   Mon, 9 Oct 2023 19:53:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
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
Subject: Re: [PATCH v11 03/10] x86/resctrl: Rename rftype flags for
 consistency
Message-ID: <20231009175329.GDZSQ+GZ45pgTiSMOX@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-4-babu.moger@amd.com>
 <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
 <1f571145-90ac-45be-9da1-681dc200051e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f571145-90ac-45be-9da1-681dc200051e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:48:38AM -0700, Reinette Chatre wrote:
> My apologies here. Babu was following my guidance on this.

No worries, that's the "next level review" kicking in. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
