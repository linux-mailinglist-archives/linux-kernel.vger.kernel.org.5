Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E1757F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjGROWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGROWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:22:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC7123
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:22:40 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689690158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fDWCSjXXEjX/JODVcgeDXco/4WMx9FK0mGR8q+fC6xQ=;
        b=qAXNX/lAeJqtzaQ8nkhj1vDqiyGCCqLkDf3gypZGmi+V9INLceXoGIOn2wbuSBZpyhzpkM
        Y0Wckb3qc9MqPembkuys1PqsYsdfG8H+DJ0JQmoBCxVTwRPuobCrR6c9J9vg110ahlgLOk
        HaVdtc3fQpRAwpFxXKXhUw1RGH6MMEF5orcaL+EKZmjpAi9qE3WTrNXgUT5/gl34aDQWQr
        oLsyCW9E4HHiK09Uj0Ux20c/i6v4eVQWv6NHxfe2cCQZdA9xuDaFxkBa79jQZAINYcReP+
        Pf1q3sWqHxAk66ivgBV80FL4CjNmr/2J2/jYMqiaLms2d2xxIQJsjIEnwnFxlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689690158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fDWCSjXXEjX/JODVcgeDXco/4WMx9FK0mGR8q+fC6xQ=;
        b=EjBcdbH7zAovwjWUL22ZOe1cLiBklkUiP9RmMz6urf5mO80PVKt5JDYF6x5Mks4jkuJ9iy
        P/A3MBd5RoXoOsBA==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <871qh5jrz2.fsf@mail.lhotse>
References: <20230609051002.3342-1-npiggin@gmail.com>
 <871qh6wcgb.fsf@jogness.linutronix.de> <871qh5jrz2.fsf@mail.lhotse>
Date:   Tue, 18 Jul 2023 16:28:36 +0206
Message-ID: <87o7k9l2oj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> ld: warning: discarding dynamic section .rela.opd
>>
>> and bisects to:
>>
>> 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
>
> Can you test with a newer compiler/binutils?

Testing the Debian release cross compilers/binutils:

Debian 10 / gcc 8.3.0  / ld 2.31.1: generates the warning

Debian 11 / gcc 10.2.1 / ld 2.35.2: generates the warning

Debian 12 / gcc 12.2.0 / ld 2.40:   does _not_ generate the warning

I suppose moving to the newer toolchain is the workaround. Although it
is a bit unusual to require such a modern toolchain in order to build a
kernel without warnings.

John Ogness
