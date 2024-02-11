Return-Path: <linux-kernel+bounces-60692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686F850898
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1CD1F22941
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9459B7F;
	Sun, 11 Feb 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqeD5eF1"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A69C8D2;
	Sun, 11 Feb 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707646459; cv=none; b=LaB2b5f4E8uVKR2zvZlyM8xAgPj66sSiGa4OKQjwG1nKmZ95dcPQBD3g0QyUpsyz0qaC2PlcLzjoeyFiIrVfnh54KG9QB9LtwsN8s4LwdvMICH9zyi6Kh9vpd12Gw8HIdfbITYOWAtbNTgb2q4kcgu5dz1D4vkTpPJWSvEp/mDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707646459; c=relaxed/simple;
	bh=13IoBBHWyO2HWQnCgEfGyaejQsClWHGa2LzrJJyhjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOgFzVyh8VPMqQbmizZwTJH7BrW3LQ8GzJ2OhPq/9YKk+Q4yg6v1eJlTcPUmOEaEJFVF1zBQjFGuu4JtPkADPGWJ3WpIsIonResoHZ9811dDb6PGh6Sc6iv7Nr8EQKJ4JNtjpntb3dVK9p+VcOBiAuqd5TwI7sPyaMbFFdOx1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqeD5eF1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d5a47ae5dso65305eaf.2;
        Sun, 11 Feb 2024 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707646455; x=1708251255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A26YIhSg1ABXVYiukrM6bhaxYm9zxBiX9FWfhb4/5Uw=;
        b=gqeD5eF1zJItkTSuS5dB43h/v2PO5eFFUTJrh8QmAivzkeO1KyT/z1m0Wu202fKtwz
         umVGfJRfhOBgh9d60/RjBP1QYiJ+/1Sq5RoakyrAAE2wCoAfBwnpyC7UMd24Q1RlNgpu
         9R1BG+rP2iRM0gzDyVQBjuUs8uof6/snf+Kdgt+DVVR82D+pWDonAxe3TxxOfENRv5ij
         nhuED5OmRWaMmua8D3K7hxipk4K7v0eD9uLcEPU5eHy2bhHPIkFtTbmX4oHqnDcS+uOV
         FpEszegz0ySGCQewYsNl1NBRx//wQPjRZnHz36KWlALht+x5qPDxUktrzZkfsT6LTsVD
         KO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707646455; x=1708251255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A26YIhSg1ABXVYiukrM6bhaxYm9zxBiX9FWfhb4/5Uw=;
        b=MvGyhooCf1ve+jQ3a3h5JXG92u8DVeFi1SPrZHTlkvni/8zEaXZV8MUJfsWNyre3E2
         LqrZmfJ8hRZIt9SCv12WHoFOUQlMd3GRTnyemripPUybOaxN8ryqJwSESjrbfNgIu8eD
         dJJ4+CJ9QXkbw3vjnhBaCmkB4ozxYBj9IgsITQRfW9EXcsIdeS8zqSmljdfZjokg2Hno
         U24PVTkZEoPgpsT/kRTSFeTkMr9OLsk64E7Ldj/ObQauaOyzfKTL7aGV7R56JdfztPLv
         BbWvgeaOp1vYMHHhOsiftxr1xwATNmf/r+InIElFM+e480iSYrC2zIECoApcxjwdk1PM
         cIbA==
X-Gm-Message-State: AOJu0Yw65+6aRR5x04MQzpiYWR6hNGdGU3UQ9XCGbJ7w2hOEcyIY1KCk
	XPXYZXQpabhIrhQ8PCWB6L3iMeXdQQ3pV9UO8fjAUL5km0a5fMPQLIpev+/fHnfwgpnE
X-Google-Smtp-Source: AGHT+IFTFqp0BwaxdbMDSYUNUqdWv9EHx+uutdwRAE81ebUQM0MhTBJuliaKOjC/l03/U0tj2OYY4g==
X-Received: by 2002:a05:6358:2786:b0:176:d46c:e704 with SMTP id l6-20020a056358278600b00176d46ce704mr4709695rwb.16.1707646454400;
        Sun, 11 Feb 2024 02:14:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZVR/CKNvZMrxz/I16cutiWg+o+TU4EKNbxvsEUkvw9jSgkgRdOCBSsjR8WOAGGdnb0q/TIWwgnjOTSsMAfTbHwNfS8joN8ZwWIBdgfJmbkzGP5vywORkAfDbtGiXW6kROhPirJGs5gwfMMjKdKhKC0aqhZviWOsF5Vl8dqFzxApGSYVsilzOb0G5cHEaE9KnkZZQKN+1+3TGHab+lUte4QVVlGQAptN85ZlsZW+Me5RSzjDvrC+DItPvLJYMSUFRyqjgBa+CJpTPe/F1OAYGbEO5YssUuC25RmTvn
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090ad30500b00297169b3887sm2717602pju.24.2024.02.11.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 02:14:13 -0800 (PST)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net,
	shresthprasad7@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Fix malformed table error in gadget-testing.rst
