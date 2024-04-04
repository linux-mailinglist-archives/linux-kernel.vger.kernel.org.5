Return-Path: <linux-kernel+bounces-131756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB72898B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BAA2857BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E03130A75;
	Thu,  4 Apr 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="qNLSmref"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8F12D201
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245560; cv=none; b=mRlucadWC/j2GcjquL1V1nBKzSMLlqdDQC0leDUu6sUgAhHsIGXh2PSaQs91SbGvgLD5tlrt0FRQHLihXd4OL43KMDdaQnvCeAql6omMW8shUWKWkYoWUVNu4GPaz3nLYmFePe2GyuReXx07l0JEoO3sSnnvyIr2PpXptQiG6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245560; c=relaxed/simple;
	bh=V+BaP2zrTv89x+ZBF7s9sNGQw6eDlrnEsWuv94n6T0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6rlGJWXHP4SEj5/cEefj3yCEfjARkCWSuRLY2nSIQymj75zz3bWeTFfas5WznbZAht2K07tMNNRFXatAeeSNKHFuFfzeraKrV+QNAMZw3nU6+jiUADyefYjj2BwOSb/og8aCApQkkZzjH+hcVU5EgpKZBMv9xA8as2RiAQAkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=qNLSmref; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712245537; x=1712850337; i=efault@gmx.de;
	bh=U/0UEqyk/SaT4Eovs2YQJ7h/qwf7tAv48BQiWSsgux0=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=qNLSmrefFGoSHcYkKoAMin6UbmQe6uI18spKesmfJF2O5XQRn2UoRk2F/gGC0dPC
	 Sj2Bp4xgNayc/cXiHZHfpAM404G0xkqTMOCHa59PMsR5IpKj1OPkacsqRKJOTHoeJ
	 JrZw8ZRrC3Fyx4Fe8WDlCzVZulDH1WZuc7HSpTllgikA00dvbZs1kapezc7+ByHLv
	 5W0dP//PjPmD5Pzv+5MtiKyR/0rByUBbqzm7YdBfGmLuYumwx/eeZkXFCpnx5LRqr
	 aCaCrhpWJne4nYYTYVzmXwFrMe4LvUI0andApkNJh8i8UXh1BNeYpPLjLWHuf8mYH
	 quc5N8Q6+I1XKD52ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.51.26]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1sIDch0vhK-00R5Cj; Thu, 04
 Apr 2024 17:45:37 +0200
Message-ID: <a702e9e545760606304a8700ee92aa5a9f01d104.camel@gmx.de>
Subject: Re: [patchlet] locking: fix trivial f70405afc99b RT build breakage
From: Mike Galbraith <efault@gmx.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 04 Apr 2024 17:45:36 +0200
In-Reply-To: <Zg6hFEQPnP3KIwQ0@casper.infradead.org>
References: <68731eaeb522ced5319e3c1e45f03cdca5c8fd2a.camel@gmx.de>
	 <Zg6hFEQPnP3KIwQ0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QkH70hYP7MbC0BOvzPCloN/EjVICs/mvPlPyC256MrbzOpNCRoZ
 vjnaHwcuQ29P5RWL4dLMmRtK6BdRyH2CYZhJvlIZOdDJ9HKh06gzRRSon8Ua2B/2fXBT/QB
 58wyMBfOgAgbCSS/BCDdSwGbTqCUl72Ziy2zSPbAnYQcT1fGREI/hCJs7IKEviCd8TS6VRR
 wFsprmx+F7nXdtshCCu3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NNU8VxTnTHM=;Ygs5PMN6WS7U2OVrL/iHn5NOrRp
 ZRkWBmYUr8USw+wHtvVFC+BvICS+SpBSgNr4r3k3DD7Y2vyweKTEifjaAlm6U+BXT3nXxvlVo
 pjE5KH4gDaTqmmi1lAMYYCW8I05v1KI9LUUmNBFnuF+5UUC9Krr1sEyfZIdV0ubR9T1td5nbz
 Lb6O1pgNR8tWu0hO2dC7ret+0I5lyVr0xSwiMyUlfOgCKpzSNpgN93ztKgj/1iAIPmEAssK5U
 umfbhFGUBbE/6Ro4QX2ht6jvpJS5ikZ/4j82CLUeSuUt/XnCW+ADbfjvbAbp5331DwSte2fxq
 WWEP94IYwbZ+Ng7A5bSJxHFpsFEiEplScqNEsc/X8/igV5IdRHvyg4mA0SzaNE8y49dDRMDJ+
 S8OLHCLh8aSc8RwdhaLNeCExw4ZBcKMo52PVFrJQ/JutYY9UK7bHTPiMQ8z4luSaQnkuu3X/g
 R7+Tn99+FdpAz2axOT0N9KfQgKzVFOILHvhWM1bh3bojWeYOLlBLdmM0WcX71Ha53iDVW9v4q
 QUdyL42VnUhyOWdWo1hLxAhI6z0kIzFSxpVgh/X2xDOI6dhwKPP6CfFqrl7kKEtwoy/d6nS6d
 M+dmrzJR+ltR/je/3ZRn+wi3P+FyLOCdv9HkXzL255jW4fPE92aHG/8gD7L0EkxnBJOgDwXfn
 AMSdbGDgr4O+xVPHX6ZbUnDS59zlmX4SvU+g/yhVa6Axu1KiDRMVNJPxeKRZ13yKOtQAVz9qX
 OmItReVURKNUTuGB8HyqksUuT+YzTJM+ipC7M3HDkVjKztwBNm8HfTsk/dMNO1SD4PJVbI2ue
 1+16bcxeTZlnhSyyFeVlVbY547Y3kQiKWc71BU2jFdLA8=

On Thu, 2024-04-04 at 13:46 +0100, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 07:02:41AM +0200, Mike Galbraith wrote:
> >
> > Two trivial RT build issues arrived along with f70405afc99b: WARN_ON()=
 being
> > undefined as added to include/linux/rwbase_rt.h, and the wrong paramet=
er (typo)
> > being passed to rw_base_assert_held_write().
> >
> > Fixes: f70405afc99b ("locking: Add rwsem_assert_held() and rwsem_asser=
t_held_write()")
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
>
> Is Sebastian's patch not merged yet?
>
> https://lore.kernel.org/lkml/20240319182050.U4AzUF3I@linutronix.de/

Ah, known issue.  Neeevermind.

	-Mike
>

