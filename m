Return-Path: <linux-kernel+bounces-16417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656E823E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E78D1C20E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A37208B1;
	Thu,  4 Jan 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pjvoGAv6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDF208AA;
	Thu,  4 Jan 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRMmqKv1TI3dtOnqbl+7sOcXb757D5CDVpvJbYQOyparhJvWxlRAQA6Y//j7fr/u/vl08zq4UgG9/aOarSszlJWsV/XQU+vkmondHP3bs9gyrO7A9onQfTqMsdgUhnsTpVrUO8LiBbQtbDVvRcxU3vl/LrnpUkIS7iqrcNmUYmwmSHVyZkMctfBVWO2OTjt/8zPRzhg+mM7h2KYIY5zo+zGpmNW4+lnKiCr6PKQy/X7ILZNZOPCtO28HoJ0UlJVL1W2iOHyTNlAuYipUTRHsUbOTniZGJfpD/48kMtkPgTMXvqMn2IiJUNUzC00mDC11R5rF5NwASP6vx3hsthCAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YhupcUekJ9DJ9ZINyfsjGPmOSxo/dUMGMUQkFoFLgU=;
 b=Muc01FnGAEH8qYKriXf6X9muX0kHzs5W7YyeJOU3anahgr5QSR5CvrL7OxIDCRH8Ea4/sVFTI/RaX6quJhV8ffr1EadSnGgxmC93HZgKmLJlSmVDZ+Qo3/hjGC+EHG1NM8okcMMnzdL8NBWuQmYc0vUrJJPGHHAHUYT79kdzYphVa7u23buxAu/NE0Zk5krHVlliCMcjTxxsF7Zf8TeQr5/M7DMUNSgI8ABJS/2xnJ3jIOlZ3ggfnz8BTN5+ghdQkmpwZZSwbVbsAlmOcimTy8bq83omTrfxDWYE7tS3BSXKlaimv/RLU0/CSFedTqnYgv8eqS2zwsrfSwtayxlDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YhupcUekJ9DJ9ZINyfsjGPmOSxo/dUMGMUQkFoFLgU=;
 b=pjvoGAv63u+qxxteCTdndAEA35L8ptZHNMOiLu9YHHOucTWec02n+5o1i/c3e06H0Lhdagat83uULu8gl/GJFTGM8uD0NX8thafcXspLNpRj99imdlV1X0FYDVESFfyE68Ef+TmGcGCnNXaA3giNA+WKrkZpIObGDlpFmX0MncA=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Thu, 4 Jan 2024 09:06:40 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::a8c9:b59c:30d6:b411]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::a8c9:b59c:30d6:b411%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 09:06:40 +0000
From: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal, Nikhil"
	<nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] cdx: Unlock on error path in rescan_store()
Thread-Topic: [PATCH v2 2/2] cdx: Unlock on error path in rescan_store()
Thread-Index: AQHaPX0wUwQ9HophjUGZABt3B1Bf6rDJXuxg
Date: Thu, 4 Jan 2024 09:06:40 +0000
Message-ID:
 <DM4PR12MB776509F5BB93D23A48AB03C58F67A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <2e66efc4-a13a-4774-8c9d-763455fe4834@moroto.mountain>
 <a7994b47-6f78-4e2c-a30a-ee5995d428ec@moroto.mountain>
