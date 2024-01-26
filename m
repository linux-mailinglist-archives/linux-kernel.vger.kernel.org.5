Return-Path: <linux-kernel+bounces-40805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7B83E64A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C061F2128A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306AC57328;
	Fri, 26 Jan 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="bG/ky5/C";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="EpHPIup2"
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7465787C;
	Fri, 26 Jan 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310682; cv=fail; b=IvpYNtoZaAhnCF+nyYTHDPXwXuduhBfoCWwN1w86H+4z8/bIKxkm82TRHM+MquecayuagttjFtfEd96xczRvqQ8IAhGHAY5wtueQ5F9ecBi8OdTcGoEQ0818ehHY9jlkxbVcIluhurm73Cf2QhRtAjkfBbzW5BgjSsGXwggq2eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310682; c=relaxed/simple;
	bh=qBjs5ioZN2KReYY3CsjGIKGMs7ogVPGn2QnTn6k9zog=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FiBjBIBPPxjni7sksgXqHlXLORQ0wB0/5rJMmRavbq+SH8CgWRstJYtULw+W1zMq6lxoVbav3fKMjrfzlyiYNrysHxqWCsmSMF3ZBLqjiivyGS1B5+zt/ZqxUMF/1SHJGoMIoiEa/tTsYen6AeB4576UuESTym+PYMnFa0VQGww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=bG/ky5/C; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=EpHPIup2; arc=fail smtp.client-ip=216.71.153.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1706310679; x=1737846679;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qBjs5ioZN2KReYY3CsjGIKGMs7ogVPGn2QnTn6k9zog=;
  b=bG/ky5/CVb8FAtBXa03WnZOCKNCTYbpUXh18FUhNA4bUgSxtGcj6dviF
   YV9mep8Y1R6A67F4vrSdAJLEYEDfQR7rhrMYDXeD1AUJ+khuonagEqIZE
   xmUq8xvThmJQ2YVrnm3P27MWH+bPYWAxcdbw8hhCb59kU1e/CkkUx6CtW
   o=;
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:10:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTI4CkR36HHgEUrMpqSLdSEj1yZ1K1xHWLnQoArK/HI2ny4Z3YcCRw313ADSEQCfNNX0HAc+2GVnJ0egZ/CV2p+sd0fa/Yc6bBS5gz6H6WhEl15BQyYAV53d6Y4SxjQny9qCcAlX3uR4FGEEgvBw1xWcA2Woy6aQH9sIHjZIQBIOUDWElYjjWonBhCsgpu6LghO4cOtJBzl5cp+mZ799oB4KtpSa1T+tEKUnlnzi0rHd/K+7hCUGz3y7Irs9/p/1GB7MNfuWe2vHH+xSwimNf46otD5KUVoj45M4iWGyUrXAOUBvcRKkwo5F8PUAi9T3uz+BYHI+h+jQgcPc8uyobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHgFZshOtYLrwk7lihreDJbH6aJHPqlMOIrVbqpTSew=;
 b=doQuuGv1YAGV8oGiza1e+xmPFWnDfYr7fINdcfDujW0mjyGakxntWwuKn8wsGLBCLmHFOzqlFXhlJIwVcetYBdRhH3v742w50xA9KuIBW9yH2CzzY3Hn28R4nPhgxlbNWuNOoqF17mnuhgACMIFHmVKTBArlECK5lGCCje5BFL2lLr1XLofTVBwR61L2VqDS8CRnSEBdUGFvx8ndPxcrsqdHdWJHNeUwgtC4wmrocoTSbKzk0aSb3qBrolsL8Ym80iLibtmlM7MUkjHMOasEfgr45MLRa3QqhimkMadt22O9vCb70c0bGt7HZ/fJ1/6FPxtpkILpZrhc2OfMG3Du+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHgFZshOtYLrwk7lihreDJbH6aJHPqlMOIrVbqpTSew=;
 b=EpHPIup2FVgsCM0t6sGGyjQZ/2969OVKjYr1mGWISqNF6zyQL9TE+14hAst4AjCT0mKh8NB1SC942rI6cZDP0K6KtQ+l7YQTK6CdsSlZVh7RxXYbk5WloE11izqZIYFNxHjWaHwqpeaOMogb1XcHG1b3ZlVbhIcsAtyA5Mz+9XI=
