Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234B7810F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378771AbjHRQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbjHRQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:50:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8733D2D64;
        Fri, 18 Aug 2023 09:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrRyZIxc/Q4QK/znetdT78GmdBfZ828DBLgnqZSWfNAxqfsxvF8R6DzfjwVSXcnpcA1Sl4h9parrIwuDQ8QF3dazraUd20NzTJoQTyty2L5o21MjprwtokxxFkiFoa8qING4wsIry4RakPJWsrjw+jCBCC4mmLa++fEqco8RQBS2K0nSuQvNU0Z/DJSQT+/AMiiqOI/YgrspbcTSVQreSU89CFRXUv/KoAs6g09m5e2VCr4+mRZ73MXIVZoQNNgTeyLMF2tT2ovVuWCRgdpKugsijFymseDQrLKaruw86CmkTBJMP02+8wwHJ4YVdtxCRSTFVD6nZ2tNbchocaBokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB4qXlChKXG8c63sQi0EVUaEAq8VIJ3RRkfBH64WjqM=;
 b=fL5shIhXQVdASi+qkJVQrT9wLjvEIN31scse/wP0nnm8aF4Em+mwKATSWMfwGSD33TAyVEKs3iuC7M0CpFcGShjuJoPV7r5Anc4gGr6IdFBKmSGjqLo+1F9UHNcxixjEeXBGXRdyMZVe+CRyVcPHLskE2Qd8nDrDCdaf3odkZjNcc/aMS2plY6izNjhdFgArlV8JiV/7UNU35P5QPge0iD7GBZrfVGQWNBabUaVsSikNZ+w1QutPpKAEpoXQvnVAJcKxXtWS0PY91QZhe+lcb7pZEqXC1fjY+ZPWDkPpK/38HAz+WsfV3E9zNWBgq6K9RfrzEJFSFvAmd4lce8S9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB4qXlChKXG8c63sQi0EVUaEAq8VIJ3RRkfBH64WjqM=;
 b=AhztYxsyj7aWlD/KcBRSA4AS9OkUmsLCu04zzn+Ce2lS1u/FtKhmnuzh4a28MoauY0SQNleX9EHqHVAKdKqV/HVHnwHZ0sP8y9SuK9p68NFy0LK/+aKj40sxw3xDfNsULffR9IPQdQKgoFO9luC8XJjLabts+2TEfCFjQkYxWCWGpgwPDeAyrqOUuPVN1a2ZxDLYNNeVpVRcumguoYaT5wdjbgZwkTumMKPnyk1RVNQWveBsjRC3RMCFm58q5w8B+ZLSPxVBDgXbr/Nw4Sv6on+gODLOV5cl7YInv4hgSl6kqhE2PFhAfv3JmPQgWO7F4OY804xweiN6ZMKAxMtX2Q==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:50:04 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:50:04 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkIAVd3Tw
