Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB076FF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHDLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:11:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EE9B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOq2PDvqc8XjcXFZMxve0tarM2Mofo3PsqR9rgKgT+RLegagMqqozkgFWzLnBLcuSDP4qxy8sXmx2FKv4rydL188JHdGW1bdOcMjClD8jAe0DgJmj2nLVdZYrvYCX7KuN9R34I7rDtlgGjkXo6hIQIcG9p/YWWMtTh7KGKnWoLyf00X6IR3eW/f+NF0QwNF4ujHxoKhxuFGRnMWXCgrllo0csbRjKwrJ4oCo0XO04qjp7Yw/ltvcm1FlXBe7SVQxo/7PSCvMHzyaLNFLEfP9J8msv0rmU141QuMOAQ65Q0jSAViPiJ1cVaitU4ToQGuvlEsKBAJQwFA+ivxGqsQkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7EXjW3tq9XFHBiBzY7ZxJmdfQFuk7riMXvVFDX5K/Q=;
 b=CRRaIAmezMgFg/eUGJ+0Gcm8Zv9+pQ1aRZjV77NJkwQofAUvYzcO5nlq2VilvKjps30C6Cr42Ii4UU43YnJ5cUyl0oyspIG9Eed5hpz00+GbDPk00sG5hEX0cIDhtqgK+OB30Qjuk1BSZkrTokTCUDGSQVyqdVcoo6sGZyRes+bSoMhng0dNoPgyEHrkc7IuEf2a3NergNW+ZfqK1fmoTRvHJAAtJzJxEA5VXz+4K5/w4l9MUKrWSVvdBhdxD6okR6UAyoOrO2/bT/IX1Iqwi7IRBzSzivjm+XR43Xi843kPG4fe5aRwjY/XRjtdyBGqkpo+qsduPnp3t+GAfd/qiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7EXjW3tq9XFHBiBzY7ZxJmdfQFuk7riMXvVFDX5K/Q=;
 b=rZ8LYuKp24TwXS2IHgHEVWXGCKvk7UzbizsWAFlV3hADP1gDx0EdYOklMF1yQsNlkaUdvzAh2OlBvlLvUd4lVfQDmM5ZrQ5lkP//cNW1kBtgvDIzwqSVH23LqvAivuUkjpxpJ4B5mANwMZDAUK76pgwjvODhKmsKcKmgdum8sbM=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 4 Aug 2023 11:11:40 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b%5]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 11:11:39 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Thread-Topic: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Thread-Index: AQHZw6fpekS7+sewHkWP9KKMIHa4dK/TzKGAgAEccwCAADdNAIABuRcggAAODACAAxdqsA==
Date:   Fri, 4 Aug 2023 11:11:39 +0000
Message-ID: <DM4PR12MB7765E06A3B9B911559FA6BBB8F09A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
 <2023073148-carried-unshaved-77e4@gregkh>
 <DM4PR12MB7765398763E00B565AB1C6DB8F0AA@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023080105-eggnog-probably-9ff3@gregkh>
 <DM4PR12MB7765B6284FD9BC113C8482FC8F0BA@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023080233-nag-animal-a905@gregkh>
