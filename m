Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C277D3C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJWQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:26:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEE103;
        Mon, 23 Oct 2023 09:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt9Yxk0lp3mgV8btc8hcuurE9/D4As9q81PuGqwABEJl2zrwgUHsK7fF+2nEiWJvKtMv3CYgXH76lQFcMpaWwkAp0Mo/ljgk6oWpINmugetNgX4OsM+YMlo19shxzJ42KT3UZANExmc1nCJV6BIhcsn+OwL4bk3iA2IbgvT6i+4JOqSWskW1UG61mezBzGoTDFFgNB7Diy1lqOiuF3CGdbw5AJQlfW1cvCc7PXcLUZVedc2frY3GzfXuFzx3Ho+14y8wl8M7wq1prr7Wcz4TLbYUTNsE2J7L4SqCB3WT0JIpyJyqwOUfbE7GZNpfL4edjXpBwwhOMbrwEB0MJVW3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNriSgbWfsDlrOznGi8oZ22wlBYLGM/qSCvRLa5H0BA=;
 b=LlDZUtSR0EW3rDo9MNbxASm3CxV6YEePAxxWIHzJjOfSk0yxi5gjm/DS4bOQmit2kUGvqCrFkWUGgkSuziGs0LOqUa+nIO4SNAiuBRBCS5C38ZNyzRMwzL3mJdSR99J+m1quZxauyxbCOMOyKnaIhllJWlsTxZO6hYmZU2O/2HHxvc95NlnWG9Hpu1FPvx6V9Z0uw50iW1K7/O8Kkh8dsJPSX4LpUI+wkCyE5vuq37TTVkBXp8zSnjlg4HkOh0Ye0dYex+nWyqfW7A2uDQeup1Nl4qphAjmUktDZCguSlPMSGweXJuNt7PtiSrmcfqVDkJ2Gwa8/nzGIYYTsyJiX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNriSgbWfsDlrOznGi8oZ22wlBYLGM/qSCvRLa5H0BA=;
 b=M+m0aQ7JUaOkrJUpQEUlxVP7TmZdnv9EdM1ZSof8wCpQyDdtuiBe1FxCtggWFIVfot0XNGEYYm/eUz0SUwNN69ypeAkYY692rv+xF9CwVJ4QgCViPknWE85HI+CA3lAFV1whl9JlFwDyx4ZrfVxr0hhumZoDNMs489dJSfzdXHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Mon, 23 Oct
 2023 16:26:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:26:49 +0000
