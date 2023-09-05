Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B3792B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjIEQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354448AbjIELqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:46:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BC1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:46:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5981B1F8D9;
        Tue,  5 Sep 2023 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693914360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcPZST/iVpALGuN/zbIUlwYfstIdFMsrI/czOq3yqOo=;
        b=raogWvK9AVddY0jjKcLCkk3KlorkVk/Pq+ZJRfXJB4ir4tEihxcRpWcwL65/XGlJBLDE3t
        6w1WSml/UzAQVdunSXKMgAKwzXAS+of91m37ea/0BR1WN84rjZwmHGgx2eeQ3coQmwinBk
        tvnqkKcD/ONoIhbbX70hBsEi5PdxAEM=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05D292C142;
        Tue,  5 Sep 2023 11:45:59 +0000 (UTC)
Date:   Tue, 5 Sep 2023 13:45:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 1/7] printk: Add non-BKL (nbcon) console basic
 infrastructure
Message-ID: <ZPcU96WWkDyssEie@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:33, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current console/printk subsystem is protected by a Big Kernel Lock,
> (aka console_lock) which has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and
> makes forced takeover and output in emergency and panic situations a
> fragile endeavour that is based on try and pray.
> 
> The goal of non-BKL (nbcon) consoles is to break out of the console lock
> jail and to provide a new infrastructure that avoids the pitfalls and
> also allows console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Per console locking instead of global locking
>   - Per console state that allows to make informed decisions
>   - Stateful handover and takeover
> 
> As a first step, state is added to struct console. The per console state
> is an atomic_t using a 32bit bit field.
> 
> Reserve state bits, which will be populated later in the series. Wire
> it up into the console register/unregister functionality.
> 
> It was decided to use a bitfield because using a plain u32 with
> mask/shift operations resulted in uncomprehensible code.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
