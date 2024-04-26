Return-Path: <linux-kernel+bounces-160587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2308B3FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0601C21216
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB818BE47;
	Fri, 26 Apr 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="axkDQcPp"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F47470;
	Fri, 26 Apr 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157601; cv=none; b=SOQK1UXx2oQCNWW1Sx58gxl8I+HJDifNaLpVwR7WReVwowx4BE7wNtLkbYQ1eqPieXNcYog8808VwZJRs4AHGuwGneQLV2nlX4Gz3RWJZ2KNIxDy/iSu0zIjuaBS4IBFOgDUKk2BmALo3e0F4R+dJgyCTEC8ZnqbXO99SerEhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157601; c=relaxed/simple;
	bh=LYrhv94fXfJc/xrjaftEa5kLjlw/Ms5LsmooEzuSh+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkvY9y5uiUcHgiEDGVYEIFd2vxYGJDN3k6mPBdB7Au2ionxGRZPg1HZqmtqQy9kwGr77h2miz9opye2lH4gv3Ty4ZO9RNTYvMAasBlE9Z2xPHg5VLGIjOUs4ZTLmj/yGqCQo6EN4pXBfXZ798tRcJD3syGhF5tj8hfgpNm4nK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=axkDQcPp; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s0Qh1-002ipf-0T;
	Fri, 26 Apr 2024 20:53:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nPehlEQTssGP0G33zMbxlvgJ6Z2DjBR7Px27U6BzRnk=; b=axkDQcPpzxZxap1pRfnjMJ3Bvs
	SJ0bDsZcQes8UzO6Oq2PTXvieDtFtY2/iJjljFu81inca4zfw1nwEHG2mSeGPTea2726RPnfjW5if
	9E4fcyg2V8R39/9ragSmJN+jsab5mA8DvKrzgYiwH29rDQCc2CXBPDjpxSq4DdIKDV99pp4l5zbBh
	thwc6/gkj4vtS5NbbZCof5SqVL1BqaDhqp2DaV9A+09sEWzYRNoJrAKJCKHzs55vqjI74bUG8I2A0
	AciL7VnUxww0SWxXf1BJ3wjbdK80gC6eMfOKy8L1GP3A5SChDrDZ/wao8yqjtiz95QJxsz68Q3BUC
	0deG5kdg==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s0Qgx-0005ao-0p;
	Fri, 26 Apr 2024 20:53:04 +0200
Date: Fri, 26 Apr 2024 20:53:02 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Felix Kaechele <felix@kaechele.ca>, dmitry.torokhov@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <20240426205302.4acbdb11@aktux>
In-Reply-To: <CAHp75VdA_peJBWXFWSs-vDxA86y6MG0J7ixzXExqDxJJzfJ7mA@mail.gmail.com>
References: <20240404222009.670685-1-andreas@kemnade.info>
	<20240404222009.670685-3-andreas@kemnade.info>
	<CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
	<20240405182832.4e457695@aktux>
	<CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
	<20240425185417.0a5f9c19@aktux>
	<7dd1eb70-b011-4247-aea9-173ddcd17dc7@kaechele.ca>
	<20240426095617.4e442681@aktux>
	<CAHp75VdA_peJBWXFWSs-vDxA86y6MG0J7ixzXExqDxJJzfJ7mA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 26 Apr 2024 16:51:59 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > I think focaltech,ft5406 is better because it is consistent with other drivers/
> > bindings. We do not specify the display it is used on on other touchscreen
> > bindings. We do not specify the actual LEDs behind a LED interface chip.
> > And often the chip name is more easily to find out than the name of a
> > display.  
> 
> I'm _not_ a DT person, you should clarify this with them. I just
> pointed out the possible mistake (from Linux / DT perspective), and
> not hardware / business related one. If they are fine with focaltech
> prefix, then it's fine to me as well!

as 1/2 is Acked-by DT, I think the compatible is fine, so I will probably
just send a v3 with a sorted 2/2.

Regards,
Andreas

