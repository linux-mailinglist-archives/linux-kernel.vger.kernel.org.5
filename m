Return-Path: <linux-kernel+bounces-5657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF8818DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDF1F26642
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36332C9D;
	Tue, 19 Dec 2023 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="M1+tHjDR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6331A64
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 43152 invoked from network); 19 Dec 2023 18:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1703006021; bh=7kmec4JawjMGqIyJHMmL9kvU9jkRy/9Mu2C9xIhcivU=;
          h=From:To:CC:Subject;
          b=M1+tHjDRUQtBwb4H5/uULVeXDgu2ZvGQqpINl4plkiqU7FTpqWToro37Rl7tYprF6
           7vDBQAUSttkoTJmNPzfvEXwKDMfXC7pboVQ0UMvKmONhU65HTgn6XNqrIk5/EfvOT1
           MN7CEPqQc3mkkncc6miAAcPEMItSo/gxIBIjjoMY=
Received: from 37.30.118.70.mobile.internet.t-mobile.pl (HELO [127.0.0.1]) (mat.jonczyk@o2.pl@[37.30.118.70])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 19 Dec 2023 18:13:40 +0100
Date: Tue, 19 Dec 2023 18:13:40 +0100
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: Gregory Greenman <gregory.greenman@intel.com>, linux-wireless@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRegression=5D_debugfs_warnings_w?= =?US-ASCII?Q?hen_resuming_from_suspend_on_6=2E7-rc5?=
User-Agent: K-9 Mail for Android
In-Reply-To: <798e32d457e3ea029fecd423fdb2b1317016e02f.camel@sipsolutions.net>
References: <da91e776-b192-4e2b-9157-e83a5a2659b1@o2.pl> <d8aef271-418c-4644-a3fd-72ee5f1959b7@o2.pl> <798e32d457e3ea029fecd423fdb2b1317016e02f.camel@sipsolutions.net>
Message-ID: <1F32CD27-682E-452D-8EC1-904314844CCB@o2.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WP-MailID: 41bfcf3e8fadcf864875140a23e25358
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [4eM0]                               



Dnia 19 grudnia 2023 13:03:12 CET, Johannes Berg <johannes@sipsolutions=2E=
net> napisa=C5=82/a:
>On Thu, 2023-12-14 at 22:49 +0100, Mateusz Jo=C5=84czyk wrote:
>> W dniu 14=2E12=2E2023 o=C2=A022:45, Mateusz Jo=C5=84czyk pisze:
>> > Hello,
>> >=20
>> > Since upgrading to 6=2E7-rc kernels, I have been getting the followin=
g error
>> > message in dmesg
>> > while resuming from suspend:
>> >=20
>> > [=C2=A0=C2=A0 83=2E302944] debugfs: Directory 'iwlmvm' with parent 'n=
etdev:wlp2s0' already
>> > present!
>> > [=C2=A0=C2=A0 83=2E302963] iwlwifi 0000:02:00=2E0: Failed to create d=
ebugfs directory under
>> > netdev:wlp2s0
>> >=20
>> OK, now I see
>>=20
>> https://patchwork=2Ekernel=2Eorg/project/linux-wireless/patch/202312110=
85121=2E88a950f43e16=2EId71181780994649219685887c0fcad33d387cc78@changeid/
>>=20
>> ("wifi: mac80211: don't re-add debugfs during reconfig")
>>=20
>> Will see if this fixes the issue=2E
>>=20
>
>Did that work? I think we need
>
>https://patchwork=2Ekernel=2Eorg/project/linux-wireless/patch/20231220043=
149=2Eddd48c66ec6b=2EIa81080d92129ceecf462eceb4966bab80df12060@changeid/
>
>in addition =2E=2E=2E=20

No, it didn't=2E I have tested it only yesterday, did not write yet=2E=20
Will retest with the new patch=2E=20

BTW, it seems that NetworkManager does not display the=20
WiFi signal level correctly on 6=2E7-rc5=2E I did not pinpoint it yet thou=
gh=2E=20

Greetings,=20

Mateusz

