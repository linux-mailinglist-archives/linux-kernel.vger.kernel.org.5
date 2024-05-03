Return-Path: <linux-kernel+bounces-167516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C18BAAA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DF28514F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE5152189;
	Fri,  3 May 2024 10:19:42 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54914F9FD;
	Fri,  3 May 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731582; cv=none; b=TKQAO6S3iH9rOfu8lNKzMn3/WqRreyZSIiQ3qufeeVAkjcmaI72ucYHH2wHMHjd4ppNm7xuvx34eYm++K5m4SzIgGKYOiTEQNuBFHJxhRzZFj2uxlVwa2nSWkH38uNuYuDuTTxXKi4rf7g1kYq36bcrZa4Z1P90yVqVagHU6QJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731582; c=relaxed/simple;
	bh=CwbRZryxDvSIlBPZ/SNUliy+TfASd/RcVyRRmY5+U0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ua6H5g3ph9wHFWcr13aASpx84S70zdFMV/ZOL/8EKEE98/g7OJDYnrA1dkKqLdr5MRdcvmbAiSaScLaMDlrVnonBY9J9TU/2GxrpRbRUi3tkce1MMosJZH2q2esvUBvxNNOt0V0V/W+n6VturY2CcpxrM6/OEIOwI8f09vGgNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 443AJ5byC3408017, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 443AJ5byC3408017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 18:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 18:19:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 18:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 3 May 2024 18:19:05 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHanHHZpNHx0voP+0CDD26jysJVP7GEr5aAgACdBfA=
Date: Fri, 3 May 2024 10:19:05 +0000
Message-ID: <3199bfed19ad4e0bb8ca868b6c46588a@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
 <20240503085257.GM2821784@kernel.org>
In-Reply-To: <20240503085257.GM2821784@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Thu, May 02, 2024 at 05:18:36PM +0800, Justin Lai wrote:
> > Implement the .ndo_open function to set default hardware settings and
> > initialize the descriptor ring and interrupts. Among them, when
> > requesting irq, because the first group of interrupts needs to process
> > more events, the overall structure will be different from other groups
> > of interrupts, so it needs to be processed separately.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Hi Justin,
>=20
> some minor feedback from my side.
>=20
> > +static int rtase_open(struct net_device *dev) {
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     struct rtase_int_vector *ivec =3D &tp->int_vector[0];
> > +     const struct pci_dev *pdev =3D tp->pdev;
> > +     u16 i, j;
> > +     int ret;
>=20
> nit: please use reverse xmas tree order - longest line to shortest -
>      for local variable declarations in new Networking code.
>=20
Hi Simon,
This is partly because ivec needs to use tp for initialization,
so tp is placed in front of ivec, causing this situation.

