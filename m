Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3205777B81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjHJPCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:02:18 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053F2694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:02:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 310F140E0140;
        Thu, 10 Aug 2023 15:02:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nlK9i7YKfWbo; Thu, 10 Aug 2023 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691679733; bh=E3op3uuYAXrKG2BlzdmnFn4u4NHtSjU0k8Q7bb7/qpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcobG+VQ5nQZvIJkgqMdu0Y/F9Eg0Hvi17MM3c+B5TyEu0x0ly8GAd0YvL7rOuNxa
         jkv6hzhAlV9juM78paYlRFrIa92PhjJtv1PfgQkLt/YKP5uiQqFAtEr9tLDbqbHiLL
         eqWahG3VB8oh3VhqiUVMXI1Jb53+wVBeilJdL0yYry961zRlhOWbjGjFqB8NuplMe1
         ZvWsVrt7dl8PeeOSUPnv4/ErRpdYYDY3gpl4I3N5yb/30Wb9hB50JmpEmIsh4EmNKX
         tLohQ84JArGtrGP9KXsWzF2bGT+BXKkxKA7FA3H5ZgyGFY73v/VktQU4ETeUBtj/by
         z2o3xNYdaX2ySZOyieTha2EqRCBiMezDFRwNiG/zpGM/1QCrygkQwltEKO69e6gWgQ
         MV7PE80Ex7jxfbSob6YZ2vFWI0CdnWs4NUSXDwqlMrgoHDFY7uuVmXrw8GCPVxjca5
         Veca+VVGpdKAHbHOPwarCxabbJ7AhBsSg2K2Djh7/kAn4fNPAWi3z11Y5qtKvj08/V
         MfdtIlcIsMJzqix5nebRtoLBnKXc0BkcnY+zGROw5r27Zzys+Y7oQ1ttUNhQfczs05
         VGGOKvG69PVUxLUBbORXRP/p2pqOwnQNXZB8jcB/eqWrTS2/685DJYdQ35hXg8fIvY
         OYVB/9kaJR/gVi9VdSmh4Vg4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 212C040E0185;
        Thu, 10 Aug 2023 15:02:06 +0000 (UTC)
Date:   Thu, 10 Aug 2023 17:02:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 04/17] objtool/x86: Fix SRSO mess
Message-ID: <20230810150201.GMZNT76W2EFGNsOV1R@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.715361518@infradead.org>
 <20230810120615.GGZNTSt49g/2YCTGYI@fat_crate.local>
 <20230810124859.GZ212435@hirez.programming.kicks-ass.net>
 <20230810125005.GC220434@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810125005.GC220434@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:50:05PM +0200, Peter Zijlstra wrote:
> Notably 'call RET' is not what this is about. I hope the below
> clarifies.

Yah, it does, now that you've taken the time to explain it. Looking at
the commit which added it:

  15e67227c49a ("x86: Undo return-thunk damage")

it doesn't even begin to explain it. Can you please put the gist of what
you've explained here in a comment over patch_return() as it is not
really obvious - at least to me it isn't - what the rules for the thunks
are.

I mean, they're clear now but I think we should hold them down
explicitly. Especially with all the crazy patching we're doing now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
