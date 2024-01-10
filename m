Return-Path: <linux-kernel+bounces-22180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF81829A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A55285796
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D134879A;
	Wed, 10 Jan 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HVAgopfK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89048797
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704890794; x=1736426794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOI1de7t6pyVOs6jsOoRo4x39WzrGdDD2xRLy0QjDOY=;
  b=HVAgopfKJ3unPSMT3wLyeLVKXvyA5biGCmSTf+0e3QUN0b2BBaqRTgxj
   /Kuc6bX7TiipNWm5ZFKIMcW7zv+Up7/ZHFSOQ7fbbe3Qxw5UurkakL7gU
   1y5fWmY7WbRbB689tmzfXnOW04PpNV0DV9yq+yIuAXhOy0bYne9tkHdWd
   w0FGqwmOTlHa84wTVW2RUOTQINYaw4NOtjYBjuMhP0xOsI87sjuvqFzMV
   DXgnc0utL7GYAL5hqKKOIzzU7dqvg8pdb0apyGk2xd4yIJCJsBElPpHQn
   D58wC5VipYGk/X69Q9QwKlyeoIdLZCFjrXpY4NNNdoLhIBMqBtUvgynbk
   w==;
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="34829298"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jan 2024 13:46:31 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D807280075;
	Wed, 10 Jan 2024 13:46:31 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: debugfs: runtime resume a device when reading registers
Date: Wed, 10 Jan 2024 13:46:31 +0100
Message-ID: <7625183.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <3bc9c762-3573-4d8b-bfcf-6c8e91938dcd@sirena.org.uk>
References: <20240110095358.473663-1-alexander.stein@ew.tq-group.com> <3bc9c762-3573-4d8b-bfcf-6c8e91938dcd@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 10. Januar 2024, 13:23:17 CET schrieb Mark Brown:
> On Wed, Jan 10, 2024 at 10:53:58AM +0100, Alexander Stein wrote:
> > If the registers shall be read from device, runtime resume it in order
> > to enable a possiblly attached power domain before accessing the device.
>=20
> The idea is that the debugfs interface isn't supposed to be disruptive
> to the thing being debugged.  It would be better to detect if there will
> be problems and report the status as busy.

In my case the device is actually unused, runtime suspended, thus disabled=
=20
power domain. That's totally different to busy. In this case dumping the=20
registers is non-disruptive, unless you account enabling/disabling the powe=
r=20
domain as well. Any attached clock is already enabled/disabled, but power=20
domains are not.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