Date: Sun, 11 Feb 2024 15:43:24 +0530
Message-ID: <20240211101324.37266-1-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've replaced all tabs with 8 spaces in gadget-testing.rst so that the
document is easier to work with. This also fixes a malformed table error
emitted while compliling the docs.

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 Documentation/usb/gadget-testing.rst | 554 +++++++++++++--------------
 1 file changed, 277 insertions(+), 277 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 077dfac7ed98..824a5a47d115 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -41,7 +41,7 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "acm".
 The ACM function provides just one attribute in its function directory:
 
-	port_num
+       port_num
 
 The attribute is read-only.
 
@@ -53,21 +53,21 @@ Testing the ACM function
 
 On the host::
 
-	cat > /dev/ttyACM<X>
+       cat > /dev/ttyACM<X>
 
 On the device::
 
-	cat /dev/ttyGS<Y>
+       cat /dev/ttyGS<Y>
 
 then the other way round
 
 On the device::
 
-	cat > /dev/ttyGS<Y>
+       cat > /dev/ttyGS<Y>
 
 On the host::
 
-	cat /dev/ttyACM<X>
+       cat /dev/ttyACM<X>
 
 2. ECM function
 ===============
@@ -80,15 +80,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ecm".
 The ECM function provides these attributes in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	qmult		queue length multiplier for high and super speed
-	host_addr	MAC address of host's end of this
-			Ethernet over USB link
-	dev_addr	MAC address of device's end of this
-			Ethernet over USB link
-	=============== ==================================================
+       =============== ==================================================
+       ifname          network device interface name associated with this
+                       function instance
+       qmult           queue length multiplier for high and super speed
+       host_addr       MAC address of host's end of this
+                       Ethernet over USB link
+       dev_addr        MAC address of device's end of this
+                       Ethernet over USB link
+       =============== ==================================================
 
 and after creating the functions/ecm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -103,11 +103,11 @@ Configure IP addresses of the device and the host. Then:
 
 On the device::
 
-	ping <host's IP>
+       ping <host's IP>
 
 On the host::
 
-	ping <device's IP>
+       ping <device's IP>
 
 3. ECM subset function
 ======================
@@ -120,15 +120,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "geth".
 The ECM subset function provides these attributes in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	qmult		queue length multiplier for high and super speed
-	host_addr	MAC address of host's end of this
-			Ethernet over USB link
-	dev_addr	MAC address of device's end of this
-			Ethernet over USB link
-	=============== ==================================================
+       =============== ==================================================
+       ifname          network device interface name associated with this
+                       function instance
+       qmult           queue length multiplier for high and super speed
+       host_addr       MAC address of host's end of this
+                       Ethernet over USB link
+       dev_addr        MAC address of device's end of this
+                       Ethernet over USB link
+       =============== ==================================================
 
 and after creating the functions/ecm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -143,11 +143,11 @@ Configure IP addresses of the device and the host. Then:
 
 On the device::
 
-	ping <host's IP>
+       ping <host's IP>
 
 On the host::
 
-	ping <device's IP>
+       ping <device's IP>
 
 4. EEM function
 ===============
@@ -160,15 +160,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "eem".
 The EEM function provides these attributes in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	qmult		queue length multiplier for high and super speed
-	host_addr	MAC address of host's end of this
-			Ethernet over USB link
-	dev_addr	MAC address of device's end of this
-			Ethernet over USB link
-	=============== ==================================================
+       =============== ==================================================
+       ifname          network device interface name associated with this
+                       function instance
+       qmult           queue length multiplier for high and super speed
+       host_addr       MAC address of host's end of this
+                       Ethernet over USB link
+       dev_addr        MAC address of device's end of this
+                       Ethernet over USB link
+       =============== ==================================================
 
 and after creating the functions/eem.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -183,11 +183,11 @@ Configure IP addresses of the device and the host. Then:
 
 On the device::
 
-	ping <host's IP>
+       ping <host's IP>
 
 On the host::
 
-	ping <device's IP>
+       ping <device's IP>
 
 5. FFS function
 ===============
@@ -224,13 +224,13 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "hid".
 The HID function provides these attributes in its function directory:
 
