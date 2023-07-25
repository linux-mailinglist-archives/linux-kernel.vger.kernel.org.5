Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67367760392
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGYAHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYAHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5907E5A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF36461475
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A379EC433C8;
        Tue, 25 Jul 2023 00:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690243672;
        bh=6fFzXgixupyns0zqBY+W9+AYz+IuYhEoIO0CBPqLwwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AU/aFu+QxDh0Qi98dayhr9GSqJ1rIao4ZFzCl0J0PLB/zIk5/GtgXPSiD4ZGQMkjR
         360+7InYgx2NfacD9QhVdmbbb+ab9ejg/tDfkolMeUZz8peo4fE+hukhqel9bV8zky
         vFLzYfrFTY9irOdbX9zpgKR6jqUHyQaaVoOpPz0GFamzjtOugeTXmBmVTYI+/JsFdL
         rv/O6e35efXnMwHT6uTy2yaINhS9o6CkqmYB18McXC5rjlDizJyMh+iHNRDtLcKpQD
         gRl4+TL+2tBNef2XN8iKuPWmT2Pk8ySjqvoPQZImjprSCDYzX0B0QWQeFJeyYAR/eo
         qPmjwUKbA852A==
Date:   Mon, 24 Jul 2023 17:07:49 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH 2/2] scripts/faddr2line: Use LLVM addr2line and readelf
 if LLVM=1
Message-ID: <20230725000749.24qsqlqn5llfan7g@treble>
References: <20230724174517.15736-1-will@kernel.org>
 <20230724174517.15736-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724174517.15736-3-will@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:45:17PM +0100, Will Deacon wrote:
> GNU utilities cannot necessarily parse objects built by LLVM, which can
> result in confusing errors when using 'faddr2line':
> 
> $ CROSS_COMPILE=aarch64-linux-gnu- ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
> aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
> do_one_initcall+0xf4/0x260:
> aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.dyn'
> aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value: 0x25
> $x.73 at main.c:?
> 
> Although this can be worked around by setting CROSS_COMPILE to "llvm=-",
> it's cleaner to follow the same syntax as the top-level Makefile and
> accept LLVM=1 as an indication to use the llvm- tools.
> 
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

This one looks good to me, I'll go ahead and queue it.

-- 
Josh
