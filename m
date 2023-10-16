Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C157CA1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjJPIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJPIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:38:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502ABA1;
        Mon, 16 Oct 2023 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697445493; x=1728981493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iI/5gN2QfySIC9Ze3pZMxK7qC3btkBN5kKcDinBV/tA=;
  b=L3Jb1pVVmQ0gKLHhG+Sbq9FNadL2hX8B03AGfpcDp9FJ7INHpVTYhBHt
   VbemFEztz0wZyL2Sc57CegKCAkzVp8p6+apZjZAUMXsiMloEKNJtyZysD
   6ArwHGlk/1LxLiFDypO5jg2BKPqmDhrdNfGGyF2SbRQDsWjMwpkYs1U8f
   oKm8snk/Miqfuec8BX2Y7wMvQoGDXxi0trro/54hf4zfMMGP7xXPqXWWm
   oLtUFXa3KFsYSDdVkf5IIAUYFvNleLY7iDe2CNIGyecvvuhAKUMmZ2kzU
   tXBvtC2Cr0ARtWZlrf1OJmNcA+A2V33fGWCF34lYC7PNs212NzVdge4vK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385319002"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="385319002"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899413389"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899413389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:36:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:38:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:38:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:37:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:37:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkErPUEMryKPWv9keuKlYIuE/T89W14V34Sc1XeGakgEmu7pOQNaOvWha0YkAYMa9IeHUpaSmLV8UZzFepp1GusQdd7T/Ptt+AS+/phfaaBCfbHyYjwzXcAifiCFHmdtDIvC8jR6rUpsUgn6A0YywhkRxn8IcoNzsufx3xxLDQHJ6VUAAJlg0Mk72WgWVAZ+oNZlqysF2a34CxcJ1IWfII37lqcuI37Z5xejWFWna8ZwRVE1SecfY6arUU5oh2MGmRfS6B8UvvOSu8/RicDdHek6d7vXwxjNCXgu7aLLIz90gbFZQln7NeQGyROMmmJUoUplvyhO+sok8IvbH+n0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzUb5YYw/E2+2skN+tSEbLo5H8GYCDs1JjLLqXdYd4o=;
 b=T8bDm/eGkup2Yt79X2wU8Syjyif7OPMFGEs5KqIitFAi/dJ0sPNTXV/sJ1WRlPfU9kSv4H/xWcv/5X8chKJXi6+UkbJSEns3rXra4nCotghnl2v1ftTyC3NURRfiZBDlzggoul54qmwXhiJDsGpvr0abnCxL12xfty5q87TmlacA+pSFZ5WW3uqN8qMvDWztLI3UMHzFxsvKhA8ePO7phH57bm3j1J0PKP2RTeLQmfXFDnLDAQbpZcXHuZmrUVF7hiJzpfVJxD43DA5knJlc0VFeWpYKHOw0qCttV2njHeNu9cb1vFlW95xGbRRUUSVauXkCj3eLzu6XlF2nca0y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:37:50 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:37:50 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v1 net-next 7/7] igc: replace deprecated
 strncpy with strscpy
Thread-Topic: [Intel-wired-lan] [PATCH v1 net-next 7/7] igc: replace
 deprecated strncpy with strscpy
