Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE47985B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjIHKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjIHKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:22:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF21FDC;
        Fri,  8 Sep 2023 03:21:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D63C433C8;
        Fri,  8 Sep 2023 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168428;
        bh=W1z1FcuoUvbcfJlaQ1NbkHr76Xrqb6ArX/tD4jLMv24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tA7OJMJz/w3RSDB8V1crqrYVCsA60kepxdSZ6gZRUMc6m6yZbp+JJ1rkxvbEkIv/G
         V3OpEki3O0IUZo8+pvPsezPFgXGI+vlRQ7sOjIwgU+tkosDRlxJ3xdYue2yr/FPXqa
         OOl4wS5pD005jNgLrym8+Dui8+6Vb8obrKT9Vmuig0dpRiEqCOOMDKb3VWUB+577pF
         GC3WD7EDG3W1rRUF1ccEtJN2yZDIJPV8vpiDt8huNj5/ZAVzfhy2RToXXAgSAt9gFm
         Np3pTdNGfmkg8cwDVcXQYlxw1fs5AL4ikllZ0+G/T7YRZD4pxvj/tOokBucC9P0mrk
         vJf6f40QaTfQQ==
Date:   Fri, 8 Sep 2023 11:20:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] arm64/sysreg: refactor deprecated strncpy
Message-ID: <20230908102022.GB6849@willie-the-truck>
References: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
 <amh6pp2mkmn22jcvz5tva7c4aaqxaq7zaz6v5u6rb7emsqp6p2@nxd7ynj524sx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amh6pp2mkmn22jcvz5tva7c4aaqxaq7zaz6v5u6rb7emsqp6p2@nxd7ynj524sx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:28:05PM -0700, Bjorn Andersson wrote:
> On Fri, Aug 11, 2023 at 04:33:51PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1]. Which seems to be the case here due to the forceful setting of `buf`'s
> > tail to 0.
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> > 
> > In this case, we can simplify the logic and also check for any silent
> > truncation by using `strscpy`'s return value.
> > 
> > This should have no functional change and yet uses a more robust and
> > less ambiguous interface whilst reducing code complexity.
> > 
> 
> I'm sorry, but this patch is wrong.
> 
> __parse_cmdline() is supposed to match the command line against a set of
> keywords, one word at a time. The new implementation ignores the
> word-boundaries and matches the whole command line once and then breaks
> the loop, typically without having found a match. (See below)
> 
> Can we please have this patch dropped, Will?

Yup, this was fixed yesterday so please take linux-next 20230908 for a
spin and let us know how you get on.

Cheers,

Will
