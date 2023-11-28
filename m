Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297C7FC85D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbjK1Vjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK1Vjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:39:52 -0500
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 13:39:59 PST
Received: from mr85p00im-zteg06011601.me.com (mr85p00im-zteg06011601.me.com [17.58.23.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA6699
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
        t=1701207022; bh=8EgrIGGkKnoJKisc1H42SGVc/w0J4XCT9HdiJld5EXw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=IwyqayvjwD1xQmxscxr7LH4lWhHQ1vHpJOMcjhUUCEmDvIifRESLlm644nFnA0OVf
         wBAq/gd/5TqPhxBy7W2DoQNU375PVThmJkVNuiJTDdTUvx+jzksH3cwKZsJzKFVkC9
         XspyLNimzZg1CuYKRCg0J4r1eiZ4plFnooZ8kGcw5yYlAJGS7uahT0B9heCYUzGDEP
         Kq5kypb9omKe4li/vOQ6wzzdD2REKbvp/2WkQctaofNRlRpNMIOy5iTESe/K510XiV
         idF806M3ZTSjv0n+YsBNZX53J8oRLTomrzcxpTSXl4Nb9yrqltnMgNm4IuYcKZqys7
         VN/HFGzvy2h1w==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id 6B4D71804BF;
        Tue, 28 Nov 2023 21:30:20 +0000 (UTC)
From:   dan@danm.net
To:     toralf.foerster@gmx.de
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference, address: 0000000000000020
Date:   Tue, 28 Nov 2023 14:30:18 -0700
Message-ID: <20231128213018.6896-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2b5d6cd4-0afb-4193-ab88-235f910a7293@gmx.de>
References: <2b5d6cd4-0afb-4193-ab88-235f910a7293@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yHOGWyb5AYz0eJuRV1grMCXODbeaoiHr
X-Proofpoint-GUID: yHOGWyb5AYz0eJuRV1grMCXODbeaoiHr
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=470 malwarescore=0
 spamscore=0 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311280171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing this too, but on 6.6.3 (6.6.2 is fine).

Bisected it down to commit 2e8b4e0992e16 ("gcc-plugins: randstruct:
Only warn about true flexible arrays"). Reverting that commit on top
of v6.6.3 makes it go away.

I do wonder if content such as that (which *looks* like it's purely
preparing for future changes) is appropriate for the stable trees.

Cheers,

-- Dan
