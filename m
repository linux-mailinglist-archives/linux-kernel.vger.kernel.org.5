Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B817B0C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjI0Teb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0Te0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:34:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB351B2;
        Wed, 27 Sep 2023 12:34:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RIx6RT007876;
        Wed, 27 Sep 2023 19:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=5/Withjkp7BxI9AgxCuFLL2xAgHIN8igANqjSkzu3Q4=;
 b=jUlw4V3mup3Csoqfqd8xQpMCoGbhvcsd8QlLpf6GQBiA5FUNGzMp8+ksstEksKGHtkxc
 4VFEGI7m/LOg8cboVqYZJ+02SroYSWz4gAeEH2XEX4hkCU/nTRZZooPqkh4G58naVTWB
 K5R7qE3eWBtDPsfkjr7zJI8vUvrxLm/DTbUvJ4u81nuGLZMAICvuIHS90sYCUXmtOiSJ
 hJGMHvnkkiKoa4dexQsgMwR1i01ceQKclHdBp0ufnUO6Jr0JkS+TZdyzN5YZO76GUso+
 mbz6NqDiCKsq1hc4CLaeZww59debUUaQwTPh+arQ8aXlY2GVSHcSOOwwMW2LzZYlHxpY cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjujf30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:34:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RI0MGv030591;
        Wed, 27 Sep 2023 19:34:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8cueh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:34:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RJY90l008431;
        Wed, 27 Sep 2023 19:34:09 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf8cub4-1;
        Wed, 27 Sep 2023 19:34:08 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        James Bottomley <James.Bottomley@suse.de>,
        Swen Schillig <swen@vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] scsi: zfcp: Fix a double put in zfcp_port_enqueue
Date:   Wed, 27 Sep 2023 15:34:00 -0400
Message-Id: <169584315413.1272983.1280092821984155852.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923103723.10320-1-dinghao.liu@zju.edu.cn>
References: <20230923103723.10320-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=956 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270166
X-Proofpoint-ORIG-GUID: v71FJI6HIYe9Cxeax3MQtVJ-uf3-PIqe
X-Proofpoint-GUID: v71FJI6HIYe9Cxeax3MQtVJ-uf3-PIqe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 18:37:23 +0800, Dinghao Liu wrote:

> When device_register() fails, zfcp_port_release() will be called
> after put_device(). As a result, zfcp_ccw_adapter_put() will be
> called twice: one in zfcp_port_release() and one in the error path
> after device_register(). So the reference on the adapter object is
> doubly put, which may lead to a premature free. Fix this by adjusting
> the error tag after device_register().
> 
> [...]

Applied to 6.6/scsi-fixes, thanks!

[1/1] scsi: zfcp: Fix a double put in zfcp_port_enqueue
      https://git.kernel.org/mkp/scsi/c/b481f644d917

-- 
Martin K. Petersen	Oracle Linux Engineering
