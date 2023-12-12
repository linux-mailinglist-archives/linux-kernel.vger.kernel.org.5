Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3651780F41D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376585AbjLLRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjLLRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69C8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702401058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gv0M0HGbrAnaBTITUU22qWIN+D01416eS5uSG0g/5E=;
        b=UDM40A97buHJ5OuN/Lx7uD9qzV5tkWUVAn7+2htMFhTTID6QhC/EXuNFFq2wg0fGB2tDRh
        /QWSi1O0ei2pK7HrwGh8ekBvSB5WActVbtcoVh72FfVHREDNXfMYnLv4br15i8cotVHESw
        iO1cH1wLR4rrApQQRn17Tnm8ChVMMW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-sc7vRIH0N7iyizZE1qVcUg-1; Tue, 12 Dec 2023 12:10:55 -0500
X-MC-Unique: sc7vRIH0N7iyizZE1qVcUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39174891067;
        Tue, 12 Dec 2023 17:10:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D393F2166B31;
        Tue, 12 Dec 2023 17:10:52 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     nathan@kernel.org
Cc:     dcavalca@meta.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] rpm-pkg: simplify installkernel %post
Date:   Tue, 12 Dec 2023 18:10:44 +0100
Message-ID: <20231212171044.1108464-1-jtornosm@redhat.com>
In-Reply-To: <20231108000749.GA3723879@dev-arch.thelio-3990X>
References: <20231108000749.GA3723879@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new installkernel application is now included in systemd-udev package
and it has been improved to allow simplifications.

For the new installkernel application, as Davide says:
<<The %post currently does a shuffling dance before calling installkernel.
This isn't actually necessary afaict, and the current implementation
ends up triggering downstream issues such as
https://github.com/systemd/systemd/issues/29568
This commit simplifies the logic to remove the shuffling. For reference,
the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
section to create initramfs and grub hooks").>>

But we need to keep the old behavior as well, because the old installkernel
application from grubby package, does not allow this simplification and
we need to be backward compatible to avoid issues with the different
packages. So the easiest solution is to check the package that provides
the installkernel application, and simplify (and fix for this
application at the same time), only if the package is systemd-udev.

cc: stable@vger.kernel.org
Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Complete to be backward compatible with the previous installkernel
application.

 scripts/package/kernel.spec | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..d4276ddb6645 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -77,12 +77,16 @@ rm -rf %{buildroot}
 
 %post
 if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
+if [ $(rpm -qf /sbin/installkernel --queryformat "%{n}") = systemd-udev ];then
+/sbin/installkernel %{KERNELRELEASE} /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
+else
 cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
 cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
 rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
 /sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
 rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
 fi
+fi
 
 %preun
 if [ -x /sbin/new-kernel-pkg ]; then
-- 
2.43.0

