Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906AE7D541B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJXOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjJXOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:32:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1710C6;
        Tue, 24 Oct 2023 07:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TohdtvoqbaPdo7lm03H6YTU0nMHG4sJF8diW8SKIuqQs3bg7RmXnSnmgTdD/FDI9AZPRlZzW1YAUTHEPc3iNofAblriB+HQd+DbyjtrNd3IGSquO8kGwjPZSoseCQsxL/n0JnmJ0wxHcWNyqS9L+d0pjL0UnEN2fWbF0bOW4N6XQZD0T/tr4dF+POxiB9RhxDxM4vys8TFMUnk13kWvGfEptdgwix73kjGEV9cDJIVX2LKmQ/EXtwUxRTsH5T5ddAtjcFfjbR6A6QNxW5Vo9eGv5js7ZfwIPVyb7A53eSVHf3PDjzTzfuKKh6jWO4mtEb+BgqXEDvQYwO0sSvtgbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpVR8xkc2e+YdicUm6jUc+RMbsQHLlZSgDjS6yE13G0=;
 b=dc4qEU1jmWtwYL3xw26uCZOOGjkKbhmci1kY1PtE1NcybOvmU8TBVuzfPJvs1LGZNbQACaIGdm0K8PF8aXZDRpNA4Io+AiNGirPmnMcQCBCxhSH63bCTNAntcIXsyhcW+jVQtkozAeeWnqNlnCTnyzRs2bE8JzuYwE9aU5dYdVKBNe5dPKs7+Uqe6v9X/fj8rtiDbfX7s0pUa2jSE/Lce7XJlAcswHiaEK6mrM8OZAJg9UvPtVer4jPA5Jnu10RfDLGZ9KIdiZlHXpTVXM5l8qE4yFNJ0NkYWaF4Y4Ku6Jat+V1ve8eO0gQ8+VrP3wMdDEQojNkSJ9altnnCabaaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpVR8xkc2e+YdicUm6jUc+RMbsQHLlZSgDjS6yE13G0=;
 b=JmaK8SMwTQsMesbl3g9KTMdorU+/zhYkHRNUafGdOaeD6HkuMqdET9ThqW6qHm3AYjb3zd9kBOV9ZBxzWYU8QB8+n0l/iO9UMpnKrFKMClkDOd8hpvlkstQSNy9Ka5txUvCnpwEs/sh3EKbVy+s1RBVttoLHfPg9idBZOvapKb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 14:31:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 14:31:58 +0000
