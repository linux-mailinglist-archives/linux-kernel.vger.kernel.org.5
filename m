Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A682F7F45DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbjKVMVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbjKVMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:20:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E88198B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:20:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ce5e76912aso43664035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700655615; x=1701260415; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlWhbaH6pQ32e6fkOvxOUl4wt3D1WjG9yqrkaFOp/Vk=;
        b=K1jcjtSa45n7Bn0w9hEoM2jtN1RwlkGEgc2uzl/QLw8O3nhsZQw0TdyzNBL3bKLqjh
         C0Mxr9QOwaVpKjIp2NaxxkckK56kK7+huHIT+uycHLTphkEz5KUgqIobGsO5IQDn8Wmn
         zMlK+VjQ8wUs3MxEM8Yjg7FLw6y/nviZkeyAjOzbgwNqZXGGnY8yyVwB7MMCccLVH3oS
         UJmWN7rt6YNm/nCZJyM6X0rYznamVQHV0EwA6NXHKdCbyL0rlMxR5A6vdgYePmvIjVzD
         Ke4zkJt8sqpxzOteKKFFmbJLpvChojyhAAJWeSd+OByc1+HEJr3bL5tYwnm8Yh2Lm7OI
         zq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700655615; x=1701260415;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlWhbaH6pQ32e6fkOvxOUl4wt3D1WjG9yqrkaFOp/Vk=;
        b=GJXZp9gQy6jna4QlacBYe/OgEwg3eMSwCyaiOrkkzBRxw/N7EeqsqyhmkJNQGoJxAS
         6IGdvkpBwknbFSuSgz4SmxmQh0mc/PuTi5ajTnxG3pQbb0H7ioYkEdyLn13XxuLZm6Wx
         naBeU5sjZ3moW6qKpUmjYmA2gs3e8UXnoKc02vzfXXqlcHRKFpsmQEUSFDfb+G021jjs
         tSx+puJVPG271JHwGlPx7AourATvHqP1VvgX0cRdV/v6GZjf0KEeo4jM/6CbppJVZT4b
         JvSrnTL1xFx+iOg+rlpwaaLeTcavPkIxMq+nqSxuhUDNlYxNNZGkSrD/SByBztFIlYuE
         ie/w==
X-Gm-Message-State: AOJu0YzK7X4mAXaYB9wjiAurrDMh9TtZ1O9ZdwgGF6HiIFf/W7nTCqAu
        fhxvYWYyyXkD9Vv+QYUZOPtxyKZcBnpcrg==
X-Google-Smtp-Source: AGHT+IFYHWZxF7hp76jWe1gWtmFxAlunhcAXQtLDfMk3Sv5ZsfDFopRc7eJ7xFIbpFS9COcAYcE8pA==
X-Received: by 2002:a17:903:2347:b0:1cd:fce2:d702 with SMTP id c7-20020a170903234700b001cdfce2d702mr2535728plh.15.1700655614591;
        Wed, 22 Nov 2023 04:20:14 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001ca4c20003dsm4225586plg.69.2023.11.22.04.20.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2023 04:20:13 -0800 (PST)
Date:   Wed, 22 Nov 2023 21:20:08 +0900
From:   Yewon Choi <woni9911@gmail.com>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     threeearcat@gmail.com
Subject: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <20231122122005.GA4661@libra05>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
and vmci_host_dev->context may cause uninitialized data access.

One of possible execution flows is as follows:

CPU 1 (vmci_host_do_init_context)
=====
vmci_host_dev->context = vmci_ctx_create(...) // 1
vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2

CPU 2 (vmci_host_poll)
=====
if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
	context = vmci_host_dev->context; // 4
	poll_wait(..., &context->host_context.wait_queue, ...);

While ct_type serves as a flag indicating that context is initialized,
there is no memory barrier which prevents reordering between
1,2 and 3, 4. So it is possible that 4 reads uninitialized
vmci_host_dev->context.
In this case, the null dereference occurs in poll_wait().

