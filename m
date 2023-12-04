Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F6802B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjLDG23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:28:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F24CC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 22:28:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bc22c836bso5462152e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701671311; x=1702276111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKeCfLZc7mdf5ttEOE5xpGWsNMCS5nBu7bohK0rYA9k=;
        b=cxx1r+XXew+5s+HnBUjs9bSZmFf1RrhwwZDVsG1B+j/MITFaoTbHWKgHOhiW3qydkw
         s8tWVThoy8yct0MUtGo7xf9dTnNaJNzDqfMIBThvpiF1MADlftto1/VQnB9Jg/jN9swv
         qtbTm3gOL0TojgktRRfmW992C/4HWC0BarWkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701671311; x=1702276111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKeCfLZc7mdf5ttEOE5xpGWsNMCS5nBu7bohK0rYA9k=;
        b=Ba/CAiLwup3VN1ivAENNN9kS3VEw4hEQKHElYrKj47WQqSSK3owDu7uNSXOkiCQ+Uf
         ob8IXL9XCqSio4f4HLKsvhr035z177eSHTOrxwSMx3pDNDhmYAjAqlMSozOGW/v2LujM
         8Hw4BsYuTbv3krypSdDbOe4vJ1OuELFUtf5yrdyPuMqye9x+CxgZD6P/A7OSSo7w5YJq
         oBVlopqI0EXIyu0sRqTg+drSonlVxnXvQKfNXUnmD7tFBWqcoOS1G/I4HDzoUjKSqKiK
         C+vkP+Y3Xm54AJF8Wqw1FDMEpFXaKM9AHN+/ZXxu3aQU3omRUx1y4ktc2wiAuWdr99TV
         QfzQ==
X-Gm-Message-State: AOJu0Yy8I9a7Br3+hk5qX6Fxr7H0JiGnOy0WhKi/95PO+Rg5MuEsJaQP
        xyTTSPWIkmLSis7qOT5nKuRxZSN4tQXYuE/SJXzA/g==
X-Google-Smtp-Source: AGHT+IG95fL6ZmhFrrdBZs1yHZpwJEkMdnWR6Z3TRg/FZYz0mqiHrefYfWV2agXhFMwbCcFaJSeavkE3C7jpb9RAWYc=
X-Received: by 2002:a05:6512:368f:b0:50b:f88a:dd63 with SMTP id
 d15-20020a056512368f00b0050bf88add63mr334344lfs.102.1701671311129; Sun, 03
 Dec 2023 22:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-2-wenst@chromium.org>
 <CAD=FV=V_v11eZ6+3gUwOvdWGNM9owG7zCK5EiezTY7RJ3eaEMw@mail.gmail.com>
In-Reply-To: <CAD=FV=V_v11eZ6+3gUwOvdWGNM9owG7zCK5EiezTY7RJ3eaEMw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 4 Dec 2023 14:28:20 +0800
Message-ID: <CAGXv+5GiwgF4CJBPT7JucV8qEMY0jLAvT3TqRzvLjCKcVMZ0Mg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] of: dynamic: Add of_changeset_update_prop_string
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 9:01=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > @@ -1039,3 +1039,50 @@ int of_changeset_add_prop_u32_array(struct of_ch=
angeset *ocs,
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
> > +
> > +static int of_changeset_update_prop_helper(struct of_changeset *ocs,
> > +                                          struct device_node *np,
> > +                                          const struct property *pp)
> > +{
> > +       struct property *new_pp;
> > +       int ret;
> > +
> > +       new_pp =3D __of_prop_dup(pp, GFP_KERNEL);
> > +       if (!new_pp)
> > +               return -ENOMEM;
> > +
> > +       ret =3D of_changeset_update_property(ocs, np, new_pp);
> > +       if (ret) {
> > +               kfree(new_pp->name);
> > +               kfree(new_pp->value);
> > +               kfree(new_pp);
>
> Given that this is the 3rd copy of the freeing logic, does it make
> sense to make __of_prop_free() that's documented to free what was
> returned by __of_prop_dupe()?

Makes sense.  There's also one in property_list_free(). I'll add a patch
for it.

ChenYu
