Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC7777C50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjHJPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHJPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4326B7;
        Thu, 10 Aug 2023 08:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 349DA65EF0;
        Thu, 10 Aug 2023 15:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06AC433C8;
        Thu, 10 Aug 2023 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681852;
        bh=L0JsfUS8p25f+d3PZHsFgozKJuVZBca+0cwe9Igyejg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA4t/dbhdtsbR6tiYTlI71TTFx7W8xv6Q0CUs8rU0/+v+I1azT3SQneIY8X3s5nJ1
         dMlqsF4RdDvx2NPGykU7egEiFdF5lhIIHCpiUbL260pbLhxqsHzOc67Ytj8JbGKVL0
         Dp606sCLyjkVnJMEDeykJXEINtIneHJcCtBNQ3/ILnPnNfEIMWCcTfjPvIeSd25NPw
         Zh7Aj1dHT2M0tDXWYqnax3wdh0DPJYNFEW3crdqQdd2FvYNs82iaQaOhkq2uGygskm
         RgDygbU8jDkDoFKUGSv71WfjV16mAT2degv+HCzvRcwh64v1LbAd+/5J9ktdC6IHl8
         O596pSd4L/OFw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Samin Guo <samin.guo@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [-next v1 0/1] Fix StarFive JH7110 gmac TCP RX speed issue
Date:   Thu, 10 Aug 2023 16:37:13 +0100
Message-Id: <20230810-cresting-talon-51a6c31da4f8@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810074646.19076-1-samin.guo@starfivetech.com>
References: <20230810074646.19076-1-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0Tr68Xd8hSRu8rUov59X+oljjBng5+GIs9HgXSz7jKs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClXWdQNNupuq1t+dKJetmZ0PX/MGqcnYVu+Pw0/Jtx+R pc5JOJwRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbyoJzhr6i3XkV+T9+uLnm3 ksh1KWoiWZan3+Xvdp08a8Fbhe6XRxkZDnr42Mjpldm1GRrV5tRt2O1aKBbx7knz18hzwezcDw2 ZAQ==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 10 Aug 2023 15:46:45 +0800, Samin Guo wrote:
> This patch fixes the StarFive JH7110 gmac TCP RX slow issue. And it has been
> tested on VisionFive 2.
> 
> Here is the result of the test (iperf3):
> 
>   Before:
>       # iperf3 -s
>       -----------------------------------------------------------
>       Server listening on 5201 (test #1)
>       -----------------------------------------------------------
>       Accepted connection from 192.168.1.4, port 47604
>       [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47612
>       [ ID] Interval           Transfer     Bitrate
>       [  5]   0.00-1.00   sec  36.3 MBytes   305 Mbits/sec
>       [  5]   1.00-2.00   sec  35.6 MBytes   299 Mbits/sec
>       [  5]   2.00-3.00   sec  36.5 MBytes   306 Mbits/sec
>       [  5]   3.00-4.00   sec  36.5 MBytes   306 Mbits/sec
>       [  5]   4.00-5.00   sec  35.7 MBytes   300 Mbits/sec
>       [  5]   5.00-6.00   sec  35.4 MBytes   297 Mbits/sec
>       [  5]   6.00-7.00   sec  37.1 MBytes   311 Mbits/sec
>       [  5]   7.00-8.00   sec  35.6 MBytes   298 Mbits/sec
>       [  5]   8.00-9.00   sec  36.4 MBytes   305 Mbits/sec
>       [  5]   9.00-10.00  sec  36.3 MBytes   304 Mbits/sec
>       - - - - - - - - - - - - - - - - - - - - - - - - -
>       [ ID] Interval           Transfer     Bitrate
>       [  5]   0.00-10.00  sec   361 MBytes   303 Mbits/sec        receiver
> 
> [...]

Applied to riscv-dt-for-next with the conversion to decimal, thanks!

[1/1] riscv: dts: starfive: jh7110: Fix GMAC configuration
      https://git.kernel.org/conor/c/1273f7e96a70

Thanks,
Conor.
