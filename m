Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1177A1D53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjIOLVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjIOLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:21:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6877101;
        Fri, 15 Sep 2023 04:21:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694776870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsnkGbttQgVvHiV9M03Q+LlQoOR8o5QNvoHNuHa+6nY=;
        b=kUVLHiYJMpOIKyckOH3EGEThs0EpvU+s0q8h8ytzvinMvOtAfd5B7odHXAHSsKB6ibsXQK
        PnVg39zA19vvSxKixPQ+lABJT51nPvqCctMMvlpaSLwmUt0ComnPBAbfOeDqJkm22KVl5U
        69v1YPuRztdswpOaGK+V1mXP6/RYTyNTYTIpwcwlIW6bdb4dXpkVV+7oGssiK5q2PP4b7N
        S4ApnDPDAMrpld//Dw0tCaKyFut5XTSw4/B2YXE/SrDtZgEkRgbbAd9XRRdohfU850iP1Y
        sbsq1DHisj/HMJsjV4h+/F/DlveahLIkHgxgeYBSTU+NxAqze0LLubPKBH6ffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694776870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsnkGbttQgVvHiV9M03Q+LlQoOR8o5QNvoHNuHa+6nY=;
        b=W6ioBJ1+Iw5AzubKd6BZK7wo1pNLk50251horbdq/DP+xQJ60XUc0+8TacyLFi3g3eztn+
        M8sSTyUWXVfOOHCQ==
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH tty v1 06/74] serial: 8250: Use port lock wrappers
In-Reply-To: <2045de5e-b7f8-18fe-dc92-e1d88a62f810@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-7-john.ogness@linutronix.de>
 <2045de5e-b7f8-18fe-dc92-e1d88a62f810@linux.intel.com>
Date:   Fri, 15 Sep 2023 13:27:05 +0206
Message-ID: <87y1h7vg0u.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-15, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>> @@ -3403,9 +3403,9 @@ void serial8250_console_write(struct uart_8250_por=
t *up, const char *s,
>>  	touch_nmi_watchdog();
>>=20=20
>>  	if (oops_in_progress)
>> -		locked =3D spin_trylock_irqsave(&port->lock, flags);
>> +		locked =3D uart_port_trylock_irqsave(port, &flags);
>>  	else
>> -		spin_lock_irqsave(&port->lock, flags);
>> +		uart_port_lock_irqsave(port, &flags);
>
> Not related to any problem (with this patch) but I'm a bit curious is
> this construct going to remain there after the follow-up work?

Yes. The uart port lock already provides excellent coverage of unsafe
regions in uart drivers. We want to take advantage of that.

> And there's the similar one in some other drivers (with some
> variations related to local_irq_save()):
>
>         if (port->sysrq) {
>                 locked =3D 0;
>         } else if (oops_in_progress) {
>                 locked =3D spin_trylock(&port->lock);
>         } else {
>                 spin_lock(&port->lock);
>                 locked =3D 1;
>         }

With the follow-up work we are introducing a new type of console
(CON_NBCON) that supports atomic and threaded printing. Current console
drivers must be converted if they want these features. When converting a
driver to NBCON, such variations as above will need to be addressed. The
follow-up work provides new functions and semantics to allow drivers to
implement more reliable code than just: "trylock and keep going no
matter what".

For console drivers that are _not_ converted to NBCON, the uart port
lock wrappers will not provide any changed functionality.

John Ogness
