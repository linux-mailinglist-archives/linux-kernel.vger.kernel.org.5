Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2647DF580
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjKBPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjKBPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:00:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD7184;
        Thu,  2 Nov 2023 08:00:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECABC433C7;
        Thu,  2 Nov 2023 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698937238;
        bh=C88FlU4ouWEmidb+DSCdaONlsanKLO79mrsdvXHGKnU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sjasx6dUDDFRcFyfz4G3MFiQcdz2i82tGsb4PhzuLohjSby23cJiAth2xGEQ+hx9V
         m6YiSBptxEHmopJdOMQDzh1XyZKhmAUfO96YwZOZnRaf8J8IfgadbESicaeyIFfOi/
         gXht+kb4Pla0icSq11paKKinB9SZ6eo/PlSprqUZtfQNrRRtpTDrcsUMJnNfKfZxYm
         DO51/FOIX19u9R9OCdeDz+nIISeqO+0aWNuGn6E/X4+gfIAYWhoKtR0sX1LSxmcgHV
         u1S8SXgcnO2SB4InpiPBmvopFQh+PoDcC9xakjYEIIW8xRwg1pdhCXfMHbICOJtoOZ
         EKAEfeqlZHFaw==
Message-ID: <868f4920-190d-4917-ae4e-bd4cbb6de98f@kernel.org>
Date:   Fri, 3 Nov 2023 01:00:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] modpost: fix modpost errors for m68k-uclinux-gcc
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jack Brennen <jbrennen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20231101150404.754108-1-masahiroy@kernel.org>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 2/11/23 01:03, Masahiro Yamada wrote:
> Greg Ungerer reports building with m68k-uclinux-gcc toolchain is broken:
> https://lore.kernel.org/linux-kbuild/CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com/T/#m6ff0364f9ca8483c9f6d162619e5005833d1e887
> 
> Usually, we do not need to search for export symbols in the .symtab
> section, but m68k-uclinux-gcc seems to be an exceptional case.
> I do not know what makes it different from other toolchains.
> Also, I do not know there exist other toolchains that work like that.
> 
> This series extends the symsearch feature in case we need to explicitly
> search for export symbols.
> 
> Then, the last patch fixes the issue.
> 
> This series should be applicable for linux-next.
> 
> This series is too late for the current merge window, but I'd like
> to fix the issue somehow by the next merge window.

Thanks for looking into this.
I can confirm this series fixes it for me (using linux-next).


     Tested-by: Greg Ungerer <gerg@kernel.org>

Regards
Greg


> 
> 
> Masahiro Yamada (7):
>    modpost: move sym_name() to modpost.h
>    modpost: add const qualifier to syminfo table
>    modpost: add table_size local variable to symsearch_find_nearest()
>    modpost: introduce a filtering feature to symsearch
>    modpost: prefer global symbols in symsearch_find_nearest()
>    modpost: add symsearch_find_with_name() helper function
>    modpost: look up the correct symbol in check_export_symbol()
> 
>   scripts/mod/modpost.c   |  39 ++++----
>   scripts/mod/modpost.h   |  12 +++
>   scripts/mod/symsearch.c | 205 ++++++++++++++++++++++++++++------------
>   3 files changed, 180 insertions(+), 76 deletions(-)
> 
