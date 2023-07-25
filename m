Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0937622AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGYTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGYTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:51:08 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 12:50:23 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6447E1BCC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1690314622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sufhrMxuR6De3yDY1epOJ1EtNjfVaEPMJu2zXJEU/VA=;
        b=Ow+sgsLO5eUCKYa4Ffyh7hR5Z/DYWzQS0RjOvD2KL4qQRkvtDWwsS9nNME3xWFhiRN/cJ5
        71cUIhxV0C4j0uj0N4VyMHSFQL8T2u+DwZgklpHveo/pxn/ZIakvPIB2CF7t1TZZcjnpIS
        T6kFdTlxTcKQVs+KQ/y21hlYXdHNcNM=
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-iikB6d2SOWuOs1D78y3mVQ-2; Tue, 25 Jul 2023 15:48:22 -0400
X-MC-Unique: iikB6d2SOWuOs1D78y3mVQ-2
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by PH0PR84MB1383.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:16c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:48:19 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 19:48:19 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: hp-bioscfg: Fix some memory leaks in
 hp_populate_enumeration_elements_from_package()
Thread-Topic: [PATCH] platform/x86: hp-bioscfg: Fix some memory leaks in
 hp_populate_enumeration_elements_from_package()
Thread-Index: AQHZuPHkIWGabZ7ClU64DUVfhVGEta/K7pLA
Date:   Tue, 25 Jul 2023 19:48:19 +0000
Message-ID: <PH0PR84MB1953EC528F8D549E6B3B7669A803A@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <9770122e4e079dfa87d860ed86ba1a1237bcf944.1689627201.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9770122e4e079dfa87d860ed86ba1a1237bcf944.1689627201.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 21ed85f3-5ec8-4d30-8b43-dd11a07cc5f7
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1953:EE_|PH0PR84MB1383:EE_
x-ms-office365-filtering-correlation-id: 6cc94ba3-eae3-4140-e9a8-08db8d4818d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: J5QMgXsiTopUiRw6j1NCHSpc2Sfx8BMztzA5SrhJWHipjEy/7YlCpj8klnJ/IpDz5S/kpHPhVL+Ez5zW9k3L+8j389tPWa3bDIlQ3RxDeE9r4B3mOaDEzStRBk6BOH8oqFWU77UtSrqeUmMfnMy93mrBxt/61vzyX9WNHt6YmmvVR18xt/LOD0vpQVgSvjg//Sqn+vJEqpRr3h4zs/qtrTuf6DMBHllxSTAKJeu0SGksvFSJE2TwiPpP/tCdNOngJx95LYggdkU0SO/bugTrojs2MnFyzD/Pah6hBDdMNJfMdTa1zfeSThPp0QrwxQK+kFfhkH+WYzEu/r5xe0qvS3jJFTvdFge9mYnoLadsoqnBnlhmrquruXVw5/81Vq1y7CBHyXNY8Y3voQBC63w5fA8j4pdfgRwqzSIqzzrsBSsLTI+PPMQMg/8+hnF1JHP/zwwbtP//ZB8EhKo/ORYNKm4/VZ7PeENisjQEfzRp1n6P7ep0j7FI5J889gNhSNqmR0C2BNuVeuZaczNVmZvqA0l5cmOnS5GkG0+uZhckSjd3qVWMKXsui3vQ2ha/Ge4GuM95w7kuep1Kk9dFq3oX376j0LX2wPiDMptjKU1qXIz4pRKEqA6L8W1n96hKBOhx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(33656002)(38070700005)(86362001)(82960400001)(55016003)(38100700002)(66446008)(64756008)(478600001)(316002)(4326008)(54906003)(76116006)(41300700001)(110136005)(66946007)(9686003)(52536014)(5660300002)(8936002)(8676002)(7696005)(66476007)(2906002)(186003)(26005)(71200400001)(6506007)(66556008)(122000001)(83380400001)(66574015)(53546011);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0OMOe995bRNnE2Qjn9aoZIo5ULzUzcI9bvXc7QIDegVmaR7sCxCYvG1XGG?=
 =?iso-8859-1?Q?MZoTE9TTceS9rXSBhT7NqEu7JHjMRUeWj6oFuQlT9jDBakn735VAoc7+1i?=
 =?iso-8859-1?Q?hKo/LP/eRnl6Hnn9Of/EYXTcG28AtT/oZVQAOfu6ynUqYTQJ5rZsvnYDGG?=
 =?iso-8859-1?Q?X4CM5B1SRtLBwSVLBq33I5R4Dk78A1jCbTlqPTItU0FhpKoAUsToSzY7JQ?=
 =?iso-8859-1?Q?bdnvlnw5cyW2wJae9oMqNtJbIC9/AabRyfj5OX/8lylyEvz7ScZgK/ftqs?=
 =?iso-8859-1?Q?jQs0WvZ10mF4K6wBhaGuwlyW1Jr0EZW33vlAuwzXwDIxfgqTzuDLRuk2nJ?=
 =?iso-8859-1?Q?z4FdGemZ+FFW6mlwymErnK8Td7BXe2QntMRtCve1L1kp8AfUu+JZkszFFN?=
 =?iso-8859-1?Q?MU6Dz7E4wfs/BSuKqIL9Lm9Jg50KzRMyg8RNI947bSUd/sSD41cWPMMhri?=
 =?iso-8859-1?Q?EtPMjw9mJo1uzqgxycHhJ4OXYYFM3/lxnGB04nOANzXpdOe/Gx62bl1sK7?=
 =?iso-8859-1?Q?dAPQr0vwUl44Z0/8hh9s+P1w4GGZMUnNzF7y6521spcOd8Px3fLnYRB+H4?=
 =?iso-8859-1?Q?iIvoHJ17+XmH7KVwPIBGUqxKcHkB2PPPRqeT8dClOSOkjDLZKwsdNQyjyJ?=
 =?iso-8859-1?Q?jlwj0xh+bYozjC9qTl4bSVFGAYO2x2XvKsDw2VNi5kDbfXEDQfc+BzqE46?=
 =?iso-8859-1?Q?5lDlD4mJLKZKkolnBlN2dOWJzo1opinkHdTw+qlc/mnAbkkZuNbwVvmmzj?=
 =?iso-8859-1?Q?9u19zOWrAOtrwqznBdhmZ+8dS2A1lQ6y5YI11s2A0mQaDUj/pvffqlAknr?=
 =?iso-8859-1?Q?Lzv+wqfFb1bJDgehW+91NP39AngHlCRq6qNv9ul77jelmzZtotJ6nFJlhb?=
 =?iso-8859-1?Q?VCIoGBCwugyxBMtc1uN1VtwTy1DIYTPPgl43wmD2u0Ss1S4qt92GmDSHky?=
 =?iso-8859-1?Q?AdpXWpbUjZ6GO2viRTtJ31+Cz7m6Ab87NolIm2nS/ZEXN1KjvwPYidR909?=
 =?iso-8859-1?Q?S8qpaFetW/deL45zhcDPtlpxUoWI4rKVz6wRw+cIu+wtPv76/9hqaBSbus?=
 =?iso-8859-1?Q?mzkp+QlT3es/W5tIxm4oomOcLV6F9VVuZHwbg2hVgUYtd6OTN5zWEgl7G5?=
 =?iso-8859-1?Q?qV7hVnNjR/cQZergp9K5dLYEzLw2ZM+qdomhRU8Hve8Of2DgN8KX15ifXG?=
 =?iso-8859-1?Q?uKgZFbxA4DyaFpHVIDs30+IKnYHckgSNPKXNsM4lj7WDsW/WJzlFTDDk5e?=
 =?iso-8859-1?Q?nHBd2mRETwZdGFc0wK+SlX1H9gl9T9Az9LI/LmQv0GkDh8YP9jKjOiS0i8?=
 =?iso-8859-1?Q?rKBC2jLdLwgUX7cGI4obz87I7LjNwhNxO8Ipl/W9WBds4C2kLKCE/wUCB1?=
 =?iso-8859-1?Q?iZUt8wrMSDqtK1BykT6JJEZ09Vnj0ovZoaMZcGrU/4UFksWqhMkySMRMeI?=
 =?iso-8859-1?Q?CbzdXtuQFheQ8m1YlbAr3gZs3zYdYC4A1iaHKsiDh1wosoRABsewdv7iOw?=
 =?iso-8859-1?Q?Who/q6h4TjujsY8WrRRqjsbiypRIxSH+yD50DwFFDZt8Jp+qFFH1PfbN5v?=
 =?iso-8859-1?Q?OttiSmzBDZbsxWhcFh3nAOOD76CU8Cu2eeDMVC2Dlhy+Yadyi6HRulErBy?=
 =?iso-8859-1?Q?OvWsYhdqhvNBW+CHKTqohPPv+0GOVVEpbj?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc94ba3-eae3-4140-e9a8-08db8d4818d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 19:48:19.7098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVIsTshVf9/pDoynhl5cWmJ/H+li87Whgxhomwa/TLhPGppAZw02nBV6fZAI7Ks0G+JHcv82pdBkg6ZkgIr2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1383
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I will submit a patch to address memory leaks in hp_populate_enumeration_el=
ements_from_package() reported here and to address some uninitialized varia=
ble errors reported in a separate email.


