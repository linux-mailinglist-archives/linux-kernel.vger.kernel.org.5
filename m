Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6D777565
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjHJKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjHJKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:06:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F630DF;
        Thu, 10 Aug 2023 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691662016; x=1723198016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0cKXRvNeJPy/x85hv7UbMImHQv1y2kQ0875cwkMUN4=;
  b=KEioQKd7YJ2LoHvl9tzeizoJ3ENNnscKCLAUU/CrAHIeUkH7hjs/82+O
   rLkwA90t4ZCxl0EUqc4OJiAi6nEweWarX99t8YSfXJMhaVV4P9mEqnbdn
   u/z7YNSjN5Lrut2aeqwpoKUl40SBZ5nxK70GvZ69Ircui6Aouq0Q0fUiy
   IxFvhHJE5GRaNGINsYqx4kqi6fXM1vRTRdkztqvg7/O73v+1O67z3Uxt+
   QCSP7bNBwTKIbDPEfWnMBxQ8bsP7IWA5lSZDRnCK2qkW6z92N7kRu13hj
   XICSfgr0oUmT4QMVazI2Ee/2NPw5dhuMW4DrXhNDtfoT52osLyo+Duv1j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351661057"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351661057"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846313493"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846313493"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 03:06:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 03:06:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 03:06:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 03:06:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 03:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apE7RQBF2nq9t/U0sRGSqA4Ctm1+Z29hU6iWM8O/usTXkYFBVf46eCeJZOtsFfvmoJ+DAiNzVfvEIIvMJ9upiCgnlm96CO1bchERI3Y0RO1NJ3TNbA8IXv3nlHnX5HL2Rgn0w0t3Bzp6X6v5YchJkuOMVhu2u7cNFHTw59crz5Zsy7gO8R4UDVh3GFD5fWJNM2JE1iGe/htNL+r6XRnYFLzN82HxNNrOoLJBQ4/FoYCNQPsX6d7VPPkHoH0e6/Pq/LQNXmAOhK8xB4ETE6a5seDzc/PkFWcahvwEmNvrFFiVxkpqofglXm+WiYWdee1l5LBXJOz09+LJ6GjZRt2kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feEG7dJdN/wOSO+NdQnosq+ZlRm5tWocQ7Dq/MiC2aw=;
 b=S4ZU2uRNXkGPL6jIIvxYSOx1EBSTXXohwNtJrKmKSb8btKTLyadWnxlvGCeAkbyRtlMsBGBRJWthls9IMtY5hKAp97ETPhoGkn9FReF7kjL5mTH1DwLrQPOMaGQbYJ0mkPTdx8roidOKee+SjEfZP4czBTKBxEDL2lU5MQpkcJNB4n1zP/Hmtt7bMHIWrRXI1Ehv1JTu//GLGMSQymBzc2RRIR8FNkIua2mNGg9Dlvyj2/weN/4VPiYL4/7AAfQlVL6XKF8kSL76hWEjYzBABDTA3lgviA2vWq8kCJvFNJsmI5pxcW1+1HeO/vwTpFO4o5pY+waytOndWp/54oWlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 10:06:47 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::f04:5042:e271:9eec]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::f04:5042:e271:9eec%7]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 10:06:47 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 2/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_segment
