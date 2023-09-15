Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBB7A24FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjIORjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjIORjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:39:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF3AF;
        Fri, 15 Sep 2023 10:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKNVbWmaj8Hl03cNmYdWTkcmYT2g2RZx4k2QuZnQ6ZE1KjPFZ9x6WZF5kB+4gJzREDoiQ9ksJR3kAtB3hqqmFl0Q8J0krR+vqRhi3vaR3rlmaB8YTz61Ln2p75pawz1A3t7KvVBo6y3rVlnyBWgZXV8sP1v3cUlgQFg8Btk2ShlUpOgDpEW02qxc1ij0u0Ob8cQ6wggPZHlQfFyiwnw3Wiyl57YyIidl4TFnihy3zwEzMLDh6X10a9CiWJR1apNWGISewfNAF0idiim28L+/evGMPhHIwi2DnoY0PIOfHFNdfjsYKkfUymzFImGM+C0Zxa6zSo59ZJ5UfotqietiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad69eWqebGzoZ/XhXSofnWmCNj9Rw6K1G48Iwv7/QN0=;
 b=afc24yOQOCMBMh31vQivR/iG/2ImWXN7gvlDpfls5fdSmdti65SehqvnbItmVPgFyAXDKwmtFhMuYNs+6AFj4wrbWMMGWJ4ZmGsBjdOVqxJwdmU9Fk+CEr7SbfAQza8XXzv1AWdUrIVJb+kiTWacPtgMuoUS6YJEqh6g56oA72q8l738adXeY7UU5wFVskjOw3/QLLBI39o3rE8o2xvpUj17qnRFzmUGeh+lsEdIhX376MzPGCNGm7YIMosPHhRnv49+D9SKZurKg1ujb926fIzFtv4yZh/Ufo+Va1oCKXcqrD7Cqwq385C9L2FTB+dEa5oBCBVviF0ukTDCDWeedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad69eWqebGzoZ/XhXSofnWmCNj9Rw6K1G48Iwv7/QN0=;
 b=nSAkLzxuqxB408TWUagMQvBcoF4OI6frCk1JRCnP4JFrf9eqLKIy9jiOUm2tRXs6daBwANFGbc8MucUFtD1v1bUioJ18+XPJ/vQ6z8iggqUc8q6Thgc6zyRZ6dlIdOVxIJzWqbuHIZFSOGe5nunaLR1n/Iw/Q5NGxXUNOViukcc=
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPTP152MB4021.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 17:37:07 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900%5]) with mapi id 15.20.6792.022; Fri, 15 Sep 2023
 17:37:07 +0000
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
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Thread-Topic: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
Thread-Index: AQHZ59CaSQnXyzGu5kOvVCsmuGo3R7AcEOeAgAAVh/U=
Date:   Fri, 15 Sep 2023 17:37:07 +0000
Message-ID: <CPVP152MB5053F04E4D2525CC339EA80CD8F6A@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
References: <20230915123136.4286-1-fevalle@ipt.br>
 <97ac516a-5d9f-f58d-2313-d7d3453f58cb@linux.intel.com>