Received: from CH0PR20MB3818.namprd20.prod.outlook.com (2603:10b6:610:d9::9)
 by SA0PR20MB3392.namprd20.prod.outlook.com (2603:10b6:806:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 23:10:06 +0000
Received: from CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::f72f:8a31:57b9:b6f7]) by CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::f72f:8a31:57b9:b6f7%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:10:06 +0000
From: Nick Spooner <nicholas.spooner@seagate.com>
To: "rafal@milecki.pl" <rafal@milecki.pl>, "srinivas.kandagatla@linaro.org"
	<srinivas.kandagatla@linaro.org>
CC: Evan Burgess <evan.burgess@seagate.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: [RFC PATCH] nvmem: u-boot-env: improve error checking
Thread-Topic: [RFC PATCH] nvmem: u-boot-env: improve error checking
Thread-Index: AQHaUKi9MsJzmgn37EmLKR/+hmHG2w==
Date: Fri, 26 Jan 2024 23:10:06 +0000
Message-ID:
 <CH0PR20MB381875927236C07B9CF9A8099C792@CH0PR20MB3818.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=True;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-01-26T23:10:13.867Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB3818:EE_|SA0PR20MB3392:EE_
x-ms-office365-filtering-correlation-id: 5ee019e8-ac97-4dab-be22-08dc1ec3ef44
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xPmRZgMAaB3hby95qgtXdgsPCny3jbVkV6u1jMslhEMMHXY23INJEmJrvI7xdDxSWQ+N6JeVj0lApbS6kpwSal8a+lT7ZCJ91x81jRgH8mOY3FUKvHciG3b9VUka1cctvNboagxZvlwrs73HJp1Msa0SHoiI/IgmVWCSHyQUcO0Gi8XqB324b1LwZC2CGHxGVS+E0nO3zE9hckGPVScFCp59o/0zWlC1maaD2V7rmYAho9lpmRmpdYLpzng1qocbU58hCR7TAqwtttlR5kCvekHnRxNQ6k2ja1rKWd7LlEly+gUBJ3u/WFlrbRdK4JMtA/P25Gw/WleoNropK0JC8iCBlduAUTKAp3/v33a12Kx1mzHpslqKGsltWlxgfGoWEI63TIWhGLbAuTEqNnjcgtwtN0+KE4pyabomwg9OCn5bvrBtx7B0Vp7T8UhA9rwvSX40AwC4nYUs9uuOXv6enq6Lt2r0xhlLS1r1st4G7gM/XzyILHy97AlGhinuIHzAY51NtzIbSup1xNKKDwR7lH16tK6NxWhq48FjHsrdgejSGMFWUcDGOWm6bGzE7s4ecl6m3D6N+CmZAWf705+dScpOuMl61vNpx/nE9u7QeTR10wGC4L8Jzmv4DLmzIrGc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB3818.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66899024)(9686003)(71200400001)(7696005)(6506007)(83380400001)(26005)(52536014)(8676002)(8936002)(2906002)(33656002)(5660300002)(55016003)(478600001)(4326008)(316002)(66556008)(64756008)(54906003)(66476007)(66946007)(66446008)(76116006)(110136005)(86362001)(122000001)(38100700002)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KGfQVRCcKZxh5J2Aho+F1XhFubaGp1YEqbREsPKOvf6R0CFyJP6/ma/HKl?=
 =?iso-8859-1?Q?EPc2JV6YxV1iE+vCCevW3FInwogiH+loRgYgFABOukF6oKxJXOHTBTB5OH?=
 =?iso-8859-1?Q?fIMTGaendIDniLDE8i16wsEWQ8jAMHN8cv7iwBFLScbpG8W4f8SExDNffp?=
 =?iso-8859-1?Q?rRS36VipB6CmbwdbDxjq+eUoh8iZcdRpCL3ObIZcd74tWOGjy/EV+zKHPm?=
 =?iso-8859-1?Q?4bbVV9QBFDt4iBuSzk62KDp75lhICiMSGLq2sb7qpiLE7tXaOT+MP0EMvH?=
 =?iso-8859-1?Q?Ow81KhrSsW7iDxYY9PjsI1tTrVKKLjxfa90k1YmKYfMmqY8oD15fpt6x9H?=
 =?iso-8859-1?Q?VUplN6GTxuLzD1lkGpD9sct0FVZaxkQ31RKc0UjTSmxvr4DRmcPTXIDyYO?=
 =?iso-8859-1?Q?4B1EmIFsoXggtNMjJCcvdS/SkGgLq1hECb/K+AbHS2b5STFihKjConmE59?=
 =?iso-8859-1?Q?TcSoXK+Q2JlB561rYc0UMdL0ypaYVGIr7RoKgPPgvOYoHjyidy6F6g0FqX?=
 =?iso-8859-1?Q?/BK6TkpxTjSGQR/q+0QqbKuLLYHEi/SETPiB0AX+mZmzZFqOZCHdNWg7yK?=
 =?iso-8859-1?Q?Ie5CqWCXav3XhP4ChEd2PzKjjKVvdWcyhowE9lPA+/9PvnSNSLIDSd7mlA?=
 =?iso-8859-1?Q?sXg7L0d0Z8kVOKgfx6S6jV2JKtuvJB11Kyb02+G21CPKMYR8OQnyu8l2pD?=
 =?iso-8859-1?Q?hTI4PdnjHn0Qmj16bGe7+08m1Kny0ew3K+y8Mc4ctKxLU6DN76gfPNuqKt?=
 =?iso-8859-1?Q?BchCDzj/O8kcGAkaAdaVLUHTHC3LZNw+8z78h2wDM5H/p2DD52Zz7dIO+e?=
 =?iso-8859-1?Q?Hbseq3vhEOcLk24Y+dG1bZ2sF2jT/mey3evIGDoE+WZKIigwc6v/4Evs9f?=
 =?iso-8859-1?Q?G/9cHLzabcU3OM1QNAnnwejTfPBqZkN/JtP8nbvxcSuz8S2N1JQ6EZZIj9?=
 =?iso-8859-1?Q?S2AsiIAGx9wGLvV3Syi0LeZWTLGT/G66Dc1dTFkbRrt5xv23HBf9jCaREu?=
 =?iso-8859-1?Q?yrLaBcl6KRvpwlwL6kYwdb3hLj7BQ/4zBzfsLwxqO+DcqysbUHv5T1jJz3?=
 =?iso-8859-1?Q?ComBHgY4zrCtcy3evJ7zwEcGROvKL0tVTXlqlzkzEQEgOqYyLp9fSOFifK?=
 =?iso-8859-1?Q?g1/qbJJ2BsPOloS/LBNWHbu+0MGd1ff/16CINiUZXJIJjAzdzuKjfGoNuZ?=
 =?iso-8859-1?Q?TpNAB6KB0zaR27XVAe5qzxNfLDylEg14RuclkQEZ2fVv94e+RT3uMuVIGf?=
 =?iso-8859-1?Q?7pHVm9YqmU3dVA3djPLwuEYEEtGc3Rr4GcEOc/K4D3MyVopBSlqUqYEKWE?=
 =?iso-8859-1?Q?hbw/9PLfCyPXYEq0CGIo3ap46x2COgfvKsqF38DGCXF5UsjaCmULCXnQ8Y?=
 =?iso-8859-1?Q?j7LuBiWLig7OZzwMYmZ/DyGKj7u/drKcFcLGYYcqN/6Kb2b9S5jSN+qTM8?=
 =?iso-8859-1?Q?PpXzxbWTpCQDXqSiuLqVMHwojZ5rQB8BRBVxQJG/CsaUi7WgX+ZSefM79k?=
 =?iso-8859-1?Q?0DLyhcSogD05bAx1WvTxvMAw4uTpBthi0TQ03emQ/UyhRpK15vRB4MNHF4?=
 =?iso-8859-1?Q?h2oVhtCG5JVdPdEGJod+4vi5PGYmOX81C7YQ3ch0Kwe6YLL74MV9hOkW3P?=
 =?iso-8859-1?Q?W6+93HOb1YFbLTLZCQmQoKatiWw8Hk1mk4pOpb1JI42NSpATts2meQqw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wJ6SeH7hdf5w1K3J87xA+XS1pA/BUlB13H5lF3pcEQ0tgQ3WFkS9+pU2dyFjUSDwJ1ccPb/JkdOplDLGEqMQ+51ISN/fdcFffbXA/dkOAHMAcHNbqeuz29eGkvbaYzNU2IU0LhKQm+TLH3cw5uCRbUGIMr7X1ws/X8ppA7h2zYDMDXBEyMTwrdsQ2FSg0gXHSAwtotfPaLDRbawLbzMdJoQYderxqFZ4EC53c7DS7ARUi/t9gwBNC5/p9+QPnuJGa5B9Llpi6VP/AciAu3lKQLbAS7kQqQLMlujDTBYYC5sjgJqzE4sQbPfYzVEcGD62SGJYWj64ocEdOr+7iOZfpSJfpBo+EeO3JVsofSZ1nlR+QKSuvFQnIQC3avedTSsfTjTnvpTCXYG7GjF4fE7xQZSVvsedEn9aluSwl3ME/t9VPHoS/+8wAeeQ1i+Ea4Q2+3h0N2o5uDoGDzQo08XVnSVCBRfeDKhExCzNLHeVwakzFmx4NTRA4sBGXrenAJjuW3/p5bzUQToGn4YzxB4NN4jsQenyc7gybjC3KqXZLvQ4G9tdaPERtjACb8p6LDdggiP2rjs4/7LEWq5g5R5y+J9t9EHzvELBxQh6qx5LZBzpYs6xieJvhrTysUD0Senw
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3818.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee019e8-ac97-4dab-be22-08dc1ec3ef44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 23:10:06.0987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERqQzQTW5XgTrHsmt4ZQW7FkLkk3iWQNAgHlLAfpfqtj8cIKUyYcy4hkddlXL6ULTxE4Gp1BOUKdqQnHzcmQs7b6liSurMmeqQ8q/Y51cpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3392

