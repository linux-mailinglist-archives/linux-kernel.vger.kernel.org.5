Return-Path: <linux-kernel+bounces-102334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8387B0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769C71F226A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F826A024;
	Wed, 13 Mar 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUNaoVg3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09554604A0;
	Wed, 13 Mar 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353317; cv=fail; b=DIenes+z0nGRFElklQ2Ork99ryj+qRjpOos5IQ/9Qqe8vXp1AzuHCIdL67Q8OKAnsSydhbNCA+vOyXxwBE+uWOcxspuTfTHbCdNuTmSja6OTSP7927S8wS+YPt6pKSi1BGdl83EVik7XKtq1198glz+25E3tTKRce/9Zb0l5vU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353317; c=relaxed/simple;
	bh=LguQIMXXQaDuMUoxz6PZnLvJGZhahh0N4s8zw/OL62w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUAgEKEaduFucyRuZssPRfWnoQCkehVOBig9E9LuBLmDSHVOxQIJm551qri2ZHNS7/Jv5wY84NXo1nQhCwQ8a0IO7t/3uYnD+0Br1di0cTBjJ2Jxtm9skRIdDVcIiB05VhMA02ILroUX7xrmWC3kwuCEAOA+/pTg/oF4YpZLdvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TUNaoVg3; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXZW3UlvtkRXoMRvmQUwuRfEmm0JgRT+RyLwX5w7kaaZChIXl6QtPbrv+cFYOO6ca6784nbrbP2tSCqRZlY6lO7M9KG0IUhzwzdSEIjA/lGwPsH+7AEXW5cE3Cjb+sUTcSGgk5ekJ4kf7LZK2dlghAWKXPmwmBKtqEQd4YvB5I8ikqFoCzZE2XOl6LW4XNXfl05KvYRbbe7RUOUpr5S5zfhqjarj7+6dptqlt66ahaTpF3cdB8X+1C1Uzb5Kv3hLXnRRbl5IE2ScDYej1nJ2qhpYPBio6pgQFLLu/DabWJzhX/BgcgNKAvS2pQdtFiWq97qLyD7oXzy+UOsbVUMLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LguQIMXXQaDuMUoxz6PZnLvJGZhahh0N4s8zw/OL62w=;
 b=TxNfOtwY7S8icx0jzSvGMvaug0wPzeIy003/WOhOWaJRxXbD925SSLd9FbRR2a1P//YX+YRrUnIEdHSWSO7SKSs+AHs8cSlLaBCk4eU17PJS+w+p4QVGFyqDBqsJMl+QWT2bFbKm3RH+uWwE5o/6WM4eGxv/zpfTylbhHgpG9BcvSi2WFc3/usNpZklLkKUxum6mYIHezdC0IZHs22dz3hFpZx8QeIeyY90+Px2hYMzKadc/gxVHX0UOZHT7054D1gJEHRPe0PTwHbFIHa9wMycsiC89znQ76XOPZnY22Ag4estC+OyFvdB7D9fqttux1jJMmyKr+9yyUzW8rxiNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LguQIMXXQaDuMUoxz6PZnLvJGZhahh0N4s8zw/OL62w=;
 b=TUNaoVg3B9rRb1P/oDU8ps0MVBdwY0Ab1S+2mLy1wEn8l190jfYmH4v1+bpgU01C+OXyCvH2JzNxiIH6f90jsbdAKassEUKncTlWqEWZkZmQUbOBMg9hLps09zFBeTk+GrfWW5wfKxAl13kZPtGEvNArqVuC1fFNrcAs43AOQhE=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 18:08:29 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::9108:bade:c41b:5947]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::9108:bade:c41b:5947%6]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 18:08:29 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Jakub Kicinski <kuba@kernel.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek,
 Michal" <michal.simek@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next] net: axienet: Fix kernel doc warnings