In-Reply-To: <97ac516a-5d9f-f58d-2313-d7d3453f58cb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPVP152MB5053:EE_|CPTP152MB4021:EE_
x-ms-office365-filtering-correlation-id: 64613ca3-f140-41ab-b1bb-08dbb61261de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTnKwOiZiLxMhSLpabN2gMJ0ogDcWum8K6rp9yE6ihrHSeWXIIVWWoZlX1obshX5B4AWtc+E+Agw4m4m5AFJU4BRtl/NKtx1HZQuX+trVh+5nbR53yMjXcpK633F8CdZ+Jw9IHJi+SIn60HMhF/wCpRQ6fQDBfqItjFqsMICaA0OwtrOA5zdaJy/+wuC/8/Dw5ExmLgFGOJk44GY3uoF3zJ3f9EsnJsFQwkFU8MhemqmXSV4FSiSWQU2bGEovvoDM7N9rirqy5tcw5U+B9C5sLZn+b4Pa01TmwfVoABSI6HHlAllLur4LT1YyPbQcPM+X1LKzj4YToaVRkS2xcxRniGWknFMJe0h8TN+GgRMB0GrXVCFTV5Dz/+w0XHniaOn4t9QrG5H8NNljYKd/E1OzrVM9TVgD0bdTn2U4uPMU+08AaUdIeNfFddP/DwiwSKib6aMHDxrpHkTKcbeRKkHrIIdlo4Efi5btQ83pPymyiEgncNBoaPbevi/ycALKFmydmUVPU6Z9K6BYjNG3BRbfH9jzegWjsOW/Qrt/6lE0wD3vt88Wb5qyjyohfTZuwQZlIdBIcqt84HRIinghdVi9h1p3b/ziJqI9nKkms2Lz+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39850400004)(451199024)(186009)(1800799009)(6506007)(7696005)(71200400001)(53546011)(122000001)(86362001)(66946007)(9686003)(2906002)(76116006)(66556008)(83380400001)(38100700002)(38070700005)(66574015)(33656002)(966005)(478600001)(7416002)(41320700001)(5660300002)(52536014)(54906003)(66476007)(64756008)(66446008)(6916009)(786003)(4326008)(316002)(8936002)(8676002)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5oYqETnYdlm4th0jNzgpp2vUvUuRnLZZeT4urVP6k916Kk7zHGbmcxA9Xn?=
 =?iso-8859-1?Q?N3sw5xGrZb1ZdWIdViQ/qbWZN3y9gfBp4Zttqx4uxi2GKVcxUMXkiNf5so?=
 =?iso-8859-1?Q?5aexMAT6qR1F8zmcUuan7mYdcMjn3gquQIyW/E8DYFGimUnZSep/+LLZbL?=
 =?iso-8859-1?Q?nEo5qjlnijhZpJl/vec5IxHYg4B82YMhlNrRpQs3RW/1B/Sj5G48i4BsQl?=
 =?iso-8859-1?Q?qkckH66P1tyZXczHYvwU/0rJ0eob83DAzANPVlN7kZ2x2VirHv9MD4/jP9?=
 =?iso-8859-1?Q?h4XD8w15S2AVtXjYzG8oc5mhaaPkObwdJ/UuTtrTbH3MfL3pKceQ+OLPB0?=
 =?iso-8859-1?Q?9yG/wrobh0vH6Af7ulX7x/jodQ2AMaxej7E+SDX4lWCA3MZiPv3XSt4okI?=
 =?iso-8859-1?Q?iLUDtTHgnqecOYlz3eYswQDyDr34Dc0uhTm0ENmI4NEunpuTLtq2UJL+5I?=
 =?iso-8859-1?Q?LYiF88IWxwGfuSjlcnfol/s2m2A9gCJm8h8rQ3OoDixT1SIOxqy7JDjsYB?=
 =?iso-8859-1?Q?q0KA/Mh9bZ68YLAEbH15VpKnNcRZjWKBAivUY71NEW+c5nhg+H7yMKeL1Z?=
 =?iso-8859-1?Q?aNz4XFEd9VWGnt2syrI9HOzvEmYNT+V05WCtuUZLynyZdDEFR9EbT+cT7H?=
 =?iso-8859-1?Q?cIWDyuvwyr+pMDmUnn5Ca0zkgW9zHILKDQtOKhC+e6RK5buRMViDhPX7AR?=
 =?iso-8859-1?Q?9nfe+2YnYHwUDkOjXuA52FlhIyeCS8amAkww8gPJVdkzXIezpwBRJEav8w?=
 =?iso-8859-1?Q?IVK0UUJ8vArC9Zx9sbZvIm6rAZUAyqMUS7HKT8kDBuQe3OUONBdz5LqSqo?=
 =?iso-8859-1?Q?L6gdNQzT9nrzx0nR+MajTZDu/ZCycsPbPiDhEprdIR/bunUWp6nw/eExGv?=
 =?iso-8859-1?Q?9Uob5ulbAHnXC+JWx+DYv4nipCAOSgzQKB9/FinaOBs6jHxfpmEE6rq47M?=
 =?iso-8859-1?Q?qM9q2ypZJ8ynRYjuR0LH4bjLJczl0Dg6hFnzm+VqIxmGEwraIJN2EXY4Lv?=
 =?iso-8859-1?Q?DKNE99/JovhTXuIHLTKiCmf/GxFkUCi6zY5uRHf8+o0JunPxeRqaKEWgGT?=
 =?iso-8859-1?Q?T7f50C4iOXBLi5tMKnv2ZMShn+ry09MF1JjEGvKDU3F3uLSnqJCNxbgFns?=
 =?iso-8859-1?Q?u35j0EgBodKXXwg6YfLr6onE+YczKoXH+iB0VwJSyXnYLiG2xwLt/6PWZw?=
 =?iso-8859-1?Q?VQVCwaKMrEJEFPeo5FSsQebV4Q0RNJId1VhDtb7VcxOF5NpRF3ZIrxqELI?=
 =?iso-8859-1?Q?qjsecSLiti1PelwajDtdkbaZLuxdwrYb/ktmVHnGRTZ+zJ+qakpHuu2ndg?=
 =?iso-8859-1?Q?I0eGpEE5jv2rngivV3ZQoR/sDl7Zwo7WFmfVj7zlKIafOlbt/ES4pemS5k?=
 =?iso-8859-1?Q?aruEheCEJ0AkqT1thYnr88WOhfv6Axy94TZzqaGnef75p53EtmdivtYFjb?=
 =?iso-8859-1?Q?fZwwYrqupUAWejAZYG1yEKyKbpw5IRZz+fgkHF+nc7crniQdopMbkkKTA7?=
 =?iso-8859-1?Q?PqhXDUU727w4lw81oztzq6zyY0/zf2vnoWxILdKPOo9CEp1KOcoLJkU4hs?=
 =?iso-8859-1?Q?i/+V0r6KiLaMSZz/8tJoaeA2+/UossNtTnRclWcE2D2SdTDVwGW6sheSgV?=
 =?iso-8859-1?Q?M8r6MANF5HwvccicPLRzqe3+2BDJYk4vdx2ps6CcHR9zuyDyII+/P7ZJRO?=
 =?iso-8859-1?Q?5s7C6HxipLbgrBaSNkU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64613ca3-f140-41ab-b1bb-08dbb61261de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 17:37:07.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNQt6b8BIFb8J+HDJpv2sNrlR0Cd318dn79WgQPHOaedDbIgac1H8pF534NkIbgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPTP152MB4021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Ilpo, I will do a v3 with your feedback.

