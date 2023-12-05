Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F339C805B58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbjLERYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjLERYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:24:48 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACB1A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:24:55 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D2F5640E01AD;
        Tue,  5 Dec 2023 17:24:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wPW8jgSJ8xpx; Tue,  5 Dec 2023 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701797091; bh=n3IyErXxFPFG0PeQz9giKUJNMBNrT2TNjqINEXLFw+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN10XgQQTMZ1gitXyTaxIOvDoXXmm83Kfw7uery2CS+MPyJ/cNMm9J5lelNC6gEVc
         WQYNM7xl4a0AyjlLWF9TAlffY8ecJbikSW8mN+xmubjL9EoSia2BDXagUqY8ziQ2Ay
         LpPyLkpsOEBqWNaEWb1xufC7pt8H5iVZsdrbRIfV92L9lFP1Mge3y/2qO5zcql6qJO
         rk0I+YlxxCuHTBnNjbIeenc/3ICPlkFIx0OR+XeVUiRc84CPOmMUkR2q0qyT+Sz6xf
         Ql8CSEsokQvGREIORKynKNKBZk6fCpg3sISbW1FhhqaQ7O354k/o2qZkV4OAZ+4mHl
         DAqLTSc35sZHSdaz2xkFBjbIfqC6aVLVgJ3/NaeQXBy0xBlUdTqfba6KvBuRgsrku6
         3/yjKSN6SvinG5ID18wwKEmz80WmlBe8cfEfyH5A4i3lSlTb4PTlLUIjfZO2hLsUve
         J5hjSb4s8S3FDJiM76aCPqMp5Pub20t/bd0W/0RMjvTWeMY+TN306BtKOR3l4207sh
         FbG6FQ+AsvPB3F+BUXLaPkWKBOh0vgtX3LCcdvXKf70yF0udoX+pyQZYk7+xuPiWrF
         2m9oIQRMA4Wx+um1/Vsox1LCoT0NXqsnL5OQcZXqopcj8+woIMGdXPJt0KryLXJrYn
         +z7vZ4gOc9zBmHeCEmdfji2w=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E862440E0173;
        Tue,  5 Dec 2023 17:24:41 +0000 (UTC)
Date:   Tue, 5 Dec 2023 18:24:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
 <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:16:43PM +0300, Kirill A. Shutemov wrote:
> What's wrong with using X86_FEATURE_* here?

What's wrong with using something which is already there?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
