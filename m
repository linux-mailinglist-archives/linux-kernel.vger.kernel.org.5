Return-Path: <linux-kernel+bounces-106731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30C87F2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1215B21FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DB59B76;
	Mon, 18 Mar 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="is62+UmF"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03159B55;
	Mon, 18 Mar 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799075; cv=none; b=UqLLz2kNNYRYuOfRtSlL/lSbJ+LFI8odI0/lpl2zeLTo+ZFv5H0eFQR+yL3Uo8cJ6dUIQmU5eb5loZYprSa/YKH4poYojScFMjmSDG35w85M1LvsUzOzC0KBD/8gPOaGDA9GW9zeupsOOPzWd9lA0M9jaaXd5ne1uMvyKsOnht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799075; c=relaxed/simple;
	bh=qNpju6VoTb4isozjyMSIQ3o9Nr+kUo/q7T3lZ7P3i44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soeFA0BAV/Jznb6rsUpg+wEAIr5SgH4qfkjpthayIkdjYunRnzTv3v7dElZV4FaoC13GTbA387+COj//cAks3mLk/i6XOaxNOVMgaBp95q6qrhnHvmta4gYxllJRl1dkA8KKrc1IB1UXk+6jEWNl3G37d4ju9vdkPgC9hURO1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=is62+UmF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710799056; x=1711403856; i=w_armin@gmx.de;
	bh=YDRrMRI32Ef/ZD85dcYlYcTDmp3Po/SC/dZeuWGol0Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=is62+UmF2hOxwb5jsGswbXa6XGVDlDwdBelqsg4AvSBsAHfSqbQwG0lqnXHfeZv4
	 JkfoZIdRQhu+vpRrZigMeX/IMBLWEaJvRTDUWGnGUjWuBC/GAONnMr/1TWyR8IEg2
	 FzSf2gVyvpmPm9w7s12X/jjUC5DEjopJbmiCaAPNjitgGlKDgPOeaVA/9DDxMGSli
	 u7t6rumT+NlNZo71FZE1IubHjiyZo88N2BLKUJC5QgJo++S8SNOCuJL2vJp/vluMc
	 Q2n4jhKtgL6OZ9GzPmyaV5T25yCXxCC077Izs9KZgAP018wojhVvOLcMlOkVh9CMm
	 ZKutOap9lKPj973bZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N95iR-1qk9YN0sH1-0163nY; Mon, 18 Mar 2024 22:57:36 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
Date: Mon, 18 Mar 2024 22:57:31 +0100
Message-Id: <20240318215732.322798-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ki1syntd+Vo7duJ/YyxqEcQwngJynPx+6JOcmhQ6e/5ZOdXZNWi
 WZsqtdrMeNT2AHV6R0f2Q5q4YdDOtQw+xWcAZKigHYrN+VnDAUm7IMTCL4IzvVydCAfwwGt
 NJe7w5YxglH+yGw2QO18lA/prPBCnrE/39qFJS3KVk0RBM1AtV8k0yios1BDYvTnuGjWqsV
 w/wAJw2jGdyCVQBc6elBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kFP78f19ung=;gUMT62CjLUZ/huU7GUZofGAAPGE
 6HFVGeIfMXqL6nqN3QVb019Z/j0PpGihpScoYcuQmuFOduyRMBrYV95JjfTOBRMfm/diWfKtX
 BruM4mHgWnRtiHr5/uhzsAhHbX9pT3gL55aVh6Jo0NnNZydx+YHm04bXSDe+AV82Xt4YxObrY
 xMKr0oeZ8gASOd9D2dLfUrzLySGGfrWUw8fueqT0Ud6fREQSMohysg1Tl9HA2x92DHJ3CEjrj
 z3UiGdSsM4e4yIwrP/WHlWJWSrs0eEPQDoJ8/IO//R1Ogv3N1lNkq/XfE2pid8t7fYrkKZ/Js
 Y02shqc2o5wjbP70Syf5Tx+EtA1L5mtk3B0ds/XxguvZ6DEYWcNl+9TD6i3sEio53dRc0DZvp
 vSSJXqhtpLCCU41llVNsbYA1EydbAvdPRwFtylbSePYkIwxN3fj9NsWlWGseEW7idBXF/7ENu
 BiHfcbFiMQXvAf3xz6E161v+S2PXFQiqVlt7yyE67dPUklVG0UqrT+YmQ9rqrhA1NWgyBavs9
 dQ29nQtGYdPwHCXW04F4R3Kp6V84QuFwAN9P3nenIbQSMNpjs/P1e2WMPZTbhdSKbVLUzH5C2
 vRO2J773gabevCsWswut5Vh6+QZAP/FDeILY7XFLSRFMhBIb4EppR46sp/TWumfbZgdQ51nhe
 LHU6tQUKkdQSsDz7g1EHZbGsZaiucJ5RkBb7P487yi6LxtZKWJ3LAT9E7pKcoDqgzr7u38bcW
 B56FHoWDC09upHAbyOlr8mqe07Qd/j7ABdXerv4Wd5ujpdOpt/6b4ztIgwXqeNow+X0ZnGMox
 dTtraAr8c91dau1FfdizttJWhrOg7tdT1j7w/KLuuw5OE=

Currently, the hp-wmi-sensors driver needs to be loaded manually
on supported machines. This however is unnecessary since the WMI
id table can be used to support autoloading.

However the driver might conflict with the hp-wmi driver since both
seem to use the same WMI GUID for registering notify handler.

I am thus submitting this patch as an RFC for now.

Armin Wolf (1):
  hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()

 drivers/hwmon/hp-wmi-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

=2D-
2.39.2


