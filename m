Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01576095B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGYFft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGYFfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B21737;
        Mon, 24 Jul 2023 22:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24FE61536;
        Tue, 25 Jul 2023 05:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE699C433C7;
        Tue, 25 Jul 2023 05:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690263345;
        bh=oEqOvaYTtYD0cDhlp47C+7XbAkxvJEjRKWIZtt4DxJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9kVXjf1HBDSjHedbx4wMwqTpNqKR8EFUdQJlMmhXfBLthblmuZkU77Z1IhdaR0wK
         x1OLHGpuEV3kutCyQ2/LY1/oaReoB/VEuw+Gs4FrtcJVkBIZkitCPYTSkInvuDJmCG
         SETBLrckjO2tXk+VvPn76Wm6pQeqppYZjuaQHbRk=
Date:   Tue, 25 Jul 2023 07:35:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
        oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 01/32] xhci: add support to allocate several
 interrupters
Message-ID: <2023072520-footbath-pessimist-670d@gregkh>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-2-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725023416.11205-2-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:33:45PM -0700, Wesley Cheng wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Modify the XHCI drivers to accommodate for handling multiple event rings in
> case there are multiple interrupters.  Add the required APIs so clients are
> able to allocate/request for an interrupter ring, and pass this information
> back to the client driver.  This allows for users to handle the resource
> accordingly, such as passing the event ring base address to an audio DSP.
> There is no actual support for multiple MSI/MSI-X vectors.
> 
> Factoring out XHCI interrupter APIs and structures done by Wesley Cheng, in
> order to allow for USB class drivers to utilze them.
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi.rej | 14 ++++
>  arch/arm64/configs/defconfig.rej         | 24 ++++++
>  drivers/usb/host/xhci-debugfs.c          |  2 +-
>  drivers/usb/host/xhci-mem.c              | 93 ++++++++++++++++++++++--
>  drivers/usb/host/xhci-ring.c             |  2 +-
>  drivers/usb/host/xhci.c                  | 49 ++++++++-----
>  drivers/usb/host/xhci.h                  | 77 +-------------------
>  include/linux/usb/xhci-intr.h            | 86 ++++++++++++++++++++++
>  8 files changed, 245 insertions(+), 102 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8350.dtsi.rej
>  create mode 100644 arch/arm64/configs/defconfig.rej
>  create mode 100644 include/linux/usb/xhci-intr.h
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi.rej b/arch/arm64/boot/dts/qcom/sm8350.dtsi.rej
> new file mode 100644
> index 000000000000..e96ef1120160
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi.rej
> @@ -0,0 +1,14 @@
> +--- arch/arm64/boot/dts/qcom/sm8350.dtsi
> ++++ arch/arm64/boot/dts/qcom/sm8350.dtsi
> +@@ -2254,9 +2254,9 @@
> + 				iommus = <&apps_smmu 0x0 0x0>;
> + 				snps,dis_u2_susphy_quirk;
> + 				snps,dis_enblslpm_quirk;
> +-				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
> ++				phys = <&usb_1_hsphy>, <&usb_1_qmpphy>;
> + 				phy-names = "usb2-phy", "usb3-phy";
> +-
> ++				dr_mode = "host";
> + 				ports {
> + 					#address-cells = <1>;
> + 					#size-cells = <0>;
> diff --git a/arch/arm64/configs/defconfig.rej b/arch/arm64/configs/defconfig.rej

<snip>

I think you need to look at this patch series a bit better and clean it
up before sending it out.  These files obviously are not going to work,
and prevent any of this from being able to be applied or tested by any
bots or test systems :(

I've stopped here in my review of this series (except for the obvious
global symbol name comment.)

thanks,

greg k-h
