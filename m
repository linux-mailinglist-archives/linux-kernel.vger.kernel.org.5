Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E97CECAA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJSAQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:16:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD063FE;
        Wed, 18 Oct 2023 17:16:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73910C433C7;
        Thu, 19 Oct 2023 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697674600;
        bh=6uPwkZ4yiG6o3MMwW++45pNUHDSPtK16RZV1nf9Kw6w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f8izOVvgCNr3OCTnTZBVaFgBngHWPPx/mayolA5yr1fNK+U0NeZnCH63olaVpZGGC
         NfJ9vsf3uh9bJK3bafY3C7e/J/GQcot0sgkqx7Rmc8TdKzGpBSem4ZEXcCKofmgz4I
         X44gX+Z3yI1l5CGVHHmVwtRAPoZZ2Ottgaf6P82ir6k0eCzDpe2JUcXQXakXz2hTSm
         GpvDSGHF5cl9AiuFxtArZGfoeINVdu3sYMBYiIvPyhiJmvZOkb2E5BXlTjiQrzFkH8
         b9ZnHMLKHf4QeBiAWXy1HqKZ9I7NuNaWr5ZoCxh7oHkLsRvFlEsRZ1Wzfy7qILT2xm
         CjQi+eAGTOKqg==
Message-ID: <c3dfeecf5cde513cf675b2f1a382f7a4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <76f3bc23-8677-42bd-a3a5-43b17cbe552e@linaro.org>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com> <20230913-gpll_cleanup-v2-1-c8ceb1a37680@quicinc.com> <76f3bc23-8677-42bd-a3a5-43b17cbe552e@linaro.org>
Subject: Re: [PATCH v2 01/11] clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Date:   Wed, 18 Oct 2023 17:16:38 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-09-15 05:19:56)
> On 14.09.2023 08:59, Kathiravan Thirumoorthy wrote:
> > GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled based
> > on the request from dependent clocks. Doing so will result in the
> > unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the PLL
> > clocks.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL=E2=80=99s")
> > Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> > ---
> Stephen, do you think there should be some sort of error
> or at least warning thrown when SET_RATE_PARENT is used with
> RO ops?
>=20

Sure? How would that be implemented?
