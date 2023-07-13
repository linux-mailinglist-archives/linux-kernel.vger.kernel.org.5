Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE2751D14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjGMJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGMJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:23:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990101BD7;
        Thu, 13 Jul 2023 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689240182; x=1720776182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xNXmjAQQlzhOTq/05JDj6IfpY+37SoXUelZevK6kpN8=;
  b=PGh4TRIcJLEZMYRJ7tyaAkXD9F1MVi4hSU/1HofnM9oiLMKexzGc4DhS
   MiLsqWEp7jwLS0ag/5jn9zTYsGGIdGirhnZj5t1S+lJMrSmR4b/2/ClaU
   VIZb6ASnr/5yXmxZztVrHejpIoXsUhWvLiBnKVtwHQeCWWbvPDsfBoauO
   SrgnFagUPEYEACN+AIUosdctcX9OIjlYz7+Q6jyxfXpEQbtO+K1cip37A
   hOVJOD9k6dvNPCLc3iRSFL8e7ghYCga9zSRkm2B8nPjM9PZolnr8mhxg0
   WS54vN698uVkvPFrc84SaoSOicztDl+pLkqzyzhhC3dGLIfrS4DFLEHWa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395939116"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="395939116"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 02:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715886820"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="715886820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 02:23:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 02:23:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 02:23:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 02:23:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 02:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GffEDnzlDproVVG/B3JUZbprY+IAwV+JKGOVZqT/blqZ1S/kbsE4bEvc/btG+NiBClpp/GUSXfPAJooxa9R4+i+jEkp8UkuI6lmD9BQF7nUseztdrKXjzQSOheQF8145UzoIXaO1hq1vD1zvUR8CayDh5gyH9vFloqOgXD1LErQt+GLcOR+4fun3/71xEPrW/LLi9ba4ykkraSlfImXEPDcnss963tSDR5kaxsEhSYoQ9H7sfWsHc43/MZMc9By/BVg5R+J5E8QpUz10MSCQwhDCh2+gP349IZ31waj4J6NXK7a2FejPea4T/brQQv/K2sAkMZ9CY4GyiqFgmZWlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WtKiW10pCs65pljGbPu7tZSahBMTIOkA0Rg4V9GHeU=;
 b=VOGz3MsH54pyn0H85uRfPIdXKYyqvnh7ZGAqYvlYGjnS2QhMkFmKV1h1ORBYnEnd2jpm05MmRW2m/7lMrCeBfFpCtdHtd6P6zgXMxWL+SLO7LFuH23BfyKftMTeW0h4b51T27nCtu4znK7IshZPhXvc/99TSQwlhUFagOEfaOdSj4tS9WJd+w/8+1GISWrw9e6PHO7JqcPrVEJjEdmqkYltW5iYYSg3H75II5sHxwZNfy4fgHgA3G3vr0tft/ISh93HphcF+AuEY38bScQfKF0HYftEBgZOnusnyVOuI5DvmQMIEOPlse/3FiC+4sH6iB46ebq8f9DsSseOa2GOCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 09:22:55 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:22:55 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: RE: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Index: AQHZs93dRsBnvsQ2oE6qwQQo1+9ekK+1guSAgABffbCAAHCDgIABGK8w
Date:   Thu, 13 Jul 2023 09:22:55 +0000
Message-ID: <DM6PR11MB46573D08DCCC3F4280BBB4189B37A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
        <20230711205953.346e883b@kernel.org>
        <DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <20230712092421.7dbc6f50@kernel.org>
