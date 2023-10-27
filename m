Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926837DA14C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjJ0TbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjJ0TbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:31:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DD1A1;
        Fri, 27 Oct 2023 12:31:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RIdX4Q003871;
        Fri, 27 Oct 2023 19:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ItvClyjMB8L/p4AE5umpCbZyCJ10SEmY05g80Zcee8s=;
 b=BLC8llJqpU8EtO0M2IvUJ++pOLkkpHYMfZ739vI+DuiOAzV0yBFWJkIJ1mSQWsiFCzjX
 XYlTczzljSKdRAS1ym43e8r+c0S3BiWi4Z31PSUt9FrrN/wwCJ7qe+7GQSOilNaHfBg5
 fHbcfeC7euWQwJP8Micip+bI9NF5x70P8JT9eC4MGlZIY02gowVriis+z2CJsBj4LjHw
 5IWizoMgL3ObhujCM1Ehvqr/tvRCqv8bXSmpVDgn0lQjJsFdR8B6p+S3ElaeOx+sp0XE
 aU+p6wgd1ySsLRHGU6ET8usTseuDXix0Cactxl2Ndk3edc+LXddrbD+MftiLGEzIqr8N Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyww72ynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:30:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RJUa8p019817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 19:30:36 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 12:30:34 -0700
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 0/3] Validating UAPI backwards compatibility
Date:   Fri, 27 Oct 2023 12:30:13 -0700
Message-ID: <20231027193016.27516-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6yv5s9wwUnZ92wTiCEbL017xmpNgKZV5
X-Proofpoint-GUID: 6yv5s9wwUnZ92wTiCEbL017xmpNgKZV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_18,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=925 priorityscore=1501
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

In the previous version of this patchset, we received feedback that there
were too many false positives flagged by the check-uapi.sh script. To
improve the situation, we've been working with Dodji Seketeli from
the libabigail team to add additional suppressions which filter out
many of the flags which were raised before. To take advantage of these
suppressions, we've raised the minimum abidiff version requirement to
2.4 which was recently released[3].

Big thanks to Dodji and the libabigail team for working on this use case
with us!

Previous discussion on v5 of this patch can be found here[4].

[1] https://sourceware.org/libabigail/manual/libabigail-overview.html
[2] https://sourceware.org/libabigail/manual/abidiff.html
[3] http://mirrors.kernel.org/sourceware/libabigail/libabigail-2.4.tar.xz
[4] https://lore.kernel.org/lkml/20230407203456.27141-1-quic_johmoo@quicinc.com/

P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
original version of the UAPI checker script. Thanks Jordan!

John Moon (3):
  check-uapi: Introduce check-uapi.sh
  docs: dev-tools: Add UAPI checker documentation
  check-module-params: Introduce check-module-params.sh

 Documentation/dev-tools/checkuapi.rst | 477 +++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 scripts/check-module-params.sh        | 295 +++++++++++++
 scripts/check-uapi.sh                 | 585 ++++++++++++++++++++++++++
 4 files changed, 1358 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst
 create mode 100755 scripts/check-module-params.sh
 create mode 100755 scripts/check-uapi.sh


base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
--
2.17.1

