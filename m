Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184B756307
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGQMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGQMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536091;
        Mon, 17 Jul 2023 05:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E4C6103F;
        Mon, 17 Jul 2023 12:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B46DC433C8;
        Mon, 17 Jul 2023 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689597920;
        bh=H13b/kPtnbPNqTkXh0P646Xi0qWC1YULsU7xxoNFXDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6K3P5tFClIWpj34d+MHBPFy6UlUBif976s68oHmrLN04lY7LhD7hht47BGRezIUA
         yUmb7+y1oCmtF1ye936kJU5r8VusBrE86uMb1cFwKXBPZLt82lBIvi2idEfeqKW+0R
         h8kPNuU9UvT/NFTm4cfdKscK571sWITEM8MuiTat0DUfFydekOW2DeVrfF2/yly3z5
         aubqxJW0S+73OiYo7yDr/eJ3Ei2f7ceGBWqwQy01U1y/3QaU4XuNKSOx3ekHtfslxP
         IllGMq3bOABvAcXbfqYw4X9YbiHXjrnJrkh0FcNdSGqX8M7ys9zXmHuwzo6ui/6L7u
         k43KmZlKtLpNg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLNbR-0000Qa-36;
        Mon, 17 Jul 2023 14:45:26 +0200
Date:   Mon, 17 Jul 2023 14:45:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: camss: Intepret OF graph connections more
 sensibly
Message-ID: <ZLU35SucePevwU6i@hovoldconsulting.com>
References: <20230614-topic-camss_grpah-v2-1-57d9d5e49038@linaro.org>
 <ZLUcaQN6hCjjulTv@hovoldconsulting.com>
 <18f2a5b5-5cc2-6bea-ca08-5da218b3192b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f2a5b5-5cc2-6bea-ca08-5da218b3192b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 02:40:05PM +0200, Konrad Dybcio wrote:
> On 17.07.2023 12:48, Johan Hovold wrote:
> > On Sat, Jul 15, 2023 at 05:37:52PM +0200, Konrad Dybcio wrote:

> >> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> >> index 1ef26aea3eae..8b75197fa5d7 100644
> >> --- a/drivers/media/platform/qcom/camss/camss.c
> >> +++ b/drivers/media/platform/qcom/camss/camss.c
> >> @@ -1084,9 +1084,8 @@ static int camss_of_parse_ports(struct camss *camss)
> >>  
> >>  		remote = of_graph_get_remote_port_parent(node);
> >>  		if (!remote) {
> >> -			dev_err(dev, "Cannot get remote parent\n");
> >> -			ret = -EINVAL;
> >> -			goto err_cleanup;
> >> +			of_node_put(node);
> > 
> > This is broken and could potentially lead to a use after free.
> > 
> > Specifically, the iteration macro already takes care of putting this
> > reference.

> /**
>  * for_each_endpoint_of_node - iterate over every endpoint in a device node
>  * @parent: parent device node containing ports and endpoints
>  * @child: loop variable pointing to the current endpoint node
>  *
>  * When breaking out of the loop, of_node_put(child) has to be called manually.
>  */

Please read this comment you just pasted here again as it seems you did
not understand it.

> > 
> >> +			continue;

And again, please remember to trim your replies. Including context after
your reply is almost always wrong.

Johan
