Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E37778E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjHJM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjHJM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:56:45 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC1269F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:56:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C56EB40E0185;
        Thu, 10 Aug 2023 12:56:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aC0e7F8bTKSQ; Thu, 10 Aug 2023 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691672199; bh=1ROWRSn7ZjjPf5ghDrLy0u7akcHqMVt17mcbLUN33DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcFwvVcFNw7KV0uEM3lT0vZP3eb53ghLVCfX6uBhOWzAHtGXid2XLtIx2HSsEJ0sN
         7QSgkOQ4m6X4hDnn6isMbpq0qqCxyQjh7xNjTsr3jWFsI19FTW1f6LhQcfEX0DgaNd
         ZIe9qKiF3E0xOIERJrBF7WP7Mg15enMjwEzTyvri08e6DyTleKv/a3wOvfqLqw386+
         zKMVXSfm0QaMGqFMvw6/+usrljASm63SQpfH5ysf6SH6yu4M4ln+BTtAJIw521qc0Y
         NxSd7F6gIL2/sbM9Z5NdjibWnRyoAoE/RhMRgHIm76Ff/e2uIJwqzXK842OtjCo38D
         JZOTZVHsbQSlF2YhBmJxGitECjvPKxSHJ+CrJgda2zPGL+H9iEeB/4P2Tpi8uxyiE3
         jMBgNybO6L579sLkIy99zFYJWoYu6ZP0nRBhhCoobT5QGc4cli06Vg5eWlx3MqM210
         LerfOsdGAekYsom/GYwvitW/unq8X6NCWmLOIzYSLbm0aHro6/fmzPgtXmT2Ktwa+w
         WvT4fup+lt2hFu3LwGWiithKH9uTENK6Rex64Jn0jq4kO59UXh6Yz2m29F9MNq36g6
         xtBOxnZBoQatoDNgDYdtTQ6xXxKd0CG43nlBlTqw/AbDi9zUZBOgx38f6LJGsenXk8
         HFBaBogGDUcAT0qm07Qvv7gE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C364B40E01A0;
        Thu, 10 Aug 2023 12:56:32 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:56:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230810125631.GJZNTef8zQWjoA9KYB@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
 <20230810123756.GY212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810123756.GY212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:37:56PM +0200, Peter Zijlstra wrote:
> It does; so zen1/2 use the decoder thing to flush BTB entry of the RET,
> both retbleed and srso do.
> 
> Then zen3/4 use the aliassing trick to flush the BTB entry of the RET.

Yes, I was correcting your "instruction aliasing". It is "BTB aliasing"
by causing those bits in the VAs to XOR.

> Then both srso options use RSB/RAP stuffing to force a mispredict there.

They cause the RETs to mispredict - no stuffing. That's the add $8,
%rsp in the zen3/4 case which causes the RET to mispredict. There's no
doing a bunch of CALLs to stuff something.

> Retbleed doesn't do this.
> 
> retbleed is about BTB, srso does both BTB and RSB/RAP.

Yes.

> So this patch doesn't actually change anything except one layer of
> indirection.

I agree with everything from here on to the end. Provided we can do that
and there's no some microarchitectural catch there, I'm all for removing
the __ret alternative.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
