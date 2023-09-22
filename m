Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079927AB910
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjIVSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIVSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:22:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CBAF;
        Fri, 22 Sep 2023 11:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqk68shHa/MjFUh0q13hCCSmS0dTviXJqHGMmDiGOnZMqWliPD+DEOIvC4kUkVRJwuNG3brGx3ffzes9Wc3vC/jrrpBGM4ObZ+HYMOYD+qtFQeZLYbJ7IB4o6IsjqedyHFeRzW1GJ5XysBj/Pq0ugPzag34dy6yuUJpBFKX/wH02FKHQ6sSycP79RbsiI0KiBqg9JqYxwJNja12s6reRb6Ya/mSu69mylK8V6x4Rm7pdbIaTv8qiEb2ObjO13HSa8fwEkszamID/ZK0E21uUx3UdADlZJCjBC5DtGlkO1nshN2/0NZ00fHmV2CfNpKSWunrnFbSBFvnkUd1WxaS/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN0KCRzZCDL1EPLQdF3a/nGxBhvumj1scZi7nd2dkTc=;
 b=XzTBUvmpmMBtNI+mT4iolvmNqx5R5J1PJKFNUAadeb4yQE7OHGf6RaDwKpliSIuOofTPVZUWNc4mJTSiZqrQ/fCj+rgygJ2xPSudCwTyWWyxnQ6NXsxLmHGyQNBfSj0FwWAvMHqOu6MCFGrhLru2nNVorskibbRhU2WocIKjayDx9IoocAXLtSKoAx+t7Fi6hjUyJ66LAa9K3gD5eAbC2sFPP+ErtfHNc+MDLk46FiMonEOa18i6UsFFLPIrFHiLQJvFad7CSmjhh32Q5/KPPmaT+xDd8d3+bGqYhnCe7Dc7q6vvahg9W0+teYK89b4wn3iE03CW9xiqxq7F1FvGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN0KCRzZCDL1EPLQdF3a/nGxBhvumj1scZi7nd2dkTc=;
 b=Mkjyg8mOQd+R2oQR6jqP1WKUdcbeGRWDsr0+Wg2Sbewg/PTXEzCOf+/yK6DQgPCpAreAP8mW5hQUBbanDYQZa+SECsYnfnDH4FD1cRvAOyPvjZElORkcp2PVoE+MURA4XvtR2L6AOaLjJhNtLBuMUiQnVJRg22t7C18HIEHXu8w=
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPWP152MB5790.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 18:21:55 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::33a9:1d82:af5d:6419]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::33a9:1d82:af5d:6419%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:21:54 +0000
From:   "Fernando Eckhardt Valle (FIPT)" <fevalle@ipt.br>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Thread-Topic: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
Thread-Index: AQHZ7JkPZrp9Pa2XGkWKJf0YpsWbgLAmit8AgACdTII=
Date:   Fri, 22 Sep 2023 18:21:54 +0000
Message-ID: <CPVP152MB50535F32391251E1AF02FA00D8FFA@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
References: <20230921143622.72387-1-fevalle@ipt.br>
 <946285e6-6064-4084-a1a7-f5ba7dea3e7d@linux.intel.com>
