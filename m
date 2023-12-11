Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738980D216
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjLKQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjLKQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287691
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:38:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BFCC433C8;
        Mon, 11 Dec 2023 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702312698;
        bh=uT3+vtv8HvVFAQ4LBmaj/5ll70qrpowhUoWCN8h1EKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0sdzlHzEI3Kvyn+aJJE+//AB/HyRXlUCzj0PeNF1vDfIfo7i+WeYD+xwuZD4/6zO
         qWZe6lIs0vd/eMbwZsURybmS1k8ZlnKdurb/8l6F2jlWJGnYM+OSEMkXU30EAcpu4Y
         h8sx+bHkmZKNuilNAIa7em232OhoPJSO+vtQu6C5q56xi36ly/8bjmOxldnx09zl5+
         J+A2REZGk8Xbv2htMOBm59RaZ/8UaW8tSvR1wYX7p9MlRwJM28obbFvRAYq3Iw40Gq
         6yX0/lW7c5v7Y02JrYRme9mLIbNgGJWgZQ8eq+QPhbG0rnxcd64Ldoje70yUjfqcm9
         fze+I5j0TV/hQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCjJB-00069a-0E;
        Mon, 11 Dec 2023 17:39:05 +0100
Date:   Mon, 11 Dec 2023 17:39:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt
 types
Message-ID: <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120164331.8116-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:43:20PM +0100, Johan Hovold wrote:

> It turns out a number Qualcomm devicetrees have also gotten the trigger
> types wrong, something which this series addresses.
> 
> Specifically, the HS/SS PHY wakeup interrupts are level triggered while
> the DP/DM HS PHY interrupts are edge triggered, and which edge to
> trigger on depends both on the use-case and on whether a Low speed or
> Full/High speed device is connected.
> 
> Fortunately, there should be no dependency between this series and USB
> one as all devicetree use the correct trigger type for the HS/SS PHY
> interrupts and the HS one has never been armed by Linux anyway. The
> DP/DM interrupt trigger types are also updated on suspend currently.

Konrad reported off-list that the sc8180x patch in this series breaks
probe of the dwc3 driver.

Turns out a number of these SoCs were using GIC interrupts for the
DP/DM_HS_PHY interrupts despite the fact that the driver tries to
reconfigure these as IRQ_TYPE_EDGE_FALLING (which the GIC does not
support) to detect disconnect events during suspend.

This is obviously broken and the proper fix is to replace the GIC
interrupts with the corresponding PDC interrupts. I believe Konrad is
digging out the magic numbers at this moment.

The following patches will need a follow-up fix:

>   ARM: dts: qcom: sdx55: fix USB wakeup interrupt types

>   arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types
>   arm64: dts: qcom: sdm670: fix USB wakeup interrupt types
>   arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
>   arm64: dts: qcom: sm6375: fix USB wakeup interrupt types
>   arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

Sorry about not noticing this.

Johan
