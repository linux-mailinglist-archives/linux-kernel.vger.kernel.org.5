Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F417D47E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjJXHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJXHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:02:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68592;
        Tue, 24 Oct 2023 00:02:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E37C433C8;
        Tue, 24 Oct 2023 07:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698130972;
        bh=+EyzEkEY5OgBH2+OQ61ZdJ9Ly/9FG10TFtNjEehjNsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJPpMnAXVejeJbmmYluzR5PJz6rlNHaLzBN4ufDFZvdwpp/V3H0bT8NtYbNoks4Pv
         sG8nNxxIZFu358PTCN6c6OfCurLkDSK8AP0SIgTiU3WhpvPoi8swif7Fw3lbb/b0XM
         X2+WKS7nuApX1oJM1Wx73opQL0FN3M0GPSGA1YkvDOTL8xtsPTb9ZLPksI15tlCiVk
         Pie6uzcSaEmamahNNKPbvBhDLYokik2RlnVvvHMq1Y96tS93OGHN8rqa2uVECZ/dD6
         XA63YyKwtmKW7c/yyhU2Lx+SzxGYkuk90aWVv8nV4YntKec+guahN+0nldoEo/A+EJ
         B2eo/rWmp0uNg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBRU-0003bz-2A;
        Tue, 24 Oct 2023 09:03:08 +0200
Date:   Tue, 24 Oct 2023 09:03:08 +0200
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
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 07/10] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZTdsLMT9PNcnroHC@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-8-quic_kriskura@quicinc.com>
 <ZTaYNjRyT1Fn4QWX@hovoldconsulting.com>
 <73168f4b-0dc2-4060-99f2-c5e9973dbf52@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73168f4b-0dc2-4060-99f2-c5e9973dbf52@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:52:38PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 9:28 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:18:03PM +0530, Krishna Kurapati wrote:
  
> >> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> >> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> >> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> >> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> >> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
> > 
> > Not sure these defines makes sense on their own. You now only use them
> > via the array below.
> > 
> > I think I already asked you whether these offsets depend on SoC and you
> > said no, right?
> > 
> There are only 3 QC SoC's today that support multiport.
> The offsets mentioned here are for SC8280 based platforms.
> 
> For Sc8180 based platforms, these are the offsets:
> USB3_MP_PWR_EVNT_IRQ_STAT	0xA4F8858
> USB3_MP_PWR_EVNT_IRQ_1_STAT	0xA4F89DC
> 
> These would translate to 0x58 and 0x1DC
> 
> And for SX8380 the values are as follows:
> 
> USB3_MP_PWR_EVNT_IRQ_STAT	0xA4F8858
> USB3_MP_PWR_EVNT_IRQ_1_STAT	0xA4F89DC
> 
> So here also, the offsets are same. 0x58 and 0x1DC.
> So these are not SoC specific (atleast looking at the controllers 
> present). But there is no mathematical pattern to denote this as in the 
> following form (x + (port_num) * y). So made an array like this.

Sounds good. Thanks for confirming.

> >> +#define NUM_PWR_EVENT_STAT_REGS	4
> > 
> > You already have MAX_PORTS, why are you defining a new define that will
> > always have to be equal to MAX_PORTS?
> > 
> Do you recommend using the same max_ports ? If so, I can remove this 
> macro altogether.

Indeed, and perhaps also some (compile-time) assert as the driver breaks
if they ever get out of sync.

Johan
