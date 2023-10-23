Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD107D2EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJWJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:41:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF97DA4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:40:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-407da05f05aso22451325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698054056; x=1698658856; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2e6e3Lcqli+2alSmk+94dBX3KJpg6geqhFS7BprVkcU=;
        b=GL7h0iFse/gxCet0otgmb1uFRctB9gzKAtzvSyWHCnxPjEe8xM+DRZAyb/w4636jfY
         iXVZpu+M3AkHhMRlSIDGUt6KFJ7mBAviT5QfB+P4nFSJ5W8lj5KERW5jO0A4HdsCA8o0
         +uLOH0qJeBktDMxxSYxa6IqT9jbLT0HTYxXow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054056; x=1698658856;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2e6e3Lcqli+2alSmk+94dBX3KJpg6geqhFS7BprVkcU=;
        b=ZWe0FnmTqnh+5fE53NmQD5hQEul0ZqZ3Lj1tDGxA11T4JSfmmnbsPhE40TkVGauGJR
         eQn6WhxSOZ+LuefjFL2dI3yD2M8EM4xDWM1+Wba4x0Y5LMJbr2EqSlwPht1eqSSHpK6w
         j28dIYgJVhOXqdyIN6iIFvHMPSErWOBNbANWkeDN2S8aAAUcXD0JP4Vf3Rf+gmHvCqnk
         2A0gZ87s7RfxGX7sjtHUVMa3wSPjW4Eqdh0Y0Orc46G/HHK1GOkgcBGsqu8Cz3oQlaKM
         cFT3CorcYjyl6KXvl8WL6dPEg+aOC3fQSByNknF1jnnpE06cWdhjtv5mMTos1MDsVD/R
         Qwgw==
X-Gm-Message-State: AOJu0YyTa7UW0Moq/J8EuZiMDBNohEcqYU9vtgEUleaaOr/DRDJs0Uew
        ymd23aRKL7Q4WNSW/ErJn53M4g==
X-Google-Smtp-Source: AGHT+IFiv0PaRNaUlIPDIvrAD0L8WPCgy4IVeKPszHKpE2+d3heHK/NlRODAuG2AKmxQC3FMfHXD6Q==
X-Received: by 2002:a05:600c:3583:b0:401:eb0:a974 with SMTP id p3-20020a05600c358300b004010eb0a974mr6582584wmq.3.1698054055794;
        Mon, 23 Oct 2023 02:40:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3e73:a41c:6787:e5d4? ([2001:8b0:aba:5f3c:3e73:a41c:6787:e5d4])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003fe1fe56202sm9011512wmq.33.2023.10.23.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:40:55 -0700 (PDT)
Message-ID: <5c49bc0f468e9fb5ae7ff7f53443fdb1fc3c77f2.camel@linuxfoundation.org>
Subject: Re: [PATCH] serial: core: Fix runtime PM handling for pending tx
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Mikko Rapeli <mikko.rapeli@linaro.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy MacLeod <randy.macleod@windriver.com>
Date:   Mon, 23 Oct 2023 10:40:54 +0100
In-Reply-To: <20231023074856.61896-1-tony@atomide.com>
References: <20231023074856.61896-1-tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 10:48 +0300, Tony Lindgren wrote:
> Richard reported that a serial port may end up sometimes with tx data
> pending in the buffer for long periods of time.
>=20
> Turns out we bail out early on any errors from pm_runtime_get(),
> including -EINPROGRESS. To fix the issue, we need to ignore -EINPROGRESS
> as we only care about the runtime PM usage count at this point. We check
> for an active runtime PM state later on for tx.
>=20
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
> Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Tested-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Thanks, I can confirm that since we added this into our builds/tests
we've not seen the serial data go missing.

Cheers,

Richard

> Cc: Bruce Ashfield <bruce.ashfield@gmail.com>
> Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Randy MacLeod <randy.macleod@windriver.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -146,7 +146,7 @@ static void __uart_start(struct uart_state *state)
> =20
>  	/* Increment the runtime PM usage count for the active check below */
>  	err =3D pm_runtime_get(&port_dev->dev);
> -	if (err < 0) {
> +	if (err < 0 && err !=3D -EINPROGRESS) {
>  		pm_runtime_put_noidle(&port_dev->dev);
>  		return;
>  	}

