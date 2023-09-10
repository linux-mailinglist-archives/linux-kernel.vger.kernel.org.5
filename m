Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8D79A0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjIJXmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIJXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:42:49 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92C8E18B;
        Sun, 10 Sep 2023 16:42:45 -0700 (PDT)
Received: from [192.168.178.44] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 720491118;
        Mon, 11 Sep 2023 00:33:05 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 720491118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1694388785;
        bh=ngpP9Jx41lBYW2t1eDleKU9GoEBqtVMsPKI7CjXb2vQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CLRxIAXlrxwioAhfe1RTxMABhwJ6dpBYim5Ty04H+nVO28djKPt/dLNKekdAymoX5
         jdPQ8wbqmi5eVv1pPhcSjQhJwotWup1BQMT6iO6RtOgFKsRuhVZoYaNP0QKa2IeEqw
         jOKat6130cN2l6bY5RAFYCLp7UsA5/VM1xD3kl5w=
Message-ID: <a5766188-11d4-44f2-ae5b-8398260809d8@gigawatt.nl>
Date:   Mon, 11 Sep 2023 00:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] uapi: Stop using __kernel_long_t in struct msgbuf
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Rich Felker <dalias@libc.org>,
        linux-x86_64@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
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
been documented as taking a pointer to a user-defined type starting with
a field of type long.  __kernel_long_t is the same as long for all
platforms other than x32, almost all code out there using msgsnd and
msgrcv uses them as documented, and it is impossible to simultaneously
support existing binaries that use the documented API and existing
binaries that use the implemented API. This change breaks existing x32
binaries that use the implemented API, and fixes existing x32 binaries
that use the documented API.

This reverts commit 443d5670f77aab121cb95f45da60f0aad390bcb5.

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>
Cc: stable@kernel.org
---
  arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
  include/uapi/linux/msg.h               | 2 +-
  2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb2..f5d81fe2c94ca 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -77,8 +77,10 @@
  66	common	semctl			sys_semctl
  67	common	shmdt			sys_shmdt
  68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
+69	64	msgsnd			sys_msgsnd
+69	x32	msgsnd			compat_sys_msgsnd
+70	64	msgrcv			sys_msgrcv
+70	x32	msgrcv			compat_sys_msgrcv
  71	common	msgctl			sys_msgctl
  72	common	fcntl			sys_fcntl
  73	common	flock			sys_flock
diff --git a/include/uapi/linux/msg.h b/include/uapi/linux/msg.h
index 01ee8d54c1c8a..3881c94d48eae 100644
--- a/include/uapi/linux/msg.h
+++ b/include/uapi/linux/msg.h
@@ -36,7 +36,7 @@ struct msqid_ds {
  
  /* message buffer for msgsnd and msgrcv calls */
  struct msgbuf {
-	__kernel_long_t mtype;          /* type of message */
+	long mtype;                     /* type of message */
  	char mtext[1];                  /* message text */
  };
  
-- 
2.34.1
