Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64744762001
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGYRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF7619A0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F58D6182C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD69FC433C9;
        Tue, 25 Jul 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690305688;
        bh=IxcL/QYAvE9rRWrO/NhYhq0czXDdJwuEwJ+g0ud+/Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wrqq2gxg6pLLbwWpt8986MbxeNC3nGuc49p6zJ9RIGmn8366d6jMUs221V1TIP6ln
         eKXbUz/uyccHlXIQma4gibyqGYWPoB2FdHV55DWEabzrn34ginVw+hffZpgNacjX1u
         ywxXSPyy4TG4VH/FPJuZqirOFZ46FNSxaPJPN88gHpzp5hwE1HtclsyO9lJx1Xqc5P
         QRDYPsyDGXN4KjXoAfQerbV8ZtxlYDBS1NDLTt50endz3eQyedKyd/p1dzgSzaQQaB
         M4oKVnSUQzgObr6rTqFy1z+C8jthaIG1s1bpamhjc/3/l/LVPXnhdLuqThkyyx1hWB
         0qMSyamumC2qA==
Date:   Tue, 25 Jul 2023 18:21:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH 2/2] scripts/faddr2line: Use LLVM addr2line and readelf
 if LLVM=1
Message-ID: <20230725172122.GB16719@willie-the-truck>
References: <20230724174517.15736-1-will@kernel.org>
 <20230724174517.15736-3-will@kernel.org>
 <20230725000749.24qsqlqn5llfan7g@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725000749.24qsqlqn5llfan7g@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:07:49PM -0700, Josh Poimboeuf wrote:
> On Mon, Jul 24, 2023 at 06:45:17PM +0100, Will Deacon wrote:
> > GNU utilities cannot necessarily parse objects built by LLVM, which can
> > result in confusing errors when using 'faddr2line':
> > 
> > $ CROSS_COMPILE=aarch64-linux-gnu- ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> > aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
> > aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
> > do_one_initcall+0xf4/0x260:
> > aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
> > aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
> > $x.73 at main.c:?
> > 
> > Although this can be worked around by setting CROSS_COMPILE to "llvm=-",
> > it's cleaner to follow the same syntax as the top-level Makefile and
> > accept LLVM=1 as an indication to use the llvm- tools.
> > 
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> This one looks good to me, I'll go ahead and queue it.

Thanks, Josh!

Will