In-Reply-To: <946285e6-6064-4084-a1a7-f5ba7dea3e7d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPVP152MB5053:EE_|CPWP152MB5790:EE_
x-ms-office365-filtering-correlation-id: f66c964e-3fa0-4866-32f2-08dbbb98ccd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scw2Z9yXrwg8sy4ezRYlkJ79jWFx5jkXFJjKlVklZ9xkL1G1AAM12vhcxSpaPo741tLp9TClOzddquO0Hwk23w01NNhQ/C6gyDfm9WtKoYga59mH8g2xneY7uoqQpNY96OMyaGeKAJBBzZprpZiE+uOTyTzTPrnKUzuFyWSCZnVNdZMXtZZbe6D/fX4dGdvZDs9Na0TFR0oSUSFknQ/DudsyeNPzOy5BiMpsxpwwesKm6NtjVVf8Kj6iVjxfCTGhJzEb9M9GCSrO3TGO0da22BSwsO8ixiDOACmh3zD69KRVlNUk5Vr6HwJ5GuTxBXqLIoyRDhKKNJ7K1TJfQulpGQ7F21Etx57nmueYsnldtwIxDQCyEfxrPG75a5m3FzDwd4X8/pWH3JQxACP/lDkr159oor05QQ5N5LZtpT1aycAJQeDVjuVNhyXAkTmvgsDOM6b3R/B2RQhYl7crglm5bNoPWq5cLvRgs1MLM16dveWk4sWS711y9cIIddpypjjugg8lq2gMzfweGqeheM5OeRrZ/eHZv/ustiUw/Vt1ID57dbbeWp6rr2Gpn3w+wjGBsi4kOBefeSW7LcDo3IGsmcJm+/S9YitmFemnc4/E+4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(53546011)(6506007)(7696005)(71200400001)(83380400001)(478600001)(9686003)(966005)(66574015)(2906002)(7416002)(41320700001)(76116006)(66476007)(66446008)(6916009)(786003)(66556008)(66946007)(316002)(64756008)(54906003)(122000001)(4326008)(41300700001)(8676002)(8936002)(52536014)(5660300002)(38070700005)(33656002)(86362001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YiFzApd9A8m1broBqtUTrWf0PsD4djKpJhdABjpWS99tJll6I2hOeCzYqG?=
 =?iso-8859-1?Q?71qa6lNW2AvNYKoVErb+BIW1SLC3Gszuy3TXOgxCcmmQYyHKUWieZsERNX?=
 =?iso-8859-1?Q?bvd09RG2OJQN8OGwSWu7RcuSbk0V0xQaQnHk9G60PQwW5E1ADlBuSKHAZJ?=
 =?iso-8859-1?Q?aqDyJB0BO79HQQ8w+gaj7vBhZ9e1PzQI3PtISNhZUBkQ1kzfNCoyYxrqZA?=
 =?iso-8859-1?Q?MkU8zC1QHCs19iRAC0PAgDtWXaJ+PMYRWtavpAbbMO+5iLbgTTonWRHyLX?=
 =?iso-8859-1?Q?IiiuCGxLpeGBOIZ+WdRy+C6/2Y88ING9ctAX1vJ7bIeMh3aPBSsPB85FfE?=
 =?iso-8859-1?Q?BH5lC0Wt7PWu/Yan8+pA+5i2GvQreZxFI65WnYHR2xE33X3S1idJs4oq/v?=
 =?iso-8859-1?Q?egAtyhgI3qFZGOFmXdCoK5Nk4yhvwT17Qu37i6TsJAUpGYBbDg8s44gFFH?=
 =?iso-8859-1?Q?7IZmsLIz+s9PEycR8br8CtHaQmfu8/wYZcEOGEY/gyzVYfRURPCMBgKwxQ?=
 =?iso-8859-1?Q?j9j897npHXb7gbQ1pwzS5RC4NwBlJ2BcJrOt6tchd3knvrSIgreh1g1Pl5?=
 =?iso-8859-1?Q?2tFgqaY/lD5a2iT2ROr7oW3VxXJt1tb9C1IxivLg2CrHh540U5g/qrvYmf?=
 =?iso-8859-1?Q?0kQ7spYGotM2NqNgkbvbWGyPCCC9WEpMxT19IISHpc75uHN6h7kTjQWJ+y?=
 =?iso-8859-1?Q?RJtZ1g1jTC/nBxWcC8fjmnlxNHZF42PlKRZSTQhLW3Tcej7vTUO+n25CuO?=
 =?iso-8859-1?Q?f70uZdcWqafjg3qFzpxw9PB3UjWGRAkkJv7bfmZ0L5KGHEudqSCG/penUS?=
 =?iso-8859-1?Q?hCv01jSZGx2aju616qmAf31CRriNLS1QyJgUjuSinrijXQD42SsoAk9xTM?=
 =?iso-8859-1?Q?pFMehuDyY47Ka5RfExSjIk+OkdTnyGBEIbDLl8SxpKd4rWUxdbGduaXn0d?=
 =?iso-8859-1?Q?Pstr4nIykbZQMl0oNKsfxW6aI9RpYMvQwsT9Ytf8ZZsvspLudZq3IPMPWB?=
 =?iso-8859-1?Q?uvttS4qEaYEORIZPoNWxmEuRtK6Ks/s/LNu9Yh5emSQ9pBQ9lDAoDSgHjG?=
 =?iso-8859-1?Q?MdhjONsC7DDqP55osUO4UnyuZ5TNOw9XnugkyhR0IxF6l3zgouPVEx04Tg?=
 =?iso-8859-1?Q?rU+kregf314JQXbM6QctP/627dRXUVCl8uYsXzNUorLfFrhD/k6ezKcJbJ?=
 =?iso-8859-1?Q?gCNU7tUyBTYZgImdb533L3Ov3WwU0wNBhDPryTbkzKPI+8H92hsoY2UrWi?=
 =?iso-8859-1?Q?fbd3txhwZ3HUTBvHjuSVjs21rzsuxLlLD588zHVtLRdMeEeMojnhXq2IAf?=
 =?iso-8859-1?Q?7ELE6hfMcJecGwzMsD1BxO4KyNPE0bQ+L/A1GdeGncD24l8rcdPDTFKTnU?=
 =?iso-8859-1?Q?Hqd4y2mYxvSsX8TdtG5oksDhwpK0fBUU2f61Eh1piDrLCTrtxGuHmyJlK/?=
 =?iso-8859-1?Q?96A6hhG0E4ZdlTKqvO1gpGYryYLBz+rVfEUzOcqYEHbhT9ZhA3Dv6mUwgw?=
 =?iso-8859-1?Q?/Ib3qqJPe8Qs9b/dYiqFCZ2Cm/BLnO5GFuNF0NPAIqKbc2fI0S2nnQ7eco?=
 =?iso-8859-1?Q?X8Jp1LijQl3hLfsRvrhHzBK27KvhPYKeMsa4+jhOJy3umczkE8IzazHMCi?=
 =?iso-8859-1?Q?Bjc70V3oSjFOREIzzIbesnhjjpqWuHvjJvOBoJUTp+0IvWRz6BetV/9Ymx?=
 =?iso-8859-1?Q?OI0YMfU1pFnWQ6dBXIg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f66c964e-3fa0-4866-32f2-08dbbb98ccd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 18:21:54.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TB8xZzSe3bYh91bMjq52ddJzPpkkAgpUnL+cpXwH7q2mygHS3GZ49izF+1v9To2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP152MB5790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,
Thanks for the feedback again!

> Okay, I wasn't expecting this change as this relies on the nul terminatio=
n
> by strscpy() since the original buffer does not have one but the #
> character there. But I guess it isn't harmful either.
Yes, precisely because strscpy() put the 'nul terminator' I thought it woul=
d be ok. In the tests I did, everything always worked fine too.

>  AUXMAC_START is an offset ??? It should be AUXMAC_LEN.
I thought that since the string 'disabled' has length 8, then I would use A=
UXMAC_START which is defined as 9 , because that way strscpy would copy the=
 8 characters of 'disabled' + the nul terminator. Wouldn't that be correct?=
 Or would it be better to use AUXMAC_LEN which is defined to 12?

> I only now realized there are two gotos to auxmacinvalid. Therefore, I'd
> do this instead:
2 'goto'... I agree.

Fernando

________________________________________
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Sent: Friday, September 22, 2023 5:51 AM
To: Fernando Eckhardt Valle (FIPT)
Cc: Hans de Goede; Mark Pearson; corbet@lwn.net; hmh@hmh.eng.br; markgross@=
kernel.org; linux-doc@vger.kernel.org; LKML; ibm-acpi-devel@lists.sourcefor=
ge.net; platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to aux=
mac

On Thu, 21 Sep 2023, Fernando Eckhardt Valle wrote:

> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
>
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
> Changes in v4:
> - strscpy() in all string copies.
> Changes in v3:
> - Added null terminator to auxmac string when copying auxiliary
> mac address value.
> Changes in v2:
> - Added documentation.
> - All handling of the auxmac value is done in the _init function.
> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 79 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Docume=
ntation/admin-guide/laptops/thinkpad-acpi.rst
> index e27a1c3f6..98d304010 100644
> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> @@ -53,6 +53,7 @@ detailed description):
>       - Lap mode sensor
>       - Setting keyboard language
>       - WWAN Antenna type
> +     - Auxmac
>
>  A compatibility table by model and feature is maintained on the web
>  site, http://ibm-acpi.sf.net/. I appreciate any success or failure
> @@ -1511,6 +1512,25 @@ Currently 2 antenna types are supported as mention=
ed below:
>  The property is read-only. If the platform doesn't have support the sysf=
s
>  class is not created.
>
> +Auxmac
> +------
> +
> +sysfs: auxmac
> +
> +Some newer Thinkpads have a feature called MAC Address Pass-through. Thi=
s
> +feature is implemented by the system firmware to provide a system unique=
 MAC,
