Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0177D3628
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjJWMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJWMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:13:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF46E9;
        Mon, 23 Oct 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698063227; x=1729599227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhdyNRi++Fb5ZkKjr1AeYS/qk2rv6dn64tu9Dpe71gs=;
  b=BTkhEucrregyJYBUo5EOk593Y7yJ6b39cxl7ts5EGnmKy8tHpJhA3wgY
   DMHQy4D+dye0LOf/tGdLnbmt09520RoUhaA2iZyLmMXjwHD0tMEMWtGx1
   y46QQhOw890GvHt2cneEla3ptTIFEGm9MeXAl2t/e0Uz9jIlfb6LyHeVg
   mPKJm20sOHNgjYsj2Rnwg1uv4tvLVKQHGVguXn80wX+7NCcwzFAniCka1
   e4yKUyVgxPsOaeX7ZirT+eS8/AtaZWaBlnHEnnKhUU6T2QXOITV53rSqw
   wbv3R4vj11KxChGSPnlEsQr2BLVQzw5p52tNYY2SnkfJJHrLWQ+saDqn7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366173222"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366173222"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5786363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 05:12:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 05:13:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 05:13:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 05:13:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 05:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtc3PgTFzyslu38wEz+8n/0SsCAQxmGzNmf4lTwy6q6ficaht7GG2pzDB8iqiLd1gGwiH/JHvI6DpPZhWUkeljZmc47knD0VsHEMjqVZCjCDZD5EqwJJH4gGBLQ0x05Eqp8jWG4Ua66fTUc/QqkkKupypq7KnbI5NreE2NZFvEOef3IVj5dYhvdWKQi2cAKddzYfvOYeSyhJNByukexy9If15zXlDLDbeDhoSxIbgOyHIt3r4mAH4W+ziIGPp+h+Mm1wXqCJeKkPdFdYur+c1Mt5XwUOgBbmBRaA2IIWkY0FoYET+/GvxCBTnXMH1g+c0i6K/8FZQTt9eL8VJ+KLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzb0AVl6IQ2kcHaWt72BcbRbDV3PtjGA5ZAR6JARsHs=;
 b=Q3VbY6gVOyXRfwmIk5ycFbcaAOVWy+HIybKFdyKqaIxD/WXtG1B9T7iAjskf6ZZ5XmMFIRYv7jerPUHyEv1REZYQ31lmgleUKRZuRC6ACADye01yJ2GbUwDM93rcwljFNpqD/i9qemXFzrkqgpy9hFnL3cLl5y63BW2wdaWNgc6WHJvibi416oeLnk8aC0KUHFpFS1JTOoKzpn8RIZ/bRubDwNqRa2lDULi5goNkv4BM06QhwDHTWAfX4m9PmLJzIX7ynzwyT4HKPrcjqxwVPo4bIDriDxdCrRGNf8nV2lBsLQQIuOPMAHvn7TaT/n8LcywbAYqElkRbXAqixRpvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 12:13:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 12:13:42 +0000
From:   "Drewek, Wojciech" <wojciech.drewek@intel.com>
To:     Shinas Rasheed <srasheed@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hgani@marvell.com" <hgani@marvell.com>,
        "vimleshk@marvell.com" <vimleshk@marvell.com>,
        "Gallen, Erwan" <egallen@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
Thread-Topic: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
Thread-Index: AQHaBaZ1ZUHfo9uwG02p7XdCLNoTULBXRlyA
Date:   Mon, 23 Oct 2023 12:13:42 +0000
Message-ID: <MW4PR11MB57766788EBB4D99302002A7FFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
 <20231023114449.2362147-3-srasheed@marvell.com>
