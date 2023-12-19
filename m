Return-Path: <linux-kernel+bounces-4586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DC817FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFCA2854A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104688466;
	Tue, 19 Dec 2023 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvbFtVRM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B45253;
	Tue, 19 Dec 2023 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0ItNq024921;
	Tue, 19 Dec 2023 02:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=OQDM0B40P70QPcL6XBur2Jg9WhefsXBhpyrJKEmGblg=;
 b=PvbFtVRMSS4CbqW/yv2CGx+uGwoaJz1MMwmIYgfc7Ue1ZrhawopFlrWH1P8CXhh36uWY
 W9iO+vdyFx4rDfYYujB6vNUj+1NUgPKwK3mIMQwi/Jejbgz/57rscyYDrtJ6+3rQN+NV
 PbUZb66b7pRP0n8iyukkNY4QiT+ttdZnl9DBmnmElEgCwJ5Bp41ESu0JUO67/wtf4Xqc
 HJg0mVBBBKl32Ro4TMqiPG4/fE5haAxbBOUFYiVIzQykfMfnsPFmucdc81ySLxhVMGdD
 rEgDMUSXNJzk9ytjYZ+qjVxvWZ1mgypYnlbBfLEiJhDhnI3KHa2rug6GIPz1yANM0mIs Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p44un9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ1k9v8020935;
	Tue, 19 Dec 2023 02:19:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69t76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7Z9012682;
	Tue, 19 Dec 2023 02:19:11 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-4;
	Tue, 19 Dec 2023 02:19:11 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
Date: Mon, 18 Dec 2023 21:18:48 -0500
Message-ID: <170294822166.2675590.301399188654325708.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
References: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-GUID: Tkj1uZp2qXkZ3E1TAzz3YUYkkT_vGBTd
X-Proofpoint-ORIG-GUID: Tkj1uZp2qXkZ3E1TAzz3YUYkkT_vGBTd

On Tue, 12 Dec 2023 23:19:06 +0000, Justin Stitt wrote:

> Instead of copying @buf into a new buffer and carefully managing its
> newline/null-terminating status, we can just use sysfs_match_string()
> as it uses sysfs_streq() internally which handles newline/null-term:
> 
> |  /**
> |   * sysfs_streq - return true if strings are equal, modulo trailing newline
> |   * @s1: one string
> |   * @s2: another string
> |   *
> |   * This routine returns true iff two strings are equal, treating both
> |   * NUL and newline-then-NUL as equivalent string terminations.  It's
> |   * geared for use with sysfs input strings, which generally terminate
> |   * with newlines but are compared against values without newlines.
> |   */
> |  bool sysfs_streq(const char *s1, const char *s2)
> |  ...
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
      https://git.kernel.org/mkp/scsi/c/edc22a7c8688

-- 
Martin K. Petersen	Oracle Linux Engineering

