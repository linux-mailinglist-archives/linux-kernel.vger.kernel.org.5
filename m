Return-Path: <linux-kernel+bounces-37052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EF83AAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6351C2883D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC277F0D;
	Wed, 24 Jan 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EM9cDy1Q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364D77644;
	Wed, 24 Jan 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101850; cv=fail; b=cy/eY3gJCs/v3vJ5kwaLpmKUTneaH39Vxmm5ISMfQdeKEIcAZAKTeEFS2lFZ0fcKeqKRCl+N6bZ45rZgoIh7Gqgf8bSiQ6nNTW8XCbKdiuoXN5gvmMgWwy5HG23OT7TRLwi63BjuzRlgIZz8GHvP448D7qZnP9OG+MEvSZOmqQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101850; c=relaxed/simple;
	bh=rFJ9pp4mNqt4iJ0wVQvjZfppndul3mkqem3d3JeSIUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkoCKL/Cc+ENb4jigOt89ntFJCysZueMerNMwExzDx6dR5mo+DbWKnKQWbUNYEe/d5XzqDClkRuezVlWMW3yafeX5BY96LtzdTL3+D0zCVerBIPXBPbHp84zIC8hKZbt5oA3LK5EDQjGT7HlOqPRqO+iGM0rM5KIHElX6d6zG0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EM9cDy1Q; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUnqLbEjtHYTts9fxCQtFkQ5jr18bc07wWPMeySBflUy9Pww+VTZf2JTZdBOk/kcVo5vS0QZ/EjYR0MeTWEjzD0lms1zYcqpU+IpE+6HOhaq6T2WCtyPHTtUPVlLg0ucNNiocw6PzQjrK2NrAyLLco6WiWcZfw8RW4XvOSawzLJQqxY19IP1dNl3m/sjsuBLbra7STdZz1yuXGpPxdD6nP/yj2mAtym6oRbHYWuSWDt+bibbLKMByRXfJqoPJkHMHt2WKWRotvDjInnIVQh0hmh/sLLgdFemRJXGZnZMwn9i2CTkJrN7xHxCUmwM1eEAKeBkHwQeq+zNlXCB+mFcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFJ9pp4mNqt4iJ0wVQvjZfppndul3mkqem3d3JeSIUE=;
 b=BmGImKUn+OY26waJT99a1M110gOXFbBisXEvBzfkBhxvrJ7TEPEnYT4PsKM8HAKdrg7rtRo/FbHvI6tZ3UUI1eQpBtHbPpx2tRM3CuctEVAbdqMlUgNDlsNB2az0sxVw2TzhWyUuLJSwqOwEcP+VOcy9KxAx1LFGUv6a5+7SMggeqLN4jjWHgmOzwzGt6rlzMTUqbJu/p1GM4pYiX+/7ogt4/Hz8z3IaYtxin78QR6pCXij22J4EWQBaopbbdtSu+OmQkO0sIctz7ZDGnBJUwrjqYy3t8cSt7subAjbhEQdRyGZ/jdZa4UKgF4Hiud8mSN07MXRKxkjJ4uNhPPj5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFJ9pp4mNqt4iJ0wVQvjZfppndul3mkqem3d3JeSIUE=;
 b=EM9cDy1QSuMHSEJFUFyWL1y459O8g3Itn+GvnHlgwW8AIK/SFxfcJnDJdvfCvJYYcBbGh4tOJp0T3CBJluP1Ujq24MRllkAn3E9270sP9OkYFrgECSGzqW+WKvIets03EVVPH8JRiSz4QYVL77MHpRn7Y1Y6vpw020vo9vpg/9ZX8i4sZdpFd4GKE+3TBycoAf/aH7nDW+L4pobE/9nhATNVgpJJaVnxscGBhYCjuRcgPVyfNAOwcavuPe3N+IZA2/DCGrNGlREqUfzO9Xp3/1Ki/Zeo2cDrtwVDMRdNOIeJq4FdITdjdOUWEPhPYRfAy++7a3x/9dlECluByw3/jw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 13:10:45 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:10:45 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Thread-Topic: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Thread-Index: AQHaTQ9wgRzMSsypjUOlyEfOvVgnwbDnof4AgAFRPPA=
Date: Wed, 24 Jan 2024 13:10:45 +0000
Message-ID:
 <DM6PR12MB4516A145E4343BADECE13C1ED87B2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
 <Za/xVHkfF0fV84ax@shell.armlinux.org.uk>
