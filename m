Return-Path: <linux-kernel+bounces-151681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B18AB1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60A21F23FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60E130A4E;
	Fri, 19 Apr 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UBcffJom"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBE12FB36;
	Fri, 19 Apr 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540931; cv=fail; b=cj0cVioeYOnT7Qh7GYLbsqPfyJoXXWDdm75ZBXVwExJvX3ql/jX7gBWhE0eI/oFwIWAtGGYGMkMZrikU60wNqSMigLrwSyxJphwaMBjVPBBXstf3FK4KoxfQ59HOxrBuuZfE69sus6bGxot8VxPjaMIGenjQ0+89h8wRsHykYRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540931; c=relaxed/simple;
	bh=N6H7YL7f0PmyoeVx37xKKuZJNaCks/iFeWs5nfQCXAg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qR3sjOlNPZKeDL9+7cCg8f+Qe80RCnHnL7m3ESies4cu+lSWDJjlN9IJu4RZPKqMH8PqIEqkUM52nclZKSlxiSbws78n8DjfqjErEPmHvhGmTDUj/C530szabzoxPAhZ8OnI5p3vYHHq2txALkCfVNkppuFsfQ5U4VTT+QrUz7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UBcffJom; arc=fail smtp.client-ip=40.107.104.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpQhgwurlNNp2ZCqx+SlLkrppFsIEmzJkN7J6FejJBBSo7slND5mrq0ExANh5vsCcpJG5ICjeLntI2/FdHl3o9nmRX5zFq2Fk/CCDs0UBaOq2LBJmMIX0/mjMUkfCC/3gyOHEF97c6JecWxCzHEgRQxGtroSn6qtXzgWPZ92rGspg0SZV1HFUlEKkse5pwhdcBy78rdECtTuGmzit5FT2Jgq+UJIo/qWoDopnJk9TV9HEjOSolpV2wWs+7W6A8GoQcoUolJNenOToduJ8I9jsJjWd2XUTYUF5z1aeQhgmgDZlQlf8CoYq3wnDgbsYrmcerxFNw/7pteys8O0kP5C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg50pzHC35/sx6AzZuqlrk/cXNBJs3dyU+JjycmuXpI=;
 b=T63s4XZ3oJvji8kIUtUCW4h22EERTrbXS0aB5RKerCZp37XkMN7APUabTlxZXQSC8aApObQTg/aE3nFywVGfAlfQaFiWV84CxAQ7SEsntQYbqhh+gpEByn22PleKoXYvUfhy+/fUrv1SGOdSjheGLT4KuF6UiLCeZehDMFJLxDeK7NMwSy5Ho14XTyXPaOuyrEO5EIbTJ1nEJbFbotM/x7eCvIqE19pM7P9HBAyr813uyczM6ooGjUsx94qG8iPRDj844FUKrqMo1nEe5HIx/FK0WjrIV4tJOeQnf3F6Nk2Zz201qSaWKcYUFxw4dgIv5BJNKH1fz8JRW7WN0QaCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg50pzHC35/sx6AzZuqlrk/cXNBJs3dyU+JjycmuXpI=;
 b=UBcffJom5EkvMvxD7wMLvsHYM3faDI5r3wqwD8+9osiZrU7OSbG0zeE+E2Oz176u05I5TqvvLUCtEpcGY33QdNZji8QPVJ3heqGt3FjKlXgq/DRpe3/kck/T9R8kizlLRNwtC6qrUiM7jvcaLV3o9t0h5u4ORgRJKSMmOuHyjcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:35:25 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 15:35:25 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 19 Apr 2024 17:35:17 +0200
