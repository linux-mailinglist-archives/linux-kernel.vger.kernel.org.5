Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D977AB0E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHMUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHMUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:08:37 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7710F6;
        Sun, 13 Aug 2023 13:08:38 -0700 (PDT)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.4])
        by mail.ispras.ru (Postfix) with ESMTPSA id 51F4B40F1DCD;
        Sun, 13 Aug 2023 20:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 51F4B40F1DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1691957315;
        bh=aAUGuClVCL2l6tb8cgm/NDi9zW81/np9gFGNuwtgWHo=;
        h=From:To:Cc:Subject:Date:From;
        b=TbNO57zV+byHKgV/3vOBM17f3NxsLFPORHq9sQFbJWfPzb0EZR3OmuwrLOAl7Yioz
         3kqh/rNT/dU0L1UYvVWeuUcRZwzTS6Z2s+puPKU6DtdMewXPumHdhPP4Tgkes2fUz5
         uOhBXj2QwlXcm6Wdb/0/G4JNuvVP9yrdCAPBh8u4=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4.19/5.4/5.10/5.15/6.1 0/1] sch_netem: fix issues in netem_change() vs get_dist_table()
Date:   Sun, 13 Aug 2023 23:07:45 +0300
Message-Id: <20230813200746.288589-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
was backported to older stables where it is causing 'sleeping in invalid
context' bug. The following patch fixes the problem and can be cleanly
applied to the stable branches affected. It was backported to 6.4.y about
a month ago.
