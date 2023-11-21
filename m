Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5B7F324C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjKUPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjKUPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:24:54 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A41122;
        Tue, 21 Nov 2023 07:24:45 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A375A40E0031;
        Tue, 21 Nov 2023 15:24:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id drDDm86i-tax; Tue, 21 Nov 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700580279; bh=a0pSPzA4YzTjhILwwoujLhIc7aMp0osSFxqzbXIqYJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEyYscIOlX6+wyUppG5aTmb6ifnJpO9nqTc0YTlouPrLhK9NAlxcWGTglO5rpeW6a
         bPcq5i/0niDSIOGT4mQauo0ENmzaaTj1DgMApeINw4U1TuJDE/1IaqXHcNtRXvWVXA
         qxH3Ii9pnyJbUuUdiuLQoMr6J/0zRA9aumcdAJlk2VXdKfXrAzagDWe/enfYKdExhe
         kKjUONYwdQFMBnxqYRjHp9iTJR8TGIsZZSlWgzt/cLUVxs2Pp7E/xiggcwqgt+EG2r
         cBcedfdVjpCkfj8Yjbz/ycV3bRmEZLj5xhttCFGXJUXyRHp6n6xCuvl8+lqjRu92Ta
         aq8afF6OGmHMezir7DLVbWUAqasz+ysaFXsr6mHpuRprlXnkNZkiVkPfe3WFGN59g/
         PWWyqSbHNsAfJ9rEw7Tqsuc3a7aUu1GwpCuYoJKubCKKRfDjxz2l8YX4XwTKFJwMAK
         JFj0WHiXG5IZHiULgNY3o6AgoOeZuRnR7BH1+mi9TkM72GEU5Yny/jZBBd/fmjzRmW
         cJlbQvZUn3jxKQWGYbbMk775n5JLr5rsFp+Zq35/Xf/v2iPQz1QMhM5A5+Xp+xflNH
         LCfNhTvSX9oITztDnJ3LbmrKDnkWHdchEfngAF8tkpV7OSyXb4XyLlCdS3/ZQWyrJ6
         Wsj0dt1yUXgUUysRR3z5d3io=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ED0040E01AD;
        Tue, 21 Nov 2023 15:24:00 +0000 (UTC)
Date:   Tue, 21 Nov 2023 16:23:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
        pankaj.gupta@amd.com, liam.merwick@oracle.com, zhi.a.wang@intel.com
Subject: Re: [PATCH v10 10/50] x86/fault: Report RMP page faults for kernel
 addresses
Message-ID: <20231121152353.GEZVzLiUK7HY+2eRg0@fat_crate.local>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-11-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016132819.1002933-11-michael.roth@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:27:39AM -0500, Michael Roth wrote:
> RMP #PFs on kernel addresses are fatal and should never happen in

s/#PFs/faults/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
