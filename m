Return-Path: <linux-kernel+bounces-67039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D22856529
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C088A1F2662C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CF131E2B;
	Thu, 15 Feb 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ftpclOE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113D13173C;
	Thu, 15 Feb 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005578; cv=fail; b=VSvViazQxfjzSidOcm0MEdS1XVehJrVdG7wFbF/8qJdnU2NeW7hwQ+bBUBYtVhh7jBu9EPzcQIeUjmJEqnYaylOuHVpq6lIVh3X95BMnI50FutREzfV61hPDgmon0KyUQnDRj24kpui1f1L4vAV0gOjGNKz1+I+tjyPjf0y9jNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005578; c=relaxed/simple;
	bh=Esib8hHqyXq5HLJuvr6nWKZwk9dOETBMRIEdzJqkcbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEsCrnqVWs9H2eE5ajCR8xBhxL3hfwLTEzoTHkqWWoEh5UyERT202hdht5uO8U+zcyU8arHAgOozltHDWApt93U52UwJYVNd2LK3hbkmdrmG+gKVaCKMOUqpsc5AY/7qdsKomAeAW5iUG7JJUVE63Jt6SoPHBdViRhiv4hgKZ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ftpclOE; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPXBEkcN5TzrKFa9uAlQKphkLFf3btwZDS1nY7Yh4zv8AXQET0eE56whoiVhrCVosJrjcMwTqhieD+3bfW9PcL6SCd7/eZhI4xkYf9rP/WR+s/Aa54XW3hsjVvv5U/iGLxh7oiu6PXsZfjFKOxurB/E/qjC4FX86dkUW4hB7UkaSJpfrNJnhAZD7ayAHPdxywgYjkOifIyaBg9fWxmc6018xNIR5k7LgE6Xi58qAPIF+NQt97Yr217+EulW+nUni8kod+IOOsCMby7W6Zrq1PJDRf3Dj66oeQ/1nh6s+EwCESgJMXuZeEDPF5YIijpfCg5mUU3zyRtetVSdeqO6fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Esib8hHqyXq5HLJuvr6nWKZwk9dOETBMRIEdzJqkcbc=;
 b=KOSfaDvm29vatvoMRr8vwRBa2Fi0+nZkm2iv1SzpYaC/pWND2KjisU5vwnE25REomjo3q1EtfGJKEd+EvG4gCMD6Uzg2BeHFAoRFREwyaYDmYbtXVf8qpjOmOh/yNJT700KIqcKnBiyfdQfDhHXDmJOeULf4zCgBi0EMVtmvSqKj+fHnn3sBaZy+cFWgoaNG8b65SqDDWSdxqyTXqedr8KDeHfnmNJF1QfbN+hhJLH39LJnvEt41Bf+mE915cfYBgDCpnEL0OOoz3gwpmSg2rSVsWxXsYYgQgdSwMM9yHthsqCvM9mIQCw8iBctE/EC7piXdzYUlvtexNcjrPN0M6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esib8hHqyXq5HLJuvr6nWKZwk9dOETBMRIEdzJqkcbc=;
 b=2ftpclOEPu7obiu57b9f56F/WvfvXEISC6Ja0UuVtIvdVnLWtcEq18sN7XQxtuKwL6dukNtH3BZlXDImv3NbKL0j6eseNEmnDYUwSF1up88VMgWLaSSfA1DmHcNzGySNIbOf/RvtnO0kumtaLL/EEDL+jo8ZejCcKK5YP6gC8cc=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 13:59:33 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::451c:692b:a40c:9310]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::451c:692b:a40c:9310%7]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 13:59:33 +0000
From: "Goud, Srinivas" <srinivas.goud@amd.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Appana Durga Kedareswara rao
	<appana.durga.rao@xilinx.com>, Naga Sureshkumar Relli
	<naga.sureshkumar.relli@xilinx.com>, Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v8 0/3] Add ECC feature support to Tx and Rx FIFOs for
 Xilinx CAN Controller.
Thread-Topic: [PATCH v8 0/3] Add ECC feature support to Tx and Rx FIFOs for
 Xilinx CAN Controller.
