Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D87924E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjIEQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbjIECbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C0CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693881040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TD6AqqZEhek/ZfRieu/bQVlET4Mzq9l0FIdUCSmPvI=;
        b=J+gRzbU3NUxr6GTr6N4FhpZFJeEo1H/c1C0sIhUS3j1baOf5I7wghkfoIiB+Mn1/yt+qjV
        g/CS+nb4kPxMlYz/+S9R/GdnDr/DwAUU7T+8q8KHg0rOWN6FdlnNYdOjmFwN5KpmXYyHVl
        5VM+Jdu3OvJa5vUVsC+kPJKDUyy9j+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-1_odNUnyN7S2l__P_hDscg-1; Mon, 04 Sep 2023 22:30:37 -0400
X-MC-Unique: 1_odNUnyN7S2l__P_hDscg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C626B8CB2D7;
        Tue,  5 Sep 2023 02:30:36 +0000 (UTC)
Received: from localhost (unknown [10.72.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 171AD200BAA9;
        Tue,  5 Sep 2023 02:30:35 +0000 (UTC)
Date:   Tue, 5 Sep 2023 10:30:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] vmcore: allow alternate dump capturing methods to
 export vmcore without is_kdump_kernel()
Message-ID: <ZPaSyMuPa466sEPz@MiWiFi-R3L-srv>
References: <20230901190438.375678-1-hbathini@linux.ibm.com>
 <ZPP/UeP1zUbGPzrt@MiWiFi-R3L-srv>
 <8fcd7ba7-0f27-7bbc-676f-7e13c8bf00d7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcd7ba7-0f27-7bbc-676f-7e13c8bf00d7@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/23 at 08:04pm, Hari Bathini wrote:
> Hi Baoquan,
> 
> Thanks for the review...
> 
> On 03/09/23 9:06 am, Baoquan He wrote:
> > Hi Hari,
> > 
> > On 09/02/23 at 12:34am, Hari Bathini wrote:
> > > Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> > > While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> > > alternate dump capturing methods like fadump [1] also set it to export
> > > the vmcore. is_kdump_kernel() is used to restrict resources in crash
> > > dump capture kernel but such restrictions may not be desirable for
> > > fadump. Allow is_kdump_kernel() to be defined differently for such
> > > scenarios. With this, is_kdump_kernel() could be false while vmcore
> > > is usable. So, introduce is_crashdump_kernel() to return true when
> > > elfcorehdr_addr is set and use it for vmcore related checks.
> > 
> > I got what is done in these two patches, but didn't get why they need be
> > done. vmcore_unusable()/is_vmcore_usable() are only unitilized in ia64.
> > Why do you care if it's is_crashdump_kernel() or is_kdump_kernel()?
> > If you want to override the generic is_kdump_kernel() with powerpc's own
> > is_kdump_kernel(), your below change is enough to allow you to do that.
> > I can't see why is_crashdump_kernel() is needed. Could you explain that
> > specifically?
> 
> You mean to just remove is_kdump_kernel() check in is_vmcore_usable() &
> vmcore_unusable() functions? Replaced generic is_crashdump_kernel()
> function instead, that returns true for any dump capturing method,
> irrespective of whether is_kdump_kernel() returns true or false.
> For fadump case, is_kdump_kernel() will return false after patch 2/2.

OK, I could understand what you want to achieve. You want to make
is_kdump_kernel() only return true for kdump, while is_vmcore_usable()
returns true for both kdump and fadump.

IIUC, can we change as below? It could make code clearer and more
straightforward. I don't think adding another is_crashdump_kernel()
is a good idea, that would be a torture for non-powerpc people reading
code when they need differentiate between kdump and crashdump.

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..102a8b710b38 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -50,6 +50,7 @@ void vmcore_cleanup(void);
 #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
 #endif
 
+#ifndef is_kdump_active
 /*
  * is_kdump_kernel() checks whether this kernel is booting after a panic of
  * previous kernel or not. This is determined by checking if previous kernel
@@ -64,6 +65,14 @@ static inline bool is_kdump_kernel(void)
 {
 	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
 }
+#endif
+
+#ifndef is_fadump_active
+static inline bool is_fadump_active(void)
+{
+	return false;
+}
+#endif
 
 /* is_vmcore_usable() checks if the kernel is booting after a panic and
  * the vmcore region is usable.
@@ -75,7 +84,8 @@ static inline bool is_kdump_kernel(void)
 
 static inline int is_vmcore_usable(void)
 {
-	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
+	return (is_kdump_kernel() || is_fadump_active())
+		&& elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
 }
 
 /* vmcore_unusable() marks the vmcore as unusable,
@@ -84,7 +94,7 @@ static inline int is_vmcore_usable(void)
 
 static inline void vmcore_unusable(void)
 {
-	if (is_kdump_kernel())
+	if (is_kdump_kernel() || is_fadump_active())
 		elfcorehdr_addr = ELFCORE_ADDR_ERR;
 }
 

