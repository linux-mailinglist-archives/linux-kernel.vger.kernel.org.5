Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9A7F2A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKUKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKUKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:25:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62613B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700562314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kv793GlpUAibpHSviUbIOlEfqFoGFgwrV0FjBE/F+mY=;
        b=etl9qQsNc7CIAUWcXmAMM7yIqPAqEfCMezyRKfqOzkwqJFL4DH2B/QU9RrF7z9lpTtfrgL
        LrjCuq+9eFi6upBD3jFBYy1+XYdOu+cPdkAoVrFiVKaS1N4KIBeQN+fuDcpqVoPPvdQ/Rm
        br7nVaKHpu9R/cGk5Lbq1Ta+YOnfypQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-livLJK9INJ6-cGEo2E10Tg-1; Tue, 21 Nov 2023 05:25:13 -0500
X-MC-Unique: livLJK9INJ6-cGEo2E10Tg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ff9b339e8cso15800566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562312; x=1701167112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kv793GlpUAibpHSviUbIOlEfqFoGFgwrV0FjBE/F+mY=;
        b=jhQqoKgBUyGDNcb4lfRyX/T96NwtxC88j4LPdhWjc9m/KHlotnUSHoegpUqKW9wUL9
         x4sy7hj4FDkQxId0eER0StVNPzLL7S8/NggujsjX465Q1ANWqfPMMw04oCQsBhCNqGhO
         PfFVsNgv4v+AawI1MNcwv+gCStHoJmkuq+87lvKdquyfVsdi5wzsOCTyeHwwyFhmEq5g
         +ysp2VXrnHIl/Vm1Ob/qhjUCSy5aCgmRE5Gcfg6KtLCClOxrntTsgbX6IxckiJZkh65N
         tkdGutgM9uub2lwUNrKM4fOIPC7n72DplzQfxFtCSYYbWFDkDNVWJkvox+jHqGM4a0+k
         5csA==
X-Gm-Message-State: AOJu0YwJQ9KkWfHURM1XIr2m0y4QUT71+6Q0eAbBSEPLA05QpBQXAzRY
        txcKEVAxg7RGLLQz/2Ezr+XIfvRWby/2fluav7iiZbYGTT/mk/e/Wz9uJaJ28EjMM5N2qYupCHf
        mDpmjywi0/U7pIkI14owmhiCf
X-Received: by 2002:a17:906:20d7:b0:9b2:bf2d:6b65 with SMTP id c23-20020a17090620d700b009b2bf2d6b65mr6470907ejc.4.1700562312008;
        Tue, 21 Nov 2023 02:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+UJk+zZlK5NUPrng8ZM0MjQUSFGh7RXz8MfiFQKiFHg+caQVnu7yUEILkX7uCjm3wmWC4VA==
X-Received: by 2002:a17:906:20d7:b0:9b2:bf2d:6b65 with SMTP id c23-20020a17090620d700b009b2bf2d6b65mr6470882ejc.4.1700562311351;
        Tue, 21 Nov 2023 02:25:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906a29a00b00a01892903d6sm866248ejz.47.2023.11.21.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:25:10 -0800 (PST)
Message-ID: <f8c1979e2c71d871998aec0126dd87adb5e76cce.camel@redhat.com>
Subject: Re: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
From:   Paolo Abeni <pabeni@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 21 Nov 2023 11:25:09 +0100
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> As of commit d9962b0d4202 ("r8152: Block future register access if
> register access fails") there is a race condition that can happen
> between the USB device reset thread and napi_enable() (not) getting
> called during rtl8152_open(). Specifically:
> * While rtl8152_open() is running we get a register access error
>   that's _not_ -ENODEV and queue up a USB reset.
> * rtl8152_open() exits before calling napi_enable() due to any reason
>   (including usb_submit_urb() returning an error).
>=20
> In that case:
> * Since the USB reset is perform in a separate thread asynchronously,
>   it can run at anytime USB device lock is not held - even before
>   rtl8152_open() has exited with an error and caused __dev_open() to
>   clear the __LINK_STATE_START bit.
> * The rtl8152_pre_reset() will notice that the netif_running() returns
>   true (since __LINK_STATE_START wasn't cleared) so it won't exit
>   early.
> * rtl8152_pre_reset() will then hang in napi_disable() because
>   napi_enable() was never called.
>=20
> We can fix the race by making sure that the r8152 reset routines don't
> run at the same time as we're opening the device. Specifically we need
> the reset routines in their entirety rely on the return value of
> netif_running(). The only way to reliably depend on that is for them
> to hold the rntl_lock() mutex for the duration of reset.

Acquiring the rtnl_lock in a callback and releasing it in a different
one, with the latter called depending on the configuration, looks
fragile and possibly prone to deadlock issues.

Have you tested your patch with lockdep enabled?

Can you instead acquire the rtnl lock only for pre_reset/post_rest and
in rtl8152_open() do something alike:

	for (i =3D 0; i < MAX_WAIT; ++i) {
		if (usb_lock_device_for_reset(udev, NULL))
			goto error;

		wait_again =3D udev->reset_in_progress;
		usb_unlock_device(udev);
		if (!wait_again)
			break;

		usleep(1);
	}
	if (i =3D=3D MAX_WAIT)
		goto error;

which should be more polite to other locks?


Thanks,

Paolo