Thread-Index: AQHZ/T+jVnib2VOsXUmx3jIDO1iTELBMHQTQ
Date:   Mon, 16 Oct 2023 08:37:49 +0000
Message-ID: <BL0PR11MB3122350138D0C03C3EA162C1BDD7A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <20231010-netdev-replace-strncpy-resend-as-series-v1-7-caf9f0f2f021@google.com>
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-7-caf9f0f2f021@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ0PR11MB5582:EE_
x-ms-office365-filtering-correlation-id: cf6de5ae-b15c-4dd5-88fa-08dbce232dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+agSbBTBFvuTiZUToFLL6CGJy+RBFBOc5DNLmCGbRKI1jKCgtlm+kmMkN8+Q39GImFuD91QHh9cZf9RD0N/+5a6YrQkQq8l5oD4nNUrdmnkEh+b0N5zHi7zXIP0CDROnjwhdpfy1w3hUXlMXLrfNLe0fHCkISZLMCOGXPjG9BmkS+HT3ZKeP/Wfeo0NN9ryPMbiTlClsF1QAY/9Y3AJh6rZmCjqDCYUXRkXHNtsdI2nKHdKsoUZnqE9vztcmop1q4C0h/ljUb3seRouEGfw6xKLMmQaXYfL64ty549Z0Y/sn4L5a7f4yVxODPWaAZbnKBgAlonCEcDKDEb2N4ZcvFXL3OiUyvWoHZvDd2Ff5iUhPD4D8DV8+Kl56Zo1e/pkd1WPdV+ejYTbHiDWPDdE5KxEkiP2QqmFmvbRxEJQQdna1zPTLCB6rQ9+pHvzClNUe5+CDJ7Ai2BfU1HSHCOjlr3lu0ulu/NQGWffjsZUXzmZoT1MsnnoAO2DE7svEwY1iWxmgHO2uaTWtRQqNCBzkNv72jr49AdQsMp4igh1elwKckh5BxMdt1ACAeS3BQtYIygnWp5b0rckH/ea+DP6MMrtrlpWPp6kY9D25QRxot2mq8oWM4sHImKJA2oru7b67bJqqlWBOYqGfDL8EgQxt6WHkIDn8AHGFphU6lVCHfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(966005)(478600001)(316002)(110136005)(66556008)(41300700001)(66446008)(64756008)(8676002)(8936002)(4326008)(76116006)(66946007)(66476007)(54906003)(5660300002)(71200400001)(52536014)(6506007)(7696005)(53546011)(55016003)(122000001)(38100700002)(38070700005)(82960400001)(86362001)(9686003)(26005)(83380400001)(2906002)(33656002)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AmxnJPUx9a9g1jRynpE581gVLSFPHD1MIpaLXFlh83JQhtPEzlSI0ZBDVg5Z?=
 =?us-ascii?Q?zxj94MV8r3Mu8tdKGeSkH+4TvRVEeFnl6w8C32Wqqcs2wNswXmetOFUBMwOa?=
 =?us-ascii?Q?8a/ytBsyBmqdKUCWePr7G6GwECimkHC/fgTanHPrV3r0GpRiCHS/vbe3p8yD?=
 =?us-ascii?Q?WZysa+cWXQBqfR2EZipvZSqlGc/ObbInSh7prYsBFgwizsu4DvkI87+WxfzG?=
 =?us-ascii?Q?769Lz9dlScMmjub0BBcYbdhCIMNdmICvLg3+sxxsp2YwksjR2DofyboxPRNK?=
 =?us-ascii?Q?Fzmx4yKo0cj8u//B20a1k7170npLeYVPvjctXLoRYGR9Aq5jAks/TBBqNbNb?=
 =?us-ascii?Q?ib3OX+BRFQRKwcJClsAzhrHdCwd+Xzp8rwgFov1/IqDz5ONoYwdP9sroVOSv?=
 =?us-ascii?Q?ygqR8ySLUlRlMKk8ABGngHay41vAbGl4sUjO07eVNcgWfajbnoHtG66e5trM?=
 =?us-ascii?Q?KOhMQHRZ7DbbfqE1ys+96YE8CHPweCNEsJSYIjIEkQSuP87agiw9cRXc9guV?=
 =?us-ascii?Q?gE0Doh/mGFEQtpxHymqoRlhB5oAM4EgugjfKZwYIlAgpgj6cE2OzMZrgE3CN?=
 =?us-ascii?Q?jKLUpemPHRwGqhATGE4w9zOqTQZiLgyewo+VbJu3z6rexwS0Ep2JA9QDedgX?=
 =?us-ascii?Q?P5Q65mbS+ixvKM5YUTMgTUW5vZZs3KuWmS4l1uARDm6YOGk0IiElihV/APc9?=
 =?us-ascii?Q?A0H19q57ucowQYWqGocMcG8UiLOp+1PO5Zdpw2LydXLEWY/PIpTkJlUAhEP+?=
 =?us-ascii?Q?RE/UHqRJBEDIVBxP6gbfFEAtIF78cb/VPjeP5rKYEnQE2ZDV+3puPOayLpP8?=
 =?us-ascii?Q?VjpPH+RuCU0DDSeHNJZeuABPy4zLfdg77qG5ykWpjpgKf1sqUtGNF3jXtnc0?=
 =?us-ascii?Q?RV61bk7mvVV+2j7tiKOUPd+nAkFX72Y1veISesWi5K/Py4W1w+amEIUuuH1g?=
 =?us-ascii?Q?LQ3WsHvTsK2TwZi9r9hC2OBMr6e5wO8qf1qFCxf86JCMCII+IDpX8qkA2f6v?=
 =?us-ascii?Q?S7S7cKe3z70mlUmiLk2hLawkgLK1rLSVgvmG6GuRZ1SfIF4XdxQeEU5RAVZz?=
 =?us-ascii?Q?PlpbPq8DGS6ljwiw4Dj4NwVU1YVQuCQP2E0D1H8XQbf5855f2nBZo527f3UZ?=
 =?us-ascii?Q?oqb+6v4yn+DDDVEbNYnbRuGnV33juipGfJIgf5ksIU3xhC7TRhJRi2o5X8Fh?=
 =?us-ascii?Q?mvTNnFYG593gpUrPJ/feTovmFlU9eZZrmSY3D7ctFqBRC/d//laj2TyJuBJT?=
 =?us-ascii?Q?ZM3t4pkVVBxp9rwmVXif7oFZZcX4wKzpycenTmIQ9+H70Epab7pB/Rt6nUS5?=
 =?us-ascii?Q?ctpo2WiLCV65b8nJ3OJy1+8uJj2tJj9OAiWh/aD5bjrLGHkKvRVCgEFaGBo/?=
 =?us-ascii?Q?DRMpLV9Sh00z0GYci+YZFJRXOSsbVOSg36rmex5OlwlcbXfdYymYqeNdJ53o?=
 =?us-ascii?Q?89Oc11ZyJ32TiGlH5QiZhsSz8gd34tKd8XyFbUKLPRP3iAQfMbvo18wo4Qfd?=
 =?us-ascii?Q?AgD5Th+07v6VN5cT4Ai+qDsxncNQavUnKAft7GwhV9LO9ElhZqo4XWkgJSkJ?=
 =?us-ascii?Q?iWL1hD7fytSOGCsMbAcGro6wi9fobB+/Ag/HV9HCvNtInXSnUfnwv5CfOw9A?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6de5ae-b15c-4dd5-88fa-08dbce232dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:37:49.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UjLviIXFVkxy+4LLHMcKU3wLeItfHZyozCEIY8JkHSF/bY5q/Pbue98QxK7ufkMmvUA79F5zD53miikjU3zeAY8+mno9UcJKkUGJyHQSrbxN6MF/6v4RbSFMHIxySPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ustin Stitt
> Sent: Wednesday, October 11, 2023 3:57 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>
> Cc: netdev@vger.kernel.org; Justin Stitt <justinstitt@google.com>; intel-=
wired-lan@lists.osuosl.org; linux-hardening@vger.kernel.org; linux-kernel@v=
ger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v1 net-next 7/7] igc: replace deprecate=
d strncpy with strscpy
>
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect netdev->name to be NUL-terminated based on its use with format
> strings:
> |       if (q_vector->rx.ring && q_vector->tx.ring)
> |               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
>
> Furthermore, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev =3D alloc_etherdev_mq(sizeof(struct igc_adapter),
> |                                  IGC_MAX_TX_QUEUES);
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFA=
IL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

