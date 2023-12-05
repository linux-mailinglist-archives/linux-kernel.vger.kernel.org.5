Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C5805BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442514AbjLEPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442441AbjLEPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:50:56 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE05BA;
        Tue,  5 Dec 2023 07:50:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy40NzvjrcX4+vtDR+vO+v3eLuLeCBGCiMTaFwoB2HJ58CD7oWs9ENi35mZSfvwRDTB0K+Zu0fhJVLjbsDS3mvSQLG3ueuDPAHF6Rmfv6wBiuIWyZn5pWCbB6iNhmUcfT+wK1lwi0hlX7/wNBHE/+y0SwR+aH2jE0IUeC8PdQY45lV3GxlQCLMr3sX5qzF7v5LRSw4tQGvjpQJ+avPOhs5kgDoFerdbjcYHPrQFMKLqNd4A9u02ykUMIO4PmW+QgYMUGiibgs6joa8+wEX1/OqzHolioRsVLanhMIuQhYvfAkvUVSHrxoMfcNiaw6yTLrAp1bcqoffWnDzbRbC+wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h22YibGG9SQL9IqkVgyOROIE9QYCIwTjO7vog9j7Xl0=;
 b=m15kcc6JUwjITthIWuf+LwmAUrkRr/2uoGZdpo+NbSSMG99Xua6V2LTgJyY33m+i7/lCB/Lhow7bEKwOx/iW+DzCCHrN2nXRG9fYZ+iS6iVZHsqNfAgLghQffgwbtIXQ9RiWgovZhq+3a+hGUZg//sVtkrxVsk4njSbiAH+8qRroOyOvfJ1AoVFXqUz+EvBHv/tmYBu51Bpf/qQkXKQQgH0hp3v6r1InHtjvxPyhWMUTy79RKYzuStKroceGzv/Ftok+L70To4Xjwzfi1EA/yKevSPU1rOmDfFxU/m95FFDOSCWlIMiyx6AKJQZjTtX+cCyfn0AVuitN86KanO7ZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h22YibGG9SQL9IqkVgyOROIE9QYCIwTjO7vog9j7Xl0=;
 b=siv2SY+kSB37NHSJXdvBzhmj6BItLXqIo+WDZxVM+A0sBb1JU1R9Px4GZeljVXTrdj56PN6ebrW8GXPRqmkmJX61N0I/qQgvdzJ7D7OKoapwQ36tT66cfG1UfRYLt7S43g2CaODRMvPYQQ9qTuoElRgoLwvdWasc5l5+r8gF+hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8786.eurprd04.prod.outlook.com (2603:10a6:20b:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23; Tue, 5 Dec
 2023 15:50:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Tue, 5 Dec 2023
 15:50:56 +0000
Date:   Tue, 5 Dec 2023 10:50:46 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 7/7] tty: i3c: add TTY over I3C master support
Message-ID: <ZW9G1qVlYOS2TQ+l@lizhi-Precision-Tower-5810>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
 <20231130224408.3591288-8-Frank.Li@nxp.com>
 <2c3824d7-0960-4de7-8fae-01478fdef8fe@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3824d7-0960-4de7-8fae-01478fdef8fe@kernel.org>
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 836ceedf-0a24-4f8f-589d-08dbf5a9f7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olNSxbpTRVD3I68MQHzA0XCtVTpgEZKt2QGJjAH4EEUOUibpP9X694pf8QzOLOzfKNs62moh77dIN3tZrqDyKSpYMrkvBkR4VXLpmxzzAoBtq0xAGvRwbK6hHsgYgYv1aYIHyPSwGZ9M5lgfp/UEbqxywPDCQbIONPRA+basvi337bNyhnj+k6rsTORtOmh+LvDzuc2WOxIsfNUL4npzINC6ZC+LOmTxLfNwfiKYLXvqAZHEIyLZEraM4Uxa2FbcN5Jgaj3VlaDJAjqbUujoxEBJZ2h5Z7HVkbET8yneePW4E1sgpgVNSP+muaXY7PcmhvHLT1HlVYjP3/YP4Tf4LkYjSeFlyfS7K7TP6iW6wtPBSF3EFbQWV8l03HTH1nRxR8o8tJhnR62BPKg4yQRsAvAJhZ6X2lXmtMkxhVLFmyki8sdcgcL4dos/qPbDidCNfF35+XgW2DgfVJRcRHnDruqtx6kvp4gBRX0iQFSrfYL7LEiBWhwrIA2Ukr7Y1vTyICfj1XBRgI1b1A7haOyWUk0EpIvgnGrC/NPp5dFj4+fWCyMK7lUz4TnfvF+cyHtaiLc941/zwqDgJ1+GZMqM5+2Om5w18ZzbcVnLrIKYYMRKhnjKIvpZp/3C+mdaJyoSxqGCg7tOqpC3b8KmRQ0hIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(26005)(6506007)(52116002)(6512007)(9686003)(6666004)(38100700002)(478600001)(316002)(66946007)(83380400001)(66556008)(66476007)(6916009)(4326008)(7416002)(8936002)(8676002)(2906002)(86362001)(33716001)(38350700005)(41300700001)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrYb1r9Um8UYMunMk1BXFXRzRwdCjG/KvATvBASyBqZAP9mnqWcl63AjMz8y?=
 =?us-ascii?Q?9pQm/spUFmXnfKZpQijoYWp8GaqlEBsi1wCSDdr6pHe35cjmkQkTDI1IuxeE?=
 =?us-ascii?Q?PjPRvel48AORHmf9fE01o8IH/FwAkVoZosCYI6H/Yvmkgn9LtDlTt7BJAkMn?=
 =?us-ascii?Q?2eKIv0j/+bTKi7ulAOWa0TxSOSwuY7pzNpVg3Yn8cjPIFQdC4JoXq/4+V4vA?=
 =?us-ascii?Q?Oz0YtXifIQNhQTZ1WkuAx3MywxxUF6f9NNqATjDmUzwcw8D+Fos/7DV9QhYH?=
 =?us-ascii?Q?TymH7KC9Rh2d7CjhHcvL8+q5nw5ER2aXXYdzZ0qrV18mHSASnwAm6VEKGgwJ?=
 =?us-ascii?Q?x8+5PF7zUXUOxtYZRhNjYxtv8if1cW/pCI1mUHiSK3ghZiOciPTApDNUbYSP?=
 =?us-ascii?Q?eYjgFULfh7LV8+91fwPOa2acvP87nZAF5uA6aHy/bcdbilamJIEEufVKxnck?=
 =?us-ascii?Q?q8XcNDULV0MXuV/aGDnpf0WuYrVgZ5i1itwj86Fw2Y+DUZcbTvFOqpmfh3yd?=
 =?us-ascii?Q?vWrh57FF/X2e+TS9Q6kFboz1ZVq7ByC0xA92TctSIxdWm/vYZyXsfUWrhyvv?=
 =?us-ascii?Q?9LiXiUq4nZOieXm7HnZ92UI8RAriuthffGr9CEkwyvEgus/YuQ53EXDjg1vG?=
 =?us-ascii?Q?ws14AsmncM8ShEJ24jPiQi2I0cGUQkHqe1qeU4KZqqqmjXsfnTzZBC/SDsGA?=
 =?us-ascii?Q?A6ZhwYg5dd/S+A3T2312Avau6j4OgWHRcpU9qzc9KUrIPJvIOoAj5fmc9s0s?=
 =?us-ascii?Q?bwqwJtYpv3ddxj9F9trO/HiyO1VVcQVNYYlnSMZGAoMVeTfMiWfLOyCkO/z2?=
 =?us-ascii?Q?+HFkSXcOqj7U42KkL4uSalFVbtnIQIqIsZh5WqRkKYgmp5+HkVnR0RXZI48G?=
 =?us-ascii?Q?6x7PHZhZ8fljhg6IstZaQNqLJaERQ+AETsB5drU4oqBcQQV9sAgdOUWmIlmO?=
 =?us-ascii?Q?gfMA+SJRIYmLAIPzBcE8BoONOXbUPoGrtrSNQxj3turBz5LDToPHk7F8Ki/6?=
 =?us-ascii?Q?YD0glBOv/xcor/AQ2F3AIoPS1xOC3XCcglMp8BhAZ/+H/SfAWR2yJ53+vd++?=
 =?us-ascii?Q?Sgu/xg/QTFMfpfNlT6kp+UbdxNKSqR7Lvr7N4e2PlrJ8Y9zvaHXDEfwHWgZC?=
 =?us-ascii?Q?I3yOFY6hfpx7jOI4PxIEM7u9l58U0zxe0FHMJJwoECyZMD8/0F+OIjhIoidO?=
 =?us-ascii?Q?xq1r5pdr2PovEkEx1iklUYX2UQuXIdUzSNq/CxeZczlbZgRZa58+Leh0XznD?=
 =?us-ascii?Q?kj5UzY02TtrXiVYASq9F9XGOkzbfmahIdsy7qHBTSJtU8ZZd9nn/SbQWLmNy?=
 =?us-ascii?Q?0aNsDxoGABtCT78BcAZ/RQit1p2WXGnbsyI6Luz2xteRFbMTN7yjkRsKsAZd?=
 =?us-ascii?Q?6rn+Nh9A1uUxI33Auo7Ucv9RAi3ZJK9SSVMbs+4zVXUGP8T75tGwLOL3ZyDD?=
 =?us-ascii?Q?plqLzlW9VsoddDRXIyBG+Pa9ipQYN9yCM5/9verSgDB2NT8eju61WuSBhNqN?=
 =?us-ascii?Q?ivMG7Oi4EbMLbqz/RijlxHEp6BhgcgflEb3U/dxMTVev/RvaUSQHOqfDJdnY?=
 =?us-ascii?Q?IxBt4H/MQOV6jKOoQO6WW8O2Kkiqku2FFXdOZ/rC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836ceedf-0a24-4f8f-589d-08dbf5a9f7da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 15:50:56.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDckpcsiC8XmWICm/FK5uiGcN4ZEAeTglQhfqTLtvHUvtFc8dBIufym18uWQUO2cNMNh8TEcZpWuYFLb6fucsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:56:09AM +0100, Jiri Slaby wrote:
