Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B07DEC42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348546AbjKBF3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348519AbjKBF3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:29:21 -0400
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AD2112;
        Wed,  1 Nov 2023 22:29:15 -0700 (PDT)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
        by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A25HwKi009350;
        Wed, 1 Nov 2023 22:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=Zr+QxWsvtCyo8uor4ixTMhNR7r7rrnW/AV3MxmJqFak=;
 b=PKV08OY9Ez0bKJ2kCEM1DRWCLQ4EeEAWOd4rjApMHlD+cDVcOFGmwwgBHY7f4hyZMwi/
 eJ+WN++uEGFlazzsVCAuKj3e8w9G3up0Lz46It9G+jWLdNeFZLCVzkx7MLI9Z/XUDhkS
 kER5uw0JfY2hmT7PW5Eeja5WI+s4wDmr6PEwU9TIxGkiZyvU9ZIyh+Nzd2hoJH7nXjYi
 Deq7ss9QzwNspSy9ZFJL/a7/gypfbfxF3IdLvpX1LbfqO7QgaXBXvOt0hW1+YJjrk/0o
 5uLXv+mUwOJTa6cmbAJh0HIuDjT/owk28h4Rjtf3dOdLJQf6MSb2gwdtoVUCPCuj/1NO SA== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx4.spacex.com (PPS) with ESMTPS id 3u0yqn6cce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Nov 2023 22:29:13 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 22:29:12 -0700
From:   <alexey.pakhunov@spacex.com>
To:     <michael.chan@broadcom.com>
CC:     <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH 2/2] tg3: Fix the TX ring stall
Date:   Wed, 1 Nov 2023 22:29:02 -0700
Message-ID: <20231102052902.3272319-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CACKFLi=Eh2ase5qnQ0ioYL+yS6-oSeZreHsaqAn9Zgwkv_d-Bw@mail.gmail.com>
References: <CACKFLi=Eh2ase5qnQ0ioYL+yS6-oSeZreHsaqAn9Zgwkv_d-Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d3-n2.spacex.corp (10.34.3.237) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: tPgsIivSKCgySAzI5He5wXBOmRf0JHWU
X-Proofpoint-GUID: tPgsIivSKCgySAzI5He5wXBOmRf0JHWU
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=797 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Let me re-test the goto version and resubmit it as v2. Please let me know
> > which version of the patch you prefer more.
> >
> 
> I did not realize the goto version is almost as big.  In that case,
> your original version is fine.
> 
> You might want to declare the variables in reverse Xmas tree style for
> any new code.  This driver is old and most of the existing code does
> not follow that style.

Copy, thanks. I'll reorder the locals in tg3_start_xmit() and resubmit that
as v2.

Alex.
