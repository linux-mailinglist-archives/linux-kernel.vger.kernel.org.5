Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7B7FF8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbjK3Rto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbjK3Rtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:49:42 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E83131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0G1it12798AOUyS8bp9DmAwOa30s4mFUpIfujGOwBb3//iKkOlFXkS4itJOlEtlz8TZ00NYM8gG2FrLZDfoZvUjyWvEll0u3lxdqvC2vAZU+Lx6DO3kjjvJY7ltAd7ZaPgGp3KcHObeivg0XkG46ZBjLX8vIKPWwea/T0YCppBQ1FXF/SEGqcQlJU5h462etwM5hPRUC84315q5Mrfvg5Y95FwO6kVXlUQN20/VDj5WjMKGtdbpdsBrskpYqqY6gZZPR8lx9gh7x8r7GC0dbllGOYtps+UYtHvPbzM+7B6D2obPyDURvYGsdiWmUXWunt5M5tnD7Qo9me5DLWtrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUmrYChD3Yj1/EfwsCjO14HatpNVJFTX7pKDLxrC8UE=;
 b=L7MOsr+ZhEyPPJ3+LsgIVj4aOeHFWh0dG5AnMoE6Kv9+oP7Qet9BVREaVwDXNc3W+642nNEnCEbg8aClNnFQa4cVI3J5q3Maai0vReue+X5jeqTYeto2ZOULTgiBQ1HMqwSKVoDDedOIBcdRgRXF4fjhTXntc8xeoVHX9Nor787RVlElspYyrfFX7udAi3axwJIEaTV67GiGaonxP8Lk/FU31sQouX8/mFykj5mVeoCDyGBiSTw/wDpVGO3yMsbwVIC55ARVgR1mOW7qeeOedJXhGQ7nvXMC9/N1BYNokrT9RaD2UyEoXsy041KZKPzPQo5kImXYz7lMpIKNdsaT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUmrYChD3Yj1/EfwsCjO14HatpNVJFTX7pKDLxrC8UE=;
 b=OU5++U0zNiwcSxr/Xv9JftMJw34sBQ/lj2PKzV3gBLAG/78n0wdK3FAtuTDy6y0fJUvdZQO6g4RCR+v8StZscipUS9ChRul3b2J0IiJTEQvm6ftPrKeZCa+DJy+rxeKevbORovGUpFM72KZNazgtWdM238s7ZznXJpCyXNnzPsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 17:49:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 17:49:44 +0000
Date:   Thu, 30 Nov 2023 12:49:36 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 6/6] i3c: add API i3c_dev_gettstatus_format1() to get
 target device status