Date:   Fri, 18 Aug 2023 16:50:04 +0000
Message-ID: <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: 26cba827-58e0-4299-a118-08dba00b2bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /60S9pLtugxZulwl2uWMCUEJX2Gos9+Q1Say3MI6LU1oFVUBg1PeyNATftkkAMib70cD05vdChkTibM/lsJuD2g+zT8PCLArD9IQnapT9xWjHd7b0GvxTfg3m9pKrGK4lhlJqugISZzmTfc5Qd1utI+lkCo89eeVIhh7tYWwn0cGwFhuGWYQN9OwQN0wiM+FgPalhT68Zsw6C6XwYnDZV7JSqAag7uImH4zhIr+p7+6zMjW73GjKU+chJ2RnXRGiwpUDqqP7hTqZHnXvkX/2O6a8tWn2fOlUUyDlp7K/pboV894pv1XZiQDmw5Lw9uAtVdaspLWQ2fFaMyP+LkqpKxD/LsnbsbYvCWQfMn6GJvc3VGJKzLad2Rs+dS5/F8hrY0eBe8gCKwLo7jkLTXlFaNdM2+owh5CPhXNZIBK3KYaFAEGOiAFo8nQwFaMLJVcVqjrJo2AiTpt1nfkolmuAt48KDSe1Frj8ojDn6+9f7DsNTY17Rmx0lp3L3x6TJ9nCuYQuQEhbDF0BeNmMSpTP2PIAV4v2GHFMxZRhyZmPLp6EhAJG2maT3t+2+/dHCbdI0COxI7z7EGRi0h4Zp60qjz1ftN7TI9MU2M+wdGW+90hARYRggTvrKVutrKteGy/zTIPvbpgkd7Nml+FQMI6S/7/EtHa2t8Rj7cTPUV+3qwA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199024)(186009)(1800799009)(110136005)(76116006)(5660300002)(33656002)(41300700001)(2906002)(66556008)(316002)(66446008)(66946007)(66476007)(64756008)(54906003)(966005)(7416002)(8676002)(4326008)(52536014)(8936002)(478600001)(86362001)(71200400001)(53546011)(38070700005)(9686003)(38100700002)(6506007)(7696005)(122000001)(83380400001)(107886003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CyCcNoDVNyCFBwLqF7bN72g1beY9PrPw+zdSz8/6ITGlwRDAQvHvp2PwYgNx?=
 =?us-ascii?Q?oviyguWh8y1CVynCgY7n8orhg04XxwBzJPUmSQcKu1cm4n3a3z+mWuY4c8JE?=
 =?us-ascii?Q?F/oxdEphqjduTM77owgsZDR0JvAF0Rgh6K8AdRcMyHREO32mNqe//ICYcBW0?=
 =?us-ascii?Q?41HAVSmg//Yg2sE3qouXW3edHiUgr/RCR/6aa91JAvsTJLnAmbiI6xDy3lR6?=
 =?us-ascii?Q?/CzEKUGUxuHJN+3vfquTqgVXt5xu7mGLkS3HtswvPPmkuADtKPVKO0z6W7b1?=
 =?us-ascii?Q?IsU/yhIgDTRzhS+Rov9VoNsZgNFY/7Vm6zfnLa5gXAzIxQ2LtS8kmSjjnmbb?=
 =?us-ascii?Q?hw5jEmxXDeN/0NLYhteH8ePsHQ/t6fYoMgW3zABEpc+jmoZ9B+bveuIBlozK?=
 =?us-ascii?Q?oPvduCvDYEbGD0DM/vJFtdPpEdcMWhif69o6TA3Go79uGey8j4v/LSpPh/OU?=
 =?us-ascii?Q?jXKj/okSYPEcs6C1RzkaAA2eXr8FdCxtbCYMdgIuQxNVNelGQgZLIw/VFvC1?=
 =?us-ascii?Q?yyWAFMx9fthmMoMOvC7h2PhPGSHQZ03qWUNweFd0U9g8uZAFRZaqOUYcMm4c?=
 =?us-ascii?Q?6He5SLo5zbWUOGkNj0voeljXiE15X9mOb2j2of7KSkFSjNGh+tejuxc0QmEa?=
 =?us-ascii?Q?n7MXQg1bydM4MrlG7Krx+6YErMYIySXp4iJ1m4gfTTeYAs7c19BVt1aQSHmG?=
 =?us-ascii?Q?WmWUyuKg0avhTtFFek5C6g62LF2JX0hZdrstyO9CyFtvfAwidwXMgJGh/EIo?=
 =?us-ascii?Q?0lmmdHYepW7QS2CyF9olwssNfEbXgopKUwd47Xgf4jMaj4PxMlk36Ft5HyA+?=
 =?us-ascii?Q?FyvNenB7fPa6wrQuhfmWQSrvZ4L5pOnQLEDy7guClaXC03zp7ESRFe15RRR0?=
 =?us-ascii?Q?uF+VWt3miyBPwkubWgqYJZJCAJ9eiqQUPcAopuAW97Gxj8UKrpHsy7XRQAsT?=
 =?us-ascii?Q?UGQ0oVpj+DURCIPrnuFV3o8164/KNjMdXWCq7wN5rSudWmgyMrufVVbR23p3?=
 =?us-ascii?Q?/HiItuSnhEsNudQ2xqcMSSQXkrsZ16oihxFN/7OyHizhbpl670o8rwiV30pG?=
 =?us-ascii?Q?xHnBSjVz6lsRdTOwNnDWw5Y2XPf9WiprlZeocLbE9Widl7OwB46QJvbBfFX9?=
 =?us-ascii?Q?E213aH8Vj6O1kR+THGEyRUV9Ti9+HepuntIYXnfhfmbVH1J4KG1JA5dmD9IO?=
 =?us-ascii?Q?ejNreoXZ440lcoyjuAECKcrF0FIguljSVVA/4zRzfELGfLqmFRILhtOPTWin?=
 =?us-ascii?Q?mM3uDPKLxg+NaG9vxg8fZhMG7LipVJqG1w9tvAElkbSLojtdLQwLzy6RaPyY?=
 =?us-ascii?Q?LQvzq7d94qM68ewPLnleg4OiEpNvbZewn/DcTTLWoLi7ADwtcfBCJwsg/X/w?=
 =?us-ascii?Q?JyrKrScMSN2gBV9gjvE3Ec6qAZB9Xj6fX3xiEuVXw/A/4hQJEZE48BvtU8U5?=
 =?us-ascii?Q?0Y8xKlFUu/ly0wG/vgCk2SJ87lxhEthpVCudMsxAsHRb17FuQGP8D0G0vJja?=
 =?us-ascii?Q?L9f0c+yK5CGdANClyrDBjgxMayEdPcuoaJyjFCfXDbq2Yc8EtK4yNwoPNVzG?=
 =?us-ascii?Q?0ZPratsLXEOVy734olRvD3ABW3gfaiENsfz2mDSutNdM1zYnhyoAnP0VOeqV?=
 =?us-ascii?Q?OpGLOZjNyYQvwXQPxtHpVos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cba827-58e0-4299-a118-08dba00b2bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 16:50:04.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ei2M0p2AWHdMyrLuPVpqQn5iCu4J6mr4OF0y+mKA3DiAOTSoNW1WY+oGQ2OGdxEBOrZcWeeVqRDX/pcRVUZ4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any further questions? Anything else holding up this patch?

-----Original Message-----
From: Jeshua Smith <jeshuas@nvidia.com>=20
Sent: Friday, August 4, 2023 7:05 PM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Thanks for the reply.

It's not very easy to see. It's just a bit down from the link you sent. It'=
s the last possible action in the Serialization Actions table:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#serializa=
tion-actions

18.5.1.1. Serialization Actions

GET_EXECUTE-_OPERATION_TIMINGS

Returns an encoded QWORD:
[63:32] value in microseconds that the platform expects would be the maximu=
m amount of time it will take to process and complete an EXECUTE_OPERATION.
[31:0] value in microseconds that the platform expects would be the nominal=
 amount of time it will take to process and complete an EXECUTE_OPERATION.

-----Original Message-----
From: Luck, Tony <tony.luck@intel.com>=20
Sent: Friday, August 4, 2023 10:31 AM
To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@igal=
ia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.=
de
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

External email: Use caution opening links or attachments


> Can the maintainers please respond to my patch?

Can you give a reference to the ACPI spec where this timing information is =
documented? I'm looking at ACPI 6.5 and don't see anything about this.

https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-ser=
ialization

-Tony
