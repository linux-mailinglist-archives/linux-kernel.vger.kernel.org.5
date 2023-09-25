Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7A7AD21F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjIYHoz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjIYHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:44:47 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDCB3;
        Mon, 25 Sep 2023 00:44:41 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59be6bcf408so67896217b3.2;
        Mon, 25 Sep 2023 00:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627880; x=1696232680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGlxeF3mvqh10+aDJP6sgcuQtFs8Uq5hua0HbhUOEJc=;
        b=iPKswbU4uA050Norm3TL6bsmzZ8Iknp5Mdx5O0QEZiZ7Cax9UNKfUzH99vPbF8sf+4
         LF/7hQkR8NlThgLchileT+CY6B0AIB7gd8kpFcHO25+YpMo97j5LTMrU9HBJVT7TcH3i
         IQnmf5K4rQBZ5diQAOrhA4nxps246KKdJrhKaLDVOiWOI8gYGiTLEY4i8HDJuccIsH+q
         5UbB5bMa4jgaUZzgL61WzaWPVZyP7PWMhqf03+5oeDJvQz84Au6RN/g9N8g2X04Z850G
         XyJdBe2TvqpmP9e6OMxX2RAQwFXF3SHN6cXtwLI8+nbcl/ZLIN1fGLVEVOtfI4DamRtM
         Zf1w==
X-Gm-Message-State: AOJu0Yx+fbhmPPshE1RZ4Y6oJSA0tDJ7qJm2JiWGIFMMuNKDh7vFkooG
        XN1BNP3C18oyHlArcC9lnwPSxkb8s4uA1w==
X-Google-Smtp-Source: AGHT+IGKgu31hM/9VX6A1nkYglZVi8xyxmuWBdM7nzk91mDbwxYk6dbH/QycBxvgtpWqw6qu7HQjQA==
X-Received: by 2002:a81:b206:0:b0:59f:4c55:efa3 with SMTP id q6-20020a81b206000000b0059f4c55efa3mr5193737ywh.12.1695627880230;
        Mon, 25 Sep 2023 00:44:40 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id gq10-20020a05690c444a00b0059f5828346csm1061744ywb.3.2023.09.25.00.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:44:39 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59c0a7d54bdso68063247b3.1;
        Mon, 25 Sep 2023 00:44:39 -0700 (PDT)
X-Received: by 2002:a81:b60f:0:b0:59f:5614:ebe8 with SMTP id
 u15-20020a81b60f000000b0059f5614ebe8mr4799116ywh.9.1695627879642; Mon, 25 Sep
 2023 00:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 09:44:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=y9i=36r-WHgpB9RhCF1rsfQ=qsosTbjwPCTHo9PrYQ@mail.gmail.com>
Message-ID: <CAMuHMdW=y9i=36r-WHgpB9RhCF1rsfQ=qsosTbjwPCTHo9PrYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: typec: drop check because i2c_unregister_device()
 is NULL safe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 12:44 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
