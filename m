Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA376AB4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHAIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHAIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:45:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3374F1B6;
        Tue,  1 Aug 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+iCOMUZEBRmp0SfXP3l/d75t5cDd7ZTASaBmWC/aA3g=; b=Hr21qsxB3uCtbyYtTq54zdvsSe
        LSi1orVTZmDgACnr7OMqBi+zYld5OJZ1RM1gHcmzXtsEHsV5SuYD3iFm3BSo5rp9yREoQayT68pFz
        fWMRqbZcyz5EXaHHfzjS0N3NLiF1Mvnnj0Ta8kGGy5YoOnT1iig3AvDdcVNgJVykHcY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qQl00-002mRI-9L; Tue, 01 Aug 2023 10:45:00 +0200
Date:   Tue, 1 Aug 2023 10:45:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <98179d9e-0c03-4659-9dcc-73a411bfa00e@lunn.ch>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
 <21dfb855-8f44-4a4c-9dba-52eb5ae46b9b@lunn.ch>
 <20230731153938.GF1428172@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731153938.GF1428172@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 08:39:38AM -0700, Bjorn Andersson wrote:
> On Mon, Jul 31, 2023 at 10:21:31AM +0200, Andrew Lunn wrote:
> > On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> > > From: Chris Lew <clew@codeaurora.org>
> > > 
> > > In addition to the normal runtime commands, the Always On Processor
> > > (AOP) provides a number of debug commands which can be used during
> > > system debugging for things such as preventing power collapse or placing
> > > floor votes for certain resources. Some of these are documented in the
> > > Robotics RB5 "Debug AOP ADB" linked below.
> > > 
> > > Provide a debugfs interface for the developer/tester to send these
> > > commands to the AOP.
> > 
> > This sort of sending arbitrary binary blob commands is not liked,
> > since it allow user space closed source drivers. At minimum, please
> > provide a file per command, with the kernel marshalling parameters
> > into the binary format, and decoding any returned values.
> > 
> 
> Thanks for your input Andrew, that is a valid concern.
> 
> The interface is in debugfs and as such wouldn't be suitable for closed
> source drivers, as in the majority of our shipping software debugfs
> isn't enabled.

There only appears to be 3 commands, so it is now too much of a burden
to do it properly, and not have a binary blob API.

And most distros do have debugfs at least built and available, but
maybe not mounted.

      Andrew
