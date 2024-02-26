Return-Path: <linux-kernel+bounces-82283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F948681C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD382B2200C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD04130E52;
	Mon, 26 Feb 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kjGUb0D4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2121.outbound.protection.outlook.com [40.107.94.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C7130E20;
	Mon, 26 Feb 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978579; cv=fail; b=eSnmpR3tTdvficQ9F9rt6HVspCrdqD06U2BZWMh/GWQCXpgrIvN0R7mio/cqc6ObM0muiL6KEK4mO/XmIEsTi5M4MnOKffVld2+bF4hFFcj3+Pq0lxvQAgXEQ9J1yOeOnT6SjWLd15lX+qHidM8Wu3NXFxfoD+sv/UYsNzw44Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978579; c=relaxed/simple;
	bh=LuI8vtimLTlomzeAI0qh3T0yf5vcS1483iai0i15I6o=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JH0llYDwXZt9im4DEyKk7lbs4Mxjnl1Yf+hT0xziWp0l6E7kUHKzWphy7MQZrTSJfPeVy9AKpbf6bMNBVhLOHjnvjjizI0jJChPlMx+cftLDkm2IQA5JPFR14ivjREmqfjtZqcCBbARcFtRwx7T+WQQYTGMoXJzfrXMcZYoz2GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kjGUb0D4; arc=fail smtp.client-ip=40.107.94.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8pmSNRb9fCz63BoiuCuACEgoLu29YIns47648B7kT6y/6opYiphNMhPw/5c/yyzYecp75C9KrU6ICrXLoXQniBKBWMOp/8VGEzDSJ7hfkAjeNIzUkzigvQkZ/mrqo165YygxkcbiTbjX5oGKcfdA7FV62ZYI0WyBC4n/cl23Xp+1cCfzctz0Rwfjm5TvSRuccqy4j/XyOsAjVfUwRZKrKzyWBa225h55fzeeXMfu6xkTJhtiH6YNDvGZJIA+Lij+ySLCHrbIdGRKxw7d5R7iR39msez7ax/SP30myl1PBgyYW8yQGo6SwpHLxLuvGmLYV3tjN6th5OyD/bjDYbkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r42JpEStbsyaigYdfMyU7Usd+8IsnYg6xNzTAGhTiy0=;
 b=IY4nbimGYywHguzgmcxeJQIxyJCj83p0qm1l6hX2lWsyxayZ05CEzczB0I6YNA1NZ5mQMDmA5j9qfyBWw0lAP7Pqpo/T//39gHbvbS4iwLxvn69OqQBUwa7P/ZgKFnsxiJePuFoHhI1G9LRug5TEO/heIY9q1Cnur62lMmoqxcaqDx0t2gd3xUb7K063v7RpQ8eIs9RnFzeb6sCzO2/jGS8SbGaCdYOmmSIWJT5Ua7ALrqfen4aMSMZuW84MLG+oHoxcBgsctzxajQCxO+21c+UuM0pRcu7uu4iK5oh9jBWuaF9WRn1C5chDVn1LJNEF823OJDE+SVmy8l4lUGeJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r42JpEStbsyaigYdfMyU7Usd+8IsnYg6xNzTAGhTiy0=;
 b=kjGUb0D49+Qqg4T7s/JawV0NUYwxAlwXpT8sl0J65RXafjBx+a86OLQVysAh98fGbEal2c7SsySX/KJl9KRk+O9y37D3bdcxsHn9arX+9XY2CBt2vmAuExoyL2Ok9YGhyvvvs/qQlnZPcZil53q8AyxNUGDxKjN7y33KvOMoBxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 CO1PR01MB6629.prod.exchangelabs.com (2603:10b6:303:d6::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Mon, 26 Feb 2024 20:16:14 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::28bb:f135:bd95:a21d%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 20:16:14 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: [PATCH v4 0/2] Adds additional information to ARM RAS errors
Date: Mon, 26 Feb 2024 12:15:18 -0800
Message-Id: <20240226-b4-arm-ras-error-vendor-info-v4-rc3-v4-0-08e0f168fec1@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbx3GUC/x2NwQqDMBAFf0X23AVd02L7K8VDNC91D03KBoIg/
 ruhp2EuMwcVmKLQqzvIULVoTk3craN18+kD1tCcpBfXiwgvjr192XxhmGXjihQaNMXM1bGtIy8
 IY5yew/0xgFrpZ4i6/y/v+TwvcLKc/nUAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Jason Tian <jason@os.amperecomputing.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: PH7PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:510:325::6) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|CO1PR01MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 478b9059-a33a-4bbf-8d64-08dc3707c814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d2Khbi47uFnLt8SI57eR+2i4S99f8lVzPbwcBu2zPQJTFwPCQJ0E5+IlzVV7/mOxOxWdaMzpiZ8arUO2QCBZ5kXA13giIgnyAbp5ookP1OIslBOtd22z9NLdki6jA42V96lxeZJIUF9KqUWD+5+mMiRE7H04Y2QZBKXLdl4ipBRfP7lTcQRrk9ns1kUP5+fZyLhkovHpCnG4h8MLj5FH2S0GOLCpKxv54zd/7+ghDaRG4WA64dgv8j3/hUH/th4X5gqJbJ1y0R070neIxU4ecFl1HwsxLLv6L1u7YTaV1gaL4GZZUD5cjORxG+NRZmt9ijBXcVKbh24Y3zXvWfA4LG51x8PKqyp/YFSkBt5YGBWKLpqBWMVVtBKXv2mdxX7XqGP4mMxoQWIbiKA3EZ5Ez0x4cDWyLneXusIxICpDYuYW1kFVhfKJCM5aPNiSA6yWzVMszMj7m2+fKbXjJvEFf4Er+c6GwPrQ07muekIeByactE+URNEAhd1A3a6AftHNIXRFKQ59j5JszK2Ri7gYxlQWoD0vD47NxsnP3D1CWPGGscqAlUq8Sq3Z4Yy1Sc/AFy4wqhytlDdhY30xDmDuUM2IrU6e8IWsg7Bf3jS4oASXNwvSDEnadFHk7VsBOMxTo575Gp40jBtfAp/MeQr3rP6d3AVAg+ZZHrK8B9rXKDfmVwQm8jXb5gfEZu7Mdd9+ppv8oA4vXAYJw+Jp2/2G/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGt1WEVzMzRSZ3dSQnMybk5JVWZnaklYblg4TXZ1YmhKS2hxNzlwOWNpNWVI?=
 =?utf-8?B?cWxndk01eWozd2JMRjkva0F0U1k0RGp6SkRmeFVnOHMzUHdVc0JBblZ1NkRx?=
 =?utf-8?B?N25QMlhQMmNCbGRJcFBKMkJkbkxRVkJwQW9VQldadjQxTmlOeE8wRWlqSkJP?=
 =?utf-8?B?cGdBc2xNcXJDODRaenkxVjNLd2JHMnZ2ZFdEazFGR0w2RlhYTXFIaVJnOUl1?=
 =?utf-8?B?WDBpUFc2eWs1MU1DRzUzTmVBakRLWjlNWG1nRGJTQ2hPSHJyL1cvZkg4REl2?=
 =?utf-8?B?MW1TNmREdUUvWFRzTkx3QnlaalRmbGJxU2Z4ZmRvd09POGJJREJQeEpiaUpB?=
 =?utf-8?B?RVk4bEpsMVJOanhjeDBnTHY1TGFlMkhqNEhTUDZISktSSUoyMUxFNjVvWjEv?=
 =?utf-8?B?bUtjd0dvMWhvallVSUF1UTJqcFhnTjlueFVNczJaeno3S0V4aWVYWHBYcWVX?=
 =?utf-8?B?TXVUcUg1L3huL05TSWN0ZDgyOUVyZUczd1drQzBXU2NpSnQ1QVZDVnNaS0ph?=
 =?utf-8?B?bW0wRDhBdi9McE1JNDY0NUFNMXdlQllIenhRWktCQitVLy9yUFRybG13SnF2?=
 =?utf-8?B?akxlNFN3NWNwSGtjZ0JqSTRIRm1uRmtHVEpvckZhRkN0QWMrMFpaQ1UvV0xH?=
 =?utf-8?B?bVFTMStuOFp5aVppYnZVVlQ2dDRhd00zYkZtTVJmNEV0NE5hZ08xaEU1QWV0?=
 =?utf-8?B?MmhLdUZkYVhjZ082bCszcFRnaHo3dFBNOHZSQkhIWGsyWXl3NGhWZ2ozckRs?=
 =?utf-8?B?MWNwMXcxRGVCNHVvZE9VTC82aUxwU1VxSGgxREg0Ykp1ZTJwamdFQU9rL2J1?=
 =?utf-8?B?WUlCOHBhRUs5WDNiUjZCcC9SY2lROHZVZzkzZXJzNmYxeko1T0IzWlpJWTMw?=
 =?utf-8?B?dVhKTi9yQ3BLL3JIYUpqVlcyTDlQci9ia01ZVHV2ZTIyQzkyR1ZaSU1vdm5x?=
 =?utf-8?B?NHhuUE1pZXljbVZxUkx3UGNDaTJpakNwM1ZJM1VLTmhYekhxdkExb09LMitm?=
 =?utf-8?B?VGFlcDRveHAyNXdvbG1VZGw0T2F1cUlBdkVPTTRCdGNKaWxFWTQzTW5YUDZD?=
 =?utf-8?B?ZDZURlQxMTJ4eGFqMXQ4OUpPWElPN0s4MzhPV0ZYUytZbjNTdGMwN1c0dGhi?=
 =?utf-8?B?SWJxVWNMOVR1dFV4OWpRR050OGhPQUFWWlRaTEUwWDlBbnRxcmZ2bGZDNU5v?=
 =?utf-8?B?bXBtWTRNTjhmRSsyeVoxaTJXMzQ4ckVJNGRsRnAzVkgxTkZrK3VkcDFBVzBm?=
 =?utf-8?B?U2tLUlJtb2JqTTJ0WXZZWlF3OTUraUZ5Zy9DWWhTOXFlQmNxNjJwbEovaFEx?=
 =?utf-8?B?NndEK05BajlGeGZud3dxb0NMSGF1aGZEYWRkS0Yvcko5a2pzcDRqdTBTNUtG?=
 =?utf-8?B?KytKejUzbzQwWUJqd0pXK3JMakJGNjZrRVg5Vm00ZHc4UWt1dTlIZWl6MDVr?=
 =?utf-8?B?RVd0OVpDdnhWb0tCRVRkcC9GMVFkelRXem92YVBuandYRW96YVRXeTd6Mjli?=
 =?utf-8?B?TlNqektYM1hYMllLeFFjaTFzcjNDbVJqRmVxaEpIOCtGaVUwMXNQbFkycXdr?=
 =?utf-8?B?elpMTmtXcloraUhtUjFqNVB4TGF0dkhrMWU3SDl5WWMxTFBsVlovY0NLVUd0?=
 =?utf-8?B?MlNyODVXSCszcGduRUFQRWxTYk82K2duWG5lTDNPL2h1THYwcmdLNEtLamVi?=
 =?utf-8?B?d1NRbG1MaWxoK0ZBdkJsSGh4YjQ5WXBaclJ1Uk91c013eFNRNFQ2UHhnWDBm?=
 =?utf-8?B?enJzT2I1UU43QVE0dlV1TUxmQ0NsZjViWmRMaXhRMW5iN3VLTlRTMENPbVhy?=
 =?utf-8?B?RTN1cHR4ZGkwMEk5SlNYNURUWkIyZUR4QktPQmQ5WEQ4S2xKR054Wk0zbzhV?=
 =?utf-8?B?RzUzZXRpNDMxS2YrUVVFcnN2ZGFZN1FRWDhVYTEvYXVOeGhTaXJjaytBd0JC?=
 =?utf-8?B?ZHYyaFp0RVg0Z0o5WUdFYU5pYzdKUmN5VGlYcGFYRDhkcmFrNUJqaWhjWW1D?=
 =?utf-8?B?ejBQMW45OWN4SzdOemd6T0hFTjN5VmF1WGM3Y1o1QW1NSjh6bU9yWXozN0tR?=
 =?utf-8?B?VGF5bmF0UUxSdUxkbjZkM1RGdjVlOEROWndFaHFWMlYxY1VWYllIMjNINi9a?=
 =?utf-8?B?VGdGZC94TFZKTzZMSmJ4dmxObVhpRFc0L2FKa3hURXlWTm12Y1ROMThLVFFx?=
 =?utf-8?Q?PRgi+OOrOdwUNRKdr+pawWA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478b9059-a33a-4bbf-8d64-08dc3707c814
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:16:14.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcuCqsuzLLjR3LCDDrpX22uCCHygfk3ucktSBFy7LYzUl2YN0H6N9H6pUbGCzwOzoJnk6UIJVtf7rvCP67TT30zcf9C/uzyrip0Wns75WNoeZzEVGtjyYsNluvuqz556
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6629

The patch by Shengwei includes most of the justification for this series
in the commit message. The only thing i've done is add a few conditional compilation
directives based on feedback from a previous submission attempt. This series adds:

1) Conditional compilation directives around ARM specific RAS error 
   handling routines, so non-ARM platforms are not unnecessarily bloated.
2) ARM Processor error section (As defined by UEFI 2.9 N2.4) to tracepoints for userspace
   consumption. This particular patch is a RESEND. 

Changes since v3:
	Added conditional compilation directives

Links:
https://lkml.org/lkml/2023/12/14/1488

Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
Daniel Ferguson (1):
      RAS: ACPI: APEI: add conditional compilation to ARM specific error reporting routines.

Shengwei Luo (1):
      RAS: Report ARM processor information to userspace

 drivers/acpi/apei/ghes.c |  7 +++++--
 drivers/ras/ras.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 19 +++++++++++++++++--
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 111 insertions(+), 11 deletions(-)
---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240222-b4-arm-ras-error-vendor-info-v4-rc3-bed3f891561e

Best regards,
-- 
Daniel Ferguson <danielf@os.amperecomputing.com>


