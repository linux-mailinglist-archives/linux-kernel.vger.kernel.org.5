Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23679F670
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjINBk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjINBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:40:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3B1BD3;
        Wed, 13 Sep 2023 18:40:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DKbOIb005535;
        Thu, 14 Sep 2023 01:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=bYGqFxi1OHfFB/skcVZcSNk2thtjUMw9RD2mRaKfX10=;
 b=wYRgWChSINdnbpKSsFZ4P28BgOyIW6W8w/TfqRyJ3QZiSqd0ZV3DmX+dgXyFN6yLFwqU
 6Ei0F9Ptwng7uPc9GG+B8XExq+V0WAZ4SMSVPnkotZQm7TbG/4rgg+UFxCSDmhbKzQb3
 cSjQIzLGKwmjuhXR7eJ0UPXlOZ0J/CgLYYv7SioS5bZapuWVaxSIfxiYbdcVxluYiJHX
 lUBZwtBjIIfPH5H3OsgiGPy5+dvjaGcUuX855ZHpRDv2f5xMsXwhMRuX92G/suzxYc5K
 mXWJwowCLYHNCHAzVpdzWcMl9MBpm2m23jwbqd4cMLnLPDWodtYOwEnzKKdVgh/XpWau Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kujut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:40:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E15njl007764;
        Thu, 14 Sep 2023 01:40:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f581r12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:40:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38E1efpP038417;
        Thu, 14 Sep 2023 01:40:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t0f581qyy-2;
        Thu, 14 Sep 2023 01:40:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
Date:   Wed, 13 Sep 2023 21:40:25 -0400
Message-Id: <169465549434.730690.14253964357330620522.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230831143638.232596-1-azeemshaikh38@gmail.com>
References: <20230831143638.232596-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=717 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140013
X-Proofpoint-GUID: OL_8MbQxqPqPazGAf-Yn2ihlsF1JXjHb
X-Proofpoint-ORIG-GUID: OL_8MbQxqPqPazGAf-Yn2ihlsF1JXjHb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 14:36:38 +0000, Azeem Shaikh wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to 6.6/scsi-fixes, thanks!

[1/1] scsi: target: Replace strlcpy with strscpy
      https://git.kernel.org/mkp/scsi/c/5c584fe6098a

-- 
Martin K. Petersen	Oracle Linux Engineering
