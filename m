Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D42810E12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjLMJyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjLMJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:54:08 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB11E8;
        Wed, 13 Dec 2023 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7F13S8FLoutiZ3CalADES9Ypom9LrrGw6pCO4/ixxqw=; b=RuvoDMyVMMqqs1yxb8x0Hv1lR0
        MgvpCopZwbFbh/IJm/HmhiDSH5+was538qxsXbKTUCGvI1RgOdw3EukXbMtf4pwwf9A84COngxvsk
        1BE9R0UJ0+69oMZogGPSJ6B9j/7kgyya2bTz0TOfJerchu+fUph//fKvnOTIkCtIR4sQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDLwI-002nrP-E7; Wed, 13 Dec 2023 10:54:02 +0100
Date:   Wed, 13 Dec 2023 10:54:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>,
        andersson@kernel.org
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: Add sysfs nodes for
 qcom ethqos
Message-ID: <428bba44-c0b9-48b2-b4fc-feba3e2245ae@lunn.ch>
References: <20231204084854.31543-1-quic_snehshah@quicinc.com>
 <3e4a1b9c-ed0f-466e-ba11-fc5b7ef308a1@lunn.ch>
 <5d5f3955-fc30-428c-99f4-42f9b7580a84@quicinc.com>
 <0c966845-2bbc-4196-806d-6a33e435bf7d@lunn.ch>
 <dd585977-50c4-40a4-a664-0ecb5a84807a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd585977-50c4-40a4-a664-0ecb5a84807a@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> We need to route vlan traffic of a specific Priority to GVM Queue
> >> (Ethernet queue 5) via programming a MAC register. The MAC register
> >> is not accessible in GVM and has to be programmed from PVM. stmmac
> >> already has TC OPS to program this routing via vlan
> >> priority. However, as PVM has only 4 queues enabled, TC tool will
> >> not take 5th queue as input. Hence, these nodes were added to
> >> conifure the MAC register to route specific vlan packets to 5th
> >> queue in GVM.
> >  
> >> Note: The queues mentioned above are HW MTL Queues and DMA
> >> Channels. The routing can be done in the HW itself based on vlan pcp
> >> before the packets reach to driver.
> > 
> > Is the normal way you would do this is like this:
> > 
> > tc qdisc add dev eth1 parent root handle 100 \
> > mqprio num_tc 4 \
> > map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
> > queues 1@0 1@1 1@2 1@3 \
> > hw 1
> > 
> > But you are saying that you cannot extend this to 5 queues?
> > 
> >     Andrew
> 

> Yes this can't extend to 5 queues. Because, stmmac in primary
> virtual machine will only have 4 netdev queues. So TC won't take
> input for 5th queue.

I still don't understand your architecture. How can you have 5 queues
if the physical hardware only has 4?

Is there any documentation for all this? Any datasheet?

   Andrew