Regards,

Jorge Lopez
HP Inc

"Once you stop learning, you start dying"
Albert Einstein

> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Monday, July 17, 2023 3:54 PM
> To: Lopez, Jorge A (Security) <jorge.lopez2@hp.com>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Thomas
> Wei=DFschuh <linux@weissschuh.net>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org;
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>; platform-driver-
> x86@vger.kernel.org
> Subject: [PATCH] platform/x86: hp-bioscfg: Fix some memory leaks in
> hp_populate_enumeration_elements_from_package()
>=20
> CAUTION: External Email
>=20
> In the loop in the ENUM_POSSIBLE_VALUES case, we allocate some memory
> that is never freed.
>=20
> While at it, add some "str_value =3D NULL" to avoid some potential double
> free.
>=20
> Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Speculative /!\
>=20
>    This patch is based on analysis of the surrounding code and should be
>    reviewed with care !
>=20
> /!\ Speculative /!\
> ---
>  drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> index b1b241f0205a..dd173020c747 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> @@ -224,6 +224,7 @@ static int
> hp_populate_enumeration_elements_from_package(union acpi_object
> *enum
>                                         sizeof(enum_data->common.prerequi=
sites[reqs]));
>=20
>                                 kfree(str_value);
> +                               str_value =3D NULL;
>                         }
>                         break;
>=20
> @@ -275,6 +276,9 @@ static int
> hp_populate_enumeration_elements_from_package(union acpi_object
> *enum
>                                         strscpy(enum_data->possible_value=
s[pos_values],
>                                                 str_value,
>                                                 sizeof(enum_data-
> >possible_values[pos_values]));
> +
> +                               kfree(str_value);
> +                               str_value =3D NULL;
>                         }
>                         break;
>                 default:
> @@ -283,6 +287,7 @@ static int
> hp_populate_enumeration_elements_from_package(union acpi_object
> *enum
>                 }
>=20
>                 kfree(str_value);
> +               str_value =3D NULL;
>         }
>=20
>  exit_enumeration_package:
> --
> 2.34.1

