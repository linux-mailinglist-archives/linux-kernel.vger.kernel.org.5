Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12A7F5E93
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbjKWL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbjKWL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:58:28 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20F1BF;
        Thu, 23 Nov 2023 03:58:35 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54AF240E0259;
        Thu, 23 Nov 2023 11:58:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X3NKKQJzBsfh; Thu, 23 Nov 2023 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700740710; bh=x0a9jKb8T+GdxkKAWUNyWFH+pL0NxSkyw8byfB61vIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfSsodfl5VWH5smd66eoq7M+EVCxMVyin36soE62zLX/kKXih4eojZA8wQH69kip3
         ORkO5xOqks51SYkYDAQsVtLL7qZrRfMHcrcQFNQiwUOsVrSrw171SKj30HG/BvD+G6
         z8z8ML5rLadXM3+CpgORSEYBF7ISKxspy+uBYXKYfL79a38a0NlHACsX+oHWd+H103
         p3KyMsD7APPprAA9irbyIfDgUnq2pTlJfzgyJQwLlUJOJ8mhRPj9u4qRNZTrmo9rre
         e7Q7M6lbthelJVDnFMjkFJ55CFAxZOi6NE/qvHADfoKEi3CesgQOHaIRVSwJSSJOp2
         Acjmq+jKB9sMAXLQwZc3E9645/z/Sqfn1kkjJ/AHv6UNzNbV8CqRnl+sljFHpDxyPN
         F83ZLhnbZyXf5nNFGDIEEGxy7gCH5HbICoZw8C0YYhws5V8wMQRS1hxIuAXIdmCpFv
         2dwVjxo2TwP+lLRMXmpI3ncLauZNR0+HOZ8j+9yKly4iuF4Kke5U3erbvr8U+6W683
         ymChZOmuMZQiIa8wdxijaB21ia1KRsHlE8+FmmUuQACL/WG3f68GJAs2S9+h7rRrZv
         5DFGid//Hq7ZEbp7I+/BLb5KmTqzShYK2c3JItuSRmAlyqH+c1WF1/nyJiSmWJ9rK7
         P9GgxdFmMenURi7pfh9btwDY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F99940E014B;
        Thu, 23 Nov 2023 11:58:18 +0000 (UTC)
Date:   Thu, 23 Nov 2023 12:58:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Message-ID: <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
References: <20231122222007.3199885-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122222007.3199885-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:19:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a

$ git describe 1b56c90018f0
fatal: Not a valid object name 1b56c90018f0

I'm assuming that's in linux-next?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
