Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14D4800717
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378081AbjLAJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378190AbjLAJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:33:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192A55B8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:30:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E42C433C7;
        Fri,  1 Dec 2023 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701423048;
        bh=JJyOioP4No0etvMhx+FJn3I0kqxY8hhH/XvABdVEB+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8MofWVjH1V/KnTQjrJxaHBRnTivjant92hnWgHenSAz4JOZ+wloFxSyjjgtHZg/E
         sOYcjsYmSy/gmm+pmBekAN608C3+hK/JGyulKD5WvYJEOmGArfi4rrkxoPhJ66dMs+
         Srm1T5fVYsgybWHrB7ex8TIptHxfnbOdbgwd1tSxtOUVDNfNVsr1dd9/FLhhg0khwA
         96hzoh3swPmaRidIpX60Iue9wOFrraKdCkurF60cOJVMidpdrjBpRVY+0scmCWK6cb
         Llcj1dO2RpktSaodi2507E1kkGB823B/hVhi8J30M4cOwstKoINfB0J+iGBxDllghW
         w9ZJec5eme1Hw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8zrm-0003Fh-1p;
        Fri, 01 Dec 2023 10:31:22 +0100
Date:   Fri, 1 Dec 2023 10:31:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
Message-ID: <ZWmn6uicNIqqSwoE@hovoldconsulting.com>
References: <20231130173223.12794-1-johan+linaro@kernel.org>
 <ad96b95a-5f4f-4333-b767-762936932061@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad96b95a-5f4f-4333-b767-762936932061@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:32:46AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2023 18:32, Johan Hovold wrote:
> > The PM8921 is an SSBI PMIC but in the binding example it is described
> > as being part of an SPMI PMIC while using an SSBI address.
> > 
> > Make the example consistent by using the sibling PM8941 SPMI PMIC
> > instead.
> > 
> > Fixes: 8138c5f0318c ("dt-bindings: rtc: qcom-pm8xxx-rtc: Add qcom pm8xxx rtc bindings")
> 
> Similarly to your thermal patch - this is just an example, not a
> binding. No bugs are fixed here, no need for backports.

A Fixes tag does not in itself imply that something should be
backported, we have CC-stable tags for that.

And if this was just about the name, I'd agree with you that a Fixes tag
is not warranted either, but the way I see this this is more than that
as the "spmi" name suggests that these "devices" sit directly on the
SPMI bus which would require a different binding entirely.

The naming therefore becomes misleading and should be fixed to assist
any casual consumer of these binding documents.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for reviewing these.

Johan
