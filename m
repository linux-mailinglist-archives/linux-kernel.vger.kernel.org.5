Return-Path: <linux-kernel+bounces-50165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE784752A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA0429361E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168911487F1;
	Fri,  2 Feb 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="BZ/82imj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF9148314;
	Fri,  2 Feb 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892158; cv=fail; b=qb8u0Ad+3Ci8Dog8Z0SvSKu4Ef8gstAHIKx937YUAhVR8JdrNoJYozHRLMqXYIXXQY6dk2s5JO+yMUC/Am1npZEmQPj+uzwtdfpj+hLU4qpsq6nyonr1NW+t+xfS5CSnrslxtMVgN4ZCcmVWWSQxg47t8k65YJT/TW7XDuB/ANQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892158; c=relaxed/simple;
	bh=qBJ2JApTIZg3cxwUYvY1ZnDllIOHGiRP35QKsIy1VEA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I2gq5N4ypCZjb+0kDmDLNkcVvUa71XZfeLmkGeIHIBR6DMkIdWagn2W0t1zpe2tBTSB3o8g4MRhP02LdTzIuWt+Kp/AwDdpXwRG7n+PL3KQyvoavoMMyyTOZPQDUgi4E915JZGH4/LJlppo9lsqRwpl6bYKjeUdOCCkhFtP//2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=BZ/82imj; arc=fail smtp.client-ip=40.107.223.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZcDr0d0yYwj8eiCH56rBjQvrF+05TTT89uTiw4ucIvkyhtBWKpvUfuvnkvHnqp/p+dSj8+ybXpMtWmpRgeoQV+OZ7hbGlhzcPsuGiv8tSoUn6plNdXq0Rz5Pp/CZb4Apv7Qmhzv2kCiKBfCFTh/mNVlQk3JZ2wFl/RF2cYyTuxE8WfT2+bnZC0m6h6AiWWNDCUAcaBNhwBSvWIUJbvKdjIZF9Ho5Ut7m9V8OHLf/BWZkPDnDICVgoxSetYbjttiIgbBzRtcEdmwzduAlgYrR7NpMxk+ZRd7CM4yKdiAO5jSjO3VlpwrRB2yVfd/f1cZVcl3JyhXWctDBoi+vfn6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBJ2JApTIZg3cxwUYvY1ZnDllIOHGiRP35QKsIy1VEA=;
 b=UoENP4zJBPuhn/CbRC4a8g56PLF4iG9iAzCBVGDTXo/qFyahOG+mw+RT9j23MKc6urFT5qoceuKPO0ZdbiTt6j03C7JhO6bnqNDLMOCUAINlmocxjAO1jpVqBndbRkmWTWRRVOWg+lRUyocFn7xvzc2XOVOHiqY3tJYPNWROYaJeaFTN/4YGJKdFNvxQYrWZuP6k2XGQ8uOoVB4rKSmo0zNBFN7l1Yhe8HnhazB7Jr9030B8Z6lnVkKyZeY1eKMyFdlmUNy4AfEHzxmqRRB5vxjm/znpf62RUzapGYtjwIhAyrvuuXdVg6aj/IbGxZtZhRtrqTD79OTP3izKi4mjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBJ2JApTIZg3cxwUYvY1ZnDllIOHGiRP35QKsIy1VEA=;
 b=BZ/82imj0tf0++Qg834QunLPQ5P1raWpgHQPS1VwdMl9l9AWuEMPa0ZrUlJXucKXkbSE00HXNb0JUlEc9NZxgGiPMSJ51B7RoLLWCYPuit/I18ccG2Ctq9TTdh/ftflEngYCPTtW92bx+aUBk/I7JSDo6ag6taBhoBQWW8+jma4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 16:42:33 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::f9c5:aaf6:b3e7:ddcf]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::f9c5:aaf6:b3e7:ddcf%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:42:33 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	linux-devel@silabs.com,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Ulrich Mohr <u.mohr@semex-engcon.com>
