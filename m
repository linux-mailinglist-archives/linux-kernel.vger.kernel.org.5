Return-Path: <linux-kernel+bounces-100467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB418797E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07A3282027
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7F7CF01;
	Tue, 12 Mar 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ln2Ui+Nm"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504007C6D6;
	Tue, 12 Mar 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258335; cv=none; b=PC7NEogFKcdFnjOpBPXcj+3BDnX9PaZWhL6hekbKvPVHoUT3+BUJvGYhvL6dteDWOBjcoup6Br7GTJbcpJQGDTsvQnEvFDD6Pzofv72sRnBOBP29XAATrMLqEn5UIZm79UZ9RrA6o1/QRn1258J5EwfPQ4cVKqUpOEAed3CWfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258335; c=relaxed/simple;
	bh=plViXgocX+43FaFVTkiMAQknhg2JZxGAilsVKhvdKAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2MYBNOIWfwYZg4timqI6782OwP/c2VJ0d//d0byDgxn09mdZgai5zL7MLrt6nIyUlicJp4dyq96IsW0xz7PfLJBru5GVAO8OeG85pruJk/RgiMquke+GGoYpW+X0+pXIo3pvJUG0XmCrFP26mYYFHxifltjoVyWApi2ctf4Zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ln2Ui+Nm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42CE6240004;
	Tue, 12 Mar 2024 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710258328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plViXgocX+43FaFVTkiMAQknhg2JZxGAilsVKhvdKAk=;
	b=Ln2Ui+NmcUK/CDH0MoZtYntEKO5E7fhSSA5YIBgdEajx0GBy6VQvfTz4y2ZgbDybP/ruPd
	+LL/SNBbO1lALCSNU6lMI1MxdqdT4HBr3lEIE9vujPy609D4g3kP8x2xXUYIoIfpnx4MX7
	U95J13boUNeOCw8NDAnFj9hcv+bu+EGXYObP1wdbVwniZH4j0LZk268E61rzhdJATID5/J
	w+dMNTtdn1yBVkmkrHwxjyLzImO2iM75OEss1rBJyEriwXA9bc0o/0lBoczmYDTLC57fXA
	NLdQlYOUgs49UYWYqO/sQXZxFRqAkzpWhSqFZ95koU1qw118qyPSAKq9SJ6vhg==
Date: Tue, 12 Mar 2024 16:45:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <taras.chornyi@plvision.eu>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <andrew@lunn.ch>, <thomas.petazzoni@bootlin.com>,
 <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] net: marvell: prestera: fix memory use after free
Message-ID: <20240312164526.4a0e242a@kmaincent-XPS-13-7390>
In-Reply-To: <20240311135112.2642491-3-enachman@marvell.com>
References: <20240311135112.2642491-1-enachman@marvell.com>
	<20240311135112.2642491-3-enachman@marvell.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 11 Mar 2024 15:51:11 +0200
Elad Nachman <enachman@marvell.com> wrote:

> From: Elad Nachman <enachman@marvell.com>
>=20
> Prestera driver routing module cleanup process would
> release memory and then reference it again, and eventually
> free it again.
> Remove the redundant first memory free call.
> All such double free calls were detected using KASAN.
=20
Not directly related to this patch but I am wondering if
the call to prestera_port_sfp_unbind(port) is not missing in
prestera_destroy_ports() function?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

