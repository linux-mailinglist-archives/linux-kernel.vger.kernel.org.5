Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B6797428
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjIGPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjIGPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388711FC9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:32:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-573d52030fbso812462a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100672; x=1694705472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rz9GiS8mTfnAVkN8QSO49dpqTEISv8k2Dk2MfoLtSg=;
        b=FJaesjWlo/SBu62WFnXEkd6KlLeeChY7e7l3U8fWwGnjjwti1VNn3f//I9x/tsLXpD
         fY2GwD6YAcwn5IsG/d6HDHrVm+kHp6eEbeCBy4gJH1m4S9/nIMQKB98hKzhHpE1klAXE
         ryOyEC8maahGiIZ4WrmPbLXSg0/SyHUnC9ty96dLbS+yGZx2waYqB4X/aqcMbSG60WIY
         BQ6tBDi6GdXJ1y2GurOdpwqpMceCbpc7OWqPAvOGIu6I43O6uoNFIEPdd8BHWhQnPtCC
         j31RBb61f6Ww66uadz+mTn5H3yCK21+yHIg20sI/Nl8slzQ+dtcyODn2opt5NHmBEnDg
         1KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100672; x=1694705472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rz9GiS8mTfnAVkN8QSO49dpqTEISv8k2Dk2MfoLtSg=;
        b=It1QDoAcPS+cXtXcrZOh29U72GPfx/DBznOr7ffreeRzO/wddivvNgk0saK+waM2pv
         48R2Ce56rtkhVAP/+tUdOSYP7Xwk/Nn1/fa3czXciVeFsrUeTWTa6dWZfgx8dreNSd/M
         LklFL57tJV3APbUTpmKnnQS6uYFwfDS4PwYMp0ZL/BOBldBRyCzRzxym3yCluL459y5o
         tZSAk0AUoAmXGefPUWkWdsLSFa8beuBrdnkLMLi1qZtT9OkS7Z0f1qhWIzWL6f6cqyJw
         eY9NwQCvq7E60WQkrR+EQ2pCyrduaxjOtWs3vI7zU5VLrObE5zftr4ibjR6Oc0S/btqf
         CPnA==
X-Gm-Message-State: AOJu0YyQISqrwOP1QPSm48ca2BpkYWU9R3Mrk0TuSqNB1Znz+tiHvAfs
        WS6Irxc9uvOAYfefsFZVfXGAjkyWACpJPBzrvUpnp4mZe+DejIlL96A=
X-Google-Smtp-Source: AGHT+IFnux13voMEYKL2AvFFZ2IntVTZOtmPk8jRTbyWfstIdLEdj42EUj9cU8dCaEOekjzsm7vjd98pJPwVLSbOMrc=
X-Received: by 2002:a05:6902:120e:b0:d78:1b39:fd03 with SMTP id
 s14-20020a056902120e00b00d781b39fd03mr22126055ybu.64.1694072432520; Thu, 07
 Sep 2023 00:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-20-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-20-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:40:20 +0200
Message-ID: <CACRpkdZkPbvDTMo_ZOJ8rZ5+dUOqOi2_EfS+jzreWjMtpJrVYg@mail.gmail.com>
Subject: Re: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the swnode GPIO code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With Andy's comment addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