-	=============== ===========================================
-	protocol	HID protocol to use
-	report_desc	data to be used in HID reports, except data
-			passed with /dev/hidg<X>
-	report_length	HID report length
-	subclass	HID subclass to use
-	=============== ===========================================
+       =============== ===========================================
+       protocol        HID protocol to use
+       report_desc     data to be used in HID reports, except data
+                       passed with /dev/hidg<X>
+       report_length   HID report length
+       subclass        HID subclass to use
+       =============== ===========================================
 
 For a keyboard the protocol and the subclass are 1, the report_length is 8,
 while the report_desc is::
@@ -257,7 +257,7 @@ Device:
 - run a program which writes to /dev/hidg<N>, e.g.
   a userspace program found in Documentation/usb/gadget_hid.rst::
 
-	$ ./hid_gadget_test /dev/hidg0 keyboard
+       $ ./hid_gadget_test /dev/hidg0 keyboard
 
 Host:
 
@@ -274,10 +274,10 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "Loopback".
 The LOOPBACK function provides these attributes in its function directory:
 
-	=============== =======================
-	qlen		depth of loopback queue
-	bulk_buflen	buffer length
-	=============== =======================
+       =============== =======================
+       qlen            depth of loopback queue
+       bulk_buflen     buffer length
+       =============== =======================
 
 Testing the LOOPBACK function
 -----------------------------
@@ -298,20 +298,20 @@ The function name to use when creating the function directory is "mass_storage".
 The MASS STORAGE function provides these attributes in its directory:
 files:
 
-	=============== ==============================================
-	stall		Set to permit function to halt bulk endpoints.
-			Disabled on some USB devices known not to work
-			correctly. You should set it to true.
-	num_buffers	Number of pipeline buffers. Valid numbers
-			are 2..4. Available only if
-			CONFIG_USB_GADGET_DEBUG_FILES is set.
-	=============== ==============================================
+       =============== ==============================================
+       stall           Set to permit function to halt bulk endpoints.
+                       Disabled on some USB devices known not to work
+                       correctly. You should set it to true.
+       num_buffers     Number of pipeline buffers. Valid numbers
+                       are 2..4. Available only if
+                       CONFIG_USB_GADGET_DEBUG_FILES is set.
+       =============== ==============================================
 
 and a default lun.0 directory corresponding to SCSI LUN #0.
 
 A new lun can be added with mkdir::
 
-	$ mkdir functions/mass_storage.0/partition.5
+       $ mkdir functions/mass_storage.0/partition.5
 
 Lun numbering does not have to be continuous, except for lun #0 which is
 created by default. A maximum of 8 luns can be specified and they all must be
@@ -321,26 +321,26 @@ although it is not mandatory.
 
 In each lun directory there are the following attribute files:
 
-	=============== ==============================================
-	file		The path to the backing file for the LUN.
-			Required if LUN is not marked as removable.
-	ro		Flag specifying access to the LUN shall be
-			read-only. This is implied if CD-ROM emulation
-			is enabled as well as when it was impossible
-			to open "filename" in R/W mode.
-	removable	Flag specifying that LUN shall be indicated as
-			being removable.
-	cdrom		Flag specifying that LUN shall be reported as
-			being a CD-ROM.
-	nofua		Flag specifying that FUA flag
-			in SCSI WRITE(10,12)
-	forced_eject	This write-only file is useful only when
-			the function is active. It causes the backing
-			file to be forcibly detached from the LUN,
-			regardless of whether the host has allowed it.
-			Any non-zero number of bytes written will
-			result in ejection.
-	=============== ==============================================
+       =============== ==============================================
+       file            The path to the backing file for the LUN.
+                       Required if LUN is not marked as removable.
+       ro              Flag specifying access to the LUN shall be
+                       read-only. This is implied if CD-ROM emulation
+                       is enabled as well as when it was impossible
+                       to open "filename" in R/W mode.
+       removable       Flag specifying that LUN shall be indicated as
+                       being removable.
+       cdrom           Flag specifying that LUN shall be reported as
+                       being a CD-ROM.
+       nofua           Flag specifying that FUA flag
+                       in SCSI WRITE(10,12)
+       forced_eject    This write-only file is useful only when
+                       the function is active. It causes the backing
+                       file to be forcibly detached from the LUN,
+                       regardless of whether the host has allowed it.
+                       Any non-zero number of bytes written will
+                       result in ejection.
+       =============== ==============================================
 
 Testing the MASS STORAGE function
 ---------------------------------
@@ -360,14 +360,14 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "midi".
 The MIDI function provides these attributes in its function directory:
 