In-Reply-To: <20231023114449.2362147-3-srasheed@marvell.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|SJ0PR11MB5813:EE_
x-ms-office365-filtering-correlation-id: aab151da-4c23-444a-d70b-08dbd3c17f92
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiCU+SmPqQ+1vPRzwD7viYFOc/olWwsRnO8MCNzRJ4I+/Xx5Wj922lUn56X1y8uxoyQOL6rNO19lObNYkbwOPAfCzU9jfgnW9rqgphxswvaQKxff0aqPdOnFMOKhdRFoDUA2hNKZbJF79x8Hz48AHV0ikbuRBhCZJlOSMIFgw9k2ExgEyqbFaLHXEkzn7Rwo0jB8CQlWvMkCccGPPw8qq1Rtao8n0HRl9YcLPc+j+xidD6gH6yv48bwypmhnW/OKmAPTzR8Znhns6xkkznWKDLqIQNtJg5dBw5Elh0gW2FGACo8Y/r6FebWvU5lC2+aXWJAwHX4iDt7xxfrnHF4d/wK3RFQlaXeWwlzuJkoOTNjSRS9dz1F4ve+aKBu7plm89HHvE/xR5UTdypEOPhn8//jKRvK3SwqyJaBAB+esuAS7S5qHbLesuXC0aYzeKya+OZqKjo9ZQqpC16pHcuiNK5nf47+O0LHzKU3U01wjPH8vnhFjCVoTpUGi4JB+q6WW2dFOi/O1agwlvlW6qaVd4thz4S1fUvvQRMRS309U26wwW+L3aVsGNvOZdvcIAjdncoWhhQT+4z8bqc1zMbAg5akNSjhZ8ZGfvq4DzJWwN/pgI27IePfn8UU2ZbXxtzgt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(83380400001)(5660300002)(110136005)(76116006)(316002)(66946007)(66476007)(64756008)(54906003)(66556008)(122000001)(478600001)(82960400001)(66446008)(86362001)(33656002)(8936002)(7416002)(4326008)(41300700001)(71200400001)(52536014)(38100700002)(6506007)(53546011)(9686003)(7696005)(2906002)(8676002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QwOJ6aDNUv/BwC0OdUwKeCR4paZ8hpw4zCwkGWcGVvJRTC9dedu8fTgfXevP?=
 =?us-ascii?Q?YEbo4ADqxeW1jjP3gHEiE3jj9pK6eKeunu7dgRkYU5fqJTMerNDQOnfsGa6j?=
 =?us-ascii?Q?vV1IVzyz9nb35jPaVnz8TNlbzurCbURGvvNdEyMyEzvo+dZ2MId9bB1EuIjo?=
 =?us-ascii?Q?QeJKjCGel0TvUziMhtP+xbikHI1g/L+vGRcDSL/e09UtdwyHZ8CA0/SpBS1t?=
 =?us-ascii?Q?O2lsR4SwyiZpUlJBcKLVPq6o7uf27B8fvUGq6FoHxiA/qS5yBpLq3jjrTq3J?=
 =?us-ascii?Q?1svdKWoOmvIUNJ+7oxGH15JZeA/No6ro4/mEceUEFhViFz6jASK5sOzPQChg?=
 =?us-ascii?Q?EDkkG3EsX9TNKdne/fv58IWQd+YT8qTMpPtlt6DzO48LJDdYDozznq9PjltH?=
 =?us-ascii?Q?JxhEFJfZsYNs0ms6j5K1Q7ncdGCrzKToYPtWzAqxy0WRIxkKFvX7XJX/v4fU?=
 =?us-ascii?Q?fbKg+oOVSiMazq8kPoulOVKu8aRTf3eEaxI0xELRnyrbgcJN117f1vG38M+y?=
 =?us-ascii?Q?GqRM5tghXdg5EoTZUN6j0k+6Aszs0Dg/M67S9CGM1rITdiYRbQyYDcgKpQ+y?=
 =?us-ascii?Q?yZd93ZU18fbkpQdtGzRXadkROJHm7LceLm11/fOJax4pV+kBhvn81vlePG5c?=
 =?us-ascii?Q?+6kpErVj/5LBVoqyrc0JoRJ26K8kDZboC3tIhtWofjUq/zmCxQ81F4jVOY+2?=
 =?us-ascii?Q?s99WmM8dCveD7jCBXcIrdkzvlejzmQ4v+4yWJMtUvI0N9/7Mta5H/n8bL9zU?=
 =?us-ascii?Q?iR2pFRreUaRl0HKspimwwP2dY5VXlc9b2zCejXI60S7H01Qug73BNfnpIcMP?=
 =?us-ascii?Q?U7qk9U+kz8mlIChqTFBraKUjEa/osmUl0GMxi3GKxCZGv3wkcEAgB90LWiPW?=
 =?us-ascii?Q?fQ9IpMXKo7N/Xswc7MQ61SX7pp4nuJnyFOKmmnHJoS7dfe/D1Wt5wY0lFp7U?=
 =?us-ascii?Q?c2OcshKWaTpIa1dd1JtHWO1sGCugsbB39EJzogPp65KA5QHw4cOqGhr4+PbM?=
 =?us-ascii?Q?ZA5Dnng74r9o34vaoYjhqAhkJkumvq4CrkFup1m09CvGZHCEIV6juzAhra3r?=
 =?us-ascii?Q?pBM6wiC650uXatAOHmVOlFGzO77quAkA1hofSAMt1gvbyssypnGKBWUuWywY?=
 =?us-ascii?Q?ow9SNX7F52eAoq3EjCHUNXypNInRn0yTkV7lzvudk4m/8SOxZdRC6jdCcGoF?=
 =?us-ascii?Q?npM8Kc8exCX5aUh/5My61oonNDqbRLVIx5iHcq7GUOuHT0EnJzyFZpH9fp6X?=
 =?us-ascii?Q?8VvnQbI/WjrKgwu8KLMlhHxNOwaoj5Fu0AeWR4R8iaDX9TTLz/lJXqsXQ0mi?=
 =?us-ascii?Q?GX3pUoEOMVDiI9BkJ4vQb+UBr7qBrjSxqYWX2v7fi4Bp0rwMQ97obGuNtp/F?=
 =?us-ascii?Q?14XY2e6Hdlt48UAWwz8u1ZpR/PpCRbaBYfnP3Z9ItP94ixN9k77IVRUG01kH?=
 =?us-ascii?Q?3usN8xWiyoc6DfovOrbDJknhfufSEFeJ42t+qm35m8E+xYE7o/az3wtZPsjH?=
 =?us-ascii?Q?ee9VWazxmPoilrp/0HBCSCWXAg0sng02tXjOwJfCRT/SD16Sv/DI13h6Iqkp?=
 =?us-ascii?Q?BHeStA2Wc8a//OakXmCq/SCfbVYPImpD9YkFMH9U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab151da-4c23-444a-d70b-08dbd3c17f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 12:13:42.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lA1w9Lqxa1F+dSks0E40eeOHFePTRkYw7iKFI6WMWObZ4a45GFKR7daqu4B/xHtUEWUVbS4RPIB6LYky+6rcDxifcyuGiPKut4/e2ngO7X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shinas Rasheed <srasheed@marvell.com>
