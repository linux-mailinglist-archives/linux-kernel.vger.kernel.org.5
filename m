Return-Path: <linux-kernel+bounces-56803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C384CF68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B36B28A88C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC9823C7;
	Wed,  7 Feb 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncf.edu header.i=@ncf.edu header.b="nArcbWdV"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2D81AC0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325815; cv=none; b=LyB7ei8nPtTjU85kGRjNk1O4X8WJJ3ZuGTwFHXWD+zgE8tvp1oNRFpxraL6Weusn8tKiHiyrVn7atDUnWiMCiYe6xIuFwtSRMfgMe/lLcxHrVDYepwpvJ13EQK0B0Rgojre9BLqmMb+ubwJRpsitPTP8olvI6oaOKOE3NREabrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325815; c=relaxed/simple;
	bh=NnrTeSM0NKttFrB0R5j/jBw6kD7U3S0LMZ+p20JMMPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=St6VoBG2TdI+HIA1QmbsbfRsB0/ukUxz2DumNMlrx2Cxh8PmTJKdmUt7dIwCSGc6CcoxOGHRpLj1gHfwEzBuNuB/gOuOSbA/SZ1eO8RD0RxRcqUaTmgtMIwSCHWTIpCkqXy1CVtwmbDSMRpuTDWVzQT+sBkjwQf+TN8UhnuKzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ncf.edu; spf=pass smtp.mailfrom=ncf.edu; dkim=pass (2048-bit key) header.d=ncf.edu header.i=@ncf.edu header.b=nArcbWdV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ncf.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncf.edu
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60491cb9571so8708297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1707325811; x=1707930611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/mkFhlXDAxUXvqhk2kRlbT3+ot3xAj8hCZnTSBVNwE=;
        b=nArcbWdVgYgRLBywOyBOXHS7GMytos/PVLCaOB6pmXxOtyTHhLQV+naazNfPp4bt2y
         06NmR+NCE0K833OVA/1GDVhKJ+bjADQ77jqgFBSxNOz880004KJZzerR8wO7ho3RVXM/
         CfP9Srj7BikXhSPBqXweUmHHBvkeB8Sq98EcqfoLPfulA94nuicXCD7JCK4HroYW/yox
         JjBEMxXnbQkZ9f38bFUX84ahwsh2wSGXha9iQ0r4jDZ1qU42mf0OGhjYMR9pwBm/FFYF
         qD8d4PTUj13QyHUiNI0Qyiu6VUW42RSfihkI626vLzT72eBo7uPxVjB3qTfwUBct/Vac
         ojZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325811; x=1707930611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/mkFhlXDAxUXvqhk2kRlbT3+ot3xAj8hCZnTSBVNwE=;
        b=J6wzUjwhlin5TMLCSCKoaGFgtCkYmmubb+UZqog6VlCQLVWixZbDSjAXt+7RJvB8ow
         qR4alWVk4oZ4utzLy6zQA0fATsWneRQIs1Dk9jpAOA6p1h568t1VwrWeG2qbCWIuZH6o
         JbHHl33Lel9QLsS4eo4Yw4h2ud3rusY4zduwDkXUczj2quUCMTxitI1casNetd6kMKr4
         uwfFhdTanMJotkTq6Zaz5RtWxL31xCdW0+LWCdbK5VBHJjZmF+W6LVlVMX2Hh30jx9yK
         vi0dTtn0+jyCD+iBuoldvgtA1Ff+itoSzDwTQZho83TUMdBngRjprBgryG2V4lJyXHAs
         wGtw==
X-Gm-Message-State: AOJu0YzDwYWjlEZwmtZNs9ACC93CUU4EkSOy8brGt+Y/TzU8I3dVid2c
	cH9jxUw3Fy8wYoN7y1BTOgsp+V6NEKhSFMMfiKHnl8wHbAHZbnkKFwJKZP8nyQ==
X-Google-Smtp-Source: AGHT+IG8nj/wmUjz51qpJvNt+t13UZaIJFps1CBpT0pYmxbMFYZ5L2lqP3rdW83sRZdPMM9e7l4hvg==
X-Received: by 2002:a81:c149:0:b0:5ff:cb36:24cd with SMTP id e9-20020a81c149000000b005ffcb3624cdmr5633474ywl.7.1707325811221;
        Wed, 07 Feb 2024 09:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN7c2/3/GjjjbkV4Uz3RtnWu6UNzu06OWN/d8Ry1OUKxfLpkPFiXwC8sGXAlSozdXiBZEAit8ZuwZbZbrY/ZgnuuqqDoq5pPbBcLn8+D5wd6CM/vXVjS/pv97Pi2Hs/aK9KsJ4W2g=
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::11c6])
        by smtp.gmail.com with ESMTPSA id p63-20020a819842000000b006040f198d3esm332814ywg.142.2024.02.07.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:10:10 -0800 (PST)
