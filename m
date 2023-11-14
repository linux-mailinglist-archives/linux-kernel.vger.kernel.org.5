Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F827EB112
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKNNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:44:24 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C451A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:44:21 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5bf812041a6so61684647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699969461; x=1700574261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ4f8JZYYq7GZ1QgPyk5lUL7VvIanUd5vXpIis2TnC8=;
        b=dCjSILGnU+V/T1OjhO/CcM5YSJqb7WRH7oPA9v/HFPh9+TcfheqWDVDHebvx+n4jzL
         BZKxN6Sze4rdEqUSN81C/d8CPLy5gYINJ6yaLs/nNdM28H0kRnTdWVaKgIZoYjNYgEcz
         5Oi94cv6kvoUkPfxM0j2HwdqvyHDn8CzZ6IpLbsfj7+FPCFMdXiZuERBifQCflSeENM6
         07ej1OzZ9uM1A8lx6c0FUXcqX51exmecBQAwry3spzT9RC2zwUr1N/PzphSS67ZCh5Uh
         qZ9nqnAGl1mU5ay4Z78lFv6d/F7GgB+y1iZdCRf7e/cyUuZ4EtZlFY/tWJdWQ1Z1H6Hy
         8ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969461; x=1700574261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ4f8JZYYq7GZ1QgPyk5lUL7VvIanUd5vXpIis2TnC8=;
        b=eZvaXUe35w6QrXTTWIi560zdC2i0HvnHIVEUI6L5X+uAqxMMDPLd2klvCIcuRWqYYW
         fNbV8DzuyDU8qoZIgi3qDDCMTHKwy4OIZNp8yHQYuUqgyKtrDpnwnMJkQH8jBIGupeSk
         FvFTsEexYY0Rl3cmCyJaDsz/DZDpXGerzKiyBll+vvJol1qzigvRZfGWvKZidAsV92sp
         rPG7s6dbYSKXuE+t0sqmf/ACiZG4zB1rM2ed90Cv9gUqftJHKA5ennxIP3Qa7aTg72De
         Ibuwn+TcXf2Rh1MrhJWCZhJv9Gu4whG6yaqkP+bF7jcr4HDnG8Bi41AS+zfinKCZ7dds
         4aVw==
X-Gm-Message-State: AOJu0Yxp0bNh/HzWOPfqWfCKnDlATtuKLgI2+vfCaD12XFCJn7p+yL4J
        28VSXz/qsJ1EXR8U6QeY1ckftHFGLHyrwggkX8rFyC7nVk0hEnpo
X-Google-Smtp-Source: AGHT+IGAINCOpkGsPc3uvs2ZEpWeFpMvfdVCBFYuVnESqW6reSzaT/65UX8qv1O7fFgmj6CDl0KATtYMkOA28AXL00I=
X-Received: by 2002:a81:7142:0:b0:583:a3ab:b950 with SMTP id
 m63-20020a817142000000b00583a3abb950mr8261177ywc.50.1699969461031; Tue, 14
 Nov 2023 05:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20231107141044.24058-1-clin@suse.com>
In-Reply-To: <20231107141044.24058-1-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:44:09 +0100
Message-ID: <CACRpkdaPNxRyJDtbEu4DB8SikMtBmr8cOJxOuKPUi6GwcoQtCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: s32cc: Avoid possible string truncation
To:     Chester Lin <clin@suse.com>
Cc:     NXP S32 Linux Team <s32@nxp.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 3:10=E2=80=AFPM Chester Lin <clin@suse.com> wrote:

> With "W=3D1" and "-Wformat-truncation" build options, the kernel test rob=
ot
> found a possible string truncation warning in pinctrl-s32cc.c, which uses
> an 8-byte char array to hold a memory region name "map%u". Since the
> maximum number of digits that a u32 value can present is 10, and the "map=
"
> string occupies 3 bytes with a termination '\0', which means the rest 4
> bytes cannot fully present the integer "X" that exceeds 4 digits.
>
> Here we check if the number >=3D 10000, which is the lowest value that
> contains more than 4 digits.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311030159.iyUGjNGF-lkp@i=
ntel.com/
> Signed-off-by: Chester Lin <clin@suse.com>

Thanks for fixing this!
Patch applied for fixes.

Yours,
Linus Walleij
