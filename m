Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28607AF325
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjIZSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:42:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2095.outbound.protection.outlook.com [40.107.92.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E0AE5;
        Tue, 26 Sep 2023 11:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mufl069ULE2w32obhr7mO0RG1oT6X2OF6U/VFEyZjlte++DbZcw01LibphNezrdZU35O9ScBkOB3W19XskJFMVQTSdS9tV0+BA1rVH4n+Lng3Kf1uOth4fZZrth0knGkBtmmaBTpkmdpuKbwxHXePgZ+gVLwJJVFV6+Xcppi5PDjBFGIn+Ccq7rC5u/jQdRtEZIphv5kU2tkezfxOaKiGQD3dAq0mFudUpGEPToguPKr4fymYOq7AL9BBcTCFCMTMxCHqW+Flfh4r1o9Mc6xuq47/Aa2FVRIrAR4dSCWmZwnWjQCWINVQNrHGRi/42zxeOPMlgh/UgU3BnfDqe1I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4e/XmDpJrT+WF9lKCJtLc/M4HMpURdN1BbcGTw1Cn8=;
 b=UuZiN0VcfavK2JU5Snw39AzBRyKAkhphJls8Ph/gjuxNwnwJuh1VXsUqPPsf1B7TGxCCGcdAeEsP9oFCyQ5ofhUaYiXY/ylGWA7bV2XBtCNZTLbwX/TJJx0nvpwT5KIDTcQTO7hMfLanpqUFKY60jcfUW+0BtGBEJL8ripkWDbuptKgixLXE/RMHpz40IJABUl/+R3U1eVRQs7KjMVCXcRvjwWJ1gXRvrnqKFqbew8XHyo3/R5/pkY5Z2nyZbmTN6HRJn8Z+ZUWoIjL4OJSKANGnWBISlSpAAWnE98ipM/P54bGgNNpV26Kx+G+14rK+71/iLsqDCQ00eVwcYTIU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4e/XmDpJrT+WF9lKCJtLc/M4HMpURdN1BbcGTw1Cn8=;
 b=W7DK5u9Ysh+hSNv2Ygm4qw06OsVBiY3HHpHQ71YXulORwzfggDXozVjcG272VXVAQYapzAmnRiKSEHaw9OWZw6m9JFfValkVW5L97Ha2woURlcHtPv/SzKL3hV0iJ6es07FWcNuvge9wHI3N+y8/Su+DITWt83B8NJIum+SIysM=
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPUP152MB4490.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 18:42:30 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 18:42:30 +0000
From:   "Fernando Eckhardt Valle (FIPT)" <fevalle@ipt.br>
To:     Hans de Goede <hdegoede@redhat.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Thread-Topic: [PATCH v5] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
Thread-Index: AQHZ79/+E+J0iJxDUkiNrl4nNsE1O7As5yuAgACJ0DI=
Date:   Tue, 26 Sep 2023 18:42:30 +0000
Message-ID: <CPVP152MB50532B5F8BBAC92243930842D8C3A@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
References: <20230925184133.6735-1-fevalle@ipt.br>
 <0efd719a-802d-1401-7cee-d3918b47441d@redhat.com>
In-Reply-To: <0efd719a-802d-1401-7cee-d3918b47441d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPVP152MB5053:EE_|CPUP152MB4490:EE_
x-ms-office365-filtering-correlation-id: 1f9d175a-f6f6-4784-ef75-08dbbec056e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kd+KlD9wAat09f+JAlzBe9cDNsCIp3l8Mmm6o0KV8mbEaEJgal5BV25I1QCX2ov6WCCm3CTZ3MJYClt9DEVUiefJyTAQ1/HMjEn5P5hobQ+yj7gYi3SprVZXg00nfh+EC1zToZMFTeKajHecA2zblyIpvlTNuENiBCNQjFpXzjjnQZX60H7C1LdMHnNfyXXtWiOG/dl9Bp7RBoh7URziOAt0Qdw04r31JSVa0LGeDtF6MxkrzF7GcMi9y/uhSvvc9q58zfROxXQvYk8+ksgqnmhLZhiBniXHNnricNCOnPe597AGHMF7V8aN50oQeYW1unHhSL8et5ihlVYiqOdndXZEidejeQI4+ZoZkezggDY/FALFDM6xGhmoZE9um89hA/4c8T02W6gTmfKOChcyIbgoFoyVjE1HTxgSfoE3WRKWjUVu0tphynHLl6uZiY8UNEensyMjBmDnGGAOWdinpxU6YKTynl4kJy6vaHYoJepByHnd0SWwC8+1QX0RURk8FHLzDyVhWbKK8uqRG+eyRvd2J5T0G6yx+x3HPEVhtfUwfSciiFq+5roETVgPSwBberDKqvVIB6134vukGZqeJXf/OinodZaTy1tEHJagEJE7XSiYnG4mxaGAEsvRivCY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39850400004)(230922051799003)(186009)(1800799009)(451199024)(8936002)(8676002)(966005)(2906002)(83380400001)(52536014)(7696005)(9686003)(55016003)(53546011)(66446008)(76116006)(64756008)(66946007)(786003)(316002)(66476007)(66556008)(86362001)(110136005)(38100700002)(38070700005)(26005)(122000001)(921005)(41300700001)(7416002)(5660300002)(41320700001)(478600001)(6506007)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z4RZDyWgFJ6lf6liD6ySJEQK3KBRzW3u036t8nOJ8z1PHtM4paisbp2RaD0S?=
 =?us-ascii?Q?7i1Eu+MD83TUw2UN75gnYNjdwFk8/JbZ78PnM6ze7Nz7eIMcOkRDcBCXctb/?=
 =?us-ascii?Q?0Hbaz1iSNHoGdakJzHlvmzVqio6Dh9zR10nvH6DCt/b8E7NjMShUcUXmVCFI?=
 =?us-ascii?Q?oQL/iFAPCdp+JiPi/ZaJQMRQFgX+LVlCNiAU3tdXaBQewTQsZlTDvV39DOlB?=
 =?us-ascii?Q?Mj6C5j3/qG9PSnyA/W23CSNdd1bVAjhPQhL09v0YWw5b7leQKdRk4utgk+9S?=
 =?us-ascii?Q?GCpc6UXVMk+5TCZG5BPybMRD57OvGTc8YlnScnobUvVvvwe39JKMpfHXjTrd?=
 =?us-ascii?Q?sBodKauI3Jw1+FJNcp4mf/BGv7KQobpr18Fe5zrvs7vym0tP6WCoCmLWpjyc?=
 =?us-ascii?Q?a/1p4/aKrqTWWeWSpjrG+kfQzrdK1joBLXJr+MXICBUpX5AmSugt/IzbfbZq?=
 =?us-ascii?Q?fxWxDJjTVldgMzCp2jptd1qUDsOPvjmjAVGn+J5ibVpedNoddxlgQIBwaIYn?=
 =?us-ascii?Q?YGskLckaixoZUIofewpO20jqCP5U3IiL6DROPm+HD7tJ/WlFQXtzpknYyB9N?=
 =?us-ascii?Q?lGdaIvr3CDL1GAhOoET729goZesIQltlAR0prlKgKYoGOxcAlrRp1wHX6HVe?=
 =?us-ascii?Q?KmgFPT5G6DIrlyoXYFhVFAXPKoHQiYVnl+sjEZHvsnXFIwfZ99LOxQtl8r9k?=
 =?us-ascii?Q?Knc7NeFlY2uB4rMm22j1m/qctugCTTI8oK5xaAO1gKzaFmmTyOhyPuEP1QPA?=
 =?us-ascii?Q?aNpxIsXc0Yj9uAiAfzKMloCMHdGJV2hvYXp1ATqwOQd+UGXaIM4frOHc+MKK?=
 =?us-ascii?Q?xPOyQx2uEBgsQoNRD2usKKTu/EQJZNv0HSdqEes+kFgZBe7ztVp9yVdI6OZ7?=
 =?us-ascii?Q?dDeKsbaq3q3YHcu4o+jq4OaD9ADS56nZysynF3Z3wP6WXQheCYcOxKe91ydq?=
 =?us-ascii?Q?/eVGvcw+wobVdl+MlElFFx+oqGphwITktMZC9+myXV5SAZx8yQBYSiJiJyqo?=
 =?us-ascii?Q?f+4HlXUBNzNBjTCkbGqdf1kRBKxZT+opsz/B4i/C6Vmdn4F1w/X00Q2xyhZd?=
 =?us-ascii?Q?hYxxxPbXnX9ZLJhOgxw24sFTbEBqBBHLdWr+Bdgtsp3FcXsSjknBI5Y4LJnK?=
 =?us-ascii?Q?ymCpi7qJsePR8Ih+etQ5B5T3iZZoAOfmA0zvhFiR99qPjXaZgQJNTQ/89o+C?=
 =?us-ascii?Q?tgrOd7DAvH59qphNN+SY51NQfe6q8N70ZsdiWRxWMjKiY0jxCNK4GnmnUUrC?=
 =?us-ascii?Q?IooSzj9DVjQIFmrj01CBFTPl901rMGZp8CzPMlch5CrsxBdncBgeohLvQjH1?=
 =?us-ascii?Q?RyQ3VtG2o3XDJDug6OBODGHE0usAqp+Em9upXGNO1xpGbHkgVA1avZqNbxDi?=
 =?us-ascii?Q?5OCkESe75Mdf6oGNuwGYFxw4iMtQyMJseE3lTEXVs80keR4sLO55/i6h0MSf?=
 =?us-ascii?Q?4OqQIlFeSUEPJ8EwD13QjPdRQYeKFdeJ5DqRAU1mJTSnG1g1KWJPJdZrzDiB?=
 =?us-ascii?Q?IHU/2rEsrNls136aF9c6K2d35Z1EfgAAhBxJEo/UTLG0XjGKtj0K7EatzVBR?=
 =?us-ascii?Q?zsl7E67TAtmVv+WQBco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9d175a-f6f6-4784-ef75-08dbbec056e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 18:42:30.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N14MFgdhthrayVtcj1UHug7xyGPTkGnSSSfYsDqYQYFUtoE0hAbaB5rNxWrcfqga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPUP152MB4490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Hans, I'll send a new version with some adjustments.

