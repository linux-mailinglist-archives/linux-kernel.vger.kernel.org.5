Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95480E12E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjLLCEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLCEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:04:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F69F;
        Mon, 11 Dec 2023 18:04:06 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC1xlnu028454;
        Tue, 12 Dec 2023 02:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=ggdoTQX
        GQlyccgy7MpErs64XVDViBmAQKfJh1l2iFuU=; b=NE71hSvDtCqGF6ZJU1pqP3W
        b3k4IVjTqakrn9W3oLJRfYvYbbSerBbukqqEqTfmYGys/asYPltlJoGkglv5GQr/
        f+nVncIz+NG9UZDkVIgvGhzYVeLdg4kR2Hz3Ra+8deiFpoqk/1TYSejshY3cXaI3
        NqFaFb7WBPBuDQDTE4uRG9oYhgyzSkEdlQ4WomJojJn5qMCZroDZWMh5sepTJE1o
        eQylXL2K/vTd/ZieZcep+kZDh5TXAp+9roF9zV166TP7fTP/iBhRQB8eGYaBo9Dk
        pC1At2l+u3ucq4Y7rXaFjbuJBe7s5/Pzytky57Y8vY3ydTVmXJxhRYCl9JgrGrA=
        =
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux20esrkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:03:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC23CXB012400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:03:12 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 18:03:09 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 0/3]  Validating UAPI backwards compatibility
Date:   Mon, 11 Dec 2023 18:02:56 -0800
Message-ID: <20231212020259.2451253-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -NGv-g96EJ6YXDR75wvtJ9LWiFr6MskK
X-Proofpoint-ORIG-GUID: -NGv-g96EJ6YXDR75wvtJ9LWiFr6MskK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=876 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel community has rigorously enforced a policy of backwards
compatibility in its userspace interfaces for a long time. This has
allowed user applications to enjoy stability across kernel upgrades
without recompiling. Our goal is to add tooling and documentation to
help kernel developers maintain this stability.

In terms of tooling, I've attached a couple of shell scripts we've been
internally to validate backwards compatibility of our UAPI headers.

The check-uapi.sh script uses libabigail's[1] tool abidiff[2] to compare a
modified header's ABI before and after a patch is applied. If an existing
UAPI is modified in a way that's not backwards compatibile, the script
exits non-zero. We use this script in our continuous integration system
to block changes that fail the check.

It generates output like this when a backwards incompatible change is
made to a UAPI header:

ABI differences detected in include/uapi/linux/bpf.h from HEAD~1 -> HEAD
    [C] 'struct bpf_insn' changed:
      type size hasn't changed
      2 data member changes:
        '__u8 dst_reg' offset changed from 8 to 12 (in bits) (by +4 bits)
        '__u8 src_reg' offset changed from 12 to 8 (in bits) (by -4 bits)

The check-module-params.sh script is quite a bit simpler. It basically
greps for module_param.* calls and compares their arguments before/after
a change is applied.

We wanted to share these scripts with the community and hopefully also
receive general feedback when it comes to tooling/policy surrounding
UAPI stability.

Since v6 of this patch, I also presented a talk at LPC[4] on this topic
in case anyone would like to review that. I've CC'd a few attendees who
participated in discussion during the presentation.

Previous discussion on v6 of this patch can be found here[5].

[1] https://sourceware.org/libabigail/manual/libabigail-overview.html
[2] https://sourceware.org/libabigail/manual/abidiff.html
[3] http://mirrors.kernel.org/sourceware/libabigail/libabigail-2.4.tar.xz
[4] https://www.youtube.com/watch?v=4ijcLgvmcek
[5] https://lore.kernel.org/all/20231027193016.27516-1-quic_johmoo@quicinc.com/T/#t

P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
original version of the UAPI checker script. Thanks Jordan!

John Moon (3):
  check-uapi: Introduce check-uapi.sh
  docs: dev-tools: Add UAPI checker documentation
  check-module-params: Introduce check-module-params.sh

 Documentation/dev-tools/checkuapi.rst | 477 +++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 scripts/check-module-params.sh        | 371 +++++++++++++++++
 scripts/check-uapi.sh                 | 573 ++++++++++++++++++++++++++
 4 files changed, 1422 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst
 create mode 100755 scripts/check-module-params.sh
 create mode 100755 scripts/check-uapi.sh


base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
--
2.34.1

