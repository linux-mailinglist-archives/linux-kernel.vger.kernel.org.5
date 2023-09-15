Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC667A14AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjIOEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjIOEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:07:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F12718
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:07:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502153ae36cso2715965e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750832; x=1695355632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzmi/iJpKjOZhxEQBLno/kngFnqZ7SNTMdomSBt3AV4=;
        b=UDeSruiPdFHlQdH6JfCu2Ei8OwAp5U7MV1+i2hneGUx5wQYXUaX8X26FM62BWRqe/U
         fm4GwtPEhNNeQN8yJYIcmpAQ8/HN2mNwn4mU8SK0hnkT5P8NPj1rkGJ8kVgkHm3IG/8f
         djhUvO5lsmmFsxaCFhEO897/W3W7Vzn4Z5R7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750832; x=1695355632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzmi/iJpKjOZhxEQBLno/kngFnqZ7SNTMdomSBt3AV4=;
        b=oyqO9xwRq5ZIpImilyGPbvfCNKIvD1a3qAII0vmpc+7XVFHbudPHtspHNBApZG3avi
         2LwmOi4mZU5REhDNqZHODZGXjTsBObnuw4zOsBap4pUeTzImZChZfU3ECdna/XLBHk/W
         dcoiphMDUshY03wMndCq8tu23bmw8w/4VcyEJjAapCP8stUYsFSdyCi5w4tHVWN/8Jkj
         9HTurrhay/Jl+PzKgz4KOpOEp7FdJUFxAMxR6zNdswAuPhCXBzz5LrmnBdtwi5nEvduT
         LGN8oGUvBvvBDtkDoOzjkk9Igq5viyPk4GXSwPNJElDnbhWC3iwuSjRzdylsSJpexwQR
         fLqg==
X-Gm-Message-State: AOJu0YweW5BVdxkATJ2X/uqiwtxny/F5EtnDmofcmrXSDVxlcdBgQNvt
        KqFWFjcy53/sGSpdv6dEl2KiQISuNd7E7LiaFC+A4g==
X-Google-Smtp-Source: AGHT+IHPS3hgvoT9h4h71M5dq9RHUqZPZ6160DtqEMhD9LLdIbTTMUMfxv9+Y4dc7C1UVI025fGTudkIedQkt3zqhIw=
X-Received: by 2002:a05:6512:3d05:b0:4fe:8c4:44fb with SMTP id
 d5-20020a0565123d0500b004fe08c444fbmr532868lfv.38.1694750832139; Thu, 14 Sep
 2023 21:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-12-john.ogness@linutronix.de>
In-Reply-To: <20230914183831.587273-12-john.ogness@linutronix.de>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 15 Sep 2023 12:07:00 +0800
Message-ID: <CAGXv+5FNSBm170z-XffkfcfQaAw4XXH3NEkonKE2s4x8ewz7WQ@mail.gmail.com>
Subject: Re: [PATCH tty v1 11/74] serial: 8250_mtk: Use port lock wrappers
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 2:38=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
>
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write functio=
n
> to make informed decisions and eventually to restore operational state. I=
t
> also allows to prevent the regular UART code from modifying UART register=
s
> while printk output is in progress.
>
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
>
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
>
> Converted with coccinelle. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Replacements look correct.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
