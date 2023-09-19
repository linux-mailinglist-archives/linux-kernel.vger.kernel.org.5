Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9567A6AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjISS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:59:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382C9D;
        Tue, 19 Sep 2023 11:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bff26qrDF7OPuNLe30wx2MNSaXACCBBa1mXGHxzzpOcjbdWF6u1TbkmNHao55ADW/OnGRaw2bNubl8P6ZcyWpCumtemkgzExyE8i/lQI1slVxBn8lOJReoMyiJvanFcSIFL2+Vx1iNOGZyU4s+6EezYynJQG36wXQc3B6+y+4K/i4qQWA64FOr2X47+Y/1DARumrCjoXuz85s3KtUzaPlXnetz+pxpH3SvCaWOULGZf33iMwhrjPtybEhJoOlD/PToE0u2TN/C+6S+zTl56GOBn3ua3LPDj5fJGuoU4ai0vTW59WWamjd7lN4vf0e9wMheEFWHCildDceu4xKa9wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L/LvZa3lhQu8DmTnCvOxnSS0+VDESut/93yjen0TG8=;
 b=MQRL5JObsJRdPODC5JKGnKVnBTOwcIWP0hLVojPYuiJJIcGzfUKmEX+2favJ+SxiH9R4oPlDX+lCJysZCFvwHtX+26nY8rKqrdz5OzfSYameBTXBlVsQ5z9TmpCAyhV1rwDOHgDqG5C2NEA1B1H5lZfJ7a0h4vnfSFbzDCifwtokfMCsnZceHkSyw3j9OyQrpX6/fvi+a/OmnbF8icOXQ0fAU9NS+jnNQcQrmhxguFIFUGelbuUHnhHX08/HV5vkjT65iO67ygkm1ganEiL+pb4AVTEI+GDs8Ns6Lgya2B+DZg8opuxlLeOnZsdr6H6N4m8N1lru2Tnff78P0kZx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L/LvZa3lhQu8DmTnCvOxnSS0+VDESut/93yjen0TG8=;
 b=jMKu2smWjDRsmqdRf4fZjylQvAT9bGBh2DO+jGvTjepkh6bOxMaqhl0tTkpJiStDv9DnfON35pyHBQH/OH2c5TH+ha/pyuyd8GZIZTTFOXpR/kse39bk26F7utSaZFUYrNShhvNt+CzOOIf3NFl/Cu67rs4Z9YwujSru1RnXlNM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 18:59:26 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:59:26 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Subject: RE: [PATCH net-next v6 2/3] net: axienet: Preparatory changes for
 dmaengine support
Thread-Topic: [PATCH net-next v6 2/3] net: axienet: Preparatory changes for
 dmaengine support
Thread-Index: AQHZ6mTYNT+5JdD7QUqVwrlgo2kFKLAh6SaAgACUgxA=
Date:   Tue, 19 Sep 2023 18:59:26 +0000
Message-ID: <MN0PR12MB595353238AA64CDEF04DB31DB7FAA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1695064615-3164315-3-git-send-email-radhey.shyam.pandey@amd.com>
 <ZQlvT7wIuxfvFLLL@shell.armlinux.org.uk>
