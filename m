Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAD77B150
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHNGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHNGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:15:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B84F4;
        Sun, 13 Aug 2023 23:15:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691993744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcEI4KZg3VbQwbcZLWUE/uWIoE2bSeS0e6kRTJtHxqg=;
        b=XS3vPp45TZPoj/MwYV/78QkdPxJR23PbRilQ/Uuyxo8rPH9dzkb2+vgyGPBp5XTZh7i/Eb
        YZIl0Rmd8CGoTr1PO/TOGBYQCK8Nim8HnWGzY58/SnQ5oc8Q9KqH9/+gV2cMBb8TV/kxUk
        OnX1+HkS8SU37EVC76XI1z7woxZNgu+vFQPgrohNDU9T3Wc1NFxh/ZOvQkge/Yl1eQ0DGC
        xAP8682tOT5841Rb5KU5yr5NPvSne5LX2TCVcJkcJLCSoGc/iw8tRp7mnWRsVtbVP5LN35
        wMc4jly7patSUrGRQJ8u2F5Ae6wrDQH2Z8kR67YQS6zY+ez1jo1Z3BFrkmtpkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691993744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcEI4KZg3VbQwbcZLWUE/uWIoE2bSeS0e6kRTJtHxqg=;
        b=i0P8MUiX0s0/aFgy4dgWhHPdVSUKR2iV21BnvYSTKA7C+mWgDk4HMFtIzUkhHaRiOko6ir
        Yh3bjYbw+9eEtvCQ==
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
In-Reply-To: <20230811064340.13400-1-jirislaby@kernel.org>
References: <20230811064340.13400-1-jirislaby@kernel.org>
Date:   Mon, 14 Aug 2023 08:21:32 +0206
Message-ID: <878rae175n.fsf@jogness.linutronix.de>
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

On 2023-08-11, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> The port lock is not always held when calling serial8250_clear_IER().
> When an oops is in progress, the lock is tried to be taken and when it
> is not, a warning is issued:

Yes, and that is a potential deadlock. The warning is correct.

> Therefore, remove the annotation as it doesn't hold for all invocations.

... because those invocations are broken by design.

> The other option would be to make the lockdep test conditional on
> 'oops_in_progress' or pass 'locked' from serial8250_console_write(). I
> don't think, that is worth it.

The proper thing to do is to fix the invocation. The upcoming atomic
console implementation for the 8250 does exactly that.

If this patch gets accepted (which it appears it will be), I will revert
it in my series implementing the 8250 atomic console.

John Ogness
