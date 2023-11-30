Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F77FE898
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbjK3FXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbjK3FXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:23:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D310D9;
        Wed, 29 Nov 2023 21:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701321790; x=1732857790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m/MjMM3ZW5tV125WyDxlkT6yxs4pwyvX1h6ar0u3SD8=;
  b=KqKbpRwH/f79I/cckG8mwMmELwGrAWXnCSG4NoxiGqZf1MwPyXKfI08v
   E8BgtQ2gMkIqLWleeIM+P+3pxGreldWeoTW+KGmZU6h5L37StzAjl3PoH
   4ChQej412TgiWAlU63STAUoHMgsOmOWNQXs68/Whw74ZR6pkX2o/2jqPv
   av1JVqUMEv+HefeDwgdaC1+YOlFe+KpfaSGtTPdGM4pfdbKsvVbze9o/I
   ZPeMR8h/D+nfOv/PjlDZMAUEdPvL0SeilupGsoNDYd4anwO6601m+hYmC
   UJgePpB0ePuDiJ9Ic4ZuEKwyvkOehgVsdVhJJzrKPsswZlNsUcM99Ic36
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6487594"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6487594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887117091"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887117091"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 21:23:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 21:23:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYMooVpGJC1IOrZfyrIlir5UGPHI4oexuVyhBDY6VQGA4ajxi8vHdURmLw5GaWHiLwwhoC+EKlt+8LGkLwmF6Fc772ug/UG7goQ8J5qU3VCWgcZ3G49hJfgA+jLctG4wKS0BPTCVpxO9R5gRt0DtsoLDE27/sYJ1lT4Ew0zVjAbD+im9ZbjBtvvDuqKhNJRUFufLKg46dmPrl1FfhWcEfttRrzMIk+kQPjDUVQvJ4LOHgpALhVcJAyhLy6F63STkDZKwzHX754WxF8TM/JE0q8SOGHDpJ8Hx8IrJriw1sFg2f/f7UPVLjsPGv7VerhH/xs8XwRn1baZLfXzjt++r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adCutIaWqUbJS4TN3qOhujJiZxUw4ktsYc7f0bbkxe4=;
 b=beuBfWtp251A96dPHKtdSq0IC3fWUwgsLndSjJOygVPXRU0W2FH6kL0zxh8nP/s7xOoLejc2lht0PImO81Cui3CdZ51pCE60xB40srevKdXbDbG3aTFCma8NqW+PP3bv7bu3xcjNxsD8pjptngJ8DVV0kKWby87NayNd12EjGH+BrTdCR/E0hjZXGmPsyKaabNXWbjrIS/JEmTMZziPdsJ1qTP8cuF7bwCUfXUlfq9OKKPIYvz9bIenkR5xKw/Fp9iuBtxRSXTBKWgyCG+nxuaSgkDy8XOVREyRKKxEoAQWu6rpAN/62pDlmLXGQcmDa/xkgChEAD6hGu6lYtlY/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:23:06 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:23:06 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v5 2/5] i40e: Introduce and use macros
 for iterating VSIs and VEBs
Thread-Topic: [Intel-wired-lan] [PATCH v5 2/5] i40e: Introduce and use macros
 for iterating VSIs and VEBs
