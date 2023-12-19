Return-Path: <linux-kernel+bounces-5489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ED2818B48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1791C23EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8221CA91;
	Tue, 19 Dec 2023 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rReFhxAz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F41CA80;
	Tue, 19 Dec 2023 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702999969; x=1703604769; i=markus.elfring@web.de;
	bh=tn6Ij30L4nzJk1aQGY/PqCDgEqVZBUaPZ1LpxACXJwM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=rReFhxAzgTkMWDA0DJzIQ8OD+hMHBfwo7o9LSN3BWD16842g6PnD6VDyASqxtAOX
	 kzxI+w0WfT+kRlp6JgVmzizSUH2rPDEt/xg8/5f+6Sv0yUI2WJa+gHjnhafE5T4f9
	 jkWttkRDCxS4qw6nuYjonHnrYuyfAn7TUPaSvWJgDWRd/UvjZutQv0hV4DEp6O1Am
	 wkAD8NrJx9w4b3NUp7AvH6/Bder6I7rcHPHhgu64zurZgACNf9Gu2SCSJh8mCghEi
	 l56fXmmGw5X6AVz8gJzX1QpQHxdOjPx8mCTwyBnG9xFE3SI15i0GbzUC6XtHj4vk8
	 HZo20+PBIlJ4Vmr2Yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1rarCZ3qhj-00LtdG; Tue, 19
 Dec 2023 16:32:48 +0100
Message-ID: <6d7d0b33-6c9e-4941-af5f-678137d2a00e@web.de>
Date: Tue, 19 Dec 2023 16:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] kobject: Add a jump label in kobject_uevent_env()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZRPQpP5gRDbecmiyr/GE+SRHU+DXgMz5lHrrQB7DWJnkoOjyg2
 K30sKLY3bstzCh5sNb9u0n4vzpJnhUf3kom/Wvx0HiUSDBLP/DO7VaZYeafo671XrPyWciw
 vnfG7mDdhrRdfw+WkhapcjKAdsrG1QCGE4hUp94NKfmfRkMTqGhQPG18A2MvI8yCeMzRjRI
 u6JZvVNqlOSj0q7C62FXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hcQw/9bQR1o=;HL5Pf2hLEmDWinV+zatF7bP3R1l
 +kQw8rd9Ep4QCKYhup2nx2GEs6mb4obohDmH05Ff7ymBibhqU75K/r1lDdPKwVTaap+GgE7fa
 ahM3XHFEN19jDllEy0YPbts01U571bzGRy+KUVH0/j07X8YPmKXATQdx0xkNsFgFu/oSajBZ9
 bUBBxJzIlwt28c+qKdhBZFyiuggTu136gxqiFxutDLJu0OXwJ4vp0p+CBgVMQ+cTXHY2QfD1K
 hOsxTGIV7vP6C+hzdjzCEZWcVV1dM2jUcxjFWnY/hChFlQkAFOYH4aQo42zt9IQU7ODWHAzo3
 C9wrGnoskFEHPlPNM/n6Z0jtPxze2pyFEdFHajNvKCZqaaYUL7I7wKaSzpBsrbaNBapRVXv4D
 0XMBurnDW1b/QHYH3rxtnIDnBaozZIoCcjGTeiEn9Eh22DL4h0M6sVJGVeL+oDIAAGKxv8bz/
 KAzNT0Ff0LTZkFyt1JM82B7JotEeNNxZMLVVn5PwVWAbv9qwRecwYDRbDYMdsWERe3OOYlYTF
 2Hy8CKPTtG2U4bbxPM2d0Fa5pl7FjmjjYg62ss7mIriXM6t+Y+ABM0Qjaxm/4VQowKJnTvXSF
 anDFUWazBxqP28/kFUWDl0de3tr9FJ5//nd3f0jcEu6S5Qd0XjHXgCZLb2j0U6JjNl0oNtbZa
 ZCrrlWFpJ/VwPQrdk9qYKP/RBD/+hWF9UDOYo7xVbNsi3ksjyyyegMUr0oJJlH8msgy9gCkC6
 fbkJl+z7MQh6aVk+Cp+7KTIPH44BlvoZVWHkzVgbyyIBY1ioaZfly2BsuZwIuwu377GOT7fvN
 YSxxZRsj/hCoCfUT1jYoPFhPOWtYcXWTmnxSR1yPdorA3rWvWROnMyhJTWp8hbYSJOfVWGrff
 zMsIlecFJw0T1ATQMzmvVwcMBUmWSuxicVTLpK1Faj3W9jWpAnUrqL98Pu5d78Jj4eSBklaGU
 N3qjuQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 14:16:35 +0100

Use another label so that a call of the function =E2=80=9Ckfree=E2=80=9D c=
an be avoided
after a failed call of the function =E2=80=9Ckobject_get_path=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index fb9a2f06dd1e..811e579ed89d 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -529,7 +529,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 	devpath =3D kobject_get_path(kobj, GFP_KERNEL);
 	if (!devpath) {
 		retval =3D -ENOENT;
-		goto exit;
+		goto free_env;
 	}

 	/* default keys */
@@ -623,6 +623,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,

 exit:
 	kfree(devpath);
+free_env:
 	kfree(env);
 	return retval;
 }
=2D-
2.43.0


