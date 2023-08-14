Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9777B17C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjHNGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjHNGVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:21:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1F10C2;
        Sun, 13 Aug 2023 23:20:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691994040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Oz708AoYWC0zOYG+tE6hDqHP4W2kJ5mwj7u+JyTgAE=;
        b=dm/UjTTd/8x22YbB7VS/B7ZT3pTXbi6W/6bHhOLqnQXB2co2TDmv+XkmkO2sEXLL4v3hk+
        fol0pL+c9/Oov6a18DICfnVwLVTa/6QucbsmEJ/CVb1qN6vlYWd9HaDjMYm26T+g2d8qYD
        E/Mx4AFaaWRN0G60Xgsdf1xL7dmF3RzOD0YKd9RPeMbePG9GRd7IsRyHvXo+oX0tCjZWC/
        BeNqSIOTkKsBV+Pr6ZJc18nz/biBLF4wcN3JDtBKajndbC8GTnHB0rwsmvdkuyS43BKN7T
        NzQCjYkaXX0AfipWEQnZi0WQBnY6Hq4TtkHzqMk7WRVC1HqZXyeNR8mPXpLmkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691994040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Oz708AoYWC0zOYG+tE6hDqHP4W2kJ5mwj7u+JyTgAE=;
        b=Lb80vFXQENVRyRX+3SY/NPNoMTTDxzxL7pzj6t1f5OlvHN/ns3wEc1lBrLrhYqtVh1cljj
        xXwlev3efGPeGpDA==
To:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
References: <20230811054528.never.165-kees@kernel.org>
Date:   Mon, 14 Aug 2023 08:26:28 +0206
Message-ID: <875y5i16xf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10, Kees Cook <keescook@chromium.org> wrote:
> If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> copy_data() was causing writes to truncate. This manifested as output
> bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> record size was larger than 65536. Fix the cast to no longer truncate
> the calculation.

Thanks for tracking this down.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