> +that can override a dock or USB ethernet dongle MAC, when connected to a
> +network. This property enables user-space to easily determine the MAC ad=
dress
> +if the feature is enabled.
> +
> +The values of this auxiliary MAC are:
> +
> +        cat /sys/devices/platform/thinkpad_acpi/auxmac
> +
> +If the feature is disabled, the value will be 'disabled'.
> +
> +This property is read-only.
> +
>  Adaptive keyboard
>  -----------------
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index d70c89d32..f430cc9ed 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,80 @@ static struct ibm_struct dprc_driver_data =3D {
>       .name =3D "dprc",
>  };
>
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * MAC Address Pass-through feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +#define AUXMAC_BEGIN_MARKER 8
> +#define AUXMAC_END_MARKER 21
> +
> +static char auxmac[AUXMAC_LEN + 1];
> +
> +static int auxmac_init(struct ibm_init_struct *iibm)
> +{
> +     acpi_status status;
> +     struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +     union acpi_object *obj;
> +
> +     status =3D acpi_evaluate_object(NULL, "\\MACA", NULL, &buffer);
> +
> +     if (ACPI_FAILURE(status))
> +             return -ENODEV;
> +
> +     obj =3D buffer.pointer;
> +
> +     if (obj->type !=3D ACPI_TYPE_STRING || obj->string.length !=3D AUXM=
AC_STRLEN) {
> +             pr_info("Invalid buffer for MAC address pass-through.\n");
> +             strscpy(auxmac, "unavailable", AUXMAC_LEN);
> +             goto auxmacinvalid;
> +     }
> +
> +     if (obj->string.pointer[AUXMAC_BEGIN_MARKER] !=3D '#' ||
> +         obj->string.pointer[AUXMAC_END_MARKER] !=3D '#') {
> +             pr_info("Invalid header for MAC address pass-through.\n");
> +             strscpy(auxmac, "unavailable", AUXMAC_LEN);
> +             goto auxmacinvalid;
> +     }
> +
> +     if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUX=
MAC_LEN) !=3D 0)
> +             strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_=
LEN + 1);

