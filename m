Return-Path: <linux-kernel+bounces-126245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573B893433
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B1E1F23733
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6F1EA71;
	Sun, 31 Mar 2024 16:41:31 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287B15990C;
	Sun, 31 Mar 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903289; cv=fail; b=fpSCbddNOW0n/ICv0JcYXEOakyY0lmp/AMIUytelW0Ks7VdInHq75g827pxuHMFnLYxjC6J65Rtskf3uqpPvDlrh6ZPXYw2b0nbQO1EkZiNteS4O9kd+7ccWn5SEQTJs5BmMILWGLZrPQoSfn3Yc7Y9cFCI7zJRl9fteodCZXtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903289; c=relaxed/simple;
	bh=ayaL65bC87JLAsZetxFc/g3aOn+ACl6KSg30mjY8Gxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bRfx5BPquKBAG5IlTvGo3EjPVajP9I+yNn4zMSRgOdQIPQW9j0TDwI6fnCd9Az1x3Ne16tk9Y/C2dvsCSHNT8jUSJxhqBaRfl2W0BTYIi36tsivaH8e2QHG8OafvfOGC+W80GSof/IiAydLLt4k3ePQnDWadzPykdihqhndL86w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn; spf=fail smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shingroup.cn
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 10F5C207D5;
	Sun, 31 Mar 2024 18:41:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bB0zKp-nBe7J; Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AAE1020896;
	Sun, 31 Mar 2024 18:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AAE1020896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 9DBB380005E;
	Sun, 31 Mar 2024 18:41:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:28 +0000
X-sender: <netdev+bounces-83539-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAm3AFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBlAAAA7IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 9853
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83539-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 779A220199
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863425; cv=none; b=VU5sqT4EZDNDIhhJDcEsRmUyK6xfLEfFs/2kDpHkMaqSndvQee+UlyPyQ9pAlCTr9tUHekrlOAk7/8M9QMn+Ozphl5D0Crk/T6wslqghXq6sMHjNK1LGGJw0FEv37pYGqPXJUMlI2uxvsCPVliyJAlvq+eE2k8E6gnodxx7wMN0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863425; c=relaxed/simple;
	bh=hpjQo0KhGps9/VGEa1fBWiX7PTL1ct+EPAiqsmg8ihw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcedxsIgUnex9W5qPm6h4B/RVb3VxToczR7yicqDvE04hFwnPDaShPwcd+Ap0ehUo5OvEBExAfFUa3CLmV5Duc+um0+KAyFF12SzvgSkjRfwVbj5m3f3/ph7rGN1Efe8WS1eBCTb1Ana7TRsY8URmqHoWvrCFrglxe8L6pfV0ik=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1711863322twj5416u
X-QQ-Originating-IP: 0rkeoEkh2HalCCEoJiJGaDTGlkyTZd6PhYBWh2BWtmk=
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: znfcQSa1hKbRHAcLRCv1mDsVAG5bHbuYuRsE+M8xuRHH6h2E+rlsyWbE1dXtv
	UQZFNYuvIRN7KJrZoV1geRqrKHmHP4N5lK23noYgSby8/HP6Uh+yb0lP0JrpeYiYuGmJDDo
	bQIsdMn0ZZLIdPi7rOkxDKv/Lon9JsOwUgzfj4hZgCMnrV/viuHyuqhnra9S7sz5rIyd2GA
	YqKJbGSTX0jZxt7WDMzxgMXgKg/TFUGjUdZqIE8ObYckJvG7rSuCw7zD2WXtT4Re1JR+1dG
	2B4c9DKNZJ4mzNCzpbR978qR6wHulvH1ysDRAD6aD5b1sT8kAtQgke+IrvxML26dgr6IU3q
	upE7QoPxntRWx9ZYSOipUsBFfxz7gRbhUDvDRYi7cH7UTiQDaY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1667159541051008534
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 0/2] Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:39 +0800
Message-ID: <20240331053441.1276826-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,