Coverity scan reported CID 1575482: error handling issues; this patch=0A=
addresses this by adding error handling to u_boot_env_add_cells.=0A=
=0A=
I added the RFC tag to this patch since I'm not confident about the=0A=
logic here. The check is reused from nvmem_add_cells in core.c, which=0A=
doesn't include an of_node_put on a device_node, whereas=0A=
nvmem_add_cells_from_dt does. Without much certainty, I went with the=0A=
less complex option and added it here. Any advice or suggested fixes to=0A=
this patch are welcome!=0A=
=0A=
Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>=0A=
---=0A=
 drivers/nvmem/u-boot-env.c | 5 ++++-=0A=
 1 file changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c=0A=
index befbab156cda..c15de5f7fd99 100644=0A=
--- a/drivers/nvmem/u-boot-env.c=0A=
+++ b/drivers/nvmem/u-boot-env.c=0A=
@@ -95,6 +95,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, =
uint8_t *buf,=0A=
        struct device *dev =3D priv->dev;=0A=
        char *data =3D buf + data_offset;=0A=
        char *var, *value, *eq;=0A=
+       int rval;=0A=
=0A=
        for (var =3D data;=0A=
             var < data + data_len && *var;=0A=
@@ -119,7 +120,9 @@ static int u_boot_env_add_cells(struct u_boot_env *priv=
, uint8_t *buf,=0A=
                        info.read_post_process =3D u_boot_env_read_post_pro=
cess_ethaddr;=0A=
                }=0A=
=0A=
-               nvmem_add_one_cell(nvmem, &info);=0A=
+               rval =3D nvmem_add_one_cell(nvmem, &info);=0A=
+               if (rval)=0A=
+                       return rval;=0A=
        }=0A=
=0A=
        return 0;=0A=
--=0A=
2.34.1=0A=
=0A=

