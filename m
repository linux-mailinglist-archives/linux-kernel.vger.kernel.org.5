Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D337BA5EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbjJEQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjJEQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3BB3D1B;
        Thu,  5 Oct 2023 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696516121; x=1728052121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Er89vX52G/zC+elLCVKrqj5b6xTnFrf3UQkARHVQqFc=;
  b=lybtdu9n8N2o5VJJJC67En7T7O46XycxR3lw0N8UA6krUnm/tw61rxXu
   DinUqbN3V5z5YILYt0pPcuKqmDWdhw1pqWPGkDF3YbwMZcapEhbKm08im
   deukP2SOmRHxyQEXR6d41InMUh8LDTZEGG5GPzeOHW+iP/ZhStZS150rT
   MEfR434te2vFT131ciufmErTyJFzBSLrBxoy3pVnw0u5233W7feSSTREO
   +ji8w585TWJ3yANEa9w2lU7N2Nw+BpS2AexSCM7h85zzUIr6Qt4oTFNGP
   vJrZ5i7bbgm0pEzmnIYCL/IfZIslDxWCuygSwb54B/ZtUUT6lJ3wKczHp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449934788"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="449934788"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="1082924472"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="1082924472"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 01:22:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:22:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:22:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 01:22:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 01:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaCVHJcTHkpuGUx/juS/wMbkqclQdYEJ3Ke5vrRvu52mYeWPJ3JZY2damSH3w/ekGGU/FLvR5ZOyPsYsux7oHfBkqRmqOiT+s92qvn3pU/05B+AYgHE1ydVyemokENrx7Ql+gdZKvZdJMcX+17aaFgKofT1KvjetWvk4Oo1lc+INcUwv2JaoCF//xb/QnriQxf1MS/RUqA9T3JhPzMJmpy4IIp5PlUmZqO7Y1FoFc8RW3hfhG444JqgFgBpsXyPcKcgROr5KcQNsn9fDGXEurL3vLFktvKh4mfANaOdREPUZZr9YPefj1eDclF9uzC2oWhDs+u6TjASNxlerXC5HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWZpvcFr6A3EicQjTi+9D7CGzZXTUu6Fz5R2h/sTnLk=;
 b=TIf+JV/9g2plyvZ0aOZOqVSTao7o9Mw0l1Z2qkA5tXBJC15mUGR01afWVNPy03uJFzOAKmbWAWho01Vfw3OxzlOScko5L41s0g9r39rvY6bCZbRjITnYgSzN+fu9XUTMhOklk8/3TPF9gKLBq2dXCtT0I+ilTrpSo/8eTIV3sCtoNr9I0uiLKAezgXObB/RE4+UDvan/DlG/rGFzWob4rT/SwWZDGWAP27QD1LJgARo8TK4N8bDO6GU9cGlTeAhFuCG2iw1Lp1XAWW37PCSpkEiDUBkhRnurw1yAtoN8fH+/1o0uAuLNyQ/ENOjeaQ4RwOkObM0UXDnF6FJs+CmMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 08:22:06 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 08:22:06 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "edumazet@google.com" <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 8/9] i40e: Remove circular
 header dependencies and fix headers
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 8/9] i40e: Remove circular
 header dependencies and fix headers
Thread-Index: AQHZ8R1TpSizpDLlFkeA5ZoIhKoZsrA65wkQ
Date:   Thu, 5 Oct 2023 08:22:06 +0000
Message-ID: <BL0PR11MB3122EA0512BBE5CCCF62C66BBDCAA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
 <20230927083135.3237206-9-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-9-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA1PR11MB8473:EE_
