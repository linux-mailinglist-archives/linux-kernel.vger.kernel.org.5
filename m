Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E827B3BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjI2VD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2VDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452B1AA;
        Fri, 29 Sep 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696021403; x=1727557403;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QxgCAgKZYbNjX8GmVoveVzIlHfoXHJAysSjEcHSe7A4=;
  b=UuPRvfwphaOuiTsEzSlet74sbZ/gkd1K7rRK7XKaiYKXds0MhDLeWxV2
   NGaNGS0X+kPoIW0UD/Ism5MGwAHG3MLlE6uTkSLPzi3orMFzyv9EHdOhQ
   sqFfzdRowe+9hdhi9dC4cgD8Yunj59q+ykfEhkKzO4IHvWTAReRghCazZ
   wIkPoHikKEUJ/MEF3rN0vv+pjxZDGP1lGx3LUgxKR8++QjK+XOFDi7ExD
   Ta2zgtb6Qpx2CLybJ+0+0gt5r/1MDAhttuQ5LfPzlnTd2PNDbx3BARjFt
   6anE3uWFNkkZw0OvqOvJ5vIvQhwCwxzHrjlq9sUmF0ZoDtXY3pJ1a3c/7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362628965"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="362628965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 14:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="946236"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 14:02:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 14:03:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 14:03:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 14:03:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 14:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhgcx4FHj5YYdWFUgFSt7u02DvO+n35VQW/e7vlhKRFMPSoAY6rHzkCLGpnQ0/64QaCjnGojNiVjZqz6ktecbGwEUNezB4C+J66aVU971gJtWWOW9dxRlbB8Fwm6YVlwCks65HZRadRGbZIL9Ja5o/nszo3vbFlo5gIZ+U1wTHLiU3A35PKzOuy0K3ckqkG68pCb90TD8IHfVsRB+IrPBLssBJGzon3qlNj3xpV24aXfyJk59cmpNwLUgCj7AFN8vdL3ahdG7nERLW7L+eVNs6mL7oDn9OsgKZFTsg/R997XC/RCRY8mBWbfwE3fbLu1Sh77dw8y67X0mjF5dgh52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NskK3ITALXp02OXS+dWckfjWejOTHujWuTh2lQIy97A=;
 b=F7Ah1l9Q1+1bfA/FyhtEyD+ZZARd1VRjsssPRNxgZIxwcFfgg9dXeGobMik8URo0pWtUzJyjPduadyIsuYB88JSulsfE4c4yGCWIVhfqVRb+fAwBkgXjN7Ve0X/mS2hLVhISBA94eDShSayt25wu2qf3LbAMYJbegC6b73X1HW9tCZoEfQJR/U636iXulcSyCSj1jtg/XpFivy7Ym/SDEJINczguvTStEky9SrTOAPWvJnWb/ePSIuZjh7hGTCKoXO071uF/Y1+BZDn2xrnhU0vPtPFFH7ymvVoENKkOtAOlxQ+0VeRjolYZm2lYjDpvLMFDbf+S32KvlOnsQ6i1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 29 Sep
 2023 21:03:19 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 21:03:18 +0000