In-Reply-To: <Za/xVHkfF0fV84ax@shell.armlinux.org.uk>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: 3ea0535d-603d-4e09-badd-08dc1cdde067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nvm7CM6/TjRN3LxvLQAzIHAAizAKF3ZJWIgcFBxS6/ukOT8PFdcRgxHhecIpMta2AuYjLgxlAok+ZtoNK9U/6dJaiVyKfdlXgC1/+JyQQLR5K/jOV1GnxCoqRz9LFDmkFkHCx8HQYizcqMMTP3AgIX03m0OERln1KajQ+rfTa7dp5n6/x78W8o044mzrZjpwzsCGiNiAma1r6LQCaL2MpO4x9/mKPqwmNs8zdiBsmwIMfvEcjwauYyO6AZQxWT+AdwW2Hljsynp/Nsacsx6+Op1LH/2kMJUmkoLDymqC8yocGnqQeZ6qHfLyN+UCBXinRks+sguzQkxuAKJ5VpIhzdKUypXVvwWAPAVsa80nPe64PHrE45URK/TvZ7Zrh5tfOnOk3cCldDyFjLY30bZ5zbNjfwQGYAx6Lyc93lpjvPRIQdDTJLytB7eYpiJzaedZG4WYx2VqtrWYKyo1nXc9/hfOldSoROsFM976f2aUwxUwwoSRB7CrMJqYTiRvxC5XXksB3hAoads/hp9K4UnhAFeh9BweX7Be7B1gqiCxbwTJTgF1+hO70GRy/yCp0zch+8zzDYSPbQR7vCD7ueuwvsu5LcQ55DEMRzqnGtGw9Utnp8AgzkGWph1MryRnPcXS9YhX8j8x5ee4hefGnaZo6OJi2goboTPrWvkH768Fddo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6916009)(52536014)(8676002)(4326008)(8936002)(33656002)(7416002)(2906002)(5660300002)(966005)(316002)(86362001)(54906003)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(38070700009)(38100700002)(122000001)(7696005)(9686003)(6506007)(478600001)(71200400001)(83380400001)(26005)(107886003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2tJZ2pZeFFnSjlnWTN4NWszZ2dvWis2U1JnK0YzR3hhM1lHQTFZTWJwNVFD?=
 =?utf-8?B?ZWF5OVgxT21KZUpZcXlCbmtBUVZKVGtaeGdRdTZrTFZqd2xIVzNPOG9VVmpD?=
 =?utf-8?B?aTFid01NbzBsTlhoUDV5UTBFY1BxR1BjVnU2a3FmMkZpZG9hWkt2OVp0NGhi?=
 =?utf-8?B?dTJXWk44Yk5hSzA3WnRXc3MvOXpvOXY1citMaHdhUXBVdUM2WjU4Rmc0Sml2?=
 =?utf-8?B?ZGZkR2ZrdEdhc3BQcjlCTHRhQUtSeGNkODNaK3lORmgzMWhjYlh2SWF3ZGNE?=
 =?utf-8?B?RU1hMlBxMEc2WC9qMHJwZHQ0TWloZGFRV203U3ViNWMzazY2aXNJaFFNQU90?=
 =?utf-8?B?Q0hjTXJXRFdPS0lpMUx0KzBaUXNzRjJXVHdDbzF2a2VVaHRQVTJyMGlrOFRK?=
 =?utf-8?B?ei9BcXZYaVZtZWUzYXVnMjRZYXVWb3U3djU5UEFSb2ZjUWJQUk92MVRtZm81?=
 =?utf-8?B?MWhFKzBTWlNiSjVZeDd1VmhRRExRc2ZMZlNzTDlZMjZDNkFhbUhNbVFuMVJI?=
 =?utf-8?B?OWpkTUFnVkV6UFVDWkRCUzJNcE1QaUVwZ2Y3eG9WZDFsM0NRQks0NHFrQzZt?=
 =?utf-8?B?a0wzSEpFeWMvWkpDUlV2NlhPbmZrOWFxN2ptV20wZi9sOFA2VmRqMkZIOStq?=
 =?utf-8?B?V2dNSFJBTjR6Rkk4a0oyaE9aVWtSSWE2em1FVmRWQ2xJcHovK0xGOVV3elVG?=
 =?utf-8?B?UjFjN3lqRW1lRHhRMk5HcHlRM014MmIzQkEyc3JzL3VsTTR3RDFSRFVPNlZG?=
 =?utf-8?B?MG42U2FYVzRwVzFRL3RhK3g5SG5YQWlmM0QyMjJ3TmRSNlUyYzJMOW9Vak03?=
 =?utf-8?B?S3NrSThBbWJHcDk2ZWp1M1dmamtTUTY3SWlWdVNXNjdFQU52QXozeTB6V0RO?=
 =?utf-8?B?Y1VqY3FuU0JtQ1hmUjJxRzNHT0p6R0VVa2ZFUno4R01hYTVwMzNOZkJ1K0lQ?=
 =?utf-8?B?RmdqSnVMczVGSGxPd3RHQlRCZHhjRTM0TWkvUGo2WFMwZFgxcDRrUUpFd1hz?=
 =?utf-8?B?S2I0bGJYaHV1MHFtZzEvUm53UjlweGlXUkh1Z3pGbk93aXdDQU1yVnhhaHhM?=
 =?utf-8?B?N0VaOWl1OVF6ZGNzaGhlWU1xV215eDVOZzV2NVpZdzVKckxYTit5M1VHcDdI?=
 =?utf-8?B?K3REc0YvVXlOdldGWDRid2RLUlZBU3c3RDdKa1h2OTRqQlhjU3ovR1R6ajZs?=
 =?utf-8?B?Y0NyQ1YvQXZVcnVJQXVwMlN3N3Z1SDBWR2dvemFLRXJBMlJGTzdhZXNGZEUy?=
 =?utf-8?B?SHk0NG8xT3hZcEZ4TFhsKy9sclJFcTJiTFRHMVkwcmNNSk4yVURXNFh0eC9s?=
 =?utf-8?B?S0FkWjZKeEpsMU5RcHdRcFlud1BwNVhURGFkSEs0K2s2ZmVmc2kxdkFnRCtq?=
 =?utf-8?B?VGtVZHRLb1h6OGVQZ2NNQW5uNWw1YVVJQUdUbDF3K3JnK1ROcVBaRWxxTU8v?=
 =?utf-8?B?SXpXRnJJOEVrL1hJK0hMTTY3Y2N6RXNFcDJZRU9ZS1FKK3pMUTNaaVB5MTFW?=
 =?utf-8?B?TlJtOFUva0MxTGNQbTBDUXJodWtvY2J5bm10VjZQNDdqOVFGdXMzSUJmOW9C?=
 =?utf-8?B?Z3ZjWHNQM0ZSY0lzY014cWJncFk5SFpMWi9ibE8vWHBsLzFrZUwxSGE3Mmxo?=
 =?utf-8?B?V0hQdUZTTExGbVBWbUpWNnZMOVVtelV4OW5mU2M3NGJNTklNSCt3MlBrQVN0?=
 =?utf-8?B?dGF4V1dEVVFZRkIwNERpaVBjQmsyQXJqUUtsSWRGckJzTnpheXRLaVVlTE1w?=
 =?utf-8?B?d1FuU2lJRE9jejNUdmJ6c2loK3RPdzZKRm50WStmdmU3ZnFOYTJzdjVkN1Ru?=
 =?utf-8?B?cjNyKzBvR0cwUC91bWxkUFZxTmhlUVNzbGJ1cHU1QTNDRy9BUk9PSTVTNGc2?=
 =?utf-8?B?SnBodjlLRjFLMkkySTF0N3M4QVlVU28vUkFOcUtuNGRNbStZYVZxeC9LUW50?=
 =?utf-8?B?dDZLbFpPdnlxcVNRVU5DM2pnN202U3BrQVh6QURxN0Uvd2RjKzc4WnFGSElo?=
 =?utf-8?B?MUxsc1ZlcUtEL3VJUSs1RWNxNjZLbFlHQUEzTElxVWtvS2VGNy92ZjhIVmpY?=
 =?utf-8?B?RDdKWjdvZ1JMdURUWnhaNUpEREdoQXpETW5vSVZTWXE0b05vUzFLWmtHYS8r?=
 =?utf-8?Q?lF6Ur5VopGvJKH2SWFzaV+w7K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea0535d-603d-4e09-badd-08dc1cdde067
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 13:10:45.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyFxgLVMK/e4AfjN0LWo/rDXEiygVPRrcvsuiegdYiTwNrUf2E9Q8Bo5TF2MnccGQ0kDnmnHbpWdhw2hKODREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

PiA+ICAvKioNCj4gPiAtICogc3RydWN0IGV0aHRvb2xfbW9kdWxlX2VlcHJvbSAtIEVFUFJPTSBk
dW1wIGZyb20gc3BlY2lmaWVkIHBhZ2UNCj4gPiAtICogQG9mZnNldDogT2Zmc2V0IHdpdGhpbiB0
aGUgc3BlY2lmaWVkIEVFUFJPTSBwYWdlIHRvIGJlZ2luIHJlYWQsIGluDQo+IGJ5dGVzLg0KPiA+
IC0gKiBAbGVuZ3RoOiBOdW1iZXIgb2YgYnl0ZXMgdG8gcmVhZC4NCj4gPiAtICogQHBhZ2U6IFBh
Z2UgbnVtYmVyIHRvIHJlYWQgZnJvbS4NCj4gPiAtICogQGJhbms6IFBhZ2UgYmFuayBudW1iZXIg
dG8gcmVhZCBmcm9tLCBpZiBhcHBsaWNhYmxlIGJ5IEVFUFJPTSBzcGVjLg0KPiA+ICsgKiBzdHJ1
Y3QgZXRodG9vbF9tb2R1bGVfZWVwcm9tIC0gcGx1Zy1pbiBtb2R1bGUgRUVQUk9NIHJlYWQgLyB3
cml0ZQ0KPiA+ICsgcGFyYW1ldGVycw0KPiA+ICsgKiBAb2Zmc2V0OiBPZmZzZXQgd2l0aGluIHRo
ZSBzcGVjaWZpZWQgcGFnZSwgaW4gYnl0ZXMuDQo+ID4gKyAqIEBsZW5ndGg6IE51bWJlciBvZiBi
eXRlcyB0byByZWFkIC8gd3JpdGUuDQo+ID4gKyAqIEBwYWdlOiBQYWdlIG51bWJlci4NCj4gPiAr
ICogQGJhbms6IEJhbmsgbnVtYmVyLCBpZiBzdXBwb3J0ZWQgYnkgRUVQUk9NIHNwZWMuDQo+IA0K
PiBJIHN1cHBvc2UgSSBzaG91bGQgaGF2ZSByZXZpZXdlZCB0aGUgYWRkaXRpb24gb2YgdGhpcyAo
SSBjYW4ndCByZWNhbGwgd2hldGhlciBJDQo+IGdvdCB0aGUgb3JpZ2luYWwgb3Igbm90LikNCj4g
DQo+IElmIG9uZSBsb29rcyBhdCBTRkYtODQ3MiwgdGhlbiB0aGUgZmlyc3QgMTI4IGJ5dGVzIG9m
IHRoZSBFRVBST00gYXQNCj4gMHg1MCAoMHhBMCBvbiB0aGUgd2lyZSkgYXJlIG5vdCBwYWdlZC4g
V2hlcmVhcyBieXRlcyAxMjguLjI1NSBhcmUgdGhlIHBhZ2VkDQo+IGJ5dGVzLiBUaGVyZWZvcmUs
ICJvZmZzZXQgd2l0aGluIHRoZSBzcGVjaWZpZWQgcGFnZSIgY2FuIHNlbnNpYmx5IGJlDQo+IGlu
dGVycHJldGVkIGFzIHJlZmVycmluZyB0byB0aGUgRUVQUk9NIGF0IDB4NTAsIGF0IGFuIG9mZnNl
dCBvZg0KPiAxMjggKyBvZmZzZXQuDQo+IA0KPiBNZWFud2hpbGUsIHRoZSBhY3R1YWwgaW1wbGVt
ZW50YXRpb24gZG9lc24ndCBkbyB0aGF0IC0gdGhlIG9mZnNldCBpcyB0aGUNCj4gb2Zmc2V0IGZy
b20gdGhlIGJlZ2lubmluZyBvZiB0aGUgRUVQUk9NLCBhbmQgb2Zmc2V0cyA+PSAxMjggYWNjZXNz
IHRoZQ0KPiBwYWdlZCBhcmVhLg0KPiANCj4gV2hhdCB0aGlzIG1lYW5zIGlzIHRoYXQgdGhlIHBh
cmFtZXRlciBkZXNjcmlwdGlvbiBoZXJlIGlzIGJhc2ljYWxseSB3cm9uZywNCj4gYm90aCBiZWZv
cmUgYW5kIGFmdGVyIHlvdXIgY2hhbmdlLg0KPiANCj4gVGhpcyByZWFsbHkgb3VnaHQgdG8gYmUg
Zml4ZWQgc28gdGhhdCB3ZSBkZXNjcmliZSB0aGluZ3MgY29ycmVjdGx5IHJhdGhlciB0aGFuDQo+
IG1pc2xlYWRpbmcgcGVvcGxlIHdobyByZWFkIGRvY3VtZW50YXRpb24uIE90aGVyd2lzZSwgaXQn
cyBhIHJlY2lwZSBmb3INCj4gYnJva2VuIGltcGxlbWVudGF0aW9ucy4uLiBhbmQgaXQncyBhbHNv
IGNvbXBsZXRlbHkgcG9pbnRsZXNzIGRvY3VtZW50aW5nIGl0IGlmDQo+IHRoZSBkb2N1bWVudGF0
aW9uIGlzIHdyb25nLg0KPiANCg0KV2lsbCByZXBocmFzZS4NCg0KPiAtLQ0KPiBSTUsncyBQYXRj
aCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8N
Cj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZp
dHkgYXQgbGFzdCENCg==

