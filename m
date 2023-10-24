Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970B7D4BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjJXJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJXJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:16:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CF133;
        Tue, 24 Oct 2023 02:16:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42A0660004;
        Tue, 24 Oct 2023 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698138974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=md6/yyZqKkyjUlet2bPLNG/W7nE8H467rQvEuNTnneo=;
        b=BXfZq//4KXiali7NIh5LYiazMLA56n3s3V/t1dnc7sGhlbBzgd80H8ksKkYdkb++IlGnvC
        tVUuGfQOfnKD28g+ViRq0MGt8wcTPf/moe4+SMB6UIuhYJcpbl+zbr2gtPX/EwlZMXIPsl
        FzT0unj13nA5QPdZJVyFA5u1713cK1kjQlQX/rIrP9zB/rzsi+vJggfr6Zx7JTbNi26/x3
        fPXErPC2j2Jvxlf12sqn4twV81QKVzEE2/nPGVJ4YJkP5EaLMn18nyNFRuBxnVDtq0o7sJ
        ZdgbeNB6UW+Ir1UKd2/HrGLcDtVlrHueSgm8KDMmtPEDoY+nVOwYfNpTW8cQSA==
Date:   Tue, 24 Oct 2023 11:16:27 +0200 (CEST)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
In-Reply-To: <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
Message-ID: <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-4-romain.gantois@bootlin.com> <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Mon, 23 Oct 2023, Andrew Lunn wrote:

[...]
> > +	struct qca8k_priv *priv = port->sw->priv;
> > +	struct ipqess_port_dump_ctx dump = {
> > +		.dev = dev,
> > +		.skb = skb,
> > +		.cb = cb,
> > +		.idx = *idx,
> > +	};
> 
> And with a little bit of refactoring, you should be able to use the
> core of qca8k_port_fdb_dump(). All that seems to differ is how you get
> to the struct qca8k_priv *priv.
> 
> That then makes me wounder if there is more code here which could be
> removed with a little refactoring of the DSA driver?

Yes, I think this should be possible for a few more functions, I'll look into it 
for the v2.

> > +static int ipqess_port_get_eeprom_len(struct net_device *dev)
> > +{
> > +	return 0;
> > +}
> 
> Is this actually useful? What does it default to if not provided? 42?

It's not, I'll remove it.

> 
> > +	for (c = 0; c < priv->info->mib_count; c++) {
> > +		mib = &ar8327_mib[c];
> > +		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
> > +
> > +		ret = qca8k_read(priv, reg, &val);
> > +		if (ret < 0)
> > +			continue;
> 
> Given the switch is built in, is this fast? The 8k driver avoids doing
> register reads for this.

Sorry, I don't quite understand what you mean. Are you referring to the existing 
QCA8k DSA driver? From what I've seen, it calls qca8k_get_ethtool_stats defined 
in qca8k-common.c and this uses the same register read.

Thanks,

Romain