From:   "Nambiar, Amritha" <amritha.nambiar@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
Thread-Topic: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
Thread-Index: AQHZ7UXRTuzFhM3Ou0WIIpP64QpTnLAyVdpA
Date:   Fri, 29 Sep 2023 21:03:18 +0000
Message-ID: <IA1PR11MB7869A9AC9C424E4C8E149210F1C0A@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
In-Reply-To: <20230922111247.497-1-ansuelsmth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|PH0PR11MB7168:EE_
x-ms-office365-filtering-correlation-id: c26e90b8-f55e-4889-733e-08dbc12f81a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3h9lNE9IC/r2tqjRHROCw9gBxh6qZ+/YK60y9iJBbsPe4SxnalsxP99rhANRx5E0RKmrLV5uXn4M+FFGgrOSl3f5hNRxofziq1c6ddUiimm0l57wAVRDIDHFN0PqUtecOwXa29vlGc5DKCF5oH3vSh5rKVOxZt6SIjMmVgWTsNGNWDHOYpDUOzhQ0daOzSVLse/iTWPDbDVc9aefMjcylNpRrq1JNbCj0c2Ylgm5eUrDyW9A3rMivVdGSaVWX8SFqovHE2GWNCVNQ+6MSiBb6Y4+pid1gTgml8N4o0umwf5VawyT8BprWgFVH6D0Z34wuzaepHQj6HztJHR2Px1r5RA5iVFtfhMtzmyZ1LCUBGUJ89zXfHw1pijciM08S7yMCWCWLaWsiEAQZLlf72toHd1+O1CtlsdEiC5q6y5XvSsFLafApCWhgqSn119q6+oYEDygqZatwoLb4ww1jvfC1YVWUM1/o3J79/zj3fzAAOMJUupEHsaWc4WieOFj511eSlO3js81G04qp6v0Yyvbx50FdZhmPPhTVJUOL77nQd7HbgdWKpuHDiorf57MjT6bQXABwqApI5OOToffKMANPwXhzdlpS9HBQSwC+s1Dqj2HDj4i3TNzhM8AktZyEC41BBL7FCHTAeBpIYYEguQvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(55016003)(86362001)(122000001)(82960400001)(7416002)(2906002)(9686003)(921005)(5660300002)(33656002)(26005)(71200400001)(52536014)(38100700002)(38070700005)(316002)(66556008)(64756008)(66446008)(6506007)(53546011)(66946007)(41300700001)(7696005)(76116006)(66476007)(110136005)(83380400001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bbk63B+PYyyDtSpKFfss8/uDa6GSMf2b51GWuJgIQbg1nKKHptx3VKgoMbbH?=
 =?us-ascii?Q?VDlwID5OwY8SwhwwodW6cxO5onwOu63hXngAgSmySWDj8znVLjPKO+y/NK4S?=
 =?us-ascii?Q?lE3LJk7sAx4XZKU2QUscWaJfuApBCPOBWL1+c+99gArRUSxisBCGxL9XRKn/?=
 =?us-ascii?Q?mF/o0/M6G3OTbmj7i/Wgx/aoeAYbxO8N6wEvB5hqmAx0c7EgLQiSORdkjIV2?=
 =?us-ascii?Q?/AsETyf+w+hc2Z6c+CrMfom/zcW6jYLbDvyaq2xPSL5AeJ74DduABXlHTzmK?=
 =?us-ascii?Q?rU01baHKXIUK9JTNNfJygN2NMqLiMNOGUH59buuqhwyYsQJr8g5lG39DVa43?=
 =?us-ascii?Q?ysQKuIcwHWXFjuBpN7utu/fP+bH+dD9HbTgcDPU3rsGx54WcvT7ZermUXnAp?=
 =?us-ascii?Q?wXHMYLLqxvL/iz0rr4sG3IukN8zIugpPFnOU+vmZyFFwK48L0yXjDCz2R+Ip?=
 =?us-ascii?Q?2kRekWSJmzjUotIlhFFaySG3OSwrNhh91G9wBDpLggMw1ddkw3EcmYl/2dda?=
 =?us-ascii?Q?sawBDJmcytd6ntcDfp/bpZmR5baCpgJTseteJs+HPAhA81glC/eVUXKt4wVX?=
 =?us-ascii?Q?tvgEoW8q/Vt0P6ooxNPdHfmkU+KcWBNrv/Z9MVNl/1xZraD7A2OkQpN4mZ6s?=
 =?us-ascii?Q?rJQaD7mUkGTe2gk/XfLtcOom3qwEX9S/MS1sHmbUsdQXWjwwIfUDfqfIRcey?=
 =?us-ascii?Q?2rUxYRP8/3wxnhCCF+2G6i1KdB3D0f2PdFQEKfLsRkBBfK31kp1ITL24cyO+?=
 =?us-ascii?Q?mODlNiOQ8x8kmbLaTBaJhZcBxKd2Devkht3LyIBVKz3zu7JkJdLAFQ37DV39?=
 =?us-ascii?Q?jECsyLxPv/IUgu9NPMowTNTqwuFjwHcreKMIje0XJDTOH/1JrP7PtHvYafzF?=
 =?us-ascii?Q?IlB6CAN51lvboBh40ZOlAAz/UFtszqek2x3mDcY3mFhr/Bzq6qJ+Y8mUBY5D?=
 =?us-ascii?Q?resVpWtNCeyPkJ50DSSSLCZGVElapNBjv2geM/+yRQQ2GZD1GL3SC5UpABcd?=
 =?us-ascii?Q?keLq2wWrWFcpYZw8hp9eIGMb4yzzQpUinu3lJY2Bgqk/nsF5MvQTotveEEl1?=
 =?us-ascii?Q?DklLaFlQiiSQU4swT4BRuA9voFZ+JLZEBJjgZEx1MKShiGCi9nQ59raqDqPV?=
 =?us-ascii?Q?twaBT6hguIhMZoHFJNCwrH4KAOBBDjOwzusON9D8XUNBBMvafKykBlgdocxW?=
 =?us-ascii?Q?/viGiNAetv4iJXPXf+itrFs5fHB51klZr+Msgjq1TAHgDrvVQ9/CyV3D40Ve?=
 =?us-ascii?Q?IPwWycbujpyhIFVZvxPPqnqb9mCs0grqnw9LUrFk1JfmHp+lDkJs7Z68m6ic?=
 =?us-ascii?Q?LcsVN0aLx618DWk5YGMVaKr+ExkwTDKUjyDgs3kBezlmPacmD4fTKV59QMGH?=
 =?us-ascii?Q?bZCn7ivN5eqO2IWiBr3xj2by6SfS4HX9iDS3R8qsfCFRiUIip6zaSwPHoY9r?=
 =?us-ascii?Q?y4UKfSepATq916B8eaUCapM1yoL3Ah4fQLVS5HxnDYs045t1Oy9BG8RIDZda?=
 =?us-ascii?Q?t2BtjwefvOcUC7whIq99J1uE85p1uXCoCOXnUa/W2IcteHm4JBOEFFK4is5W?=
 =?us-ascii?Q?hzpqUHZabg408qJa8BEDqYxaddOzNeD8HAavnwkv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26e90b8-f55e-4889-733e-08dbc12f81a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 21:03:18.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKwIohLhXDlB1gsEC7mq6r/ctadQkP9cKbvR1gRfMjrzmeTMj1ZdccQ8EC93uBUYsmdlE7Qg5kR12dEM9ZhOdRZPLlNML4G8X579KWsXptM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
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
> From: Christian Marangi <ansuelsmth@gmail.com>
> Sent: Friday, September 22, 2023 4:13 AM
> To: Vincent Whitchurch <vincent.whitchurch@axis.com>; Raju Rangoju
> <rajur@chelsio.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
> Jose Abreu <joabreu@synopsys.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>; Kalle
> Valo <kvalo@kernel.org>; Simon Horman <horms@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jiri Pirko <jiri@resnulli.us>; Hangbin L=
iu
> <liuhangbin@gmail.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-wireless@vger.kernel.org
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Subject: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
>=20
> We currently have napi_if_scheduled_mark_missed that can be used to
> check if napi is scheduled but that does more thing than simply checking
> it and return a bool. Some driver already implement custom function to
> check if napi is scheduled.
>=20
> Drop these custom function and introduce napi_is_scheduled that simply
> check if napi is scheduled atomically.
>=20
> Update any driver and code that implement a similar check and instead
> use this new helper.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Looks good to me.
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

> ---
>  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
>  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
>  include/linux/netdevice.h                 | 5 +++++
>  net/core/dev.c                            | 2 +-
>  4 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> index 2e9a74fe0970..71fa2dc19034 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *nap=
i,
> int budget)
>  	return work_done;
>  }
>=20
> -/*
> - * Returns true if the device is already scheduled for polling.
> - */
> -static inline int napi_is_scheduled(struct napi_struct *napi)
> -{
> -	return test_bit(NAPI_STATE_SCHED, &napi->state);
> -}
> -
>  /**
>   *	process_pure_responses - process pure responses from a response
> queue
>   *	@adap: the adapter
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 133bf289bacb..bbf4ea3639d4 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct
> rtw89_dev *rtwdev,
>  	struct napi_struct *napi =3D &rtwdev->napi;
>=20
>  	/* In low power mode, napi isn't scheduled. Receive it to netif. */
> -	if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> +	if (unlikely(!napi_is_scheduled(napi)))
>  		napi =3D NULL;
>=20
>  	rtw89_core_hw_to_sband_rate(rx_status);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db3d8429d50d..8eac00cd3b92 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct
> napi_struct *n)
>  	return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
>  }
>=20
> +static inline bool napi_is_scheduled(struct napi_struct *n)
> +{
> +	return test_bit(NAPI_STATE_SCHED, &n->state);
> +}
> +
>  bool napi_schedule_prep(struct napi_struct *n);
>=20
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cc03a5758d2d..32ba8002f65a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6523,7 +6523,7 @@ static int __napi_poll(struct napi_struct *n, bool
> *repoll)
>  	 * accidentally calling ->poll() when NAPI is not scheduled.
>  	 */
>  	work =3D 0;
> -	if (test_bit(NAPI_STATE_SCHED, &n->state)) {
> +	if (napi_is_scheduled(n)) {
>  		work =3D n->poll(n, weight);
>  		trace_napi_poll(n, work, weight);
>  	}
> --
> 2.40.1
>=20

