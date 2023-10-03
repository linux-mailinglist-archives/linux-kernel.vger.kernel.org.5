Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04307B5EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbjJCB1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJCB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:27:45 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 18:27:42 PDT
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCBBD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696295998;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=zf15RZVskS49B4izrEnaAS5dtiY4DHY/FO3/DSx7haSBK5tshqH23s9ZWoYZiw//U
         QBWBemVtLFoiZBoXE+tY6YqvsxSvZyM0/jAC+XbFXvs/JYhoHw1sAGkXDvg8W2K4QS
         4e9PnPBrJxPH7RwlCVxJv2MH5Bz1uCdnasvqZAZdFBXpC9urGX7ZDO05XeZ6FTLFBW
         V8LY1HLApRxergDVEtosZhJyMnbFkNthlguF804Xz+tWiVKd2F+3A/ZHVwbFVuIo6q
         /9Fc3/G4kmJQ4tYAfM1VPCo+BcrgzHzn5f/H3wFHpKoZB46wg0ESBM/5tifRbUtxXy
         t0e+/wOcuFyjg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 736DD61800F3;
        Tue,  3 Oct 2023 01:19:57 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Yeah Yeah <yeah32857@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 2 Oct 2023 21:19:54 -0400
Subject: Re: [PATCH v2] memblock: don't run loop in memblock_add_range() twice
Message-Id: <A2AF3AD6-255C-4580-AD33-B50AD32A1FBE@icloud.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org
To:     yajun.deng@linux.dev
X-Mailer: iPhone Mail (18F72)
X-Proofpoint-GUID: 0vWBfNo-ZgsKh9-wuNwOxhIR_nRnTIfQ
X-Proofpoint-ORIG-GUID: 0vWBfNo-ZgsKh9-wuNwOxhIR_nRnTIfQ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=18 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=18 clxscore=1011
 mlxlogscore=67 spamscore=18 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2310030009
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




