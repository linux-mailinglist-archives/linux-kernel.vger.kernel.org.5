Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7D7BFBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjJJMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjJJMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:55:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC5B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:55:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqCGq-0007t3-2T; Tue, 10 Oct 2023 14:55:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qqCGp-000fQw-9f; Tue, 10 Oct 2023 14:55:31 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqCGp-00Djkg-7K; Tue, 10 Oct 2023 14:55:31 +0200
Date:   Tue, 10 Oct 2023 14:55:31 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <20231010125531.GA3268051@pengutronix.de>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 01:19:36PM +0100, Mark Brown wrote:
> On Tue, Oct 10, 2023 at 10:59:06AM +0200, Oleksij Rempel wrote:
> > Add handler to forward under-voltage events.
> > On systems for more or less complicated regulator chains we need to
> > forward under-voltage events to actual driver which need to react on
> > them.
> 
> It isn't clear to me why this would be implemented in one specific
> driver, nor why this would be done unconditionally.  Could you provide
> some information on the problem you're trying to solve here?

The hardware I am working with has an under-voltage sensor on the 24V
supply regulator and some backup capacitors to run SoC for 100ms. I want
to forward under-voltage events across a chain of different regulators
to a designated consumer. For instance, to the mmc driver, enabling it
to initiate shutdown before power loss occurs.  Additionally, a bit can
be set in the volatile memory of a scratch pad in an RTC clock to record
sudden power loss, which can be checked on the next system start.

> This feels like something that should be a core feature.

Agreed. I am relatively new to the regulator framework and am uncertain
about the optimal location for registering the event forwarding. Could
you advise on this?

> > +static int reg_fixed_regulator_notifier(struct notifier_block *nb,
> > +					unsigned long event, void *data)
> > +{
> > +	struct fixed_voltage_data *priv =
> > +		container_of(nb, struct fixed_voltage_data, nb);
> > +	struct regulator_dev *rdev = priv->dev;
> > +
> > +	if (event != REGULATOR_EVENT_UNDER_VOLTAGE_WARN &&
> > +	    event != REGULATOR_EVENT_UNDER_VOLTAGE)
> > +		return NOTIFY_OK;
> > +
> > +	regulator_notifier_call_chain(rdev, event, NULL);
> 
> This would be better written as a switch statement for extensibility,

ack.

> and it's not clear why the filtering?

I started with a conservative approach because I'm not sure about the
possible effects of forwarding all events. If forwarding all events is a
good idea, I can do it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