Subject: [PATCH] wifi: wfx: fix memory leak when starting AP
Date: Fri,  2 Feb 2024 17:42:13 +0100
Message-Id: <20240202164213.1606145-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR3P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::12) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0b9ebd-fc36-4065-115e-08dc240df42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lDEQkH6ded3+pqa57EsqGH5IBEJ1SWZE2tTJr/0IjY/qGuiLY5CPf84+uQOo4IxKjwgiiY/7QkEKIiSMw1oVESk/R9+JMWCcXBV/Zu6GSoPQJE+S7wHKBVfrOg+5SUF0jRXWEpbW7yMdAGFnzLxa7IJU/72+Iayw9h3ZUklSIv/OkzSa0QL0fa+rR+aJ98qvBon9C8GSYe32QP5ik0AjdOC8ure8rEBXIJ+0H6ys4PmRDPOjRcQrmTyO1Su8DQHP0il7v7RqGeX//U9IXqKKTc43OoiiSmzpmVSpg6dGjM6Gqsi28WyAJdDPfgiLdJPDBZRk+/4p0plfvq42bCKEbHy0uIrddJ6jQOVOVonhRd8hXo9BTi1hKX5p0fqGXZNrectq7+R7lrrW2ttr/RhAv9wC/H+h4zr2Q8t9ZbX9RGaiif0ybOSsEoGyxe88aqbC1w7Vm8NEfCCjqf4egT6XGA+nQfe38yNxUuzcWnf9cMYBDQ6U2TRqoVGIMtAxLKVs/KjVdH2IFUahXQ9ZF0ic0JTaW8YLf2aFFfxTQ0wrFGSXiynCdSuLqlJivFYcekdQ5KlWITWbS2V9Om7yNi507wWQdIzCbIUWdwJbPFXhk+hByAAHfJoUB6l+WKKZQ8ETMI9odulx7/h7iUTMkIISYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(36756003)(41300700001)(86362001)(38350700005)(8676002)(54906003)(38100700002)(1076003)(6512007)(2616005)(26005)(66476007)(2906002)(8936002)(6506007)(478600001)(6916009)(6486002)(66556008)(316002)(5660300002)(6666004)(66946007)(52116002)(4326008)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3VLWHR6ZzJzdzVRZjRORzJwVWpaZGNyUTU4WlpzVnozY01XSkhLUWp4MDlM?=
 =?utf-8?B?R1JLUFdFRytXYUlXZjA1d1kxaGovK0txYU9EMGY3eTd4MkNpY3ZFQUtjRk9s?=
 =?utf-8?B?NkVEZDFBWFpOcjdpbXRMQXlMZklOTnhsUFhmQnBLdXpiNDc1TzJVVDY4eEdN?=
 =?utf-8?B?Vm5TSTllWFliUXoyZ2JOWE9LUzNuazBCcTFRcytrSHM0SVhxSXRnT1lYZFVn?=
 =?utf-8?B?NGtOdU9weWRZcDBZMzZvQ0FuMGcvM1RVbFNaaVJTejMvUFAwL214Tm9sVm5r?=
 =?utf-8?B?blFndE5hOStRS1FvS0t6b2R3MzV2cGplRkRFbVhnR2xLc2tIbWY3MWtGVms5?=
 =?utf-8?B?SkhQa0lsWWhxZ09tVC95dG51QXNhWk8rNmp6TFZvcXRoZ3ZyMXZkOU1SOGxl?=
 =?utf-8?B?a0FSeGtkL0pqQmNVb2hwNFlpdzlNdGpGa0MzakVsQTdaeGZFMjJiVVVISlls?=
 =?utf-8?B?S2N4MjhtNUJIazVGeU9GTzkyeXBHZldrNjk5MmJDeXRTRnZ4Z1RsVVpnV1Av?=
 =?utf-8?B?a0d6M2FKMjJYbmxoUFFCTDhQdmQ1R2pya0tkS1Y4bEVNY0JaQTZ5L3UrNFZ1?=
 =?utf-8?B?d2M0OUU5SUl3bzZOOUhKOTNhc01jMGFnYmFlRUdvWGJFV0ltNW1ZVzVXNWll?=
 =?utf-8?B?OWIwbkRLOWVyVU94d1BZNkFtT3B2YTBIUEw1MTZuNnhVcDVHTmJZYzJXQ25i?=
 =?utf-8?B?YmN2eTJVd1ZmQW10Q29JbHFKNmMzbDFHbFRzWkFFWHhWODlqcGExSXB5ZnpO?=
 =?utf-8?B?Q0FKeE5FWDU5cml0YmJnZXdDc1JKOE1zcEVpaWhnSzJRamlpbGZtalFLZERj?=
 =?utf-8?B?K2ozelJjdGlNUHh1RVpUN0hzSksreEJqUUx2Y2Nqa0djWmpuL05nclhBTmpM?=
 =?utf-8?B?RFgrRFVlYTFXaVdXOTU4dHhiL1FQc2phZnIwMEh0WXUzQXg1OWdlc200VFJm?=
 =?utf-8?B?bDd3RmxXek9jSml2dWQ4Q1RsbVZ4T3NFQWVaV1lneGxPaU5TV2djN0IveE1X?=
 =?utf-8?B?NkZBOHhYakc5WHIrcWJ1cEE5K0NhdkVlRU0zM3VpVFViUy9NbW9ZSzBYTUVr?=
 =?utf-8?B?azlJYlRsbnZPM1hWKy8rWjFHYXJIR1ZWYStsQnlSSWVRZzdSbU11Mm9zVlB4?=
 =?utf-8?B?ejZ0L3hYaktIQ2hvRmpvOFIzYjRlK0w1c21MbU5Fd212di9NQnVYMnNrcjlN?=
 =?utf-8?B?WmJmTTIvczhxUUpUSXc5SFNySkJNR0VORmhEVFA1THIwNDFLaldNWmY3K2hz?=
 =?utf-8?B?NE9CbVpMckRkTmlZYmtTZTdPc1QyMDJZd0JQVFRLNlVqcjc1WXpMc0pNQklz?=
 =?utf-8?B?Z3JVRWRNRE9EZnFHR1RsTi9lMk0rU1F5RDllQjBwUTEyNkR3VUk2ZDl4MXF3?=
 =?utf-8?B?S3FFWEJvK1p2UWZONk5GbVNaMFVoTW9TQjM0L1F0TEE5YjdXMkZPb2piYmk3?=
 =?utf-8?B?V1lkSVZha29qTkFIbXoyOGRlNFhSQXlKKzZNb01KZnJvQmhmU2IwZ1RWeUNB?=
 =?utf-8?B?Rm4yRTdueEdDRGJrc3RqWm5vNEk0NUtBWHU3Unk1QWkzYjVESHNPQjVLRGVH?=
 =?utf-8?B?V1FPOTFpcGMwTjE4bVBibG5VZGxrVGNRQk9BdkpNNUNKTnBOY3dYdzd4a3N6?=
 =?utf-8?B?L2ZNaW9wVThibERLY1hSUytaenNwbHV4Q2JWZnFEQmIyWmVMdUM0WWtxeHVZ?=
 =?utf-8?B?SlFEUjFHTVFzSTltZHQwdTRyRE9mR3ZsRUp6dzl3NzRycUJPamZORHZyMjFX?=
 =?utf-8?B?YUFQQnMyWHl0MmM0L1BTTzNkK212RlFHVXI5SzUxMFBBbVdNK0xzK0ZlNDBV?=
 =?utf-8?B?b1hBaXVGL29GTUhyUFV6LzRlaFkxRDF6TS9MdHBBaEloRG5SNDNtbDJVY0Er?=
 =?utf-8?B?bUtyaVNJOTB5MTEydDRBYzIyVEcxMjRDK1JhaFRBWFRUSEQyelJEaml6WGk0?=
 =?utf-8?B?OTl0K2NLSHNJdGV6YS9iR0ttaEFLOHlIYWcvR2lkeFNEZHJIVXBZTE5XY0Rk?=
 =?utf-8?B?clU5MGdzTTJiSmlVUkJQZ3ZsNG90K3ZVQzI3cFpJT2NaMko2eS9KVmloS1dX?=
 =?utf-8?B?WTVnNVpnTXgxWVc4T3NKbmJ1Q2YyWm9pRzRKU1dmOHNqUU9ZMVNQU2d2SXJs?=
 =?utf-8?Q?6ThjkfyI3YyR6q/eRxP/9fKld?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0b9ebd-fc36-4065-115e-08dc240df42b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:42:33.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEk2NKJB1ltqMnyDeNP1VufoB4U/AAohbxDrvcStLeCJpNbZyPL83Pbqmgmu4UcjuFT05DtrnbMUGOBgkZLUvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173

