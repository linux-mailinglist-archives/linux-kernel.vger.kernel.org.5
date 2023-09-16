Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A384A7A3250
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjIPTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjIPTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A19CDE;
        Sat, 16 Sep 2023 12:45:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694893546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsAZGo1LDmsx0eNheZ1sbFob+5+H0uD3ImSzoDM1eN0=;
        b=Ds+V0jJykQ9snU22NpFxo4ZFJ7k6QcNANTNtwoXeut9StqCciy2CKhzSJ3IF4HQUID+lGH
        Npouo7RRf3HCBpPhF7S86AO/gMAEKMwZ+P5Pi1pOELgXqldozfDcIs/BxLSGl1R6wAZvmh
        QXSkFA5v17ArxaYo3yyyBzMSHb5wB4sE+Xp4R+eK5Y13lpDJhCvQcelHtPztue1qOtxwKA
        hA5Rpniha4fVQndLxQQUrXosqCqJ/AbGytSyQ07aXdlqf0yV8zJUI1I76tUXP3DVUrOLVM
        XFhDzpNQotd6d5uBrUhoJIE/77qhYo8uUk6yGehFiReFZLHZxzwFvNWqZaou+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694893546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsAZGo1LDmsx0eNheZ1sbFob+5+H0uD3ImSzoDM1eN0=;
        b=SH3zc15x8zH5+UDgFth70vyyKqbSCkeqT0GSWAOnqct6ifOj0QlJgiGmOBEHOygxLdgWWg
        PgDcBlGRjeb4VsCg==
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>, Petr Mladek <pmladek@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty v1 29/74] serial: imx: Use port lock wrappers
In-Reply-To: <20230915202122.ulgy4fdxpsxmecbo@pengutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-30-john.ogness@linutronix.de>
 <20230915202122.ulgy4fdxpsxmecbo@pengutronix.de>
Date:   Sat, 16 Sep 2023 21:51:40 +0206
Message-ID: <875y49nbq3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-15, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>> Converted with coccinelle. No functional change.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> This lacks a Signed-off line by John.

I really didn't have anything to do with the development of this
series. (I just did basic testing and the posting to LKML.) But I have
no problems adding my SoB if that is more appropriate.

John