In-Reply-To: <20230712092421.7dbc6f50@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM3PR11MB8684:EE_
x-ms-office365-filtering-correlation-id: 0a367dd1-ec80-4410-27dd-08db8382bd8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faoYYhwIIa3BkXiDu6UsEkBjZ54KmeCuFxMMVIa9XDadCMFYoW7wY0nubXXUgPchnFHr2TzCyHK4sZt+hiTrsdtfOo7FY0JeYUminsPK+cnJEZbsj6NcPMLggpvQJ4I6ia15Hrj4ONEl5nfVa2CG2EE4XMLMX2fm/PoznRJ8DsWmhc2ho6mgcwbseeOf4t0Lj6fn1c58DPe2JITQS0MhpU3AN0DmC2GJ9PHlO9usSaWG2AP6Rrggb/fYx9qMihE9m8Nz+cEUEy8JbbpUO89bCJkqgr+6StRQWVaQDB15EMVBSqwuxIJwYn7Xc0ilyRuAS4V+TlVtTJ0VwnVPQsm4TC8xYy7zqhG3hafZwgoatV/Y1si0PwjsYqoRBUNo+qD92ECdxXSMEcxZ5/JE+Km108vtUqtgBkyJhrOOHkGXudrwFdsLHEKkIACvrYvb5ZAmiFjKYuGRxMhnDLCWH+A8mpFi13cGF3hnmHK9PZzRiOmwXrtiJxjHcyLY1Rh9SBIdi1XxhCGG7UuFo0XkqjFOTOA2mKRFalb3Urdz2Cf3cDr3rFsY1/mrmhubA/QgOdV7gyp/9Z9ZBsV8FWf4WMW5u1/HxQ51nST+trTTDVyDLANzNt5lLTnpaqsqzkRhZRka
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(7696005)(54906003)(71200400001)(38070700005)(86362001)(55016003)(4744005)(76116006)(2906002)(33656002)(186003)(26005)(6506007)(9686003)(38100700002)(82960400001)(122000001)(64756008)(66446008)(6916009)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(52536014)(66556008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MCpucdd0NrSLLuYvXkLTRah/6yeFwiDFAT9cp7gCiCjIQo49U08+VPSrJZ8V?=
 =?us-ascii?Q?pXjcKeoZ5zZz9yM+X9H1i9Bk4b+otZC3ZTLptctq6WsF4PdvX8FMYFgleN3T?=
 =?us-ascii?Q?EQTxClYlkTVzYaQ+eDDni8dYCZsGNVdaXHaOtbCp04GnbItpu2tLtD38vW5W?=
 =?us-ascii?Q?O6vmoKnzNHkVnIuIy6Gff2j9mV4P4bvOR2Vj+u+54uqnWp6WDRy5Jm19jTGY?=
 =?us-ascii?Q?62AE7XsOvBmP3X3dsL8XyGemTo40VPv0aaq8ivzO36DYfRvt3EU+5duE3CgF?=
 =?us-ascii?Q?akAi2u3luJzmteaf9h1dJ0irJMFP3wd9amGxtFCtFPtt9dnM1jmL2rcd1zj3?=
 =?us-ascii?Q?tN+pcY4uM04gDbNQTEcLx+6IDJFma1dTBmCt0tew/Sb98daFGSi2YBUUZ1nw?=
 =?us-ascii?Q?d8tVz0WN7TYLH2ZQ8rQnK2xCLKEJMlknt+Cxl7NCgji95hEVBwAs2OhLMrAy?=
 =?us-ascii?Q?bvyY/zOWf/HdsgVhrEO7v8u2nnlLUdT4FOyrODL5M2/CnDUXYs7B3WEx6PES?=
 =?us-ascii?Q?ZttzmziH8BWYz+nk8lfL0uQIQfhlFioUkcP8jKqN0fmsGftpK4yr40McIbDw?=
 =?us-ascii?Q?GELRlxH8JxKjFN5yeKwW5gy4JhsBxEbMq6z3l4MH+gKdH6afOTlDG2voerNg?=
 =?us-ascii?Q?l4Tv9qUN4qLaFBn/ytD53CcyCZowWShFVNDzi7wakabLPiPesEHWUPAKA5ZG?=
 =?us-ascii?Q?1NnfwD3ofSkz9VSprvc9J0zun1sgUIsWYAnufn1V5R+1v3c+Sfl4PI7Lc/k/?=
 =?us-ascii?Q?QVLcVFbPVV5j0nEv2N0k+iL+ZB5iLUqiBRYErz3CYFQqLyLnm/rONQA7jw81?=
 =?us-ascii?Q?/DXRdX6p5bqpDsbxrZrFlomI9fJgbdN3F8lA5NeSzledWdFQtoa3W2ufhmf9?=
 =?us-ascii?Q?yaYdp2Jt4OZyhH3C9YoMMeaa9DeoU8Dh9t12WX0DSsbPWT4DxHxHiADxeO19?=
 =?us-ascii?Q?kFekOQmD4oU5piMzZWnDQQQjFQtpy7aWg54B56zBfMlEHCQcTrL7tR99hI8V?=
 =?us-ascii?Q?dwKe/M0GEJNL6CxbDDvWSBzMj5ccjCwovQUB+y2a+ih3/2BtCu6Y+6zcyrKC?=
 =?us-ascii?Q?eTR4zwTU5DdAYRHDCIbcCtRFT77u57U0fJCrFg3J/q+vDE9R/y7pTxLbNGmM?=
 =?us-ascii?Q?7EkOvux4bFBxmy2ka0kxiGItiU3uw4Dwt5SaTyj0dn72omhSD6dOGBemZr2M?=
 =?us-ascii?Q?QUWE9guqzy3MPFA7G6aGFF0lZd9BuDRm80kS899Sk1zinO57JdBZ0m3Rie4p?=
 =?us-ascii?Q?U/eP6Ju/RnjCcSwpChRfwitCcqVqVsyOsQUFruRvN9j6SSjg/AQYBefZr/LW?=
 =?us-ascii?Q?eMKjrdnfHshhlzwzcfQAh/JNg3xqd7V9t6kF6Ge3jJFeiR2hqpH8gQYyZHrV?=
 =?us-ascii?Q?4LV6vA+8s56b+SnGMi4ib5pTCG3d2aP5CtKqz6pC/LnjQ9PJqCfJbGvpyX4W?=
 =?us-ascii?Q?tcEefezkGvwHI1Nam9IGiKj01asRXiiqhBJvpZvyE7BhmeTVXfkYO1rcQZ8S?=
 =?us-ascii?Q?QvSO5nySVQ75vPG1+qaWSqpOJ54w+9eWespwPVhf/bkb7GS3Ko62tGwXt+vv?=
 =?us-ascii?Q?AUS2liNCpnrYwvDL3DGAm5ezhwlIMpvO1NHNAW4Qf/Bv+htqSkgfmLt7Ifl7?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a367dd1-ec80-4410-27dd-08db8382bd8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 09:22:55.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NE1pJ6GDuZqL14cg7r446Bj7icX4NkHkoKXW+UgWHJd94fhGwMatBdtCM6hHd8zEKNulGvYNqat5Zzsvp9aK0FKuJ0igkv/483BLn98q64U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, July 12, 2023 6:24 PM
>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com;
>chuck.lever@oracle.com
>Subject: Re: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
>attribute
>
>On Wed, 12 Jul 2023 09:47:43 +0000 Kubalewski, Arkadiusz wrote:
>> >+            if 'enum' in attr_spec:
>> >+                decoded =3D self._decode_enum(rsp, attr_spec)
>
>To be clear - this is just a quick mock up, you'll need to change
>the arguments here, obviously. Probably to decoded and attr_spec?

Well I did something that works for me:
("[PATCH net-next 0/2] tools: ynl-gen: fix parse multi-attr enum attribute"=
)

But I am pretty sure it could break the other _decode_enum call
(from _decode_binary(..)), wasn't able to test it yet, as it seems to be us=
ed
only with ovs_flow.yaml spec (binary + struct type attr).

If you could take a look would be great.

Thank you!
Arkadiusz