This is v2 of previous series[1] about cpumask var on stack for net
subsystem.

Change since v1:
- For iucv_setmask_up() which returns void to caller, just make cpumask
  var static which is protected by global lock iucv_register_mutex. [Eric]

[1] v1:=20
https://lore.kernel.org/lkml/20240329105610.922675-1-dawei.li@shingroup.cn/

Dawei Li (2):
  net/iucv: Avoid explicit cpumask var allocation on stack
  net/dpaa2: Avoid explicit cpumask var allocation on stack

 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++++++----
 net/iucv/iucv.c                               | 26 +++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

Thanks,

    Dawei

--=20
2.27.0


X-sender: <netdev+bounces-83539-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAm3AFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGYAAADsigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 9842
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:25 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 5B87620199
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:25 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDNM0aQHOZLY for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:21 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dnetdev+bou=
nces-83539-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteff=
en.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com E84D720310
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id E84D720310
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71011C20C4F
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191166FB2;
	Sun, 31 Mar 2024 05:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB98C1F;
	Sun, 31 Mar 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.65.219
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863425; cv=3Dnone; b=3DVU5sqT4EZDNDIhhJDcEsRmUyK6xfLEfFs/2kDpHkMaq=
SndvQee+UlyPyQ9pAlCTr9tUHekrlOAk7/8M9QMn+Ozphl5D0Crk/T6wslqghXq6sMHjNK1LGGJ=
w0FEv37pYGqPXJUMlI2uxvsCPVliyJAlvq+eE2k8E6gnodxx7wMN0=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863425; c=3Drelaxed/simple;
	bh=3DhpjQo0KhGps9/VGEa1fBWiX7PTL1ct+EPAiqsmg8ihw=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:MIME-Version; b=3DhcedxsIgUnex9W5qP=