In-Reply-To: <ZQlvT7wIuxfvFLLL@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MN0PR12MB6003:EE_
x-ms-office365-filtering-correlation-id: e25493e9-2b69-46cd-f5b2-08dbb9428b74
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRctnRAsILcJkW9FI1ffBY01rrgSo018BIK6iEV/D6yZi3kFvB7C0S4t6EuuuBAvzp1B4KrMtouU9QpjRD2R/5syPJb9xfMEC+QKK0PRBJbCBGucqGcO1LsJWuOIP0N/QUfhvG7CYO8PFuF6meJypz7vXJUUU928sjRwLW4BIiTVHc1RoaCU/OBWQ+Xe6tiY76LnqQ88exU4OBQIsEVgW+sthGx+Wc1hpL/d+MtvVXpCS3JXnR7RvMn1Ip0QpHRP69PIWv5KhgNAe8VQxO/62BLJ9Cic8Uk9NmkKZjmAE0aIxpEgw/vIzJcyokyxdnqrjat3IYqZHM313YQ/2iMANa+lnyzvczCBrZ6bmifBhQVyuPh4X5ncAEr8G3c2rpkNkJFc2oU0xDGQBfDMEbwtQac70T5S/BInZ/dZJcgClNUUsGYmeo/tDOMal2Gj70R4W8+nE9rSZCt8Sc9m3N2DmueyMJjCryt3uDbR21/pdy531bfKYPFkxzAB/Wx7uPBqnM050LWIAoWpDhrNayEGBkWCw1tZwhxaviV6E5EpnZW3PQr3f0zZsZiPHERkj+0HWJPjXxAPhJ/8nRGJepTAPJC5F9OwgCvv0Im6D/X05/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(1800799009)(186009)(451199024)(26005)(966005)(478600001)(2906002)(122000001)(71200400001)(6506007)(7696005)(53546011)(9686003)(7416002)(55016003)(33656002)(52536014)(5660300002)(4326008)(8936002)(66446008)(86362001)(66556008)(66946007)(76116006)(66476007)(41300700001)(316002)(64756008)(6916009)(83380400001)(54906003)(8676002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V13FSeUbq+XupXa/erfiZFlzmlmFstqqP19h4nOxJ8QosEkniGn3DlMCH6mx?=
 =?us-ascii?Q?ArKUbPEtgzNh4QlXmvwTz9DzYVmB8O57BZ8nbce5DJ0k2Mkfxb/NCA8RTAbZ?=
 =?us-ascii?Q?TB9qYcOmSHze2KhWjGY174p5d13MpL08+wPT0ZbpSnCC4sJbX5y6DJao63Zs?=
 =?us-ascii?Q?DMSSr7YxhHOGAwiiBWNpPrY7BzUHtMw/BlD9sbZ9tfqhkylWtgmdozdDjVfA?=
 =?us-ascii?Q?Wtx+4/uMU/m8OljuUMJ0lkmI1LWMhcWmpuJV0pPsGajZAbZsFkhRU4MUJ7X+?=
 =?us-ascii?Q?rFzgdCwOEhToC3STS/bT+mKFcbOaAepQqBO13/ADz2W2D7cQY9YdihtnQRkW?=
 =?us-ascii?Q?oxoljPuGbaQ1QnnLlso/cRDp4hSb3P5dI96pZcX3T+WerUY6Qw5rh71Efd1C?=
 =?us-ascii?Q?ja97kG5KBez4gQQ5ZKI1rZSfMQbN3leFoFpEilFHl6wUkpZ7QZigS2XqK2Cb?=
 =?us-ascii?Q?1HJ/zjeTJQsLteT2bA15clGnJrQDAM5FZt4NsrbaAh+Hf/yjGEvbz2RyQ5lg?=
 =?us-ascii?Q?xypv/rLqYkgm0vU4qOr79vUSrpQrFJYc9SlX3RUyX+B1E/V1DVywYUwlqG76?=
 =?us-ascii?Q?IgFizmsmdk4d9soPejNrF26FlyIlueE3knGTBSa6TMSPnP9evv1Ijvz13UT3?=
 =?us-ascii?Q?rzzosqK+ouYMol3evo9kZJagCUwy24AtkMWvtCyw+pu63lfvw2RdWVxYyuo1?=
 =?us-ascii?Q?C8ECrp5u8hAOofHe1qt4qZgf+sXqc88Ij8EMgBd26uWgIvhJDOWjus15clmf?=
 =?us-ascii?Q?J3uIqcA7HY5vAV7+rKkLkWxdn8VfR4p0fu1au0by/GKj1ab9S2MSSQgIWAHu?=
 =?us-ascii?Q?9kQu9VFVL5+If74aFblWySUcPTJ+CqdP+swGmYZ2RoNV5pj0PcawotHnecAQ?=
 =?us-ascii?Q?awRUKipCP8+QYJmYZYxFmbvbJeEyZei4eYwOdlFrgNTrOcP7M7JBc+ky+l8Q?=
 =?us-ascii?Q?JUVwJlcC/OCPYJWo+hofCDxPnBNoHpeA53hrOp0ewfsHTHcmNNWZfCevrDPk?=
 =?us-ascii?Q?v8VwKNg8c0opwYqcSv0cJZwdryXlFeviaLfvoclt5B8DZvblPXmHNWc8fvDA?=
 =?us-ascii?Q?B3gLBfhJc1wIiQnkwEqhD3sW1kqugiG8ovcXPnyJOG3FEaR97jLK44aAJYzH?=
 =?us-ascii?Q?dW4P1bOZLaBPvix6MMf1ltNG2QNxDV+BUYNuKD9r5a84MEiRmMc+ONXFmv9H?=
 =?us-ascii?Q?pcdQUdBpdvcYRSfhIpo8E1BSpscbhpBjzXzWdktuLMB6+QqPMLCClpHZDy97?=
 =?us-ascii?Q?BNY+USvyXohM7nVFJAAMl3JVykNsTGcVwuIZchhBpMX2AURhxuGBJP6tdRxo?=
 =?us-ascii?Q?s2aQisgS65pfqBVL1V/R7jkdwZqyOylc4fWr/q4oanA8rr5J/G8F+UpGk0xg?=
 =?us-ascii?Q?GvOtxnbJ0G+P/8KtPfuHphUdJDGd2RvmFTYDYP8vjYvnlCWde/r86LRiBTBM?=
 =?us-ascii?Q?igkbot2uOXmCgZktdiCUSHq8VZEIA6CWqeA7DOYWZ0pwlV99kY6DYJtFK57m?=
 =?us-ascii?Q?/gL4rB7N7Uiz9qsUBL95OYzzHTYYLoiQKi+jRQ0hEhJzHTFL9R2dqith9p0h?=
 =?us-ascii?Q?VBVap4VzTzkcq0L542Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25493e9-2b69-46cd-f5b2-08dbb9428b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 18:59:26.1403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IF5Pu7YYOlFv4iTfkEjazAuQrQOypZT0jE34zehwiL7/g4bVLHrMkWPqR5MLzTpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, September 19, 2023 3:22 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Sarath Babu
> Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> Subject: Re: [PATCH net-next v6 2/3] net: axienet: Preparatory changes fo=
r
> dmaengine support
>=20
> On Tue, Sep 19, 2023 at 12:46:54AM +0530, Radhey Shyam Pandey wrote:
> > +/**
> > + * axienet_open - Driver open routine.
> > + * @ndev:	Pointer to net_device structure
> > + *
> > + * Return: 0, on success.
> > + *	    non-zero error value on failure
> > + *
> > + * This is the driver open routine. It calls phylink_start to start
> > +the
> > + * PHY device.
> > + * It also allocates interrupt service routines, enables the
> > +interrupt lines
> > + * and ISR handling. Axi Ethernet core is reset through Axi DMA core.
> > +Buffer
> > + * descriptors are initialized.
> > + */
> > +static int axienet_open(struct net_device *ndev) {
> > +	int ret;
> > +	struct axienet_local *lp =3D netdev_priv(ndev);
> > +
> > +	dev_dbg(&ndev->dev, "%s\n", __func__);
> > +
> > +	/* When we do an Axi Ethernet reset, it resets the complete core
> > +	 * including the MDIO. MDIO must be disabled before resetting.
> > +	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
> > +	 */
> > +	axienet_lock_mii(lp);
> > +	ret =3D axienet_device_reset(ndev);
> > +	axienet_unlock_mii(lp);
> > +
> > +	ret =3D phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
> > +	if (ret) {
> > +		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n",
> ret);
> > +		return ret;
> > +	}
> > +
> > +	phylink_start(lp->phylink);
>=20
> ... and at this point, the link can come up while phylink_start() is comp=
leting.
> Could that cause a problem if this happens before:

This preparatory patch keeps same execution sequence and it only=20
creates wrapper around dma specific initialization. No functional
change.

There shouldn't be any problem if link come up while phylink_start is=20
completing. Packet will be processed only after dma initialization
(Interrupts are enabled) .=20

>=20
> > +
> > +	if (!lp->use_dmaengine) {
> > +		ret =3D axienet_init_legacy_dma(ndev);
> > +		if (ret)
> > +			goto error_code;
> > +	}
>=20
> ?
>=20
> I suppose I should add this statement to the phylink_start() documentatio=
n
> so that this point is clear for everyone.

Seems to be a good idea to capture it in documentation.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