Date:   Mon, 23 Oct 2023 12:26:42 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <ZTaewidgtcDaBega@lizhi-Precision-Tower-5810>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
 <2023102105-outfit-legroom-1633@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102105-outfit-legroom-1633@gregkh>
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: a2121d68-0e80-4312-488a-08dbd3e4db78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F67xA/cmn4Ib+7Gv+OevsE/w1vOCTbJ1ciUfM/F8RTD0OMTod1foUxfmAtHTXPQUb6w10NCaHXP/R8lla+ksUsYm2tjeos9mAC2+av7VrowudJ3B2pDN+JMkNeRm4Qmltzpv4a5d//LdxtGtBVyp0hz6ziFH1YWQORAx4wkDZHiL/KwfjFSNCuWIcqQG7eTvIJJNlU36iBMDox6MhkvnWZRFOYIg0233H8yWul45TMKAmXBFBeTO7iGIpgrfZ4zgnQwOLelX+vlnOxQ4LYDrG5C7Lm0zk7xS9toCc90wa+IDZ3ib8oHIKY+zbPb/LrusEw0/ifXbzC0cboNWCzet7XCF79V5bC7JtrXvfEqNbxafwEius9caKmSYxiGfIEXfQfgQcCUOeg7FdIrCbzpPWYp4c5z2K+XswqXb4GjmQetgVH10blgalGDSK2rZVLEpMG1gpLlSCQ0MJxhDE5x3TIJQo4IXls2PgiMWGnlWNuWHu8IG+LFONlO44xdGOP4cSlToC3OACwQbZvNF/uiniUBu1SY/Cc0l+M8poc0zJa8Rxn+mEqLRrqn3vV0OC3fmrjEGJi2wWSRtAi97Au9R4ug4sv4SRox4TeLWor3kKK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(8676002)(8936002)(41300700001)(38350700005)(7416002)(2906002)(5660300002)(33716001)(66899024)(52116002)(83380400001)(6512007)(6666004)(9686003)(6506007)(86362001)(38100700002)(26005)(966005)(6486002)(478600001)(316002)(66556008)(66476007)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+C4XLABUK3EN9Yyb2aeBM8Vzj50ZawGclRVzhrC9B1f5JE/jNwxZMRZy+CX?=
 =?us-ascii?Q?G+yUdu293zluLcFUrDJoTVt+XUgJf2eggNgtFm6u2v5CL9P7X83gdmTIwiCH?=
 =?us-ascii?Q?SS/IMhmY+idzA+WTIhBBd5pLew5Ny1Wb32cTrv0yKLE2HjpexuqqP2VnDI1a?=
 =?us-ascii?Q?xyDy4Hj6HjxIaad/SyLNFaBqZy6c3c+4umtaWA7wp0dyRXmGFsxlrU8eoIyi?=
 =?us-ascii?Q?criUOZbsmG+3TLoldlAboyfqiAV1Wztecc4Hw4611ljZLGOiL6AowfjQ4O3B?=
 =?us-ascii?Q?ATPKdtp/y36whJI94tB2ZQc9+7jBkyL9JDCbSFAXA6cRbRA9GjdE1VDHuhza?=
 =?us-ascii?Q?44Ilx56tMHyIhXvD2ezHTvXhlemenrEbVSZdOUZxu2ZhWXPXqEKbl7H0IiBS?=
 =?us-ascii?Q?yRAcEhcGrEsk7eULFpD6YJWeNo/09GnE1CJ4gWuvwUgc+31MDWkmmPMRMql8?=
 =?us-ascii?Q?aHeYt3IZ96V9cswICAk7oIk4+jN2XqLpU/AS+Yr0ZwURf57CtFB6F3fc69tX?=
 =?us-ascii?Q?NCAk+ikVR8wwr3d1IQtNr47CvxeUuucfiUIzggW2MM1rSiHHcTl6jJBlYQBg?=
 =?us-ascii?Q?VkeaLvfW6NdhOoFUxqCOssnpD6gcfCHBhtL6oEAAXZm1BwUKA9jPoFrmdTeT?=
 =?us-ascii?Q?3Gwc+jB3S+avkQAGyBgwN6A5BoVpMjHb8j0O/jURGObpV7aSclvZWu9QAqw9?=
 =?us-ascii?Q?FCkrWSi4QOO+1dSjGtX9NcH82u13OJ/Wuw2oCiKR87TQJ13/0wF951XRGy8X?=
 =?us-ascii?Q?DU9UUvbJjfgeNa1w+RydaYlocwKfDDpnGP/YXeAzREdpOI1FzpvtO79qCSVm?=
 =?us-ascii?Q?UYxe0g5PYxSn7HMGmMDNBCjLepdbTavAxINMqldBXNhPJimg9VzorP8BxZfA?=
 =?us-ascii?Q?QbvOZMT+6hz79HFkI2SD3EfqbxB7S3gpPvqO1g/pxT5LYkfiFlKbZ6v7o0sB?=
 =?us-ascii?Q?A5Il7LDIqy+foaq4eAxsjBCvrw6LyPTZVjU1sLwVAGoBc5uzpgZQAccUJC5r?=
 =?us-ascii?Q?FTdQ0utiIie534SLQsWYOLdK4lr8balffggsPS29ShlEgM1TCLOtC2+4wmcC?=
 =?us-ascii?Q?VRswzA/q22L38h5YvnoE+Ol3UQdYdYEe0ix3fKXFqirtFJmrOC1T3KfDqXiD?=
 =?us-ascii?Q?W/hcUCl65MbiYwBDGLoC/H8q+AiGJnjrJBcCFxp1K2qTxUc6fCwmXOpC86eN?=
 =?us-ascii?Q?euEa01s6PGEz5aO27WDVv7IJb1qU51/yw/xgBopiD8b4Z5ocTr4/u40Z938s?=
 =?us-ascii?Q?dBAmEuxdN0eM5DCJ3UvBOmiXmICZ057s+LRRihYMGOBBV3WC9o/qbhnfFpF6?=
 =?us-ascii?Q?Gpy0dzd8nhbDWGpbiZGYkiWs78oKXRka3M9jsAZtVsMxONXY8qRoXba538Dn?=
 =?us-ascii?Q?6KI0Pgjm/hvEF9PQRuxaZZV2YalroAQdEf8XVYRCpPzEncULVdiX/cxx7KhN?=
 =?us-ascii?Q?Tu9r59Sr61cmXgmi0Rtypl6Atw/PTT0C5LTktnyp6YTRK173QwfDeq1MdmNE?=
 =?us-ascii?Q?P4gYXNYDPd4Kj1ZENwuj+qQPVdC2N7KZjGCXg3C1zJRsIbTgbLqZjDCVmQza?=
 =?us-ascii?Q?ZtcpeK42u59A3kIZ3O31QYSLWeIoeCPcPQ7rkwMd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2121d68-0e80-4312-488a-08dbd3e4db78
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:26:49.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9oUN8ZEYQ47hw0oVhWbtl6yK3SN8eyUv84euWs0tY2Rn34Ye6m1czCe2u6qluW9maatwe0+EW/7HlzG57wYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 07:02:40PM +0200, Greg KH wrote:
> Note, your subject line needs to change.
> 
> On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> > In typical embedded Linux systems, UART consoles require at least two pins,
> > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > present, we can save these two pins by using this driver. Pins is crucial
> 
> "Pins are crucial"
> 
> > resources, especially in small chip packages.
> > 
> > This introduces support for using the I3C bus to transfer console tty data,
> > effectively replacing the need for dedicated UART pins. This not only
> > conserves valuable pin resources but also facilitates testing of I3C's
> > advanced features, including early termination, in-band interrupt (IBI)
> > support, and the creation of more complex data patterns. Additionally,
> > it aids in identifying and addressing issues within the I3C controller
> > driver.
> 
> But where is the serial data ending up at?  Not a normal uart, what is
> on the other end?  And do line settings mean anything here?