Okay, I wasn't expecting this change as this relies on the nul termination
by strscpy() since the original buffer does not have one but the #
character there. But I guess it isn't harmful either.

> +     else
> +             strscpy(auxmac, "disabled", AUXMAC_START);

AUXMAC_START is an offset ??? It should be AUXMAC_LEN.

> +
> +auxmacinvalid:
> +     kfree(obj);
> +     return 0;

I only now realized there are two gotos to auxmacinvalid. Therefore, I'd
do this instead:

free:
        kfree(obj);
        return 0;
auxmacinvalid:
        strscpy(auxmac, "unavailable", AUXMAC_LEN);
        goto free;

I'm sorry about my incorrect suggestion the last time.

> +}
> +
> +static struct ibm_struct auxmac_data =3D {
> +     .name =3D "auxmac",
> +};
> +
> +static ssize_t auxmac_show(struct device *dev,
> +                        struct device_attribute *attr,
> +                        char *buf)
> +{
> +     return sysfs_emit(buf, "%s\n", auxmac);
> +}
> +static DEVICE_ATTR_RO(auxmac);
> +
> +static struct attribute *auxmac_attributes[] =3D {
> +     &dev_attr_auxmac.attr,
> +     NULL
> +};
> +
> +static const struct attribute_group auxmac_attr_group =3D {
> +     .attrs =3D auxmac_attributes,
> +};
> +
>  /* ---------------------------------------------------------------------=
 */
>
>  static struct attribute *tpacpi_driver_attributes[] =3D {
> @@ -10843,6 +10917,7 @@ static const struct attribute_group *tpacpi_group=
s[] =3D {
>       &proxsensor_attr_group,
>       &kbdlang_attr_group,
>       &dprc_attr_group,
> +     &auxmac_attr_group,
>       NULL,
>  };
>
> @@ -11414,6 +11489,10 @@ static struct ibm_init_struct ibms_init[] __init=
data =3D {
>               .init =3D tpacpi_dprc_init,
>               .data =3D &dprc_driver_data,
>       },
> +     {
> +             .init =3D auxmac_init,
> +             .data =3D &auxmac_data,
> +     },
>  };
>
>  static int __init set_ibm_param(const char *val, const struct kernel_par=
am *kp)
>

--
 i.

