Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB87EA26C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjKMRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:52:29 -0500
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F510EC;
        Mon, 13 Nov 2023 09:52:26 -0800 (PST)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
        by mx5.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADG7ufB026420;
        Mon, 13 Nov 2023 09:52:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=OAedADIDq7Yy/leBF8yLvmN9Q5ZHAfPjVXFuK05A8Vc=;
 b=mz296ekGLs70ZxPAJF0XIvMpdOeHglBRTI+pNcSlk4BrQP6Kr7Iigz1tY1KNi6o+jRRb
 /noTs+2XV351CMpprXq9xMVadi61hb7AQFoY+qvhHe2zFqb69kmT1w+Xa2Pm9+vBEf7g
 OqDpvec4eecutQir9Llv3fqzfU3yCQTkB6e0tnZvMJ+dcMwFGMNn01fOFRHR4WdaYlAa
 SKh1YUoJL1rRAV1qR2+8jTsfP0vCoomdmefdfXxUAGf4WisLB2qihxPE978d9mm3TYRw
 cY+pciNDAMxHo+dFYjrEFn02l4uAgPsNUvAE3nxeZOTUj3s2Jq94/uk930Ui01cWTM0U QQ== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx5.spacex.com (PPS) with ESMTPS id 3ua7wsa55f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Nov 2023 09:52:17 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 09:52:16 -0800
From:   Alex Pakhunov <alexey.pakhunov@spacex.com>
To:     <andrew@lunn.ch>
CC:     <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Date:   Mon, 13 Nov 2023 09:52:04 -0800
Message-ID: <20231113175204.4193922-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
References: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d4-n2.spacex.corp (10.34.3.240) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: _5hxAL3tMxclKqisjqg7aZvMArbTyrld
X-Proofpoint-ORIG-GUID: _5hxAL3tMxclKqisjqg7aZvMArbTyrld
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxlogscore=562 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Isn't this wrapping artificial? old_stats is of type
> rtnl_link_stats64, so the counters are 64 bit.

The wrapping here is needed as long as tnapi->[rt]x_dropped counters are 32
bit wide. It makes sure the resulting value is correctly wrapped.
tnapi->[rt]x_dropped counters are 32 bit on 32 bit systems to make sure
they can be read atomically.

> Why not use include/linux/u64_stats_sync.h, which should cost you
> nothing on 64 bit machines, and do the right thing on 32 bit machines.

It should be possible to use include/linux/u64_stats_sync.h but it seems
like overkill in this case. First, we mostly care whether the counters are
not zero and/or incremening. We typically don't care about the exact value.
Second, the counters are unlikely to ever reach 4G. Essentially, they are
incremented on memory allocation failures only meaning that the system need
to be in a completely wedged state for a very long time for this to happen.

Given the above additional complexity of u64_stats_sync.h does not seem to
be worth it.

Alex.
