Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A777BA348
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjJEPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjJEPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD68C26;
        Thu,  5 Oct 2023 07:16:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604BCC43397;
        Thu,  5 Oct 2023 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515394;
        bh=fWQldp1MXyl2dHxGT2BPOTVVly5guzHelUpsTf07C30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uY2BlzqQ8OTEFm7DFcjakRUdD34dpyyVkKd74Wjh7zMxYtV15MwqyAvGPk0hxcV6B
         gkhjqaPypFX1avgFjSTOEZeTVH8xtL5zR5iKdozju80d6HWrX6od/6/7ZhfG4AA7o7
         13tCjNmg7ah2rl71e9YZP5Nd3Lhx0rqD7nAA9bqXPAczQwG6xqxqNlEzoW0dlP1dPF
         fFu40icf6dmWCTUFupXrHJ9QnITf7nrf5Qw6UkgUsi4cXgrGyQMtSNsEAkoQ8y6jki
         LXjtxWlSHYp289tf6XfWpAWoK4ZvJfDJA7BQSvF+2IpckkUEc/++tVuhncut6UOLF9
         YV5vbbCAxXg1w==
Date:   Thu, 5 Oct 2023 15:16:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Message-ID: <20231005151637.4dc990f8@jic23-huawei>
In-Reply-To: <SN7PR03MB71329FB51185EAD7BE6C65A78ECBA@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
        <20230930163209.17ee0020@jic23-huawei>
        <SN7PR03MB71329FB51185EAD7BE6C65A78ECBA@SN7PR03MB7132.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 11:01:56 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Samstag, 30. September 2023 17:32
> > To: David Lechner <dlechner@baylibre.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > staging@lists.linux.dev; David Lechner <david@lechnology.com>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Axel Haslam <ahaslam@baylibre.com>; Philip Molloy
> > <pmolloy@baylibre.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
> > threshold to event attr
> > 
> > 
> > On Fri, 29 Sep 2023 12:23:27 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> > > From: David Lechner <david@lechnology.com>
> > >
> > > From: David Lechner <dlechner@baylibre.com>
> > >
> > > The AD2S1210 has a programmable threshold for the loss of signal (LOS)
> > > fault. This fault is triggered when either the sine or cosine input
> > > falls below the threshold voltage.
> > >
> > > This patch converts the custom device LOS threshold attribute to an
> > > event falling edge threshold attribute on a new monitor signal channel.
> > > The monitor signal is an internal signal that combines the amplitudes
> > > of the sine and cosine inputs as well as the current angle and
> > > position output. This signal is used to detect faults in the input signals.
> > >
> > > The attribute now uses millivolts instead of the raw register value in
> > > accordance with the IIO ABI.
> > >
> > > Emitting the event will be implemented in a later patch.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > 
> > I think I'm fine with treating these internal signals like this, but I would ideally
> > like someone from Analog devices to take a look at how these are being done
> > and make sure our interpretations of the signals make sense to them.  We are
> > pushing the boundaries a little here (though we have done similar before for
> > fault events I think.)  
> 
> Hi Jonathan,
> David and I we also had some internal discussion related to this.
> I'm sure these fault events and thresholds are understood correctly.
> Doing it this or the other way, it needs to be properly documented in order to make sense.
> So from my perspective whatever makes the most sense from a IIO ABI
> perspective, is the way to forward.

Great - as long as keep to a logical mapping I quite like the events
approach.  Most of these faults are real thresholds on things being measured
(even if those 'things' are signals from which stuff is derived for the main
measurements the device is making.)

Jonathan

> 
> -Michael
> 
> > 
> > Jonathan  
> 

