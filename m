Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8277B33F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjHNIEy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHNIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:04:36 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24281D2;
        Mon, 14 Aug 2023 01:04:34 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-583f036d50bso45657947b3.3;
        Mon, 14 Aug 2023 01:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000273; x=1692605073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzJrlLI5WNhjukEiyCuwgA8oXCqB2FTn6jKbDcA5q68=;
        b=VYkhUSIYevw4jX7n7DwtuqrMjDq8XZmpKTrtRIY8MlwENiC6xwNGzE9jwH2kJy49Zb
         tehLBmOkdT0c5XI2LnVixG7HyrE9h5tA4v78JW0rRL3k01w/DFPi2gx2tHRai847WoxF
         9m06TVHesaQ9SJDpfycDz2jpY8MhD4BEcrzFOImXBzJAjlFP//Pg1AfDDyOwWXIZfwp7
         gkhP7Ic32EaErex/+CZPCp2dBvlK89hQf+Ez3vk649K/kTMloaj/W7/QlUAxgg86yXX8
         2+EUEo0ZA9c2zOXn/zobg1WtazAIQ1izfTFu1CjRY71Q19574wQJGhZfydYAD/2hl9Uq
         DebA==
X-Gm-Message-State: AOJu0YzYqVvyXysCyNQw597bOECeRrB3cPxMrpATSrOhvPzjUgXKbpI6
        wigJN7dT2bWuTs26WTbRKQaUUa3UO1a80IoS
X-Google-Smtp-Source: AGHT+IFiqf0Cez/blAgJYgJXeaRB/XvhWeMardG4hntJrofeZmd5YFiLvCMUGqopXR2YgZc5vzk/fg==
X-Received: by 2002:a0d:d552:0:b0:577:51cd:1b4a with SMTP id x79-20020a0dd552000000b0057751cd1b4amr13528895ywd.41.1692000273129;
        Mon, 14 Aug 2023 01:04:33 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id n11-20020a0dcb0b000000b0058419c57c66sm2634017ywd.4.2023.08.14.01.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:04:32 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-583f036d50bso45657847b3.3;
        Mon, 14 Aug 2023 01:04:32 -0700 (PDT)
X-Received: by 2002:a81:9294:0:b0:561:206a:ee52 with SMTP id
 j142-20020a819294000000b00561206aee52mr11727423ywg.24.1692000272605; Mon, 14
 Aug 2023 01:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230629073419.207886-1-tanure@linux.com> <20230629073419.207886-4-tanure@linux.com>
 <CAL_JsqKd_XYB682eHoW+omjGWLpuz0QL6zc0VB7u-Lm+X=PmOw@mail.gmail.com>
In-Reply-To: <CAL_JsqKd_XYB682eHoW+omjGWLpuz0QL6zc0VB7u-Lm+X=PmOw@mail.gmail.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 14 Aug 2023 09:04:21 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2QUEhYax=bOzGHr2f0O8KSGnn0ncD5+HQRSOTUXwv6wA@mail.gmail.com>
Message-ID: <CAJX_Q+2QUEhYax=bOzGHr2f0O8KSGnn0ncD5+HQRSOTUXwv6wA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 4:34 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jun 29, 2023 at 1:34 AM Lucas Tanure <tanure@linux.com> wrote:
> >
> > The new Amlogic T7 SoC does not have a always-on uart,
> > so add OF_EARLYCON_DECLARE for it.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/tty/serial/meson_uart.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> These 2 serial patches will probably never be applied if you don't
> send this to Greg and linux-serial. IOW, use get_maintainers.pl for
> your patches.
>
> Rob
Thanks, I didn't see that issue.
I just re-sent ad v9.
