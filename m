Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A76808BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443475AbjLGP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443452AbjLGP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:27:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B210C8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:27:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5FDC433C7;
        Thu,  7 Dec 2023 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962869;
        bh=WuHw8xBDQ4YPG0E788n4gpBGlBKTZtk7wXdWqhrweF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgL9KtdYlG4PFBVAkV/sg39gPBkBc1aKidxwfqYRrzk2ZA4RHPcOPy0HGyeZso8Z9
         bhTJU6U4hfQspY18LbEMb55CsfoESrH1Tg1OqsgRGFNMxO62AlQRTGZZXNuSo/sbAK
         wgoumdqFMPTxtnbfsBKet6cgEgWu/Lh16lt5PMi/wfTyaBqDvOuW3KJ0chfmEWDSo9
         bpe9/6+b75Tzpp6pHxxT1hlnHTVzvXVXlked6bsW6oetQnPGFgjpBZHaxXuGle+8h4
         RgooKFeqnIWvdCRijDdkC3u+hFpn747kWtx/08ovW73iluc+N74sD1qPEZv1+Jvbnq
         h5hls87q6xxfQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBGIp-0000q6-1V;
        Thu, 07 Dec 2023 16:28:39 +0100
Date:   Thu, 7 Dec 2023 16:28:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/6] usb: dwc3: qcom: Rename hs_phy_irq to
 qusb2_phy_irq
Message-ID: <ZXHkpwji_AzXMjfm@hovoldconsulting.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100950.28712-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:39:46PM +0530, Krishna Kurapati wrote:
> For wakeup to work, driver needs to enable interrupts that depict what is
> happening on th DP/DM lines. On QUSB targets, this is identified by

typo: the

> qusb2_phy whereas on SoCs using Femto PHY, separate {dp,dm}_hs_phy_irq's
> are used instead.
> 
> The implementation incorrectly names qusb2_phy interrupts as "hs_phy_irq".
> Clean this up so that driver would be using only qusb2/(dp & dm) for wakeup
> purposes.

Here too you should say something about why this won't break any systems
booting using an older devicetree. Specifically, the QUSB2 PHY interrupt
has never been armed on any system running mainline as those bits never
made it upstream.

So an alternative to this could also be to just drop the QUSB2 PHY
interrupt handling from this driver for now.

Johan
