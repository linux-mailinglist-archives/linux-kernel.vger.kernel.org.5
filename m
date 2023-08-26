Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785678938D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjHZC72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHZC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:58:55 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C742102
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:58:52 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37Q2wfr0013746;
        Fri, 25 Aug 2023 19:58:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=Rhd/bZv5vOoG1xrHWO2yD+cjPhp7tUfExrPHpSA0s/4=; b=
        Cdlh1NZBK2WPWMKTEq3sPPc5pq2k3x/3W2wt1IBw1rE+UhS51mYKEkgyg6nR/a6Z
        Tdxrzu6cOpKQJXauXH1Twn2lddwQsY0VReR8Zv30skAMa/q9XIeaDQiW3orpt7jK
        346DrXIqT+/+76dzNu+7EC0p5vtIUbYiwj1wYcSEegrNx5as1ChYm/LpnBGFcasq
        lzICv9sEDFOclnarBIOgezzfHBkuVR6ul7S78Uuo2FkWu23RqzcZehLG/f/SGvHg
        MDGcozBPyjyVzwSxhLA4OJfSNieyOc+s4Pexg+aiETPdh5CMBpayKWWwyJricEFd
        zbMhSc5+chWQuMaGCapYdg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sn20e3s47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Aug 2023 19:58:41 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 19:58:39 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 19:58:38 -0700
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <chao@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock in f2f2_add_dentry
Date:   Sat, 26 Aug 2023 10:58:38 +0800
Message-ID: <20230826025838.1131325-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <517380b7-77e6-3b79-5156-234b51dbb104@kernel.org>
References: <517380b7-77e6-3b79-5156-234b51dbb104@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ScFUOfPCRpgFf4VONwUJFSCDZq5XNeE-
X-Proofpoint-ORIG-GUID: ScFUOfPCRpgFf4VONwUJFSCDZq5XNeE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=543 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308260026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 18:41:38, chao@kernel.org wrote:
> Can you please check below patch? it has fixed reported issue.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=5c13e2388bf3426fd69a89eb46e50469e9624e56
> 
> Feedback from syzbot:
> 
> https://lore.kernel.org/linux-f2fs-devel/0000000000001ba17a0603b5871e@google.com/
This fix uses nest lock to avoid deadlocks, which I personally believe is feasible.