m6h4B/RVb3VxToczR7yicqDvE04hFwnPDaShPwcd+Ap0ehUo5OvEBExAfFUa3CLmV5Duc+um0+K=
AyFF12SzvgSkjRfwVbj5m3f3/ph7rGN1Efe8WS1eBCTb1Ana7TRsY8URmqHoWvrCFrglxe8L6pf=
V0ik=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp82t1711863322twj5416u
X-QQ-Originating-IP: 0rkeoEkh2HalCCEoJiJGaDTGlkyTZd6PhYBWh2BWtmk=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:35:20 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: znfcQSa1hKbRHAcLRCv1mDsVAG5bHbuYuRsE+M8xuRHH6h2E+rlsyWbE1dXtv
	UQZFNYuvIRN7KJrZoV1geRqrKHmHP4N5lK23noYgSby8/HP6Uh+yb0lP0JrpeYiYuGmJDDo
	bQIsdMn0ZZLIdPi7rOkxDKv/Lon9JsOwUgzfj4hZgCMnrV/viuHyuqhnra9S7sz5rIyd2GA
	YqKJbGSTX0jZxt7WDMzxgMXgKg/TFUGjUdZqIE8ObYckJvG7rSuCw7zD2WXtT4Re1JR+1dG
	2B4c9DKNZJ4mzNCzpbR978qR6wHulvH1ysDRAD6aD5b1sT8kAtQgke+IrvxML26dgr6IU3q
	upE7QoPxntRWx9ZYSOipUsBFfxz7gRbhUDvDRYi7cH7UTiQDaY=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1667159541051008534
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 0/2] Avoid explicit cpumask var allocation on s=
tack
Date: Sun, 31 Mar 2024 13:34:39 +0800
Message-ID: <20240331053441.1276826-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: netdev+bounces-83539-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:25.4221
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d4ac858f-a754-4169-aaaf-08dc=
5144a564
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.371|SMR=3D0.321(SMRDE=3D0.005|SMRC=3D0.316(=
SMRCL=3D0.103|X-SMRCR=3D0.315))|CAT=3D0.049(CATOS=3D0.001
 |CATRESL=3D0.022(CATRESLP2R=3D0.017)|CATORES=3D0.022(CATRS=3D0.022(CATRS-I=
ndex
 Routing Agent=3D0.020 )));2024-03-31T05:37:25.820Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 6759
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.026|SMR=3D0.023(SMRPI=3D0.020(SMRPI-FrontendProxyAgent=3D0.020))=
|SMS=3D0.003
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXoCAAAPAAADH4sIAAAAAAAEAJVSXWvb=
MBSV4tipXdwU9r
 S3y54aktix26Y0Txv7YLA97q2U4ChKrMWxjCSnLfQv7j/tSm7YxmAw
 IcSV7jnnnnvRD/+zmMRRHH0rhQbchxzkBhrFD0K2GjRXguu77B6KlW
 wNsKbdF3oHh0KBrEGbgu1gIxXU3MSRblf6SRu+T6zk+7Kotxy0qBmH
 Q7aIoyl8Qqho2WGpubFCy7a5GMFDKVgJiptW1WhBijUYCayoKq4m8L
 3VBvbFjh+rxxE4A1jdCPbCRu+NkoYzw9eweoJtJVdFBZVEg66i4luB
 3tRy3xr+mMDdRyXYvTVq23P+SmMavUjTSiqe7LiqeZVItU2r3b5K81
 l+NbvMb7PZ9TybJbd5Pr+5nmbTdfHARVKJt7oU9VbJtklYnVrdDzYD
 XwVc5KOFNY1DSq2XBbxzTfLHphJM/DlW7FoybAzHe5zwkbtuiiL/fz
 LSkyRJrQI3pW3LpBvFucYJ8060O6eYThjAM2RXMHZrigv5R+fusJB/
 rmfI5y/88S8ZJ5TDRlRcA3OfYz2B/AZEjd/MetYX49EEsktY84p3D9
 NR9zuLeqfdR7X6brD2YiXzJL9JZvYWR4T0yKBP/B7xun1CwoAOKCGU
 eD4JBuTEI/2eizHwiB+Ss4AM8IpEfOlTMiQ+wnrE7/CdWuCCvk2dIu
 xI8UISuawtitxXxMeKPoJp1BW1OpR8cfSgK0H8MzLEmJLebyJOkPYd
 q4MF+IJqneeInDrbIca+A/+VOsMYH1ENs1g0dD1Siv5xLOddadyUvr
 Ev9LWrZT0MaOgwXkSHXRCS84AMfRpbDO05vGfjn2eLDCExBAAAAQuN
 Ajw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg
 0KPFVybFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+
 DQogIDxVcmxzPg0KICAgIDxVcmwgU3RhcnRJbmRleD0iMjY4IiBUeX
 BlPSJVcmwiPg0KICAgICAgPFVybFN0cmluZz5odHRwczovL2xvcmUu
 a2VybmVsLm9yZy9sa21sLzIwMjQwMzI5MTA1NjEwLjkyMjY3NS0xLW
 Rhd2VpLmxpQHNoaW5ncm91cC5jbi88L1VybFN0cmluZz4NCiAgICA8
 L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQ7OAVJldHJpZXZlck
 9wZXJhdG9yLDEwLDA7UmV0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0
 RG9jUGFyc2VyT3BlcmF0b3IsMTAsMTtQb3N0RG9jUGFyc2VyT3Blcm
 F0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0
 b3IsMTAsMTtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3
 IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCw3
X-MS-Exchange-Forest-IndexAgent: 1 1128
X-MS-Exchange-Forest-EmailMessageHash: B36D1F22
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hi,

This is v2 of previous series[1] about cpumask var on stack for net
subsystem.

Change since v1:
- For iucv_setmask_up() which returns void to caller, just make cpumask
  var static which is protected by global lock iucv_register_mutex. [Eric]