Regards,
Fernando.

________________________________________
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Sent: Friday, September 15, 2023 1:18 PM
To: Fernando Eckhardt Valle (FIPT)
Cc: Hans de Goede; Mark Pearson; corbet@lwn.net; hmh@hmh.eng.br; markgross@=
kernel.org; linux-doc@vger.kernel.org; LKML; ibm-acpi-devel@lists.sourcefor=
ge.net; platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to aux=
mac

On Fri, 15 Sep 2023, Fernando Eckhardt Valle wrote:

> Newer Thinkpads have a feature called Mac Address Passthrough.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
>
> Changes in v2:
> - Added documentation
> - All handling of the auxmac value is done in the _init function.
>
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 78 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Docume=
ntation/admin-guide/laptops/thinkpad-acpi.rst
> index e27a1c3f6..6207c363f 100644
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
> +Some newer Thinkpads have a feature called MAC Address Passthrough. This
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
> index d70c89d32..05cc3a1e2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,79 @@ static struct ibm_struct dprc_driver_data =3D {
>       .name =3D "dprc",
>  };
>
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * Mac Address Passthrough feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +static char auxmac[AUXMAC_LEN];
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
> +     obj =3D (union acpi_object *)buffer.pointer;
> +
> +     if (obj->type !=3D ACPI_TYPE_STRING || obj->string.length !=3D AUXM=
AC_STRLEN) {
> +             pr_info("Invalid buffer for mac addr passthrough.\n");

MAC address

> +             goto auxmacinvalid;
> +     }
> +
> +     if (strncmp(obj->string.pointer + 0x8, "#", 1) !=3D 0 ||
> +         strncmp(obj->string.pointer + 0x15, "#", 1) !=3D 0) {

Why use strncmp with (..., 1)? These offsets should defines above and not
use literals.

> +             pr_info("Invalid header for mac addr passthrough.\n");

MAC address

> +             goto auxmacinvalid;
> +     }
> +
> +     if (strncmp(obj->string.pointer + 0x9, "XXXXXXXXXXXX", AUXMAC_LEN) =
=3D=3D 0)

Why you're not using AUXMAC_START here?

It's also bit confusing that some of the offset are hex and some non-hex
numbers.

> +             memcpy(auxmac, "disabled", 9);

Don't use memcpy() for copying a string.

> +     else
> +             memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_L=
EN);

What about the termination of auxmac? It's given

> +
> +     kfree(obj);
> +     return 0;
> +
> +auxmacinvalid:
> +     kfree(obj);
> +     memcpy(auxmac, "unavailable", 11);

Again, don't use memcpy() to copy a string. You even got it wrong here
compared with the other case where you copied also the zero terminator.

> +     return 0;
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

This requires proper termination for the string but you didn't ensure it
above.

--
 i.

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
> @@ -10843,6 +10916,7 @@ static const struct attribute_group *tpacpi_group=
s[] =3D {
>       &proxsensor_attr_group,
>       &kbdlang_attr_group,
>       &dprc_attr_group,
> +     &auxmac_attr_group,
>       NULL,
>  };
>
> @@ -11414,6 +11488,10 @@ static struct ibm_init_struct ibms_init[] __init=
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

