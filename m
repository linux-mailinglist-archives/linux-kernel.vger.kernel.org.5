Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C057D2DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjJWJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjJWJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:11:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE943D7B;
        Mon, 23 Oct 2023 02:11:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA22C433C8;
        Mon, 23 Oct 2023 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698052299;
        bh=4X70b+y5Rv1VPzOWwLZG3sDuDOPKJsxum64a06GpX2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnQk+4OxI/6+02PUkt2DxouJgD2tN/LJ+U0iSXfJjHydL4jTxJxALCeIQtOOh24wd
         5Lag11TF2iApRxIyikbrXeQbRbsYURMXJbE5Tnx0hbX8945cY/NupCGzt8vgvlOCMp
         tdR2NLep23Ii3z0p+P7AkjmTwcixVRwho95fuDkAHzgpxI5mqY+Nx8d2KhkBe46Q42
         AANDVKC5FotJN8fz7cEU0oRQblQUe2WUgzXfTO4Bq+xBwX45+ecSPn+Fx1CbqKJcmx
         E+GvDm3h2K5FaRHTYUH+YBBlGCD0QGfef1FAr3v1pPDhb0SyTK80QM7d3TProwUryT
         gKmv3KIwYGVZA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quqyW-0007rt-2E;
        Mon, 23 Oct 2023 11:11:53 +0200
Date:   Mon, 23 Oct 2023 11:11:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
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
        quic_shazhuss@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZTY42KvYCk9HhCIE@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-4-quic_kriskura@quicinc.com>
 <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
 <257716c4-7194-4d26-a34c-fff09234628f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257716c4-7194-4d26-a34c-fff09234628f@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 11:33:52PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/20/2023 3:27 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:17:59PM +0530, Krishna Kurapati wrote:
> >> From: Harsh Agarwal <quic_harshq@quicinc.com>
> >>
> >> Currently the DWC3 driver supports only single port controller
> >> which requires at most one HS and one SS PHY.
> > 
> > Should that not be "at least one HS PHY and at most one SS PHY"?
> >   
> 
> No, I think it would be appropriate to say "at least one phy (HS/SS)" as 
> even one phy is sufficient to get things working.

No, that would be a violation if the binding (even if the driver may not
currently enforce it for generic phys) as well as the USB spec.

Also note that your implementation (i.e. this very patch) assumes that
num_usb2_ports >= num_usb3_ports.
 
> >> Add support for detecting, obtaining and configuring phy's supported
> > 
> > "PHYs" for consistency, no apostrophe
> > 
> >> by a multiport controller and. Limit the max number of ports
> > 
> > "and." what? Looks like part of the sentence is missing? Or just drop
> > " and"?
> > 
> >> supported to 4 as only SC8280 which is a quad port controller supports
> > 
> > s/4/four/
> > 
> > Just change this to
> > 
> > 	Limit support to multiport controllers with up to four ports for
> > 	now (e.g. as needed for SC8280XP).
> > 
> >> Multiport currently.
> > 
> > You use capitalised "Multiport" in several places it seems. Is this an
> > established term for these controllers or should it just be "multiport"
> > or "multiple ports"?
> > 
> This is an established term AFAIK. So I've been using it here like this.

Do you have a pointer? A google search seems to mostly come up with
links to this patch series.

Johan
