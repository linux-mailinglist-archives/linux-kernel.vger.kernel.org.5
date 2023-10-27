Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF677D9D09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346296AbjJ0Pdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346277AbjJ0Pdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:33:38 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5ABB8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:33:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B269F40E0173;
        Fri, 27 Oct 2023 15:33:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H-th4CV3RACo; Fri, 27 Oct 2023 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698420812; bh=gH1kGJW0H+Ql6cmbGG3S9bXgwseObYu3GOaSMnhwaIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsGQB2Bj+r4IDFoCCx04vffocr2pg+oiLi1PMbT5u1yRH2kP3EKC9Oh6ehwvrnmdp
         vQ5ueen79s0QBnS9mNb1y/wNxCdEBXM3rkhOtUJphmj2TVdC99e4bYXZN4WQvC/RQr
         RTWAA3CiAXo7/zUo3qtUTwVhkoANFbW3odT4+z3QEp8fCmsb5f/v2/ZuqWAO9mZGOR
         o+aebCYt+amp/+YqTcphVOXHvWOXVPvJglQrcSrD6HrLUZotrg5XXKOpwZxou8KsUx
         m0u8I9YxrDw2T/E3gmwB8EYa3h8du7wIyTMPXXqpBkvpjRo2ejY7daVddDiofNwInL
         saqiE9AeoUgCbbhLRvcB+kqbUd+/kB11EF9h32TYn1jRB0jFDhTX6metq2OTU8+EHZ
         TgXO93PLq/tCiEyWLzo/0LGXrQipzt7vcpboePEMM4V3GzaX0kz3oVWjbuTUwRJmyp
         IaSfzMPYifeCZqSzfBrQnUFFxkjLyYjqxA8YKNnM5RnFbekmtzh6XtFaZCrbELjz2Y
         tXPfAzrsiUIlnuZVyPrUYRXYNNf3vh7PJqSupl1etKZ9+CNj13zbpopwEybUAnBmSE
         Xtu+2hRNmz4sGGHnF48qWCQXCzr8m6iNc2gfJw4gBTXLjPzf/u3UxDsvuYYhii0eR/
         YuSVHj7xdj1SesimBJGfI03I=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C828940E0171;
        Fri, 27 Oct 2023 15:33:28 +0000 (UTC)
Date:   Fri, 27 Oct 2023 17:33:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:22:22AM +0200, Borislav Petkov wrote:
> I'm wondering if we could make:
> 
> 	alternative("mfence; lfence;", "", X86_VENDOR_AMD);
> 
> work...

Seems to work in my guest here and it don't look half as bad. See
replies to this message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
