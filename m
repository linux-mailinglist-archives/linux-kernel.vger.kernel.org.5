Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D87F45EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbjKVMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343719AbjKVMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:23:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7A6197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7071DC433C7;
        Wed, 22 Nov 2023 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700655816;
        bh=BYEcrkRJolTlhrpPIJPgV41ILBqMXfYPCsqUZp1UwYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwmOU9T2VGnU3b6rAa05NBuX3nFH52KxkrNJb7dcCGGArBcSfFkNG81gZrz1fIk6l
         T/olhBkflMFu9Vp7eX5hz8bUgvcdkJBwTLvOWyws15S3wo6MHDxwSdmTr1JSrvOlGy
         tRRYmmd/roKlvJ7KVthvHTfsMEVG/fotLXgs1wE9VkRvatMLT8aYZizP8F4TLOGrfG
         o2wSHZPHxdWzHrQ3RDnGFFh6TP9CD/9McQSJm3BIMZy2t3XI7x55IpOYRh9F2Q3npw
         qCPov3ojvQvJ6zw4otHorw9091L5Gbq+F+7rtoayNWfQTuVlAp7HmFr3BgM1oAyrbz
         2pyZpaPBbuEyg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5mGk-0000C4-23;
        Wed, 22 Nov 2023 13:23:51 +0100
Date:   Wed, 22 Nov 2023 13:23:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 07/12] usb: dwc3: qcom: Instantiate dwc3 core directly
Message-ID: <ZV3y1oUpZL7btbF1@hovoldconsulting.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-7-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-7-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:15PM -0700, Bjorn Andersson wrote:
> The Qualcomm DWC3 glue builds up a platform_device programmatically in
> order to probe the DWC3 core when running off ACPI data. But with the
> newly introduced support for instantiating the core directly from the
> glue, this code can be replaced with a single function call.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

> @@ -986,10 +933,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  interconnect_exit:
>  	dwc3_qcom_interconnect_exit(qcom);
>  depopulate:
> -	if (np)
> +	if (qcom->dwc_dev)
>  		of_platform_depopulate(&pdev->dev);
>  	else
> -		platform_device_put(pdev);
> +		dwc3_remove(qcom->dwc);

The current code was broken here too:

	https://lore.kernel.org/linux-usb/20231117173650.21161-2-johan+linaro@kernel.org/

Johan
