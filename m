Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F091B758503
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGRSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C4F0;
        Tue, 18 Jul 2023 11:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1078616B0;
        Tue, 18 Jul 2023 18:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4155EC433C8;
        Tue, 18 Jul 2023 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706012;
        bh=E0xg5i3PsLwOZ+xVGItr6XQ7+8A2YuzDBfiyQIwFzqA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MU318Xy59qZ603MLkd+k/kl6Yoxs5wgtXp8/WgKKqy/TrNUu2PhK+dzMqSpIcauzc
         IxZ1oanjeNzrmB0rRZZge9DsldEn3DltuGHFUJ9tyUBAcCsPGfZ2Rf+/dNU1tXUUhE
         PZczng3wybrlynsh+zlM5rm6MlyQ09QkLAyEDH5tj45WCDoIWmN1dglHcZ5VCWob5C
         qY7nrHl/oINGa3rMkUYiSfGWH5zaQ8oKM3JWYZJeFEJP5IfQANYPvgx7PH+u3JZfBA
         60gC0M5krkVXx8wbhKFi/A4CDRoe+2OSl6Ho5A+ymc/r5tOD/+ngV4gywpEE5xXLnJ
         tb0bJCobZ9uWg==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
Subject: Re: (subset) [PATCH 00/10] spi: rzv2m-csi: Code refactoring
Message-Id: <168970600997.94192.11376983705102685200.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 19:46:49 +0100
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

On Sat, 15 Jul 2023 02:03:57 +0100, Fabrizio Castro wrote:
> this series is to follow up on Geert and Andy feedback:
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230622113341.657842-4-fabrizio.castro.jz@renesas.com/
> 
> Thanks,
> Fab
> 
> Fabrizio Castro (10):
>   spi: rzv2m-csi: Add missing include
>   spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
>   spi: rzv2m-csi: Rework CSI_CKS_MAX definition
>   spi: rzv2m-csi: Leave readl_poll_timeout calls for last
>   spi: rzv2m-csi: Replace unnecessary ternary operators
>   spi: rzv2m-csi: Squash timing settings into one statement
>   spi: rzv2m-csi: Switch to using {read,write}s{b,w}
>   spi: rzv2m-csi: Improve data types and alignment
>   spi: rzv2m-csi: Get rid of the x_trg{_words} tables
>   spi: rzv2m-csi: Make use of device_set_node
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/10] spi: rzv2m-csi: Add missing include
        commit: f572ba797c639c9b1705908d3f5d71ed7c3f53e0
[02/10] spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
        commit: 74e27ce8d23c3aeb1a9fdcaf6261462506bbbfc3
[03/10] spi: rzv2m-csi: Rework CSI_CKS_MAX definition
        commit: aecf9fbdb7a4dc6d83e8d9984c8d9dc074d8ea2e
[04/10] spi: rzv2m-csi: Leave readl_poll_timeout calls for last
        commit: 2ed2699f58891c72fcd462129345d09424f986c5
[05/10] spi: rzv2m-csi: Replace unnecessary ternary operators
        commit: 9f5ac599801c0f7c0969fa94c638265ed988b9bc

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