> Note this is just a preference you keen keep this as is
> if you want,
I liked the Ilpo suggestion, with two 'gotos' is eliminated repeated code. =
If everything is ok, I prefer it this way.

Regards,
Fernando Valle

________________________________________
From: Hans de Goede <hdegoede@redhat.com>
Sent: Tuesday, September 26, 2023 7:23 AM
To: Fernando Eckhardt Valle (FIPT); ilpo.jarvinen@linux.intel.com; mpearson=
-lenovo@squebb.ca; corbet@lwn.net; hmh@hmh.eng.br; markgross@kernel.org; li=
nux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; ibm-acpi-devel@lists=
.sourceforge.net; platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: thinkpad_acpi: sysfs interface to aux=
mac

Hi,

It looks like I just reviewed an old version, reviewing this version now ..=
.

On 9/25/23 20:41, Fernando Eckhardt Valle wrote:
> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
>
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
> Changes in v5:
> - Repeated code deleted.
> - Adjusted offset of a strscpy().
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
>  drivers/platform/x86/thinkpad_acpi.c          | 81 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
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
> index d70c89d32..2324ebb46 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,82 @@ static struct ibm_struct dprc_driver_data =3D {
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

In this code path you don't initialize the "auxmac" buffer at all,
but your auxmac_attr_group does not have an is_visible callback,
so the auxmax sysfs attr will still show up.

Please add an is_visible callback and retuern 0 (not visible)
when auxmac[0] =3D=3D 0; See existing is_visible code for some
examples.

> +
> +     obj =3D buffer.pointer;
> +
> +     if (obj->type !=3D ACPI_TYPE_STRING || obj->string.length !=3D AUXM=
AC_STRLEN) {
> +             pr_info("Invalid buffer for MAC address pass-through.\n");
> +             goto auxmacinvalid;
> +     }
> +
> +     if (obj->string.pointer[AUXMAC_BEGIN_MARKER] !=3D '#' ||
> +         obj->string.pointer[AUXMAC_END_MARKER] !=3D '#') {
> +             pr_info("Invalid header for MAC address pass-through.\n");
> +             goto auxmacinvalid;
> +     }
> +
> +     if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUX=
MAC_LEN) !=3D 0)
> +             strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_=
LEN + 1);

