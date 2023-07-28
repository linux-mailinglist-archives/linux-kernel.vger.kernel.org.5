Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F9767072
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjG1PXc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjG1PXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:23:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10235B8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:23:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-eJcN3k0sP7Kvuwhq7UFxfw-1; Fri, 28 Jul 2023 16:23:26 +0100
X-MC-Unique: eJcN3k0sP7Kvuwhq7UFxfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 16:23:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jul 2023 16:23:25 +0100
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
Subject: RE: [PATCH 1/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_stop_io_on_error_cmd_read() directly
Thread-Topic: [PATCH 1/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_stop_io_on_error_cmd_read() directly
Thread-Index: AQHZwSEI7kbXXpGPc0ikqDMKVqIzOK/PS6TQ
Date:   Fri, 28 Jul 2023 15:23:25 +0000
Message-ID: <314512939ebd44508b767d799e7c30af@AcuMS.aculab.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
 <20230728065819.139694-2-oleksandr@redhat.com>
In-Reply-To: <20230728065819.139694-2-oleksandr@redhat.com>
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
> The qedf_dbg_stop_io_on_error_cmd_read() function invokes sprintf()
> directly on a __user pointer, which may crash the kernel.
> 
> Avoid doing that by using a small on-stack buffer for sprintf()
> and then calling simple_read_from_buffer() which does a proper
> copy_to_user() call.
> 
> Fixes: 61d8658b4a ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
...
> diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
> index a3ed681c8ce3f..4d1b99569d490 100644
> --- a/drivers/scsi/qedf/qedf_debugfs.c
> +++ b/drivers/scsi/qedf/qedf_debugfs.c
> @@ -185,18 +185,17 @@ qedf_dbg_stop_io_on_error_cmd_read(struct file *filp, char __user *buffer,
>  				   size_t count, loff_t *ppos)
>  {
>  	int cnt;
> +	char cbuf[7];
>  	struct qedf_dbg_ctx *qedf_dbg =
>  				(struct qedf_dbg_ctx *)filp->private_data;
>  	struct qedf_ctx *qedf = container_of(qedf_dbg,
>  	    struct qedf_ctx, dbg_ctx);
> 
>  	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
> -	cnt = sprintf(buffer, "%s\n",
> +	cnt = sprintf(cbuf, "%s\n",
>  	    qedf->stop_io_on_error ? "true" : "false");

You've made cbuf[] exactly just big enough.
If anyone breathes on this code it could overflow.
You really should use scnprintf() for safety.

> 
> -	cnt = min_t(int, count, cnt - *ppos);
> -	*ppos += cnt;
> -	return cnt;
> +	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);

Or just:
	if (gedf->stop_on_error)
		return simple_read_from_buffer(buffer, count, ppos, "true\n", 5);
	return simple_read_from_buffer(buffer, count, ppos, "false\n", 6);

	David

	
>  }
> 
>  static ssize_t
> --
> 2.41.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