Date:   Tue, 24 Oct 2023 10:31:51 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <ZTfVV3DW8jqH6ek9@lizhi-Precision-Tower-5810>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
 <2023102105-outfit-legroom-1633@gregkh>
 <ZTaewidgtcDaBega@lizhi-Precision-Tower-5810>
 <2023102457-galore-uphill-4c84@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102457-galore-uphill-4c84@gregkh>
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c79291-c846-4ed2-1312-08dbd49dfa88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjAvqyHLvFgBXVSrQ1piMQD6ZH+ALYG60pNrm+aIs5AlshxPqVpdggfBDdGtywCQ7FyppEbVTJQl+49jhXKFQiVT6rbzN+ILgADiSWbUxQX2A2oGPWdi8LBywABP0NS3Knj3MMTM0xCfzUb/wXZE+un0EKEyKLUL04UMfcSnWJVKTUYuKQ2/8uDT+zfPq7FkVhuOT/uDi/VSPlxzELYz76oVQuzgs7Jl4wle6k4C75Z4ms77yG1QLq4smS3l7pzrYXPUQ7TfLRn3R9FHIRAfQUiW50Usf9WjG/andEg1/YTQVc5z7SvMKObo9WeRjyMliIdkUpbozzEcwsnEqbSL6BSsEicn4S+LupZ9SgYUmWxJs9PPE3WoZLh44krpLZJlLNyFxHs+HyjGiOCAA/2DwUgafegEzksy5E7o0CqRYO6iDA+mRp9zNtG5THCr7SbDF8RbqLyt214pAOZeMvbdBj9bIfTKHErqAe0Czud+bsYhqOHNZqbuCghtU98pfz2eDcdz5+Jkbdt032UK9gKLmU/pMLvQLHZntCn1ljQCE4zJDeL3cMC+6CiTCX9mziKaaVswNqV20ptTx5S4TLtjtKxbXHmp6Fm/WaXRLe5Q9Bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33716001)(26005)(38350700005)(66899024)(38100700002)(41300700001)(2906002)(86362001)(5660300002)(7416002)(66476007)(8936002)(8676002)(4326008)(478600001)(6506007)(6666004)(6916009)(316002)(66556008)(66946007)(83380400001)(966005)(6486002)(9686003)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkpLGo6clfAxAZCNsJVVib2T9uFKKHt1xcby+OgeEoTe8AWvxHseHABSuYRV?=
 =?us-ascii?Q?+OeKZQmw9vUg+HJM5Dzq+q7ptEAXP/nNnqQa8dMOnsj/6oYTtT6CkrelD590?=
 =?us-ascii?Q?rAXEoeEzundq29bhRf1YB3YKBmMwfxV9KgyKybN4+zHA+wDFvqTTxFIIcx7q?=
 =?us-ascii?Q?gSndmkBn+K2gVX0dcUTjKbdmGhLD3N/umCRy9goCYEd03t0hJ8kwzbHKY+qm?=
 =?us-ascii?Q?SQXMq3FCG2OCiRDYmRvLnUeHKOs1CwpWjE4VOqHHDELbUTRfKpq9R6yLVT7w?=
 =?us-ascii?Q?7sOEGtzc7IsN/gR3/op3/5oZL5MYNumOQUf+CWhKZXa2gG4YG0ESM9j8Ncyo?=
 =?us-ascii?Q?VindZ1p0xJDjXno/iXDvwSInfjT2FsANeejvE47To8pUzujo8Hg0Ln7AXEfK?=
 =?us-ascii?Q?KBmoaO+w6trtbG8M9Qbi9TDHckTJrrNClYA+GTLOB2HRNqvO5tRkma9Jmdfz?=
 =?us-ascii?Q?b++KZgkTh5vgOfisaRo/grj3MdLLJC1xgjM4XPUXnZpruYN1kYvXFM7xn7Ii?=
 =?us-ascii?Q?ckRjjsAM1cBdUw4Y2ZhcODWGNJMOxVF8JkPQDt8uSqTlab3MeNosxExKrV4G?=
 =?us-ascii?Q?/uS/M0jWJNUw7s8uo/tD2G9I5YQEPjw/oJB74Oi9FwySSecNDbharA6BeixM?=
 =?us-ascii?Q?wyyjtkR4MP/XgbcH1lgnw/huduvaGVnvxxht8eRfnDJVBPxuFLjTFvTTDsTL?=
 =?us-ascii?Q?D3dlZRen0gX8cRElOhWpIszjKimT73BYt9ZzwhRJdt/sdeF2Ej92h6YqfbR+?=
 =?us-ascii?Q?wgwZchU0Xg39ofBeIo6QGqw0VDkC5f+5jisKi2Wp8qlKbv2mnvdUvdu8sfhm?=
 =?us-ascii?Q?CSH5szHcEoJA8lVR5DSRsJNyS5yYzYS6vQEwFmgEBdw5dgwU5NctWsp04vf5?=
 =?us-ascii?Q?d7uvD10/JSfNrYPSpH8faPYvkWUNy6YxzEu1UdM5DAhkWor0fN51jQUMOCl1?=
 =?us-ascii?Q?wUwOijiAKxqyUvNhzlHCyIzhU0jTGFsp+m03uUaD2st0CxX6lNk28hF+bzrZ?=
 =?us-ascii?Q?BKLVkr1QEBK7s60Xi/zD0UFlLgp33fO5Q1eZoNTtymXoOO1YfspeTX5GeeYy?=
 =?us-ascii?Q?d4CvHSOj4AX9d4GTJr53ONVmOdXWapDxJ0fwa/iMvdL8fhzKxqTNV+RQiXUi?=
 =?us-ascii?Q?IybAtbmVflkDCmE86O61yDaqIdM/P97y8YbIiH+gAhyxxGFvLtJOPHbUbVff?=
 =?us-ascii?Q?/Ry3MoNDW3R3MsRbUA8Bi+H1v5PNzstdPB4RA9XUQ0iXrc2LTH3io14OGJzp?=
 =?us-ascii?Q?RX1I7f1+V7Od4F7orOCMqemZT8Ud86DAUmM+uhcb+tgDJYiEeeiuGMsCU1cY?=
 =?us-ascii?Q?9/N53ueu6dor+/o0hPYL2bsippgRCo85Hr5XvBQS++1+CgcAIBDFfVHae6Pq?=
 =?us-ascii?Q?Q2KXeBiSa/IlkdiU9o6oIapb9tKO+DspvOq4GHGP7ULdX6IwL1CqXTZDL47w?=
 =?us-ascii?Q?DxGyE2/LWuZEzauPaHWBp1src02tJIXBWpf9j6m5IMfT6eVDCD00d8I3lyAJ?=
 =?us-ascii?Q?Vdznv0cCUAmxlIY1kOp2z5lz94JaTaB/DSd5MOfJPYlgOkLzJPumXyFOYEKB?=
 =?us-ascii?Q?tix52faEEZXQQ8wkaZQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c79291-c846-4ed2-1312-08dbd49dfa88
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:31:58.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgPf7aIkpZ755OvT3RFjFcbMrUsVkwnKVSBJ0ED4zdq7q7Bvgd5/W1EA/BNCw55d7lGrdSGWTAToqjlTNgI4zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:30:33AM +0200, Greg KH wrote:
> On Mon, Oct 23, 2023 at 12:26:42PM -0400, Frank Li wrote:
> > On Sat, Oct 21, 2023 at 07:02:40PM +0200, Greg KH wrote:
> > > Note, your subject line needs to change.
> > > 
> > > On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> > > > In typical embedded Linux systems, UART consoles require at least two pins,
> > > > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > > > present, we can save these two pins by using this driver. Pins is crucial
> > > 
> > > "Pins are crucial"
> > > 
> > > > resources, especially in small chip packages.
> > > > 
> > > > This introduces support for using the I3C bus to transfer console tty data,
> > > > effectively replacing the need for dedicated UART pins. This not only
> > > > conserves valuable pin resources but also facilitates testing of I3C's
> > > > advanced features, including early termination, in-band interrupt (IBI)
> > > > support, and the creation of more complex data patterns. Additionally,
> > > > it aids in identifying and addressing issues within the I3C controller
> > > > driver.
> > > 
> > > But where is the serial data ending up at?  Not a normal uart, what is
> > > on the other end?  And do line settings mean anything here?
> > 
> > Currently, it use slave i3c code. 
> > https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t
> > 
> > idealy build an i3c->usb dongle to bride it to usb acm. 
> 
> So no one has built such a thing yet to determine if any of this works?

It is easy to proof concept by I3C slave code and USB gadget ACM, then pipe
two tty (ttyACM0 and ttySI3C0 together).

Of we also can implement a USB to I3C class standard, base on this, reuse
this tty driver at host side.

Frank

> 
> > > > +static DEFINE_IDR(i3c_tty_minors);
> > > > +static DEFINE_MUTEX(i3c_tty_minors_lock);
> > > 
> > > I thought idr didn't need a mutex anymore, are you sure this is still
> > > needed?
> > > 
> > > > +static struct tty_driver *i3c_tty_driver;
> > > > +
> > > > +#define I3C_TTY_MINORS		256
> > > 
> > > Do you really need 256 minors?
> > 
> > Any resource concern about it. Maybe 32/64 is enough. I refer from USB tty
> > driver.
> 
> USB serial devices are quite common, and in some places, replaced PCI
> serial cards for modem connections.  So for them, we do actually use all
> 256 minors.
> 
> But for this, it's a debugging device, how are you going to have so many
> different debugging ports on a system at once?
> 
> How about making it small, like 8, and see if you ever actually exceed
> that in real life?
> 
> thanks,
> 
> greg k-h
