Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDC7CED05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJSA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:58:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4621611D;
        Wed, 18 Oct 2023 17:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DC9C433C8;
        Thu, 19 Oct 2023 00:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697677121;
        bh=ih+ytPv4nxpq0a5mnqxIN76oDxBc4L1G0wNYPAVRMGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JLQjRFD4nWYcmeWUiYVKzwRBAOw8CqTn7BpbDYNqKjoCArBB21vo4+1kCsVbvlBf8
         8uyfWLl4V3qCO5p9YthHUrbuFspPBVZLYUlC6nqPeWBc2c3h5ungXN2CrRHjMbGj4G
         eFRfr8oXPckwk27ZpZF53A2pOO/6G0H9iW7FPH2/3GKoj8FWTPi8dyQkF9zAhBpYL5
         zqT/qUsRJlAY4c74FM+hzd3S/08Y8hAL7SNoFrKx7ODSnlHB/015uvqkF8WD0zpd3j
         zXTzkmPHNtoow9W6rOtcAWPu91mHHgZD4/dJriQK6NUOhLYypzjJKn2OCBptAfhkSw
         wtTXcJYRwmvZw==
Message-ID: <e38ae24c09ef321c224a6b6aeb97e73b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231017131944.8356-1-quic_kriskura@quicinc.com>
References: <20231017131944.8356-1-quic_kriskura@quicinc.com>
Subject: Re: [RFC 4/8] clk: qcom: gcc-sm8450: Keep usb30 prim gdsc on during runtime suspend
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 18 Oct 2023 17:58:38 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Kurapati (2023-10-17 06:19:44)
> When runtime suspend happens in host mode, if cable is removed at this
> instant, it triggers a resume where a xhci register access is done when
> gdsc is not on leading to a crash. Keep usb30 prim gdsc as on during
> runtime suspend to avoid this crash.
>=20
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Note: I am not sure if this is the right way or setting GDSC flags to
> PWRSTS_RET_ON is the right approach. So for now made this change to

Does using PWRSTS_RET_ON work? Does the GDSC support being turned off or
is the lowest power state retention?
