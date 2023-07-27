Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A92764971
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjG0HzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjG0Hyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BA5252;
        Thu, 27 Jul 2023 00:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0F361D93;
        Thu, 27 Jul 2023 07:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FECC433C8;
        Thu, 27 Jul 2023 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690444222;
        bh=lWGwY1QhsymOYMK/LuXKj9gYqKYIQIFk/HwFmgDO3HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHTKxkLl4FLueg27w9rlU6X20u/MmWpNKiN2jUxJU6n3ksprFcwkrsKnIuGUXHOhE
         vsNJfq58fPH85c3exh34dqOFYKur2HzW1QJF1xg7a4hquL+OL2j8bEisYNe2azUPLf
         tu2b9ZCwQF3Zjr+dKgKcetNENV8IOcBEVG7jgaXFDZBqWg2+M31+CWKj+st8bgorCS
         Q7ucBgDfZpx76xNFgM66BpAIaYiOS77rwU7TGFQXxzskiZkJrGARxOqkvrxdlmw4fQ
         J4oTZ8+G+ATubDqBsxyy+9OKC+jNWVzQQCongrFjAiRzbkxKDgI1LjSYVG8rwkbeuX
         W/h/JmcWI9MLA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOvlf-00007v-1i;
        Thu, 27 Jul 2023 09:50:40 +0200
Date:   Thu, 27 Jul 2023 09:50:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com
Subject: Re: [PATCH v13 1/2] Bluetooth: hci_qca: adjust qca btsoc type print
 expression
Message-ID: <ZMIhz_ULbfwxZjZ8@hovoldconsulting.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <20230727044011.965205-2-quic_tjiang@quicinc.com>
 <ZMIcZqpN-CBgCFS8@hovoldconsulting.com>
 <11643479-3411-381e-4708-7259f6a15668@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11643479-3411-381e-4708-7259f6a15668@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:34:53PM +0800, Tim Jiang wrote:
> On 7/27/23 15:27, Johan Hovold wrote:
> > On Thu, Jul 27, 2023 at 12:40:10PM +0800, Tim Jiang wrote:

> >> @@ -1762,10 +1763,32 @@ static int qca_setup(struct hci_uart *hu)
> >>   	 */
> >>   	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >>   
> >> -	bt_dev_info(hdev, "setting up %s",
> >> -		qca_is_wcn399x(soc_type) ? "wcn399x" :
> >> -		(soc_type == QCA_WCN6750) ? "wcn6750" :
> >> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> >> +	switch (soc_type) {
> >> +	case QCA_AR3002:
> >> +		soc_name = "ar300x";
> >> +		break;
> >> +	case QCA_ROME:
> >> +		soc_name = "ROME";
> >> +		break;
> >> +	case QCA_QCA6390:
> >> +		soc_name = "QCA6390";
> >> +		break;
> >> +	case QCA_WCN3990:
> >> +	case QCA_WCN3991:
> >> +	case QCA_WCN3998:
> >> +		soc_name = "wcn399x";
> >> +		break;
> >> +	case QCA_WCN6750:
> >> +		soc_name = "wcn6750";
> >> +		break;
> >> +	case QCA_WCN6855:
> >> +		soc_name = "wcn6855";
> >> +		break;
> > I still think the above should be sorted (alphabetically) as maintaining
> > these lists otherwise soon becomes harder than it should be. And similar
> > throughout the driver.

> [Tim] Hi Johan: I think we no need to sort it, we only add the new btsoc 
> name following the older one, for example , ar300x is the oldest , ROME 
> is new than ar300x, actually qca2066 is newer version chip than qca6390, 
> so I does not think we need to sort it.

Possibly, but generally this becomes hard to maintain and eventually
someone will need to sort these entries anyway. Therefore it's generally
a good idea to just do so from the start.

But it was good that you replied so that we know that this comment was
not just missed or ignored.

> >> +	default:
> >> +		soc_name = "unknown soc";
> >> +		break;
> >> +	}
> >> +	bt_dev_info(hdev, "setting up %s", soc_name);

Johan