[1] v1:=20
https://lore.kernel.org/lkml/20240329105610.922675-1-dawei.li@shingroup.cn/

Dawei Li (2):
  net/iucv: Avoid explicit cpumask var allocation on stack
  net/dpaa2: Avoid explicit cpumask var allocation on stack

 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++++++----
 net/iucv/iucv.c                               | 26 +++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

Thanks,

    Dawei

--=20
2.27.0


X-sender: <linux-kernel+bounces-125960-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGcAAADsigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 9885
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:38 +0200
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:38 +0200
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8D5E82087C
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:38 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_Ez23TMl8tb for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:35 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125960-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1E48C2083E
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1E48C2083E
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3316B2167A
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F27A951;
	Sun, 31 Mar 2024 05:37:07 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB98C1F;
	Sun, 31 Mar 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.65.219
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863425; cv=3Dnone; b=3DVU5sqT4EZDNDIhhJDcEsRmUyK6xfLEfFs/2kDpHkMaq=
SndvQee+UlyPyQ9pAlCTr9tUHekrlOAk7/8M9QMn+Ozphl5D0Crk/T6wslqghXq6sMHjNK1LGGJ=
w0FEv37pYGqPXJUMlI2uxvsCPVliyJAlvq+eE2k8E6gnodxx7wMN0=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863425; c=3Drelaxed/simple;
	bh=3DhpjQo0KhGps9/VGEa1fBWiX7PTL1ct+EPAiqsmg8ihw=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:MIME-Version; b=3DhcedxsIgUnex9W5qP=
