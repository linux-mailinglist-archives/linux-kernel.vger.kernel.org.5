Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8376579A0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjIJXmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIJXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:42:50 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92DAE18C;
        Sun, 10 Sep 2023 16:42:45 -0700 (PDT)
Received: from [192.168.178.44] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 7BCAA107F;
        Mon, 11 Sep 2023 00:33:52 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7BCAA107F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1694388832;
        bh=L9utoYOeaCCBbt0ZcgctvXdy5xAJVZGD+3I0IMrPVJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L+BlNAjxTDAk4S9Htl/tUQtWi4JoR/+izfkFqb9rxIZb+rhtsARkrzHVRKWx3q8fL
         MbblZWrxGi/CNkCbOdQwjM8Oh/48oEmpZ3L2H1k3xV1Cocra0BNIF5ST2J/c1JzZRP
         WBu95VFLjftUo0XvbsoXMSM8tkzylGUkKVSGZEZc=
Message-ID: <81895c92-3e4f-4463-acc8-36b32445b87f@gigawatt.nl>
Date:   Mon, 11 Sep 2023 00:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] uapi: Remove struct msgbuf, struct ipc_kludge.
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rich Felker <dalias@libc.org>, linux-x86_64@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
 <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
 <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
 <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct msgbuf is mostly an internal type: msgsnd and msgrcv have always
been documented as taking a pointer to a user-defined type.  Any code
that relies on the uapi-defined type can trivially be updated to follow
the documentation and define the type itself.

struct ipc_kludge is a workaround for the limited number of arguments
supported in syscalls, references struct msgbuf, so either needs
updating or also needs removing from uapi.  As no libc that I have been
able to find uses it (almost all use an array of long instead, and
dietlibc defines its own struct ipc_kludge without relying on kernel
headers), this commit removes it too from uapi.

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>
---
  include/linux/ipc.h      | 10 ++++++++++
  include/linux/msg.h      |  6 ++++++
  include/uapi/linux/ipc.h | 10 ----------
  include/uapi/linux/msg.h |  6 ------
  4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index e1c9eea6015b5..b2f8e4ff554ec 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -8,6 +8,16 @@
  #include <uapi/linux/ipc.h>
  #include <linux/refcount.h>
  
+/*
+ * These are used to wrap system calls.
+ *
+ * See architecture code for ugly details..
+ */
+struct ipc_kludge {
+	struct msgbuf __user *msgp;
+	long msgtyp;
+};
+
  /* used by in-kernel data structures */
  struct kern_ipc_perm {
  	spinlock_t	lock;
diff --git a/include/linux/msg.h b/include/linux/msg.h
index 9a972a296b953..46836a6291af2 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -5,6 +5,12 @@
  #include <linux/list.h>
  #include <uapi/linux/msg.h>
  
+/* message buffer for msgsnd and msgrcv calls */
+struct msgbuf {
+	long mtype;                     /* type of message */
+	char mtext[1];                  /* message text */
+};
+
  /* one msg_msg structure for each message */
  struct msg_msg {
  	struct list_head m_list;
diff --git a/include/uapi/linux/ipc.h b/include/uapi/linux/ipc.h
index 5995fc9d675ea..2c6e543c18fd8 100644
--- a/include/uapi/linux/ipc.h
+++ b/include/uapi/linux/ipc.h
@@ -50,16 +50,6 @@ struct ipc_perm
  #define IPC_64  0x0100  /* New version (support 32-bit UIDs, bigger
  			   message sizes, etc. */
  
-/*
- * These are used to wrap system calls.
- *
- * See architecture code for ugly details..
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
  #define SEMOP		 1
  #define SEMGET		 2
  #define SEMCTL		 3
diff --git a/include/uapi/linux/msg.h b/include/uapi/linux/msg.h
index 3881c94d48eae..901e2952669e6 100644
--- a/include/uapi/linux/msg.h
+++ b/include/uapi/linux/msg.h
@@ -34,12 +34,6 @@ struct msqid_ds {
  /* Include the definition of msqid64_ds */
  #include <asm/msgbuf.h>
  
-/* message buffer for msgsnd and msgrcv calls */
-struct msgbuf {
-	long mtype;                     /* type of message */
-	char mtext[1];                  /* message text */
-};
-
  /* buffer for msgctl calls IPC_INFO, MSG_INFO */
  struct msginfo {
  	int msgpool;
-- 
2.34.1
