Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A71770CEA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHEBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHEBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC34EDD;
        Fri,  4 Aug 2023 18:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89D662177;
        Sat,  5 Aug 2023 01:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD3C433C7;
        Sat,  5 Aug 2023 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691197980;
        bh=pGRHLC6BYo2oZ4srt3SQmvI0Koy0Lb9Kb8rWVcSYuJs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sm2EoOLeeHdmMPFke6UzsELDlSZmaLpKMPz4nzYALlfioyOxIcAb6zru6HXYAix5Y
         hsNjsd6ZyAp3Ptg7m8Ewcz9vDsnJ2rwTMpFC5Jx1yNQDWNqCMbg4WFebge/XHHSqMA
         rJWs8+zSandbJA1UoFIvTx+oPCT6CSklIqMbrQZ3ZLQP7UCH5C8hELkA1SifKB2f/o
         oDnyU2bx27YqpkGbzSmCz9ru8WsgDCKDDhDFu5DrXM6f/PLrASbrXkDkBw0pfKbsE8
         63PPDPPkJJD7eQaDYEbvssLtmOXegcnfMpeRFHUg/hPa84n388//lZ2KZEpUoWow9X
         /M2voSNWVtYKw==
Message-ID: <dd80b41a26c62ba42efc51d9ab800bfb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230728222639.110409-1-francesco@dolcini.it>
References: <20230728222639.110409-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] clk: keystone: syscon-clk: Fix audio refclk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Francesco Dolcini <francesco@dolcini.it>,
        Jai Luthra <j-luthra@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Date:   Fri, 04 Aug 2023 18:12:57 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Francesco Dolcini (2023-07-28 15:26:39)
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Audio REFCLK's are not working correctly, trying to use them lead to the
> following errors:
>=20
> [    6.575277] of_clk_hw_onecell_get: invalid index 4294934528
> [    6.581515] wm8904 1-001a: Failed to get MCLK
> [    6.586290] wm8904: probe of 1-001a failed with error -2
>=20
> The issue is that Audio REFCLK has #clock-cells =3D 0 [1], while the driv=
er
> is registering those clocks assuming they have one cells. Fix this by
> registering the clock with of_clk_hw_simple_get() when there is only one
> instance, e.g. "audio_refclk".
>=20
> [1] Documentation/devicetree/bindings/clock/ti,am62-audio-refclk.yaml
>=20
> Fixes: 6acab96ee337 ("clk: keystone: syscon-clk: Add support for audio re=
fclk")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Applied to clk-fixes
