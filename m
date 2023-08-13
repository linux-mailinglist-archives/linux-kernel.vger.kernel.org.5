Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C577A6D4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHMOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:18:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC310FC;
        Sun, 13 Aug 2023 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691936312; x=1723472312;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vaY0h3XyjILUoFc0gEPKPcVu7f2rYwwaHrLpd3OZXXA=;
  b=VyOuRLE05V9MWHmpsZjAqBQwaOZAZkCCarXemD1AOI3YULR0eUSgWLlQ
   9Z57AuFFuWyOSi99qQcfFSkh+9lMQEWcemsMwMSQr7EpYYy5p49Tj96mZ
   Sr/RVLsXKssEw0E1UhFHSnbFex1OyeNJT5T8IdNk/d5oMZA6bYE9uqazi
   1+4SBNm6Th++FGG6DMLcqZ7oOmmtTfb4OjunS89nHLoQl4E8Y+TorRFiK
   6HWt94nCY5Nrqtkxw6T6zDE4nACTf4w2v/7XHb5MLjR3dx5Hg87yrdY8Q
   0hkZTq4l5Ik8FHpttwjdRvD7sOldIeQFEDtwowWYoHgq+s56piTCdQbT2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="374663746"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="374663746"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 07:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847332846"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="847332846"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 07:18:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 07:18:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 07:18:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 07:18:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 07:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqT7EtZ6mUrb15Dwyfntwhsqc/wYGbHMHA4BVRECauqXyeRLWOef2FcYyqz0B1LgXiY86EeLBjXXJLgigJMgBI5NI+m1BW4yu5lltqVmcN8R9gOtnxvKngv6/B+tFCBAWN/cRq8qQ44G7CNsnO/jomWpDZYd3hePsx0pXi/+jSccvYu+r4sKGCiWwVMWAYjg9NQE9681VqR7o8mD1tt9rcxZv5v0KZsN4wUtPA/sKNtemzBe7d5Nxkq6+vlsWKzpw7StSVCNCckAlyNceOLClJuu+1biD8f4TamPf0LLgGjwUBx6l+SfQGJGnZc/2RCIFVLB5bZ0kPbMjdL+vHpKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHNc4WT05Tyr68XHRxFS77w9+irKaS3Tiea8lIm3Cqk=;
 b=CTaeFeEmu3Q+wafJg9s6RlT3yuczUpiTqFk3Dx8+GYModFCKKAkHI9qXfmOoccLpDea/eVgnapU0RbFHjLLFA3LQ++4aAwiXwH7F6/P/ojzq/8vQPy8vkcIqXeVQ2p7dCeYzXr3wH9DQCRohLJ3mCYANzwOHqTekhlJ84IQwOAmXKsMPJnwc3uZHwQ50z2aWyoh3JqW+0EtTNxZ90VXsTQVPo6NMJT4vEgykk44CJlxLCgo9AklGTkc6vrPLyb2wkPUj7hAjAuief2Qb2P6fMopTt/ty3HR/8LvUbZV6P9/kucPAdwsZfloAOad+CZBW3WqVJVY6J8frHWkqAKy/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) by
 CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Sun, 13 Aug 2023 14:18:28 +0000
Received: from DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9]) by DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::b393:daa3:e9cb:58d9%7]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 14:18:28 +0000
From:   "G Thomas, Rohan" <rohan.g.thomas@intel.com>
To:     "jszhang@kernel.org" <jszhang@kernel.org>
CC:     "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v3 03/10] net: stmmac: mdio: enlarge the max
 XGMAC C22 ADDR to 31
Thread-Topic: Re: [PATCH net-next v3 03/10] net: stmmac: mdio: enlarge the max
 XGMAC C22 ADDR to 31
