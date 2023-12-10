Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2096480B8F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjLJFVC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Dec 2023 00:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:20:59 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8193CD;
        Sat,  9 Dec 2023 21:20:57 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 15CDA8043;
        Sun, 10 Dec 2023 13:20:42 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 10 Dec
 2023 13:20:42 +0800
Received: from localhost.localdomain (180.75.243.157) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 10 Dec
 2023 13:20:38 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <andi.shyti@kernel.org>
CC:     <jisheng.teoh@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@amd.com>
Subject: Re: [PATCH v2] i2c: cadence: Add system suspend and resume PM support
Date:   Sun, 10 Dec 2023 13:20:17 +0800
Message-ID: <20231210052018.2063-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20231209205744.ehmthjvn7nuslvhd@zenone.zhora.eu>
References: <20231209205744.ehmthjvn7nuslvhd@zenone.zhora.eu>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.75.243.157]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2023 21:57:44 +0100
Andi Shyti <andi.shyti@kernel.org> wrote:

> Hi Ji Sheng,
>
> On Sat, Dec 09, 2023 at 09:15:16PM +0800, Ji Sheng Teoh wrote:
> > Enable device system suspend and resume PM support, and mark the
> > device state as suspended during system suspend to reject any data
> > transfer.
> >
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> > Changes since v1:
> > - Add missing err assignment in cdns_i2c_resume().
>
> thanks for the quick version update. However, while it's nice to
> see such prompt proactivity, we also need to allow more time for
> others to review your change.
>
> Next time, please give it a bit more time before sending out
> version 2. :-)
>

Thanks, will take note of that. 

> > ---
> >  drivers/i2c/busses/i2c-cadence.c | 33
> > ++++++++++++++++++++++++++++++++ 1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-cadence.c
> > b/drivers/i2c/busses/i2c-cadence.c index de3f58b60dce..4bb7d6756947
> > 100644 --- a/drivers/i2c/busses/i2c-cadence.c
> > +++ b/drivers/i2c/busses/i2c-cadence.c
> > @@ -1176,6 +1176,18 @@ static int __maybe_unused
> > cdns_i2c_runtime_suspend(struct device *dev) return 0;
> >  }
> >
> > +static int __maybe_unused cdns_i2c_suspend(struct device *dev)
> > +{
> > +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> > +
> > +	i2c_mark_adapter_suspended(&xi2c->adap);
> > +
> > +	if (!pm_runtime_status_suspended(dev))
> > +		return cdns_i2c_runtime_suspend(dev);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cdns_i2c_init -  Controller initialisation
> >   * @id:		Device private data structure
> > @@ -1219,7 +1231,28 @@ static int __maybe_unused
> > cdns_i2c_runtime_resume(struct device *dev) return 0;
> >  }
> >
> > +static int __maybe_unused cdns_i2c_resume(struct device *dev)
> > +{
>
> I am not really understanding what you are trying to do here:
>
> > +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	err = cdns_i2c_runtime_resume(dev);
>
> First you try to resume...
>
> > +	if (err)
> > +		return err;
> > +
> > +	if (pm_runtime_status_suspended(dev)) {
>
> ... then you check if you are suspended ...

This serves as a check and balance to ensure that when the system
resumes with device in runtime suspend state, we disable the clock
enabled in earlier cdns_i2c_runtime_resume() to ensure a balanced clock
reference count for subsequent runtime resume transition.
Similar implementation can be found in this commit:
https://github.com/torvalds/linux/commit/44c99904cf61f945d02ac9976ab10dd5ccaea393

>
> > +		err = cdns_i2c_runtime_suspend(dev);
>
> ... and suspend again? Shouldn't this be _resume()?
>
> Thanks,
[O> Andi
>
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	i2c_mark_adapter_resumed(&xi2c->adap);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct dev_pm_ops cdns_i2c_dev_pm_ops = {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_i2c_suspend,
> > cdns_i2c_resume) SET_RUNTIME_PM_OPS(cdns_i2c_runtime_suspend,
> >  			   cdns_i2c_runtime_resume, NULL)
> >  };
> > --
> > 2.25.1
> >
