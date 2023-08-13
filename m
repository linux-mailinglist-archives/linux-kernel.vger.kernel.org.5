Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD00577A5CE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHMJfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:35:15 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB910FD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 02:35:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04B9F40E0196;
        Sun, 13 Aug 2023 09:35:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l5l-rZGVZUdY; Sun, 13 Aug 2023 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691919311; bh=9MUJYmIkqwU5TXZUaHKoM/IkVExu75SqDo1/Y6mqk6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDzpO3O5izTU2tj1tZu3N3syASONS9vXH/3UU1s42oOYLB7V3hehVTxwxtuOTY39Z
         IB6HFfJVffPRhhZy5RonkmWjvYN6APOYvAWgmVxpSc2KgK27YX1VQuD7pO8RjOBZ9d
         M/TzCCufs+vr9pr7b/BxxoViA1fKzMBVx+UyI1cGy5VyBOZiRY0TeBKFueNqhbOFtz
         1KYojonNgvPupqAooS7lnO5wyxNfHOqgqmJyiZhJRAHgc6K+Wjrrf8v0w9WNu+cxyb
         c7ZLtm3wwJHndrRviSvZ37sX3uhuDugJGnI7xFU1Sa3A3mmjsuwY/N8GzPXYWtDjsC
         4tww+jq0nvmjZSta+UbBRrhS9SiRy0rA9VaGYxMqNxqe85n5avdyOTBHNVrE1MiOpI
         ShfWun9Fwr3IJtONV3ad5qxMM7tZPymFJ09BQaX1b5h9oYXqpS2w5+PqXIfw6e3pnS
         cEfZ7gDhmPHn5tlXc8o+Rj1So7ZmzFD+x041pgeIePhsAHMHU+UwZi0tP/ApUsfpWH
         1+tN55pdNYunjWhRcNcqOjQi8/4qdLz8EPYsQ0VhiFSkNirR2EJCnT2EPnHr9RuZVI
         7jGjE57KozbxyguhiEm2iE1WEqv0A2XwnW394zlf/jWOArrGwZG37G68EfaZsfUFab
         LtCx36HoqZDh8ZQRVWHbQuhg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFE5740E0195;
        Sun, 13 Aug 2023 09:35:08 +0000 (UTC)
Date:   Sun, 13 Aug 2023 11:35:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
Message-ID: <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local>
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local>
 <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 02:17:25PM +0500, Mikhail Gavrilov wrote:
> > spec_rstack_overflow=off
> 
> Thanks, I checked this and it works!

Right, so you have Zen4 and it already uses the default mitigation and
no IBPB is mitigating retbleed because Zen4 is not affected. (If
retbleed mitigates with IBPB, that is also the SRSO mitigation but this
is not the case for your machine).

So yeah, I guess disabling the mitigation is one option.

Another could be if you supply:

spectre_v2_user=on spec_rstack_overflow=microcode

on the kernel command line after upgrading your microcode. That would at
least take care of protecting one user process from another.

There's no microcode for your machine yet, AFAICT, but you could still
try the above to see whether that mitigation type is better than no
mitigation at all wrt gameplay.

As to the microcode, I guess you'll get it with a BIOS update according
to:

https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7005.html

the table cell about 7000 series.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
