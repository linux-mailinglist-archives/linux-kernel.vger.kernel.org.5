Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8287FE167
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjK2Uyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjK2Uyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:54:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A710C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:54:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701291297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHijwGm6NVFiHKrEw0H9Z4fyN3jsvPOuZ7CFlGvf8i8=;
        b=xDGDOBm4q1VzEIWuH0G1gREsW+/mo1XdBjswfVmZ9/uZew5ojKcOWLrr+hbArnFENKOPRQ
        sw/LNwiu17n7oLX4jZFMQ7EfNKATT3DcVNDQIF9FZy/GYrJswdbeUBXkTeEdQaiFX7kW3v
        AuXd+Igxb8FJUS+YDQAR5iGq2TGGTAnnXiX5s8RQ29fEzKkqmat0zhm7SORUjQ4PJC96c7
        d6kDaCLvmF/zDW8QNDYoQSZVStfZxMT6lCToO9Ff+yeFxg2DvmJy3wrV989BtWyn/vSidv
        Vx7udQqCIGu465UUUYbNeQrMHowMwwDnp4Y7dBOsRmuj8ZLZ8sDCp2U2LDVj7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701291297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHijwGm6NVFiHKrEw0H9Z4fyN3jsvPOuZ7CFlGvf8i8=;
        b=hQDR6KboiiQcVWyu6xYHgCT3S8ww7nDG2ypitiHslclkOu52BZG3El0yDVNl36Bl51tXjK
        A5fV38sPpgf6asBw==
To:     Wei Gao <wegao@suse.com>, mingo@redhat.com, peterz@infradead.org,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        linux-kernel@vger.kernel.org
Cc:     wei gao <wegao@suse.com>
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
In-Reply-To: <20231123053140.16062-1-wegao@suse.com>
References: <20231123053140.16062-1-wegao@suse.com>
Date:   Wed, 29 Nov 2023 21:54:56 +0100
Message-ID: <87a5qwz3dr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23 2023 at 00:31, Wei Gao wrote:
> The new function copy main logic of current sys_futex_waitv, just update parameter
> type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
> and use get_old_timespec32 within the new function to get timeout
> value.

That's not how it works.

struct __kernel_timespec is the same on 64bit and 32bit syscalls.

User space has to use the proper type when invoking a syscall and and
not just decide that it can use something arbitrary.

All new syscalls which deal with time use the Y2038 aware data types and
do not have compat fallbacks because there is no requirement to have
them.

If user space want's to use struct timespec on 32bit nevertheless in the
programm for a new syscall, which is obviously stupid in the context of
Y2038, then it's a user space problem to convert back and forth between
the two data types.

Fix LTP to be Y2038 safe instead.

Thanks,

        tglx
