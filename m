Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE77B1FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjI1OkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1OkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:40:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455CC180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:40:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1224C433C7;
        Thu, 28 Sep 2023 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912010;
        bh=h8H/O+3tGg84I9dup0h1f947gtwyQA+AfL2cSRNnujU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wa0mTny93UweF9pZUlIFlDUFDzcjYo3FsAsBkIOCjJEoDU9FhRvkugHar5nswMYyb
         4JDy07td7zUbJmTHWyEpN4ScjjiF5G6wbBSYNC+Tqrufj1ZF8Z7h1zSg1qwCjLEgKH
         nZB0xMPlsgGQxey23F+xsgK58Us8nTC/6l7hs87KuabLd8Douy2ynB1AJCg807VpG3
         Zy2veVf1fABy23uBTtbSIcpPPsSLyZUr07NVkMDCJEvoCUg24+AEoJPQL0wSPejYsB
         Bst6eCetr8R+env9V2MHLQuTkfhkVSbWdiCmkEhLSmgXnT4JFSoW0+mFKQJf7nqCOB
         UfT60zd1x/pcg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50437c618b4so18462590e87.2;
        Thu, 28 Sep 2023 07:40:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuM7yMm6smSSNGJJEIrzrQuZ4LID1nLcLmOS2Ddnai2EZRsHLY
        2otnm9tsMgE1IFd7/Ricm/zYwCaLKVjk4gG7VQ==
X-Google-Smtp-Source: AGHT+IHlFRYNH1yT+cBQYKts0sQSWJ7V+SRU+AQ/TMhseplKK1kk/v3dI6NbdzsUpFxr/xM9/FfvMcO6JNQuqwhidDE=
X-Received: by 2002:a05:6512:2807:b0:4fd:fc36:68a2 with SMTP id
 cf7-20020a056512280700b004fdfc3668a2mr1554384lfb.1.1695912009035; Thu, 28 Sep
 2023 07:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061207.1841513-1-apatel@ventanamicro.com> <20230928061207.1841513-3-apatel@ventanamicro.com>
In-Reply-To: <20230928061207.1841513-3-apatel@ventanamicro.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Sep 2023 09:39:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL6LvfQQi4AqJpDPKwC76Xap4Re4o+bzviyb--dUOG7vQ@mail.gmail.com>
Message-ID: <CAL_JsqL6LvfQQi4AqJpDPKwC76Xap4Re4o+bzviyb--dUOG7vQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/15] of: property: Add fw_devlink support for msi-parent
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 1:12=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
