Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8177BF70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHNR7f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHNR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:59:03 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B38E5E;
        Mon, 14 Aug 2023 10:59:02 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d650a22abd7so4256422276.3;
        Mon, 14 Aug 2023 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035941; x=1692640741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtSyWgoHAPKB/8w09KpfGrIziJ800wsSSLaufIpmVD4=;
        b=QdIJuFNlrCCrspSCHrWWtp0ttmeCfNdxUsPk0GHruDL0h3InIjQwJbGxJWw3AeSuXn
         fxoWtFdDvM5rNrytKySi/Enz0WfwBN2JUyla0ktvnvDr/ZNu2N5IhlT2ztPbSEQ/j2aH
         uCLkcdsqQPjjFYfZbOThdoYHuXwR2zkleWHkurWPPxnw3xtWqu/FjII+LZVWPGtU8ZWu
         dG/VuLUFn8DyHNr4X55ZpSCQ7/Wzzloaq8GahJy/3H4uLm7IShjCX4qazKqQ6sOCqgCD
         UONtMuSS0h7j0T+dXi869n/XbmACgy3LCYWDe4cQaH4RR09+i+Nha8bSQNtTIx3Gn6/T
         3WIQ==
X-Gm-Message-State: AOJu0YzF1j9vwe/EdudV7NnEAmtbh09DBETIk9WEWY0Wnvw7S95SFZ7t
        +rrHLbWLQzbFwYMWYAqSAjdpBcL1CW7g7w==
X-Google-Smtp-Source: AGHT+IEqUFN1xQGZV1K6nMtuyZyIRhlUR9/AM8b2QfUvTcyTlVh0QKSjS9G8Pq4hRSrorovbcRetXg==
X-Received: by 2002:a25:adc4:0:b0:d1c:5049:687b with SMTP id d4-20020a25adc4000000b00d1c5049687bmr13593046ybe.16.1692035941137;
        Mon, 14 Aug 2023 10:59:01 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id l124-20020a25cc82000000b00d538f9d0f4dsm2558852ybf.18.2023.08.14.10.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 10:59:00 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d650a22abd7so4256381276.3;
        Mon, 14 Aug 2023 10:58:59 -0700 (PDT)
X-Received: by 2002:a25:ccc4:0:b0:c00:e25d:818f with SMTP id
 l187-20020a25ccc4000000b00c00e25d818fmr12421739ybf.27.1692035939392; Mon, 14
 Aug 2023 10:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230810091510.13006-1-jirislaby@kernel.org> <20230810091510.13006-30-jirislaby@kernel.org>
In-Reply-To: <20230810091510.13006-30-jirislaby@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 19:58:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcA_d_gfPQy_H70-Jy4kG41xVACrEYwkvWOe-vkoCeFg@mail.gmail.com>
Message-ID: <CAMuHMdWcA_d_gfPQy_H70-Jy4kG41xVACrEYwkvWOe-vkoCeFg@mail.gmail.com>
Subject: Re: [PATCH 29/36] tty: make tty_operations::write()'s count size_t
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 10, 2023 at 11:39 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Unify with the rest of the code. Use size_t for counts and ssize_t for
> retval.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

>  arch/m68k/emu/nfcon.c                  | 3 ++-
>  drivers/tty/amiserial.c                | 2 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
