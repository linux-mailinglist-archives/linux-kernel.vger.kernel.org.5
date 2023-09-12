Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A079C796
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjILHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjILHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:04:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4CE7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:04:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8020510203so3546598276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502258; x=1695107058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B30cQR4KsHwNvaeoC8Z4dw3bG2+oBb1t/+4IAjCtWX0=;
        b=tWLPj6LHrmRPWGbuAJ2yvYheVGZwEV+xDbPL8K6pIS7cU+Q6/E+jpXWslVMNvp03SJ
         SHCG8lxpWUAqy0l0BahLrABBWqmzguvSj5v5rkG35soQVYT72+OKuqlOyVFutpWit/c9
         yOAVquJXeJnc41av9wdG3ZdiVsWAYaVseXqQ54bVDQFC4f7FwcFXn4yqNFm14b4/Cc7+
         preWmxufPRZDjxl02HsTdBkE/MdYJgVKyyUsS9pztJXU83mwKwHw09Oq3NtAUeveKAxF
         4Ci548eVA2qAmAtmRJYenNpt2Ki6eU2mgbFolbaA6K7GBnKLCxKklaEJVxr5Y1z1/8nc
         Uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502258; x=1695107058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B30cQR4KsHwNvaeoC8Z4dw3bG2+oBb1t/+4IAjCtWX0=;
        b=hqkPC7QOwa1GH09SNy+CP2VkUPmtlGDcWY0OcZvh3Vv75PHneZdlJc4E8wIFGzneE9
         bq3MDWtru7mnIfmQ1DGY/MD5vftGc1pwSbtO+agcnGPzjTCrGl/tlh51L5Ou0TbEI3JV
         +7lI13Ot9Pm+pBERAKDM+B2XpNfqPWDJFkIflwmd8nEPN3ZmUq8g+Sx0+BBZsXQjWk1y
         /PxM3XH4rWldDGLcvHBThJCTFv1Mip0yYpY6PzaCauCu+Sb/GGmgnXBpweVJ8c3UIy/0
         mcrCEBqtaOOi/2xoxkGlG+Bhxn401P/Vma7n/iYcjdS88uQ8g+aF9iFULBgxwW0u0dx7
         kDmQ==
X-Gm-Message-State: AOJu0YzDloLA/zCyHMeurdrbnaBwLnmXAvZD5R6+Q0o0KduJFeURWrRT
        AuCCFbkAYV8SZEZ3znY7pqQR8hmDmztBVqbA5b2fZw==
X-Google-Smtp-Source: AGHT+IFLqvljpBXBZdopK8IJF7HPCb8UCSZpJ0LEj1zJHnH5CNf+EnxKPRD6io9/GpD2fEWeRkg9qgH7Kgxlf3yqiSM=
X-Received: by 2002:a25:7343:0:b0:d3f:208:b8ea with SMTP id
 o64-20020a257343000000b00d3f0208b8eamr10648403ybc.11.1694502258238; Tue, 12
 Sep 2023 00:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825101532.6624-1-m.kobuk@ispras.ru>
In-Reply-To: <20230825101532.6624-1-m.kobuk@ispras.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:04:07 +0200
Message-ID: <CACRpkdayD_47kvwDgS+7N01qsUT+DoNqz+jODb5g2uT74Byycw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: wpcm450: fix out of bounds write
To:     Mikhail Kobuk <m.kobuk@ispras.ru>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:15=E2=80=AFPM Mikhail Kobuk <m.kobuk@ispras.ru> =
wrote:

> Write into 'pctrl->gpio_bank' happens before the check for GPIO index
> validity, so out of bounds write may happen.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch applied for fixes.

Yours,
Linus Walleij
