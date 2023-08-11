Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FC7790C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjHKNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:30:00 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855C26A0;
        Fri, 11 Aug 2023 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GBRpFjxLbns8NI82AkjFbqTYlTSuMd1HSZ4M2qYod0w=; b=VgEAODstO4Ai6X5+PSSXKGtpd4
        AvcElTUI0IgZo7meovrPNNaecYhdVpIxNv8RiY2jno8AdVjQYKpZwdq8C7F2ktOsCDH0sJ/HwihCi
        xC2nVxcz1bFQqKaekIiBn9Eez8rOXuX7BY6FeMxgM3TSkVECUDB8XNn4NsJdgYpGIWoNc47DwgW+q
        yfmz7LPgUkZ1lz8VvvIFtXz2/VPLmJA5CqBq/cRLB7iXTPPeJp6POHC7Kgbdhr5SXBEEq8E0EgHIg
        YZryUEM3a3EmAOmS1awoAiZdldlXGKJFrzjlKlo/6cD1cDcestCWmunAXfxbiiRvlQ7PIGrDrfIys
        nfoLoUYQ==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qUSD8-00HAJo-3p; Fri, 11 Aug 2023 15:29:50 +0200
Message-ID: <2b358118-e7b9-1f6d-aa38-306f537a5d93@igalia.com>
Date:   Fri, 11 Aug 2023 10:29:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230811054528.never.165-kees@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great finding! Thanks a lot for the report and the fix - oneliners are
usually the most challenging to debug.

Tested it in the Steam Deck, and it works perfectly - I saw eventually
one line or two filled with NULLs, now they're gone.
Feel free to add:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