Message-ID: <ZWjLMNKJElPI6uSo@lizhi-Precision-Tower-5810>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
 <20231129221225.387952-7-Frank.Li@nxp.com>
 <20231130111959.11afd8a8@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130111959.11afd8a8@xps-13>
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: fe51f2b1-ff88-4c06-e3ad-08dbf1ccbcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoeE+LSMBhw1J4ReEEnvl9XTzJJoOLIXSRxc7JzIwKgRWJkcUty3xweV86DiGI+jYihOqXFvSRXMXE1TUsqHdfEPxifSClJXv1laFBR37GoxjxB3JAIwK/1eNCLHzxtXPsAXtIABQViY/erbny2ftn5h0zT5PE0kX5whsKOdwvombyqeEWTGINQhKlA3oP5ylmqLgQVQ6GgzICYbjOZSQ9KeiX50NC6YwCkCRypmmMHJadIJcqQlpKgnWVEtBDnibtg36KUtnQ+1SO09fHKldaY2lrThtLHl5wbIHO0JglcE03vlyd0pzaUPRswZbGr8nfDZZwplQwhpc8LCHzXdOYOufZmKUvG8+N61jEfu6tGuQ8G5B2DGKoD7bgY5ldJjzLHgNBruFJ81Z8H6iZ7+A+ZSV3c2W7aoU4Ngrl1Z74dJEJ8sE1KT1oGMi1SoujnooaG+eqkR9/90y3Yv42RqxaGsxka8mSWGrXWDmYEABPqVDaztsitF7GV+UWvHcLwA8JPzh0333pDqGUSZkcl/YnmglKRScBVyUjLbvj/+sGX5xAkEBZnJjeBPPNqtuzTFXd1AJuRXmfGM3At9kHDlBL7fTyPp0nP/uSMOIiDVk7aZwMYV9qdWrNs3LVBVYGAo/r09d1NU8mOEJsYmFTNE4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(366004)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66574015)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(83380400001)(5660300002)(33716001)(2906002)(478600001)(41300700001)(316002)(6486002)(966005)(4326008)(8676002)(66946007)(66556008)(8936002)(6916009)(66476007)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?T60r+vYoWkdS7Hm4dZA0h3nOL2aEcPkEaiv6rUI3T7BjNmyQrtN4bRAmDA?=
 =?iso-8859-1?Q?/gX+D0OBm+XEEce5i3yhKqhfcGixhyOtnft5Au9DzdgOUS5W9z0bg33d2Y?=
 =?iso-8859-1?Q?/2BQ4A997R0MSfNmmY7cQ/TgpOga9brV94hJu5I5q728GDu190RC0el6Cp?=
 =?iso-8859-1?Q?5vX6FCuor23Kc9h47YalJ0MNVlV9i3TiYBvg/OQRn7WZWM2/DtgY6VRtGZ?=
 =?iso-8859-1?Q?t6j8kRFc/WTdIbHGo37Ow1cttVKVAxfQM1JO0swD4gSLzvSNm7qYcs0Tz0?=
 =?iso-8859-1?Q?mRhxBiZHmqZVC/lR/MlxMqmPRlfUa6rzlXILHIQOkfyePKBbhA1wyvPaWH?=
 =?iso-8859-1?Q?WhLdkTkvI3js+ABIRopEGvwb2e+xk/MJ+8f4Gf3BmZkjt3nypf9LEjrb7q?=
 =?iso-8859-1?Q?NfPMZ3YJ25AqWclWHt9+GX2x/MDMUsOq/J+ayWKI1gh1SY9VNj2+xRbeah?=
 =?iso-8859-1?Q?GKI7IyZm/IsVaUyGgRzYA/NRrmOoii2TNGfqzAlEbO0udlzksYuUZBW2yd?=
 =?iso-8859-1?Q?xPPZZnzu2iDX6+Ia6GybHTmoKSNZMOgjIcfe9Kz4Wdv4KEEQc1E1/D8dT6?=
 =?iso-8859-1?Q?DBp2gRJF6tOSbx1Bwfq/diL5O3ta1C/Ve1qP1nWo8Y/ts/jCOM+QlO4WH9?=
 =?iso-8859-1?Q?vmhSKrNX4ap1M5NGU3BLgTgOEzBtHkxqC3M9AlZb6TCPxys+PBWnps0zrz?=
 =?iso-8859-1?Q?vvtxOrLB/kw/zDfdG7yXMWahEWwWbPXNBSe7xnTSTZg9CeVxhOY1ecEPsY?=
 =?iso-8859-1?Q?+0WLrkG6a9kZPjVSQjOywTv0D6AgbC/hH4MTW4867LVenJIpjkcSjQBUAy?=
 =?iso-8859-1?Q?8KM4vFM9IumhsY4qT/fZBtbCg6tDyVEQ/k1K7xoF4UUDYHUI2qK1oPa+rd?=
 =?iso-8859-1?Q?fZKqyVYBhxDorZ5/pbsOdklnatpAvqGs4ZMvI2FO+R3ETdOya6tGISedY2?=
 =?iso-8859-1?Q?wkoEBmVloGbQKg/MbA/ErEiQNDS5pr8c4n/8mmckOXcOHBo0nkTagBXjmx?=
 =?iso-8859-1?Q?N8XjVAFL21gAaBGqQuH7vNWwoZq7DvLWg/AUh8sXs3plWfu7cXODtx/7D3?=
 =?iso-8859-1?Q?czA0DtPMm7uiPAJYjSZhf2q+3QeNmSq/LBZaUHhe6n+/8/ZFjJzQFF78Fd?=
 =?iso-8859-1?Q?vJ9loNxCx77QzHJJuD4pq2CjEwb3GSxdoUCVUHcPW28IGlbUOjVZ0sT3F6?=
 =?iso-8859-1?Q?O6l9bJ+xbdZl1vAA6ibLm90DiwKAl8CcITtrCUZ/lkJVO697z1ILpREXOH?=
 =?iso-8859-1?Q?8M2C49iw4poczeYnH3y8Fa5EaK84mi09W8tlXo58PzRG1KpjUf8bjB2HkA?=
 =?iso-8859-1?Q?mq7QBQ2hqyuE/vhxzN/f33rLu5OqxY5EXEeZQ4sk3rotyS+OGyZjcYhBgO?=
 =?iso-8859-1?Q?rqZeKcPt3KOQoZstUn5GpJ5F4qooqB9o3gIJ04n3996X480TVuQjnGiv4L?=
 =?iso-8859-1?Q?/GAEDfInp0tkXKX5Pi8qjn2vRyAVKfkLxbG+siQVruF26nNV8KHZbTk2Bz?=
 =?iso-8859-1?Q?QQ6UCw8HP1dy7KTfn2PqjGdherxZyq+sY/pbfDXyfYtQhRAdGEW9DfjTJx?=
 =?iso-8859-1?Q?RnolSUMnLQCT0ugURTFeCfrSQHZjzA+vVNg2ihdor3mhASWSeHdIwE3Q8e?=
 =?iso-8859-1?Q?waB3V7ZLzzynCGyFs/LVWsP4w3pQ085pfp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe51f2b1-ff88-4c06-e3ad-08dbf1ccbcb6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 17:49:44.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/6hwoQbLskpZPkoWebFCn81pX719dvKdCvmvIhPvYyqXJITY/rcK4i+qqDN+eTn2oLq2GZWSd535miyyrbOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:19:59AM +0100, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:25 -0500:
