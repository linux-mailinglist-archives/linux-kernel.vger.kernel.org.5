Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01B774D38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjHHVnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHHVnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:43:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8D4E71F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:53:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso9590591e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691513593; x=1692118393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGhuIKV/L3bAbsUWL0BAHFtTykQxuprzMPnTwpvh1C8=;
        b=DucOkGJgxyj5utymXaBcbNRIf4sQkKleRIVzXrRJK5i9nGIsth+eL9jFyMHOvNp74m
         f39lpeOsc1916ttxG5ZwTZKYNoZFutX0T7iVR5ayUv0Lg9ESAgSguo+2IYPNOKzTwCvI
         16KqyCF8jFLJqtTNQRzH6g+URPzTVY5IHhaeMXQP5/NIFQn1r9CyozOI+dijxay/5ywb
         n1zUvEZKIHenrlf42CJuP+ipvplIuhnO7da/rgrEFqVlQSL2rYdCiL8zyfQIoSUW+vkk
         SkMmcbNso7YMq1uPR08DviKvqcU2nPxkvKoUB6tYrifh5f6K+N2Jeom8HnaaMLWeMTZn
         iuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513593; x=1692118393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGhuIKV/L3bAbsUWL0BAHFtTykQxuprzMPnTwpvh1C8=;
        b=e8Muxrpx1bZGL7H9J3n7XyK/PDTvAe9XL+VfG3LCyOkenuMX4sNj/WKd+JtJTu1mDq
         lkw+VwILysOZZe5/uJaaES5+beXsvWn7IbUji3FUyKHIOebAOyLjMfmYm/6BdIUbVfrt
         uqrcOfy15r89a3kzuAPNkvxsm2or1glzVuQahSwAsQXb0K6ujAcNCW9+RBIu8n/LXtKJ
         1TZ2kgunSWkNsmdGG2hGID3CtZWPCP1rtMB1MjMmFxuVGIWc5CcRWk8CwKc8I8I9zwuM
         c3kM1ZX3AAU+DZUz8BNP05GEJA5XBqap0hS8n8uwcN7piJ3aHjUAjJIZMtxM1CX2x+1n
         qGKw==
X-Gm-Message-State: AOJu0YxEkkXxahRXqCgz8GaGvP8zenEccfwNe6+/uT4fMfrkJlnSdSHd
        Q+HzH5/3NKO/HGcv+ar4UaMlpip472RsOr6nxxMJk7ffS+uMVe/8U+ks
X-Google-Smtp-Source: AGHT+IH55JKIqgT6Ka9IEuC2AaX5V6W9W2P33HjRg8M3EvAK1ZRJKlSCDPgy0lTJ5+Q1iHi68i4Q9DYZvDifVThfZ2E=
X-Received: by 2002:a19:ca09:0:b0:4fa:6d62:9219 with SMTP id
 a9-20020a19ca09000000b004fa6d629219mr7169552lfg.62.1691472836351; Mon, 07 Aug
 2023 22:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230808032510.31754-1-luke.lu@libre.computer> <2023080851-duh-scroll-09bf@gregkh>
In-Reply-To: <2023080851-duh-scroll-09bf@gregkh>
From:   Da Xue <da@libre.computer>
Date:   Tue, 8 Aug 2023 01:33:45 -0400
Message-ID: <CACqvRUaK_Pj1DT4QY+YpKmvGeFqmM8KPcYWqTLNJoUJJaEbFAg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: do post init to fix broken usb
 after resumption
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luke Lu <luke.lu@libre.computer>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 12:56=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 08, 2023 at 03:25:10AM +0000, Luke Lu wrote:
> > Device connected to usb otg port of GXL-based boards can not be
> > recognised after resumption, doesn't recover even if disconnect and
> > reconnect the device. dmesg shows it disconnects during resumption.
> >
> > [   41.492911] usb 1-2: USB disconnect, device number 3
> > [   41.499346] usb 1-2: unregistering device
> > [   41.511939] usb 1-2: unregistering interface 1-2:1.0
> >
> > Calling usb_post_init() will fix this issue, and it's tested and
> > verified on libretech's aml-s905x-cc board.
> >
> > Signed-off-by: Luke Lu <luke.lu@libre.computer>
>
> What commit id does this fix?  Should it also go to stable kernels?

Hi Greg,

Suspend device tree flag has not been enabled in-tree for the Amlogic
GXL (S805X/S905X/S905D) series due it having PSCI 0.2 and thus never
untested. Most of the suspend resume code was only tested on newer
G12A/B series.

This and "[PATCH v3] net: phy: meson-gxl: implement
meson_gxl_phy_resume()" fixes USB and Ethernet after resume. HDMI
requires another fix.

It would be great if they could go into stable since we are carrying
these two patches in our tree on 6.1 and they're applicable back to
5.4 but I am not sure what the criteria is.

Best,
Da

>
> thanks,
>
> greg k-h
