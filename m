Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2576707D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjG1P0S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjG1P0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:26:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D7A1717
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:26:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-217-YVmH9eBiMmG5VIsPrBuaNQ-1; Fri, 28 Jul 2023 16:26:12 +0100
X-MC-Unique: YVmH9eBiMmG5VIsPrBuaNQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 16:26:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jul 2023 16:26:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oleksandr Natalenko' <oleksandr@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "GR-QLogic-Storage-Upstream@marvell.com" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Rob Evers" <revers@redhat.com>
Subject: RE: [PATCH 2/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_debug_cmd_read() directly
Thread-Topic: [PATCH 2/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_debug_cmd_read() directly
Thread-Index: AQHZwSEN9Ls1iMTEjEyz1kbENNwADa/PTLUA
Date:   Fri, 28 Jul 2023 15:26:11 +0000
Message-ID: <2938f701ba56419e861f1bb410831862@AcuMS.aculab.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
 <20230728065819.139694-3-oleksandr@redhat.com>
In-Reply-To: <20230728065819.139694-3-oleksandr@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Natalenko
> Sent: 28 July 2023 07:58
> 
> The qedf_dbg_debug_cmd_read() function invokes sprintf()
> directly on a __user pointer, which may crash the kernel.
                                      ^^^ will

> 
> Avoid doing that by using a small on-stack buffer for sprintf()
> and then calling simple_read_from_buffer() which does a proper
> copy_to_user() call.
...
> diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
> index 4d1b99569d490..f910af0029a2c 100644
> --- a/drivers/scsi/qedf/qedf_debugfs.c
> +++ b/drivers/scsi/qedf/qedf_debugfs.c
> @@ -138,15 +138,14 @@ qedf_dbg_debug_cmd_read(struct file *filp, char __user *buffer, size_t count,
>  			loff_t *ppos)
>  {
>  	int cnt;
> +	char cbuf[35];

Why 35?
I pick a multiple of 8 that if 'enough.

>  	struct qedf_dbg_ctx *qedf_dbg =
>  				(struct qedf_dbg_ctx *)filp->private_data;
> 
>  	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=0x%x\n", qedf_debug);
> -	cnt = sprintf(buffer, "debug mask = 0x%x\n", qedf_debug);
> +	cnt = sprintf(cbuf, "debug mask = 0x%x\n", qedf_debug);

Use scnprintf() to be sure it doesn't overflow.
Much safer if someone does a quick update or copies the code.

	David

> 
> -	cnt = min_t(int, count, cnt - *ppos);
> -	*ppos += cnt;
> -	return cnt;
> +	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
>  }
> 
>  static ssize_t
> --
> 2.41.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

