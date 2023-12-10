Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296C80BC28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjLJQVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Dec 2023 11:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 11:21:50 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84354FA;
        Sun, 10 Dec 2023 08:21:52 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A5F2C24DB84;
        Mon, 11 Dec 2023 00:21:49 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Dec
 2023 00:21:49 +0800
Received: from localhost.localdomain (42.189.171.87) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Dec
 2023 00:21:44 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <andi.shyti@kernel.org>
CC:     <jisheng.teoh@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@amd.com>
Subject: Re: [PATCH v2] i2c: cadence: Add system suspend and resume PM support
Date:   Mon, 11 Dec 2023 00:21:19 +0800
Message-ID: <20231210162119.364-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20231210115412.hztjrubacnmenbvz@zenone.zhora.eu>
References: <20231210115412.hztjrubacnmenbvz@zenone.zhora.eu>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [42.189.171.87]
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

On Sun, 10 Dec 2023 12:54:12 +0100
Andi Shyti <andi.shyti@kernel.org> wrote:

> Hi Ji Sheng,
> 
> [...]
> 
> > > > +static int __maybe_unused cdns_i2c_resume(struct device *dev)
> > > > +{  
> > >
> > > I am not really understanding what you are trying to do here:
> > >  
> > > > +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> > > > +	int err;
> > > > +
> > > > +	err = cdns_i2c_runtime_resume(dev);  
> > >
> > > First you try to resume...
> > >  
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	if (pm_runtime_status_suspended(dev)) {  
> > >
> > > ... then you check if you are suspended ...  
> > 
> > This serves as a check and balance to ensure that when the system
> > resumes with device in runtime suspend state, we disable the clock
> > enabled in earlier cdns_i2c_runtime_resume() to ensure a balanced
> > clock reference count for subsequent runtime resume transition.
> > Similar implementation can be found in this commit:
> > https://github.com/torvalds/linux/commit/44c99904cf61f945d02ac9976ab10dd5ccaea393
> >  
> 
> OK, this is done purely for clock balancing, but then, I still
> don't understand the case. I expect the clock counter to be
> unbalanced when you suspend (because is moving towards '0').
> 
> While, if you check if the clock is unbalanced when resuming, it
> means that the clock had a negative counter (which is impossible
> because the clock counter is unsigned).
> 
> If there is any unbalancing at this stage, then I recommend you
> to check what has happened previously.
> 
> ... Or is there anything I am missing?
> 
> Thanks,
> Andi

You are right, the clock counter will move towards 0 during system
suspend.
Conversely during system resume, the clock counter is incremented to 1
early on in cdns_i2c_runtime_resume(). So the clock counter is not
negative to start with. 
At this point of time, clock counter is 1. If the device is in runtime
suspend, we decrement the clock counter back to 0, so the subsequent
runtime resume could increment it back to 1. In a sense, balancing the
clock counter.
Please help correct me if I've got it wrong.

> 
> > > > +		err = cdns_i2c_runtime_suspend(dev);  
> > >
> > > ... and suspend again? Shouldn't this be _resume()?
> > >
> > > Thanks,
> > > Andi
> > >  
> > > > +		if (err)
> > > > +			return err;
> > > > +	}
> > > > +
> > > > +	i2c_mark_adapter_resumed(&xi2c->adap);
> > > > +
> > > > +	return 0;
> > > > +}  


