Return-Path: <linux-kernel+bounces-97290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BF876855
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634541F21BED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3B381D4;
	Fri,  8 Mar 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3Mdx6jt"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E161DFDE;
	Fri,  8 Mar 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915167; cv=fail; b=IJaMmfr+xMR79URSG9qASzXrCWJpDs3XCY9WdK1r3S97ykOy4TVgap4znpsw5mQ605xltRV3lM21DGGJdKyGNpGbn9htofu3nINIZhk0sBC99Sn2AU080dP/Ic0AHE/GUnnkkK6+Czv2wrnlBvkGvc4Qx+IBvT9P0rBmIyn59yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915167; c=relaxed/simple;
	bh=hc0vWKzWBYmTQPNA0uhujkmwegxnId+yCijUqEvVwaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kL8sI7mbvyvXOKGVU47NM1MaE5sFTVQOsuGfekwAdjPGdclpdHbHTGSWFDgaCo0zP8bj/Qlf7kK6MfC8uAJ+qDB/F85Zb6fDU0j9iqJ7o2XXyLYC7i6beHsCJqAJxrfJx9FfxkmR1SoeZdMUzcBGYAyCAiXPdJ84l68yp2J158E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3Mdx6jt; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF3pRpBispG98ZcR/36y/5U6Ac0/h6EWXFNt7Np1jtftArAlasMCzYqRhfl39hpnvK5N9/4ZWGfJpkpHpYyUMS4ihXm06djWbp1rPEZG3CFCJLJ4jtZrDUjR8UyqP4TcN2hDoZBorX9snD1iSp7IE+0WosXgNqwUyS74muwvMU1Q8jGvmnxHBfAxw9jfTn3KgKaf7LTp5448qq2XZi5HPWjim3HA4ponpvQ8j7oqJYFPFC3uVIM+bxGZKgxD0jAIgILDo+wOvP5JJk+8IZIQ/7cz9Y4fKJ1NLnVqndNXqoKAk67KaJrahmr70nuvK3fbB8DkA7QN80XZdcSHp1BMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=naW+6/QLvwX4dn6116XICSZRS8rfWN+GlI6qzjai6lvNRJPXU/yJb/kGmnk6A8CqHBxq6DpBKefSpl/OkD0betPWBEglTOkhOGg50W4fE9zuE3cpfK5K8KJ9RKDvf8oU/tp/ExzCvWHTdAo1yjegLO+S9KAMToQ3TriF7Ew9/3PLefJrXvc6y1zXv5QN6tZ4KZI8V33GL/hcE9A3VnubEsMWBIF+urMXC7+RJePHH3zX85JXk1iO7yoOaRRfMXBPRRHlvOeIpApjxd6EGIQaP78PLgOJoXl66QiHIMb5wSL4rTR14xtTTeoUONlNs3lHJBc4nPCSh4pFFthdXq0dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=c3Mdx6jtSTmjFNIiN7wGqE39VdNsRNU3kLrCvQN7cv/B32jISrNw67XSJoYy41UTdpzqcl7b4GOpsDRztlLPmUDGnd6RtVTF5x1m1zsfGEazi8OqRINQmTZn75HHNjFELOM4ZRMnxiA6awF8RO7MEvFWN1aHTCONwmaSsP6ipkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:25:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v9 0/8] I3C target mode support