Thread-Index: AQHaXmiV0BNz0Ne+1UOVRvJHD10uK7ELLkuQ
Date: Thu, 15 Feb 2024 13:59:33 +0000
Message-ID:
 <PH8PR12MB6675AAAC5D7A86D2CAA382D6E14D2@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
In-Reply-To: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|CH2PR12MB4247:EE_
x-ms-office365-filtering-correlation-id: 2d2051a4-1a63-446c-aa59-08dc2e2e5669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZBFJCbSafsItZQtBgcUqTvzbBu1FUWyMmfFu132BTm5zqVUb+0uOPVEg/eDTg1wJlEN/WWR35/Wd56uZIUzEbt8mwGq+vxVILaNnoO+1dzviCrINZURkAqGrKMu+sR+yd5iZ4AkxZyrvX7cgLtUuWYQZT/FJjLNA8YCiH9Q59Ug1RDWmFsdae+vgVAXrXrNJUczs5JjDntNed0IqCoXpoHwFs6Ca9bgCizOrW6Lzsg3EchkHYCx4HJsA7mxGZ/v3YnzSzD+fzKrqw9ZR4c5t5JOSmgte15thYhUnXkr6jWCGhZ4vo+MIaDOB9zXGYhYassPWNBiPJulUwmwYjRBR0e1jh5hMt7djOPuh5KPmlg2zafqZREWXXREhOHUu3RvCyDhoh2rL4nVuVi4VAU21lXBt6aTGSYdrfZMJiQZXv08qG6LvqKSADgkfW/22ljWl5ZidjHJqhc23AUAPqZCWnHhdyK40qFOEF3aGCBx49KCgIdg88JjB9C4sl0qrhVAtom/dxhbsq0VaYSoJKKQPZzdYoVOZrecyrmX6EQ7/AhNK2ihheWk7/YIM1A5rGjr7X/z67bnVM/9AD4vLmkyL7Gbv2CA2O/UEtgFQbjZpc0Ca8tJrIWzJIzW19TWCO8vNLSLtF4+bXR1b3s70tsq2Xw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66556008)(66946007)(2906002)(66476007)(8936002)(8676002)(64756008)(55016003)(66446008)(5660300002)(4326008)(7416002)(52536014)(41300700001)(83380400001)(86362001)(921011)(38070700009)(7696005)(316002)(6636002)(110136005)(6506007)(33656002)(478600001)(38100700002)(76116006)(54906003)(71200400001)(9686003)(26005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWNwc3ppckp4QkZOb3VXdDdCdStxUUR1M295SUpVb3ozQXRRVjZ1S3BFMXU5?=
 =?utf-8?B?KzZ3bGh4M3NBMURRaWhIbVpDL3FVSUtGYkplOHM5TTltZEgyRHJUL2wrR0Ns?=
 =?utf-8?B?ZGdaMHlmcUJIZ1dJUFpBM0pRaEZBRmN3UkQ2WXhlYmdmMTFjTjV1SEpFUHRE?=
 =?utf-8?B?OEtyVnlheWxrV21jeXA4R2xwcVUxKzh0aWp5b1RuRCtkakowcUtuTk5OZzdj?=
 =?utf-8?B?bnFZYy83RmJaRHZtRFBjeTZjQ2hUbHd2WFpoVi9PeVJuTStPU1NkaDI0cDZr?=
 =?utf-8?B?YTk4NWdLNXl6c3l1ZE5zSHUxVm9PR0tremsrUm9hakhMOFh2Q3lDZ1RkV1V1?=
 =?utf-8?B?clQxbjVFSTMvU2dtWTdRQ0E3NXQ3Uk84dEttT2RJV212SlVxM2NQOFpCby80?=
 =?utf-8?B?bW5DZGUrbU5BbXZQN1pTbUVxczI4blNyMHRxSkIvS1BhbEdkV3hzbFQrNnM1?=
 =?utf-8?B?M0FXVTljWUlGNHZEcHQ4empsMUNhMmthd29zNVlPNDcxTk9KNVY4ck81MHlt?=
 =?utf-8?B?K2k1UEU4eTByRlRheXZOc0RmV0VFWVM5bFJTU1F6L29VZ0ltOGFoVWhrZmhZ?=
 =?utf-8?B?d2VQY1Jpb2pNT1lyTTBzK2ZEYURZMGcxN3crMFhoVC9QTlVCSmNhbTNsYmZK?=
 =?utf-8?B?WmdLeTBvR0JvcDQ4VmxtS2Ivc0hEUUtINzNPbkNJeW1LLzhUYzBpcVhic2R1?=
 =?utf-8?B?amFmSFhIR1RQT3hiS29PeEhMVzlmWURFVHFqN1pycEZnWVVncEIrcEEybGJv?=
 =?utf-8?B?V25vNkg2R3hSSFNBa0NRaGdHdG9YOGN4cFJsUDBqYjcwRG9qV1hldmgwZTEy?=
 =?utf-8?B?eVYrdEx1SkthaFZ2VWtRR3RsQnk0RGN3SjUzb2h6WTMxbzdXV3BBdUJiTnk5?=
 =?utf-8?B?ZlUrSllsOEl4WG9NamZadHVibmJOTDB6VEV5WUdHbVlvOGlRYnZ6UU9mZ1pm?=
 =?utf-8?B?WE8xTVRQaEdHTWdidVlmeTBCUUgrakpYaUxSK1BTaGwrdGZmSGlKSWdyQ0V6?=
 =?utf-8?B?NkhocVVIUzVuU3l1WFFiODcvUlg0SFh4dXBKOStrMVB3ZkZIdFlDVnZKdFIv?=
 =?utf-8?B?QmozQUFqWlBtZGZBc0oxN0Zva29jNlVUSVlYQkhnMjZTRjZYVUF2Uk1aQnIx?=
 =?utf-8?B?OGYvbm53NUdpZ0NTbEJrS24rcFE5VTQ3YWdwVTFTV0E4Wmt5aGkvbXVYV0hq?=
 =?utf-8?B?bnM5RnN3c2lTNGZBSlQ4WU5mdlowZmQzZ0pjVU55ZVM1dmd2RTJtSGF6Mkpl?=
 =?utf-8?B?aWI1V3NFdXljL01tc2RMempLZlFRUUlmOGgwb2thUUVSVkJEK2ovVWxwanFJ?=
 =?utf-8?B?bEk2MHpTaXhjd05yT3lGTTUzd29QRlU5ZllFbzZiYlIrOVNkVHJlV1RpN3RY?=
 =?utf-8?B?SDJGazRFR0puY3Fob3MwMmQ2S29Cc3RHckNnSFAwMEpqemhybnNVR2Y2d3A4?=
 =?utf-8?B?YWxhcXNmQ092Nm9welk4MFlGQmdQWUJVWURySUVKN1EwKy85dVFseEhDRnF0?=
 =?utf-8?B?b0phbUVSczdVbU1HcTVPOGkybEIvQnZQelNST08rRTBWZlAzeHQyQTdLRFZX?=
 =?utf-8?B?RW1RRXZ4b2JFdEh0ZjR1cjQ1cStMVmhQME02M0RDTVF1QURUbkc1eC9GWjdM?=
 =?utf-8?B?b3JjUW5pdGNVVllCRm9oYjRNNk41NWRDM05uSDhqQUdkMmtId1M4MFhpS0Q4?=
 =?utf-8?B?dE04YnRtR1Q0MU00MnhZTTF1dTcrMTF2a3NJeGVlRHBIc3grekRDYndXdXR6?=
 =?utf-8?B?YTRTdTN3RXdXUHRrSkpTZ2FaVkVqZkRobStpakluNXBVdjEwR1hEaGErb2FC?=
 =?utf-8?B?RmZ6RkgyWDI3OHdWaGVXYW8vT0FRc2cvTHcwdlFSUmwxai83NXdTVVQ3dEhr?=
 =?utf-8?B?L0R5bEVzWTVmMFEycm9EK0kzL1B3RkNpZVZIaVhJWlViT3dwTlFqVHUvYU5O?=
 =?utf-8?B?cGZyeFNDQzdSMEI1TXlhR2k4dk5XTHd0enhtN3ptbndTZXNacGZQaW44MU5w?=
 =?utf-8?B?U3I5aklzWHdPaUQxbklVaVNZRHNNWktReUpDbTd3SDY4ajV3NjM4TFpFTnJk?=
 =?utf-8?B?N2I3QWRyTW1mWFlOdzdqL0lNZ05kSDM3RHdiNVBIczRoZjZEWW4yR1lhUDU4?=
 =?utf-8?Q?v2+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2051a4-1a63-446c-aa59-08dc2e2e5669
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 13:59:33.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OswJaVv11wygDJD2XBG+u1P88nZcaCsz3Er21+X7botUcg2e0rF7yTNT5yQxmWJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

SGkgTWFyYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWFyYyBLbGVp
bmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj5TZW50OiBUdWVzZGF5LCBGZWJydWFyeSAx
MywgMjAyNCA0OjA3IFBNDQo+VG86IEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSByYW8gPGFwcGFu
YS5kdXJnYS5yYW9AeGlsaW54LmNvbT47IE5hZ2ENCj5TdXJlc2hrdW1hciBSZWxsaSA8bmFnYS5z
dXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29tPjsgV29sZmdhbmcgR3JhbmRlZ2dlcg0KPjx3Z0Bn
cmFuZGVnZ2VyLmNvbT47IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+OyBE
YXZpZCBTLg0KPk1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1
bWF6ZXRAZ29vZ2xlLmNvbT47DQo+SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFJvYg0KPkhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj48a3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj5TaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj5DYzogbGludXgtY2FuQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj5kZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj5rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBHb3VkLCBTcmluaXZhcyA8c3Jpbml2YXMuZ291ZEBhbWQuY29tPjsg
Q29ub3INCj5Eb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPlN1YmplY3Q6IFtQ
QVRDSCB2OCAwLzNdIEFkZCBFQ0MgZmVhdHVyZSBzdXBwb3J0IHRvIFR4IGFuZCBSeCBGSUZPcyBm
b3IgWGlsaW54DQo+Q0FOIENvbnRyb2xsZXIuDQo+DQo+RUNDIGlzIGFuIElQIGNvbmZpZ3VyYXRp
b24gb3B0aW9uIHdoZXJlIGNvdW50ZXIgcmVnaXN0ZXJzIGFyZSBhZGRlZCBpbiBJUCBmb3INCj4x
Yml0LzJiaXQgRUNDIGVycm9ycyBjb3VudCBhbmQgcmVzZXQuDQo+DQo+QWxzbyBkcml2ZXIgcmVw
b3J0cyAxYml0LzJiaXQgRUNDIGVycm9ycyBmb3IgRklGT3MgYmFzZWQgb24gRUNDIGVycm9yIGlu
dGVycnVwdHMuDQo+DQo+QWRkIHhsbngsaGFzLWVjYyBvcHRpb25hbCBwcm9wZXJ0eSBmb3IgWGls
aW54IEFYSSBDQU4gY29udHJvbGxlciB0byBzdXBwb3J0IEVDQw0KPmlmIHRoZSBFQ0MgYmxvY2sg
aXMgZW5hYmxlZCBpbiB0aGUgSFcuDQo+DQo+QWRkIGV0aHRvb2wgc3RhdHMgaW50ZXJmYWNlIGZv
ciBnZXR0aW5nIGFsbCB0aGUgRUNDIGVycm9ycyBpbmZvcm1hdGlvbi4NCj4NCj5UaGVyZSBpcyBu
byBwdWJsaWMgZG9jdW1lbnRhdGlvbiBmb3IgaXQgYXZhaWxhYmxlLg0KPg0KPkNoYW5nZXMgaW4g
djg6DQo+LSBVc2UgdTY0X3N0YXRzX3N5bmMgaW5zdGVhZCBvZiBzcGlubG9jaw0KPi0gUmVuYW1l
ZCBzdGF0cyBzdHJpbmdzOiB1c2UgIl8iIGluc3RlYWQgb2YgIi0iDQo+LSBSZW5hbWVkIHN0YXRz
IHN0cmluZ3M6IGFkZCAiX2Vycm9ycyIgdHJhaWxlcg0KPi0gUmVuYW1lZCBzdGF0cyB2YXJpYWJs
ZXMgc2ltaWxhciB0byBzdGF0cyBzdHJpbmdzDQo+DQo+Q2hhbmdlcyBpbiB2NzoNCj4tIFVwZGF0
ZSB3aXRoIHNwaW5sb2NrIG9ubHkgZm9yIHN0YXRzIGNvdW50ZXJzDQo+DQo+Q2hhbmdlcyBpbiB2
NjoNCj4tIFVwZGF0ZSBjb21taXQgZGVzY3JpcHRpb24NCj4NCj5DaGFuZ2VzIGluIHY1Og0KPi0g
Rml4IHJldmlldyBjb21tZW50cw0KPi0gQ2hhbmdlIHRoZSBzZXF1ZW5jZSBvZiB1cGRhdGVzIHRo
ZSBzdGF0cw0KPi0gQWRkIGdldF9zdHJpbmdzIGFuZCBnZXRfc3NldF9jb3VudCBzdGF0cyBpbnRl
cmZhY2UNCj4tIFVzZSB1NjQgc3RhdHMgaGVscGVyIGZ1bmN0aW9uDQo+DQo+Q2hhbmdlcyBpbiB2
NDoNCj4tIEZpeCBEVCBiaW5kaW5nIGNoZWNrIHdhcm5pbmcNCj4tIFVwZGF0ZSB4bG54LGhhcy1l
Y2MgcHJvcGVydHkgZGVzY3JpcHRpb24NCj4NCj5DaGFuZ2VzIGluIHYzOg0KPi0gVXBkYXRlIG1h
aWxpbmcgbGlzdA0KPi0gVXBkYXRlIGNvbW1pdCBkZXNjcmlwdGlvbg0KPg0KPkNoYW5nZXMgaW4g
djI6DQo+LSBBZGRyZXNzIHJldmlldyBjb21tZW50cw0KPi0gQWRkIGV0aHRvb2wgc3RhdHMgaW50
ZXJmYWNlDQo+LSBVcGRhdGUgY29tbWl0IGRlc2NyaXB0aW9uDQo+DQo+LS0tDQo+U3Jpbml2YXMg
R291ZCAoMyk6DQo+ICAgICAgZHQtYmluZGluZ3M6IGNhbjogeGlsaW54X2NhbjogQWRkICd4bG54
LGhhcy1lY2MnIG9wdGlvbmFsIHByb3BlcnR5DQo+ICAgICAgY2FuOiB4aWxpbnhfY2FuOiBBZGQg
RUNDIHN1cHBvcnQNCj4gICAgICBjYW46IHhpbGlueF9jYW46IEFkZCBldGh0b29sIHN0YXRzIGlu
dGVyZmFjZSBmb3IgRUNDIGVycm9ycw0KPg0KPiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL3hpbGlueCxjYW4ueWFtbCAgICB8ICAgNSArDQo+IGRyaXZlcnMvbmV0L2Nhbi94aWxpbnhf
Y2FuLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMTY5ICsrKysrKysrKysrKysrKysrKysrLQ0K
PiAyIGZpbGVzIGNoYW5nZWQsIDE3MCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPi0t
LQ0KPmJhc2UtY29tbWl0OiBhMzUyMmEyZWRiM2ZhZjhjYjk4ZDM4YzJhOTlmNTk2N2JlZWYyNGUy
DQo+Y2hhbmdlLWlkOiAyMDI0MDIxMy14aWxpbnhfZWNjLTgzMTBmNTU1NjAxMA0KPg0KPkJlc3Qg
cmVnYXJkcywNCj4tLQ0KPk1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+
DQoNClRoYW5rcywgdGVzdGVkIHdpdGggdjggY2hhbmdlcywgaXQgaXMgd29ya2luZyBmaW5lLg0K
DQpUaGFua3MsDQpTcmluaXZhcw0K

