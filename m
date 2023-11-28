Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650C7FC126
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbjK1OEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbjK1OEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:04:13 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E61B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:04:19 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5c85e8fdd2dso52018737b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701180258; x=1701785058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyTIAD88uiTFC+Ckur3HZ5JKDTkHFJddsUZ7zO5rxZY=;
        b=hq7i298Pw7cX6bYVfE0rycBCKndCWi5xU/zKtoCK7xKckbZvW5sb5cswAAQE1MBiq6
         mV1Awuf87huk4S6dYN0/vy59rNG6kXifDajpk+smwKaPam9o1Hag7+JZwxZbpkbPswit
         Xjy/Yv8B+mxx2pzBfSYx701ntYvIF+RL/wqufXjglzYa7GuKvowkt95ZGHbL5je3UhX/
         gx/WSwuNEfHz3Ii9GSE0Va/RPM7y6T89bp2i+2Uink4br7NWTln9W5KSznDj97pgyk4P
         gFI4wUou1F9KOK6JcIdPTL5VV9iy/GRxIAOB24Y7d9OYr7ALXlTH0XBCAoHlSYah9XhD
         ydhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701180258; x=1701785058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyTIAD88uiTFC+Ckur3HZ5JKDTkHFJddsUZ7zO5rxZY=;
        b=JF33ot2/RtVvUln7AVH5AQMyCJm+RcInK4dj/TeYMqQDiYn3i024A55KyqZGI1M0wC
         2sHoeJcZNWLkOncUBuUZ20qLc9qB3YElTfu+vOMgyeCVMmMtpcIIsEB2sO/O7OiwwIvz
         kfHjzwEyjHgP7a81Sj/6KjS+lAzEKzDCNwPyBEHN/4dbBzlakWTA0ucoJhjnugEOtpl7
         gSyknNKFNuYtN0vhkfNYcE919R+QT6iw4zhRKfKFCrbi5Q7n9Il8WAoddXpFp0282tj4
         jsihqYhFDy61fRH+wzIFcViHJialrw9yPnpVz6lajNXBW1rFYCxPmqtD++KGlqjLHQPc
         mBIw==
X-Gm-Message-State: AOJu0Yxg2TFz/3V2dNt6LbHamI5RtVozeWNWGtHUjIKfemDbJySzmtHe
        k0wGehEgGE9h8q2EesykjjrYMpwvHyyL648RqdI5rA==
X-Google-Smtp-Source: AGHT+IEAhaxY7VXrsKyapb49YDVLidKEv2PVueicNtrV/zkkM1Fw6vnoicZOv1OP8hqYM6AKpWp8/dsN2BJz/2mmQrA=
X-Received: by 2002:a05:690c:c09:b0:5ce:7ac9:d10c with SMTP id
 cl9-20020a05690c0c0900b005ce7ac9d10cmr14223522ywb.32.1701180258562; Tue, 28
 Nov 2023 06:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20231127193716.63143-1-brgl@bgdev.pl>
In-Reply-To: <20231127193716.63143-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 15:04:06 +0100
Message-ID: <CACRpkdaMCdMaqPrmBJgTKHLGsW8YJmq=KkuzRToiF2EYk1apeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sysfs: fix forward declaration of struct gpio_device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 8:37=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The forward declaration for struct gpio_device should be provided for
> both branches of the #ifdef.
>
> Fixes: 08a149c40bdb ("gpiolib: Clean up headers")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