Date: Fri,  8 Mar 2024 11:25:10 -0500
Message-Id: <20240308162518.1615468-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7024ec46-c412-45e5-a4f7-08dc3f8c7069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5DVDi0+9NPQ3oOB3NwATvAVe/XPcemCLCgLMhCX49PMtX4/89enS4YEvhO6luyme1bIkuOQwUVuRr7eR8ul6aOlGT4hlACFsw9KSex0DvEITKcY6kBhY6hK+hjTRmv/hWF78+gupagv7IksKzFgaAOWm21lTrWjezcZekAX+BuJByRsao5C/Gy5ZHY7xP8y0NAbwSXr10ULj3N4SJGqjTWoJAiGDB2PJ6p7ebTQCWxlg3WxXy4/6UcGf/kmIskD7q2vP3tBGEoOxMM5fSgNz/mH18KWmn79MVf7dn0GfXmGKoT/0k/p+jUBlllCveReMr2qFLowMiCjt9J7BU0x9HYDrqj0k9jR3jWYgW6ooBPoh5qYMxMGzlFLhKCOOPBAuHobeYSK9DLqKMEmw3tAZbSD9WhOel+wZE8Cst/T133QWt01ydSUawd0ahTQndZX47xMenhBFMVpd4KRUbuBqF15/vT5ICDZgrvwRnGWUCnyPeNq1f2Jpdj3ngECXEFvq9Fd5GonKe5CeqgwzoHz++i3iAVKXQgoG3L2m3LT7+mBy4PEpM9HB8u+l+EIDAl5YKDVyzDCrAjZbU8js/tZPq4z9frMFVp0lUjm32IpnUUMTQNfabbOqAsHsub6BRvY1C+1kpoMruo8JjLRLQpOWLAcwp9MZXM8+NwVA3GgDdi1wAchSAQG8YWslE3XFpeS27drpxEciDbYj6E+PNGS9Ag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0htcW9PdEhMMW0rY1lPbEN5ODBtV0dMSzdtY04rLzhDUmpIYk11N0JXaDJU?=
 =?utf-8?B?cmJJOUpzQzZPYmhHM0hvTnZKQjYwMUFva2p2OHZaa1RLcEZGa3B0TXQwM2Nn?=
 =?utf-8?B?clhQUi81eU5KeFRkZEMwZjJ3S3Z3Ujh3TS9oU28zYjlKdXlYMHlISW1qRjVy?=
 =?utf-8?B?MWowV2oreEMxeWlSc2JYcDlIdm1saUg3NitPOVRVdWpSOUo2QzgxNVNtZXZm?=
 =?utf-8?B?UWdNZ3VwSGRDdmU1TW94bjJidGNiSFcxMkZwd2tQSGMzZjJjc1dkL1cxeFFM?=
 =?utf-8?B?VmROUHAwaTdQOGxQY3lFRExXeU1zQkFiRnBkZjkrb2oyNUhiSnZDclJEWnlF?=
 =?utf-8?B?S0lIcm05a1FlUThlU3IrZnVqbU5IOVRCVU5lbkZoK1ZZMWZrTUVZRWVtK2dF?=
 =?utf-8?B?ZG1pejdXVUdHM3pFVDZ6bkhHaEZvM1cxWEdZcFU5cERQNnY2ZVBtUUpCQlZZ?=
 =?utf-8?B?MUlsM1ZGSG5oS21FZEIyUmNQUStnQkJXM1pDbCttTnIyZCsrb2szaHYyVlJG?=
 =?utf-8?B?OHN4Ykw0Vy9vbnVwTlBQcXhHNTlaWldSMGNiWUMrd1lldnhzOXUyK0pkdWw0?=
 =?utf-8?B?cXVYeDdKNGxDQjZDVUhvNTQ5UmlsTkU4Y0c1eTJWUVZURWZyU2NwdnFRN1JJ?=
 =?utf-8?B?a0pDM09KdFhLOWpzTU1UQWtWTklDY0VuaHB5YkNmZlBqSXhmYW1lUmJTYkhm?=
 =?utf-8?B?YWNNUWp5Nlh6OHVaT21lZVBoSWV1K2M1Q3BMZEZNS25zOTEySkFJZ1lZcjBG?=
 =?utf-8?B?eXBYQjhjZGZjaFQ2ek9ScUFSOThESFlLbGlSeDZxWWhjVlNNQmhwUjRPQzlz?=
 =?utf-8?B?NXlLQm5mRnlLMjNxNGJ6TE9NWDVGNnNOMEcyN0MvRWVSZWJ6am1mYkNuRjI5?=
 =?utf-8?B?ZmtES0JkdUJKTXdMcHpLbHFJcVdpdzBmZitvaGVNV3RFYzUxL0ZVS2xkMVcy?=
 =?utf-8?B?WS8zQUsycWpSSXJES3dWWWFxTFFXTGpCZWVSNll0MlIzeHgzUDdXQUt1c1Y4?=
 =?utf-8?B?Ym9lNDFDeC82SWZ0NW14QTZQSmg2R3ZSemlDbVZqSm9QbGJFdWc5blMwNzdO?=
 =?utf-8?B?STVpODUvZVZzTW16cXVXV0lrTVJ3RlJFK2lHZnZFS1FTbHZiOEEwSldhQUta?=
 =?utf-8?B?VmsrdHlVdUZ5U2hyTllDQkk0eGpwOUI4SGR6Q0k0eTU5Wk8vdFN6Y2dXL3V0?=
 =?utf-8?B?eTlvMTlFN3JRL1J6VUhVWlVFZHY4Ti9KQVdIZGh1VXhJeWtObTg2SnZKT1pW?=
 =?utf-8?B?VmwveDhVa1BqVFcwTUdDSjNZWEwvRXFnT1F4Wk5jU1hOSkVZbjRpOUpVcVRH?=
 =?utf-8?B?dGt2MUNsYUNYZVhrdk1ZYStVQjVCZnJYK0pSTzBsYkVYZ1IyTFJFL1dkZU9P?=
 =?utf-8?B?Ty9zQ1ZhTmRzcGVHeFZ3Z3hsbk5IR202Q1Fyemhrd21MVklVd2FXMXBRRVhH?=
 =?utf-8?B?bTI0RTlpVFVVK0t3ZCtZcFh4MWN1K3JDcjlQQ1NUbFI5Lzg2dVIwTTNXY0Mv?=
 =?utf-8?B?ZktQaE9sMVdIejJWQjI1OVBsOVV0TnlZWk9JNXp3OE1Sdmpvc2dGMFovRHc4?=
 =?utf-8?B?REF1UzlFcUlENlFaWGJuOVp3QWM1dGdXM1NCZVYwZnlpcktlMjg2VS9qUmdW?=
 =?utf-8?B?TjdwUEhWRU9YcEdZVkdaNDdDdXJMZDZCYnI4Wi9WbUJZVzV3Q0Iyb21iZzJv?=
 =?utf-8?B?Y1YrSXp3UkZ4QkVMOGMwNVZtenBPNm5NaEVQYWxuM1VqZUwveldDcG9MV1ow?=
 =?utf-8?B?WmxsZVlmelRkMU15TWdTeERiaFIydDM1blBmYTNCR2QyeVBWaDJ5TmtwVS9y?=
 =?utf-8?B?ZDliNGRiZDlBalhiVzFhSDRjZkhhTktNdTlPd2FWQzlDQldlVDJhUGY4N2kz?=
 =?utf-8?B?MWJUWHJyZkFYTEU2YUlOZWdSZVZBSzY1T3lNSUFxb2ZzZVZZTHdGSmYzeFA5?=
 =?utf-8?B?YUJpMDFDUnNxdkNnbGJMK0NjSS80VTVGdEw3VnpOaWxoblk4c1hwaDNCdzBT?=
 =?utf-8?B?QkEvYzdZblRRWFRRWFJoenZpYUR0NFlQZnFzNElxRHZHNnUra2hGZzI3dGxN?=
 =?utf-8?B?Q0ZqSU5HSno5OFRwVHVpRFZMc0lRWUk0QjNLYkwwTHcwRU44clVjRDhGR2Mr?=
 =?utf-8?Q?e5dtZ+aEPXnFmiv+AVH8hBExJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7024ec46-c412-45e5-a4f7-08dc3f8c7069
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:25:59.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snuvm03YAwe29IvpAVkwx8UTdPwDVdPkOjoNx3GmiEzVvxLg6BAMjGAgYMngs3HQLEaGpP0wqYSY+bL594OseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This  patch introduces support for I3C target mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C target controller driver and the I3C target function
driver

