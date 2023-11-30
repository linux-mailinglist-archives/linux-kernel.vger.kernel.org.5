Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48B7FEC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjK3KNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjK3KNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:13:22 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DCF10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:13:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A12FE0003;
        Thu, 30 Nov 2023 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701339203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eul7P3tvqZcblHVJ8cWvUt7gAONNj5sKxayyAvBmU8s=;
        b=R4J9KlNtzPHRqq2mNgsahIwLfrF+RlJ0UHUDqd2PRMpNd0s6AeYuxukuY4M1Xvlzo+PT26
        ZkasPugB779XCn2A6G5pKSh6plLnPSLHMvR+fIfLicqEzoWW7yLjMHEDp9un4pBs1W1l7O
        Ob2ZuAs2MPNJKczx7dI/70pX7cvC3tNfSKGWtaJWhLvOKbRem75RnPMHUEDSuPbORCqJQ9
        w+MlivkSbtfTXE9aMDx3WL/IYrwQpS01WgzhhXdiAKHlPtWWBYSRsY5jY1jufhXTOQ1KNm
        DD7+rtVGjNGJN/ln4WZO1D9yb8X+L3hzYEES9kbk1tZ1dE/dMYwziAxxtDjg2Q==
Date:   Thu, 30 Nov 2023 11:13:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <20231130111321.3ce6a961@xps-13>
In-Reply-To: <20231129221225.387952-2-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-2-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:20 -0500:

> Add hotjoin entry in sys file system allow user enable/disable hotjoin
> feature.
>=20
> Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> Add api i3c_master_enable(disable)_hotjoin();
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master.c       | 84 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i3c/master.h |  5 +++
>  2 files changed, 89 insertions(+)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 08aeb69a78003..ed5e27cd20811 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -526,6 +526,89 @@ static ssize_t i2c_scl_frequency_show(struct device =
*dev,
>  }
>  static DEVICE_ATTR_RO(i2c_scl_frequency);
> =20
> +static int i3c_set_hotjoin(struct i3c_master_controller *master, bool en=
able)
> +{
> +	int ret;
> +
> +	if (!master ||
> +	    !master->ops ||
> +	    !master->ops->enable_hotjoin ||
> +	    !master->ops->disable_hotjoin
> +	   )

Style is wrong here (max limit is 100 chars and the ) should not be on
a new line)

> +		return -EINVAL;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +
> +	if (enable)
> +		ret =3D master->ops->enable_hotjoin(master);
> +	else
> +		ret =3D master->ops->disable_hotjoin(master);
> +
> +	master->hotjoin =3D enable;
> +
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return ret;
> +}
> +
> +static ssize_t hotjoin_store(struct device *dev, struct device_attribute=
 *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct i3c_bus *i3cbus =3D dev_to_i3cbus(dev);
> +	int ret;
> +	long res;
> +
> +	if (!i3cbus->cur_master)
> +		return -EINVAL;
> +
> +	if (kstrtol(buf, 10, &res))
> +		return -EINVAL;

Isn't there a better approach to get a y/n answer in sysfs?

> +
> +	ret =3D i3c_set_hotjoin(i3cbus->cur_master->common.master, !!res);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +

Thanks,
Miqu=C3=A8l