Subject: [PATCH net-next 1/2] dt-bindings: net: adin: add pin polarity
 properties for LED_0, LINK_ST
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-adin-pin-polarity-v1-1-eaae8708db8d@solid-run.com>
References: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
In-Reply-To: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 603bae6d-8e95-4613-e714-08dc60865570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NRVjlHM3dBUlJhSndDSlMxNnNtSXlRY3lGQ2hSY2ZaRUJYQ1BmQmMrZmQ3?=
 =?utf-8?B?WEkzM1JuZ0Z4YTFuZnhHd0hadXQ2MFg3VkZJaFovVkROUVhUeWtybFFvd3hG?=
 =?utf-8?B?MkdjbXFRSnJwblVLTThxWnRSUW9lZnB4VnBiWjkwWmVadUdVdnFQcElpT25L?=
 =?utf-8?B?TVhlV2xOUE9WVGdMVmNjMmpGbEE0MTcxeC95UnJWTUpJa2Vhc2FFRC9MQzZX?=
 =?utf-8?B?dHh5YzR0eFg1SWlUci9iU1Y3emNpT0FPVkZpakVqQkh4VUNSZVlZS1YwTzND?=
 =?utf-8?B?ci9ieFRQV1VaLzhobTVCYXBPRGFoalpWU3ZaenRvWG5ZOFFpV056bHhTaVY3?=
 =?utf-8?B?SjZRY2U2RWJISHVvWjUzZnc2bjhGL3BOSndYKzFXOUZxZVNxTVByTFh3UCs2?=
 =?utf-8?B?eGYrZncwVDJxVFlydDdBVEF6U1lUMEc4VGhOU3dSVWxNb1ZZRUdWK3ZBb3Ft?=
 =?utf-8?B?Q0tGWVdpL2NnSHFsTUJKL3dmMXRTWDhJYlhOd1ptN2x4UTlySkNpMXBjTHRS?=
 =?utf-8?B?QmdCYzQzTWljLzFxUGtoeVNDeGJENG5XTFFLV2cxZHVhUUJOTE1jVlBNNThu?=
 =?utf-8?B?d3hic0xkTHd5SVNiWWpkUnp5Wi9HVDFCWGVGdXhDNVFkYUhzMG9xd2liS2xV?=
 =?utf-8?B?TlJYc1ZjOFAyc2J5NnJFblNiTXNIN0NyYVpvWEs1WmJDdHowc0JRSmwxSTQ5?=
 =?utf-8?B?bGRIRVZWNUdRSm9BNXdOajN2WFlnVGNmYzlNOWlLSk9idWkrdUVwSWQyZXZO?=
 =?utf-8?B?S0dsRC9OUTFmQWVUbjBPSDVFK0tlc25CcEFQQ3hsZzgxdjNVWXNkR0dFOTFD?=
 =?utf-8?B?bGt5aDBycVlDNm9DZUM0MEw4RmJoeXFaVVJXbnh1cm80dG11bStRSTJUMEp4?=
 =?utf-8?B?QjRKcTAyQUNJWGVuRExKMnlLRUNzcGZBdmhaSnNnOHFXeGVmKzg2QWNyRHg2?=
 =?utf-8?B?akJ6eDhyVFNnWmI0VCtYSVlnc3NSZW9nTTFRa1o3QnR6REZOMWVOaUVPRnVP?=
 =?utf-8?B?elhQSm0wMC9nOGpzTnR1SmMwZi9wbUhQbTFqV2VGZmRtdW9NbzFCenU2OHBa?=
 =?utf-8?B?bFJRZ0pEaHJTNWg0RC9DcXIwQzBpN0lmSHp0bXNnYlhoSzVXK040VVZwcEta?=
 =?utf-8?B?dXlXQVVkb3k5QkJHRUZFS25QMVZlMkFKR1pFOVd6Y1pITElPQW1vbERiMmYv?=
 =?utf-8?B?dTZyRDBjREp6RzduMDExalI4N2I0RHcxQ1FZY1JReU1XNGRDdlFjNTZ0ajZR?=
 =?utf-8?B?M2I4N095bitoeDhRNzA4VUxlTlJ0ZjJzY2RrUlBraDF4K0p3Vjk3SE1pLzAx?=
 =?utf-8?B?K1F1M3ZoTlRGVHlncmF4a2NYMXB0ZW9hbTZzL2dKcW9Cd1luemRUUFBHSng3?=
 =?utf-8?B?aWFHTjNvdS9DbGhhdTZQWUN4TkJMSEtleXlObUtSd2JNb0FZeXJ1d1kxelpN?=
 =?utf-8?B?RlNBWVFueGF1L1FwSC9vSkFhRDIwaVp4cXRSNTVDcFhhVjU3dEJQMkJBR0tI?=
 =?utf-8?B?NVNQdnA1R3hMUERVUmlYYUpBTVhNZWxBYS9oYnFEcVJsSzNGQlVJY0NydnQ0?=
 =?utf-8?B?cWdBRW10aEdyYjFYMlFOOS84ZmxkQ2NMdXd0OFQ3V0N1L1JHRm93V1FURmJL?=
 =?utf-8?B?OUNkczZwNU44aFNpazNZeXF4QS8raVlNWmRub2k3MGl0WThBZXB4OWpXcDJQ?=
 =?utf-8?B?Qk03Y1ZlM0N2RnhsVzl6NDRkVlRpa21DL3JOMGJvWUUvUFFOa1VxYWlIeXNm?=
 =?utf-8?B?UytBcERHVzVBWHZRcVBFZWsrVUlCUENEc1hMU3ZjTld0QkdKK21ILzlzdzlQ?=
 =?utf-8?Q?zV1YcPLe0oFM93ck4asI4MU567pT5kP7hIrWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SldDNGkrWW1ZUzBxMHZuOFVtMmlEYnlDTDFpbWMwdmxYT1hPK2ErVnZaZFR2?=
 =?utf-8?B?Y0ZxNkNYNEgrWjZqYU5VNnF4RDFkM0V3NXE2SVNYZUpUNis5OE55YWZBbHpL?=
 =?utf-8?B?VlpRVUJMVTlZaDNoMEFpYytEUXYyWmhQUkgyeVFHc1FpTVdjYUtIend2dlo5?=
 =?utf-8?B?dmRmazByWHVQMHE4amdZTG10aHFUUUtXK0g1Y0xMbXF4YmVlZEpoNGNxdDhi?=
 =?utf-8?B?UkhvRVQ2Yy9SbWtlM0lDaHkwUEJlS1ZXQVR4WVAxcXVaR0ZSSHlEdkJvQUwy?=
 =?utf-8?B?WEhnQnNNNGFoMkJyaWFmRzNUeE55SVlXSjdnVDRpQjRpOGhJdWRwem1xcTBX?=
 =?utf-8?B?RFZYRk9LWmJLVGo3Wi9pU2ZhSnhUWmg4OTNKUFAvTkdvcGErNTJFQndmMzVB?=
 =?utf-8?B?SjRGQU1Xb2dKUk0zVWtkanJxaFp4bnFoeHdoOVR6ZDhmMi9WbHEvOWo3QVN6?=
 =?utf-8?B?MHNTM2JBTXhEcFlDcmFURUdqK0VuQmhLNFZKN1d6TVFZeXZveTB0ejFQY0ZC?=
 =?utf-8?B?YklMTzNvQ2F4YnAwZDZDeWJUQmIxcEROWG9DcFdMbFQzM1U4bWVWZk5wSFQr?=
 =?utf-8?B?V0RXazFKc3FVVXVWZXdxNkJSVzV1eEd3R1pjY1pmOHVjU2RUb1dZbVA1YVM4?=
 =?utf-8?B?MVNsYzhWVE5DWTlhT1Z3VnpENnpyekdiblBicm1VekxFT3BMN2NXdHlWTWFU?=
 =?utf-8?B?SkRjRkdmQklJT0xKY0tIbHR0cnZOY3dZcmFkZG1pNUZtbVI0TkkxbG9TNVBL?=
 =?utf-8?B?dDlGbGZoRWZwNm1hd3NRb28zQTlVTFlkV1NGQVhzSU9wMlVoK0hZblJqVEUw?=
 =?utf-8?B?K044bm1KNkpnc09zSXV0djhwWTU2RTR4U3p3UVhjZDBYSzFabW5hSWZjREl1?=
 =?utf-8?B?c3ZVL3JOUTM0QldBaERKQWJjakJib0VIcWR1ak1EcmxTblE4R1FZVThvL2NF?=
 =?utf-8?B?WXRPZ1J1aFN2cm44RUY0N3FMS0R2cE1CNExJckRIL3BBV0ozRE9xKzNyM3lR?=
 =?utf-8?B?c1p5WUp0T09OUnNhN25BOUpaZjU1MHJZRUZ2a3NhN25IWTdCTHB3QjM5Z2xN?=
 =?utf-8?B?L2dlV0ZEVUdsYjdTQzhvSmR1T3hBbURieWhwT2lRdkdsaEdIQ2l0MDZrNEZT?=
 =?utf-8?B?Y0xFV3lkR1B1YStxWmpBZDBrVTRmOGtxTnhFUFY3R3o5c3lFVEQwc2pkdGF4?=
 =?utf-8?B?ckNFblFoaEFodW9Ccm1oS2JLVU9SQXN6YTVGV0ZCOUpQZUljMlVSZkM3UTNZ?=
 =?utf-8?B?WU9GZlJwaTd6dVBiRHRlOWh3U3RuQ3FJMXJDa2tFWHJPRDVPVlcybkxVdldt?=
 =?utf-8?B?UXl6MkozY0taOHg4UFZwckRaOFI1MWJVSk5meDFyWm9tT2dvMm9ES0xFcmFF?=
 =?utf-8?B?MGtNWG1sa293NTRtazVjM2N1a3BBRmdiMVlhZ0x4UUUxRU1LbnNmUitXY2Rs?=
 =?utf-8?B?TmZwbkZwZ2dqZmFjeWpQU2h1STAzd21pZ1E5V3dmR25IQTVIQnRDWG9SazdV?=
 =?utf-8?B?MytQbyszMDFUZU42TU94Y1YyZFZkdzdHRDB0T09BNVpGeTdTWmxRenN3RmIw?=
 =?utf-8?B?ZHRReE0rOENjTW1jTGVaUWN5MzR3eWllbndGNkpRU1g0SnY1ekpYTzFpQkcx?=
 =?utf-8?B?QnBkTzdDODIyNlRUaEdEVW1kUVloK3JHbTM0K0JsbFB0YUg0QUY1VUlSOElt?=
 =?utf-8?B?cWF6QWtYK1NCL1RtQWVkOHVIZ3pkMmpoMVV3d1h2aS9XNGY0VWVCZU92T2RD?=
 =?utf-8?B?NVRJSHdmRmd5TEpxTWl1Rk9oUUhDR25aVEF0Mnd3bFp1VVhrbjhmSkJKVlRZ?=
 =?utf-8?B?VGRPd01UNUs0TUFEUk1Pc3drTjdIejQvNWI4T3BGZWM3ejdLdGxsREdGdVg3?=
 =?utf-8?B?OFBVT3BJYXZ2RFVxZy9tam10YzR1Q1k4V1VDUTJGQS9WNUZUemhEWVhIWmZk?=
 =?utf-8?B?WW05ZU5SbUtjVTRSRE1VdWJ4cHBwUkZZZUg3ZUpiemxrNThITkMxQWx6eFh6?=
 =?utf-8?B?Uk1rYmJQTHJIam9rbTVuWm5NRThKd1M2UjFORHhRQ09PdFQwQzUvQ0orRDVj?=
 =?utf-8?B?T1AvN04wRStiTEhuVm1pZitzSk9vdVhST3NlMVM1Sy9saS9ORW5UcEgySHZ0?=
 =?utf-8?Q?jDymA4VfBHr1UP1CE4Fj/D6Za?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603bae6d-8e95-4613-e714-08dc60865570
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:35:25.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dxx9MdN2OCLsIlEwmbS65+wGfUm556jA6bUjzf2a+k37xaqYw46DWy/zyn36FfEwjZHRgNxzmw8+LwO8oT1yKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

ADIN1300 supports software control over pin polarity for both LED_0 and
LINK_ST pins.

Add new properties to set pin polarity:

- adi,led-polarity:
  LED_0 is used as hardware configuration signal during reset.
  Depending on external voltage on the line default value is either
  active-high  (0) or active-low (1).
- adi,link-st-polarity:
  LINK_ST is always active-high (0) after reset.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/net/adi,adin.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
index 929cf8c0b0fd..ff9262dc69f9 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -52,6 +52,24 @@ properties:
     description: Enable 25MHz reference clock output on CLK25_REF pin.
     type: boolean
 
+  adi,led-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      LED_0 pin polarity. If unspecified keep phy reset-default derived
+      from hardware configuration pins.
+    enum:
+      - 0 # active high
+      - 1 # active low
+
+  adi,link-st-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      LINK_ST pin polarity.
+    enum:
+      - 0 # active high
+      - 1 # active low
+    default: 0
+
 unevaluatedProperties: false
 
 examples:

-- 
2.35.3


