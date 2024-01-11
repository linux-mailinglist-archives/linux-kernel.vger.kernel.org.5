Return-Path: <linux-kernel+bounces-23345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53A82AB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9102849F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C9125CA;
	Thu, 11 Jan 2024 09:56:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDE11C85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rNrnl-000540-5w; Thu, 11 Jan 2024 10:56:41 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rNrnj-001tes-B4; Thu, 11 Jan 2024 10:56:39 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rNrnj-00AavJ-0p;
	Thu, 11 Jan 2024 10:56:39 +0100
Date: Thu, 11 Jan 2024 10:56:39 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Message-ID: <ZZ-7V2bGL3c1RuZw@pengutronix.de>
References: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On Fri, Oct 20, 2023 at 04:13:37PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
> So limit the len to 4 will report "invalid range data" for i.MX93.
> 
> This patch drop the local array with allocated ttrcr array and
> able to support larger tmu ranges.
> 
> Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index ccc2eea7f9f5..404f01cca4da 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -57,6 +57,9 @@
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> +#define NUM_TTRCR_V1	4
> +#define NUM_TTRCR_MAX	16
> +
>  #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
>  						   * Register n
>  						   */
> @@ -71,6 +74,7 @@ struct qoriq_sensor {
>  
>  struct qoriq_tmu_data {
>  	int ver;
> +	u32 ttrcr[NUM_TTRCR_MAX];
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	struct qoriq_sensor	sensor[SITES_MAX];
> @@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device *dev,
>  				 struct qoriq_tmu_data *data)
>  {
>  	int i, val, len;
> -	u32 range[4];

Why don't you keep the array locally on the stack? Will it be needed
elsewhere later?

Other than that:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Would be great if this could be picked up anytime soon.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

