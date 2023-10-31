Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94C7DCD07
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbjJaMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872EFB7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=c1BRe9qNm8b87vPyUGX8p25CFwIxJGN5aVLu3MRADHuhPiLZ4vroJc0+sA3b+Ml2ktuCz0
        CaDrhIiGdEEt5RrIJqHwpvGjNt2kOt+yIHLH6QfzG+tb7VyFwm1CluSLCgECnxAo5bbxoj
        HIDwN89XtgMeJkfKsEhuOsRVVXY6/28=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-7nt6u-DQPCOeR0mAprKKCA-1; Tue, 31 Oct 2023 08:32:10 -0400
X-MC-Unique: 7nt6u-DQPCOeR0mAprKKCA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-779f645c74cso698897185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755530; x=1699360330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=gNtlsoA59b3M7Juz9zzlYNu04E7bK0Na1+g4b31FxehyPWRwanx2x71BPm5cn5GSyo
         /StANHL0kNbHjJR+nDfn7vn1t+n+tQMNbSB5MUFx0m9O23/5UNAthj1Mtt4jIwpPO7ts
         +MHuoEdN9edo8nXydLL600v/f1TODGGmSSPEYwhUmJfoRvmJtIauuJkkLRB1c88EJxcl
         mmCNuKFk9ldvskx6L1vXdzClD/IcepPvDgpMPgtTOUMmedQlCFufkJJ0Tbnsc+NSA4Cj
         Bp1EHSSc4ETaTcIZm/l1pK6sIhnepdmbzVyd8DuzdFbqGy1eBgfJ91FyVkRVjUp3qMk3
         TkSQ==
X-Gm-Message-State: AOJu0YyXPl9KYBUVbA5v8MIu1YtSO+JOdrYQvPapjR76jgn00d0DMmJ/
        9EL3GRp6wUYRQ7qnTZ6GP8cunDIb7ljVdqLGfTZ/UzLxizetACEKK23wNzYOCAuIL+RBXjatsQR
        jKGr3u6cz8kMcB+cC0Dske0HU
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316844qkb.53.1698755530346;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRF2hQntJG+GwSak9Gg0Fe+r97U8evGxvH+rsbr7bRKRAzBo2stdiR75AFPLvChPFBieDyLw==
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316823qkb.53.1698755530070;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lsm: fix default return values for some hooks
Date:   Tue, 31 Oct 2023 13:32:05 +0100
Message-ID: <20231031123207.758655-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the default return values listed in <linux/lsm_hook_defs.h>
don't match the actual no-op value and can be trivially fixed.

Ondrej Mosnacek (2):
  lsm: fix default return value for vm_enough_memory
  lsm: fix default return value for inode_getsecctx

 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0