Thread-Topic: [Intel-wired-lan] [PATCH 2/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_segment
Thread-Index: AQHZxP749lfvsNctU06nZ07JGS2dxa/jWkrg
Date:   Thu, 10 Aug 2023 10:06:47 +0000
Message-ID: <BL0PR11MB31220CB6D0542180190013C8BD13A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
In-Reply-To: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5770:EE_
x-ms-office365-filtering-correlation-id: 899304f5-d6aa-42b1-61fe-08db99898212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkP/PbrIluhebgHeTUWV3zkI1Scz8vL2WRHtNaRwUn+abK5XnO73ammxOOjP93zhGJk0wd1n4C/UdLcm40Toi7CkhVxUDyxMvMpInW+ChW2bTApe/AxyjyMcH5r90+urRU/xEiJXUAxtE79jnk/nBO6jYyr+37tN+tH7RkEAGx10MvqW9QeAWGuBMHPXDpY6RQ+tF0QU+Jt3/AfKa1rJs/M8InpkiwbIoQHT+2eBrfHN7vFRuFw9QbTjIrBzE7WeTbgi11W8vdZzD/SmBbYY6le2sQbWQUGIlNnnsAfdsKuIZdVrGQ/yRve2h3jFPmTrWDhYf809ldVViav/mzUohPlBD3kdzclrxxrqR8uASRlqOqFdvWAWTb5A7EQaHhNBER/1M7qwsHK4HQ7e9TpIRU/Oge2myJKq4JGoB9je4od7Iezp+Med2yKFk2jFApLuzOOAsZMpgvYoAAz764+F+PO6UYXjaess6JLk4XsPtpmWr+ZHOFcr/kfCWWNg3Ul6NUQAYqBHDmS/RbXWGjHRKWMtyHYpF3PuW/7seb2DErk79asfMSm3tnWLTWzlYuoEfHgVuJWW6q5oqmQZm+zEMckRJtAUxvM7702whOUgRiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(186006)(451199021)(1800799006)(83380400001)(55016003)(7696005)(110136005)(4326008)(4744005)(5660300002)(52536014)(8936002)(64756008)(38100700002)(38070700005)(66446008)(8676002)(316002)(2906002)(54906003)(66476007)(66946007)(66556008)(76116006)(33656002)(86362001)(82960400001)(966005)(478600001)(122000001)(71200400001)(9686003)(41300700001)(55236004)(26005)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s2IhLWFbFNZiGH1gUgiFIC6+todtM53LGHvg1xSmV3HI3od5FzKzSsU8H8dw?=
 =?us-ascii?Q?Kx5+2yTE4ab4dxWklFG8RHf++hjpICDGGvRaP5WrnObCRXTwz3UjOrJjWxHO?=
 =?us-ascii?Q?eOxAz6fq8LChedsEmyaIjMNGvaTcF9/Z0IBUPzl+EeITz3nPWcQN4CEKsAsf?=
 =?us-ascii?Q?jnPHe/f4WTtlQdmWmkPnPDKHwaLzTh/vJHn7drHXPdqS6qrw2qlS3VhfNNfW?=
 =?us-ascii?Q?fWYF2iKKak04mlC2ZZoTe4VwBR+fob0DskgTiYGGwW9QndDwuH6ml5d6ezn2?=
 =?us-ascii?Q?08jM0BuuH1zQlnFNx4aY0L3V5cJPpXQhVmIJRsbnyWWHB5AooUgsYjTgVWyR?=
 =?us-ascii?Q?IVNX3H5aM6rXomai048Tf/kUaMLeZ64ZAZbshgPrKjvEouUbVMb2jCPVGPCf?=
 =?us-ascii?Q?/RKQ2U1t+VWYLisD81hHlxlVFoCUtrxEFFjbHf8coDccREXin2znyUxxkEp8?=
 =?us-ascii?Q?5yOIayvFcuLUCCVhUjXFR49gS9pF3oJLA9pO910FAebzASp1qlyWx6rWA2Ed?=
 =?us-ascii?Q?i08YwX23mSzvj2oMpPeW5edq/eKuj6ax90Cmln4mjw66NlIYFiaFyh9LDa6n?=
 =?us-ascii?Q?rTmbZCspWUrQYNWsno070+FwcIrahgzN8P5232yKh4UJ6AFPFT+reHsy6u+X?=
 =?us-ascii?Q?pzXFu3FSSGH9Fst2++f8YEhKOF2RpZwSF46c8poJpsVSbs3ByFbcyQ6Zb+gg?=
 =?us-ascii?Q?BaDZVY6Ij52ni2gIo4G0UvIf2onBUEK+1SVAhJOoLuRQQfdQUVe+Ybp1c7SX?=
 =?us-ascii?Q?cjk+kpEFsqk/15vFRRPyFR8X7bmHOBJuW6DADFOtN8yXMkwzpbDL9jYhoECL?=
 =?us-ascii?Q?mMR9gvm4MIIOti9qERLSCn3DDRG5Bl4eHv5Amvnq5U7zPgTUAOHdN5BGugbU?=
 =?us-ascii?Q?smCDW/KnsArUT4eFAV4sDjq8CNQYbX6ME+NwUfDa8Ww3Ua+sCgMr5XdzcvQ1?=
 =?us-ascii?Q?rV8JH6btKFj8TmeKA/mUYq2WKA9B1si5+YjaMySMslAU7FCV88PlC2ANXC0k?=
 =?us-ascii?Q?/OVIErrO49gd9FH4WZzwr6n8KJVTgvxGNjvygrabGHBcXQOgadDQIP0sk7dG?=
 =?us-ascii?Q?aQhc4HYAMfG2SbQJTKeEDGRcx627pcPDxgz91RktcXjaRPf8u5J2AVbXTtSx?=
 =?us-ascii?Q?mSZRTs8RoIgZdyYHGPz1Alp+Apm/NM9GtwDvclsj32TWVivaymTaOzKxgKY8?=
 =?us-ascii?Q?C7GjXRXGXKjRGMzo6loW6IUowhxLESFg7yTG8nv1s78HbG6LNTU0a9hb4yCb?=
 =?us-ascii?Q?tBwDAOvTtEknCx7AmdzrMg02n9xoShM376D40/O4b0Psg6idOLxnfBPIlRJo?=
 =?us-ascii?Q?Mit6AffTSQ7o6Ft0vEixzTyuL6Rf4yHfi/hfogz4ICq3vW8ilsIxJuhckP2V?=
 =?us-ascii?Q?gM4qqr+W5wz0G+Wh1orBq04Pn6glJn+JFUxtLwLlCuBjUSQb29uUEJ09VS46?=
 =?us-ascii?Q?ilRyyfEvlLaaevGay+dC6eReOHa1PfSlcaJ3MqgRwFimozGI8ZvYmcJ2HiOv?=
 =?us-ascii?Q?d2nNHJRNns+RAZvMzs/1bjg2R5DBbmlR1nfa0YLfXB2GicA69/Az8mrKDUw+?=
 =?us-ascii?Q?RZezuh787oXm4XyFYXKfCAzVgijpHyXm7c8ms8beYLrJ5OfnMCeH58ICojcH?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899304f5-d6aa-42b1-61fe-08db99898212
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 10:06:47.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN21T9aS7vxrNfDNDGrfAZvNZQnwUMJ23vZ8Hh8Kzodxbjayh1i5yIf8yXuLUjg5UAk3rYAvkQ5Mz9Z/YML6SwU7OqkJFfud/GSlCRmbDlQ8r3H0nkuM6UkD6p0rjFZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
ustavo A. R. Silva
> Sent: Wednesday, August 2, 2023 10:36 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>
> Cc: linux-hardening@vger.kernel.org; netdev@vger.kernel.org; intel-wired-=
lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gu=
stavoars@kernel.org>
> Subject: [Intel-wired-lan] [PATCH 2/4][next] i40e: Replace one-element ar=
ray with flex-array member in struct i40e_profile_segment
>
> One-element and zero-length arrays are deprecated. So, replace one-elemen=
t array in struct i40e_profile_segment with flexible-array member.
>
> This results in no differences in binary output.
>
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