-	=============== ====================================
-	buflen		MIDI buffer length
-	id		ID string for the USB MIDI adapter
-	in_ports	number of MIDI input ports
-	index		index value for the USB MIDI adapter
-	out_ports	number of MIDI output ports
-	qlen		USB read request queue length
-	=============== ====================================
+       =============== ====================================
+       buflen          MIDI buffer length
+       id              ID string for the USB MIDI adapter
+       in_ports        number of MIDI input ports
+       index           index value for the USB MIDI adapter
+       out_ports       number of MIDI output ports
+       qlen            USB read request queue length
+       =============== ====================================
 
 Testing the MIDI function
 -------------------------
@@ -448,17 +448,17 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	======================= ==================================================
-	ifname			network device interface name associated with this
-				function instance
-	qmult			queue length multiplier for high and super speed
-	host_addr		MAC address of host's end of this
-				Ethernet over USB link
-	dev_addr		MAC address of device's end of this
-				Ethernet over USB link
-	max_segment_size	Segment size required for P2P connections. This
-				will set MTU to 14 bytes
-	======================= ==================================================
+       ======================= ==================================================
+       ifname                  network device interface name associated with this
+                               function instance
+       qmult                   queue length multiplier for high and super speed
+       host_addr               MAC address of host's end of this
+                               Ethernet over USB link
+       dev_addr                MAC address of device's end of this
+                               Ethernet over USB link
+       max_segment_size        Segment size required for P2P connections. This
+                               will set MTU to 14 bytes
+       ======================= ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -473,11 +473,11 @@ Configure IP addresses of the device and the host. Then:
 
 On the device::
 
-	ping <host's IP>
+       ping <host's IP>
 
 On the host::
 
-	ping <device's IP>
+       ping <device's IP>
 
 11. OBEX function
 =================
@@ -490,7 +490,7 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "obex".
 The OBEX function provides just one attribute in its function directory:
 
-	port_num
+       port_num
 
 The attribute is read-only.
 
@@ -501,16 +501,16 @@ Testing the OBEX function
 
 On device::
 
-	seriald -f /dev/ttyGS<Y> -s 1024
+       seriald -f /dev/ttyGS<Y> -s 1024
 
 On host::
 
-	serialc -v <vendorID> -p <productID> -i<interface#> -a1 -s1024 \
-                -t<out endpoint addr> -r<in endpoint addr>
+       serialc -v <vendorID> -p <productID> -i<interface#> -a1 -s1024 \
+               -t<out endpoint addr> -r<in endpoint addr>
 
 where seriald and serialc are Felipe's utilities found here:
 
-	https://github.com/felipebalbi/usb-tools.git master
+       https://github.com/felipebalbi/usb-tools.git master
 
 12. PHONET function
 ===================
@@ -523,10 +523,10 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "phonet".
 The PHONET function provides just one attribute in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	=============== ==================================================
+       =============== ==================================================
+       ifname          network device interface name associated with this
+                       function instance
+       =============== ==================================================
 
 Testing the PHONET function
 ---------------------------
@@ -543,39 +543,39 @@ git://git.gitorious.org/meego-cellular/phonet-utils.git
 
 On the host::
 
-	$ ./phonet -a 0x10 -i usbpn0
-	$ ./pnroute add 0x6c usbpn0
-	$./pnroute add 0x10 usbpn0
-	$ ifconfig usbpn0 up
+       $ ./phonet -a 0x10 -i usbpn0
+       $ ./pnroute add 0x6c usbpn0
+       $./pnroute add 0x10 usbpn0
+       $ ifconfig usbpn0 up
 
 On the device::
 
-	$ ./phonet -a 0x6c -i upnlink0
-	$ ./pnroute add 0x10 upnlink0
-	$ ifconfig upnlink0 up
+       $ ./phonet -a 0x6c -i upnlink0
+       $ ./pnroute add 0x10 upnlink0
+       $ ifconfig upnlink0 up
 
 Then a test program can be used::
 
-	http://www.spinics.net/lists/linux-usb/msg85690.html
+       http://www.spinics.net/lists/linux-usb/msg85690.html
 
 On the device::
 
-	$ ./pnxmit -a 0x6c -r
+       $ ./pnxmit -a 0x6c -r
 
 On the host::
 
-	$ ./pnxmit -a 0x10 -s 0x6c
+       $ ./pnxmit -a 0x10 -s 0x6c
 
 As a result some data should be sent from host to device.
 Then the other way round:
 
 On the host::
 
-	$ ./pnxmit -a 0x10 -r
+       $ ./pnxmit -a 0x10 -r
 
 On the device::
 
-	$ ./pnxmit -a 0x6c -s 0x10
+       $ ./pnxmit -a 0x6c -s 0x10
 
 13. RNDIS function
 ==================
