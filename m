Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C927978EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbjIGQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjIGQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:58:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897110CF;
        Thu,  7 Sep 2023 09:58:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4AFC116A2;
        Thu,  7 Sep 2023 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104882;
        bh=TcXlCdBwAdhvSY29Gk4U6YRFj3oqsCMGTaUu7DO7ABc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ER06lwSM/j1xnFBQOrUJerziPgcpI5gDKNTqDixQjhU0k8PiCru4SwlOiLg0ImvO/
         kEl2QkM+/7urjlYrzxPn1a8a1ZCkKhzzM8HypyK/+JghUgI3OsD+X4qRpOf9w0w2ud
         K9Dp7IOFdNfiBgJcfKNJsRDaKud6Z9tI6+OY2bZa7Y0P6V8dNJpLmHShL8JqTYeGoW
         mOODtbz272BFtKswS1WP6lEktZ106QkwAwa+Ag4bzzUqiM0KMPvw/7g9cUlUzd6iyd
         kt9RhoKcdRgV5l2w4Q9WhMRyEXIhDJHAr9j4tVqUCpFDNWVtVVTW6jLSnZrRJfkwKk
         2NJKmzlChFiyA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b974031aeaso21275601fa.0;
        Thu, 07 Sep 2023 09:41:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxbHfliM/B982PbsbV5AnwcW3HBXR2UZ3IYfDzwyr4OKSpHe1H9
        GXArBySVwkE79+ixzrAcXTHzMTBJaDu5bh9EnA==
X-Google-Smtp-Source: AGHT+IG23bFGvQrEWMPrUuiNiXfBfSQ2nV8yCIxtgarBdJYaaWK6UgdiyOScuIdqPU/mpa09cy/VQ6TL5hv239G+U08=
X-Received: by 2002:a2e:3a18:0:b0:2bc:bdbd:1542 with SMTP id
 h24-20020a2e3a18000000b002bcbdbd1542mr5251425lja.11.1694104880149; Thu, 07
 Sep 2023 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Sep 2023 11:41:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFyuHfJ1t1gKfDFp1yGuNB_FhVCnY1Tk9iBzvchHwEOw@mail.gmail.com>
Message-ID: <CAL_JsqJFyuHfJ1t1gKfDFp1yGuNB_FhVCnY1Tk9iBzvchHwEOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] Add reserved-memory
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Bring in this file from Linux v6.5
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - New patch
>
>  .../reserved-memory/reserved-memory.yaml      | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/reserved-memory.yaml

I've applied this one and patch 2.

Rob
