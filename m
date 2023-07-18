Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBF757B04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGRL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGRL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F918E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689681372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HzrRHf2xvIEmTHm/Gu7FM0e+zDruuUgopzejA6ZU6c0=;
        b=TssADWMud3m77wAmIA8aGmiuRY2zb0IrJsv8h3MK8LeExfXxq1T2vKmUx0QrrXJBasrAxK
        X+NielFzAW9G6Yx+e3f2EumN/Ebp3iQ4LlIsk86S95QEy8IyhmPPAF82Rs302LQax6uD2X
        w/JIy8sbW/KANTQgm5Fg+qYsjGQD4Uo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Rnc4iNATP3O8LLi7ULSGkg-1; Tue, 18 Jul 2023 07:56:11 -0400
X-MC-Unique: Rnc4iNATP3O8LLi7ULSGkg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63788123d11so46781236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681371; x=1692273371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzrRHf2xvIEmTHm/Gu7FM0e+zDruuUgopzejA6ZU6c0=;
        b=Eg+m/v0n0nAMXqMm0ypJSaeh1+UR0XBPaDXDqywLUVPiRqzG2ed9EN/M8+crTafoI1
         PYSpvoC7hkFwYer83l6tMDLo/kgRuSonCEBbBVtI7Rv4COUWsLX8uqSTL/xq5sSLMclG
         QUdpQjPMbQJLoXjQ6E0qWn7A2LiRtinWp6mz5PT81Ee6hQZ/wAT50gsMAGYU6u/FLkMA
         y/EKtu1iV78gZF0hYLwUjMZy0LDRio2SFKvQoSPdy954NcfHYT8g53QOvC5XeJjSKwFz
         Xy4ZqWaw+jHKYQw+ZSl5l636xT4C7cJEXne2GeY8M7xw86jLEBCOhBN2fC8hJ6gbqneC
         264Q==
X-Gm-Message-State: ABy/qLZ0d/DZVfw6D9iT4hclVl/DqrNO9Q5JQqG49v0iu3FUzZXhbNuJ
        M6tNEgD0NBteEKdA0cDzcJBrZ/yX4M/cLjDdBcXSU6vbi0uPolS+NWt1dfkrcSBVph6YVY+gXCx
        WGlaRTIDCbwzNvdqJbflwHIcn
X-Received: by 2002:a0c:e283:0:b0:623:9ac1:a4be with SMTP id r3-20020a0ce283000000b006239ac1a4bemr2032995qvl.12.1689681371139;
        Tue, 18 Jul 2023 04:56:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSJUN7slcgvMgDdDG5JP24NhEZr3/218cgdV5hvCjvLFTCVdt9XTG4M2tXJraV2xCUUP3dVw==
X-Received: by 2002:a0c:e283:0:b0:623:9ac1:a4be with SMTP id r3-20020a0ce283000000b006239ac1a4bemr2032986qvl.12.1689681370899;
        Tue, 18 Jul 2023 04:56:10 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i4-20020a0c9c84000000b0063612e03433sm657864qvf.101.2023.07.18.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:56:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: don't audit the capability check in io_uring_create()
Date:   Tue, 18 Jul 2023 13:56:07 +0200
Message-ID: <20230718115607.65652-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check being unconditional may lead to unwanted denials reported by
LSMs when a process has the capability granted by DAC, but denied by an
LSM. In the case of SELinux such denials are a problem, since they can't
be effectively filtered out via the policy and when not silenced, they
produce noise that may hide a true problem or an attack.

Since not having the capability merely means that the created io_uring
context will be accounted against the current user's RLIMIT_MEMLOCK
limit, we can disable auditing of denials for this check by using
ns_capable_noaudit() instead of capable().

Fixes: 2b188cc1bb85 ("Add io_uring IO interface")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2193317
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7505de2428e03..a9923676d16d6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3870,7 +3870,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		ctx->syscall_iopoll = 1;
 
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
-- 
2.41.0

