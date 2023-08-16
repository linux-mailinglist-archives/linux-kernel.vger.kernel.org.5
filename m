Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA477DB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbjHPHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbjHPHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:38:48 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFF10FF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:38:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AE8940E0145;
        Wed, 16 Aug 2023 07:38:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ArqFugcEgMk; Wed, 16 Aug 2023 07:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692171522; bh=vL5+kIWXkEVH6CBWgwYCFaNCsnJM5VBQ3ljb61UVHRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB1HWHZa1JVnfhxLRujVku1OvBO3x5WnHvDSSt50QazZ4wPDXb58QISP5dfp0ZCFS
         JkdhhMW/UYIBj9xsLlonzNybhnR52Q7A3gX+c1IKJjnf6JZBaBcijqdNQ+KUc39NTi
         1kbXdzh38qYxqn3cwRv6wVtWP9e/ZUt6CRwYyKJ0b8bQkHTD+dKuBuPSGg/15++IzQ
         rTO+eeRRI1RaZka6CkGsDZaHRXMCZO/7gHU1QgOyvJ4JDUw8MPf1ky9dMppY12dzqw
         54TI0M0TYjOPp8V5590V68WYr3uMbbqiC9XMBRkcfvu6hdNkOeY/FnhT8RfE2ooV/a
         Ee2aUivn8K+8L9FrbOGz++X87KjIlT/2xoCndY4ctfbBN97mlHdXGaw7cqWBjNn721
         g0GcSVrYRq8oB5H83w9LzHiYiAYtx/i0iE041vriLsN0lY92g7pOApc5w9HLZdxOT5
         4/h96d1ctyyMhWlx/TAcQg5tfRwF2nMFxnnWDKTWv77fGO0DVQTSm5Qoir7nlJQ9uY
         O7Y/0KmHFFlwpnba8kEnBVsc6Qpoezvo46jbUZzPFQzzmSNkzrNp6eG+l7MuWt0PK+
         KiugJiAmd5XtACH3AZSasfcttR/tMmQ66LjUHSbB0Q15FAuJhsBFdlACjKt6y7q1r6
         aiyP8pu2OXv1ody7oSwcc6h4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E8E840E0196;
        Wed, 16 Aug 2023 07:38:33 +0000 (UTC)
Date:   Wed, 16 Aug 2023 09:38:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816073828.GAZNx89HT8mYCOxvV1@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
 <20230815212931.GA3863294@dev-arch.thelio-3990X>
 <20230815224348.GE971582@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815224348.GE971582@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:43:48AM +0200, Peter Zijlstra wrote:
> Yeah, Boris and me fixed that yesterday evening or so. I'm not sure
> I still have the diffs, but Boris should have them all somewhere.

Even better - all the urgent fixes I've accumulated so far are coming up
in tip's x86/urgent.  I'd appreciate people testing it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