> Sent: Monday, October 23, 2023 1:45 PM
> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: hgani@marvell.com; vimleshk@marvell.com; Gallen, Erwan <egallen@redha=
t.com>; mschmidt <mschmidt@redhat.com>;
> pabeni@redhat.com; horms@kernel.org; kuba@kernel.org; davem@davemloft.net=
; Shinas Rasheed <srasheed@marvell.com>;
> Veerasenareddy Burru <vburru@marvell.com>; Sathesh Edara <sedara@marvell.=
com>; Eric Dumazet <edumazet@google.com>
> Subject: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
>=20
> Adds xmit_more handling in tx datapath for octeon_ep pf.

Imperative mode is preferred :)
Besides that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>=20
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../ethernet/marvell/octeon_ep/octep_config.h |  2 +-
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 19 +++++++++++++++----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/driv=
ers/net/ethernet/marvell/octeon_ep/octep_config.h
> index 1622a6ebf036..ed8b1ace56b9 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
> @@ -15,7 +15,7 @@
>  /* Tx Queue: maximum descriptors per ring */
>  #define OCTEP_IQ_MAX_DESCRIPTORS    1024
>  /* Minimum input (Tx) requests to be enqueued to ring doorbell */
> -#define OCTEP_DB_MIN                1
> +#define OCTEP_DB_MIN                8
>  /* Packet threshold for Tx queue interrupt */
>  #define OCTEP_IQ_INTR_THRESHOLD     0x0
>=20
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index bf1e376a4232..730443ba2f5b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -818,6 +818,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *s=
kb,
>  	struct octep_iq *iq;
>  	skb_frag_t *frag;
>  	u16 nr_frags, si;
> +	int xmit_more;
>  	u16 q_no, wi;
>=20
>  	q_no =3D skb_get_queue_mapping(skb);
> @@ -892,18 +893,28 @@ static netdev_tx_t octep_start_xmit(struct sk_buff =
*skb,
>  	}
>=20
>  	netdev_tx_sent_queue(iq->netdev_q, skb->len);
> +
> +	xmit_more =3D netdev_xmit_more();
> +
>  	skb_tx_timestamp(skb);
>  	atomic_inc(&iq->instr_pending);
> +	iq->fill_cnt++;
>  	wi++;
>  	if (wi =3D=3D iq->max_count)
>  		wi =3D 0;
>  	iq->host_write_index =3D wi;
> +	if (xmit_more &&
> +	    (atomic_read(&iq->instr_pending) <
> +	     (iq->max_count - OCTEP_WAKE_QUEUE_THRESHOLD)) &&
> +	    iq->fill_cnt < iq->fill_threshold)
> +		return NETDEV_TX_OK;
> +
>  	/* Flush the hw descriptor before writing to doorbell */
>  	wmb();
> -
> -	/* Ring Doorbell to notify the NIC there is a new packet */
> -	writel(1, iq->doorbell_reg);
> -	iq->stats.instr_posted++;
> +	/* Ring Doorbell to notify the NIC of new packets */
> +	writel(iq->fill_cnt, iq->doorbell_reg);
> +	iq->stats.instr_posted +=3D iq->fill_cnt;
> +	iq->fill_cnt =3D 0;
>  	return NETDEV_TX_OK;
>=20
>  dma_map_sg_err:
> --
> 2.25.1
>=20

