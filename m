Return-Path: <linux-kernel+bounces-153402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D88ACDB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9448F1F21881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AF14EC6E;
	Mon, 22 Apr 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hSpp75hS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6E746E;
	Mon, 22 Apr 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790964; cv=none; b=YHOgNZSVNwGgl0WepwPNEIt50LwE++A13wQcvtOymfC9bQ3YJGEAxEPVXRpwBgaD0L60g3XItmvAHdT1S9mnbDu+sB/TH7kDj8Lr0LS/6tvJ9i53lg2VPpt4zgXLnb3RoksUGyeergTGytGr6CnMQeEXJ0MQ+tLr7ALsfaVHCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790964; c=relaxed/simple;
	bh=mjvoOzaTFjWROlqsoo/N+O/73K5m1NYdZJQC+IKoWcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVwy61f3Szo/rDY7V9e7au1+eSFtqjsD2gAPkFpd5veQWqVLZ9w3JT+SJSd2R9HiRICJjvOdCcZbV764NZlCgKl4TZ9WzZ8adlRvg6VjsEmZ+ikleQQb71HGq4UmONfA/sbayeRyWl3fsc6OEmM47TEy31rKN8qhFUJVD15kvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hSpp75hS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39F811BF210;
	Mon, 22 Apr 2024 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjvoOzaTFjWROlqsoo/N+O/73K5m1NYdZJQC+IKoWcg=;
	b=hSpp75hSW2gl+9p/T6r8yIn09H6zspYCJQz5ZjpoCYj7dAdGceijGtARjWgSLi0GbVFCxp
	/47HqIvC8qqvRb4H6EYfod6Ig1stdF1Y8iWfjeKg2qm3TwCZPavYD8kcV1hI/kDG7IklI+
	56xOLIxj29B7wDKQZrZ52+DFwOS9kEDylPhcMdWpnb5wzoJjVk5lEQ/dgxjkJ20Doon/mE
	YeYLDRNxX/HdI+x6pv53zMChGAzCRD7ymA7+mk3WvZC4bpOXG2HqhkouUQFOFdvFDPLYFB
	k3519rEZ5+q+hoPkXpniJAwEloSfvkTIWWi7BSd90cjmGufz2yYVb3yE+FzErA==
Date: Mon, 22 Apr 2024 15:02:34 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240422150234.49d98b73@kmaincent-XPS-13-7390>
In-Reply-To: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 22 Apr 2024 14:50:47 +0200
"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This patch series fix few issues in PSE net subsystem like Regulator
> dependency, PSE regulator type and kernel Documentation.
>=20
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Found out I had a git configuration that adds "Dent Project" to my sob. I d=
on't
want that, and will send a v2 without it.=20
I will wait a week for review before the v2, so please do not merge this
version.
Sorry for the noise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

