Return-Path: <linux-kernel+bounces-40230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5983DCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59244B26CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7461CD1B;
	Fri, 26 Jan 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="E/fPac+X"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA651B963;
	Fri, 26 Jan 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281108; cv=fail; b=l2g/QPhux9zd9DsfJGoezinydVgHQonJF16WdX6XkKckbj379CYQsH/M97ZJixX4m/D6di5YlqX3/9nBTbhemU2IL6HbPMUZkVjAcdEspJbXKWQx03OojXVuLAlIygxHVTJTejK+HAPvTE9GblkxY6NY7cmn6Pa4giArz0WXM18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281108; c=relaxed/simple;
	bh=0IrMSMvFKpqj1lAwdLsZodaIV5l/8Q8O27U8dq1joso=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=s/bd4Tln+dfnLHA3FB2JlmEkWw9DHM49WXxuHsNlzlOLq4Fz2/aNnDMtkzy45y2z+kMWc4YAumWN7Rhopa1bC3cm+BiSuXfuXyTslUvD7P6s1grl6Li+wrksZ2J3FPEK74Zf4TkwUWJwYm1cNPf7K5WgbDgNwxVXTGEZMGCt/ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=E/fPac+X; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia6aSDTVy/sjv9eWQRouY9WVtQaUXSNbfuObYu8b5QTKDJwrmzDfXlCWOF23IjYylSdPh0U/X/ZzckWv5aYFaRY1qmpsn4G8quiWVDzuQ5F8mdfPupMoVhy1q0taD7++cnPXcmHDABHBIEuGqCPjteYhn7/H2l2VgJJDMNZnMrG0sxpVvPtKLe5f5yTczsKhK88x0uA9qrP7kytVOMpqjIxeoVB5iLFv8ZpHPZyQqRCI54hPlg9oxNu/gkcWNTk/IPGqDp4dv6xXgh37g4xDj1fFKy/vhRA5t5htLicIg5MI6fuNwlDKMQtvQ8NTFWvvww14ryow8mVC7eC+Gx2new==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSCKe2OcTqJsvI3kD+f+eWX2tw7eVNsZl5iY1pZu8Gg=;
 b=K/w/a+0JuETUIGrWN5JsBGeTQLgUaF0NXINl+HPPDzrSGwIj2aVaY3IN9b+QHDPpx1PspBezt+3f45BVZWwYqcYO7oNBF0K3s1+ZQewg/TpfgFYyiftuBk4UMxrEIn0/JTSDX60DSXn580jcpmzPESju+THaN6sNGo1haRWlGh6nawwRWDXQaS/FOOHSnrfETqLYdvv0gsByPXoHvFAjeXM9vC6jL7RRo7xQvGnf2vldh2OXZNvIZ3Tbb776SN4wH+6tXyazUA4yF/muv2MQyKav4fNAZa8KutxZkxNVA+mTTxhjIQZgXKyqeO2hRLkewaOcz3nFlYu1iDUHeF/6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSCKe2OcTqJsvI3kD+f+eWX2tw7eVNsZl5iY1pZu8Gg=;
 b=E/fPac+X+mn1O7iiiRkN8vNmUp4bVUKFnXhxGsAXZwZoBTBcqMjq0Y1OjsWPtXWAXzb0fBxN3Bry0B1sj2iu/S6gfZcdKfwBAUMtZmtVx3bk3MZL9WYzI5yrmbSe42tjxo3sEJZ7fjEWDAdaNrx2KM3g660hkGjFlB8ARFVmoOl3gySp/YqL8zSvaHXHcm9vXkypJDJY6VEzbLucB9fOG/PPssn6CdjQnsocHnlzdQi1Hb60ssGEFBKLHOryU6zLr5xixrWApzyEmas5LtPRv/uctC2b4Tve0Zag9/HQcGGD3TatoDLBdfQ1lZ2X/kWVJ4XCyHq8p79QPwFm4sNW4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:58:22 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:22 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Subject: [PATCH v4 0/6] serial: 8250: Add support for rs485 half/full
 duplex on puma/ringneck-haikou
