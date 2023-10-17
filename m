Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67777CC3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjJQM74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjJQM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:59:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2383;
        Tue, 17 Oct 2023 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=zPjdrkr74mlf+FJnNvMTzPhWfY7AUc/QDIF1M/76zDI=; b=evtJntTpQ/WnWp851YRxlVQ5KV
        oa1x2BQXAch/mp8d4kVlMUgXCz0hUc5mOmlueYzEHEpTWdmUe0kE+oLGDqW9XQyCAvah9q7Yf9x/v
        VIlp0WkVLNjVS7zJigWkHIybz8obdhTLF1JCfZr0UAaFAkoYIKEAfnhcQlNwTtGdSo5o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qsjfm-002Tox-8f; Tue, 17 Oct 2023 14:59:46 +0200
Date:   Tue, 17 Oct 2023 14:59:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <8e1fb87d-b611-49f3-8091-a15b29e03659@lunn.ch>
References: <20231012-unicorn-rambling-55dc66b78f2f@spud>
 <20231016075349.18792-1-ante.knezic@helmholz.de>
 <20231017-generous-botanical-28436c5ba13a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-generous-botanical-28436c5ba13a@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The switch always provides it's own external reference, wut? Why would
> anyone actually bother doing this instead of just using the internal
> reference?

I think you are getting provider and consumer mixed up.

Lets simplify to just a MAC and a PHY. There needs to be a shared
clock between these two. Sometimes the PHY is the provider and the MAC
is the consumer, sometimes the MAC is the provider, and the PHY is the
consumer. Sometimes the hardware gives you no choices, sometimes it
does. Sometimes a third party provides the clock, and both are
consumers.

With the KSZ, we are talking about a switch, so there are multiple
MACs and PHYs. They can all share the same clock, so long as you have
one provider, and the rest are consumers. Or each pair can figure out
its provider/consumer etc.

How this is described in DT has evolved over time. We don't have clean
clock provider/consumer relationships. The PHYs and MACs are generally
not CCF consumers/providers. They just have a property to enable the
to output a clock, or maybe a property to disable the clock output in
order to save power. There are a few exceptions, but that tends to be
where the clock provider is already CCF clock, e.g. a SoC clock.

      Andrew
