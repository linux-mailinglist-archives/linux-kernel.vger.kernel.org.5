Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD587DF9CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbjKBSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjKBSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A7137
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yH09Py8IYRdWEq70yMXJ3wDczRklXyABpCu4Oku+uko=;
        b=craN23vT94oPqNZLksryG1IPTEnP2L66If6HlaOlqgS4HvWCYcsgULTK90mADicboyK1GW
        G9aSDOzU95GWp8FkLQrOky9N3TarrFoMvvOYPsLLsNh1/i+UQNWrAh1bFHJfy4FHQs7NYA
        Rx8yRpIFDCkt6ISsEsHfZieKNsIgQes=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-azxNW6RgMiKT8INuitfV3Q-1; Thu, 02 Nov 2023 14:16:04 -0400
X-MC-Unique: azxNW6RgMiKT8INuitfV3Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507df68e881so307285e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948963; x=1699553763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH09Py8IYRdWEq70yMXJ3wDczRklXyABpCu4Oku+uko=;
        b=rn2l5TwB5aoyJFv7KjW57Jn6zpW2UvmZ1EhsWf0XYAVlsplqTZHhjk4CwRlbw/tP7d
         EsXUek7NxvU5q3CAEbn89l3tkHYvz+1X2ZFTM8GgPHnH2FwzI/uRCRGHzG0+0VrYex3C
         KtMUJszJcrwvbcYPr9dNMgQMgj/vzY9dYgwWpzLE9j9KtS9DqAYEXQssgzyar7+23r65
         dXeFE6qRIedSuvb+NmCnMxtmspkk7VDNAwzCsg/57k+UgNwcNhf/q9YkCwRla97QuFtO
         j1/K8hYhJS6U9ptzYXiJFTR41xqJKM+nUDBLVDt+C3NnScVw7FHgDWrnsSgSR/cVxypK
         0W5g==
X-Gm-Message-State: AOJu0Yw5IgvHTPDhj/1rHp59lBjMnlRWwa3uNXWvx4jKf+wyZ0OEhKng
        EYAVT9n0x/aC5/ClqmSXEYhGfsdikTdT1BVnFRcp3QmcraiV2UB5ftupnnFxaDOJb4LzcjgBDeU
        RYnlB5mhsJaL0rPAjkA8xSp+I
X-Received: by 2002:a2e:9695:0:b0:2c4:ff24:b02e with SMTP id q21-20020a2e9695000000b002c4ff24b02emr14483934lji.3.1698948963410;
        Thu, 02 Nov 2023 11:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS1zGZUHtg3KOcze+sfSekgUGd8coQqnik/gqhe4Qn0cg6IP3P+fkjw/XDjmt/1fT6T4eXsA==
X-Received: by 2002:a2e:9695:0:b0:2c4:ff24:b02e with SMTP id q21-20020a2e9695000000b002c4ff24b02emr14483906lji.3.1698948963067;
        Thu, 02 Nov 2023 11:16:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
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
Subject: [PATCH 3/3] virt/kvm: copy userspace-array safely
Date:   Thu,  2 Nov 2023 19:15:26 +0100
Message-ID: <20231102181526.43279-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
References: <20231102181526.43279-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_main.c utilizes vmemdup_user() and array_size() to copy a userspace
array. Currently, this does not check for an overflow.

Use the new wrapper vmemdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 virt/kvm/kvm_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 486800a7024b..2a2f409c2a7d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4932,9 +4932,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			urouting = argp;
-			entries = vmemdup_user(urouting->entries,
-					       array_size(sizeof(*entries),
-							  routing.nr));
+			entries = vmemdup_array_user(urouting->entries,
+						     routing.nr, sizeof(*entries));
 			if (IS_ERR(entries)) {
 				r = PTR_ERR(entries);
 				goto out;
-- 
2.41.0

