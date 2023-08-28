Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC178B495
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjH1Pga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjH1PgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2BEA8;
        Mon, 28 Aug 2023 08:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27F6619D9;
        Mon, 28 Aug 2023 15:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA1C433C9;
        Mon, 28 Aug 2023 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693236973;
        bh=MaQo1sQ7uRn1nnWSN7Y4hWib//CPVZtqmc3RJjAcQ+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6wxqOzvWb0hpnzZZMHX+goK+nbclN2bE3YsIlilG5U93+nn4c8N7xHmPfh6oZlSW
         is2MGUtmS1iswqnGW6m96/VmeTXqpCCZH3NnE5AJlBlyTiy+/QRif3djog+8W+GlNY
         paSdDkj93J2fiNe+qN8oW0e5N/13hFC59b1gg5jQMe+xVVWaMK6XvDL+WoSjs24je4
         LyJcNBcCpl/dhHkgzkDWRboGZhd2WgNbjnkIBBD/PPiuHFtDJBTeCb5DJ8jT+XNJAK
         czEjUh/XSq9UA3dau6hpGpY+qx5KX16l9y/RERLNJQ0paNii9kT3zVKsSINfbs1FEm
         jbg1BS/3ZCB6g==
Received: (nullmailer pid 598799 invoked by uid 1000);
        Mon, 28 Aug 2023 15:36:11 -0000
Date:   Mon, 28 Aug 2023 10:36:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2 RESEND 2/2] dt-bindings: usb: dwc3: Add DWC_usb3 TX/RX
 threshold configurable
Message-ID: <169323697090.598738.7627713780609568752.robh@kernel.org>
References: <20230828055212.5600-1-stanley_chang@realtek.com>
 <20230828055212.5600-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828055212.5600-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2023 13:52:06 +0800, Stanley Chang wrote:
> In Synopsys's dwc3 data book:
> To avoid underrun and overrun during the burst, in a high-latency bus
> system (like USB), threshold and burst size control is provided through
> GTXTHRCFG and GRXTHRCFG registers.
> By default, USB TX and RX threshold are not enabled. To enable
> TX or RX threshold, both packet threshold count and max burst size
> properties must be set to a valid non-zero value.
> 
> In Realtek DHC SoC, DWC3 USB 3.0 uses AHB system bus. When dwc3 is
> connected with USB 2.5G Ethernet, there will be overrun problem.
> Therefore, setting TX/RX thresholds can avoid this issue.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v1 to v2 change:
>     Add the properties for TX/RX threshold setting
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