From: Hunter Chasens <hunter.chasens18@ncf.edu>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v4] docs: admin-guide: Update bootloader and installation instructions
Date: Wed,  7 Feb 2024 12:10:07 -0500
Message-ID: <20240207171007.45405-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates the bootloader and installation instructions in
admin-guide/README.rst to align with modern practices.

Details of Changes:

 - Added guidance on using EFISTUB for UEFI/EFI systems.
 - Noted that LILO is no longer in active development and provides
   alternatives.
 - Kept LILO instructions but marked as Legacy LILO Instructions.
   Suggest removal in future patch.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 Documentation/admin-guide/README.rst | 69 ++++++++++++++++++----------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 9a969c0157f1..62377f7bd523 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -262,9 +262,11 @@ Compiling the kernel
  - Make sure you have at least gcc 5.1 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
- - Do a ``make`` to create a compressed kernel image. It is also
-   possible to do ``make install`` if you have lilo installed to suit the
-   kernel makefiles, but you may want to check your particular lilo setup first.
+ - Do a ``make`` to create a compressed kernel image. It is also possible to do
+   ``make install`` if you have lilo installed or if your distribution has an
+   install script recognised by the kernel's installer. Most popular
+   distributions will have a recognized install script. You may want to
+   check your distribution's setup first.
 
    To do the actual install, you have to be root, but none of the normal
    build should require that. Don't take the name of root in vain.
@@ -301,32 +303,51 @@ Compiling the kernel
    image (e.g. .../linux/arch/x86/boot/bzImage after compilation)
    to the place where your regular bootable kernel is found.
 
- - Booting a kernel directly from a floppy without the assistance of a
-   bootloader such as LILO, is no longer supported.
-
-   If you boot Linux from the hard drive, chances are you use LILO, which
-   uses the kernel image as specified in the file /etc/lilo.conf.  The
-   kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
-   /boot/bzImage.  To use the new kernel, save a copy of the old image
-   and copy the new image over the old one.  Then, you MUST RERUN LILO
-   to update the loading map! If you don't, you won't be able to boot
-   the new kernel image.
-
-   Reinstalling LILO is usually a matter of running /sbin/lilo.
-   You may wish to edit /etc/lilo.conf to specify an entry for your
-   old kernel image (say, /vmlinux.old) in case the new one does not
-   work.  See the LILO docs for more information.
-
-   After reinstalling LILO, you should be all set.  Shutdown the system,
+ - Booting a kernel directly from a storage device without the assistance 
+   of a bootloader such as LILO or GRUB, is no longer supported in BIOS 
+   (non-EFI systems). On UEFI/EFI systems, however, you can use EFISTUB 
+   which allows the motherboard to boot directly to the kernel.
+   On modern workstations and desktops, it's generally recommended to use a
+   bootloader as difficulties can arise with multiple kernels and secure boot.
+   For more details on EFISTUB,
+   see "Documentation/admin-guide/efi-stub.rst".
+
+ - It's important to note that as of 2016 LILO (LInux LOader) is no longer in
+   active development, though as it was extremely popular, it often comes up
+   in documentation. Popular alternatives include GRUB2, rEFInd, Syslinux,
+   systemd-boot, or EFISTUB. For various reasons, it's not recommended to use
+   software that's no longer in active development.
+
+ - Chances are your distribution includes an install script and running
+   ``make install`` will be all that's needed. Should that not be the case
+   you'll have to identify your bootloader and reference its documentation or
+   configure your EFI.
+
+Legacy LILO Instructions
+------------------------
+
+
+ - If you use LILO the kernel images are specified in the file /etc/lilo.conf.
+   The kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
+   /boot/bzImage. To use the new kernel, save a copy of the old image and copy
+   the new image over the old one. Then, you MUST RERUN LILO to update the
+   loading map! If you don't, you won't be able to boot the new kernel image.
+
+ - Reinstalling LILO is usually a matter of running /sbin/lilo. You may wish
+   to edit /etc/lilo.conf to specify an entry for your old kernel image
+   (say, /vmlinux.old) in case the new one does not work. See the LILO docs
+   for more information.
+
+ - After reinstalling LILO, you should be all set. Shutdown the system,
    reboot, and enjoy!
 
-   If you ever need to change the default root device, video mode,
-   etc. in the kernel image, use your bootloader's boot options
-   where appropriate.  No need to recompile the kernel to change
-   these parameters.
+ - If you ever need to change the default root device, video mode, etc. in the
+   kernel image, use your bootloader's boot options where appropriate. No need
+   to recompile the kernel to change these parameters.
 
  - Reboot with the new kernel and enjoy.
 
+
 If something goes wrong
 -----------------------
 
-- 
2.43.0