In-Reply-To: <2023080233-nag-animal-a905@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=d194fa3a-3953-4d8b-90b6-5e221e112df3;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-08-04T11:09:53Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|DM4PR12MB6010:EE_
x-ms-office365-filtering-correlation-id: 2099cf64-8251-45d6-5397-08db94db9390
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uR7FnQ2m6VZwykY5WnSTqG1T3VG/NfxfJ3LpHrzFOCuzMAC5PZ7aJX5OGpRsCo1HMza54l8ChGZdmdKKZgDZloFqDcJQjXEm6q0mTpqeJ8vKepW9Xv+uR3ZuY4MuapGG7Q7LDHU919EWvZ093cPcbH9z1nT2ty5osHZ+WEQUeAfkeM/C43DdswGt6X8FQLrb6XEolyMUqHcNfZDEGaswGHgcCzHQ9xuqL3IdL2D7zw2qokTjpC6pZ3cltNdGSMjMMrhuigEXe0XSNsWjEF2jgCRKzdfM8xwrRYy9abkZCMmZyW3xF7xIzchlYnwBB5mR+x+q7JLWO1XCgR2vNYjIve9eY/RMd+52jCpIW0ERhCAH0DNyinqN5mxWweBJi9rKomVCejsO6J4AUGHr7AHTSIEGYg3k99lJf2s99ATtIaYmX2K1TAn46UeGkFB9hvDK1eseRGaWGos6F8ud23+yYzeZppw1kwQsJUiQOudTi6Ny7G5S8iZo5QQlo4c6vQYEwmu/Jqve15zyypkUOse9+8lUkNegzPNvn69LYP05GmQ/Tkiiel+FAfAQnF7gTRYlWNzqcJX1jKyiG1jnoDQUrM0xDsusW/IdDrbSvx9Mlye7v5XiaWHa2946j7sMUt8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(6506007)(26005)(53546011)(83380400001)(8936002)(41300700001)(9686003)(6916009)(2906002)(76116006)(5660300002)(66946007)(66446008)(64756008)(52536014)(66556008)(66476007)(316002)(4326008)(8676002)(7696005)(71200400001)(478600001)(54906003)(122000001)(38100700002)(55016003)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NSJfgwMVDgBWFFi+TIK9T4ECnYX3R5EoH9TUfGYpLaA+u+kVDIBtQ8n4KQ9Z?=
 =?us-ascii?Q?7SyHy2Bt2Xm/6MbnOhBpxkD7KYbaLY9is1o9WEg58+GQy86aLApBjPzRX7lu?=
 =?us-ascii?Q?BwGM7yo77Sq0zBZLg/wH4/itdwIcaJxvwWTr01qC5UP+/uRTSakTc0XWf03q?=
 =?us-ascii?Q?CqINBVNl6/7K1AIP6AAxTDq7TtRVtctpW7/FwYE/ruDqkI5D4i2s4Stm0m6/?=
 =?us-ascii?Q?i+CNXLWv7ax2hEyGvqiEyUj5Fehz3N5+izdGf57KtaOcj+Dj/0IsdHNXkR/2?=
 =?us-ascii?Q?379OtVhe8EpbUDSR4F6BzL+d4MIka91X+bkK96tbu8Fncjuoj7jdl3STV16f?=
 =?us-ascii?Q?CmBAqOAfYNXmMG1Pj0hb9KqWAS35WCk1yUNgukGUWTTgIZiVqOIMm+/X3k+d?=
 =?us-ascii?Q?f/HvPDZCZqVATmDlnfLGO5yPhon33UBQU5NxMCH+m+l3sYBKb8aVflzbxjBm?=
 =?us-ascii?Q?TnrIMxlnfNDX8EwUMa5H0HYxU28paN6QEX3eZ7LetSBLvBa5ddhayWFCIEqD?=
 =?us-ascii?Q?l3JKjTg2zAwGUnPuQ9SgDSHIs9cFscvCH0hjKd/depQPibWZSQnqX+krMDfU?=
 =?us-ascii?Q?Vk7p5rCi1YjDP8qyfXwUiCMHRULlj854MJhfSUYNt+MYAXktoUn+8JtqGk8C?=
 =?us-ascii?Q?YPDhRitjj7oev7VJutRPsgEBySM4qu0FtJ/n/qtzrnDGJ1PIykVrzAo14Xji?=
 =?us-ascii?Q?+92GR2CUJxngsXxyyQ/hY2FxUzSUYhe919M8WGcnZrW5RLX6RWsD7ptvAQn6?=
 =?us-ascii?Q?Ca/jgGbwGa3mmmBtFBrF9lU6cEQm49UOzEd/3/9BYmYIlh5SvOyy2Mp7Ounn?=
 =?us-ascii?Q?zrRFAe3X8AfC2vfgmbqB2qqw/OxjJKZ+mLtQrVDA7ETwR4w/z/4efAd8h1Yz?=
 =?us-ascii?Q?epsuFgob8sLMD+v7/ZpsvO5YDZBT7zwz1S/uu/oghfFzXpdjgFLy3usVfT9H?=
 =?us-ascii?Q?2adHpG8eF+4lIy/KLPD6lk9B0bQU4oyaFLUL1lSZGzwMGLFJ7OwTFQjnvGpW?=
 =?us-ascii?Q?nslThj7fp74dXevjs5ghS1yBttgsT624jc0LiC0DNt1/Sn52KUROialE99J2?=
 =?us-ascii?Q?M9eNTYNaqn574HkyVgwF2cyziuHoCRScyC54uvIhSBTQBJn39QsmwLjkmPmr?=
 =?us-ascii?Q?PSQo5BGtUaaJBMH9XV75fHDE1OxPbK4w6uA/04E0Rlc3zokPil834GqED2Xj?=
 =?us-ascii?Q?ckcs3DJFckzlY2ooYyXXIQJwS+Gyrztg55G3CIJJepS9AAxBABsspulYSPhg?=
 =?us-ascii?Q?FtONovI76nHMgfpEGVCYZzTx506jXV8QqLGi9x/fnSCaFYPm/+H7lIhwdL2y?=
 =?us-ascii?Q?MdeF/RrOBqmoeb1yZQZH/Pi/7QOdr/1q9GIPQxchtp+l3B3RxI55dOfYoXlv?=
 =?us-ascii?Q?EkpgAG4jFGWkUY/LZAJFLyJXkkmlk62d/qEFTlvUmRElwNgFWIK4hZ/StWJO?=
 =?us-ascii?Q?bcf99cfQHzkaSL6tiDB3idQdHx9X5UjiMoe8F+VYYcbZZIOYAfbwIcnLnFSV?=
 =?us-ascii?Q?YYTd8BhrvaoobLtFb/4UDOL9X8BBAN5XnLWrjta39gwoqkfxdj+pFJT/VcBT?=
 =?us-ascii?Q?lEUkhamZauOvS/0MXIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2099cf64-8251-45d6-5397-08db94db9390
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 11:11:39.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNbKZuraHc7/zmsJunwi6kmQcLjCuAOZhl3YWYQBuurSeTIoKFDUL56yCO3Hv+QtVxdotRcL1Aw6Oz7ebJF3ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 02, 2023 at 11:20:17AM +0000, Gangurde, Abhijit wrote:
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Monday, July 31, 2023 5:55 PM
> > > > > To: Gangurde, Abhijit <abhijit.gangurde@amd.com>
> > > > > Cc: masahiroy@kernel.org; linux-kernel@vger.kernel.org; Simek, Mi=
chal
> > > > > <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Agarwal,
> > > Nikhil
> > > > > <nikhil.agarwal@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> > > > > Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect contro=
ller
> ops
> > > and
> > > > > controller list
> > > > >
> > > > > On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> > > > > > Add a mutex lock to prevent race between controller ops initiat=
ed by
> > > > > > the bus subsystem and the controller registration/unregistratio=
n.
> > > > > >
> > > > > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > > > > ---
> > > > > >  drivers/cdx/cdx.c | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > > > > index d2cad4c670a0..66797c8fe400 100644
> > > > > > --- a/drivers/cdx/cdx.c
> > > > > > +++ b/drivers/cdx/cdx.c
> > > > > > @@ -72,6 +72,8 @@
> > > > > >
> > > > > >  /* CDX controllers registered with the CDX bus */
> > > > > >  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > > > > > +/* Lock to protect controller ops and controller list */
> > > > > > +static DEFINE_MUTEX(cdx_controller_lock);
> > > > >
> > > > > Wait, why do you have a local list and not just rely on the list =
the
> > > > > driver core has for you already?  Isn't this a duplicate list whe=
re you
> > > > > have objects on two different lists with a lifespan controlled on=
ly by
> > > > > one of them?
> > > >
> > > > cdx_controllers list is holding just the controllers registered on =
the cdx bus
> > > system.
> > >
> > > Which are devices on the bus, so why do you need a separate list?
> > >
> > > > CDX devices are still maintained by driver core list. Controller li=
st is used
> by
> > > rescan
> > > > which triggers rescan on all the controllers.
> > >
> > > Again, why a separate list?  The driver core already tracks these,
> > > right?
> >
> > As of now, cdx controllers are platform devices and maintained on
> cdx_controllers list.
>=20
> Oh, that's not ok.  Please do NOT abuse platform devices for things that
> are not actually platform devices.  Make them real devices on a real
> bus.
>=20
> > CDX controller devices are not added on cdx bus. IIUC, you mean to use
> driver core
> > list to find out different cdx controllers, in that case cdx bus would =
need to
> scan
> > platform bus and access the private data of platform device to get a
> cdx_controller ops.
> > IMHO, that would not be a right approach.
>=20
> If these are actually real patform devices, then yes, that's the correct
> thing to do.
>=20
> Or you can create a cdx controller device and add that to the device
> tree, that's usually the way "controller" devices work (look at USB host
> controllers as one example.)

Thank you for the suggestion. CDX controller is already in the device tree =
as
a platform device. We are weighing both the options right now and would
send the changes accordingly in next spin.

Thanks,
Abhijit

>=20
> > Or as an alternative cdx controller could be added on cdx bus as well. =
And we
> can then
> > get these controllers from driver core list.
>=20
> Yes, that can work too, but don't keep them outside of the driver model,
> that will not work well over time, as you can see here already.
>=20
> thanks,
>=20
> greg k-h
