Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2975FB06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGXPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DAB7;
        Mon, 24 Jul 2023 08:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D571560C49;
        Mon, 24 Jul 2023 15:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBE2C433C8;
        Mon, 24 Jul 2023 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690213298;
        bh=FwmJyUFEwRmW6GyLKrRzaoOIFKD1ZixYyekFLFBjYm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxZNmLvGWF0DcvPN5zy994G1T8upsOy4oNv0aa5nIm9dPf/QVVpQZn848TRZ1rklg
         3W1Bdkz6crdOaUKTZJTf63y+9/GThMSsqtya4Gl9U9YgsTgm0RLlGuHo6H6C5/1VaI
         9zWORpzVrZesTnVYEsypK7vADRQiw93qJVtLfSG/JjoSJ1ZfB0015D7Sf5a4wKrXe/
         kGnkkRJY/FoAVIib6/IqSS/08ZYLBSqS8CQiwQ60ySUCkGDBDg5Xc9nf4w7qQK40yc
         siMJJO9hrCcKMdsVuPTxhP/ROnUDZe+VLzRnAYTnPhxlJIsHxIQqHdOGfX/Oe4wP9Y
         91yoKaZiERL/Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qNxgz-0005Ey-0h;
        Mon, 24 Jul 2023 17:41:49 +0200
Date:   Mon, 24 Jul 2023 17:41:49 +0200
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
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZL6bvQkBUsFErpXd@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
 <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
 <e225fa01-c3be-8bfc-03de-59b507c70d3b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e225fa01-c3be-8bfc-03de-59b507c70d3b@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please remember to trim your replies. ]

On Sun, Jul 23, 2023 at 08:29:47PM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 5:15 PM, Johan Hovold wrote:
> > On Wed, Jun 21, 2023 at 10:06:21AM +0530, Krishna Kurapati wrote:

> >> +#define XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
> >> +#define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
> >> +#define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
> > 
> > Again, don't copy defines from xhci.
> > 
> > Looks like these should be moved to the xhci-ext-caps.h header along
> > with struct xhci_protocol_caps.
> 
> Moving the defines would be sufficient right ? Just wanted to know if 
> there is any reason you are suggesting to move the structure as well so 
> that I can update commit text accordingly.

The defines are used for parsing the members of struct
xhci_protocol_caps and they belong together even if no driver has
apparently ever used the structure.

Johan