@@ -588,15 +588,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "rndis".
 The RNDIS function provides these attributes in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	qmult		queue length multiplier for high and super speed
-	host_addr	MAC address of host's end of this
-			Ethernet over USB link
-	dev_addr	MAC address of device's end of this
-			Ethernet over USB link
-	=============== ==================================================
+       =============== ==================================================
+       ifname          network device interface name associated with this
+                       function instance
+       qmult           queue length multiplier for high and super speed
+       host_addr       MAC address of host's end of this
+                       Ethernet over USB link
+       dev_addr        MAC address of device's end of this
+                       Ethernet over USB link
+       =============== ==================================================
 
 and after creating the functions/rndis.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -611,11 +611,11 @@ Configure IP addresses of the device and the host. Then:
 
 On the device::
 
-	ping <host's IP>
+       ping <host's IP>
 
 On the host::
 
-	ping <device's IP>
+       ping <device's IP>
 
 14. SERIAL function
 ===================
@@ -628,7 +628,7 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "gser".
 The SERIAL function provides just one attribute in its function directory:
 
-	port_num
+       port_num
 
 The attribute is read-only.
 
@@ -639,26 +639,26 @@ Testing the SERIAL function
 
 On host::
 
-	insmod usbserial
-	echo VID PID >/sys/bus/usb-serial/drivers/generic/new_id
+       insmod usbserial
+       echo VID PID >/sys/bus/usb-serial/drivers/generic/new_id
 
 On host::
 
-	cat > /dev/ttyUSB<X>
+       cat > /dev/ttyUSB<X>
 
 On target::
 
-	cat /dev/ttyGS<Y>
+       cat /dev/ttyGS<Y>
 
 then the other way round
 
 On target::
 
-	cat > /dev/ttyGS<Y>
+       cat > /dev/ttyGS<Y>
 
 On host::
 
-	cat /dev/ttyUSB<X>
+       cat /dev/ttyUSB<X>
 
 15. SOURCESINK function
 =======================
@@ -671,16 +671,16 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "SourceSink".
 The SOURCESINK function provides these attributes in its function directory:
 
-	=============== ==================================
-	pattern		0 (all zeros), 1 (mod63), 2 (none)
-	isoc_interval	1..16
-	isoc_maxpacket	0 - 1023 (fs), 0 - 1024 (hs/ss)
-	isoc_mult	0..2 (hs/ss only)
-	isoc_maxburst	0..15 (ss only)
-	bulk_buflen	buffer length
-	bulk_qlen	depth of queue for bulk
-	iso_qlen	depth of queue for iso
-	=============== ==================================
+       =============== ==================================
+       pattern         0 (all zeros), 1 (mod63), 2 (none)
+       isoc_interval   1..16
+       isoc_maxpacket  0 - 1023 (fs), 0 - 1024 (hs/ss)
+       isoc_mult       0..2 (hs/ss only)
+       isoc_maxburst   0..15 (ss only)
+       bulk_buflen     buffer length
+       bulk_qlen       depth of queue for bulk
+       iso_qlen        depth of queue for iso
+       =============== ==================================
 
 Testing the SOURCESINK function
 -------------------------------
@@ -702,14 +702,14 @@ The function name to use when creating the function directory
 is "uac1_legacy".
 The uac1 function provides these attributes in its function directory:
 
-	=============== ====================================
-	audio_buf_size	audio buffer size
-	fn_cap		capture pcm device file name
-	fn_cntl		control device file name
-	fn_play		playback pcm device file name
-	req_buf_size	ISO OUT endpoint request buffer size
-	req_count	ISO OUT endpoint request count
-	=============== ====================================
+       =============== ====================================
+       audio_buf_size  audio buffer size
+       fn_cap          capture pcm device file name
+       fn_cntl         control device file name
+       fn_play         playback pcm device file name
+       req_buf_size    ISO OUT endpoint request buffer size
+       req_count       ISO OUT endpoint request count
+       =============== ====================================
 
 The attributes have sane default values.
 
@@ -720,7 +720,7 @@ device: run the gadget
 
 host::
 
-	aplay -l # should list our USB Audio Gadget
+       aplay -l # should list our USB Audio Gadget
 
 17. UAC2 function
 =================
@@ -733,33 +733,33 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac2".
 The uac2 function provides these attributes in its function directory:
 
