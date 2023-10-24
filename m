Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F837D4CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjJXJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjJXJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:54:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02AA118;
        Tue, 24 Oct 2023 02:54:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF3BC433C8;
        Tue, 24 Oct 2023 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698141259;
        bh=W+0QNqrgDZnOgi+hua/M9Ooqieg02b9bat44s6CqMUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU3EL63smcyw4DW29cAE87yiTKhtpmVZoah8oPz++M+9CngOTdXHOpiDWm6zB8G0P
         cxWLL5j2Unb+zvM2Ztic/IytOdi+nrfwR1KXcK0YKDQnppva8BZE15ST8L7AjJnLYO
         1ZmSZVPjy8VGBg+EQ6GxSTZQhUniGjXogo0c4iGY=
Date:   Tue, 24 Oct 2023 11:54:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <2023102408-deodorize-frequent-184e@gregkh>
References: <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <196601cc-f8c6-4266-bfff-3fd69f0ab31c@quicinc.com>
 <ZTeL4nSw6dMGKODm@hovoldconsulting.com>
 <2023102429-craftsman-student-ba77@gregkh>
 <ZTeObdjSSok0tttg@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTeObdjSSok0tttg@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:29:17AM +0200, Johan Hovold wrote:
> On Tue, Oct 24, 2023 at 11:23:19AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 24, 2023 at 11:18:26AM +0200, Johan Hovold wrote:
> 
> > > And we may even consider reverting the updated bindings as it appears
> > > they are still not correct.
> > 
> > If you can tell me what the git ids of them are, I'll be glad to do so
> > right now, sorry for taking them "early".
> 
> That's
> 
> 	ca58c4ae75b6 ("dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport")
> 
> and
> 
> 	eb3f1d9e42b1 ("dt-bindings: usb: Add bindings for multiport properties on DWC3 controller")
> 
> It's probably best to just revert them now.

Now reverted, thanks.

greg k-h
