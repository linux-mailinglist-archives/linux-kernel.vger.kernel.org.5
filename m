Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDE7D2D09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJWIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJWIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:44:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D645DD;
        Mon, 23 Oct 2023 01:44:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB4DC433C7;
        Mon, 23 Oct 2023 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698050641;
        bh=u7NlD1Q+yOeYznnIX1NVopvkTd5tWg++cwHdsd8xV9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9CvIn0J0RMwF/S119USSKPzO0larT1HgWg65t/5hmyR0VWd8BN4NDchR3gyJi5rk
         WkEfkSIkJom9+ATFcmZjEkHDBklwwLnEWV9neWYBrs6SWKZWZ/OOh3rz65uvwbUlCe
         b556SNpPjp1XIuDZrp3JhLl4gpinZq0inwcycAE0rXZJavjhegx6usGIs9GR93x2jo
         ZhJc4z0VaXilVdDdraN+P+Y9FOgkOsVB+1dwWKQDp7awVIPzN9y6SE9RKamRtI9Dpw
         vXOf84SUl7z2EcB+32pA3W4sR2R7sDjaO1TvJ6dIxfclxU71S8IzEw+cSlWe56GilE
         X3HQZAqr9hFDA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quqXm-0007eU-2X;
        Mon, 23 Oct 2023 10:44:14 +0200
Date:   Mon, 23 Oct 2023 10:44:14 +0200
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
Subject: Re: [PATCH v13 01/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZTYyXhyZN3jBXEfm@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-2-quic_kriskura@quicinc.com>
 <ZTI7AtCJWgAnACSh@hovoldconsulting.com>
 <279a54f2-7260-4270-83c7-d6f5c5ba0873@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279a54f2-7260-4270-83c7-d6f5c5ba0873@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:12:44PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/20/2023 2:02 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:17:57PM +0530, Krishna Kurapati wrote:
> >> Currently host-only capable DWC3 controllers support Multiport.
> > 
> > You use the word "currently" in a few places like this (e.g. in comments
> > in the code). What exactly do you mean? That all current multiport
> > controllers are host-only, or that this is all that the driver supports
> > after your changes?
> > 
> This means that, today the capable multiport controllers are host-only 
> capable, not that the driver is designed that way.

Ok.

> > Please rephrase accordingly throughout so that this becomes clear.

Johan