-	================ ====================================================
-	c_chmask         capture channel mask
-	c_srate          list of capture sampling rates (comma-separated)
-	c_ssize          capture sample size (bytes)
-	c_sync           capture synchronization type (async/adaptive)
-	c_mute_present   capture mute control enable
-	c_volume_present capture volume control enable
-	c_volume_min     capture volume control min value (in 1/256 dB)
-	c_volume_max     capture volume control max value (in 1/256 dB)
-	c_volume_res     capture volume control resolution (in 1/256 dB)
-	c_hs_bint        capture bInterval for HS/SS (1-4: fixed, 0: auto)
-	fb_max           maximum extra bandwidth in async mode
-	p_chmask         playback channel mask
-	p_srate          list of playback sampling rates (comma-separated)
-	p_ssize          playback sample size (bytes)
-	p_mute_present   playback mute control enable
-	p_volume_present playback volume control enable
-	p_volume_min     playback volume control min value (in 1/256 dB)
-	p_volume_max     playback volume control max value (in 1/256 dB)
-	p_volume_res     playback volume control resolution (in 1/256 dB)
-	p_hs_bint        playback bInterval for HS/SS (1-4: fixed, 0: auto)
-	req_number       the number of pre-allocated request for both capture
-	                 and playback
-	function_name    name of the interface
-	c_terminal_type  code of the capture terminal type
-	p_terminal_type  code of the playback terminal type
-	================ ====================================================
+       ================ ====================================================
+       c_chmask         capture channel mask
+       c_srate          list of capture sampling rates (comma-separated)
+       c_ssize          capture sample size (bytes)
+       c_sync           capture synchronization type (async/adaptive)
+       c_mute_present   capture mute control enable
+       c_volume_present capture volume control enable
+       c_volume_min     capture volume control min value (in 1/256 dB)
+       c_volume_max     capture volume control max value (in 1/256 dB)
+       c_volume_res     capture volume control resolution (in 1/256 dB)
+       c_hs_bint        capture bInterval for HS/SS (1-4: fixed, 0: auto)
+       fb_max           maximum extra bandwidth in async mode
+       p_chmask         playback channel mask
+       p_srate          list of playback sampling rates (comma-separated)
+       p_ssize          playback sample size (bytes)
+       p_mute_present   playback mute control enable
+       p_volume_present playback volume control enable
+       p_volume_min     playback volume control min value (in 1/256 dB)
+       p_volume_max     playback volume control max value (in 1/256 dB)
+       p_volume_res     playback volume control resolution (in 1/256 dB)
+       p_hs_bint        playback bInterval for HS/SS (1-4: fixed, 0: auto)
+       req_number       the number of pre-allocated request for both capture
+                        and playback
+       function_name    name of the interface
+       c_terminal_type  code of the capture terminal type
+       p_terminal_type  code of the playback terminal type
+       ================ ====================================================
 
 The attributes have sane default values.
 
@@ -774,12 +774,12 @@ sends a stream of audio data to/from the host. In order to
 actually hear something at the device side, a command similar
 to this must be used at the device side::
 
-	$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
+       $ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
 
 e.g.::
 
-	$ arecord -f dat -t wav -D hw:CARD=UAC2Gadget,DEV=0 | \
-	  aplay -D default:CARD=OdroidU3
+       $ arecord -f dat -t wav -D hw:CARD=UAC2Gadget,DEV=0 | \
+         aplay -D default:CARD=OdroidU3
 
 18. UVC function
 ================
@@ -792,30 +792,30 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uvc".
 The uvc function provides these attributes in its function directory:
 
-	=================== ================================================
-	streaming_interval  interval for polling endpoint for data transfers
-	streaming_maxburst  bMaxBurst for super speed companion descriptor
-	streaming_maxpacket maximum packet size this endpoint is capable of
-			    sending or receiving when this configuration is
-			    selected
-	function_name       name of the interface
-	=================== ================================================
+       =================== ================================================
+       streaming_interval  interval for polling endpoint for data transfers
+       streaming_maxburst  bMaxBurst for super speed companion descriptor
+       streaming_maxpacket maximum packet size this endpoint is capable of
+                           sending or receiving when this configuration is
+                           selected
+       function_name       name of the interface
+       =================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
 a number of their subdirectories. There are some sane defaults provided, but
 the user must provide the following:
 
-	================== ====================================================
-	control header     create in control/header, link from control/class/fs
-			   and/or control/class/ss
-	streaming header   create in streaming/header, link from
-			   streaming/class/fs and/or streaming/class/hs and/or
-			   streaming/class/ss
-	format description create in streaming/mjpeg and/or
-			   streaming/uncompressed
-	frame description  create in streaming/mjpeg/<format> and/or in
-			   streaming/uncompressed/<format>
-	================== ====================================================
+       ================== ====================================================
+       control header     create in control/header, link from control/class/fs
+                          and/or control/class/ss
+       streaming header   create in streaming/header, link from
+                          streaming/class/fs and/or streaming/class/hs and/or
+                          streaming/class/ss
+       format description create in streaming/mjpeg and/or
+                          streaming/uncompressed
+       frame description  create in streaming/mjpeg/<format> and/or in
+                          streaming/uncompressed/<format>
+       ================== ====================================================
 
 Each frame description contains frame interval specification, and each
 such specification consists of a number of lines with an interval value
