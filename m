Return-Path: <linux-kernel+bounces-1031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B981497D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED45D286AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C462DF98;
	Fri, 15 Dec 2023 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FsTmMLgU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E679F3032F;
	Fri, 15 Dec 2023 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFCdb3H003660;
	Fri, 15 Dec 2023 13:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=e1V6io6xw+X48KEN9Lw2
	Dc3hZe8mKdB3X54mQjBDkM8=; b=FsTmMLgU25BqlcNKNv2Bw1vGxWR8+puV6EOb
	ti1wCeWUkeiTtee8vutviBW8uy0RsL9nTIHUPH9efX53HongFJ0Qpv2AUGmyO7gc
	XS96RiO4kfWuowNQUzl3vupqMhZEZ8cdKNtucCNLQ50s55I/hx11rjJ0WjtkxvHr
	KbGGUfEFBL9lv+eUMlfNjVNkAJqvWMjjucrckJHmzalYi86I0OvjLUqobbXAg2cg
	14CF2ZR8HK2lHG0MUfdAAsRZhZMWWnmtNigzwf1ea/lcFLBJ7xtrD/Wyd3th+THO
	zVc92t7wIbZo0LsUtkBrul2Gru1cZe1dyBDvPFNh78fyq3bVEg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb013sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 13:41:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFDfb33008769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 13:41:37 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 05:41:34 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <quic_qiancai@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_vnivarth@quicinc.com>,
        <quic_eberman@quicinc.com>
CC: <quic_zijuhu@quicinc.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Date: Fri, 15 Dec 2023 21:41:30 +0800
Message-ID: <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7dD9jupRyBhKhkRsDBa3w_rjy5WQsO-X
X-Proofpoint-GUID: 7dD9jupRyBhKhkRsDBa3w_rjy5WQsO-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150092

Current tty-ldisc module loading logic within tty_ldisc_get()
is prone to mislead beginner that the module is able to be loaded
by a user without capability CAP_SYS_MODULE, add comments to make
the logic easy to undertand.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove condition checking changes

 drivers/tty/tty_ldisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 3f68e213df1f..34526ffaccbc 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -150,6 +150,10 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
+		/*
+		 * Always request tty-ldisc module regardless of user's
+		 * CAP_SYS_MODULE if autoload is enabled.
+		 */
 		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
 			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
-- 
The Qualcomm Innovation Center