S21lbWxlYWsgcmVwb3J0ZWQgdGhpcyBlcnJvcjoKCiAgICB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4
ZDczZDExODAgKHNpemUgMTg0KToKICAgICAgY29tbSAid3BhX3N1cHBsaWNhbnQiLCBwaWQgMTU1
OSwgamlmZmllcyAxMzAwNjMwNSAoYWdlIDk2NC4yNDVzKQogICAgICBoZXggZHVtcCAoZmlyc3Qg
MzIgYnl0ZXMpOgogICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMWUgMDAgMDEgMDAgMDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgYmFja3Ry
YWNlOgogICAgICAgIFs8NWNhMTE0MjA+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MjBjLzB4NWFjCiAg
ICAgICAgWzwxMjdiZGQ3ND5dIF9fYWxsb2Nfc2tiKzB4MTQ0LzB4MTcwCiAgICAgICAgWzxmYjhh
NWUzOD5dIF9fbmV0ZGV2X2FsbG9jX3NrYisweDUwLzB4MTgwCiAgICAgICAgWzwwZjlmYTFkNT5d
IF9faWVlZTgwMjExX2JlYWNvbl9nZXQrMHgyOTAvMHg0ZDQgW21hYzgwMjExXQogICAgICAgIFs8
N2FjY2QwMmQ+XSBpZWVlODAyMTFfYmVhY29uX2dldF90aW0rMHg1NC8weDE4YyBbbWFjODAyMTFd
CiAgICAgICAgWzw0MWUyNWNjMz5dIHdmeF9zdGFydF9hcCsweGM4LzB4MjM0IFt3ZnhdCiAgICAg
ICAgWzw5M2E3MDM1Nj5dIGllZWU4MDIxMV9zdGFydF9hcCsweDQwNC8weDZiNCBbbWFjODAyMTFd
CiAgICAgICAgWzxhNGE2NjFjZD5dIG5sODAyMTFfc3RhcnRfYXArMHg3NmMvMHg5ZTAgW2NmZzgw
MjExXQogICAgICAgIFs8NDdiZDhiNjg+XSBnZW5sX3Jjdl9tc2crMHgxOTgvMHgzNzgKICAgICAg
ICBbPDQ1M2VmNzk2Pl0gbmV0bGlua19yY3Zfc2tiKzB4ZDAvMHgxMzAKICAgICAgICBbPDZiN2M5
NzdhPl0gZ2VubF9yY3YrMHgzNC8weDQ0CiAgICAgICAgWzw2NmIyZDA0ZD5dIG5ldGxpbmtfdW5p
Y2FzdCsweDFiNC8weDI1OAogICAgICAgIFs8Zjk2NWI5YjY+XSBuZXRsaW5rX3NlbmRtc2crMHgx
ZTgvMHg0MjgKICAgICAgICBbPGFhZGI4MjMxPl0gX19fX3N5c19zZW5kbXNnKzB4MWUwLzB4Mjc0
CiAgICAgICAgWzxkMmI1MjEyZD5dIF9fX3N5c19zZW5kbXNnKzB4ODAvMHhiNAogICAgICAgIFs8
Njk5NTRmNDU+XSBfX3N5c19zZW5kbXNnKzB4NjQvMHhhOAogICAgdW5yZWZlcmVuY2VkIG9iamVj
dCAweGNlMDg3MDAwIChzaXplIDEwMjQpOgogICAgICBjb21tICJ3cGFfc3VwcGxpY2FudCIsIHBp
ZCAxNTU5LCBqaWZmaWVzIDEzMDA2MzA1IChhZ2UgOTY0LjI0NnMpCiAgICAgIGhleCBkdW1wIChm
aXJzdCAzMiBieXRlcyk6CiAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAxMCAwMCAwNyA0MCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uQC4uLi4uLi4uLi4uLgogICAgICBi
YWNrdHJhY2U6CiAgICAgICAgWzw5YTk5MzcxND5dIF9fa21hbGxvY190cmFja19jYWxsZXIrMHgy
MzAvMHg2MDAKICAgICAgICBbPGY4M2VhMTkyPl0ga21hbGxvY19yZXNlcnZlLmNvbnN0cHJvcC4w
KzB4MzAvMHg3NAogICAgICAgIFs8YTJjNjEzNDM+XSBfX2FsbG9jX3NrYisweGEwLzB4MTcwCiAg
ICAgICAgWzxmYjhhNWUzOD5dIF9fbmV0ZGV2X2FsbG9jX3NrYisweDUwLzB4MTgwCiAgICAgICAg
WzwwZjlmYTFkNT5dIF9faWVlZTgwMjExX2JlYWNvbl9nZXQrMHgyOTAvMHg0ZDQgW21hYzgwMjEx
XQogICAgICAgIFs8N2FjY2QwMmQ+XSBpZWVlODAyMTFfYmVhY29uX2dldF90aW0rMHg1NC8weDE4
YyBbbWFjODAyMTFdCiAgICAgICAgWzw0MWUyNWNjMz5dIHdmeF9zdGFydF9hcCsweGM4LzB4MjM0
IFt3ZnhdCiAgICAgICAgWzw5M2E3MDM1Nj5dIGllZWU4MDIxMV9zdGFydF9hcCsweDQwNC8weDZi
NCBbbWFjODAyMTFdCiAgICAgICAgWzxhNGE2NjFjZD5dIG5sODAyMTFfc3RhcnRfYXArMHg3NmMv
MHg5ZTAgW2NmZzgwMjExXQogICAgICAgIFs8NDdiZDhiNjg+XSBnZW5sX3Jjdl9tc2crMHgxOTgv
MHgzNzgKICAgICAgICBbPDQ1M2VmNzk2Pl0gbmV0bGlua19yY3Zfc2tiKzB4ZDAvMHgxMzAKICAg
ICAgICBbPDZiN2M5NzdhPl0gZ2VubF9yY3YrMHgzNC8weDQ0CiAgICAgICAgWzw2NmIyZDA0ZD5d
IG5ldGxpbmtfdW5pY2FzdCsweDFiNC8weDI1OAogICAgICAgIFs8Zjk2NWI5YjY+XSBuZXRsaW5r
X3NlbmRtc2crMHgxZTgvMHg0MjgKICAgICAgICBbPGFhZGI4MjMxPl0gX19fX3N5c19zZW5kbXNn
KzB4MWUwLzB4Mjc0CiAgICAgICAgWzxkMmI1MjEyZD5dIF9fX3N5c19zZW5kbXNnKzB4ODAvMHhi
NAoKSG93ZXZlciwgc2luY2UgdGhlIGtlcm5lbCBpcyBidWlsZCBvcHRpbWl6ZWQsIGl0IHNlZW1z
IHRoZSBzdGFjayBpcyBub3QKYWNjdXJhdGUuIEl0IGFwcGVhcnMgdGhlIGlzc3VlIGlzIHJlbGF0
ZWQgdG8gd2Z4X3NldF9tZnBfYXAoKS4gVGhlIGlzc3VlCmlzIG9idmlvdXMgaW4gdGhpcyBmdW5j
dGlvbjogbWVtb3J5IGFsbG9jYXRlZCBieSBpZWVlODAyMTFfYmVhY29uX2dldCgpCmlzIG5ldmVy
IHJlbGVhc2VkLiBGaXhpbmcgdGhpcyBsZWFrIG1ha2VzIGttZW1sZWFrIGhhcHB5LgoKUmVwb3J0
ZWQtYnk6IFVscmljaCBNb2hyIDx1Lm1vaHJAc2VtZXgtZW5nY29uLmNvbT4KQ28tZGV2ZWxvcGVk
LWJ5OiBVbHJpY2ggTW9ociA8dS5tb2hyQHNlbWV4LWVuZ2Nvbi5jb20+ClNpZ25lZC1vZmYtYnk6
IFVscmljaCBNb2hyIDx1Lm1vaHJAc2VtZXgtZW5nY29uLmNvbT4KRml4ZXM6IDI2OGJjZWVjMTY4
NCAoInN0YWdpbmc6IHdmeDogZml4IEJBIHdoZW4gZGV2aWNlIGlzIEFQIGFuZCBNRlAgaXMgZW5h
YmxlZCIpClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJA
c2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIHwg
MTUgKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4
L3N0YS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwppbmRleCA1Mzdj
YWY5ZDkxNGE3Li5iYjQ0NDZiODhjMTJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L3N0YS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
c3RhLmMKQEAgLTM0NCw2ICszNDQsNyBAQCBzdGF0aWMgaW50IHdmeF9zZXRfbWZwX2FwKHN0cnVj
dCB3ZnhfdmlmICp3dmlmKQogCWNvbnN0IGludCBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfY291bnRf
b2Zmc2V0ID0gOCAvIHNpemVvZih1MTYpOwogCWNvbnN0IGludCBwYWlyd2lzZV9jaXBoZXJfc3Vp
dGVfc2l6ZSA9IDQgLyBzaXplb2YodTE2KTsKIAljb25zdCBpbnQgYWttX3N1aXRlX3NpemUgPSA0
IC8gc2l6ZW9mKHUxNik7CisJaW50IHJldCA9IC1FSU5WQUw7CiAJY29uc3QgdTE2ICpwdHI7CiAK
IAlpZiAodW5saWtlbHkoIXNrYikpCkBAIC0zNTIsMjIgKzM1MywyNiBAQCBzdGF0aWMgaW50IHdm
eF9zZXRfbWZwX2FwKHN0cnVjdCB3ZnhfdmlmICp3dmlmKQogCXB0ciA9ICh1MTYgKiljZmc4MDIx
MV9maW5kX2llKFdMQU5fRUlEX1JTTiwgc2tiLT5kYXRhICsgaWVvZmZzZXQsCiAJCQkJICAgICAg
c2tiLT5sZW4gLSBpZW9mZnNldCk7CiAJaWYgKHVubGlrZWx5KCFwdHIpKQotCQlyZXR1cm4gLUVJ
TlZBTDsKKwkJZ290byBmcmVlX3NrYjsKIAogCXB0ciArPSBwYWlyd2lzZV9jaXBoZXJfc3VpdGVf
Y291bnRfb2Zmc2V0OwogCWlmIChXQVJOX09OKHB0ciA+ICh1MTYgKilza2JfdGFpbF9wb2ludGVy
KHNrYikpKQotCQlyZXR1cm4gLUVJTlZBTDsKKwkJZ290byBmcmVlX3NrYjsKIAogCXB0ciArPSAx
ICsgcGFpcndpc2VfY2lwaGVyX3N1aXRlX3NpemUgKiAqcHRyOwogCWlmIChXQVJOX09OKHB0ciA+
ICh1MTYgKilza2JfdGFpbF9wb2ludGVyKHNrYikpKQotCQlyZXR1cm4gLUVJTlZBTDsKKwkJZ290
byBmcmVlX3NrYjsKIAogCXB0ciArPSAxICsgYWttX3N1aXRlX3NpemUgKiAqcHRyOwogCWlmIChX
QVJOX09OKHB0ciA+ICh1MTYgKilza2JfdGFpbF9wb2ludGVyKHNrYikpKQotCQlyZXR1cm4gLUVJ
TlZBTDsKKwkJZ290byBmcmVlX3NrYjsKIAogCXdmeF9oaWZfc2V0X21mcCh3dmlmLCAqcHRyICYg
QklUKDcpLCAqcHRyICYgQklUKDYpKTsKLQlyZXR1cm4gMDsKKwlyZXQgPSAwOworCitmcmVlX3Nr
YjoKKwlkZXZfa2ZyZWVfc2tiKHNrYik7CisJcmV0dXJuIHJldDsKIH0KIAogaW50IHdmeF9zdGFy
dF9hcChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwK
LS0gCjIuMzkuMgoK

