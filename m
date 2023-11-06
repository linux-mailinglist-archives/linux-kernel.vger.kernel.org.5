Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF87E223E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjKFMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:49:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D677BB;
        Mon,  6 Nov 2023 04:49:28 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6BnCUI003977;
        Mon, 6 Nov 2023 12:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=J6zrOtNnHzETgVq1MXtCyUNJtlPiqfaGnHat/IrTdq4=;
 b=ZjhvVkdzUhmF04Bd+qdPpeAY0O54nlqxv8Bk6Jf8p6pD2spRIVjABl/CSIW5mwvPYXOU
 776XBauNAHfcGuY/rYtDUQW7QIDe2z+fwhlVv2zLsbVi10ZiKVSsgagL1fE6avXHIb8C
 EN4M9gQEV8+JlEB5JHYBKweckhDC49FF5fs3mDoq4FjWyGS8ifk3I2aLY3Y0H6f1/Udo
 +tc6+YJzA+jHCmK1HVeOr2jA01ZS3/Gug50N1db8AAf8wa3Fi2ddLddPPCP9lJcjIMz7
 6QdJioaoJ2N7wWJdCEHsRkQaru1CJM9Wt29qoZzhAO159tyYKcP5ZvF+E8P7jLRBxtYS 6g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6uj0subd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:49:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Bp2l2007930;
        Mon, 6 Nov 2023 12:49:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61sk93uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:49:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CnMNM20906540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:49:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC3AB20043;
        Mon,  6 Nov 2023 12:49:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B299C20040;
        Mon,  6 Nov 2023 12:49:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:49:22 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/uvdevice: Report additional-data length for attestation
Date:   Mon,  6 Nov 2023 13:49:22 +0100
Message-Id: <20231106124922.3032370-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qVPZCt37uQzLaQvGYX_IHhxyq1d7e1Vy
X-Proofpoint-GUID: qVPZCt37uQzLaQvGYX_IHhxyq1d7e1Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional data length in the attestation request is an in/out variable.
Software provides the capacity of the buffer. Upon successful request,
firmware reports the actual bytes written to the additional data in that
field. This information is lost, as the length field was not copied back
to userspace before. Attestation might fail, if user space did not
specify the exact amount of needed bytes required, as this length is
part of the attestation measurement.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/s390/char/uvdevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 144cd2e03590..42c9f77f8da0 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -109,6 +109,7 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
 					   struct uvio_attest *uvio_attest)
 {
 	struct uvio_attest __user *user_uvio_attest = (void __user *)uv_ioctl->argument_addr;
+	u32 __user *user_buf_add_len = (u32 __user *)&user_uvio_attest->add_data_len;
 	void __user *user_buf_add = (void __user *)uvio_attest->add_data_addr;
 	void __user *user_buf_meas = (void __user *)uvio_attest->meas_addr;
 	void __user *user_buf_uid = &user_uvio_attest->config_uid;
@@ -117,6 +118,8 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
 		return -EFAULT;
 	if (add_data && copy_to_user(user_buf_add, add_data, uvio_attest->add_data_len))
 		return -EFAULT;
+	if (put_user(uvio_attest->add_data_len, user_buf_add_len))
+		return -EFAULT;
 	if (copy_to_user(user_buf_uid, uvcb_attest->config_uid, sizeof(uvcb_attest->config_uid)))
 		return -EFAULT;
 	return 0;
-- 
2.39.2