In order to prevent this kind of reordering, we change plain accesses
to ct_type into smp_load_acquire() and smp_store_release().

Signed-off-by: Yewon Choi <woni9911@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index abe79f6fd2a7..e83b6e0fe55b 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
 
-	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
 		vmci_ctx_destroy(vmci_host_dev->context);
 		vmci_host_dev->context = NULL;
 
@@ -168,7 +168,7 @@ static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
-	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
 		/*
 		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
 		 * sure that context is initialized
@@ -309,7 +309,7 @@ static int vmci_host_do_init_context(struct vmci_host_dev *vmci_host_dev,
 
 	mutex_lock(&vmci_host_dev->lock);
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_NOT_SET) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_NOT_SET) {
 		vmci_ioctl_err("received VMCI init on initialized handle\n");
 		retval = -EINVAL;
 		goto out;
@@ -346,7 +346,13 @@ static int vmci_host_do_init_context(struct vmci_host_dev *vmci_host_dev,
 		goto out;
 	}
 
-	vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
+	/*
+	 * Make sure that ct_type is written after
+	 * vmci_host_dev->context is initialized.
+	 *
+	 * This pairs with smp_load_acquire() in vmci_host_XXX.
+	 */
+	smp_store_release(&vmci_host_dev->ct_type, VMCIOBJ_CONTEXT);
 	atomic_inc(&vmci_host_active_users);
 
 	vmci_call_vsock_callback(true);
@@ -366,7 +372,7 @@ static int vmci_host_do_send_datagram(struct vmci_host_dev *vmci_host_dev,
 	struct vmci_datagram *dg = NULL;
 	u32 cid;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -422,7 +428,7 @@ static int vmci_host_do_receive_datagram(struct vmci_host_dev *vmci_host_dev,
 	int retval;
 	size_t size;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -453,7 +459,7 @@ static int vmci_host_do_alloc_queuepair(struct vmci_host_dev *vmci_host_dev,
 	int vmci_status;
 	int __user *retptr;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -522,7 +528,7 @@ static int vmci_host_do_queuepair_setva(struct vmci_host_dev *vmci_host_dev,
 	struct vmci_qp_set_va_info __user *info = uptr;
 	s32 result;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -570,7 +576,7 @@ static int vmci_host_do_queuepair_setpf(struct vmci_host_dev *vmci_host_dev,
 		return -EINVAL;
 	}
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -641,7 +647,7 @@ static int vmci_host_do_qp_detach(struct vmci_host_dev *vmci_host_dev,
 	struct vmci_qp_dtch_info __user *info = uptr;
 	s32 result;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -668,7 +674,7 @@ static int vmci_host_do_ctx_add_notify(struct vmci_host_dev *vmci_host_dev,
 	s32 result;
 	u32 cid;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -691,7 +697,7 @@ static int vmci_host_do_ctx_remove_notify(struct vmci_host_dev *vmci_host_dev,
 	u32 cid;
 	int result;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -715,7 +721,7 @@ static int vmci_host_do_ctx_get_cpt_state(struct vmci_host_dev *vmci_host_dev,
 	void *cpt_buf;
 	int retval;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -747,7 +753,7 @@ static int vmci_host_do_ctx_set_cpt_state(struct vmci_host_dev *vmci_host_dev,
 	void *cpt_buf;
 	int retval;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -785,7 +791,7 @@ static int vmci_host_do_set_notify(struct vmci_host_dev *vmci_host_dev,
 {
 	struct vmci_set_notify_info notify_info;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -818,7 +824,7 @@ static int vmci_host_do_notify_resource(struct vmci_host_dev *vmci_host_dev,
 		return -EINVAL;
 	}
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
@@ -867,7 +873,7 @@ static int vmci_host_do_recv_notifications(struct vmci_host_dev *vmci_host_dev,
 	u32 cid;
 	int retval = 0;
 
-	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
+	if (smp_load_acquire(&vmci_host_dev->ct_type) != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
-- 
2.37.3

