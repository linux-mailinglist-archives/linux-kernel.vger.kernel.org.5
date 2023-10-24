Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6830B7D45C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjJXC7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjJXC7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28885120;
        Mon, 23 Oct 2023 19:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B237FC433C7;
        Tue, 24 Oct 2023 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698116344;
        bh=q+zOUHNZpyyfySvjLWIAqk44DXAPWzP6dh5SDkzRPYI=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=odmdHcyty6crbW0U+CjvVuCb+kmm2FHxS0OwOe2smlYNgqAsM2wH893MGTDvNZ6wJ
         nmt5SD6reBpgTJQ4lwloOChOZwURJ08xI2kVbLklHKq9HrujOORvRRNRnAF//Svu/P
         Mgq6bCl+jhHEOcsRaSA+fVqmfRzjJ2t2KZVjRGoHejyPVLvdH4z2VS2dhAj4xA5Zjd
         2wa2OZCInGrR8Rc843syr1g/qwihWUQvR7nVdELEFOFqgArvKFaeGpU9YObOXQUCZv
         SbNPGQjOc1FaDis2b86Lo5grKlhwKiLn6R0dQ+eU96ulvuIFGrLfG4KmXarqpOhQKi
         kpBL2SNyNgouQ==
Message-ID: <07937184481af74c65108bae26526605.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0eebfc14-dbcd-4987-9e94-ea5630b6c268@linaro.org>
References: <20231002170021.192740-1-trabarni@gmail.com> <0eebfc14-dbcd-4987-9e94-ea5630b6c268@linaro.org>
Subject: Re: [PATCH] clk: qcom: gcc-msm8953: fix stuck gcc_usb30_master_clk
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        =?utf-8?b?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Oct 2023 19:59:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-10-06 16:50:18)
> On 2.10.2023 19:00, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote:
> > According to downstream dwc3-msm source this clock has FSM dependency on
> > gcc_pcnoc_usb30_clk so enabling it would fail if latter isn't enabled.
> > This patch add works around this issue by changing parent of
> > gcc_usb30_master_clk to gcc_pcnoc_usb30_clk. This is acceptable because
> > both clocks have same parent and are branches/gates.
> >=20
> > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > ---
> "meh"
>=20
> There are multiple cases, especially with qcom, where there are some
> magic "dependencies" without parent-child relationship. The common
> clock framework doesn't currently have any good way to handle this,
> other than some mind gymnastics like you had to do here with matching
> them against a common parent/ancestor..
>=20
> Stephen, what do you say?
>=20

You can't change the parent to be not the actual parent. The consumer of
the branch probably wants to call clk_set_rate() on the branch and have
it propagate up to the parent to set the actual rate. Can the axi clk
simply be left enabled all the time? That seems simpler. Otherwise we
probably need to leave the axi clk control to the interconnect driver
and make sure drivers enable interconnects before enabling this branch.

When things start to get this tangled I tend to think that we need to
remove control of the clk from the general drivers and put the logic to
control interconnects and clks into some SoC glue driver and expose a
single interface, like genpd power_on/power_off so that general drivers
can't get the sequence of steps wrong. Instead all they can do is "power
on" their device, and the SoC glue driver can do the proper sequence of
framework calls to power up the device.
