Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541EF801D06
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjLBNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:23:59 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C1BF3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:24:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3B2DNx6S015078;
        Sat, 2 Dec 2023 14:23:59 +0100
Date:   Sat, 2 Dec 2023 14:23:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nolibc: optimise _start() on x86_64
Message-ID: <20231202132359.GA15040@1wt.eu>
References: <38183c29-9b7f-4960-8702-d71ce816cf80@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38183c29-9b7f-4960-8702-d71ce816cf80@p183>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Sat, Dec 02, 2023 at 03:45:13PM +0300, Alexey Dobriyan wrote:
> Just jump into _start_c, it is not going to return anyway.

Thanks, but what's upper in the stack there ? I'm trying to make sure
that if _start_c returns we don't get a random behavior. If we get a
systematic crash (e.g. 0 always there) that's fine, what would be
annoying would be random infinite loops etc. In the psABI description
(table 3.9) I'm seeing "undefined" before argc, which I don't find
much appealing.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> 	Also, kernel clears all registers before starting process,
> 	I'm not sure why
> 
> 		xor ebp, ebp
> 
> 	was added.

Hmmm psABI says:

  Only the registers listed below have specied values at process entry:

  %rbp The content of this register is unspecied at process initialization
       time, but the user code should mark the deepest stack frame by setting
       the frame pointer to zero.

  %rsp The stack pointer holds the address of the byte with lowest address
	which is part of the stack. It is guaranteed to be 16-byte aligned at
        process entry.

  %rdx a function pointer that the application should register with atexit (BA_OS).

Thus apparently it's documented as being our job to clear it :-/

Willy
