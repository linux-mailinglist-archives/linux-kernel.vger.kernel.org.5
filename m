Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D7798C44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjIHSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjIHSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:08:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17F210B;
        Fri,  8 Sep 2023 11:08:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf3f59905so286402866b.3;
        Fri, 08 Sep 2023 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694196434; x=1694801234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=subAUO9E8mZRv/6RLgXHnMS5iBnCJy0fu3qM36GnA0o=;
        b=CApMUrWNj1LJz/M+5QH5Q95FFnWo1dONbvDW4lH3AKtSBbHEeuzejFksWR/qleSFFy
         htLdpgmhGuTXCmPp3FGLiNj8P2at56+neqqiA9W5pJg5K0KBr5aaFaiKQAtjgB3yrnlh
         QUBsUwDnKo/slFHdzFb6/q8eQF4qgBPtp25Uv/BeojQIoXYiHWPlr3MTh1LeBQUU/Hsq
         b0aTlVZYu+gDUcrZhEFp45KsO81lhg+K6kkOuh8LJRwBthvIhpANC3uRkFLxw2K38+ed
         kFMCfMuxrD+zl+XWN7M3AeDvYVn/JAYkyHgKWH9647GOWz9l8XIXLrvlAAisieNMt6IY
         jCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196434; x=1694801234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=subAUO9E8mZRv/6RLgXHnMS5iBnCJy0fu3qM36GnA0o=;
        b=KQ2c19MJ8zh6CMIciHxloT6HZoD8gCVnY2yXys1W8CbAQ8YaLIiglBsER4oSFAE/JF
         thi8lHayvg5aUdePvH6g7XON4qVU70BgQ+ZHovY0kRD82zP4/yzY4JhyI6PqS6p6vztn
         nCfcVUbmRP65++XvUuVkdbMnNwAD+ZVJbnhasnIpSQTPhk7FTllUpbrkAjAgfqtUjrkl
         2STfmZ6DyQdKZujHiSJxkWxoCuEj/zGFAzBVEGhgAZEvRDSnv1w6SsxPhM8jFEFFTtKZ
         bW4LEADhFrenmWCCT/kCRCkLXPbp8JcewSJXKiYhmdTVTNtB1XGKzHKLBFuG1O8Zn3Xt
         4dpw==
X-Gm-Message-State: AOJu0YzJ0i/2Vp2HXsY6JPcPCCeL18oP6EDFxsYPGjOb1PeVc7Nea7Io
        dXTdZ0tMyjXjZ8hOcryWOxxWPbAopgBv+u6k
X-Google-Smtp-Source: AGHT+IEBdgr1xof7hnEAV6QqzBERHOL9Ak0Vp3bXRIwbgu6y3tDfH9aHIemt2jhAqyAqEOA3aPEmIQ==
X-Received: by 2002:a17:906:2d0:b0:9a1:bd53:b23 with SMTP id 16-20020a17090602d000b009a1bd530b23mr2467057ejk.14.1694196433411;
        Fri, 08 Sep 2023 11:07:13 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090682c500b00993664a9987sm1312081ejy.103.2023.09.08.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 11:07:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
Date:   Fri, 08 Sep 2023 20:07:09 +0200
Message-ID: <6555932.G0QQBjFxQf@dell>
In-Reply-To: <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-16-brgl@bgdev.pl>
 <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czwartek, 7 wrze=C5=9Bnia 2023 09:31:01 CEST Linus Walleij pisze:
> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>=20
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_find() is going away as it's not hot-unplug safe. This platform
> > is not affected by any of the related problems as this GPIO controller
> > cannot really go away but in order to finally remove this function, we
> > need to convert it to using gpio_device_find() as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> I was cleaning this one just some merge cycle ago, now it
> looks even better!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz

>=20
> Yours,
> Linus Walleij
>=20