@@ -851,15 +851,15 @@ device: run the gadget, modprobe vivid::
   # uvc-gadget -u /dev/video<uvc video node #> -v /dev/video<vivid video node #>
 
 where uvc-gadget is this program:
-	http://git.ideasonboard.org/uvc-gadget.git
+       http://git.ideasonboard.org/uvc-gadget.git
 
 with these patches:
 
-	http://www.spinics.net/lists/linux-usb/msg99220.html
+       http://www.spinics.net/lists/linux-usb/msg99220.html
 
 host::
 
-	luvcview -f yuv
+       luvcview -f yuv
 
 19. PRINTER function
 ====================
@@ -872,10 +872,10 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "printer".
 The printer function provides these attributes in its function directory:
 
-	==========	===========================================
-	pnp_string	Data to be passed to the host in pnp string
-	q_len		Number of requests per endpoint
-	==========	===========================================
+       ==========      ===========================================
+       pnp_string      Data to be passed to the host in pnp string
+       q_len           Number of requests per endpoint
+       ==========      ===========================================
 
 Testing the PRINTER function
 ----------------------------
@@ -884,7 +884,7 @@ The most basic testing:
 
 device: run the gadget::
 
-	# ls -l /devices/virtual/usb_printer_gadget/
+       # ls -l /devices/virtual/usb_printer_gadget/
 
 should show g_printer<number>.
 
@@ -898,19 +898,19 @@ host->device transmission:
 
 device::
 
-	# cat /dev/g_printer<number>
+       # cat /dev/g_printer<number>
 
 host::
 
-	# cat > /dev/usb/lp0
+       # cat > /dev/usb/lp0
 
 device->host transmission::
 
-	# cat > /dev/g_printer<number>
+       # cat > /dev/g_printer<number>
 
 host::
 
-	# cat /dev/usb/lp0
+       # cat /dev/usb/lp0
 
 More advanced testing can be done with the prn_example
 described in Documentation/usb/gadget_printer.rst.
@@ -929,27 +929,27 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac1".
 The uac1 function provides these attributes in its function directory:
 
-	================ ====================================================
-	c_chmask         capture channel mask
-	c_srate          list of capture sampling rates (comma-separated)
-	c_ssize          capture sample size (bytes)
-	c_mute_present   capture mute control enable
-	c_volume_present capture volume control enable
-	c_volume_min     capture volume control min value (in 1/256 dB)
-	c_volume_max     capture volume control max value (in 1/256 dB)
-	c_volume_res     capture volume control resolution (in 1/256 dB)
-	p_chmask         playback channel mask
-	p_srate          list of playback sampling rates (comma-separated)
-	p_ssize          playback sample size (bytes)
-	p_mute_present   playback mute control enable
-	p_volume_present playback volume control enable
-	p_volume_min     playback volume control min value (in 1/256 dB)
-	p_volume_max     playback volume control max value (in 1/256 dB)
-	p_volume_res     playback volume control resolution (in 1/256 dB)
-	req_number       the number of pre-allocated requests for both capture
-	                 and playback
-	function_name    name of the interface
-	================ ====================================================
+       ================ ====================================================
+       c_chmask         capture channel mask
+       c_srate          list of capture sampling rates (comma-separated)
+       c_ssize          capture sample size (bytes)
+       c_mute_present   capture mute control enable
+       c_volume_present capture volume control enable
+       c_volume_min     capture volume control min value (in 1/256 dB)
+       c_volume_max     capture volume control max value (in 1/256 dB)
+       c_volume_res     capture volume control resolution (in 1/256 dB)
+       p_chmask         playback channel mask
+       p_srate          list of playback sampling rates (comma-separated)
+       p_ssize          playback sample size (bytes)
+       p_mute_present   playback mute control enable
+       p_volume_present playback volume control enable
+       p_volume_min     playback volume control min value (in 1/256 dB)
+       p_volume_max     playback volume control max value (in 1/256 dB)
+       p_volume_res     playback volume control resolution (in 1/256 dB)
+       req_number       the number of pre-allocated requests for both capture
+                        and playback
+       function_name    name of the interface
+       ================ ====================================================
 
 The attributes have sane default values.
 
