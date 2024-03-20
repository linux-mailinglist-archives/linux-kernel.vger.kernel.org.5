Return-Path: <linux-kernel+bounces-109018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E993C88136C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A33CB22CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5348792;
	Wed, 20 Mar 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="cMBNmGSu"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F24482D8;
	Wed, 20 Mar 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945410; cv=none; b=NEVkO3X88OFQ8JR/UpQF1NleH1oEsVwbNgGcdbQZB5//AEHgse78rp4cAA5sr+fdOoWrKw3h9LTw0+Db13KdYZPaR+fNVLR0zXkd41F0I7kBBoV4XormbHNW3hEKSLEmY5Doz/Xh7hLL5pUnQPExiOb7sJNHYGL/Y/nSooTvzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945410; c=relaxed/simple;
	bh=mfL4lpZfvM7BlCtt4ST58fKYcVjZ6oDkZO2yKupDzdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vg4CYyqjDPd+pmAC//h/RrTasQqyGUsbCOqIyX7VyCPxMqG2PLxvbarIgYjtEeRLqh1RbFILKmZ1jkV/BT6w6uHSeLpMZFPOPku0trSjrlNJP/ac89u7GTVzhGenqJnPQgEgkfGnYZ2I9covHr7tQAnq3nMERczbE/jF0f3uEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=cMBNmGSu; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 7680710D0AAD;
	Wed, 20 Mar 2024 17:36:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 7680710D0AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1710945398; bh=H5icz46cAcV+OVygu5QLzJOl+JIEFHHjACrVhgKwhnk=;
	h=From:To:CC:Subject:Date:From;
	b=cMBNmGSuTOL4P51rHxadCZ+Nd8E4YXOuE1SdY44+EvzD5pDHL37nOpbms/TgKIuZC
	 a5IckhKlohtZ/FDI71aUEgr7cyBX4fhi4DXlOzHWIt3vSxhdyaKF5FrehSFrS5An9a
	 X7uwemkAn+59HeEbMMLN3ouwlqNqhndSmvRveUt0=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 72D7930537AB;
	Wed, 20 Mar 2024 17:36:38 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.6/6.1 0/1]  pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Topic: [PATCH 6.6/6.1 0/1]  pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Index: AQHaetQEdZJQK19qr0KbG/EQESuzkg==
Date: Wed, 20 Mar 2024 14:36:38 +0000
Message-ID: <20240320143637.2904385-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/20 07:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/20 12:55:00 #24319174
X-KLMS-AntiVirus-Status: Clean, skipped

syzbot reports a memory leak in pppoe_sendmsg in 6.6 and 6.1 stable
releases. The problem has been fixed by the following patch which can be
cleanly applied to the 6.6 and 6.1 branches.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Gavrilov Ilia (1):
  pppoe: Fix memory leak in pppoe_sendmsg()

 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--=20
2.39.2

