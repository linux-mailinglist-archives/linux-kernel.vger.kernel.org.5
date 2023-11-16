Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F547EE137
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345201AbjKPNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjKPNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:14:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BD10DA;
        Thu, 16 Nov 2023 05:14:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so687264b3a.3;
        Thu, 16 Nov 2023 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700140442; x=1700745242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IijjW5z83l5PX4DSM0mCw5PGI5YXGJ/C+FpbXJjae/o=;
        b=e+6naRNgeBJoIVh4aWSE5ORSYIXJm0qylxaXaGIch+G3GUeDuoC/0pVo5iD5yobrNZ
         yQp/+e3vdF3qbWVGQ7Zc53tEr+/MTHDhTM5UlEpXZaxn2a0JvQrpGzSMPJL33cgcGorZ
         t+cgeYFFMByLpkNxOqw8SCx8+4M5LUGsHUuAEtPnSHPQWflt3ekaHdnb75fo+9rDHmho
         fSfVZi10yFMlYIRhgb5pVmFrXEl/YvBXM70/AnrNtZEgUYzRynLif5yrzzc4sSwMU5Yi
         jC8n4W09IqlLIG6hhNzRLBYfzgizdbD5ozEgb0SyjO/HUv8agfrLw8gEVsc3OFtSA31T
         V+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140442; x=1700745242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IijjW5z83l5PX4DSM0mCw5PGI5YXGJ/C+FpbXJjae/o=;
        b=tvLHyazDTyJubS8zRr3MhA1N4Mq0w+SJgpRH9dGIwQ7teb78vRtboFch26WJUUJ9Sk
         xmICqQqZFIjNYqI0rVbjbG7xqlbq89ERZhdvI8deCb9psoa/FqaJrCjQCa0M0WLxb0g9
         Pg/Ybhh5B3hhW77vyLM0Noiu4PbNtkHRduwkWLGS9n5cq6CKGQrAR4fbEVVvRVzkBShT
         exkEA2dKPt/Ot23642inUZW9f/ghgcjP91VSnB5ee2CvTMbRwxfipIsRQ+3CqWwT7GxO
         RnDopPOcmOCRPWPGReaxFVN/zEpLJmOg8f8ocyGL4taDnsOfMrEUN71jYTR3Fy+xqb0y
         vd/w==
X-Gm-Message-State: AOJu0YzeaUknz5GRait9AoIVpnAbzTbU1wzouSa4TCbIZ2uB/CYtZAR8
        a/TdupQOVAHS7mh0ZerfmdA=
X-Google-Smtp-Source: AGHT+IEWSiEcX1lNfco4/eSeRq9smE/cTNyoWk8TVFKE59OwR5CRw3g74Fw1pnSPx3oZda7lCOiJHA==
X-Received: by 2002:a05:6a20:8e1f:b0:187:2c9a:c9ad with SMTP id y31-20020a056a208e1f00b001872c9ac9admr7906794pzj.55.1700140441584;
        Thu, 16 Nov 2023 05:14:01 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm4458116pfk.219.2023.11.16.05.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:14:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 0D69C10D76D28; Thu, 16 Nov 2023 20:13:55 +0700 (WIB)
Date:   Thu, 16 Nov 2023 20:13:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
Message-ID: <ZVYVk8KutkQE0RDU@archie.me>
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:49:37PM +0100, Thomas Hellström wrote:
> +TODO: Pointer to the gpuvm code implementation if this iteration and

"... implementation of this iteration ..."

> +Using a MMU notifier for device DMA (and other methods) is described in
> +`this document
> +<https://docs.kernel.org/core-api/pin_user_pages.html#case-3-mmu-notifier-registration-with-or-without-page-faulting-hardware>`_.

You can use internal linking instead:

---- >8 ----
diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index d3c1f6d8c0e0ec..6b5f7e6e7155fb 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -153,6 +153,8 @@ NOTE: Some pages, such as DAX pages, cannot be pinned with longterm pins. That's
 because DAX pages do not have a separate page cache, and so "pinning" implies
 locking down file system blocks, which is not (yet) supported in that way.
 
+.. _mmu-notifier-registration-case:
+
 CASE 3: MMU notifier registration, with or without page faulting hardware
 -------------------------------------------------------------------------
 Device drivers can pin pages via get_user_pages*(), and register for mmu
diff --git a/Documentation/gpu/drm-vm-bind-locking.rst b/Documentation/gpu/drm-vm-bind-locking.rst
index bc701157cb3414..08b6a47a6e592f 100644
--- a/Documentation/gpu/drm-vm-bind-locking.rst
+++ b/Documentation/gpu/drm-vm-bind-locking.rst
@@ -366,8 +366,7 @@ need to care about, but so far it has proven difficult to exclude
 certain notifications.
 
 Using a MMU notifier for device DMA (and other methods) is described in
-`this document
-<https://docs.kernel.org/core-api/pin_user_pages.html#case-3-mmu-notifier-registration-with-or-without-page-faulting-hardware>`_.
+:ref:`pin_user_pages() documentation <mmu-notifier-registration-case>`.
 
 Now the method of obtaining struct page references using
 get_user_pages() unfortunately can't be used under a dma_resv lock

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
