Return-Path: <linux-kernel+bounces-12760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B190181F9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD6285393
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC2F4FA;
	Thu, 28 Dec 2023 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV24B82m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70900F4E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA57C433C7;
	Thu, 28 Dec 2023 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703777577;
	bh=LG5wfSfrHn99aGr2v7pF+1hWyoSHf6YdWgLzSdkpESY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bV24B82mQKHqGjRSKXLYULLUfp7zHybS5xhk1FSm3DTpIpcPnZRKHf9FlpCpbzNhr
	 k+uBiy+6ucOzWB8lI+gJok+Pl5pAPIWPsqVbsSnfQw+SJJfrCMaG0a+M0Q8znK6hgz
	 9so5rJKSAs651AWD1mN4hsbxBLZ+y47bpmjVGhWzbiLUizTHWrJtI0XMZQ/hMABNHK
	 s3cImwgPGu7aVK+H6Cm826b02aidEoMkd8LqTOompL4wMSPfcSgtxBYKb6tebA1sC2
	 4s3MQAoHBfTj8XGt/9CqQZsc3Y8qpu2RLDhwf05KxpIN/piBJvLWb24u6EeJtMwGN0
	 FAQ/FWD2Kl/RQ==
Date: Thu, 28 Dec 2023 16:32:54 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] firmware: turris-mox-rwtm: Convert to platform
 remove callback returning void
Message-ID: <20231228163254.72b770ba@dellmb>
In-Reply-To: <9074d1ad2e889425991fecad664781ae27b2418a.1703693980.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
	<9074d1ad2e889425991fecad664781ae27b2418a.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Dec 2023 17:26:34 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris=
-mox-rwtm.c
> index 2de0fb139ce1..31d962cdd6eb 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -554,7 +554,7 @@ static int turris_mox_rwtm_probe(struct platform_devi=
ce *pdev)
>  	return ret;
>  }
> =20
> -static int turris_mox_rwtm_remove(struct platform_device *pdev)
> +static void turris_mox_rwtm_remove(struct platform_device *pdev)
>  {
>  	struct mox_rwtm *rwtm =3D platform_get_drvdata(pdev);
> =20
> @@ -562,8 +562,6 @@ static int turris_mox_rwtm_remove(struct platform_dev=
ice *pdev)
>  	sysfs_remove_files(rwtm_to_kobj(rwtm), mox_rwtm_attrs);
>  	kobject_put(rwtm_to_kobj(rwtm));
>  	mbox_free_channel(rwtm->mbox);
> -
> -	return 0;
>  }
> =20
>  static const struct of_device_id turris_mox_rwtm_match[] =3D {
> @@ -576,7 +574,7 @@ MODULE_DEVICE_TABLE(of, turris_mox_rwtm_match);
> =20
>  static struct platform_driver turris_mox_rwtm_driver =3D {
>  	.probe	=3D turris_mox_rwtm_probe,
> -	.remove	=3D turris_mox_rwtm_remove,
> +	.remove_new =3D turris_mox_rwtm_remove,
>  	.driver	=3D {
>  		.name		=3D DRIVER_NAME,
>  		.of_match_table	=3D turris_mox_rwtm_match,

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

