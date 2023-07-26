Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E94763C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjGZQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGZQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A172D5E;
        Wed, 26 Jul 2023 09:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6CC61BA9;
        Wed, 26 Jul 2023 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16230C433CC;
        Wed, 26 Jul 2023 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690388130;
        bh=vVdBJUeDX9yPLWxR1KmOI9UTmYJhTaX/UmEjgL9xjjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acQ3pSymbk7OUBE2WwltvCn247oyA3bbQB8P8oc0nlm5IEP7FPAMgds6LG4GKAyLU
         QO2hZNjCyKnU2oxkphxqmXREUbxE8+yFjWXB1my+x5UURG7J+n+f6od9OUzTa0pa5K
         K1vpLAJqubfkqzwMotou1CUSueTFntjUmNI5ESQyWfXogwjbX3Oh4ZPlqHcYsClPm3
         HXPPHcYwSjiDLDG13fbH/RIPaiAKUSmhoS0B+WjKQareNBwT2TeCv1LEz2uF4J6NQu
         Sa4yKAfcCxjjhcbUBvgaekaAhMVNKNzgJpHaYw7v5LIC2mfL/0bu0tr+H4M57qUyg6
         G0RWudtRw9kpw==
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: (subset) [PATCH v3 0/2] Add SPI module for StarFive JH7110 SoC
Date:   Wed, 26 Jul 2023 17:15:20 +0100
Message-Id: <20230726-sixth-uphill-66fbc1b5e5ce@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724101054.25268-1-william.qiu@starfivetech.com>
References: <20230724101054.25268-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=KWl97tOyRAl6hm4I/TsKzqcKez1byYACmfzfwtLiPf4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkH3aatPiJvwipi+6yq40mLD1OSTaz4Gr4XmwNMNwRWP 2nPK+/pKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwERiFBn+qdz5VeR4fqWe96bV Jsv0z348v2HPWQavk3KeIRcKKj9W7WJk2BrElLFl8tZHhw4/a219xvF/lr6sy703px9tWDJ74ix lPi4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 24 Jul 2023 18:10:52 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> SPI controller. And this driver will be used in StarFive's
> VisionFive 2 board. The first patch constrain minItems of clocks
> for JH7110 SPI and Patch 2 adds support for StarFive JH7110 SPI.
> 
> Changes v2->v3:
> - Rebaed to v6.5rc3.
> - Registered one more clock.
> - Dropped commit that changed the number of clocks in YAML.
> - Rewrited the commit comment.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[2/2] riscv: dts: starfive: Add spi node and pins configuration
      https://git.kernel.org/conor/c/74fb20c8f05d

Thanks,
Conor.
