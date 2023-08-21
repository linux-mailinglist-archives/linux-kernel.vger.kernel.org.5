Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9F783088
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjHUSyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHUSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A976B2;
        Mon, 21 Aug 2023 11:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8400964180;
        Mon, 21 Aug 2023 18:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81722C433C7;
        Mon, 21 Aug 2023 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692643957;
        bh=9Yw86enLpID5U94hXBP0Cn3sQwsJbGoXb+O9UlFco2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bMGxPQ8rqPAL5n5G3OsOHhxVHf494arO950h0E03Bkpq/ThOfFIcvfpU40WvxVeKV
         aHkA1HtScEGLObzbbd+6tL3CXSZMGXEvg+JaHyZ03iY1ja2ys0omgqQepmYFZrwvzi
         mLS62DmzD4oDTyvstiobOa4nEjsduQIRNmSECOoneqWKmdGmZYcMYTFlK+5558d9oa
         tUbzRusq5FsHISJIAMZeuhHGQP9V//IzCuACBej/v3vZbxEEz551rZL0t9ufxRFT+d
         YnEEbAaRyNQJ6UO5v2gJol+93ylEwF5svR5zpLSwZf5dV1JL8et34ik50QG/Bu2MiQ
         AlaGlNaOmwT8A==
Date:   Mon, 21 Aug 2023 11:52:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Message-ID: <20230821115234.3aa55965@kernel.org>
In-Reply-To: <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
        <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
        <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
        <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 05:19:22 +0000 Christophe Leroy wrote:
> As I said in the cover letter, this series only fixes critical build=20
> failures that happened when CONFIG_MODULES is set. The purpose was to=20
> allow robots to perform their job up to the end. Other feedback and=20
> comments will be taken into account by Herv=C3=A9 when he is back from ho=
lidays.

I missed this too, FTR this is unacceptable.

Quoting documentation:

  **Do not** post your patches just to run them through the checks.
  You must ensure that your patches are ready by testing them locally
  before posting to the mailing list. The patchwork build bot instance
  gets overloaded very easily and netdev@vger really doesn't need more
  traffic if we can help it.
 =20
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#pa=
tchwork-checks