In-Reply-To: <a7994b47-6f78-4e2c-a30a-ee5995d428ec@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=43a8e5fb-76c2-42a4-b0a3-c1a559dc0a93;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2024-01-04T09:04:25Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|CH3PR12MB9079:EE_
x-ms-office365-filtering-correlation-id: 05ef2d65-c991-4ec6-4751-08dc0d0476df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IrXMS3nOXit53N1jpbpcerrxoz/iTyow5neITHO+o+j82R+lFcSLpljehDEDkMbfhb2V6VMRilQnAdLuHDjcHqHZ3SL5XKFNaM6olD/i0fn2tFX6AXf/t06gyINQVUpxGTJ2rg7uTRH3MroFDX05wShVkKjcIePwAjdorTzWwjpEQM8VnGGke24IQ3fA21DX+Ys41hTOOyR27HYG/5F7uQZMwpXd4UXqhMuKFhATx455e5KvlsG995S7Jf0hyOjs/5ap0BRnrWPEJ0XSd3DPJKyUZAd/QDthZn0rd7O8ZV59LroH37cfhs1gSFDQ2aOHLNlwJnh+CnOKyPs/xHss/aDQITtac1S6lci2+bRVv8u4tw2EimR9+suWcwfG6yXipAvHBgqcu4pX8g3jx1tpfSfeRUFVecv/va5G7U8w6jQJ7JiXE3PH4lxnE7DWwJAGwqQbU/C4Jc7nhH5TxigVEmIyOSkUEeM9RnIG0UappuMy3+ao+TiMhN55DW+BvE7YfS/HWu+5/VYMM6c2V9i+U72OnXiaom5wGCeJrxiO/6puOMGOHVhlT6YsqbPG8mZqhyWjAwNYW2+7J5MVsgD/rXY5utVLyoER9x2wvC1As8wgm5pTWSmcFfLBShymuRlu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8676002)(8936002)(52536014)(9686003)(64756008)(66556008)(66476007)(55016003)(6916009)(76116006)(54906003)(66946007)(83380400001)(41300700001)(38100700002)(66446008)(122000001)(86362001)(558084003)(33656002)(6506007)(7696005)(478600001)(71200400001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sdl0OLWEbFa2PzwVJdIejPjDgH+CWaTRvZ8Zeirz4+8PY3SL2zxW6SLBUOkm?=
 =?us-ascii?Q?SmTC9YE8wIaNoARjaQAbd1EasyutsX05dRCepFE0TEOanjfYntist2btmOaW?=
 =?us-ascii?Q?7qwZ47iCfybFCTNH3dhc6PqTeIZfQnxkv2ECkG3fEWKBmsLWLKMA4b3ejQ2u?=
 =?us-ascii?Q?5SVWEhxV2UvAI8Lmsm3C9jtMB/69F8KQzkoLNG2/iUxSJUO8cgr9E+/YSHjv?=
 =?us-ascii?Q?Lrn/MBMLYlxjgViq2+VvYpMI9sCejzfRGleYqB2RvxVGqAtDkjbCFQMBrR0u?=
 =?us-ascii?Q?B3xjPalN/8X3lboqdnuZMTgaQbgIZpAFZw8gBhr6tqepjKNWx0KQOYXZ/WBv?=
 =?us-ascii?Q?Y61LsAC9ZNtjY91mUToAGrEk56NdBWbOImHIoNrYr4JsJfo2Ti9QPsrcluaC?=
 =?us-ascii?Q?TxxM4BuZrT/lefQtvDB3aaQG93V7uTN69lKimiuLP1/aQcEsmcTYSOBGHIRF?=
 =?us-ascii?Q?IZPBxqXXkw1wy+2t88lqhF8ZDKlo9CnopV4SXiFX015+uh2TYMdueLapvxuX?=
 =?us-ascii?Q?EcMFRm8rprX5wwJAGAu08FztVBNm2STL1KaCp6ekOtcDZ/fqtgL0wZcSztXY?=
 =?us-ascii?Q?gjIsmi/BzuzsqeV5c5YVQE1yhBzlHBlq0OopAUV0AM8k54vhl9ZHKxh+wOa1?=
 =?us-ascii?Q?rJ+UKA/d2KG0cjFhd08W4wfDCSCYWEh5mlbgWHErs54l3iv03vMg0DQSYRV1?=
 =?us-ascii?Q?S+lSppLLQGnDbhOeTX9cYMNcWMeZzSakb/OF/6DWIY4OernWm4xIEJearr8W?=
 =?us-ascii?Q?JNunzuTw69+66RjF7ne3oXhA5ODgrXiUCp1+BH+iTJ0ZpQQmGYyDcubz9tsT?=
 =?us-ascii?Q?FhEbaiRqluAkneNKjfBW1JGhvBoS37saaafKTVUhQQ4dNT9Qp0PyODxjSCP/?=
 =?us-ascii?Q?V6vBFTvcCwuqnMtGnfYbrMZIoKaw7I93S/ykEZXWzq3vSkV7PlAElaS8dTbo?=
 =?us-ascii?Q?s3XJfv+WTfWET7OvHBk6VsvSZH5uEYiBYq+DIiCWhJ//ChgjjFMzfp6EqmTD?=
 =?us-ascii?Q?U2WolLlEc1bsTQZW2T7VHafAojLqDvV3m4cz/Zu5OyVya7IKk6fEmkZpJEl5?=
 =?us-ascii?Q?PkQA0ia9y0n4z1Mr9BCYrSmyO6Xl7CLwNGOEGeGi8JgZFcppcNdwodquad/+?=
 =?us-ascii?Q?+XR1QDrlHG+6SOMyDZJbA2F1EQ8070PAJHkvQqVgk5B1GmqMBvdJMLEWnJmF?=
 =?us-ascii?Q?WxPjBhtNsRf1fjT00wDi8U7lA7dOl3YmOJcvO7SNUXQO+68PRRT1cT2bRYr2?=
 =?us-ascii?Q?Di9ROf6D0tVIJ/o4r5vYhhTXFjq1uvh/Row+YU6HWEgFVIv5qT5KJsH4mc76?=
 =?us-ascii?Q?IOslU8zLMy68iDgnjhec/sylMzNS9OMFTZrXit3qFKGkTws42yyky9UUKH5D?=
 =?us-ascii?Q?GcEtx542uJXiB7Ve0JB3VfbzV36QKsE+dFA0dQFk+3OWG3BcV/nblbyqQ/fM?=
 =?us-ascii?Q?jesd7n8MJoRUiIXjqklvLfwUHdgz7HJ4rvBk69i/BbXQJWSbF8S12bX8WeuU?=
 =?us-ascii?Q?eSlXYf7hgi0OcOY98OR6eW2ZLrxTURlHkwjnio7ozN5p5BWhiYxlXAcd70d9?=
 =?us-ascii?Q?2xewCR7xDodXH3EiysRvzAX7S4nf2y01c2G4nNSazwcHCvqzrchV+g21koFP?=
 =?us-ascii?Q?s3vTxhb2B1yxYhiQAihVN7A=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ef2d65-c991-4ec6-4751-08dc0d0476df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 09:06:40.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cW49UiKUGvS+JlFVK9r6J22C8FqMgnK52uqUNSiZ9n/1KXYUECyqOAmVqWslIXmBzj9KsbuzWTVlLtIF2fqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

> We added locking to this function but these two error paths were
> accidentally overlooked.
>=20
> Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
Acked-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

Thanks,
Abhijit