Typic usage as

The user can configure the i3c-target-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-target-tty Device to target Controller
------------------------------------------------

In order for the target function device to be useful, it has to be bound to
a I3C target controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-target/

Host side:
        cat /dev/ttyI3C0
Taret side:
        echo abc >/dev/ttyI3C0

Notes about header files.

About Ilpo Järvinen's header file comments, it can pass build, some header
should be included by other header files.

I added some, but I am not sure that is all needs. There may have tools,
which can help check, but I don't know.

Chagne from v2 to v3
- using 'mode' distingiush master and target.
- move svc-i3c-target.c to under master,
- built together with svc-i3c-master.c

Change from v1 to v2
- change "slave" to "target"
- include master side tty patch
- fixed dtbcheck problem
- fixed kerne-doc check warning

Some review comment may be lost since it is quite long time since v1. Now
master side dependent patches already in linux-next. So sent target side
patches with tty support again.

No sure why an additional "\r\n" appended.

Frank Li (8):
  i3c: add target mode support
  dt-bindings: i3c: svc: add proptery mode
  Documentation: i3c: Add I3C target mode controller and function
  i3c: svc: Add svc-i3c-main.c and svc-i3c.h
  i3c: target: add svc target controller support
  i3c: target: func: add tty driver
  i3c: add API i3c_dev_gettstatus_format1() to get target device status
  tty: i3c: add TTY over I3C master support

 .../bindings/i3c/silvaco,i3c-master.yaml      |  11 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 +++
 .../driver-api/i3c/target/i3c-target.rst      | 189 +++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 +++
 Documentation/driver-api/i3c/target/index.rst |  13 +
 drivers/i3c/Kconfig                           |  31 +-
 drivers/i3c/Makefile                          |   3 +
 drivers/i3c/device.c                          |  24 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 481 +++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/internals.h                       |   1 +
 drivers/i3c/master.c                          |  26 +
 drivers/i3c/master/Makefile                   |   3 +-
 drivers/i3c/master/svc-i3c-main.c             |  80 ++
 drivers/i3c/master/svc-i3c-master.c           |  34 +-
 drivers/i3c/master/svc-i3c-target.c           | 776 ++++++++++++++++++
 drivers/i3c/master/svc-i3c.h                  |  15 +
 drivers/i3c/target.c                          | 453 ++++++++++
 drivers/tty/Kconfig                           |  13 +
 drivers/tty/Makefile                          |   1 +
 drivers/tty/i3c_tty.c                         | 432 ++++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/target.h                    | 548 +++++++++++++
 26 files changed, 3724 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/master/svc-i3c-main.c
 create mode 100644 drivers/i3c/master/svc-i3c-target.c
 create mode 100644 drivers/i3c/master/svc-i3c.h
 create mode 100644 drivers/i3c/target.c
 create mode 100644 drivers/tty/i3c_tty.c
 create mode 100644 include/linux/i3c/target.h

-- 
2.34.1