Please use sizeof(auxmac) as last parameter to strscpy() here.

> +     else
> +             strscpy(auxmac, "disabled", AUXMAC_LEN);

Please use sizeof(auxmac) as last parameter to strscpy() here.

Also note how you pass 2 different dest-sizes for the same dest buffer befo=
re,
which looks weird ...


> +
> +free:
> +     kfree(obj);
> +     return 0;
> +
> +auxmacinvalid:
> +     strscpy(auxmac, "unavailable", AUXMAC_LEN);
> +     goto free;
> +}

I'm not liking the goto dance here, I would prefer:

        kfree(obj);
        return 0;

auxmacinvalid:
        strscpy(auxmac, "unavailable", AUXMAC_LEN);
        kfree(obj);
        return 0;

It is quite normal for an error-exit path to repeat a kfree().

Note this is just a preference you keen keep this as is
if you want, but to me the goto free which jumps up looks
pretty weird.

Regards,

Hans



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
> @@ -10843,6 +10919,7 @@ static const struct attribute_group *tpacpi_group=
s[] =3D {
>       &proxsensor_attr_group,
>       &kbdlang_attr_group,
>       &dprc_attr_group,
> +     &auxmac_attr_group,
>       NULL,
>  };
>
> @@ -11414,6 +11491,10 @@ static struct ibm_init_struct ibms_init[] __init=
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


