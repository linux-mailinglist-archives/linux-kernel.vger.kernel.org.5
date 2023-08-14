Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25277C254
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHNVUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjHNVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:20:30 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 14:20:19 PDT
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CB1738
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1692047578;
        bh=sXNOdpjVSoGACiNLSt1LtJ2VQ3gpPHhhH84Rspe2eRU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=X93EkCxlcj66jV4B5EAdKTiBfyVn01NxLqykX1JnfLip0wCR1JfOSXfk/a8UhMwbb
         CwW4iTsFyTrZwKrJ5s7g5hRloWpHCPNCD8W5+zuUk/58bkqZTcnt5nr7oHInouxDf6
         OJP6CxhBX4k4v4hdRUPas7iMLp8p5UvlDKnCjkwDRgMSl8N60cTxLkM0ySpm5IsUgo
         d6I4OXQRmnfnzKJ3hKq4tvGs0cffgmqNVbc5c7IV1TjeBMOxNy9C7UGYnRYe3tlnGd
         qhfGG3kHdhe+boadldhKVfz9Ltgyrk4WgaFvK1NHYMtlcdBJTX/mem2DEUc2irO9sZ
         s5bY3yHrBCFFQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 3AAC99004AC;
        Mon, 14 Aug 2023 21:12:57 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Claudia De-Massari <c.dem@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 14 Aug 2023 23:12:44 +0200
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-Id: <1673EE78-1C27-407F-9785-6751FFC12811@icloud.com>
Cc:     chaorace@gmail.com, dmitry.torokhov@gmail.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthias.benkmann@gmail.com, mkorpershoek@baylibre.com,
        nate@yocom.org, pgriffais@valvesoftware.com, radon86dev@gmail.com,
        rojtberg@gmail.com, s.demassari@gmail.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        vi@endrift.com
To:     dzm91@hust.edu.cn
X-Mailer: iPhone Mail (20G75)
X-Proofpoint-GUID: 3uCci-yaljfv-k_IcH-VH5h37uLRbdrW
X-Proofpoint-ORIG-GUID: 3uCci-yaljfv-k_IcH-VH5h37uLRbdrW
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=584 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2308140196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I am the mother of Santosh De Massari .
santoshde-massari@mail .com

I have to tell you that he is diet last year.

Greetings

Claudia De-Massari
