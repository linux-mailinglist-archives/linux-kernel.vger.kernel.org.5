Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5D87BD979
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbjJILXD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346171AbjJILXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:23:01 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF499;
        Mon,  9 Oct 2023 04:23:00 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f4f80d084so52258737b3.1;
        Mon, 09 Oct 2023 04:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850579; x=1697455379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPwjpLn9USlrr/tk2CipqLIIg/Q3mvsVfg6prhm4tx8=;
        b=C74AHYDOw1xSQ47nMLchJzRYNXZ2qmVBmZk90A1ZuqbXg4VoyKmiYpkPxQZc4LUFtJ
         OIlk6ySNFzrHtRIHpMAkiFhJfz3InhOsXYS9X9iPfmPT9A99EBQrF7SHsHz1Vt/bmwJ0
         t5mW/RRcCWpbdyRoVIxOTOgh8g50R6A6HY6fVUmmkWIw+eZcECUG0kL/1njXnhhbmGut
         543n9SnKHaXmgb3mr48ugIFRoA+s2fIOwDidhtp70BKaMMO1XEs7SaLsguHyNoTDhmN1
         tl4ct46Nqg27OVjNQGJDefEdYi2l1AYgCw2367lKuTMpnoVDCidK0EO9wG1eOuB5KwD1
         DmoQ==
X-Gm-Message-State: AOJu0YzoGYn30uoBnscgXdEPOIO5EgHNzhswxxQ4OmeRXBwn4MTtDBw8
        MqA0q6IhuLGuJxo3QIdpaEmteY7YAUifow==
X-Google-Smtp-Source: AGHT+IF2CYZ4ST2UuCN4DHZkwmmVt45Kz3ouQI5XGUvcPKByjFT0J5PkNNykxlOSp3VPc7J7Wm6uZw==
X-Received: by 2002:a81:af27:0:b0:5a7:ab4c:c7bf with SMTP id n39-20020a81af27000000b005a7ab4cc7bfmr174644ywh.0.1696850579634;
        Mon, 09 Oct 2023 04:22:59 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w205-20020a8149d6000000b005927a79333esm3627286ywa.28.2023.10.09.04.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:22:59 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7af45084eso327507b3.0;
        Mon, 09 Oct 2023 04:22:59 -0700 (PDT)
X-Received: by 2002:a81:af43:0:b0:5a7:af72:cb50 with SMTP id
 x3-20020a81af43000000b005a7af72cb50mr24941ywj.19.1696850579135; Mon, 09 Oct
 2023 04:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-15-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-15-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:22:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUp4GtrvJgOCRG149JFmWHAkHyvOu5FmE0RCvo6GeH-QQ@mail.gmail.com>
Message-ID: <CAMuHMdUp4GtrvJgOCRG149JFmWHAkHyvOu5FmE0RCvo6GeH-QQ@mail.gmail.com>
Subject: Re: [PATCH 14/36] pinctrl: renesas: use new pinctrl GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 4:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
