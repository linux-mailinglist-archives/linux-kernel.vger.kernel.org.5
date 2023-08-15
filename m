Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3C77D4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbjHOVAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbjHOU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:59:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470B199D;
        Tue, 15 Aug 2023 13:59:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9923833737eso773479066b.3;
        Tue, 15 Aug 2023 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692133180; x=1692737980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0gF3RLU8dnkJW3L2cW1INKAdZ4sC+saPsSk/51D5P0=;
        b=DqZuiE5Bkt9zzEHpxzo3DXd8bHwi4MbYJx+Q9rPqeYh5pS4Nl6t+QSM6hxYVO0s2yX
         gIFVoTmPEE/TvLJVfDvenylbEaUrLdI7mETf34kD1zk1P6t7eGjQfrbBqeHTp8n4vWVX
         iIHmBO//AtE9EflYlWzhQ2M61rYUugh9TKa4VR7NM1vfXZV9jtQkMSASlM3+xz1gASog
         qI3Il8PUGASuTvaoLmNCXNZJ6V172qUNDwpevP6D4562wsNPEyxDSHkcRgXQheljEC6N
         9g5NIvAE+Eo7R2b0Iz685urOd1uNBCRkbrQOdvD6p1ynLD/RjauH1LcLT5hh1PV0QdVv
         gDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133180; x=1692737980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0gF3RLU8dnkJW3L2cW1INKAdZ4sC+saPsSk/51D5P0=;
        b=a18H8kp1RKoS4KkOBEVo4mTZF3OKed+0HHUrS4Le2m2tc1LXeUkJA62RD9b/Xrrjtq
         nrZ+suqpekuawViY3RP7V6Fu9VSEj87iXdGQ85FZaJkySTBPm4oNTlydg6nXHa9Akz84
         HgvVLIjIg+rsoRRA/GIls+xYcvMcijefn3NS2k5Tssndp5Kjlga4lTjCjLwT2piVE1SY
         PHePXtE3dHwqfTV5Nm//gVSUF2xLgqeoTBmFv0ntDqs6cpFDm6iNDEUT5NRxBO5INnMO
         xHZRvi0b4HmNhB5ZVz6hfmDFBWc77/jXgwiP29OsNdbP7UF4Dc7oFRg3eb8PbDsVdq34
         A/PQ==
X-Gm-Message-State: AOJu0YyBeNMGPm06uMJwrGkaKnDAOduniRRAb5cNJKAw11j4+tGNGJTt
        Qn3Lsq7JN+BdYxWQ3qORnmQ=
X-Google-Smtp-Source: AGHT+IH/aGPaNuYrE5FIpeUUEiwDKzx3rBtDl7UzVKwQZ2oG7sty6u4UgJRwrt201to403XS7aFJtw==
X-Received: by 2002:a17:906:847a:b0:99d:9adc:cd76 with SMTP id hx26-20020a170906847a00b0099d9adccd76mr7710287ejc.0.1692133179701;
        Tue, 15 Aug 2023 13:59:39 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b0099297782aa9sm7469235ejs.49.2023.08.15.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:59:39 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH 0/1] netlabel: KMSAN warning
Date:   Tue, 15 Aug 2023 22:59:16 +0200
Message-Id: <20230815205917.1504837-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to use KMSAN and found the warning in
security/selinux/hooks.c which triggers each time I use the official
guide to run syzkaller reproducers

Link: https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run-a-c-reproducer

I'm not quiet confident what are the rules in security subsystem. It's
not a bug, but a warning which is triggered by KMSAN for the argument
of the security_net_peersid_resolve() which was not initialized. It
will not affect anything inside this function, at least with the
current order of checking the variables, which might eventually
change.

Please reply if you're ok with such not-a-bug fixes. Otherwise I'll
just ignore this warning in my experiments with KMSAN.

PS: most likely if fixes commit 220deb966ea5 ("SELinux: Better
integration between peer labeling subsystems"). Not sure if this tag
is needed for this patch.

Andrew Kanner (1):
  selinux: netlabel: Prevent KMSAN warning in
    selinux_inet_conn_request()

 security/selinux/netlabel.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.3

