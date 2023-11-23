Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C57F5521
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKWAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:06:53 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8F11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:06:50 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso409384b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700698010; x=1701302810;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTdAz8rR/cyp5kTMf3sQ+1Xdn84UuzjX2VTkhXz5Uzo=;
        b=QL7QU1b0FBMr533XjYj3AjyofeVNz7HNCMm5ynhiRMuj5HasFYfeoT6zUspxKl/FWP
         uhyRZzMxMvv5OmlP/FOxdRIDw8PgB+TA+5Mu9SsLHLZu0uaorV6mwUv9dsFyrx5RLax7
         rEhFDVBO3hl2czPEtAbbuMWv1VfomAMA6r3PzMzOvKk7Q8GwniCnP1byEPva83tLK4ao
         6JxCIa1oh1zZqC1YoeZxbeLF+/WfkchB6FWFUd6fhbZXjK6OK92e069kMGD+RQHU4lsA
         uhUMZUT0Em5MTOit9MSyeWH+0ZMd8P3y515NTDCuBeVfwsENBUjQU0S0eFMk/f7JGP9S
         Sa9Q==
X-Gm-Message-State: AOJu0YztzKMMAz0ABIMZKXBF95RXf0zAsp40rRdwWWtaEb6u5Es/ouj2
        iaczSbKzq43bgNE9p5vlZDZuv+Myv7uqvAaTjQUQExAnhs211MU=
X-Google-Smtp-Source: AGHT+IG2OO9lH5PEb+VcMwa2PtA3qnZlWCdgzyzzL+XluFlLlo0Om/02ILlHjViUzws2UfPsLHU47unbnYIaJhA3usG1zs8Cvh+O
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1d19:b0:6c2:bca7:640b with SMTP id
 a25-20020a056a001d1900b006c2bca7640bmr1017193pfx.3.1700698010207; Wed, 22 Nov
 2023 16:06:50 -0800 (PST)
Date:   Wed, 22 Nov 2023 16:06:50 -0800
In-Reply-To: <000000000000545a26060abf943b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4cb01060ac69c14@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From:   syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
Author: eadavis@qq.com

please test uninit-value in mptcp_incoming_options

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2d5304e6c64

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..c53914012d01 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}