Thread-Index: AdnN64iTNewURgUoSuyDlZj1njalFw==
Date:   Sun, 13 Aug 2023 14:18:27 +0000
Message-ID: <DM3PR11MB871491A357B9A12BF1B0CC82DE16A@DM3PR11MB8714.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8714:EE_|CY8PR11MB7171:EE_
x-ms-office365-filtering-correlation-id: 090729dc-b9ea-43de-2571-08db9c0829eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfStwQbltdlwz2SAUWUD/gY/hlB/z66LoJZ4vlekB8C0hGjvYTWJfTIYImx16O1t12OZdQn/0kekJvRdP7il6Rk233JW+TKIfWC/QCF2PCDQ4qbv6umh9XGgExMD85RrZq4iUvGy01qJ6nF8kBq7gF31yV0rnilNmRyI/t6VIAHDEneRkHFs0nuDZIFvvVD3giH3NR8dh6DN+LpR4kVNZ0SeeNxkOrwuq31nIYrjtbh3HOL9SATqZ6MEk9O9Mg5ty6A7lZKzvNOUhL9WeT75mdMWwKJ6wkvrk+y5ncc+3deJdha5gHDlm8QzFe3L8oayKCEmP5tWeTRMW/KaKBBThycjxuvAr4Q1Sf5ws8H3gqXlv/mIjf3nqVBupl7b3HiBA54qZYuKb8Nw/1jOd3G2IcvDHUZgThHgEEbfOmqi0xOcMjcqA0igvZO7y13T2dTHQNA7ozKL9hsI1wtQb+JKE/futxMV6iCupy6fXnT1H7iC2LGhJllpAIQ36QRuvlwskZt7SDxZTh92UqLyhRuGGzv/5J/aIUh/g+D3q9EA7pUlS2pDQx+0NsZK+r2AbiSmV0PRgqwNVX+eAB5yL/5wNTy3SCIJZgZHBoU4e8fyp1iD5WZpDeligNlAUMJ6mhTQytJh1s5vhoX6gkDCPjayKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(366004)(346002)(186006)(451199021)(1800799006)(66946007)(66556008)(64756008)(66446008)(66476007)(6916009)(76116006)(316002)(41300700001)(54906003)(8936002)(8676002)(52536014)(5660300002)(478600001)(71200400001)(7416002)(2906002)(53546011)(6506007)(9686003)(83380400001)(26005)(7696005)(4326008)(82960400001)(55016003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(147533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbzEWJQQbUoCAsPHEIpBPZriIQFOJHwwflswVQog5SJIPM52NOvy3Qbt9YNV?=
 =?us-ascii?Q?q499XE7HLIbNlx0XuZBNkaJjc3Q25Ia+SDnphCuvlGRqRN5aLHOH1EPqmhA4?=
 =?us-ascii?Q?bo9Khwl6Wnv5sm5rlLDNRHr8pbtRm3Olo36qpxB4pIsKOCHYyJG6xoyXwxMs?=
 =?us-ascii?Q?9h0QnUWyyOJQXZ0YM4U+Ic3fl3LehPf9FtjwRHrZSiiHrrta6orNjtt7P3Eu?=
 =?us-ascii?Q?5EWBpH9BlCE0/eb6BjtKxrOzpfZ4cxb5ngr7XEdNvEcnUpSDj7n5E0lujxlB?=
 =?us-ascii?Q?h8Abt226HIYvmcPL1TwGOuD0BRxx54BMaNwCvIO9zedKFgGYY5e7rllDdiAo?=
 =?us-ascii?Q?bsDstZs1RQg02Z1T5m3+kqGptlZAIPF6DyivVUHV7L8+tlX+velGJ7MLxRz7?=
 =?us-ascii?Q?Ob/AlseYxcbrLI0gvCWhP3s6SjY7ZHpQ7RxYbsmkUxy4hTMNsAQ5ZhAbg+VO?=
 =?us-ascii?Q?38DKr6KHVS+EatduprsveJWPArNQYdmeSdtyGsONKq9TjK/6gFuojMmlELEM?=
 =?us-ascii?Q?zU7PzRdWACzeqCs5vfGZUTXxv3tN1JXW5S0GPORlMUWbKU+xZhUiXdgpexpO?=
 =?us-ascii?Q?qeAZOL7lzj3P2arF97SBEFm9JX1KSPKBVv+jrJ6sA4skwOMa6UBjB5aZX5PW?=
 =?us-ascii?Q?gm0qSj/Tcm0F538sEpq7TIlLq/W21wXm/pAV5jNN/2ZomkYD0B+GSQUGB9++?=
 =?us-ascii?Q?xMwOgVei1V9aliw2aBUICkt3l5YxfjMgTeBhIpbud/t8i7yXADhQeSWRIV+i?=
 =?us-ascii?Q?I9tjWzs+8EkJ6ybEHCS0+ppkJZKvQ/HinYY4s3AQnqCghhcgbudVJoFPDr7q?=
 =?us-ascii?Q?ff/bBK+ZPyJiyP7foUSzycIhm6yNl+HpNwrUjuFleZY7E3JRhxp3ep5rtzm5?=
 =?us-ascii?Q?5lyUJHDzdURKpAkEWmtZw7a2iOsIS65I4gXFc/5Vj+r3K2GoqMmPUgD7IK37?=
 =?us-ascii?Q?CMqhnLrElVQi3DNxNUAFkWiL0yu6qJz3TULpKLdFLmuiV8sTKmTeb/Xge6rA?=
 =?us-ascii?Q?feitfmlipPIZy+z6uXhyblIHnq/RH6SHSx+JUosxjwjB6WCRuA713RbAlVP8?=
 =?us-ascii?Q?16sLEpeJv/Ln4ye4LATl44VYmwXqk+tT+C4Y3TkMwtj/bA3GTh2phbpDe0GV?=
 =?us-ascii?Q?Cd9q4o7rqHOPfJ0tWpHRCXHDKzto60mYz3+x+L0hTPG3jcokRp+QW/E+eUpY?=
 =?us-ascii?Q?sNYZWstkugYsT7gQNbF2rH0EghlEURM4oODLulNY+z+9dOL/bw39D6ffn7z2?=
 =?us-ascii?Q?BDlY/Ndmzzm5Sa67aKc3So+XxRMYRk48Kr2i1sg0Wa1CepATOWinSoRu2QOC?=
 =?us-ascii?Q?AXVESlcrrW2x3jkPD+C9fB2xtoZ6n5JqCNKr1IW9qvNU9FU1t1EB2Se70nVf?=
 =?us-ascii?Q?sed1Xt1aS7iICmnmmoNvoDWFyP9L6J2IPEl1dGOUru/KLTjw+1hs9cw1X9DO?=
 =?us-ascii?Q?gzgBR9p6Tgs/mJbQdopI8s2Uc+VXQX9vDb7uJmbtocTzRP6Nu20XrtZIkntr?=
 =?us-ascii?Q?uLajo0UFmGadfn2vImkHLbg1vaJdNZz1N5NV8PUuzBds9R1XU68J75i1pMAw?=
 =?us-ascii?Q?rKiVntObqY0xPhMTKcK9E/N8PLV0WA/b81/+JraB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090729dc-b9ea-43de-2571-08db9c0829eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 14:18:27.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zz0FiPSy3zx1j7ehIrxH4keH4iM4UiZQtrgB2Y+/e538zTzoDLg57LCehLrI1bC/P7WCuIm9tKSS5jTH1jh79A5Q1VFvQUn5nZHEeWSuJLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/23 18:50, Jisheng Zhang wrote:
> The IP can support up to 31 xgmac c22 addresses now.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 3db1cb0fd160..e6d8e34fafef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -40,7 +40,7 @@
>   #define MII_XGMAC_WRITE			(1 << MII_XGMAC_CMD_SHIFT)
>   #define MII_XGMAC_READ			(3 << MII_XGMAC_CMD_SHIFT)
>   #define MII_XGMAC_BUSY			BIT(22)
> -#define MII_XGMAC_MAX_C22ADDR		3
> +#define MII_XGMAC_MAX_C22ADDR		31
>   #define MII_XGMAC_C22P_MASK		GENMASK(MII_XGMAC_MAX_C22ADDR, 0)
>   #define MII_XGMAC_PA_SHIFT		16
>   #define MII_XGMAC_DA_SHIFT		21

Recent commit 10857e677905 ("net: stmmac: XGMAC support for mdio C22
addr > 3") already addressed this in a different way. As per Synopsis
IP team until version 2.2, XGMAC supports only MDIO devices 0 - 3. An
XGMAC IP version check is newly added for the same reason. I think this
covers your commit also. Please have a look and if so you can drop this
commit.

BR,
Rohan