x-ms-office365-filtering-correlation-id: 9a1abbd9-87e6-4ba9-8510-08dbc57c295b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LE9SNQaBBt+sRcw9c5sL2IFm9CY914Ui1NOnZ8N++lZjaSf8jLRX5ai3bwxKvttme3SQbq3v4tlLa/rte+LduHzOxcZaZUVQxWYSHuVyprG22CnaPKG0u46TbUKHQVJin/ia9AgbxOaVw4VOxvkSJS+CTC34nQyvBb0bENGhcA582JfdEot6zbCZyQplbZdHczkcwOIXtQ5kKv9SOTbpmNzK4JR86l4bD3WEhL+yE7rTV2w3ePqhRTdZOPnRbU+rAiLmaytGIO0MqaRTo1m0Rqo/PXC7abJpwVAsJGnQLxvYpqEq4OkmmBrHEr9DH7FX252Yd9DRYzj90Ni6vBCybf8rjx+IUxH88oE1SNMUvP7ufZcOB+3KUgz6Uwa3g1Oy2oXzNcexiJoS2xEJPncSc0UK1XPPjmCMleLWtdMk46UflT66ti4ovD51TzmNHSSgNFnYTpsm9Thb7yM+kckgFwZ5YOOIHaZ5PnuMFqfI/hgJTgoemMtsB+qTRj9S7nZHcqyNnywmNOxAi2pqq90PaiLTFYxgAGj1zP9dojKEjLboi8vhiZIiWnjlwggfvSkSvhEquWcDFeBJI/wxVXBiRKfqM7duQEiDrbfTY4Gw2ffL8RSZHzQ9ldh3hdbfZ84h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66446008)(53546011)(110136005)(54906003)(86362001)(66556008)(66946007)(76116006)(66476007)(4326008)(41300700001)(33656002)(38100700002)(2906002)(8936002)(52536014)(8676002)(38070700005)(122000001)(5660300002)(83380400001)(82960400001)(316002)(26005)(55016003)(64756008)(9686003)(71200400001)(6506007)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?69c0rkGwD/mPd1cLCkKp+/ul6L4YBmy3Qxm/VxNQDLsC/2TVmmf+HtEYW3oZ?=
 =?us-ascii?Q?vNMbvoB3mVn+HLWN5voGoCwq7yIwwPW2HxCc1sKWKufNqWJxXXbVzWAmtUT4?=
 =?us-ascii?Q?GwUwwc9Cp479Z2Rhrc0+Z8/RHP2Qfx3B1dKplGmUtckkv0V5AMMfr6z+ZSjO?=
 =?us-ascii?Q?s6qBJ9pNgFwdw7mVF71/THQPEYvsdlMklVBK7JJPxBYrXuva/JZgYJoATefT?=
 =?us-ascii?Q?WyRJCPIo32VS4AnjMOkVZPY4J3R6U9NDHWI0jnJlm47ukcRClDWwlbQz2DJ1?=
 =?us-ascii?Q?SowqIOgm+pITkaRy6CtJ+O5hJc7+M9Sma9Dd2QwPOqrhuMPHHFpFDWsYkW0A?=
 =?us-ascii?Q?6eVBFCCjT/D1YB+QjnOw6fu7JPL9eoLViWQNNfXo18WLeu+A+5kWME1GIeA2?=
 =?us-ascii?Q?NjkD7faKab+j61dS9K5onbTqyKRG6LIuRvcGWIqF96A7pbrkokh8F7VRnBqO?=
 =?us-ascii?Q?vrR9ou6JwWo0A+GF5rtcn70Oiarb/fYdQhBEPJqhAm6PjCin3MclxMy4AA50?=
 =?us-ascii?Q?OzE4FW5jgrqrpOgyz4IFxGyFfXje6brcDFJXAtqwiDsQyA9leIVSeAbn7zuS?=
 =?us-ascii?Q?ngRNgbDvx/jPEICAabgfZoDwEdvYk+ghQ2HF5SqAdDBVQ96JOWc6wKIFOpUl?=
 =?us-ascii?Q?efr3OE7cLTvVH7u41KXJ/tSZ+Pbu4tokIii0xNQmE32EFm+ehoRINV0Wjw3A?=
 =?us-ascii?Q?aQk5tscL2ZC/3dp2eg/4vMDkUhPhVBsEYRtIxOGW3rOkcFHhUV2pN9wVTS0N?=
 =?us-ascii?Q?c1G7acXIPy79qDLhYOW2e7f2M/sHUm9f/h/ULW+DrTPcuj9gRFKxmX6jZKe6?=
 =?us-ascii?Q?YEbTqsyjSMODEmrd2qoNsA9Jazox/73/lpXLGNtYv/s7uLToaa/dSYwkGOrB?=
 =?us-ascii?Q?Qe4mtkgKRXxdLlJEk1ycPaxV+rRTtT3Fl9FfndWmr+tMjJX2AAMSMcHes35N?=
 =?us-ascii?Q?aV6nxRQT++isjEuDbenceqIwVdCcRaOJWuDQT1Yy3abs47MpnUOTH6vv8cFi?=
 =?us-ascii?Q?qUyb++uULagvnWRyOh3x+B65VfS0W/9dwABUBLfcXuk0GU8vCjNkl0gos9sq?=
 =?us-ascii?Q?ilfmx/JbpcNoMng2qJbd8h5NQ+4WbMrXryG1+Z9v08T1l4kcRwstRFEUReBS?=
 =?us-ascii?Q?hlKNXXEUHUv7WETRT/KUWTnIe+8OgLDrVRbr6lu5BhEsLCsTI7sOmaiM1O90?=
 =?us-ascii?Q?+PkGEl/A+BQpM5WOXvLkvt5IkpuxYRCVKGxzLD0Z8Qrf68XTg31UbOb1jD5R?=
 =?us-ascii?Q?u72lEk300XogQCA3VSDyr0zbfiboWsR0NAHA2oOD7oztq6lwMU20wL8uqHYS?=
 =?us-ascii?Q?HNs2Te7+ZsKalWBXtc/rbwAF9JuukaBxNz/xyNQJ200MZ0GPShJh8jt9oGvb?=
 =?us-ascii?Q?tqHSbjhE9m54qnFGUyR0kcLT4+MAjqnd6cWa+6kPiqVRaV53OMHxrikcTq1H?=
 =?us-ascii?Q?Mh1cHmrF+W6ZuP7+UC9mDLq7YIGhPamNA4smJ5TFtRFQ2jgQpbkFPH9KIKCE?=
 =?us-ascii?Q?FjlTHT4v0ZgOv5MJbl1bKRCmNA/5epTTgYMeOeolNPzSrz2TYQLanluB5k0k?=
 =?us-ascii?Q?nMFeEBMOsoaoCnwTeQqs9JKLaMqKnzYvbFYi4ktx53G1eFUqdn34bVOoxrAm?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1abbd9-87e6-4ba9-8510-08dbc57c295b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:22:06.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuDmKgAnWt1fgFJWnKkgpsn2huQuRq9IUqjR/cBWThloNKFc/CmJqwnjl0+HH+WIp5tV7WwhIDukAkX2uKpurgChtWIPlQvyQZX5NiJEe2s1EjiY8an4JjghUFep42tQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, September 27, 2023 2:02 PM
> To: netdev@vger.kernel.org
> Cc: edumazet@google.com; intel-wired-lan@lists.osuosl.org; Brandeburg, Je=
sse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitsze=
l@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next v2 8/9] i40e: Remove circular =
header dependencies and fix headers
>
> Similarly as for ice driver [1] there are also circular header
> dependencies in i40e driver:
> i40e.h -> i40e_virtchnl_pf.h -> i40e.h
>
> Another issue is that i40e header files does not contain their own
> depenencies on other header files (both private and standard) so their
> inclusion in .c file require to add these deps in certain order to
> that .c file to make it compilable.
>
> Fix both issues by removal the mentioned circular dependency, by filling
> i40e headers with their dependencies so they can be placed anywhere in
> a source code. Additionally remove bunch of includes from i40e.h super
> header file that are not necessary and include i40e.h only in .c files
> that really require it.
>
> [1] 649c87c6ff52 ("ice: remove circular header dependencies on ice.h")
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 43 ++++---------------
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 +-
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 11 +++--
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |  2 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 ++-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 ++
>  .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  8 ++--
>  .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  2 +
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 +--
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 ++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  7 +--
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 --
>  drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 ++
>  27 files changed, 72 insertions(+), 81 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