Thread-Index: AQHaHueJU13CxeL/kk+c5lK7vc4267CSVqzw
Date:   Thu, 30 Nov 2023 05:23:06 +0000
Message-ID: <BL0PR11MB31223F724496F16A60479434BD82A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-3-ivecera@redhat.com>
In-Reply-To: <20231124150343.81520-3-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: ef5dc57f-828e-4160-f7a3-08dbf1646ee1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bX/Xz/tKLBhgvH/c6VbMMtNuNsOJTMTE4FA6dapiNAEBLt9t9SP9mUpjVQAyCebFYRTBBbdY72Q7EvZfCJSewplfoqnI5WzTJeoV0Fow79HK1q644hc9SkBFCx13nLnwbTDEQXlM+Ocp4+S40yomZlkEFnel+SZGfuIX2xMLl11f0XmBI86EVxJ8BfAeQePYuTwiyTkn98R3n4QlDJV4uc3I+FdVkgVXL8YZT+9qmWtgw6glkXkdWmo79qeMr9y29/UcGDsASmDVZcJtAT1tkaUuXGox3hH7CfYlQdBNCKjZUcCKVsGxviDSy09EZ5m7bgLp7XJC30ciyJYUCPMuP23GXeBCCWB39NXxyNsROKM4I9Il1oWZYnmeK99H16ta1VwBy2wLrG8XG9aRS8/jK1q1e8IhoEHvadSNEK46HTywn5mSvx/4EuO2P7vqyVVMxyjs+So7yLBh3mP16hKVlyJP7CHFUbQlz/EX7JMj0btGEXQ4yzZHMF3Npyob5uBx18i+KS9SwtrGMKxYXDaB6cxRoFJNT/pVwKqigcRHcyVWVZKY/NdWEawuuOWIdbhMQTWRT7gmbm3d+1PjIBFaQmPbFzmGOQakcpvQmX0p5F5sDNqSVBWyRedbuHyuzdeKZ0VxmHvoqE93hVazMv118NGHSkSZH4ZP5dSJn6qtQA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(71200400001)(9686003)(26005)(53546011)(2906002)(5660300002)(41300700001)(83380400001)(7696005)(110136005)(8676002)(8936002)(66946007)(52536014)(66446008)(66476007)(66556008)(6506007)(76116006)(54906003)(316002)(64756008)(4326008)(82960400001)(122000001)(86362001)(33656002)(38100700002)(202311291699003)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFiS32lpIQlcfMrG8I5wVMt/LIA310aVyIZT+ig2hu+bIo1iNGnvZqTc0bbR?=
 =?us-ascii?Q?2iCdoPbDnv6PcZQaP/JeTSZR3Pc3925MuC69uc8CbtYx+Ui8GMqEyYbJwrwP?=
 =?us-ascii?Q?atZotta9K69Xono0YABXovnWuKWlD6Z5q75MA9lb1wraTJoPRyDrUy1uZqxP?=
 =?us-ascii?Q?GJ7bD9/NfreGrnRNAuxM6ProyUNuFs5efbtD4ic+OYg2O+0DtrWTGWqDfngO?=
 =?us-ascii?Q?3NxJLm1otrYM/z7USjZiuzpYM33DvrOnoCkis6Gnp6W8eAMMpyZbcPPbH2mE?=
 =?us-ascii?Q?G1JBSoL9Z5KVYe6cVbr3kw1V670WdETF/lmZFcryxYW+lNhehr7tcp7xEfFW?=
 =?us-ascii?Q?vUvGCTs9eTKwAKnp3PK9sPYcxq3S6wMadOSi2FEz4E2CcOGSM+PmMH4VAx3s?=
 =?us-ascii?Q?R34H/op3qMgl/gqs+3o2648Ch26KKcLPzLqSpDFt0IyufmAChyvCu7+ea4PJ?=
 =?us-ascii?Q?PWwlXrR0Aaw1tupZAMbBWF/b6oIQtZat3JeppqKVn3Ri1qMbJBs1IbM+kSC/?=
 =?us-ascii?Q?y1XI8djV+SAjTG4MraQheP6w7gxw2zaPf55J2QpG8hHKz5nmeTzUXaEH1ck1?=
 =?us-ascii?Q?evrE91lPmMRNXImNRHYR2wlGCTB5vVGv9u35/qVb999Bsyw5Y5iqWnJnBHOP?=
 =?us-ascii?Q?4SVJmx77fcLJIuJ4DvLJQzepyV/WfTGxOvalA8e8G4JQNcg+jIj1Gau845d6?=
 =?us-ascii?Q?kty8e8UUqHe9k45Bd4OkfSoNxLMRNUhadb4lF7Lr2acGC9+IDLHFxS+4UNHG?=
 =?us-ascii?Q?nlCCxro0f8vtw3MzJXwKB+HuovrUYnx33oG4P/+VQkYZAEVJOtjCsjL3vQKU?=
 =?us-ascii?Q?GUwNaatywOwrJik74i8tr8eYUo/1H3erWogqHB9HmKL2XF5d1XgGl7CBoQ8E?=
 =?us-ascii?Q?pniiABPppfFlbNnRgu8xZEpObMMnYo688VCpD2TnpEvScHeU6lqPk2GWnY5h?=
 =?us-ascii?Q?rlEwRM9La+ISBZv8a3gwwgAIyEizpVqis7G9/phjRDli0CY+kh2x2bKYr3n3?=
 =?us-ascii?Q?42eSWRJ6d94miwFnbyeqIakBTo8bmlI9KQmzWgt+LJ/wjPxaqSU2D0MR1ryG?=
 =?us-ascii?Q?v0Mq8MDMxbW99AA60aYyW5nnW2m1gqNhgaTKfOMlezrlFCD7wcd8+kzCJOZw?=
 =?us-ascii?Q?twkduPHsO8ZAbpRRFrxmF/jbafFtcLcnx3nxMxbUxnSWV6m2rreINt2jdlZ7?=
 =?us-ascii?Q?3EMajKbirOfQLAfetDJj5RsRZlLEwCldfaNolp9sAqcBf56H97Cr8ZpKfY7F?=
 =?us-ascii?Q?VFQAi1Tsg8dT1LINENW6t1dn4KMVXBJ9eEHs+99MSiM2A+NVyqSjp48MfRLP?=
 =?us-ascii?Q?1LhNtzEfxm28i04Jk4dl05n0V32qnMzCfp9Yn1oT9jH/GCBbQJ7SCDhrT1gP?=
 =?us-ascii?Q?VjbOD9hfoGm7lUm6Z+QfQdeA086JyLOO/xHVIByJye2+isA+jocCc+/EXGGQ?=
 =?us-ascii?Q?rkNGrYMFoOc2sdemaH0WwlHh4tjEawRsejj6VRJ+XA8PK/MIc/wHBY1I3pc8?=
 =?us-ascii?Q?U3L9R1UeTKTf/GnNlywK1fFgyvIkYzObv1BvIKzHVSBj3/i4ErSuVskKZ843?=
 =?us-ascii?Q?CvhvH96iCBRoZupsVrQ4FwBPYfhFf7H7DhLwbUkOiPXdFMP5EciAUdwSVXls?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5dc57f-828e-4160-f7a3-08dbf1646ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:23:06.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuHNTJWhcrUA4y5Mbmk8SAJBNyWoXA+r77Zi9Eb6MUpdnc26z/a948uMeQSxl5aYxC55dCBisYTahS1kZlLARtWmTqQkutzRfT8Vyyq6NIaXO7B7hFWSGyxH1XjyWKvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Friday, November 24, 2023 8:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;=
 Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.o=
rg; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Simon Horman <horms@kernel.org>; Keller, Jacob E <jacob.e.kell=
er@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat=
.com>; David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v5 2/5] i40e: Introduce and use macros =
for iterating VSIs and VEBs
>
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
>
> Replace pattern:
> for (i =3D 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
>
> and pattern:
> for (i =3D 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
>
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  56 ++-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  54 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 389 ++++++++----------
>  4 files changed, 264 insertions(+), 245 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