Thread-Topic: [PATCH net-next] net: axienet: Fix kernel doc warnings
Thread-Index: AQHab6d3YlLOnxXGWkyx2XPt3aR3+rEse16AgACP7ACACPcIMA==
Date: Wed, 13 Mar 2024 18:08:29 +0000
Message-ID:
 <BL3PR12MB657125A2B9BFD229E905D609C92A2@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20240306091921.8665-1-suraj.gupta2@amd.com>
	<MN0PR12MB59536E9DFE0751049F15C1A6B7202@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307170942.6ada3f79@kernel.org>
In-Reply-To: <20240307170942.6ada3f79@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|MN2PR12MB4207:EE_
x-ms-office365-filtering-correlation-id: 6884630a-1338-434a-c9be-08dc43889662
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zW7/1WXcAkzHj/lvdApAJWBU5fln4miw4Gcv16jv2wnR1NCkOtHZEv/Jyd0O59HFw7OvcshceLp6ze3SJ9vVOmPQ/wzdBwJmYfGEwhGTqmcPO17cQcWDeJg3H7pQCA6gyxRAxNTO3+nuj8F3Z3FVfukud5Ql51uLQHenPlbtcTtsdShGlrLCrNhRSnrRMqxjgul7Gu9s0clbJvhZTACMcE1KNnvZL7QBWfyMZ4/+FA8Zyi0aMr6djMMuiuwRmeT0njHJPQpesU3RKUYyqQkOl2n7F8BWQuiY64txAjWdFPQG5D74CAWbRwWBdxUqOB3Y8QPLU+zSn4pUxY4M9+SDvsaMKwcxrik26nQrt2JYeN0ZMOJu2Rznlg32elwtJeEuCJQFliKfamXd0hPy3nvmOBYHQghIKRo5IIechUGsid3wlVxIxd/48uN1EByVOev72iNKnBKd2fpfbbJ5xRguR5qtvgigsUxPFgZERuZHtD8B1HgtYvdPbKhlA2X6SdkDOqACIthq3e7i783EZxih+OzzQTrbSu6BFgqenKKWCJ3/QjgwCsffuEMKT3XPcMrizgX2ClGrx0tLaO+Avsz1JHPXCKcmyXYMXHKcrfglWaIEzTTuXdJ11OngJN7bRY8bqY43VgR86H6rEqO8B4HY31rpSoJ2pgCNZPQqqOPTI04=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sZL7hWB/2oukm00aOqOnYu+seW2NSlMECBPBkd6tkIR0EEZSdws9hx+xnPOS?=
 =?us-ascii?Q?FRzkrpNR8WBmpS9twEvrqCXiGHZnSrLPEiNrsxDxNFNOAJH0WQkCCjw/u3Xc?=
 =?us-ascii?Q?C/ENU3AgKYygVCRwB4/6gJ8NwktfigDbcgwilI87ra+6J3Jwm86VmBowQYsW?=
 =?us-ascii?Q?flOJMouHQdzh1qka4CGdNlEeEoL7O25s7e9hKhfcWFGcRm1pWNN+oxYZxsrb?=
 =?us-ascii?Q?t6cAccSH9tpxa6qJPVVgiDBil+TqHaI2iuJ096W+hpMx8Bkouhv62Ch4sde5?=
 =?us-ascii?Q?v8YS6TtBW4ATvoxqE8XNL1FRFQr/BdZXeKV2rm2A8YETRHRQB6ID61Jrel7K?=
 =?us-ascii?Q?UONjkGW5GQhYBnff919rMPKvj3X/4yijZsO54bZMnXvyiCNJLzXvwiHoqc2l?=
 =?us-ascii?Q?kZT/pSiiRdRwe1Fvs2QVVJ0bFsHo/N84QPZfo3OudsCf/zDBFO7D1kSlc0Ri?=
 =?us-ascii?Q?QfFGRaIgrdh2Nmyqdm4K/hUrfvRNmTt2vsf4L6JVmnndnQbnTdjlOPfTI8BZ?=
 =?us-ascii?Q?iXlPG8I6Lv2+cqY6aSjSRB6A80IgCIvJBJKAR7r/DiZ2qzuNAmGoKEEjlxmb?=
 =?us-ascii?Q?qb87Y1trCdOeuIWVaq/m1lxllY9aflTu35KWO2VP7ye+QmLk5F3o5WYg71FT?=
 =?us-ascii?Q?UoD/3SmJU8gk3sM4D76LXDCLFwRf9FvEv4+u3qEiiIlzOMTAW7+UKvdyaFd1?=
 =?us-ascii?Q?86sxwPBr0Et60pqkkknQ3laD928OkwH1ooJnhabEXHJOMKMybof7ZEqUXvYo?=
 =?us-ascii?Q?dlNQKPY6/3+T0OjFB9J6EM6lFTNALczezhf/qF5IqB3x1xEkgl5JBS7LEsDw?=
 =?us-ascii?Q?7vyGz6sunmvZKt84liPVIZ6mr9l1NfASXU4XFPThNonj/mZFWTE8hblRZI3d?=
 =?us-ascii?Q?V4LC2hyNiLq7VpNPT4DuX/Fqnup5lHfqxGx0bbRedDt18ky4PE2LVb8aMoCY?=
 =?us-ascii?Q?rEENiCIlWLSC1xaSubVRWrV7CAzZZsCWSdZBnY2NN7pTiknI3DKVmM9SSstk?=
 =?us-ascii?Q?Q4jxO+rVXufc00MzMAoqfvaITG4VBO+/L3QOlvuTpNa7lvWFgrxbvg6PwfxZ?=
 =?us-ascii?Q?nipF6Tf3ASYfAkUZqdcsaiqSpOX6hyoeFuyYWtBrQbXjMXIl94prHA4HzW4N?=
 =?us-ascii?Q?V8EKPxQchgC25spSYG9dK/z53sevROqGgqgP7Nrr/Z0FFRY7ClDQ+KWA8+Br?=
 =?us-ascii?Q?JwrrNek1/xrgLx/LNiAKl9xxRtjboc0GPFLgV5BFly7UzBqkxZ7P6+wtQi5R?=
 =?us-ascii?Q?wdCbuPzK1gydV93Xz9SK51u+gbrZF013rO3HJdaHx4zceb3Hlous1TKwicWq?=
 =?us-ascii?Q?rluTFurc7Yqhkd8062K88Odfr6VdOFE7SpmXoV/248LaOXWKBHvvUD8bDRn2?=
 =?us-ascii?Q?oFEZSNwj053/zNVTKbb4Zqhpo7gTGqhTM/h5ZDJgVpIsiOmXjz7iXR2Wiftt?=
 =?us-ascii?Q?vdpKFMfYAm3Loe/vgh4/IsFw5v0KJ6KyIUR6OJ/7p9tDqE5KRRoWL9MJVETr?=
 =?us-ascii?Q?uJt5nuoWlfGheazuut7pOfNOZ9k/zWqgfkT9tBA74vn3EWQldIz5SXOSply/?=
 =?us-ascii?Q?Y8tOuxtt5I6Qfn59KKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6884630a-1338-434a-c9be-08dc43889662
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 18:08:29.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYfU85zvMEnZr78QDqlvU0mAz6uV7nl4Crhh+1v0BmD0lVvPq/LEcfE/CHzsbQ9izYW8LfOuSzpOTrDNaZhmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, March 8, 2024 6:40 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; Simek, Michal
> <michal.simek@amd.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx=
)
> <git@amd.com>; Katakam, Harini <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next] net: axienet: Fix kernel doc warnings
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On Thu, 7 Mar 2024 16:34:35 +0000 Pandey, Radhey Shyam wrote:
> > > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> >
> > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
> Hi, FWIW the patch itself never made it to any kernel mailing list:
> https://lore.kernel.org/all/20240306091921.8665-1-suraj.gupta2@amd.com/
> you may need to resend
Hi Jacub, due to some email settings issue patch wasn't sent. Will send it =
again, thank you.

