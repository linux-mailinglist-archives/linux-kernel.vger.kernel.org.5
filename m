Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCCB79E988
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbjIMNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjIMNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:43:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804281BC9;
        Wed, 13 Sep 2023 06:42:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC45C433C7;
        Wed, 13 Sep 2023 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694612579;
        bh=lFraKzdNfExngIGaIv/1K58suMvu++hc1nKgmQ0iXQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRikp+ctqfYM5nwvev0vmw1nveMqm+sw2yKSNsonXUlMahLHJF7ucVKX98G+txgkF
         K62GisiU5xPDXcLI3UFlKnlWPITWbX1U/JVDNda7o/youuEm8H+9bloP+KKgtxSg/A
         X6UYHNWPxzK5lCS3s8ZN1efrBbAiDUcTjWzSPaTtZy6/lsM9wgn+TokLNJE/16/sue
         QTLIQIe3fIlUkdLIQejJcLZuTcN39IAZ3m9h9hyaZwa9nCu/Uk+f7NaedFkpvWLQ1D
         +gErPJokNMYPNKZMwbzOSJ0NwRqlNVtx1i7N4S3pSGnaIg0MbvE9FxtfjydPgsARo9
         hISqQFw6Yyd8g==
From:   Conor Dooley <conor@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add PWM-DAC audio support for StarFive JH7110 RISC-V SoC
Date:   Wed, 13 Sep 2023 14:42:50 +0100
Message-Id: <20230913-capital-skiing-1b504653358c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230814080618.10036-1-hal.feng@starfivetech.com>
References: <20230814080618.10036-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Dk53k5rmUx7nlZbwvEoZddi3urCZf9sprXbm0Xahd8U=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmMeyK38Vg8XDP9ycTFbhttxeYbi8ZVxB3kv6naNlV07 Y54m2jdjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyE6zIjw8EjHkdOMK3dId06 X519wpIDtUduBKd0XVTdxXxueUkrQyAjw9Ukc8aOR8/Ej4QYbfjN/GntYbGKDS+/zVA52tc/WSY 3kw8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 14 Aug 2023 16:06:15 +0800, Hal Feng wrote:
> This patchset adds PWM-DAC audio support for the StarFive JH7110 SoC.
> The PWM-DAC module does not require a hardware codec, but a dummy codec is
> needed for the driver. The dummy spdif codec driver, which is already
> upstream, is compatible with the one which JH7110 PWM-DAC needed. So we
> use it as the dummy codec driver for the JH7110 PWM-DAC module.
> 
> The third patch depends on tag next-20230809 in linux-next branch.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[3/3] riscv: dts: starfive: Add JH7110 PWM-DAC support
      https://git.kernel.org/conor/c/be326bee0937

Thanks,
Conor.
