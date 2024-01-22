Return-Path: <linux-kernel+bounces-34165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D08374DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADAE1C25EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022CE47F59;
	Mon, 22 Jan 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IpAtV/t8"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC247A6C;
	Mon, 22 Jan 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957652; cv=none; b=pHiLC7D8mh/Fqm+0vk+ZAKVtA4mSVvnFrGmB6yioYaCy44Ho8RJ8l+aI21gXWG+iSASDKpY7Qpp/x9RNkxxEHn8h8jrES6c7/SQnX109z0jQcJr5eeLR7Jn7lPxIJAsMvbat6ztKU9eqmwClA3sf82vGFrs3VIqXo1iNJzCQjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957652; c=relaxed/simple;
	bh=1XOSbykEqUUQSCdQydNqmiiDGdDbGfe7HfEwHvPi2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc5PUR7hyo1ZOoRuMoyToo1/FeWyLlOkjBAXMrngTKZlzcll8i3fVgZXSzNgljjZqdcqhSE+ANzCz8LtChwyQ+0Ug92cxsXLN/39ZeZyMc2uynr+DzRQgqH7PTbNciBYr8REDgp8ByOyszinfXcPUH81d4AGJa/9ov1a7zzwnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IpAtV/t8; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ML6lmG024542;
	Mon, 22 Jan 2024 21:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=5B3Ox/oe0H1oIjownqXHkO9GUdRiWejqb33wdY7F3CA=;
 b=IpAtV/t8wmVXT0eN1ck/aPLOnjuHRJw70ora0kSme+ghKpIyOp6wje+EXv7QOkOgN6HU
 zqrokRz+gY722mc8Iy2DNa6oyLkWmLDMEttpIz6hBxgXitWO3VqdrcbCgTiCl5Bv8Smc
 SeUE+nsxVlWmfiDiucLZi2KvRf2QDYhWSIfxMGCr2K3aa8lFnd9ITJZ44qXIbtEIzDET
 4v//BBqTs8RnGJhnjmTWbvVXOrU+ofBkDJlWSoHmBJg6ZViH/juImZHUd53luj925gPR
 rauInwLMQwVnpRMPVTGOmFvkn81aOOf5/W8InwfM6caf+hGRD45qJTB1UdeOn2C8Sb/C gg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vsp9te4bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 21:06:47 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0704913780;
	Mon, 22 Jan 2024 21:06:45 +0000 (UTC)
Received: from perchik (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8274A80A0F2;
	Mon, 22 Jan 2024 21:05:55 +0000 (UTC)
Date: Mon, 22 Jan 2024 14:05:53 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Message-ID: <20240122210553.GA2731@perchik>
Reply-To: Jerry.Hoemann@hpe.com
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
 <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: 42lPsTHy_FvCBKUGNWisWyAD5N2G08zB
X-Proofpoint-GUID: 42lPsTHy_FvCBKUGNWisWyAD5N2G08zB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220150

On Mon, Jan 22, 2024 at 09:39:27AM -0800, Guenter Roeck wrote:
> On 1/22/24 03:11, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > The RZ/G3S supports deep sleep states where power to most of the IP blocks
> > is cut off. To ensure proper working of the watchdog when resuming from
> > such states, the suspend function is stopping the watchdog and the resume
> > function is starting it. There is no need to configure the watchdog
> > in case the watchdog was stopped prior to starting suspend.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >   drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> > index 9333dc1a75ab..186796b739f7 100644
> > --- a/drivers/watchdog/rzg2l_wdt.c
> > +++ b/drivers/watchdog/rzg2l_wdt.c
> > @@ -279,6 +279,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
> >   	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
> >   	watchdog_set_drvdata(&priv->wdev, priv);
> > +	dev_set_drvdata(dev, priv);
> >   	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
> >   	if (ret)
> >   		return ret;
> > @@ -300,10 +301,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
> >   };
> >   MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
> > +static int rzg2l_wdt_suspend_late(struct device *dev)
> > +{
> > +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> > +
> > +	if (!watchdog_active(&priv->wdev))
> > +		return 0;
> > +
> > +	return rzg2l_wdt_stop(&priv->wdev);
> > +}
> > +
> > +static int rzg2l_wdt_resume_early(struct device *dev)
> > +{
> > +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> > +
> > +	if (!watchdog_active(&priv->wdev))
> > +		return 0;
> > +
> > +	return rzg2l_wdt_start(&priv->wdev);
> > +}
> > +
> > +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
> > +	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
> > +};
> > +
> >   static struct platform_driver rzg2l_wdt_driver = {
> >   	.driver = {
> >   		.name = "rzg2l_wdt",
> >   		.of_match_table = rzg2l_wdt_ids,
> > +		.pm = pm_ptr(&rzg2l_wdt_pm_ops),
> 
> I think this will create a build error if CONFIG_PM=n because rzg2l_wdt_pm_ops
> will be unused but is not marked with __maybe_unused. But then the driver won't be
> operational with CONFIG_PM=n, so I really wonder if it makes sense to include any
> such conditional code instead of making the driver depend on CONFIG_PM.
> 
> I really don't think it is desirable to suggest that the driver would work with
> CONFIG_PM=n if that isn't really true.
> 
> Guenter

Guenter,

I'm working on a similar patch.

Is your concern limited to the use of the "pm_ptr" macro?  Or is it
wider?

Thanks

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------

