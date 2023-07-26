Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1542763B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjGZPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjGZPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0E193;
        Wed, 26 Jul 2023 08:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9110961B96;
        Wed, 26 Jul 2023 15:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA7AC433C7;
        Wed, 26 Jul 2023 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690386654;
        bh=qTUx1ibkNZiv2Ulvi2UjI9je+Gr+m7TlTSI0DAZX4MM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RQR7tIRDjvAkVF7nwmsvm+XRvECbXqIyhem6BswxnB5RnNw2M369NR83PIWcg4n0i
         7b0RZKPr2GvGuR6uE4koLC+tOeaOyuikWjIB7eG40tMtMTpglL/VW6wMq5wlEn4Jep
         X9GTyhBJK4B2P5m5dc6yDV/z+yZ1RrQ5/JK5qdcsqu11Eh6gHBG307Mlv/35Mku4hb
         6txkqSh/1L8CkTwU9rHQzUXjyULY+qGd9PtogVdVZVNpQuqZaH/sHX2d5RqJ2bLQ/0
         +iqkakXsRXhbDH70G4/avVkkPs/X9MEhbJbAc7EGxm0EqxXezV1uhey/z/rzqVeGpv
         Z75dmtAjeVpRA==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
Subject: Re: [PATCH 1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that
 aren't multiples of 4 bytes
Message-Id: <169038665208.73112.11925690374692993446.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 16:50:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 11:02:26 -0700, Douglas Anderson wrote:
> The Qualcomm QSPI driver appears to require that any reads using DMA
> are a mutliple of 4 bytes. If this isn't true then the controller will
> clobber any extra bytes in memory following the last word. Let's
> detect this and falback to PIO.
> 
> This fixes problems reported by slub_debug=FZPUA, which would complain
> about "kmalloc Redzone overwritten". One such instance said:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't multiples of 4 bytes
      commit: 138d73b627c71bf2b2f61502dc6c1137b9656434
[2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads
      commit: cc71c42b3dc1085d3e72dfa5603e827b9eb59da1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

