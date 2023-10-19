Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780577CFAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjJSNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJSNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EE106;
        Thu, 19 Oct 2023 06:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F99CC433C8;
        Thu, 19 Oct 2023 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697721621;
        bh=VOgijqnTNDtnP5vZfW0kZXy9HzFMq1AfoLyH43H+9QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euF/Oe30adccYRG1D2KqAdsZH6ES5G29fc3GYvg3jyHVY6vFkobKVbn1riBtcOn5q
         Z4c1wx3MgCigZGA1EBi2YEoesdyEQKqxjFYLdFhGllTOteXp5i16TUIcRNH4rgW41X
         cA0Le25PTRec0HIh52GVsWwxcL7z1HbJL6sXB3xyOiT6d9PBj/u11teLTqk7PWiZN2
         QlvaedlZNZi3tBCzyes9RLtV1cDjE0oSccwDCzEulImuyl5KBhLqQwZ3uSSona6TeQ
         U+lxWMPNCdk9aiwpYGGLNLLwD10Qa+C8SLKzcANg+Xvv5rbJiV/TOJJOKUskxqbezW
         ZcLwZdq7m2A7Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtSwq-0003YF-1G;
        Thu, 19 Oct 2023 15:20:24 +0200
Date:   Thu, 19 Oct 2023 15:20:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v9 05/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZTEtGIerwI90P6aA@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-6-quic_kriskura@quicinc.com>
 <ZJrRe7HtMs0KbsCy@hovoldconsulting.com>
 <e3e0c4c8-1e91-caf1-c1c4-86203a7ecba0@quicinc.com>
 <ZLo6MwbuKNL5xtPE@hovoldconsulting.com>
 <20230801013031.ft3zpoatiyfegmh6@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801013031.ft3zpoatiyfegmh6@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Digging through some old mails. ]

On Tue, Aug 01, 2023 at 01:30:36AM +0000, Thinh Nguyen wrote:
> On Fri, Jul 21, 2023, Johan Hovold wrote:
> > On Mon, Jul 03, 2023 at 12:26:26AM +0530, Krishna Kurapati PSSNV wrote:
  
> > > >> +/* Number of ports supported by a multiport controller */
> > > >> +#define DWC3_MAX_PORTS 4
> > > > 
> > > > You did not answer my question about whether this was an arbitrary
> > > > implementation limit (i.e. just reflecting the only currently supported
> > > > multiport controller)?
> > > > 
> > > I mentioned in commit text that it is limited to 4. Are you referring to 
> > > state the reason why I chose the value 4 ?
> > 
> > Yes, and to clarify whether this was an arbitrary limit you chose
> > because it was all that was needed for the hw you care about, or if it's
> > a more general limitation.
> > 
> 
> Note: We can support many, but we set the current limit to 4 usb3 ports
> and up to 15 usb2 ports.

Thanks for clarifying.

Johan
