Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31377E537
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjHPPeK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbjHPPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:34:03 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC4210D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:34:02 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5862a6ae535so64980917b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200042; x=1692804842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaVSsPNBIbXa98DG/iHuB0Knmq9R+zqUhYDbkrJc/CM=;
        b=EfBpAqdNq9Wp4FxN+idd1fqvlVimTdAPfyKYvV5n+fVWmjbKJ74+XSKd3IDwjRw0X3
         Iaxavf9ZclUP1HySPa4bBZ3IwLTtINB775VAzZEKiaLcHBVfKR8uwv1m0GqWLiPCqNzK
         RUBeZ8yiADvlscZTG7Y+kbd2VTw+445Un8qMkWMdE28bNqRPg3YrWRLd2ZgG8gVX+Yw9
         djGBRjNSHUIs2x5GDT9rafl4FgfGOjUxsh28v898ADXxyy+PXYL5PwIixt/jJg8lpgqD
         AzSG3If+OwdWpMOIrrWwLh9+2KaOnUa4+2htZSYG6T+OZ2ZqGqNxQTLU4N6WDuIEHWXR
         1sbA==
X-Gm-Message-State: AOJu0YwEsVYk3Qzcw5D9ohaoM0de4iwLnl9ZglSp/P6rno4E0gtzbQM3
        5QdNIeMl0ZUXXTALicis3vbQJo8WOdsEGw==
X-Google-Smtp-Source: AGHT+IFVHHoowi/bWOdxa3HPYRh0I4XAZkNkp2/df7aT2MWfrYeRr7Zlk6XdhPjyREfaG4RJiJsRDg==
X-Received: by 2002:a0d:df44:0:b0:583:dca6:216d with SMTP id i65-20020a0ddf44000000b00583dca6216dmr2286275ywe.38.1692200041853;
        Wed, 16 Aug 2023 08:34:01 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id ey15-20020a05690c300f00b005837b48d16csm4026703ywb.84.2023.08.16.08.34.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:34:01 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d72cf9156easo50609276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:34:01 -0700 (PDT)
X-Received: by 2002:a25:d20d:0:b0:d1c:6a5e:463e with SMTP id
 j13-20020a25d20d000000b00d1c6a5e463emr2111588ybg.28.1692200041383; Wed, 16
 Aug 2023 08:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230809211057.60514-1-arnd@kernel.org>
In-Reply-To: <20230809211057.60514-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 17:33:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFRhBT4iNMQpzjspBR20s700FZbhq+NZ_f9HyV1Ztcqg@mail.gmail.com>
Message-ID: <CAMuHMdUFRhBT4iNMQpzjspBR20s700FZbhq+NZ_f9HyV1Ztcqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: define __div64_32() to avoid a warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
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

On Wed, Aug 9, 2023 at 11:11 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The generic __div64_32() definition is built on all architectures that don't
> provide this as a macro. m68k however neither defines nor requires __div64_32,
> so it should define an empty one to avoid the warning:
>
> lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice! 142 bytes saved (which do not show up with bloat-o-meter,
as it does not count weak symbols; patch sent).

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.6 branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