@@ -964,12 +964,12 @@ sends a stream of audio data to/from the host. In order to
 actually hear something at the device side, a command similar
 to this must be used at the device side::
 
-	$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
+       $ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
 
 e.g.::
 
-	$ arecord -f dat -t wav -D hw:CARD=UAC1Gadget,DEV=0 | \
-	  aplay -D default:CARD=OdroidU3
+       $ arecord -f dat -t wav -D hw:CARD=UAC1Gadget,DEV=0 | \
+         aplay -D default:CARD=OdroidU3
 
 
 21. MIDI2 function
@@ -988,49 +988,49 @@ The function name to use when creating the function directory is "midi2".
 The midi2 function provides these attributes in its function directory
 as the card top-level information:
 
-	=============	=================================================
-	process_ump	Bool flag to process UMP Stream messages (0 or 1)
-	static_block	Bool flag for static blocks (0 or 1)
-	iface_name	Optional interface name string
-	=============	=================================================
+       =============   =================================================
+       process_ump     Bool flag to process UMP Stream messages (0 or 1)
+       static_block    Bool flag for static blocks (0 or 1)
+       iface_name      Optional interface name string
+       =============   =================================================
 
 The directory contains a subdirectory "ep.0", and this provides the
 attributes for a UMP Endpoint (which is a pair of USB MIDI Endpoints):
 
-	=============	=================================================
-	protocol_caps	MIDI protocol capabilities;
-			1: MIDI 1.0, 2: MIDI 2.0, or 3: both protocols
-	protocol	Default MIDI protocol (either 1 or 2)
-	ep_name		UMP Endpoint name string
-	product_id	Product ID string
-	manufacturer	Manufacture ID number (24 bit)
-	family		Device family ID number (16 bit)
-	model		Device model ID number (16 bit)
-	sw_revision	Software revision (32 bit)
-	=============	=================================================
+       =============   =================================================
+       protocol_caps   MIDI protocol capabilities;
+                       1: MIDI 1.0, 2: MIDI 2.0, or 3: both protocols
+       protocol        Default MIDI protocol (either 1 or 2)
+       ep_name         UMP Endpoint name string
+       product_id      Product ID string
+       manufacturer    Manufacture ID number (24 bit)
+       family          Device family ID number (16 bit)
+       model           Device model ID number (16 bit)
+       sw_revision     Software revision (32 bit)
+       =============   =================================================
 
 Each Endpoint subdirectory contains a subdirectory "block.0", which
 represents the Function Block for Block 0 information.
 Its attributes are:
 
-	=================	===============================================
-	name			Function Block name string
-	direction		Direction of this FB
-				1: input, 2: output, or 3: bidirectional
-	first_group		The first UMP Group number (0-15)
-	num_groups		The number of groups in this FB (1-16)
-	midi1_first_group	The first UMP Group number for MIDI 1.0 (0-15)
-	midi1_num_groups	The number of groups for MIDI 1.0 (0-16)
-	ui_hint			UI-hint of this FB
-				0: unknown, 1: receiver, 2: sender, 3: both
-	midi_ci_verison		Supported MIDI-CI version number (8 bit)
-	is_midi1		Legacy MIDI 1.0 device (0-2)
-				0: MIDI 2.0 device,
-				1: MIDI 1.0 without restriction, or
-				2: MIDI 1.0 with low speed
-	sysex8_streams		Max number of SysEx8 streams (8 bit)
-	active			Bool flag for FB activity (0 or 1)
-	=================	===============================================
+       =================       ===============================================
+       name                    Function Block name string
+       direction               Direction of this FB
+                               1: input, 2: output, or 3: bidirectional
+       first_group             The first UMP Group number (0-15)
+       num_groups              The number of groups in this FB (1-16)
+       midi1_first_group       The first UMP Group number for MIDI 1.0 (0-15)
+       midi1_num_groups        The number of groups for MIDI 1.0 (0-16)
+       ui_hint                 UI-hint of this FB
+                               0: unknown, 1: receiver, 2: sender, 3: both
+       midi_ci_verison         Supported MIDI-CI version number (8 bit)
+       is_midi1                Legacy MIDI 1.0 device (0-2)
+                               0: MIDI 2.0 device,
+                               1: MIDI 1.0 without restriction, or
+                               2: MIDI 1.0 with low speed
+       sysex8_streams          Max number of SysEx8 streams (8 bit)
+       active                  Bool flag for FB activity (0 or 1)
+       =================       ===============================================
 
 If multiple Function Blocks are required, you can add more Function
 Blocks by creating subdirectories "block.<num>" with the corresponding
-- 
2.43.0