> On 30. 11. 23, 23:44, Frank Li wrote:
> > In typical embedded Linux systems, UART consoles require at least two pins,
> > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > present, we can save these two pins by using this driver. Pins is crucial
> > resources, especially in small chip packages.
> > 
> > This introduces support for using the I3C bus to transfer console tty data,
> > effectively replacing the need for dedicated UART pins. This not only
> > conserves valuable pin resources but also facilitates testing of I3C's
> > advanced features, including early termination, in-band interrupt (IBI)
> > support, and the creation of more complex data patterns. Additionally,
> > it aids in identifying and addressing issues within the I3C controller
> > driver.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ...
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -412,6 +412,19 @@ config RPMSG_TTY
> >   	  To compile this driver as a module, choose M here: the module will be
> >   	  called rpmsg_tty.
> > +config I3C_TTY
> > +	tristate "TTY over I3C"
> > +	depends on I3C
> > +	help
> > +	  Select this options if you'd like use TTY over I3C master controller
> 
> this option
> to use
> add a period to the end.
> 
> > +
> > +	  This makes it possible for user-space programs to send and receive
> > +	  data as a standard tty protocol. I3C provide relatively higher data
> > +	  transfer rate and less pin numbers, SDA/SCL are shared with other
> > +	  devices.
> > +
> > +	  If unsure, say N
> > +
> >   endif # TTY
> >   source "drivers/tty/serdev/Kconfig"
> ...
> > --- /dev/null
> > +++ b/drivers/tty/i3c_tty.c
> > @@ -0,0 +1,443 @@
> ...
> > +struct ttyi3c_port {
> > +	struct tty_port port;
> > +	int minor;
> > +	spinlock_t xlock; /* protect xmit */
> > +	char tx_buff[I3C_TTY_TRANS_SIZE];
> > +	char rx_buff[I3C_TTY_TRANS_SIZE];
> 
> These should be u8 as per the other changes throughout the tty layer.
> 
> > +	struct i3c_device *i3cdev;
> > +	struct work_struct txwork;
> > +	struct work_struct rxwork;
> > +	struct completion txcomplete;
> > +	unsigned long status;
> > +	int buf_overrun;
> 
> Can this be ever negative?
> 
> > +};
> > +
> > +struct workqueue_struct *workqueue;
> 
> Is this related:
>     Still below items not be fixed (according to Jiri Slaby's comments)
>     - rxwork thread: need trigger from two position.
>     - common thread queue: need some suggestion
> ?
> 
> As I don't remember, could you elaborate again why you need your own
> workqueue? You need to do it in the commit log anyway.

I just learn from other drivers, such as USB ACM, usb gadget ACM driver.
If use common workqueue, which one prefered.

I will send fixed version after i3c part accepted.

Frank
> 
> ...
> > +static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +	unsigned long flags;
> > +	bool is_empty;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
> > +	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +
> > +	if (!is_empty)
> > +		queue_work(workqueue, &sport->txwork);
> > +
> > +	return ret;
> > +}
> > +
> > +static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +	unsigned long flags;
> > +	int ret = 0;
> 
> Unneeded initialization.
> 
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +	ret = kfifo_put(&sport->port.xmit_fifo, ch);
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +
> > +	return ret;
> > +}
> ...
> > +static void tty_i3c_rxwork(struct work_struct *work)
> > +{
> > +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
> > +	struct i3c_priv_xfer xfers;
> > +	int retry = I3C_TTY_RETRY;
> 
> Likely, should be unsigned.
> 
> > +	u16 status = BIT(0);
> > +	int ret;
> > +
> > +	memset(&xfers, 0, sizeof(xfers));
> > +	xfers.data.in = sport->rx_buff;
> > +	xfers.len = I3C_TTY_TRANS_SIZE;
> > +	xfers.rnw = 1;
> > +
> > +	do {
> > +		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
> > +			break;
> > +
> > +		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> > +
> > +		if (xfers.actual_len) {
> > +			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
> > +						     xfers.actual_len);
> > +			if (ret < xfers.actual_len)
> > +				sport->buf_overrun++;
> > +
> > +			retry = I3C_TTY_RETRY;
> > +			continue;
> > +		}
> > +
> > +		status = BIT(0);
> > +		i3c_device_getstatus_format1(sport->i3cdev, &status);
> > +		/*
> > +		 * Target side needs some time to fill data into fifo. Target side may not
> > +		 * have hardware update status in real time. Software update status always
> > +		 * needs some delays.
> > +		 *
> > +		 * Generally, target side have circular buffer in memory, it will be moved
> > +		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
> > +		 * there are gap, especially CPU have not response irq to fill FIFO in time.
> > +		 * So xfers.actual will be zero, wait for little time to avoid flood
> > +		 * transfer in i3c bus.
> > +		 */
> > +		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> > +		retry--;
> > +
> > +	} while (retry && (status & BIT(0)));
> > +
> > +	tty_flip_buffer_push(&sport->port);
> > +}
> > +
> > +static void tty_i3c_txwork(struct work_struct *work)
> > +{
> > +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
> > +	struct i3c_priv_xfer xfers;
> > +	int retry = I3C_TTY_RETRY;
> 
> Detto.
> 
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	xfers.rnw = 0;
> > +	xfers.data.out = sport->tx_buff;
> > +
> > +	while (!kfifo_is_empty(&sport->port.xmit_fifo) && retry) {
> > +		xfers.len = kfifo_len(&sport->port.xmit_fifo);
> > +		xfers.len = min_t(u16, I3C_TTY_TRANS_SIZE, xfers.len);
> > +
> > +		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
> 
> Can this simply be:
> xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff,
> I3C_TTY_TRANS_SIZE);
> ?
> 
> > +
> > +		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> > +		if (ret) {
> > +			/*
> > +			 * Target side may not move data out of FIFO. delay can't resolve problem,
> > +			 * just reduce some possiblity. Target can't end I3C SDR mode write
> > +			 * transfer, discard data is reasonable when FIFO overrun.
> > +			 */
> > +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> > +			retry--;
> > +		} else {
> > +			retry = I3C_TTY_RETRY;
> > +			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
> 
> Just to make sure: xfers.len is nor overwritten by
> i3c_device_do_priv_xfers(), right?
> 
> > +		}
> > +	}
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> 
> Why do you take the lock here, but not during the kfifo operations above?
> 
> > +	if (kfifo_is_empty(&sport->port.xmit_fifo))
> > +		complete(&sport->txcomplete);
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +}
> 
> > +static int __init i3c_tty_init(void)
> > +{
> > +	int ret;
> > +
> > +	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
> > +					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > +
> > +	if (IS_ERR(i3c_tty_driver))
> > +		return PTR_ERR(i3c_tty_driver);
> > +
> > +	i3c_tty_driver->driver_name = "ttyI3C";
> > +	i3c_tty_driver->name = "ttyI3C";
> > +	i3c_tty_driver->minor_start = 0,
> > +	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
> > +	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
> > +	i3c_tty_driver->init_termios = tty_std_termios;
> > +	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
> > +					       CLOCAL;
> > +	i3c_tty_driver->init_termios.c_lflag = 0;
> > +
> > +	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
> > +
> > +	ret = tty_register_driver(i3c_tty_driver);
> > +	if (ret)
> > +		goto err_tty_register_driver;
> > +
> > +	ret = i3c_driver_register(&i3c_driver);
> > +	if (ret)
> > +		goto err_i3c_driver_register;
> > +
> > +	workqueue = alloc_workqueue("ttyI3C", 0, 0);
> 
> Can it happen that you already queue something on this wq, while not
> allocated yet? I mean: should this be done first in i3c_tty_init()?
> 
> > +	if (!workqueue) {
> > +		ret = PTR_ERR(workqueue);
> > +		goto err_alloc_workqueue;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_alloc_workqueue:
> > +	i3c_driver_unregister(&i3c_driver);
> > +
> > +err_i3c_driver_register:
> > +	tty_unregister_driver(i3c_tty_driver);
> > +
> > +err_tty_register_driver:
> > +	tty_driver_kref_put(i3c_tty_driver);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __exit i3c_tty_exit(void)
> > +{
> > +	i3c_driver_unregister(&i3c_driver);
> > +	tty_unregister_driver(i3c_tty_driver);
> > +	tty_driver_kref_put(i3c_tty_driver);
> > +	idr_destroy(&i3c_tty_minors);
> 
> What about the wq?
> 
> > +}
> 
> regards,
> -- 
> js
> suse labs
> 
