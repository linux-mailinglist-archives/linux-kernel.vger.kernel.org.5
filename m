Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81FD7BD973
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbjJILWR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJILWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:22:15 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4099;
        Mon,  9 Oct 2023 04:22:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-579de633419so54080837b3.3;
        Mon, 09 Oct 2023 04:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850533; x=1697455333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPwjpLn9USlrr/tk2CipqLIIg/Q3mvsVfg6prhm4tx8=;
        b=MWvf845F13D75kdhCkHvZcwQndcV0R/0KjY+JVSoXumfNzp33p1gmiOp0xv/yNgEjY
         9X78iS6uHQv5pt6FmAGhKl9JEXDzprwZHs5KFP1p9lDz9D1nlsY64BE+nugdW9p15Z9R
         Z07uoJ1owfH/Lt9o2SEXkqB6lWPa2KLL9iYaBLkNAy+/jwEWdynP9pBatCe/MZCxcm+Z
         oJhO+mzvohemgtLzKgGCa/rNnKSE4LIW75m77uqoqEmRzwnbaHC4Rtwy32VSzIxPE2ho
         KAlkFEYJyyrWd31miUup03e6UAlwkomGPkDPerJmtY/uQGuymt0tdrBpyCgfBoWKySrH
         AZQQ==
X-Gm-Message-State: AOJu0YyHCTgf4FRCMhMFDbpkmG6QSkK70rVSYRkUxvkYX4PvQxJ7Wplx
        w3W14w8QQb4YajNWgPIGBdD6lORJqSabGw==
X-Google-Smtp-Source: AGHT+IF0l0Knea3PBEbzvFVLpFbCAXs5gro0QJNj9gTe8Qq6N/omFdRQCud00fWq3TdnofmZ/2UPgg==
X-Received: by 2002:a0d:f405:0:b0:583:741c:5fe6 with SMTP id d5-20020a0df405000000b00583741c5fe6mr13004724ywf.52.1696850533241;
        Mon, 09 Oct 2023 04:22:13 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id h64-20020a816c43000000b0059bc980b1eesm3602599ywc.6.2023.10.09.04.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:22:12 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-579de633419so54080597b3.3;
        Mon, 09 Oct 2023 04:22:12 -0700 (PDT)
X-Received: by 2002:a0d:ea95:0:b0:5a1:ed8d:111f with SMTP id
 t143-20020a0dea95000000b005a1ed8d111fmr15792790ywe.1.1696850532452; Mon, 09
 Oct 2023 04:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-6-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-6-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:22:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxJYBeK1ntWthZS8PhYuGkGqmT+u89jBZdpph4zYR58g@mail.gmail.com>
Message-ID: <CAMuHMdVxJYBeK1ntWthZS8PhYuGkGqmT+u89jBZdpph4zYR58g@mail.gmail.com>
Subject: Re: [PATCH 05/36] gpio: rcar: use new pinctrl GPIO helpers
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