Date: Fri, 26 Jan 2024 15:55:09 +0100
Message-Id: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3Hs2UC/53PsQ7CIBDG8VcxzGLKlSJ18j2MA+UOS2KLgYZom
 r676OBkHRz/l9wv+WaWKHpK7LCZWaTskw9jCbndMNub8ULcY2kGFchKQMORMo93TqPprsRRa6G
 xc3sLmpWfWyTn72/vdC7d+zSF+HjzWbyua1IWvOKN0miNMRYsHKeeQhfDYHh6pImGtLNhYC81y
 5+SLJKrW3BWSOmEXpG2n1Xqm1BLQFTUSRTtf4IyAI1ygNCatTXLsjwB9DVon4QBAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AM0PR04MB6371.eurprd04.prod.outlook.com
 (2603:10a6:208:178::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6371:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab26628-c2c4-4f1b-9d96-08dc1e7f3dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mFNN40mHUbva29mEbqYnAVwUqv9z1GZr2ftvEBBCP0k3BbiCRidSPXyg7xoUkNF5p9kjvGl4OHIOV+TU6D4jFNNjZebss8UlRLavWn0y8024s7CXAknoaGrFFxmMpCT31kTSjJuMZMcBuyFoum+Tljs9GJZ5OTFNwWbfgLv4OybDb3Sd60rpfTsKziuT2dZ7RRWyb82b/LuYcBPi7Ro9w1iIJj2/Itry4UC1CbDdrcjsWOTRqkqhPAZgj6hha/RgULrUp0eHKVVQLd+iY4LUOMx5eXxs5+Le+LDbnHTUTzizIXJNbXRVAZu7/aTkepmnmnfvfNnLIcLliVHolx0w3ZQHPLAT6TRg+QT3uXcxx1hBf+BQm/2ehhRlXxvAJKnZdv/bWA1Nxjg3C+RyHIhUrZfzpNDevw5HamjvZ4rdtLvgDU5buN0lDdaXDm416zf1r2LhpwpjLIaBe3cGtKylRR6DTIet+1BqBpJ8SHYzsSL9y8K658kq6OlipzFexpf+tlCSLbd68xrvG/P3lBl2usragY6buOW8J5Htl+9B3v17BP0Ezqk63mEduVswOzJh+/8r6nCqObguzOwNGG2amvsRGMeeZ0G0l+T2e2HMNjDh4zkuy1NWr45eHLGyyMet7tZtltqlHmUBFuwqL+D+fA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(346002)(396003)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(2906002)(41300700001)(36756003)(86362001)(54906003)(66476007)(66556008)(6512007)(52116002)(6506007)(66946007)(7416002)(316002)(478600001)(966005)(6486002)(6666004)(110136005)(5660300002)(83380400001)(4326008)(26005)(2616005)(8676002)(44832011)(8936002)(107886003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGt1V2pEYmo0UXAwRFlUM215V0RXUTd2M0srdUtGVnVsMU9hSGc5cWdxdU9G?=
 =?utf-8?B?clNGQ1ZVZVVQb0kvSEJseitZSHVjMHRkRmNtNmZXVzIxdDNiNkllUjZwZVhQ?=
 =?utf-8?B?aEtGNWVBU2RKUDZwbWgwVk9lMS8zc0VGSDdlb1AzMnVsQ0RDY2FPUHZYUnBJ?=
 =?utf-8?B?Y3Bma09uMmlqaTYzOCtPSWRFUHp1Y2ZaSDhaVlZNV0x2eWRQeUtxU1hWVHVp?=
 =?utf-8?B?b1FTSjczanFJbWZYeFlEMjdqdUhjUXpKa0YyclZaMXhWMHE2Uld2ZU44VU9N?=
 =?utf-8?B?VG5CNlFoQmErZnZ3R1VGYW1yRVJrY2x1QTV4cDFHWThDYys2aHBJOVhDTVkv?=
 =?utf-8?B?VjlQTlh4NkRjOFZheFY2eFBZSlk5OTB1N2pVYldFK3ExQ3luNFZpcHdwTEsr?=
 =?utf-8?B?L2NSdFNQMTQ5OUJ3eFYwMTF5dnRENVVEV1FaOGFpUVFHOXo1R3VrZUc4NHE0?=
 =?utf-8?B?d3NCL3ozQTFXOS93OUdPaWxQTDRNN2MwbURmTEtCVXc5TFF2eEhIZDRwckd4?=
 =?utf-8?B?eENxVzVGakM4SHhTNkEvYnBYOHRRWkVac1NnQitBNjFoWVlMSjFzTlZUUUFS?=
 =?utf-8?B?N0FxZzJ4cEZWM1BiNjhNdVF0bHlxd0xWR0JIZzFjcXRMZ1JtS1ZFb1k4eHBq?=
 =?utf-8?B?WVlPaXRKRlU5Y1FWQnoxYlp3cTJzMDd5b1cyOWtjcXJ4WGF5TmxWcXgyeE8y?=
 =?utf-8?B?Rm1xRVR5UlNLT0dPKzdQQm83cnZ0RzFrM01zc2l0T29LY2dSdlBLdUw4M3Vn?=
 =?utf-8?B?SFdkbGltTlFPbFVzTUgvMjhGbHg0cmhabExEL3g3UnJvU3EwN0ltWDEyMTNB?=
 =?utf-8?B?NzJqcjE5Y2ZjcktuS0NoOFBSMmZPajU1VVE3T09tRGRhSXcwME9ua1l1eDRE?=
 =?utf-8?B?L3RaMFpMTXJqVjRuY0p4WW45dE1DdFZDNFREc2ovbVB2NGwvajJhNFdybEZv?=
 =?utf-8?B?dG55SkZ5YzBrME81MitBVFo0RTM1TEhocVBqVU1UZ3V5dWpGMk9xUU9kR0FM?=
 =?utf-8?B?djhsTFRjMit6ZGlWK3VDdE5OK2IrVzkrVHo2WS83dVVQVVZ5Z080dk1jd21B?=
 =?utf-8?B?Mm1Jd0ZiZFBZTVpHWXdvWW5uUnNmYUJQSHRCZUpmazZEazVGdlYyZ1psMjJi?=
 =?utf-8?B?SFZQdkYxK1Q2dFFna1BLM0NCNmM0eU44YmhIQmQyK1BkUVFWUkhvUFFhWGJm?=
 =?utf-8?B?UTNKRDdXZVgrMkVpNElBWmx0UWxWeUZPdGhJa1dmZDEybXBuZHQ3cUorV0xR?=
 =?utf-8?B?TG5JeFh6dXVKcGgyNzJyeEdJMnBuQmxYY0hWa0g4YWEza0JLYTkyK2JaeXl4?=
 =?utf-8?B?ZjA2SW1yRjhyYkwxYzM4b0J6RU1nbDZSa3dzWTRhUlllZkUrWEx4dHhGK29Z?=
 =?utf-8?B?T2tmOTd2R005dmJlYVl3UytZdzd1SGhxdVpWcXVhNjB3TGJickh5Y0lIcDJQ?=
 =?utf-8?B?RUtkQnBpK2VKd29IYTd0KzdSRTFwOG1YU1lBTVM2RlVmVjNXS2VHMUxiZlNu?=
 =?utf-8?B?UWo5cE5RbHp4NnpWOXFGU3YreDREallXN05abkRnRjhtc3NlZ1QreHdWUDhu?=
 =?utf-8?B?TTBhdCtMWml1b0hyQWV2WTV4S2NuV0lmcnZVRW9lMEpaRkJ2dlEzQ3Q4aE5N?=
 =?utf-8?B?bnE3Y05sM0xPa3VVS01iQ3ZzTUNUZ1JUOVhSdmZ1UmYzcVpDOTJDcGJkUmVV?=
 =?utf-8?B?U3FzQWVIcjZtQlJneWNQamIvVm94SGdKM29pT0lrN1FnNUFTSjg3YjMzOTFp?=
 =?utf-8?B?emZ2T3JRdGJSTTNJaC8vRTFnTGxtNjFqamR3aVdpb05LcnB0WWdwOXRLekU2?=
 =?utf-8?B?LzkybzJpUUc4SEEveXFWUFVUVldSY2h1YUhUN2l3K2NjeVBRU3pPVTV4UjFQ?=
 =?utf-8?B?K0RQQ0FCdmNRS0FzUmhNRzNoVURrSjJaeTJjWERuWlJ6c3JrSXNQMWNlZUJC?=
 =?utf-8?B?L2FVZWF5Q2pFa2RNc1plbGFiWVcwMlZBZXdVQ2tEeGd4ZE9LaGdGZGJFNUg0?=
 =?utf-8?B?S2FheGRhaWFab3R2WG1KdVgxbTh1NXJjOXZsMWcyMjROVTFGdDlLemMxckZh?=
 =?utf-8?B?eWV6TTcwdHp3RGZycnVtWmowWW85MENPeGFSM0FFRTNTOUw4WmJXNU1RRXd0?=
 =?utf-8?B?T2t5VWUvcHV0dUFpMTkwSlVidHptZ3U3aUJGTzh6eFdoTzZmUzM2Ly9OeHV2?=
 =?utf-8?Q?UVwOJKgCqzjlLH9dYJv9zvI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab26628-c2c4-4f1b-9d96-08dc1e7f3dc0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:22.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeSGuZmu9qCPFvvOIpSNzVCfGrZN0oizEye4J68g6kGtKTKk8Z88apKkHfszdHgjgQqW++xZ/ukhxMCLslS0MIrkG8v/MdAlbESHyXhcgD+zei6ZCkERm4l116zDpfpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

This series tries to revive the work of Heiko Stuebner from 2020

On the boards that we are using (ringneck/puma-haikou) a hardware switch
can set the rs485 transceiver into half or full duplex mode.

In half-duplex mode the DE/RE signal of the rs485 transceiver is not
connected to an RTS signal whose control is already handled in the rs485
emulation (start/stop callbacks), but rather to a gpio. And since enabling
the receiver requires setting this gpio active we need to do that in em485
while receiving and disable it while sending to enable the driver mode.

In full-duplex mode RE is grounded and separated  from DE. Meanwhile the
rx-enable gpio remains connected to the DE pin. In this case the
receiver-enable gpio should be disabled to enable driver mode in parallel
to the enabled receiver.

This patch-series adds support for controlling the receiver mode using a
gpio in em485 for half-duplex mode while allowing users to keep using the
full-duplex feature if em485 is disabled.

Changes in v4:
- define the state of rx-enable gpio when em485 is disabled
- add rs485 half/full duplex support to ringneck/puma-haikou
- use dev_err_probe instead of dev_err if error is -EPROBE_DEFER

Changes from the 2020 submission include:
- external gpio for optional receiver-enable handling

Link: https://lore.kernel.org/all/20200517215610.2131618-1-heiko@sntech.de/
---
Farouk Bouabid (4):
      dt-bindings: serial: add binding for rs485 rx-enable state when rs485 is disabled
      serial: 8250: set rx-enable gpio state when rs485 is disabled
      arm64: dts: rockchip: rk3399-puma-haikou: add rs485 support on uart2
      arm64: dts: rockchip: px30-ringneck-haikou: add rs485 support on uart5

Heiko Stuebner (2):
      dt-bindings: serial: Add binding for rs485 receiver enable GPIO
      serial: 8250: Support separate rs485 rx-enable GPIO

 Documentation/devicetree/bindings/serial/rs485.yaml   |  9 +++++++++
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts   |  4 +++-
 drivers/tty/serial/8250/8250_port.c                   | 11 ++++++++++-
 drivers/tty/serial/serial_core.c                      | 12 ++++++++++++
 include/linux/serial_core.h                           |  2 ++
 6 files changed, 38 insertions(+), 2 deletions(-)
---
base-commit: 5ebe731c2a586b379103f736cd498bcca3cf1ea9
change-id: 20240125-dev-rx-enable-d8818dbf7c28

Best regards,
-- 
Farouk Bouabid <farouk.bouabid@theobroma-systems.com>


