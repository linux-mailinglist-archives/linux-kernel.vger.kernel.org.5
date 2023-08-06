Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D377771493
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHFLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHFLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:42:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84FE50;
        Sun,  6 Aug 2023 04:42:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5232bb5e47bso1148006a12.2;
        Sun, 06 Aug 2023 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691322150; x=1691926950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HumppwNUn3TA8YpQ0fQzm7WpQytFg98rX1E8vNluGYU=;
        b=COX4FRzPg5Df7S7scGkL1a1jxSkgE4lsLMpzoAKRInM2N2donpYwiXDjSi/uGQQJdm
         wnKu5zkOi4+z2eDvgysSiv8+wnzUSluY4wQ5tf23SqJnRh34l9MsjY0f81HXTwdimI/K
         GW8UQJRJil0ochVBGECpvNlVOUpC2TpR46BNRdtqybtoE/quddDakVx+BSAAn7/1Sdlz
         XZkfNvlLlGjfuEjcvAlf6iTnTjcI9tIHvIk9iB2wzLyKG0GKDLCon/LnZE/cu205nyvc
         ZpUbvtf3cSHF9m1L8NZHvlpkWXujyLx4Z8+cLnkrtFr4Tat+wekNAvvveNMSRtuJZOmO
         bM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691322150; x=1691926950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HumppwNUn3TA8YpQ0fQzm7WpQytFg98rX1E8vNluGYU=;
        b=ER4NSspLt7vKD+ld0Sjxtbdvp8KRIQ3s53joN+bw8EhxGVMvYNBCFV87QuDN14qGOu
         z1S6yWVxH1SYYLT4Jnv2pw3UNbLvmTdIHs0wyaJcwx0e48stW/CExIUjm/LKAi6r3qUX
         tWa4F7BrTAT7iC0XAlbsoroUBr+wgDXW4vInK2qrFuwRrLtouCrgEspl/TXELCfuWxt9
         vjcVdEyDABJRq7k7///mmMUC18BDMJ+MgKRpYCsythHmDUXGf3tOlJIu/MVMD6VAI3Vv
         vTCJvy4kNaiSrXdtyLcfW/CLD4MNDpb4piADbPnondLb0iX88SBNjPJprZ+vjotJJTIg
         O6fA==
X-Gm-Message-State: AOJu0YzQVfCqg6mx2Fp1tKpbyc5ts3qxlBPMdcKeBJ36bBIeWUkglVBZ
        q6LhhLbq3Te6JbbWkK5xOSU=
X-Google-Smtp-Source: AGHT+IEEg3PkfDxHcETaO7LHnXNw+qJwjWb90KaZ3707q9E0qH0cZ2HLszMui/vhh35dCWWOEYUkRQ==
X-Received: by 2002:a50:fc12:0:b0:522:c0ea:15d with SMTP id i18-20020a50fc12000000b00522c0ea015dmr4929062edr.41.1691322150093;
        Sun, 06 Aug 2023 04:42:30 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402516200b0052275deb475sm3787539ede.23.2023.08.06.04.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 04:42:29 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     John Watts <contact@jookia.org>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Sun, 06 Aug 2023 13:42:28 +0200
Message-ID: <4848155.31r3eYUQgx@jernej-laptop>
In-Reply-To: <ZM8-yfRVscYjxp2p@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <2690764.mvXUDI8C0e@jernej-laptop> <ZM8-yfRVscYjxp2p@titan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 06. avgust 2023 ob 08:33:45 CEST je John Watts napisal(a):
> On Sat, Aug 05, 2023 at 07:49:51PM +0200, Jernej =C5=A0krabec wrote:
> > Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> > > On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > > > Hi John, Jernej
> > > > Should we also keep a pinctrl nodes itself in alphabetical order?
> > > > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > > > Looks like the other nodes sorted in this way...
> > >=20
> > > Good catch. Now that you mention it, the device tree nodes are sorted
> > > by memory order too! These should be after i2c3.
> > >=20
> > > It looks like I might need to do a patch to re-order those too.
> >=20
> > It would be better if DT patches are dropped from netdev tree and then
> > post
> > new versions.
> >=20
> > Best regards,
> > Jernej
>=20
> Agreed. Is there a way to request that? Or will the maintainer just read
> this?

Hopefully it will.

Best regards,
Jernej




