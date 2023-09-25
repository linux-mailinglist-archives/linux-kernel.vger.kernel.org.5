Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B517AD593
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjIYKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjIYKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AAA10DB;
        Mon, 25 Sep 2023 03:12:10 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P98dFT003707;
        Mon, 25 Sep 2023 10:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=96psxN1f9XQziopU35QMc9HEX23km0D8MWKqNpx5f/A=;
 b=S1KLfwCr7U5E1iT6apQf6fHJdXmjpbAqIEBJXodxr9SEQN7ug1/6mibp8SIMr2Oi2adn
 QY4UMTmrFM1rfTpIzqpI3dm+9/Rd+t07qAK7ccp0NrU0kmfpfzCvMk6ivkAZBDi0gJ33
 b76UM5Es5g4QolM7223ZblQ008g05SH3yWHfPKDR9zpQDpAtoeLmmQx708NmWoiGn4mX
 4K2J4ZnnsF3UaqWoHafauYUH3XkuXlYX/4TfeZWP4DVP/SN/n9Fn3gjE+FAitMGs6F8w
 N2tVG+M6hV/yIhQZ//kRFfSzUzCRKnK1XqIg5+fr1xj9WLjT0tdCtsI0hVwUwWGVLv1I zQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta5rd8hvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:12:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38P8uVB2008253;
        Mon, 25 Sep 2023 10:07:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbms82q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:07:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38PA739W14811882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 10:07:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DFDC20065;
        Mon, 25 Sep 2023 10:07:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347D32004F;
        Mon, 25 Sep 2023 10:07:03 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.171.44.172])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Sep 2023 10:07:03 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1qkiUY-0039iO-2G;
        Mon, 25 Sep 2023 12:07:02 +0200
Date:   Mon, 25 Sep 2023 12:07:02 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] scsi: zfcp: Fix a double put in zfcp_port_enqueue
Message-ID: <20230925100702.GA650446@p1gen4-pw042f0m.fritz.box>
References: <20230923103723.10320-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230923103723.10320-1-dinghao.liu@zju.edu.cn>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cDUwzamnM3SGE02sFbPz0Oa8_j5jzsyU
X-Proofpoint-GUID: cDUwzamnM3SGE02sFbPz0Oa8_j5jzsyU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 06:37:23PM +0800, Dinghao Liu wrote:
> When device_register() fails, zfcp_port_release() will be called
> after put_device(). As a result, zfcp_ccw_adapter_put() will be
> called twice: one in zfcp_port_release() and one in the error path
> after device_register(). So the reference on the adapter object is
> doubly put, which may lead to a premature free. Fix this by adjusting
> the error tag after device_register().
> 
> Fixes: f3450c7b9172 ("[SCSI] zfcp: Replace local reference counting with common kref")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: -Improve the patch description.
>     -Add a new label 'err_register' to unify code style.
> 
> v3: -Improve the names of goto labels.
> ---
>  drivers/s390/scsi/zfcp_aux.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index df782646e856..ab2f35bc294d 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -518,12 +518,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
>  	if (port) {
>  		put_device(&port->dev);
>  		retval = -EEXIST;
> -		goto err_out;
> +		goto err_put;
>  	}
>  
>  	port = kzalloc(sizeof(struct zfcp_port), GFP_KERNEL);
>  	if (!port)
> -		goto err_out;
> +		goto err_put;
>  
>  	rwlock_init(&port->unit_list_lock);
>  	INIT_LIST_HEAD(&port->unit_list);
> @@ -546,7 +546,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
>  
>  	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
>  		kfree(port);
> -		goto err_out;
> +		goto err_put;
>  	}
>  	retval = -EINVAL;
>  
> @@ -563,7 +563,8 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
>  
>  	return port;
>  
> -err_out:
> +err_put:
>  	zfcp_ccw_adapter_put(adapter);
> +err_out:
>  	return ERR_PTR(retval);
>  }
> -- 
> 2.17.1
> 

Looks good to me. Ideally we would have a stable tag (v2.6.33+) in with the
Fixes tag as well, but I don't think we need to fly an extra round just for
that. We can ask the stable team once this is included upstream.


Acked-by: Benjamin Block <bblock@linux.ibm.com>


Martin, can you please pick this directly?


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
