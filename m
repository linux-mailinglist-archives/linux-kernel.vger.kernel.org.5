Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C49773716
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHHCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHHCuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:50:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3A10CF;
        Mon,  7 Aug 2023 19:50:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781i68Y006781;
        Tue, 8 Aug 2023 02:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=C/CfdWb6wx/Zxm96Fzb6dhsDatVRuRD2p9SbRhgCz1M=;
 b=I7DXown6xnMB06TxZlIg1EqbaPPbwwUbXbgGq1azjSTJugYA9vxtFThS/Mob//rINIbR
 XX2kI59qbeKLlt/s/SGI+lmwI9xNsFuEcCQ7JhMypG71PYoeW+olSzKWcmwY+dd+un1Q
 Ehrp1z1Uf5Ov8SDM5IETnd50ye5wati+ofOQbHH7ehd7S6XWXJxY9TbtJCxJnLAM4h+9
 uoU18N8IU5zuXsOIs6gAKvnUeks1AUnvWxfhoxZLuIHkFEPSWlhHfYPSl36A3ytkx8/t
 dCP4bU0RRwAPNTRf9XgeeayvHM0cc1rL0A/ZlmNkZyFQFjQegVW1Bh324fXI1PcrXWnL hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc45wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377NpZOk027387;
        Tue, 8 Aug 2023 02:50:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv561nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3782oadg010815;
        Tue, 8 Aug 2023 02:50:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s9cv561mp-4;
        Tue, 08 Aug 2023 02:50:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@ACULAB.COM>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
Date:   Mon,  7 Aug 2023 22:50:29 -0400
Message-Id: <169146270856.4040832.2702542870252072266.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731084034.37021-1-oleksandr@redhat.com>
References: <20230731084034.37021-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=956 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080023
X-Proofpoint-ORIG-GUID: WD9VkmIgC5YUy8BGkk-wvNVFMl4lsfCf
X-Proofpoint-GUID: WD9VkmIgC5YUy8BGkk-wvNVFMl4lsfCf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 10:40:31 +0200, Oleksandr Natalenko wrote:

> qedf driver, debugfs part of it specifically, touches __user pointers
> directly for printing out info to userspace via sprintf(), which may
> cause crash like this:
> 
> BUG: unable to handle kernel paging request at 00007ffd1d6b43a0
> IP: [<ffffffffaa7a882a>] string.isra.7+0x6a/0xf0
> Oops: 0003 [#1] SMP
> Call Trace:
>  [<ffffffffaa7a9f31>] vsnprintf+0x201/0x6a0
>  [<ffffffffaa7aa556>] sprintf+0x56/0x80
>  [<ffffffffc04227ed>] qedf_dbg_stop_io_on_error_cmd_read+0x6d/0x90 [qedf]
>  [<ffffffffaa65bb2f>] vfs_read+0x9f/0x170
>  [<ffffffffaa65cb82>] SyS_pread64+0x92/0xc0
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/3] scsi: qedf: do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
      https://git.kernel.org/mkp/scsi/c/7d3d20dee4f6
[2/3] scsi: qedf: do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
      https://git.kernel.org/mkp/scsi/c/31b5991a9a91
[3/3] scsi: qedf: do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly
      https://git.kernel.org/mkp/scsi/c/25dbc20deab5

-- 
Martin K. Petersen	Oracle Linux Engineering
