Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3107D05AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJTAGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346711AbjJTAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:06:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F94B114;
        Thu, 19 Oct 2023 17:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A55C433C7;
        Fri, 20 Oct 2023 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697760360;
        bh=O9MAEXEEnD8PbgYOZLMCqbHxoOdKvoMUqekx/eQ6PMI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pJwZeiQP69B+aICkseQkPHLtJPGyN5w/39KHR0BR27H2ziCIQUqpjn79bzLmU1SYN
         bqW6A9FRXDxcq+DWB7nhe89zQWF+bypTT8DYgav8dMfI5FDzbqicJoNEjP1TsQqtHM
         7hhXvIFVY6t5pnkBTbb9Rd0PdthTZO5ORJV0lrxMXk4HOuiF0zPLKsAELBQ/jF19ux
         8pbZGaXlrXE/iQqqCJID4rm6qUKQWN0sa5T6rBntLuJzIsJMXE8LvvB8ECM67YOQex
         kreSlww85XPYiugjq4gXim/H/X5nVAHBYMpk6Bg7wQ6Btc8atl7QiVAMcxPh6DRxeN
         N2HFzrOmAw72g==
Message-ID: <ac00b49505e926ac4f3d0d0ba315b366.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b8fa17a7-296e-4e17-9438-a8be04dbd476@quicinc.com>
References: <20231017131944.8356-1-quic_kriskura@quicinc.com> <e38ae24c09ef321c224a6b6aeb97e73b.sboyd@kernel.org> <b8fa17a7-296e-4e17-9438-a8be04dbd476@quicinc.com>
Subject: Re: [RFC 4/8] clk: qcom: gcc-sm8450: Keep usb30 prim gdsc on during runtime suspend
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, Udipto Goswami <quic_ugoswami@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 19 Oct 2023 17:05:54 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Kurapati PSSNV (2023-10-19 01:37:20)
>=20
>=20
> On 10/19/2023 6:28 AM, Stephen Boyd wrote:
> > Quoting Krishna Kurapati (2023-10-17 06:19:44)
> >> When runtime suspend happens in host mode, if cable is removed at this
> >> instant, it triggers a resume where a xhci register access is done when
> >> gdsc is not on leading to a crash. Keep usb30 prim gdsc as on during
> >> runtime suspend to avoid this crash.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >> Note: I am not sure if this is the right way or setting GDSC flags to
> >> PWRSTS_RET_ON is the right approach. So for now made this change to
> >=20
> > Does using PWRSTS_RET_ON work? Does the GDSC support being turned off or
> > is the lowest power state retention?
>=20
> I didn't see any issue when I put it as PWRSTS_RET_ON. If the GDSC is=20
> off, when we remove cable in host mode, we see a crash because of xhci=20
> register access. But when I try putting PWRSTS_RET_ON /=20
> CLK_RPM_ALWAYS_ON it doesn't crash.
>=20

You need to find out if the GDSC only supports retention mode. Otherwise
it sounds like the xhci register access is happening when the genpd is
off, and thus the driver needs to power on the device before accessing
it.
