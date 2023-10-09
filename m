Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF57BE7A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377421AbjJIRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377398AbjJIRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:20:07 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856DA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:20:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8140840E01AD;
        Mon,  9 Oct 2023 17:20:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X-1eWUJPZh-I; Mon,  9 Oct 2023 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696872000; bh=6uKOwNAtIi+7iLgXjvjrx+/QVcVmKqKtiRu/yGVcehU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROAPEIGG1Dw+xwZ27N75PtOaWSQkGYDcIjkoeTTKlXMjbJeWsaLrwImLHaiTmR37f
         W37eyVbQkfVBpbrN9o43US8IrxPmPr6KZhzU467ATgL1jWVHPu2GpIgIxUH1zxfJ86
         rJoSrO5fqtxG8O86rJE4I6K7fCNYJnrjxuHOO7u7pFI+RaQcJbsEWlA3hWgMFhjwiQ
         o8eoO6KTb1nVTXqu5C6VE47TkAFpmR4B87N3lmUd++63vWPkLuiL6Uq/OfhImIbkDo
         gu6I81iXfr0qbJX/3++KILKNEoNbzqkb5DJ0gdT3LjmbzDjM7l6lZ5WEuPDE6/zu+C
         dhBlzcyi/UItt/80t6j0FTpKnkb8mxYlnPbrOoAk2R1uqyYelvW27+CfBGTU24+vlm
         qq3y+jvMhM3aCCCB39AL51OkMf/aVfrsOAHgxkAjZsV8clB8/gFKZ4ZLg0uyYzSyru
         AF/mfpj9UVhABxmazeeErSxx3xndCb9KypJnIoSnZ19x6xdVN6nEu1QgRkgzzoiYS1
         sAlQQaSR5QmiSTaz3BdgaKn4vOYYFGa2rOlW7MeTXyip6cagWuevMg62D2o4aPEm2y
         t3er02Qk8J3kokinwE3iFHRm5Rtsa7Fk9eO+Kdgw4En4oDxkK6tb1KRMaOilUr9ypk
         MA4s30hCnUobhHncQGeB87NQ=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 505EB40E01AA;
        Mon,  9 Oct 2023 17:19:26 +0000 (UTC)
Date:   Mon, 9 Oct 2023 19:19:18 +0200
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
Subject: Re: [PATCH v11 03/10] x86/resctrl: Rename rftype flags for
 consistency
Message-ID: <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-4-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003235430.1231238-4-babu.moger@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:54:23PM -0500, Babu Moger wrote:
> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
> complements existing RFTYPE_CTRL_BASE and represents files
> belonging to monitoring groups.

First of all, the concept of "later patch" has no meaning when the
patches go into git, depending on the listing order.

Second, why isn't this define added in the patch that's using it?

A patch needs to be a logically separate, possibly self-contained
change - remember that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
