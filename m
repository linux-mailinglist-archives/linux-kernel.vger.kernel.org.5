Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D27F42C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjKVJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjKVJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:49:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B634212A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B70C433C9;
        Wed, 22 Nov 2023 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646516;
        bh=VC9h/SiN8Zx5aGSBZR6crUirZJCFXIk5eN7BP4+P6I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2r1HKahm9VWVd8qhtRV5/TA0RzVd6l+Ek0VSBN3s1RHZ4h7noyswlQcQ/YYLC0bk
         S8X2LCkTa9Cn0lqoVsO7YeEWzqDDF9S00dbajvfkp/V/Nkf6RbrOv60lm2Tu2jKhzH
         hJHZR8n8AoXCmbsVVJ4HS9/AW6Dt7b2D46VblcZMz174wt5kA9wh4fSSKIjgNyL93o
         Vh0BPCbwpKejYEmFtM3PBxYReBmcH7yZKTkqkAthHqusQZrsvy/TIyXYFaJRwJzhJL
         E5WBfi2inJ1LBiPwSpwzZkes9BfR8RHQ7hzLdlH71Y2L2f9A6BHxmwdiPcB7qM765H
         4tEAIETsNmApQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5jqk-0008B5-1g;
        Wed, 22 Nov 2023 10:48:50 +0100
Date:   Wed, 22 Nov 2023 10:48:50 +0100
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
Subject: Re: [PATCH 00/12] usb: dwc3: qcom: Flatten dwc3 structure
Message-ID: <ZV3OgorG4G4mwvv1@hovoldconsulting.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:08PM -0700, Bjorn Andersson wrote:
> The USB IP-block found in most Qualcomm platforms is modelled in the
> Linux kernel as 3 different independent device drivers, but as shown by
> the already existing layering violations in the Qualcomm glue driver
> they can not be operated independently.
> 
> With the current implementation, the glue driver registers the core and
> has no way to know when this is done. As a result, e.g. the suspend
> callbacks needs to guard against NULL pointer dereferences when trying
> to peek into the struct dwc3 found in the drvdata of the child.
> 
> Missing from the upstream Qualcomm USB support is handling of role
> switching, in which the glue needs to be notified upon DRD mode changes.
> Several attempts has been made through the years to register callbacks
> etc, but they always fall short when it comes to handling of the core's
> probe deferral on resources etc.

Nice to see this finally being worked on. It's not clear why mode-change
notifications would be a problem though, as if you get such a
notification, you know that core has been probed.
 
> Furhtermore, the DeviceTree binding is a direct representation of the
> Linux driver model, and doesn't necessarily describe "the USB IP-block".

True.

Johan
