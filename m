Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87697CA330
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjJPJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjJPJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3978BF5;
        Mon, 16 Oct 2023 02:01:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659DC433C9;
        Mon, 16 Oct 2023 09:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697446913;
        bh=JZNNaADJ7qXp5c7KPri0lQGSkXdeIiUrGbMneibduME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfgiJ3nDm7L3V3BpuWNtUIG5krVrjH+PPTEDJhjnJDheRY9aSMQxJUlPb/qUZfL/F
         lKsICe/w+/QkVGM5ELqY4M0cNzR/92JmL2TA/elK47c+dttq1gHoTQoT084jI5mSK9
         WVNTvq+funx+ttOFZpOrrwm3RlJzfNuky+7OzejlscYqL2rEO4cOofqzyLZ/joPZZE
         zyrJm5G55hmcL0BRkYgoFrzvipGwrNAvVnVYLXdah8UwTeg8hLTWA8nQ4/LbPHRskP
         QA6is7dNt4nxt5d04bwCIybhl16tg2u2T0Z4cpXC95aqFtKgOInF+uMVxCxXuCkAZV
         RTFa0y6PZtwsA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsJTv-0003TF-31;
        Mon, 16 Oct 2023 11:01:47 +0200
Date:   Mon, 16 Oct 2023 11:01:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY
 compatible
Message-ID: <ZSz7---IW_7Oj2Zr@hovoldconsulting.com>
References: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
 <CAA8EJprXCzVyaU49qgVcVfF0-FJ3QqAfTMZj5CEZm187hoi4=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprXCzVyaU49qgVcVfF0-FJ3QqAfTMZj5CEZm187hoi4=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:51:33AM +0300, Dmitry Baryshkov wrote:
> On Fri, 29 Sept 2023 at 19:03, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > The DP PHY needs different settings when an eDP display is used.
> > Make sure these apply on the X13s.
> 
> Could you please clarify, is it the same PHY type, just being
> repurposed for eDP or is it a different PHY type?

Same PHY, just different settings AFAIK.

> If the former is the case (and the same PHY can be used for both DP
> and eDP), it should carry the same compatible string and use software
> mechanisms (e.g. phy_set_mode_ext()) to be programmed for the correct
> operation mode.

Possibly, but that's not how the current binding and implementation
works:

	6993c079cd58 ("dt-bindings: phy: qcom-edp: Add SC8280XP PHY compatibles")
	2300d1cb24b3 ("phy: qcom: edp: Introduce support for DisplayPort")
	3b7267dec445 ("phy: qcom: edp: Add SC8280XP eDP and DP PHYs")

	https://lore.kernel.org/lkml/20220810040745.3582985-1-bjorn.andersson@linaro.org/

And you'd still need to infer the mode from DT somehow.

Johan
