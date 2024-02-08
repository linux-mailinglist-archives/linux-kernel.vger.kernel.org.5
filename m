Return-Path: <linux-kernel+bounces-58391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606784E5DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D077E28FAF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92773164;
	Thu,  8 Feb 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDAbJWAh"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460777D3F0;
	Thu,  8 Feb 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411700; cv=fail; b=tGMI7MwzgHd+cQfBAMY7kn1QevOqMYn+zs+DzGp0ISKTUms1mdQ1fRLRGnenaP+9Yqtz/ExECgZ/bRxsOdCGGUbKx2k+Nfj7c4hxSvfBGBcl2CUFiO63aaiNEUye9bkNgczDMxwODif6O8A67V0XICyydZbwkg7cq9/4gA6MQe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411700; c=relaxed/simple;
	bh=hc0vWKzWBYmTQPNA0uhujkmwegxnId+yCijUqEvVwaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p+D4qXa/Yh2OTQ+B7ZuUAAj2M63xeEDFiqh1ttoCY9PFHaQhckzrwPtM/KcvnSg4kdm29MrV5fKk+v1V7RUh3BQAaaJxSMORUBh4ocpZbC/x4kC/Tk7Q84JA8MuHRfSpdExc1pPLVGGk3pUcZurMYJcr5NiIDbZg832bWZGCkrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aDAbJWAh; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS3w7phlgUg7l7Tp4hEE9LUCUXKawYbfYsAucE+1PMV4x7oQEttgjV31HhL+I/BNu6Etj9/ULYBfq4s/MJkOtDGsk9trbd5gYyofYi6XB3DvvpDMC/r/RofkTdJeGOh2tzICtRJjjY6n09L1FzKeJG4sZUjhvot1fSC1Mq7XPQxmwg2WZff0+cZRn1v5mEvsNpjmnud/DnyrF0KwdqwMZVJ07pbrJp/vHHew06jod/um/hTYrcbT74JgArARyz4dqfxeurFPOaiBcRTXIFAetDjYEyNsPUoex6UvkKyk2oWR0CSEmdBVfa01/Qnmr28sd7golZR64DRzbArEkflh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=iiKCfDtM/SRY68uSmv4/dFkCh3k7M5kkE+yULYwq8fhz6TB6O/QSeQo93C5luuM5U2rjEK2NmFbOO8q7P8OlmPnoYB+ifOg4j3ZbDBFS/RS+wdYw1015Cf2cxUPFfFmKcMuh3FOM8S05fjxtrt/Qxe3z3nJNAP6r4GozeIpV6bJbxFUw67rId8vJc0zoxOMXO1N3+BWn0s53QOorX90VTVBdyJbZBXDW2/4mG601gT+y4verHpYFA642AEm7D0M/yONrtS3OD1pavSKmJpMbxr3dV6N2h7rPA7ZaaZZZ7tiSsprq5Res9awqxYCd3eaolyu5DL+vw2eQ7qVzdlrUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=aDAbJWAhV3DECOeYqLUYvrt8fwI99fpt+vx2CP2VRlC0pXdG+EsGSSTZfCV9iK6VIIhhggAVW6J8DHWNrwWRaoOOu/ZKeHfOHMz5icEb5A0+KE2Njk3THYQtmaHW4oswYuRK+1mNbNXlm3GMw2mqxSnx/+fuLFTUY570evozg9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:01:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:01:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
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
Subject: [PATCH v8 0/8] I3C target mode support
Date: Thu,  8 Feb 2024 12:01:09 -0500
Message-Id: <20240208170117.798357-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a65b08-4f16-4c28-94ae-08dc28c79b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UhlbusNTMBw31RFGmtPyEaORzj8cMxHJzdMc9vbII2p/2okJG5tk0pHKaGGSOrNK/st0/vqmJGFEYssFQpbxxFebGltLBEQqUV4nQyvs2/2NEekuY9bbOWiy0/Fs5iIgk/fWplZ3nEKvIsgtCq5Ufmq+YNivlr75MStF0lyXp0hEy3hCSif+cddha2L14Eo4KRTjdoSflyhPftZLZPGTwobUzA3tA0dBQqzmWvua18hs2dRhmSM2B821O/0zSkUd8Hm70p0MkXgdOQXcHSrygehp/xYOAomthi/po2LxUSAVm5hUrGKSwhV4mrhv6oe/rwqkZYE5q/Oo6TgDG6675WYqidRKNTP2dwRkZXOa/Rh0PQErLHizGVUJcQ4G3V0KtXN2k2lfcqV8yX1qOYzcSw1V6vy0j0GPo+gqAEfH8x6thIUnRANzf6dvgyl8fl+2/PWLLMNa4ttBxWzVorSKPYZCUDTBwNzInSNTdCJZUfs0sZe7MektF6uLCLTfGWiomtqbyPDH7pGgO2AABIPKmw4e2yXxqqQnSgzHL4LY55UNUo+CkslQoFcHJ3C7uO7LYhNmzaYEjtQQ/ukUeK2LYCb/TdXkJEuWWEpXLcUU7RI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(6666004)(52116002)(6506007)(83380400001)(37006003)(66574015)(86362001)(7416002)(41300700001)(1076003)(2616005)(26005)(34206002)(6512007)(36756003)(8676002)(8936002)(4326008)(6486002)(478600001)(2906002)(5660300002)(66476007)(66946007)(316002)(66556008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tNUVIva1NuaXRkZ0VqRWZiaTNvUDh0elkzOXZ0a3ZNVWF3RXhSZW5zWXhE?=
 =?utf-8?B?c2doOWpHb2dsbzY5WGdSa0NGdDRkdkFUQktJQi90ZnU4N3dQNXFDM0pQYVd2?=
 =?utf-8?B?OTJzcmI0L3ZtSEM4ZmEwNTZrREVEOEN1OTdtYkI3TlprakF6V1NpdUdPbk5n?=
 =?utf-8?B?T1BzbGd2aDhONDhVV3AvdkdCSmtNSzllWFlEMDg5S0M1ZDYxMWN4ZkFUeWw2?=
 =?utf-8?B?aEc2eUkrazlSWGlic3NsUUU5V21uV3FoM2MzMG9mQkNIK3FxRjUrcWh3WUF6?=
 =?utf-8?B?QmI1dC8rWFdUWTA0d2lZZzd5Y2R3eEF5OFBVdENFWmFqaHBqNnd3UXpURGFR?=
 =?utf-8?B?MlJtM0xlYWZra0Y4bkovenNib0gxMG4vc1liWVpFem14c3VmbkU4RGlnbUZ0?=
 =?utf-8?B?UHFTYnhFSXFFOVVUYUhVOHNRTFpod2hzWDhIT0IrUDFvZFcwc0xsRXovNXJ3?=
 =?utf-8?B?SnJteFg1b3BYNmcxdDNMYXY1T1BuNktsdFhJOUxTVXFCVnFqNkt0eElNQno5?=
 =?utf-8?B?UGNDdU5YOURKWEFsdTFHUCtOK0tLM0huKy81NGpReHNYU2J0QWRoMGpvS29m?=
 =?utf-8?B?b3docTRndGtJOGlVWG95eUF5a1daZHM5Sy9XVkpKVlNSeHBZWHJ1UkZ1dkFM?=
 =?utf-8?B?a1QxemNlUUdlSStuUUN5M2ZWVnYvVFI4V1pCUnlFb1NOK3pWUU81Z0doV1pk?=
 =?utf-8?B?UHRtLzgvVXp5UkI5UFZvSldSV0Z0WDUrbUo0elFTMWFhbHllNEwvNWo4ckdh?=
 =?utf-8?B?TDE3WllzMm9UTjFVMW9jY2RnM0YxS0N4SlIrd21aMVBOSlZ2bFZWZFJGNTZh?=
 =?utf-8?B?WGlrQVVQQ2hPakt1RWpiclVwMjhVUzlhV3VIanRXQmlvZUhMU3EvVDc4a0tZ?=
 =?utf-8?B?dy95d2lSL2hnSXp2Y3paL2duZW8vanBWcmlYOVEzNzUxeVZseG5jdUFzcU10?=
 =?utf-8?B?T0dVZXJKazJQTlFPQVoxN21sMVp0c01jQ3NEQVdDMGJkWW0xbHlMMERLWDMv?=
 =?utf-8?B?MkVNWTdjdVFmcTB3SGFDYTdyZFU5bHh2dll6dkZZWXY5dGFnMS9CZzV3YUxO?=
 =?utf-8?B?U1Zibm9namZYWjdvbmhVNU5rd3ZGdUlIeWZvRURUUmo5LzV2dzExZVBiRyta?=
 =?utf-8?B?dkw3Zk1vYkp3VWJsQ2kwMEtFTVM0UHJMbmZkRTBvcEZqaEFPVElJaE9xZkpw?=
 =?utf-8?B?ZTZzWkEzZS94ZklMY1dTZ01telhEWEh2RDJPRmxsYTR1cVRaR0lWVnpPV2dW?=
 =?utf-8?B?S1RFdmJIWWo3TE9TS0RCQzlCbDFvUk9XVi9SSEJoYkQvbWFWbG9ZRURiZkh4?=
 =?utf-8?B?QXlManF2RGRENjFlOTFpNDBpN05lYy9ZMnNVYVVIUi9GN2RIdnpiUm8vZzNn?=
 =?utf-8?B?YVpjVTZTVnArL3NRSlduL2o3TGNudkg4cSs0YlZ3d3NsK2w5cW8vNG9ON29T?=
 =?utf-8?B?bzgwVkV2WmYxQlV1enVkYkUxcyt3TGZqUitLa2dqUXBtN2tUd0V0ZHM5cGF0?=
 =?utf-8?B?WWltT0RkbEk5dk5qYk42UDJzVXpKS3IrMlNRdEwyMEIwZEdEY01yWncyU2Q0?=
 =?utf-8?B?REpKTkxKcXpQMGl0Y1lsc1BPd2ZMSkgranIzRk02Y1RJYytjTUgzSGY3Yklu?=
 =?utf-8?B?NTRvQ3dQZWtWMEM0blVLdDVkUDMvUHBSOTNtZURBWG8vNy9RQUtuTTBnTTE4?=
 =?utf-8?B?eHczNTlUYXpwUTM4cElUdVQrOUV6RzJBL2FGSWFzZjRSMkVjeFJ1RjZIYkRO?=
 =?utf-8?B?azcyRkQ1ZUNRRUFlZ3hZdThnSDRTOXJQYzEyWVJJVEM2dUYydW1MY2lES3FG?=
 =?utf-8?B?UVNvUEdKb0lyVU1mNjNVY2dvZzFUcUE1dnAwTFFla21wSGp2UWxwRkNvRHJk?=
 =?utf-8?B?ZlhuQkFqYUozRDNnWnRlemdaSUpLbmI0R09qampQdi95ai8wOEY2cnNKc2NO?=
 =?utf-8?B?enV1ZVVyNmNVQ2YvWFROQVR5MjhISWY1NG5ILzJPUytRSXFBOWlDOGNhdklK?=
 =?utf-8?B?eTkvWjRQcEtGVUx2OTBVQm91Y2lxYWFtUXpPRndodVdsS2MzSEZhcFAzazcw?=
 =?utf-8?B?d09IVFNLVVcvempjb0RJRk1SQUMrbkdtUEZ6RG1zS2xlSUJRRzEzMUNpb0w5?=
 =?utf-8?Q?XdMY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a65b08-4f16-4c28-94ae-08dc28c79b5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:01:35.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE6H7cY9ZhjUtUK4uNXVI7p3P/EiYUKdRUBp9FTAFwNbjPVxhYP9/YdT4XTY6K92JeEkrJ1dt34Qz+vC3V/ZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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