Currently, it use slave i3c code. 
https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t

idealy build an i3c->usb dongle to bride it to usb acm. 

> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     This patch depend on
> >     https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t
> 
> Let's wait for those to be accepted first, right?

Yes.

> 
> > +static DEFINE_IDR(i3c_tty_minors);
> > +static DEFINE_MUTEX(i3c_tty_minors_lock);
> 
> I thought idr didn't need a mutex anymore, are you sure this is still
> needed?
> 
> > +static struct tty_driver *i3c_tty_driver;
> > +
> > +#define I3C_TTY_MINORS		256
> 
> Do you really need 256 minors?

Any resource concern about it. Maybe 32/64 is enough. I refer from USB tty
driver.

> 
> > +#define I3C_TTY_TRANS_SIZE	16
> > +#define I3C_TTY_RX_STOP		0
> > +#define I3C_TTY_RETRY		20
> > +#define I3C_TTY_YIELD_US	100
> > +
> > +struct ttyi3c_port {
> > +	struct tty_port port;
> > +	int minor;
> > +	spinlock_t xlock; /* protect xmit */
> > +	char tx_buff[I3C_TTY_TRANS_SIZE];
> > +	char rx_buff[I3C_TTY_TRANS_SIZE];
> > +	struct i3c_device *i3cdev;
> > +	struct work_struct txwork;
> > +	struct work_struct rxwork;
> > +	struct completion txcomplete;
> > +	unsigned long status;
> > +	int buf_overrun;
> 
> You set buf_overrun but never do anything with it.  Why care about it?
> 
> Other than these minor things, looks sane, nice work.
> 
> thanks,
> 
> greg k-h
