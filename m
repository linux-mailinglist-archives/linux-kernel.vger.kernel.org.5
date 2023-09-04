Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53737914BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352664AbjIDJ3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjIDJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:29:36 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F399191;
        Mon,  4 Sep 2023 02:29:33 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-58dfe2d5b9aso16753947b3.1;
        Mon, 04 Sep 2023 02:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819772; x=1694424572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhYY1jPPd4YIanKFTU2nWMCKlreWmIcOriE8C055zzM=;
        b=l+GSf2FY2KSR2xQTgPYgPvmnm3r2UN51lXBfepe26x1cLOgLDVml/WyshZgd5+sh6b
         uVIw697wAj8Qy0il7LQ2cXi+5dHga8E3Tf8WRV0hbf3mDeGc5AcKHMz2KuC3fLrORR8t
         pTs4vkjrPNawWVVcX55qGDEfbmcBy4IirDXkEpOlZxMbchjMdUvTyYRgH4SJQ9bww2X1
         3Gntpk/NRgkC03m/g8uH2kV0oGEEfxsb3hoAQUl7Rwe7XTWHbgLN4fiFn+rhkXllvjos
         zPI2S8Mlf1eHFGh8DNFNuf5PmEg1BHZQbOJe99mvSFSnoeY/kqMgJ3atmxMUNnuAKYgZ
         0JHw==
X-Gm-Message-State: AOJu0YzHXJsBBQ1I3ZATnG5oohVgw0CwGdREgQuJl4bSBaHZpezIqmMi
        YzJ6+tk15Es6MQ11w+4jIwNGqvq7bGwFOg==
X-Google-Smtp-Source: AGHT+IGFMRDvwvBfA8KStTTP+OGp+HJDj96FgGdzcGJfNbjL7Cecds5Rl6Zh/7n+hkd7sXsoRXG9oA==
X-Received: by 2002:a0d:cbc6:0:b0:576:87b1:ae0d with SMTP id n189-20020a0dcbc6000000b0057687b1ae0dmr13789348ywd.21.1693819772503;
        Mon, 04 Sep 2023 02:29:32 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s7-20020a81c447000000b0059935151fa1sm1450126ywj.126.2023.09.04.02.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:29:32 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d7bae413275so2922222276.0;
        Mon, 04 Sep 2023 02:29:32 -0700 (PDT)
X-Received: by 2002:a25:ae57:0:b0:d72:7cb8:21a1 with SMTP id
 g23-20020a25ae57000000b00d727cb821a1mr12231769ybe.4.1693819771988; Mon, 04
 Sep 2023 02:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 11:29:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWW81k+hzHeT-CH7B5Vm3MxvicjB7+jRQf2W8ecMbk+eg@mail.gmail.com>
Message-ID: <CAMuHMdWW81k+hzHeT-CH7B5Vm3MxvicjB7+jRQf2W8ecMbk+eg@mail.gmail.com>
Subject: Re: [PATCH] m68k/atari: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
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

On Wed, Aug 30, 2023 at 8:54 PM Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.7 branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
