Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281A8034EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjLDN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjLDN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:29:30 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FA101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:28:46 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4649c501c1fso160501137.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701696525; x=1702301325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUNfjBGHa6bsT9LM7dto/JIl0WbVZdu9xvrx+9m15HE=;
        b=a+zCcDQQwVUdOUufuMm1OzhXwviAcNkOmSYF7H5jUYBTyVaaCmvOE7Zp1lW6YzxQgz
         Kd4lHsr9GmkuCBTXgHg4l6kIaLRDvMqHz7/k4MAFA1xiZP2ij0Is2MGRtwwmqnzDYHgL
         JNOo40pQiTScPhUywkryukUBcuNQZdNGJ4Z0EEabI/bT2VBKkwVmvg5H+QMrxlWlZKID
         b3QSQWCqESyFeitwTNkkNQvExWWfbnNt2VKyGD1sNh+isF9JQuy6QN2en5keOqhV+JT+
         4Pd421YoQLfM2HJ3mmu4pJ16pPDOK8KtC9CL2doXSLw2yFKXqf0uCpT1V7RPcVugVM/Z
         uNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696525; x=1702301325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUNfjBGHa6bsT9LM7dto/JIl0WbVZdu9xvrx+9m15HE=;
        b=YmLyQJ0tFqJZAXr2ge+ZMLwcB23kmHJs4n6/FeGNRBnpfTFrpLWr5Y4HunI3E27Btd
         RY/Yu5mhysSgPKg7MaAvTyku6gX5qyJv0iG42ZlI+kJ9CFHRTbjF5MtZZGxq8jlzDOa9
         92eNYgEDm8Wf2dFCH/SV57Y/A7BjYk5m56A+3iEiWO8Cz1PhBcp1cg2YNv9LNQYG6QSn
         iJlxJ5wZ5etkPeGX3KbDJ2ajhw3ImtFpoTxrOIvQkSv+ZEg9gZ666HopECOmBHxIu7ak
         qnnN3ZEsdwwWqBwfA1k2TAqnRpjLOiK5n4DmnGEaw/DDs1s7ifVnwVllDnKWjgpHOcPk
         K39A==
X-Gm-Message-State: AOJu0Ywor3r6u8TGiciPXcr8ZMAtwx/oGXMGdvrlmrQ1GwAjajnZWRIQ
        jL982o66VCS8QkLkJq6VmegmvA/R94VEQJ0dINKfSA==
X-Google-Smtp-Source: AGHT+IGQ7RLvUyB1+/4iLrI24nuY5PSxr7dP56FBocTGJ/0YQxIuukU1qgngImTbNOIX/fj+WjxBzb55x6Tn66gGAi4=
X-Received: by 2002:a05:6102:48e:b0:464:82cd:3947 with SMTP id
 n14-20020a056102048e00b0046482cd3947mr1881605vsa.32.1701696525656; Mon, 04
 Dec 2023 05:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20231109151106.2385155-1-glider@google.com>
In-Reply-To: <20231109151106.2385155-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Dec 2023 14:28:09 +0100
Message-ID: <CAG_fn=U7EV0ohaNFRwQ83cvwVn-Fer1pHXOjPevbP_XpYGDCYA@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] lib/bitmap: add bitmap_{read,write}()
To:     glider@google.com, yury.norov@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 4:11=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> From: Syed Nayyar Waris <syednwaris@gmail.com>
>
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
>
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f403=
38.1592224129.git.syednwaris@gmail.com/
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yury, Andy, do you think anything else is needed for this series?
If not, whom should we ask to take it?
