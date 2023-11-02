Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F767DF9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377196AbjKBSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjKBSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556A194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgG3A5hpFrp+6V7xcOap0dfvpVeqP5J5h/8swybWPW8=;
        b=AmKeNG6e5TGAmov2bQOQ1EysZ4KQklR/7TXeewd+jGPyLxfPHn5T9d0BEEvy/xefL6F1MB
        IWHk/IoFW9gAe01jfrFvoNErDm+78E+A8DJSFnAFYrp26F4FlSjI3TQIH0A/hIrRhYjZ/9
        4vak1+LpLGk/nmbSVc5rqCJqFyZPiAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lGH64hU8O6e7uXzPjSK1ZA-1; Thu, 02 Nov 2023 14:16:03 -0400
X-MC-Unique: lGH64hU8O6e7uXzPjSK1ZA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083a0fb583so1417885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948962; x=1699553762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgG3A5hpFrp+6V7xcOap0dfvpVeqP5J5h/8swybWPW8=;
        b=ZsgiLVjWAAudh31TEr8FuJaIMcBG1k8OSybA9I6RRMpqxWy5uLfGjeTwzRITe6Pcw+
         GG99TEGdibRIqM8bnBGjdMYAI7TsLjIn7Td/w89pr7i38kU1OAtFpwvLYvZ3gHCPBWG+
         J0eRKKdPeERK85Fl8Bf/pXVuHOjGmo2J4HZohrbye5v7I2Yy9Tt7WOFS7ob1o6KAoKEO
         grnh1aldEuhJSVEUbbaqbQIgEztwKC2nK2OjIbJP3w4pekWyyhyc5BHUZmuKyLR22qAI
         JpYK+yhcLgIYFk0+nk+t+ia0Gk6AztWMH63scv9gY4ZcVpCo69ak1SpOL/1PIAWQCbZJ
         eM4A==
X-Gm-Message-State: AOJu0YxaBwGUWDcDLafm+WCRel6gUpOBcX6AtKhsMJ2xJtbZslK7vZlI
        2fY9NkYT09CcKC4vYQmm8ikrxLfV8Z+z4G3qSZfufVR2Xv29xjL9ggrxQ9sFkEekylyn+H2iAfR
        he1zrOaJigBjGp3QV3WQQ1lbv
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15629793wms.4.1698948962009;
        Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjTetfCnz62A+Ip2Hdlm3nuttWd2b6W3o5YuoU7reIi83z2x4Kzw5EwS3QOFs2J4hJ+0CIUg==
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15629783wms.4.1698948961745;
        Thu, 02 Nov 2023 11:16:01 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:16:01 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 2/3] arch/s390/kvm: copy userspace-array safely
Date:   Thu,  2 Nov 2023 19:15:25 +0100
Message-ID: <20231102181526.43279-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
References: <20231102181526.43279-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guestdbg.c utilizes memdup_user() to copy a userspace array. This,
currently, does not check for an overflow.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 arch/s390/kvm/guestdbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 3765c4223bf9..80879fc73c90 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -213,8 +213,8 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
 		return -EINVAL;
 
-	bp_data = memdup_user(dbg->arch.hw_bp,
-			      sizeof(*bp_data) * dbg->arch.nr_hw_bp);
+	bp_data = memdup_array_user(dbg->arch.hw_bp, dbg->arch.nr_hw_bp,
+				    sizeof(*bp_data));
 	if (IS_ERR(bp_data))
 		return PTR_ERR(bp_data);
 
-- 
2.41.0

