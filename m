Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20387797840
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjIGQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIGQos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:44:48 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19ACE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:44:20 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1d14bb44ad1so861351fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104906; x=1694709706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhjMO+NmlnkrwuQTWTc/YRBA9QtXdjC/hl8DIJEpExk=;
        b=NKX+mfUQXVeJ9GK2taMwW/wEB4n2TuX9/yAqw90BfGG591N4YJB7cHIgL4MRVe5fes
         7nPdNkCaUKNpDs681pc9kx2r64oD878b1qrZ+oind6+V2p3W8yZ65DtXDAD4Q4nXxVIm
         +F5h48dZl+EemY/upL5MnjOn/VjWdaK1s3O0eC76CR20FDSDsEW9T4tVVHvnuuxGbphg
         gd0G+njgTkgg5Ipf6pElNMAvMn3N7YAOZsjUWUHDB8BXGx8DTv1qW/e4wzLEvwI/5HRX
         E0+q1hit+LNorXcqifHRgyUsvWESvaGXlbEQT/EZRvJ7mJWu6l8WWMlxM0jrlgZuc3v7
         w77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104906; x=1694709706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhjMO+NmlnkrwuQTWTc/YRBA9QtXdjC/hl8DIJEpExk=;
        b=g/RDhuOAtKL/AqjgIsAegAy5kwcimfvffDdDXeMR3Ufobzgvh3xpHNyh/DKmseUP5w
         fwOTesq9cq3GPyTuHpLb5QvowSneIax5tcg870xJm3Q2gJNagMsMnCUGJO7rRslcd2Ug
         AcvGH0Fs+CiiR4esyqQVro1A0VhAYRr2o9GI/0jBD1gOQ/MeFpdYsCvWRs330wbADYLn
         B7u+GWa9Y77e3qDvXDknc5S6FjMky8HN0cMgpa4sX8jwpzy0SJaTchjtbfj1y5QptTpp
         6Q25k7TChu/wNFkIMz6B+p1RKbe0Gf36k0KOjlUuK8yROyhtUk9qyZjI/gRDxl5v+2gr
         t95A==
X-Gm-Message-State: AOJu0YwDe/Gx0f+wYgBVXt24/knaERYvCRAuOrrbzh8bqlCzrX404Rs0
        KP0D8DbywNUh8SGqxDUYEA7yfeFvZvyAwnzqPsGiDVtpzW4ABb0BoL8=
X-Google-Smtp-Source: AGHT+IEos+IWcRlRURBpWq2f/yqX4JwD1uUNGc4FMcBDjtB4EYVZgMX+6wsZb6/oamwVKLnZoLMvxAzj5BAJ8/qIfJs=
X-Received: by 2002:a25:aad4:0:b0:d7b:9ac8:f439 with SMTP id
 t78-20020a25aad4000000b00d7b9ac8f439mr18109140ybi.40.1694071872125; Thu, 07
 Sep 2023 00:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-16-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:31:01 +0200
Message-ID: <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiochip_find() is going away as it's not hot-unplug safe. This platform
> is not affected by any of the related problems as this GPIO controller
> cannot really go away but in order to finally remove this function, we
> need to convert it to using gpio_device_find() as well.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I was cleaning this one just some merge cycle ago, now it
looks even better!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