m6h4B/RVb3VxToczR7yicqDvE04hFwnPDaShPwcd+Ap0ehUo5OvEBExAfFUa3CLmV5Duc+um0+K=
AyFF12SzvgSkjRfwVbj5m3f3/ph7rGN1Efe8WS1eBCTb1Ana7TRsY8URmqHoWvrCFrglxe8L6pf=
V0ik=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp82t1711863322twj5416u
X-QQ-Originating-IP: 0rkeoEkh2HalCCEoJiJGaDTGlkyTZd6PhYBWh2BWtmk=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:35:20 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: znfcQSa1hKbRHAcLRCv1mDsVAG5bHbuYuRsE+M8xuRHH6h2E+rlsyWbE1dXtv
	UQZFNYuvIRN7KJrZoV1geRqrKHmHP4N5lK23noYgSby8/HP6Uh+yb0lP0JrpeYiYuGmJDDo
	bQIsdMn0ZZLIdPi7rOkxDKv/Lon9JsOwUgzfj4hZgCMnrV/viuHyuqhnra9S7sz5rIyd2GA
	YqKJbGSTX0jZxt7WDMzxgMXgKg/TFUGjUdZqIE8ObYckJvG7rSuCw7zD2WXtT4Re1JR+1dG
	2B4c9DKNZJ4mzNCzpbR978qR6wHulvH1ysDRAD6aD5b1sT8kAtQgke+IrvxML26dgr6IU3q
	upE7QoPxntRWx9ZYSOipUsBFfxz7gRbhUDvDRYi7cH7UTiQDaY=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1667159541051008534
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 0/2] Avoid explicit cpumask var allocation on s=
tack
Date: Sun, 31 Mar 2024 13:34:39 +0800
Message-ID: <20240331053441.1276826-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: linux-kernel+bounces-125960-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:38.6367
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 14ed287c-673b-48d1-0ce0-08dc=
5144ad45
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.190|SMR=3D0.145(SMRDE=3D0.003|SMRC=3D0.141(=
SMRCL=3D0.102|X-SMRCR=3D0.139))|CAT=3D0.043(CATOS=3D0.001
 |CATRESL=3D0.011(CATRESLP2R=3D0.003)|CATORES=3D0.028(CATRS=3D0.028(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.026))|CATORT=3D0.001);2024-03-31T05:37:38.826Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 6747
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.007|SMR=3D0.007(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXoCAAAPAAADH4sIAAAAAAAEAJVSXWvb=
MBSV4tipXdwU9r
 S3y54aktix26Y0Txv7YLA97q2U4ChKrMWxjCSnLfQv7j/tSm7YxmAw
 IcSV7jnnnnvRD/+zmMRRHH0rhQbchxzkBhrFD0K2GjRXguu77B6KlW
 wNsKbdF3oHh0KBrEGbgu1gIxXU3MSRblf6SRu+T6zk+7Kotxy0qBmH
 Q7aIoyl8Qqho2WGpubFCy7a5GMFDKVgJiptW1WhBijUYCayoKq4m8L
 3VBvbFjh+rxxE4A1jdCPbCRu+NkoYzw9eweoJtJVdFBZVEg66i4luB
 3tRy3xr+mMDdRyXYvTVq23P+SmMavUjTSiqe7LiqeZVItU2r3b5K81
 l+NbvMb7PZ9TybJbd5Pr+5nmbTdfHARVKJt7oU9VbJtklYnVrdDzYD
 XwVc5KOFNY1DSq2XBbxzTfLHphJM/DlW7FoybAzHe5zwkbtuiiL/fz
 LSkyRJrQI3pW3LpBvFucYJ8060O6eYThjAM2RXMHZrigv5R+fusJB/
 rmfI5y/88S8ZJ5TDRlRcA3OfYz2B/AZEjd/MetYX49EEsktY84p3D9
 NR9zuLeqfdR7X6brD2YiXzJL9JZvYWR4T0yKBP/B7xun1CwoAOKCGU
 eD4JBuTEI/2eizHwiB+Ss4AM8IpEfOlTMiQ+wnrE7/CdWuCCvk2dIu
 xI8UISuawtitxXxMeKPoJp1BW1OpR8cfSgK0H8MzLEmJLebyJOkPYd
 q4MF+IJqneeInDrbIca+A/+VOsMYH1ENs1g0dD1Siv5xLOddadyUvr
 Ev9LWrZT0MaOgwXkSHXRCS84AMfRpbDO05vGfjn2eLDCExBAAAAQuN
 Ajw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg
 0KPFVybFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+
 DQogIDxVcmxzPg0KICAgIDxVcmwgU3RhcnRJbmRleD0iMjY4IiBUeX
 BlPSJVcmwiPg0KICAgICAgPFVybFN0cmluZz5odHRwczovL2xvcmUu
 a2VybmVsLm9yZy9sa21sLzIwMjQwMzI5MTA1NjEwLjkyMjY3NS0xLW
 Rhd2VpLmxpQHNoaW5ncm91cC5jbi88L1VybFN0cmluZz4NCiAgICA8
 L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQ7PAVJldHJpZXZlck
 9wZXJhdG9yLDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0
 RG9jUGFyc2VyT3BlcmF0b3IsMTAsMTtQb3N0RG9jUGFyc2VyT3Blcm
 F0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0
 b3IsMTAsMjtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3
 IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwxMA=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1129
X-MS-Exchange-Forest-EmailMessageHash: B36D1F22
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hi,

This is v2 of previous series[1] about cpumask var on stack for net
subsystem.

Change since v1:
- For iucv_setmask_up() which returns void to caller, just make cpumask
  var static which is protected by global lock iucv_register_mutex. [Eric]

[1] v1:=20
https://lore.kernel.org/lkml/20240329105610.922675-1-dawei.li@shingroup.cn/

Dawei Li (2):
  net/iucv: Avoid explicit cpumask var allocation on stack
  net/dpaa2: Avoid explicit cpumask var allocation on stack

 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++++++----
 net/iucv/iucv.c                               | 26 +++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

Thanks,

    Dawei

--=20
2.27.0



