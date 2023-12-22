Return-Path: <linux-kernel+bounces-9670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCE81C951
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A82B23A10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE017993;
	Fri, 22 Dec 2023 11:41:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755A17989
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-EcondNBpNcmFjLxr1RqcUQ-1; Fri, 22 Dec 2023 11:41:24 +0000
X-MC-Unique: EcondNBpNcmFjLxr1RqcUQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 11:41:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 11:41:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gui-Dong Han' <2045gemini@gmail.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baijiaju1990@outlook.com" <baijiaju1990@outlook.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, BassCheck
	<bass@buaa.edu.cn>
Subject: RE: [PATCH] Bluetooth: Fix atomicity violation in
 {conn,adv}_{min,max}_interval_set
Thread-Topic: [PATCH] Bluetooth: Fix atomicity violation in
 {conn,adv}_{min,max}_interval_set
Thread-Index: AQHaNMVjcf/fSWdBLky9VyA+zJFtpLC1LJZg
Date: Fri, 22 Dec 2023 11:41:09 +0000
Message-ID: <0565eabbd25141fab9f3206db4e86196@AcuMS.aculab.com>
References: <20231222105526.9208-1-2045gemini@gmail.com>
In-Reply-To: <20231222105526.9208-1-2045gemini@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Gui-Dong Han
> Sent: 22 December 2023 10:55
>=20
> In {conn,adv}_min_interval_set():
> =09if (val < ... || val > ... || val > hdev->le_{conn,adv}_max_interval)
> =09=09return -EINVAL;
> =09hci_dev_lock(hdev);
> =09hdev->le_{conn,adv}_min_interval =3D val;
> =09hci_dev_unlock(hdev);
>=20
> In {conn,adv}_max_interval_set():
> =09if (val < ... || val > ... || val < hdev->le_{conn,adv}_min_interval)
> =09=09return -EINVAL;
> =09hci_dev_lock(hdev);
> =09hdev->le_{conn,adv}_max_interval
> =09hci_dev_unlock(hdev);
>=20
> The atomicity violation occurs due to concurrent execution of set_min and
> set_max funcs which may lead to inconsistent reads and writes of the min
> value and the max value. The checks for value validity are ineffective as
> the min/max values could change immediately after being checked, raising
> the risk of the min value being greater than the max value and causing
> invalid settings.
>=20
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.

Your static analysis tool is basically broken.

The only possible issues are if the accesses aren't atomic.
In practise they always will be but using READ_ONCE() and
WRITE_ONCE() would make that certain.

The lock sequence:
> =09hci_dev_lock(hdev);
>  =09hdev->le_conn_min_interval =3D val;
>  =09hci_dev_unlock(hdev);
is pretty pointless - is doesn't 'lock' two+ things together.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


