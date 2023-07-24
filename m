Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810075FB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGXQIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:08:15 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B248131
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:08:14 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-583b4522927so27828077b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214893; x=1690819693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc4HBfAWhFIrA+P5+l0RBWimMN2JNFuFZoCBh9iYioY=;
        b=Fe7iTkYMaFUKSLGFVgRCZKttRU/fbVpGkiN8Q2N12VSz6jIbcP4Yw3lweR5eb13Ckt
         iRX8iVj/0wIOo3HNPd28OHrCUUE1tSgXk0KBTY4WrXL/jj9thWZv9mkcD1luXTzJCDlA
         yyPa5yupDDCxS/ei7uF3CbcpnW4x300Ca4c+zOSXrNb+uJh+MpSkVLzpf0hms1CTokCX
         5jNP7ZTg0kNbHQXZ9+DwAET2bEdxg0Hq2AHRNvjoUV40DRJTGlcgs74fWFDKHjr9DW8P
         r4FHGVQa6Z0aVGuA60uSWjKQ/YqGb8YmpmMcE6LM3/Qxk8Je+NWT4bboKynr7ehZF3v0
         iV+g==
X-Gm-Message-State: ABy/qLY4sscTjDdUqD+d6yfg2h+ZxYNOMfB1O8JzC58Zrmyf8W7WBd6Q
        g0s6xTlVKiNKjt39Va5lp0SjVBWBRbLD3Q==
X-Google-Smtp-Source: APBJJlEKac4I2SozQ3UScZ+DGgxLIBMYdBtdanpJJvSQagh2wSIUIZuOtxy5z1KVxINORCWllmrsYA==
X-Received: by 2002:a0d:cb08:0:b0:579:efbb:cbe3 with SMTP id n8-20020a0dcb08000000b00579efbbcbe3mr7512713ywd.43.1690214893579;
        Mon, 24 Jul 2023 09:08:13 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id b81-20020a0dd954000000b005794a9576f0sm2873547ywe.9.2023.07.24.09.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:08:12 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57688a146ecso54815347b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:08:12 -0700 (PDT)
X-Received: by 2002:a25:2fcb:0:b0:d0e:b419:f4dc with SMTP id
 v194-20020a252fcb000000b00d0eb419f4dcmr3377848ybv.10.1690214892152; Mon, 24
 Jul 2023 09:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230722180925.1408885-1-hugo@hugovil.com>
In-Reply-To: <20230722180925.1408885-1-hugo@hugovil.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 18:08:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
Message-ID: <CAMuHMdVTDrTowx2-MgYaaNASKLZw=ra5z7pL5WtemDgZ3HS5sQ@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On Sat, Jul 22, 2023 at 8:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> does NOT change the DDRAM address to 00h (home position) like the
> standard Hitachi HD44780 controller. As a consequence, the starting
> position of the initial string LCD_INIT_TEXT is not guaranteed to be
> at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> command.
>
> Extract of DISPLAY_CLEAR command from datasheets of:
>
>     Hitachi HD44780:
>         ... It then sets DDRAM address 0 into the address counter...
>
>     NewHaven NHD-0220DZW-AG5 datasheet:
>         ... This instruction does not change the DDRAM Address
>
> Move the cursor home after sending DISPLAY_CLEAR command to support
> non-standard LCDs.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/hd44780_common.c
> +++ b/drivers/auxdisplay/hd44780_common.c
> @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
>         hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
>         /* datasheet says to wait 1,64 milliseconds */
>         long_sleep(2);
> -       return 0;
> +
> +       /*
> +        * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> +        * address when executing the DISPLAY_CLEAR command, thus the
> +        * following call is not required. However, other controllers do not
> +        * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> +        * unconditionally to support both.
> +        */
> +       return hd44780_common_home(lcd);

Sorry, I haven't tested your patch yet, as my HD44780 display is
currently not connected to any system.

Your patch LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Note that hd44780_common_home() calls hd44780_common_gotoxy().
According to the documentation, both HD44780U and NHD-0220DZW-AG5
support the Return Home command (0x02), so that could be a good
alternative.

>  }
>  EXPORT_SYMBOL_GPL(hd44780_common_clear_display);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