> 
> > I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
> > Get request for one I3C Target Device to return its current status.
> > 
> > Add API to fetch it with format1.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
> >  drivers/i3c/internals.h    |  1 +
> >  drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
> >  include/linux/i3c/device.h |  1 +
> >  4 files changed, 52 insertions(+)
> > 
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > index 1a6a8703dbc3a..aa26cf50ab9c6 100644
> > --- a/drivers/i3c/device.c
> > +++ b/drivers/i3c/device.c
> > @@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
> >  
> > +/**
> > + * i3c_device_getstatus_format1() - Get device status with format 1.
> > + * @dev: device for which you want to get status.
> > + * @status: I3C status format 1
> > + *
> > + * Return: 0 in case of success, a negative error core otherwise.
> > + */
> > +int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
> 
> I'm not a big fan of the opposition between "i3c_device" and "i3c_dev".
> Could we clarify the prefixes?

look likes:
	Internal API between device/master/ use i3c_dev
	External API for I3C target device use i3c_device
> 
> > +{
> > +	int ret = -EINVAL;
> 
> Init not useful
> 
> > +
> > +	if (!status)
> > +		return -EINVAL;
> > +
> > +	i3c_bus_normaluse_lock(dev->bus);
> > +	if (dev->desc)
> > +		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
> > +
> > +	i3c_bus_normaluse_unlock(dev->bus);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
> 
> There is no user yet. Maybe this needs to be done in another series?
> Same below.

See
https://lore.kernel.org/imx/202311070330.5mylauLR-lkp@intel.com/T/#t

> 
> ...
> 
> > +int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
> 
> ...
> 
> Thanks,
> Miquèl
