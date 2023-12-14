Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9328129B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443300AbjLNHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:47:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245BBA3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:47:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C8C433C8;
        Thu, 14 Dec 2023 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702540057;
        bh=ovZ6zAePYvXD9jRWW6q/p7/dTB87cBa34W1V20uuBAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9fGXx9qKV+vxhEP/SeePB7AsEuV+hoBj7DlvaXnYxwmAvffPiqliig3m5TJ9oyjB
         K3tAuO+XjLoON/eUxLNlwk3qfyyzoO8UD775/diDY6n4LdvR1UIrLXlaXafvw1zol3
         cD+FHTrpdo2Pc+RbLnwOqZKF+fvLf251h1KkAqb7I3PlUEJO2ZWe1JEVxI3yItlqCp
         ZZPd2G3bIUF/t0zit8LI5Z4qYJtk9/myioET4ZzRiRSQUae9XWXs4VIPynMgZ2nrgj
         3LwvbTRda5RoxkH5zWLt1ea3mWIHUHov2CK1vu6MOTCYIw98TWcvCKYYXsiBp6mtQp
         xNdETgWmQOL6w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDgRV-0002uZ-0E;
        Thu, 14 Dec 2023 08:47:37 +0100
Date:   Thu, 14 Dec 2023 08:47:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: qcom: fix USB wakeup interrupts again
Message-ID: <ZXqzGculNm7vwUvh@hovoldconsulting.com>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <e2ce47e8-fe27-4ca0-b295-cf7e12eae1ce@linaro.org>
 <4b73d53e-ee25-4764-a916-973674d83fc9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b73d53e-ee25-4764-a916-973674d83fc9@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 07:25:51AM +0530, Krishna Kurapati PSSNV wrote:
> On 12/14/2023 12:19 AM, Konrad Dybcio wrote:
> > On 12/13/23 18:33, Johan Hovold wrote:

> >> Note sdm670 and sm6375 need similar fixes and I believe Bjorn is trying
> >> to dig out the corresponding vectors. The SS PHY interrupt on sc8180x
> >> should also be fixed.
> > sdm670:
> > 
> > pdc 9 DP
> > pdc 8 DM
> > pdc 6 usb3
> > 
> And for second controller of sdm670/sdm845,
> 
> pdc 11 DP
> pdc 10 DM
> pdc 7 SS

Thanks! Looks like we only describe the first controller on sdm670
currently.

I just sent a follow-on series for sdm670 and the sc8180x SS PHY
interrupts here:

	https://lore.kernel.org/r/20231214074319.11023-1-johan+linaro@kernel.org

Note that I inferred (guessed) the SS PHY numbers based on
sdm670/sdm845/sm8150 which all appear to use the same configuration.

After that series, only sm6375 remains to be fixed.

Johan
