Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D77944FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbjIFVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:14:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B5199F;
        Wed,  6 Sep 2023 14:14:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C4FC433C7;
        Wed,  6 Sep 2023 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694034859;
        bh=JHbSwZaxRY4y8epF7seEt6LLA3NLlN1pmTG3mw/GDuQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sr4Rx2bri7DkIK0+zTnKGsZA1leJXBPlNXJG48HQlNl8+/BoJVw6xZjnMD1g0dsno
         AXDKi0bf4zvsNLkXBcR+XJ4OhWvnUrevXqoyabun7c/mvRFiT7vGmDcM4XVw0ovq9/
         OAVtFeHkel2YyMAldt7A1SVXYAUU1ME8f70vAvZN2TuWi7zwt5MkJHqY9kz88Eg6Ng
         zxvMZeyTXCitnhkA8Ihw5y3qgAYAvhTT+7PDFXOQzyD5N9i3y7mqzt6grXfQ4bGu+O
         cxIvIxS8b6T1DH4Zuz+vWZfVy8POScSLF+25b6po0VZBmbPVNeMkqnM6feKDBr47Bv
         xW22x3zOfzWDQ==
Message-ID: <69e1945bebd93916e4408fd8a141fdc5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f139041f-452a-46d9-b5af-a5ddef29c705@linaro.org>
References: <20230901070041.13463-1-quic_devipriy@quicinc.com> <3fe1655e30d62493a24e1f97ab7bf710.sboyd@kernel.org> <f139041f-452a-46d9-b5af-a5ddef29c705@linaro.org>
Subject: Re: [PATCH V2] clk: qcom: clk-alpha-pll: Use determine_rate instead of round_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_saahtoma@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 06 Sep 2023 14:14:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-09-06 00:33:38)
> On 5.09.2023 22:40, Stephen Boyd wrote:
> > Quoting Devi Priya (2023-09-01 00:00:41)
> >> The round_rate() API returns a long value as the errors are reported u=
sing
> >> negative error codes. This leads to long overflow when the clock rate
> >> exceeds 2GHz.As the clock controller treats the clock rate above signed
> >> long max as an error, use determine_rate in place of round_rate as the
> >> determine_rate API does not possess such limitations.
> >=20
> > Does this fix something, or is it preparing for PLLs that run faster
> > than 2GHz?
> I did some grepping and we already have multiple of these.
>=20
> E.g. SM8250 CAMCC PLL2 (zonda) goes (or well, should go) up to 3.6 GHz.
>=20
> Today, only stromer PLL uses determine rate, but perhaps all of them
> should.
>=20
> I would not at all be surprised if many otherwise inexplicable bugs
> went away with that change.

Are any of those arm32 systems? It would only matter on arm32 systems
because sizeof(long) is limited to 32-bits and we don't have negative
frequencies.
