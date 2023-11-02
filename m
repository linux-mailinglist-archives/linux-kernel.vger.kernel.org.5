Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588A7DF3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376500AbjKBNZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376495AbjKBNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:25:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF41A3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:25:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9beb863816so947184276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698931545; x=1699536345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JT2WiqrUWiKdMUK5Gi6pkMsSfdNk0yg7yzJZhitgBsA=;
        b=xj51gx7KwSodbO9MrV0la61ZtLySF2U28ZO6nJHEHxEjtA0o9k1+tj0U0CMzff2EI8
         dXRlyyfz2Fd6Le5hILECRe1wUJmxlEWcLPoyHvW5OcpFmxTOJsTSrMGLpjWLFMyX+E53
         XBDxog39SjamvhEL0sV6JpCk9IftoSHX3UaKfsq1ryAmH4Tm7xuscJBEQuAYx6t1kw5b
         TyLtBWaPk6/haIr35DwGfeSpUgMIsNwxpUpm0kuj78Vxu6N3huiepR22z8Hzp/sinfUl
         xvq0isGYJOthog1MmTrRU+GGuQktS9TOmD3OhMvJ6oqdE28/9IEPROS4GZDG0sh4h/yR
         1mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931545; x=1699536345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JT2WiqrUWiKdMUK5Gi6pkMsSfdNk0yg7yzJZhitgBsA=;
        b=ApF4cCZpKuGHWI9/epKjjAiH8g8IYYQFUXbGuXcTdj8rDasjJXw78uRSaUv8fdiMQ8
         Ei+3qGSVLdExDJHCqFCA3nvcqqcN+1zsqCs/8Koft9tfMqlCwUbNpNuzad7rpSA9ffZJ
         sXh9U8t66EBkSg+pXg6hJKwh/Xsmv+0GAr6rwWZa1Hw+Ja1GtKt2PInQXs9a7A5SAirU
         QCVG+7oVDHO5Dp2oVN78wS2F2XTdbEk2l43/syBe+zAFr/h7+gVEOpuj1nFaUp6oFXqS
         9jVGT9Rccq80wnfyIRJwchR6/MiKtjLtawmSFfvzXmA+VHe+xvlx2yOTRc8X7E1Ugj04
         9FyQ==
X-Gm-Message-State: AOJu0YzatpHLX0QCc8gU1u6PilikNDTj2pkZ4aww2a02zRS5KCs3TSjz
        KyB9bpZJfLgUeJKiMOlAJhLB+OhOAtop4z1OIFQTdA==
X-Google-Smtp-Source: AGHT+IEgO4VcMdk7S+MhCs4e+ldmiTvFIF9d7453ck3duRyDnCbxH0+iHjLdDTAQv/fHIGka04+fBZU/vdjm1M4Ps6c=
X-Received: by 2002:a25:8485:0:b0:d9a:c5f7:f848 with SMTP id
 v5-20020a258485000000b00d9ac5f7f848mr14839901ybk.63.1698931545478; Thu, 02
 Nov 2023 06:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
In-Reply-To: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Nov 2023 14:25:09 +0100
Message-ID: <CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com>
Subject: Re: [PATCH] mmc: truncate quirks' oemid to 8 bits
To:     Avri Altman <avri.altman@wdc.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alex Fetters <Alex.Fetters@garmin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 09:52, Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> We now only capture 8 bits for oemid in card->cid.oemid, so quirks that
> were filling up the full 16 bits up till now would no longer apply.

Huh, thanks for spotting this!

>
> Work around the problem by only checking for the bottom 8 bits when
> checking if quirks should be applied
>
> Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")

I wonder if the quirk approach is really the correct thing to do. I
had a closer look around what has changed along the new versions of
the MMC/eMMC specs, the below is what I found.

Before v4.3: OID [119:104] 16-bits.
Between v4.3-v5.1: OID [111:104] 8-bits, CBX [113:112] 2-bits,
reserved [119:114] 6-bits.
Beyond v5.1A: OID [111:104] 8-bits, CBX [113:112] 2-bits, BIN [119:114] 6-bits.

OID: OEM/Application ID
CBX: Device/BGA
BIN: Bank Index Number

It looks to me that the offending commit (84ee19bffc93) should be
reverted instead of trying to introduce some weird parsing of the card
quirks.

In fact, up until v5.1 it seems not to be a problem to use 16-bits for
the OID, as the CBX and the reserved bits are probably just given some
fixed values by the vendors, right?

Beyond v5.1A, we may have a problem as the BIN may actually be used
for something valuable. Maybe Avri knows more here?

That said, if the offending commit is really needed to fix a problem,
we need to figure out exactly what that problem is. The EXT_CSD_REV
doesn't provide us with the exact version that the card is supporting,
but at least we know if v5.1 and onwards is supported, so perhaps that
can be used to fixup/improve the OID/CBX/BIN parsing.

Kind regards
Uffe

> Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: stable@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Alex Fetters <Alex.Fetters@garmin.com>
> ---
> Notes:
>  - mmc_fixup_device() was rewritten in 5.17, so older stable kernels
>    will need a separate patch... I suppose I can send it to stable
>    after this is merged if we go this way
>  - struct mmc_cid's and mmc_fixup's oemid fields are unsigned shorts,
>    we probably just want to make them unsigned char instead in which
>    case we don't need that check anymore?
>    But it's kind of nice to have a wider type so CID_OEMID_ANY can never
>    be a match.... Which unfortunately my patch makes moot as
>    ((unsigned short)-1) & 0xff will be 0xff which can match anything...
>  - this could also be worked around in the _FIXUP_EXT macro that builds
>    the fixup structs, but we're getting ugly here... Or we can just go
>    for the big boom and try to fix all MMC_FIXUP() users in tree and
>    call it a day, but that'll also be fun to backport.
>
>  drivers/mmc/core/quirks.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..27e0349e176d 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -211,8 +211,9 @@ static inline void mmc_fixup_device(struct mmc_card *card,
>                 if (f->manfid != CID_MANFID_ANY &&
>                     f->manfid != card->cid.manfid)
>                         continue;
> +               /* Only the bottom 8bits are valid in JESD84-B51 */
>                 if (f->oemid != CID_OEMID_ANY &&
> -                   f->oemid != card->cid.oemid)
> +                    (f->oemid & 0xff) != (card->cid.oemid & 0xff))
>                         continue;
>                 if (f->name != CID_NAME_ANY &&
>                     strncmp(f->name, card->cid.prod_name,
> --
> 2.39.2
>
>
