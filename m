Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B27D0AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjJTIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376509AbjJTIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:38:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A6D65;
        Fri, 20 Oct 2023 01:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE3AC433C8;
        Fri, 20 Oct 2023 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697791091;
        bh=9SQfZR/nn3xuO36PSNTBTydsMCVV2RapIyMT5BBaj2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvrFJbPnL4+dhwzTK5G5E9IsJN1JtCCt+OgH9Rr7lkGYknzK+4DSJA0fUm8kKLBfc
         B1u1k3OgZPf8tEgZkwceNMZLi3YOMQ/v3RfivjZTJGwN8MretAHy8nGlFlJ5yT/x+L
         9+/YmSvDh065sjME4f76IW7iHaYv8+N9fs3jO/Pq9LeBVKAWcvrTwSWw/iwZVpFH/u
         FbEg+Wh5uXLE0Vh+f4IKImMTeInPqVyNpESqrP02VfPs5sAfHhhned5RMEju7v5qSY
         YsDffpBWbQC0IbzVLKmEllaOPQ+wxd/E43Bc+/Tmh8GiESgiIm2v15Sg5wfFI+RCOr
         mN7m6YhnL1KHQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtl1M-0001lO-0v;
        Fri, 20 Oct 2023 10:38:16 +0200
Date:   Fri, 20 Oct 2023 10:38:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 02/10] usb: dwc3: core: Skip setting event buffers
 for host only controllers
Message-ID: <ZTI8eFbVAYy3hxQy@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:17:58PM +0530, Krishna Kurapati wrote:
> On some SoC's like SA8295P where the tertiary controller is host-only
> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to access them leads to a crash.
> 
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
