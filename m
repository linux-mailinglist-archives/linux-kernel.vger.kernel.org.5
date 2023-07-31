Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200A76A178
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGaTpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGaTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:45:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788071BD9;
        Mon, 31 Jul 2023 12:45:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTaaA017799;
        Mon, 31 Jul 2023 19:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=yFcTrHPuLCX1mvHoozfJBevhb7wRvXP2qL/c7m8L3Fk=;
 b=0NWRYlXNnVFw3UWP5RBZILZIRZ1e/ZgWExM54Lv9xkcAkoYz7YurKI7ANhD04j6t5Olb
 GbLsCRKLXVa3D7YZBmhWeU3zxtfXGfEU1tfQepzWKm1dhV7bOgnxAsS9KxSka3QBpaIo
 A713U+H5vG4fxaouSR62TbODy/pem8VFtIqMSkp+TPaVc3eFJKq3vsqHoCal3dH0dPUr
 zIIQ4qn2+HOh3UzKqifQmP57t39vpbPLuDxvAs7G8IQiX5Fuzq4J2usHvhVNZka9sHS+
 LyJmSJ+pxS4jXpFhuaDu9R+KAjzZHO7Du3WW2Y4tX7olalfr075tZ8l51PihQJYMZ+Pq bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2bf4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VI2TPD013610;
        Mon, 31 Jul 2023 19:45:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75cmr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJjEfh025102;
        Mon, 31 Jul 2023 19:45:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s4s75cmf1-5;
        Mon, 31 Jul 2023 19:45:19 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, vikas.chaudhary@qlogic.com,
        JBottomley@Parallels.com, mchan@broadcom.com, benli@broadcom.com,
        ogerlitz@voltaire.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Ma <linma@zju.edu.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 1/2] scsi: iscsi: Add length check for nlattr payload
Date:   Mon, 31 Jul 2023 15:45:06 -0400
Message-Id: <169083266401.2873709.2360198964162460177.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725024529.428311-1-linma@zju.edu.cn>
References: <20230725024529.428311-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310179
X-Proofpoint-ORIG-GUID: sNCeZxblS2RBoJwpajY-nWOiev6dTE0S
X-Proofpoint-GUID: sNCeZxblS2RBoJwpajY-nWOiev6dTE0S
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 10:45:29 +0800, Lin Ma wrote:

> The current NETLINK_ISCSI netlink parsing loop checks every nlmsg to
> make sure the length is bigger than the sizeof(struct iscsi_uevent) and
> then calls iscsi_if_recv_msg(...).
> 
>   nlh = nlmsg_hdr(skb);
>   if (nlh->nlmsg_len < sizeof(*nlh) + sizeof(*ev) ||
>     skb->len < nlh->nlmsg_len) {
>     break;
>   }
>   ...
>   err = iscsi_if_recv_msg(skb, nlh, &group);
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/2] scsi: iscsi: Add length check for nlattr payload
      https://git.kernel.org/mkp/scsi/c/971dfcb74a80

-- 
Martin K. Petersen	Oracle Linux Engineering
