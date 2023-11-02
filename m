Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9B7DEBB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbjKBEME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348519AbjKBELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:11:38 -0400
Received: from mx2.spacex.com (mx2.spacex.com [192.31.242.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578310FE;
        Wed,  1 Nov 2023 21:11:04 -0700 (PDT)
Received: from pps.filterd (mx2.spacex.com [127.0.0.1])
        by mx2.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A23pP4E020474;
        Wed, 1 Nov 2023 21:11:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=371HGp4VtkteU+yfBnvfrctAAxL1/12Kf/eiF8Y+EDk=;
 b=IXp8MfDDd/XfUTOttyFb+V8YTIX2aqenmCEtvcy9DQCdCdb9WYt7l1gDffTZk9MY+Z6T
 pn2L0i7P/h6M8ObnmBVzDFie7szMCJiofl4u2DJqv12kpHxQEk5qWkw24yt8uugO4noU
 SwhSld9RDAa0uynB8f8x1zi+Q4NFSwMPT85r7R3YqJcsS4P0CNQBH+fuNejMnf45Me5Y
 aBlpT9FOnk99TsyxhUxtvOjT0Ug//gqoVQ34o+Ogod3e7cYCbjubMK/vJgtO7nZdUbXw
 xk6awOmBzWrw1RQZ+9AeJwc8jjuRFMcV9f/baaX3YTfavLzh93mUnQ95zermM4+dfcDe Yw== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx2.spacex.com (PPS) with ESMTPS id 3u0yqheay2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Nov 2023 21:11:00 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 21:11:00 -0700
From:   <alexey.pakhunov@spacex.com>
To:     <michael.chan@broadcom.com>
CC:     <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH 2/2] tg3: Fix the TX ring stall
Date:   Wed, 1 Nov 2023 21:10:45 -0700
Message-ID: <20231102041045.3103307-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CACKFLikNku0_9=MNjj=X+RvO_omTtg5TicQeM5oWfk0NSxiqwg@mail.gmail.com>
References: <CACKFLikNku0_9=MNjj=X+RvO_omTtg5TicQeM5oWfk0NSxiqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HT-DC-EX-D2-N1.spacex.corp (10.34.3.233) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: 8sXkYA2htpe2wEmJEpNadIcFU5U5q9hb
X-Proofpoint-GUID: 8sXkYA2htpe2wEmJEpNadIcFU5U5q9hb
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=952 clxscore=1011 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Thanks for the patch.  An alternative fix that may be simpler is to
> add a goto after calling tg3_tso_bug().  Something like this:
> 
>         tg3_tso_bug();
>         goto update_tx_mbox;
> ...
> 
> update_tx_mbox:
>         if (!netdev_xmit_more() || netif_xmit_stopped())
>                 tw32_tx_mbox();
> ...

Yes, I considered this approach but in the end it seemed more fragile. All
future updates to tg3_start_xmit() would need to be careful to make sure
all return paths go through "update_tx_mbox". This is much more
straightforward with a separate wrapper function.

The sizes of both patches are roughly the same. The wrapper function
version:

 drivers/net/ethernet/broadcom/tg3.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

The goto version touches four different return paths: three tg3_tso_bug()
calls and the return at the very top of the function:

 drivers/net/ethernet/broadcom/tg3.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

Let me re-test the goto version and resubmit it as v2. Please let me know
which version of the patch you prefer more.

Alex.
