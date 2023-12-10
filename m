Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2880BA8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjLJLyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:54:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C999
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:54:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B7CC433C7;
        Sun, 10 Dec 2023 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702209258;
        bh=VcO895aojfnwILlplXsvhD/oc+9HK3LQQDHWerPGqLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAUlHc1uSvYUyDeIsd3y5qj6MWZwM6fbj9FGyK+HvJTSFrEbZCgdq+uVwyuEP/412
         wtXPehU1VmhFvzKOJYCr0Zeh2X0TOcjzb8aFB5H4Ba0C1qsVFdpGoeEhg3dUbOxGAM
         E6mWJfU2x6Prt2EEseU2ZKMCsOyNAFa6WcVwZoHdoQMXNOVmc5DOurN1oVDvwyNh5V
         4LkiPwSnum1kbC8Fw2edcyHQ24o1WNqhvrwaL3TQEDCZaDoTcfsUbwcSI0YF9KFP2M
         HrfIPstbSH2DMy83MxrH1Z4zR3acACR45eXCzx2xUv2deeMeCXArEeJt3/DBjoPq0E
         K5CTmExcA5tpw==
Date:   Sun, 10 Dec 2023 12:54:12 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     leyfoon.tan@starfivetech.com, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com
Subject: Re: [PATCH v2] i2c: cadence: Add system suspend and resume PM support
Message-ID: <20231210115412.hztjrubacnmenbvz@zenone.zhora.eu>
References: <20231209205744.ehmthjvn7nuslvhd@zenone.zhora.eu>
 <20231210052018.2063-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231210052018.2063-1-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji Sheng,

[...]

> > > +static int __maybe_unused cdns_i2c_resume(struct device *dev)
> > > +{
> >
> > I am not really understanding what you are trying to do here:
> >
> > > +	struct cdns_i2c *xi2c =3D dev_get_drvdata(dev);
> > > +	int err;
> > > +
> > > +	err =3D cdns_i2c_runtime_resume(dev);
> >
> > First you try to resume...
> >
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (pm_runtime_status_suspended(dev)) {
> >
> > ... then you check if you are suspended ...
>=20
> This serves as a check and balance to ensure that when the system
> resumes with device in runtime suspend state, we disable the clock
> enabled in earlier cdns_i2c_runtime_resume() to ensure a balanced clock
> reference count for subsequent runtime resume transition.
> Similar implementation can be found in this commit:
> https://github.com/torvalds/linux/commit/44c99904cf61f945d02ac9976ab10dd5=
ccaea393

OK, this is done purely for clock balancing, but then, I still
don't understand the case. I expect the clock counter to be
unbalanced when you suspend (because is moving towards '0').

While, if you check if the clock is unbalanced when resuming, it
means that the clock had a negative counter (which is impossible
because the clock counter is unsigned).

If there is any unbalancing at this stage, then I recommend you
to check what has happened previously.

=2E.. Or is there anything I am missing?

Thanks,
Andi

> > > +		err =3D cdns_i2c_runtime_suspend(dev);
> >
> > ... and suspend again? Shouldn't this be _resume()?
> >
> > Thanks,
> =1B[O> Andi
> >
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	i2c_mark_adapter_resumed(&xi2c->adap);
> > > +
> > > +	return 0;
> > > +}
