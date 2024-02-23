Return-Path: <linux-kernel+bounces-77912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A67860C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ED31F26C86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6418E08;
	Fri, 23 Feb 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHKltUmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCE18E3A;
	Fri, 23 Feb 2024 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676358; cv=none; b=CQvwnjCKwXzUpCkVEZwuA3eRz7aDP7zTE7hHc+3KrPnpmcnJiBrDnRd+rjrf5vjst37cH+aCtQ8Zhkq71J6l6VeYKU+LZFeac1gmMahEHm97+5VWMWT8tfEiQstp/JiBUh4/1kxpyYojKYGqBY755ylXLwZQI72FtpId/T2mhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676358; c=relaxed/simple;
	bh=pKXhiVzovtSRpksWnhHidKbSNS1BwNi/q9VvIY6FFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiHmhVFw/msSUVgL+38LGa3Ma9pwh2gZSNP8SzPoFVspZAdW9P/XsBg/MUwbn+pzFM0NVoiTQ0H5IsCve9qJXkndQGLSGocTc/OS5J4cZYcv4OwAqr96DeordqZ9B6raMiCGYwpB12E8LybqvqU7ayR1imRZVnVwJCMDq7ByTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHKltUmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93603C433F1;
	Fri, 23 Feb 2024 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708676356;
	bh=pKXhiVzovtSRpksWnhHidKbSNS1BwNi/q9VvIY6FFh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHKltUmE5tiLPiubEiNkTfcv1bXRDkVVQ1XXiIphEaFwuDWejwewlnX7grZlRkqfe
	 0tZ1L1XqUv8SaPTrONyIMsFHUi06wr68paf8CRDsp7NznU0bk4hWuK3NCLlChCVeSq
	 22KWd/7MuEs5QcDFsVlIsnrpQiQ1W4IbKlCFuCk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.149
Date: Fri, 23 Feb 2024 09:19:04 +0100
Message-ID: <2024022304-improve-shriek-b89f@gregkh>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024022304-prelaw-probe-d1a2@gregkh>
References: <2024022304-prelaw-probe-d1a2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 5e6b74f30406..1e7e0bb4c14e 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -52,6 +52,9 @@ Description:
 
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
+		If the transition table is bigger than PAGE_SIZE, reading
+		this will return an -EFBIG error.
+
 What:		/sys/class/devfreq/.../available_frequencies
 Date:		October 2012
 Contact:	Nishanth Menon <nm@ti.com>
diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 978b76358661..40d5aab8452d 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_cpus
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_cpus
 Date:		March 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -8,7 +8,7 @@ Description:
 		network device queue. Possible values depend on the number
 		of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_flow_cnt
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_flow_cnt
 Date:		April 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -16,7 +16,7 @@ Description:
 		Number of Receive Packet Steering flows being currently
 		processed by this particular network device receive queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_timeout
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_timeout
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -24,7 +24,7 @@ Description:
 		Indicates the number of transmit timeout events seen by this
 		network interface transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_maxrate
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
 Date:		March 2015
 KernelVersion:	4.1
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		A Mbps max-rate set for the queue, a value of zero means disabled,
 		default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_cpus
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_cpus
 Date:		November 2010
 KernelVersion:	2.6.38
 Contact:	netdev@vger.kernel.org
@@ -42,7 +42,7 @@ Description:
 		network device transmit queue. Possible vaules depend on the
 		number of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_rxqs
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_rxqs
 Date:		June 2018
 KernelVersion:	4.18.0
 Contact:	netdev@vger.kernel.org
@@ -53,7 +53,7 @@ Description:
 		number of available receive queue(s) in the network device.
 		Default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -62,7 +62,7 @@ Description:
 		of this particular network device transmit queue.
 		Default value is 1000.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -70,7 +70,7 @@ Description:
 		Indicates the number of bytes (objects) in flight on this
 		network device transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -79,7 +79,7 @@ Description:
 		on this network device transmit queue. This value is clamped
 		to be within the bounds defined by limit_max and limit_min.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -88,7 +88,7 @@ Description:
 		queued on this network device transmit queue. See
 		include/linux/dynamic_queue_limits.h for the default value.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-class-net-statistics b/Documentation/ABI/testing/sysfs-class-net-statistics
index 55db27815361..53e508c6936a 100644
--- a/Documentation/ABI/testing/sysfs-class-net-statistics
+++ b/Documentation/ABI/testing/sysfs-class-net-statistics
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/statistics/collisions
+What:		/sys/class/net/<iface>/statistics/collisions
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Indicates the number of collisions seen by this network device.
 		This value might not be relevant with all MAC layers.
 
-What:		/sys/class/<iface>/statistics/multicast
+What:		/sys/class/net/<iface>/statistics/multicast
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -14,7 +14,7 @@ Description:
 		Indicates the number of multicast packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/rx_bytes
+What:		/sys/class/net/<iface>/statistics/rx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -23,7 +23,7 @@ Description:
 		See the network driver for the exact meaning of when this
 		value is incremented.
 
-What:		/sys/class/<iface>/statistics/rx_compressed
+What:		/sys/class/net/<iface>/statistics/rx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		network device. This value might only be relevant for interfaces
 		that support packet compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/rx_crc_errors
+What:		/sys/class/net/<iface>/statistics/rx_crc_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -41,7 +41,7 @@ Description:
 		by this network device. Note that the specific meaning might
 		depend on the MAC layer used by the interface.
 
-What:		/sys/class/<iface>/statistics/rx_dropped
+What:		/sys/class/net/<iface>/statistics/rx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -51,7 +51,7 @@ Description:
 		packet processing. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_errors
+What:		/sys/class/net/<iface>/statistics/rx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -59,7 +59,7 @@ Description:
 		Indicates the number of receive errors on this network device.
 		See the network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/rx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -68,7 +68,7 @@ Description:
 		network device. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_frame_errors
+What:		/sys/class/net/<iface>/statistics/rx_frame_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -78,7 +78,7 @@ Description:
 		on the MAC layer protocol used. See the network driver for
 		the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_length_errors
+What:		/sys/class/net/<iface>/statistics/rx_length_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -87,7 +87,7 @@ Description:
 		error, oversized or undersized. See the network driver for the
 		exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_missed_errors
+What:		/sys/class/net/<iface>/statistics/rx_missed_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -96,7 +96,7 @@ Description:
 		due to lack of capacity in the receive side. See the network
 		driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_nohandler
+What:		/sys/class/net/<iface>/statistics/rx_nohandler
 Date:		February 2016
 KernelVersion:	4.6
 Contact:	netdev@vger.kernel.org
@@ -104,7 +104,7 @@ Description:
 		Indicates the number of received packets that were dropped on
 		an inactive device by the network core.
 
-What:		/sys/class/<iface>/statistics/rx_over_errors
+What:		/sys/class/net/<iface>/statistics/rx_over_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -114,7 +114,7 @@ Description:
 		(e.g: larger than MTU). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_packets
+What:		/sys/class/net/<iface>/statistics/rx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -122,7 +122,7 @@ Description:
 		Indicates the total number of good packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/tx_aborted_errors
+What:		/sys/class/net/<iface>/statistics/tx_aborted_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -132,7 +132,7 @@ Description:
 		a medium collision). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_bytes
+What:		/sys/class/net/<iface>/statistics/tx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -143,7 +143,7 @@ Description:
 		transmitted packets or all packets that have been queued for
 		transmission.
 
-What:		/sys/class/<iface>/statistics/tx_carrier_errors
+What:		/sys/class/net/<iface>/statistics/tx_carrier_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -152,7 +152,7 @@ Description:
 		because of carrier errors (e.g: physical link down). See the
 		network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_compressed
+What:		/sys/class/net/<iface>/statistics/tx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -161,7 +161,7 @@ Description:
 		this might only be relevant for devices that support
 		compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/tx_dropped
+What:		/sys/class/net/<iface>/statistics/tx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -170,7 +170,7 @@ Description:
 		See the driver for the exact reasons as to why the packets were
 		dropped.
 
-What:		/sys/class/<iface>/statistics/tx_errors
+What:		/sys/class/net/<iface>/statistics/tx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -179,7 +179,7 @@ Description:
 		a network device. See the driver for the exact reasons as to
 		why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/tx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -188,7 +188,7 @@ Description:
 		FIFO error. See the driver for the exact reasons as to why the
 		packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_heartbeat_errors
+What:		/sys/class/net/<iface>/statistics/tx_heartbeat_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -197,7 +197,7 @@ Description:
 		reported as heartbeat errors. See the driver for the exact
 		reasons as to why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_packets
+What:		/sys/class/net/<iface>/statistics/tx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -206,7 +206,7 @@ Description:
 		device. See the driver for whether this reports the number of all
 		attempted or successful transmissions.
 
-What:		/sys/class/<iface>/statistics/tx_window_errors
+What:		/sys/class/net/<iface>/statistics/tx_window_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d2f90ecc426f..df7c53102a5f 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -198,3 +198,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index dccd61c7c5c3..193c22687851 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,13 +22,16 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
-parent and finds source and target.  We lock both (provided they exist).  If we
-need to lock two inodes of different type (dir vs non-dir), we lock directory
-first.  If we need to lock two inodes of the same type, lock them in inode
-pointer order.  Then call the method.  All locks are exclusive.
-NB: we might get away with locking the source (and target in exchange
-case) shared.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks
+the parent and finds source and target.  Then we decide which of the
+source and target need to be locked.  Source needs to be locked if it's a
+non-directory; target - if it's a non-directory or about to be removed.
+Take the locks that need to be taken, in inode pointer order if need
+to take both (that can happen only when both source and target are
+non-directories - the source because it wouldn't be locked otherwise
+and the target because mixing directory and non-directory is allowed
+only with RENAME_EXCHANGE, and that won't be removing the target).
+After the locks had been taken, call the method.  All locks are exclusive.
 
 5) link creation.  Locking rules:
 
@@ -44,20 +47,17 @@ rules:
 
 	* lock the filesystem
 	* lock parents in "ancestors first" order. If one is not ancestor of
-	  the other, lock them in inode pointer order.
+	  the other, lock the parent of source first.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* Lock both the source and the target provided they exist. If we
-	  need to lock two inodes of different type (dir vs non-dir), we lock
-	  the directory first. If we need to lock two inodes of the same type,
-	  lock them in inode pointer order.
+	* Lock subdirectories involved (source before target).
+	* Lock non-directories involved, in inode pointer order.
 	* call the method.
 
-All ->i_rwsem are taken exclusive.  Again, we might get away with locking
-the source (and target in exchange case) shared.
+All ->i_rwsem are taken exclusive.
 
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
@@ -67,6 +67,7 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
+[XXX: will be updated once we are done massaging the lock_rename()]
 	First of all, at any moment we have a linear ordering of the
 	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
         of A and ptr(A) < ptr(B)).
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d36fe79167b3..5833cea4a16b 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -98,7 +98,7 @@ symlink:	exclusive
 mkdir:		exclusive
 unlink:		exclusive (both)
 rmdir:		exclusive (both)(see below)
-rename:		exclusive (all)	(see below)
+rename:		exclusive (both parents, some children)	(see below)
 readlink:	no
 get_link:	no
 setattr:	exclusive
@@ -118,6 +118,9 @@ fileattr_set:	exclusive
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
 	exclusive on victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
+	involved.
+	->rename() has ->i_rwsem exclusive on any subdirectory that changes parent.
 
 See Documentation/filesystems/directory-locking.rst for more detailed discussion
 of the locking scheme for directory operations.
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bf19fd6b86e7..569fdb7d7ed5 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -908,3 +908,21 @@ Calling conventions for file_open_root() changed; now it takes struct path *
 instead of passing mount and dentry separately.  For callers that used to
 pass <mnt, mnt->mnt_root> pair (i.e. the root of given mount), a new helper
 is provided - file_open_root_mnt().  In-tree users adjusted.
+
+---
+
+**mandatory**
+
+If ->rename() update of .. on cross-directory move needs an exclusion with
+directory modifications, do *not* lock the subdirectory in question in your
+->rename() - it's done by the caller now [that item should've been added in
+28eceeda130f "fs: Lock moved directories"].
+
+---
+
+**mandatory**
+
+On same-directory ->rename() the (tautological) update of .. is not protected
+by any locks; just don't do it if the old parent is the same as the new one.
+We really can't lock two subdirectories in same-directory rename - not without
+deadlocks.
diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 8e44107933ab..c3154ce6e1b2 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -234,7 +234,7 @@ corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
 ::
 
-  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
+  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 This can be used to merge to signal paths together in software.
 
diff --git a/Makefile b/Makefile
index 1e5ac4584ac1..e0f0677c1bbb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 148
+SUBLEVEL = 149
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/Kconfig b/arch/Kconfig
index b45c699c2bac..2e2dc0975ab4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -605,6 +605,7 @@ config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
 	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
+	depends on MMU
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
 	  shadow stack to protect function return addresses from being
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 93880bdbcad9..8232d843bfe0 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -520,6 +520,14 @@ vtcam_reg: LDO12 {
 				regulator-name = "VT_CAM_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				/*
+				 * Force-enable this regulator; otherwise the
+				 * kernel hangs very early in the boot process
+				 * for about 12 seconds, without apparent
+				 * reason.
+				 */
+				regulator-always-on;
 			};
 
 			vcclcd_reg: LDO13 {
diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index 5833fb6f15d8..2c817c4a4c68 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -65,7 +65,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index 77b21aa7a146..27e72b07b517 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -45,7 +45,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 9b940987864c..8d6e900a9081 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 46057d9bf555..c2efcc20ae80 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -175,10 +175,8 @@ i2c-0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@ i2c-1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index ce3d6360a7ef..b236d23f8071 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -414,7 +414,7 @@ emi@80020000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7 5 9 26
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index 0703f62d10d1..93a6e4e680b4 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -27,7 +27,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 7d4301b22b90..1ed3fb7b9ce6 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -16,7 +16,7 @@ cmo_qvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&qvga_timings>;
-			qvga_timings: 320x240 {
+			qvga_timings: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
index 80a7f96de4c6..64b2ffac463b 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -16,7 +16,7 @@ dvi_svga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_svga_timings>;
-			dvi_svga_timings: 800x600 {
+			dvi_svga_timings: timing0 {
 				clock-frequency = <40000000>;
 				hactive = <800>;
 				vactive = <600>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
index 24027a1fb46d..fb074bfdaa8d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -16,7 +16,7 @@ dvi_vga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_vga_timings>;
-			dvi_vga_timings: 640x480 {
+			dvi_vga_timings: timing0 {
 				clock-frequency = <31250000>;
 				hactive = <640>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index fb66884d8a2f..59b40d13a640 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -78,7 +78,7 @@ wvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&wvga_timings>;
-			wvga_timings: 640x480 {
+			wvga_timings: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <45>;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bd8ea2ec2457..5eb79a9ffe04 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -543,7 +543,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 6f1e8ce9e76e..3d9bb7fc3be2 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -16,7 +16,7 @@ display: display {
 		fsl,pcr = <0xfae80083>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 800x480 {
+			timing0: timing0 {
 				clock-frequency = <33000033>;
 				hactive = <800>;
 				vactive = <480>;
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 74110bbcd9d4..c7e923584878 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -33,7 +33,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
@@ -90,7 +90,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 9c3ec82ec7e5..50fa0bd4c8a1 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -16,7 +16,7 @@ display0: CMO-QVGA {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 320x240 {
+			timing0: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 188639738dc3..7f36af150a25 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -19,7 +19,7 @@ display: display {
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 640x480 {
+			timing0: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <112>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 344e77790152..d133b9f08b3a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -19,7 +19,7 @@ display0: LQ035Q7 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 240x320 {
+			timing0: timing0 {
 				clock-frequency = <5500000>;
 				hactive = <240>;
 				vactive = <320>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 3d10273177e9..a5fdc2fd4ce5 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -322,7 +322,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index fd525c3b16fa..247617d6d41e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 10eab221bc05..7fcc0d35d31c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -992,7 +992,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b0bcfa9094a3..8ad3e60fd7d1 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -209,9 +209,6 @@ pcie: pcie@33800000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 406e8870c680..5b960849c3ab 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -174,7 +174,11 @@ funnel@30041000 {
 			clock-names = "apb_pclk";
 
 			ca_funnel_in_ports: in-ports {
-				port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
 					ca_funnel_in_port0: endpoint {
 						remote-endpoint = <&etm0_out_port>;
 					};
@@ -798,7 +802,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
@@ -1260,7 +1264,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 73fa0ef6b69e..67159e8608ed 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -420,10 +420,10 @@ usb: usb@a6f8800 {
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -447,7 +447,7 @@ pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
 			qcom,pdc-ranges = <0 179 52>;
-			#interrupt-cells = <3>;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupt-controller;
 		};
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ffa9bc7ed3d0..0af1a86f9dc4 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -402,12 +402,20 @@ hdmi: hdmi@20034000 {
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
 
-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8a7c65178507..fd9ffe8448b0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -394,6 +394,19 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	etm {
+		compatible = "qcom,coresight-remote-etm";
+
+		out-ports {
+			port {
+				modem_etm_out_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&funnel_in2_in_modem_etm>;
+				};
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -2203,6 +2216,14 @@ funnel@3023000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
+			in-ports {
+				port {
+					funnel_in2_in_modem_etm: endpoint {
+						remote-endpoint =
+						  <&modem_etm_out_funnel_in2>;
+					};
+				};
+			};
 
 			out-ports {
 				port {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b7d72b0d579e..7eadecba0175 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1863,9 +1863,11 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port{
-				etm4_out: endpoint {
-					remote-endpoint = <&apss_funnel_in4>;
+			out-ports {
+				port{
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -1880,9 +1882,11 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port{
-				etm5_out: endpoint {
-					remote-endpoint = <&apss_funnel_in5>;
+			out-ports {
+				port{
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -1897,9 +1901,11 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port{
-				etm6_out: endpoint {
-					remote-endpoint = <&apss_funnel_in6>;
+			out-ports {
+				port{
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -1914,9 +1920,11 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port{
-				etm7_out: endpoint {
-					remote-endpoint = <&apss_funnel_in7>;
+			out-ports {
+				port{
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 410e0305eb51..8428f1040cac 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2774,8 +2774,8 @@ usb_1: usb@a6f8800 {
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 8 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 9 IRQ_TYPE_LEVEL_HIGH>;
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5a78ee8622c9..15af6c7ad06c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3767,10 +3767,10 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc_intc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc_intc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -3815,10 +3815,10 @@ usb_2: usb@a8f8800 {
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc_intc 10 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc_intc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index c6b6064e6b12..a072b40c9698 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3094,8 +3094,8 @@ usb_1: usb@a6f8800 {
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -3139,8 +3139,8 @@ usb_2: usb@a8f8800 {
 
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index c2a1ccd5fd46..3656bbbb7c7b 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -116,6 +117,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -157,6 +160,7 @@
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index 81bbfa3a035b..a1020285ea75 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-extern void arch_irq_work_raise(void);
-
 static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index bf69a20bc27f..4f12d8c1e55b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -367,6 +367,7 @@ static struct midr_range broken_aarch32_aes[] = {
 static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2139208
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2119858
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -379,6 +380,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 static const struct midr_range tsb_flush_fail_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2067961
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2054223
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -391,6 +393,7 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 static struct midr_range trbe_write_out_of_range_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2253138
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2224489
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..351958be8ac8 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -19,6 +19,7 @@
 #include <linux/kprobes.h>
 #include <linux/scs.h>
 #include <linux/seq_file.h>
+#include <asm/numa.h>
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
@@ -44,17 +45,17 @@ static void init_irq_scs(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(irq_shadow_call_stack_ptr, cpu) =
-			scs_alloc(cpu_to_node(cpu));
+			scs_alloc(early_cpu_to_node(cpu));
 }
 
 #ifdef CONFIG_VMAP_STACK
-static void init_irq_stacks(void)
+static void __init init_irq_stacks(void)
 {
 	int cpu;
 	unsigned long *p;
 
 	for_each_possible_cpu(cpu) {
-		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
+		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
 		per_cpu(irq_stack_ptr, cpu) = p;
 	}
 }
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b4044469527e..c77b9460d63e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -168,7 +168,11 @@ armv8pmu_events_sysfs_show(struct device *dev,
 	PMU_EVENT_ATTR_ID(name, armv8pmu_events_sysfs_show, config)
 
 static struct attribute *armv8_pmuv3_event_attrs[] = {
-	ARMV8_EVENT_ATTR(sw_incr, ARMV8_PMUV3_PERFCTR_SW_INCR),
+	/*
+	 * Don't expose the sw_incr event in /sys. It's not usable as writes to
+	 * PMSWINC_EL0 will trap as PMUSERENR.{SW,EN}=={0,0} and event rotation
+	 * means we don't have a fixed event<->counter relationship regardless.
+	 */
 	ARMV8_EVENT_ATTR(l1i_cache_refill, ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL),
 	ARMV8_EVENT_ATTR(l1i_tlb_refill, ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL),
 	ARMV8_EVENT_ATTR(l1d_cache_refill, ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL),
diff --git a/arch/csky/include/asm/irq_work.h b/arch/csky/include/asm/irq_work.h
index 33aaf39d6f94..d39fcc1f5395 100644
--- a/arch/csky/include/asm/irq_work.h
+++ b/arch/csky/include/asm/irq_work.h
@@ -7,5 +7,5 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
 }
-extern void arch_irq_work_raise(void);
+
 #endif /* __ASM_CSKY_IRQ_WORK_H */
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 1e6c1354f245..eb15339e58fd 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -244,7 +244,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	"	.set	pop"
 	: "=&r" (sum), "=&r" (tmp)
 	: "r" (saddr), "r" (daddr),
-	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
+	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
+	: "memory");
 
 	return csum_fold(sum);
 }
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 7b045d2a0b51..bbc6f07d8124 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -11,6 +11,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
+#include <asm/fpu.h>
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
@@ -309,6 +310,11 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
+	 * we are preempted before the lose_fpu(0) in start_thread.
+	 */
+	lose_fpu(0);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 19347dc6bbf8..833fcfc20b10 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -417,7 +417,12 @@ void __init paging_init(void)
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
+
+	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+#else
+	max_mapnr = max_low_pfn;
 #endif
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -453,13 +458,6 @@ void __init mem_init(void)
 	 */
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
 
-#ifdef CONFIG_HIGHMEM
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
-#else
-	max_mapnr = max_low_pfn;
-#endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 	maar_init();
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 5385e0fe9842..1d69e8cf459c 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -123,10 +123,10 @@ static unsigned long f_extend(unsigned long address)
 #ifdef CONFIG_64BIT
 	if(unlikely(parisc_narrow_firmware)) {
 		if((address & 0xff000000) == 0xf0000000)
-			return 0xf0f0f0f000000000UL | (u32)address;
+			return (0xfffffff0UL << 32) | (u32)address;
 
 		if((address & 0xf0000000) == 0xf0000000)
-			return 0xffffffff00000000UL | (u32)address;
+			return (0xffffffffUL << 32) | (u32)address;
 	}
 #endif
 	return address;
diff --git a/arch/powerpc/include/asm/irq_work.h b/arch/powerpc/include/asm/irq_work.h
index b8b0be8f1a07..c6d3078bd8c3 100644
--- a/arch/powerpc/include/asm/irq_work.h
+++ b/arch/powerpc/include/asm/irq_work.h
@@ -6,6 +6,5 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
 }
-extern void arch_irq_work_raise(void);
 
 #endif /* _ASM_POWERPC_IRQ_WORK_H */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 8abe8e42e045..de0bb77f54e0 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -416,5 +416,9 @@ extern void *abatron_pteptrs[2];
 #include <asm/nohash/mmu.h>
 #endif
 
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 4c6c6dbd182f..da827d2d0866 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -42,14 +42,6 @@ u64 memory_hotplug_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NUMA */
-#ifdef CONFIG_FA_DUMP
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end,
-				  int nid, pgprot_t prot);
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
index ff8c8c03f41a..c4a54208ba22 100644
--- a/arch/powerpc/kernel/interrupt_64.S
+++ b/arch/powerpc/kernel/interrupt_64.S
@@ -62,7 +62,8 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
 	mr	r10,r1
 	ld	r1,PACAKSAVE(r13)
 	std	r10,0(r1)
-	std	r11,_NIP(r1)
+	std	r11,_LINK(r1)
+	std	r11,_NIP(r1)	/* Saved LR is also the next instruction */
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
@@ -85,7 +86,6 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
 	std	r9,GPR13(r1)
 	SAVE_NVGPRS(r1)
 	std	r11,_XER(r1)
-	std	r11,_LINK(r1)
 	std	r11,_CTR(r1)
 
 	li	r11,\trapnr
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fe912983ced9..f1a2a75c4757 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1423,10 +1423,12 @@ static int emulate_instruction(struct pt_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
 	return is_kernel_addr(addr);
 }
+#endif
 
 #ifdef CONFIG_MATH_EMULATION
 static int emulate_math(struct pt_regs *regs)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 2d39b7c246e3..ecc2e06854d7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -529,6 +529,8 @@ static int do_fp_load(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -579,6 +581,8 @@ static int do_fp_store(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -623,6 +627,9 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u = {};
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
@@ -650,6 +657,9 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u;
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 9e16c7b1a6c5..da15f28c7b13 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -459,6 +459,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -480,6 +481,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
+#endif
 
 /*
  * Does the CPU support tlbie?
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 3a82f89827a5..4bc8f0c893a2 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -105,7 +105,7 @@ void pgtable_cache_add(unsigned int shift)
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
-	struct kmem_cache *new;
+	struct kmem_cache *new = NULL;
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
@@ -118,7 +118,8 @@ void pgtable_cache_add(unsigned int shift)
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
+	if (name)
+		new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index f3e4d069e0ba..643fc525897d 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -64,6 +64,7 @@ int __init __weak kasan_init_region(void *start, size_t size)
 	if (ret)
 		return ret;
 
+	k_start = k_start & PAGE_MASK;
 	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
 	if (!block)
 		return -ENOMEM;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index dd1cabc2ea0f..21996b9e0a64 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -190,3 +190,8 @@ static inline bool debug_pagealloc_enabled_or_kfence(void)
 {
 	return IS_ENABLED(CONFIG_KFENCE) || debug_pagealloc_enabled();
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int create_section_mapping(unsigned long start, unsigned long end,
+			   int nid, pgprot_t prot);
+#endif
diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
index b53891964ae0..b27a4d64fc6a 100644
--- a/arch/riscv/include/asm/irq_work.h
+++ b/arch/riscv/include/asm/irq_work.h
@@ -6,5 +6,5 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return IS_ENABLED(CONFIG_SMP);
 }
-extern void arch_irq_work_raise(void);
+
 #endif /* _ASM_RISCV_IRQ_WORK_H */
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 1023e9d43d44..401236f66b64 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -601,7 +601,9 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
-		cpacf_kmctr(sctx->fc, sctx->key, buf, walk.src.virt.addr,
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
+		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
 			    AES_BLOCK_SIZE, walk.iv);
 		memcpy(walk.dst.virt.addr, buf, nbytes);
 		crypto_inc(walk.iv, AES_BLOCK_SIZE);
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 621322eb0e68..d84d87349718 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -688,9 +688,11 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
 		while (1) {
 			if (cpacf_kmctr(ctx->fc, &param, buf,
-					walk.src.virt.addr, AES_BLOCK_SIZE,
+					buf, AES_BLOCK_SIZE,
 					walk.iv) == AES_BLOCK_SIZE)
 				break;
 			if (__paes_convert_key(ctx))
diff --git a/arch/s390/include/asm/irq_work.h b/arch/s390/include/asm/irq_work.h
index 603783766d0a..f00c9f610d5a 100644
--- a/arch/s390/include/asm/irq_work.h
+++ b/arch/s390/include/asm/irq_work.h
@@ -7,6 +7,4 @@ static inline bool arch_irq_work_has_interrupt(void)
 	return true;
 }
 
-void arch_irq_work_raise(void);
-
 #endif /* _ASM_S390_IRQ_WORK_H */
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 516c21baf3ad..014ed5b27027 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -392,6 +392,7 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if ((unsigned int) data != 0 ||
 		    test_fp_ctl(data >> (BITS_PER_LONG - 32)))
 			return -EINVAL;
@@ -754,6 +755,7 @@ static int __poke_user_compat(struct task_struct *child,
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if (test_fp_ctl(tmp))
 			return -EINVAL;
 		child->thread.fpu.fpc = data;
@@ -917,9 +919,7 @@ static int s390_fpregs_set(struct task_struct *target,
 	int rc = 0;
 	freg_t fprs[__NUM_FPRS];
 
-	if (target == current)
-		save_fpu_regs();
-
+	save_fpu_regs();
 	if (MACHINE_HAS_VX)
 		convert_vx_to_fp(fprs, target->thread.fpu.vxrs);
 	else
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index eb97db59b236..5526f782249c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3700,10 +3700,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 	vcpu_load(vcpu);
 
-	if (test_fp_ctl(fpu->fpc)) {
-		ret = -EINVAL;
-		goto out;
-	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
@@ -3711,7 +3707,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
 
-out:
 	vcpu_put(vcpu);
 	return ret;
 }
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 2fc0b038ff8a..e24bc9aaff4a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index a2cfd42608a0..cb798a50e8cf 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -50,7 +50,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int cpu(void);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index b3fbfca49400..4b6179a8a3e8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -218,7 +218,7 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index fddd1dec27e6..3e270da6b6f6 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -432,9 +432,29 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 	time_travel_del_event(&ne);
 }
 
+static void time_travel_update_time_rel(unsigned long long offs)
+{
+	unsigned long flags;
+
+	/*
+	 * Disable interrupts before calculating the new time so
+	 * that a real timer interrupt (signal) can't happen at
+	 * a bad time e.g. after we read time_travel_time but
+	 * before we've completed updating the time.
+	 */
+	local_irq_save(flags);
+	time_travel_update_time(time_travel_time + offs, false);
+	local_irq_restore(flags);
+}
+
 void time_travel_ndelay(unsigned long nsec)
 {
-	time_travel_update_time(time_travel_time + nsec, false);
+	/*
+	 * Not strictly needed to use _rel() version since this is
+	 * only used in INFCPU/EXT modes, but it doesn't hurt and
+	 * is more readable too.
+	 */
+	time_travel_update_time_rel(nsec);
 }
 EXPORT_SYMBOL(time_travel_ndelay);
 
@@ -568,7 +588,11 @@ static void time_travel_set_start(void)
 #define time_travel_time 0
 #define time_travel_ext_waiting 0
 
-static inline void time_travel_update_time(unsigned long long ns, bool retearly)
+static inline void time_travel_update_time(unsigned long long ns, bool idle)
+{
+}
+
+static inline void time_travel_update_time_rel(unsigned long long offs)
 {
 }
 
@@ -720,9 +744,7 @@ static u64 timer_read(struct clocksource *cs)
 		 */
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
 		    !time_travel_ext_waiting)
-			time_travel_update_time(time_travel_time +
-						TIMER_MULTIPLIER,
-						false);
+			time_travel_update_time_rel(TIMER_MULTIPLIER);
 		return time_travel_time / TIMER_MULTIPLIER;
 	}
 
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 32e88baf18dd..4e429a41565c 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -69,7 +69,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index fc0f2a9dee5a..1dca4ffbd572 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -173,23 +173,38 @@ __uml_setup("quiet", quiet_cmd_param,
 "quiet\n"
 "    Turns off information messages during boot.\n\n");
 
+/*
+ * The os_info/os_warn functions will be called by helper threads. These
+ * have a very limited stack size and using the libc formatting functions
+ * may overflow the stack.
+ * So pull in the kernel vscnprintf and use that instead with a fixed
+ * on-stack buffer.
+ */
+int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+
 void os_info(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	if (quiet_info)
 		return;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
 
 void os_warn(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..6f55609ba706 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -379,7 +379,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 575d881ff86e..b72dea92cd96 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -357,3 +357,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	add_identity_map(address, end);
 }
+
+void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Empty handler to ignore NMI during early boot */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567d663a..9620883485ac 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -45,6 +45,7 @@ void load_stage2_idt(void)
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_trap);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e199f5b..4d03c8562f63 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -70,6 +70,7 @@ SYM_FUNC_END(\name)
 	.code64
 
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
+EXCEPTION_HANDLER	boot_nmi_trap do_boot_nmi_trap error_code=0
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb		error_code=1
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 31139256859f..cea1b96c48b2 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -163,6 +163,7 @@ static inline void cleanup_exception_handling(void) { }
 
 /* IDT Entry Points */
 void boot_page_fault(void);
+void boot_nmi_trap(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_work.h
index 800ffce0db29..6b4d36c95165 100644
--- a/arch/x86/include/asm/irq_work.h
+++ b/arch/x86/include/asm/irq_work.h
@@ -9,7 +9,6 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return boot_cpu_has(X86_FEATURE_APIC);
 }
-extern void arch_irq_work_raise(void);
 #else
 static inline bool arch_irq_work_has_interrupt(void)
 {
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e8ab7c1f1080..4163d02728cf 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -58,12 +58,29 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\
 
+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\
 
 #define __SYS_STUB0(abi, name)						\
 	long __##abi##_##name(const struct pt_regs *regs);		\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a0727723676b..eb48729e220e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -274,6 +275,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -329,6 +331,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		/*
+		 * Kdump skips the poisoned page in order to avoid
+		 * touching the error bits again. Poison the page even
+		 * if the error is fatal and the machine is about to
+		 * panic.
+		 */
+		if (kexec_crash_loaded()) {
+			if (final && (final->status & MCI_STATUS_ADDRV)) {
+				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				if (p)
+					SetPageHWPoison(p);
+			}
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..f50cc210a981 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/block/bio.c b/block/bio.c
index a0080dc55c95..92399883bc5e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -809,7 +809,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index f95feabb3ca8..645a589edda8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1342,6 +1342,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
+	/*
+	 * If the delay is set by another CPU, we may be in the past. No need to
+	 * change anything if so. This avoids decay calculation underflow.
+	 */
+	if (time_before64(now->now, iocg->delay_at))
+		return false;
+
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
 	if (iocg->delay)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bbbbcd2c1941..d80ebba16778 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1176,6 +1176,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
+	/*
+	 * Add one explicit barrier since blk_mq_get_driver_tag() may
+	 * not imply barrier in case of failure.
+	 *
+	 * Order adding us to wait queue and allocating driver tag.
+	 *
+	 * The pair is the one implied in sbitmap_queue_wake_up() which
+	 * orders clearing sbitmap tag bits and waitqueue_active() in
+	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
+	 *
+	 * Otherwise, re-order of adding wait queue and getting driver tag
+	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
+	 * the waitqueue_active() may not observe us in wait queue.
+	 */
+	smp_mb();
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
diff --git a/block/ioctl.c b/block/ioctl.c
index 0a3cf9aeec7d..7a939c178660 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	sector_t start, length;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1ead8c001561..b6a941889bb4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -463,6 +463,11 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		goto out;
 	}
 
+	if (disk->flags & GENHD_FL_NO_PART) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (partition_overlaps(disk, start, length, -1)) {
 		ret = -EBUSY;
 		goto out;
diff --git a/crypto/algapi.c b/crypto/algapi.c
index c390a79c5a66..565f591c4b81 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,6 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
+		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 088db2356998..0a84d5afd37c 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -308,9 +308,10 @@ static int __init extlog_init(void)
 static void __exit extlog_exit(void)
 {
 	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
 	if (elog_addr)
 		acpi_os_unmap_iomem(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 61bcdc75bee7..c8eb69d3e1d6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -566,6 +566,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "COLORFUL X15 AT 23",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8678e162181f..160606af8b4f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -99,6 +99,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt). On x86, the HEST notifications are always
+ * asynchronous, so only SEA on ARM is delivered as a synchronous
+ * notification.
+ */
+static inline bool is_hest_sync_notify(struct ghes *ghes)
+{
+	u8 notify_type = ghes->generic->notify.type;
+
+	return notify_type == ACPI_HEST_NOTIFY_SEA;
+}
+
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -461,7 +475,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -475,7 +489,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -483,9 +497,11 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -510,7 +526,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -631,6 +647,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -648,13 +665,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b4b73093757f..7547c4ed265c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -450,6 +450,16 @@ binder_enqueue_thread_work_ilocked(struct binder_thread *thread,
 {
 	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
+
+	/* (e)poll-based threads require an explicit wakeup signal when
+	 * queuing their own work; they rely on these events to consume
+	 * messages without I/O block. Without it, threads risk waiting
+	 * indefinitely without handling the work.
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL &&
+	    thread->pid == current->pid && !thread->process_todo)
+		wake_up_interruptible_sync(&thread->wait);
+
 	thread->process_todo = true;
 }
 
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 49cb4537344a..2daf50d4cd47 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2930,6 +2930,8 @@ open_card_ubr0(struct idt77252_dev *card)
 	vc->scq = alloc_scq(card, vc->class);
 	if (!vc->scq) {
 		printk("%s: can't get SCQ.\n", card->name);
+		kfree(card->vcs[0]);
+		card->vcs[0] = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 00fb4120a5b3..bce0902dccb4 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static int __init early_cpu_to_node(int cpu)
+int __init early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6ffee01e174d..aaf6c297c63d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1044,7 +1044,7 @@ static int __init genpd_power_off_unused(void)
 
 	return 0;
 }
-late_initcall(genpd_power_off_unused);
+late_initcall_sync(genpd_power_off_unused);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 8c4819fe73d4..185ea0d93a5e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -580,7 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
 }
 
 /**
- * device_resume_noirq - Execute a "noirq resume" callback for given device.
+ * __device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
@@ -588,7 +588,7 @@ bool dev_pm_skip_resume(struct device *dev)
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -656,7 +656,13 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_noirq++;
+		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
+	}
 }
 
 static bool is_async(struct device *dev)
@@ -669,27 +675,35 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(func, dev);
+	if (!is_async(dev))
+		return false;
+
+	get_device(dev);
+
+	if (async_schedule_dev_nocall(func, dev))
 		return true;
-	}
+
+	put_device(dev);
 
 	return false;
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_noirq(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	struct device *dev = data;
 
+	__device_resume_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_noirq(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_noirq))
+		return;
+
+	__device_resume_noirq(dev, pm_transition, false);
+}
+
 static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -699,14 +713,6 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
-		dpm_async_fn(dev, async_resume_noirq);
-
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		get_device(dev);
@@ -714,17 +720,7 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
-
-			error = device_resume_noirq(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_noirq++;
-				dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " noirq", error);
-			}
-		}
+		device_resume_noirq(dev);
 
 		put_device(dev);
 
@@ -754,14 +750,14 @@ void dpm_resume_noirq(pm_message_t state)
 }
 
 /**
- * device_resume_early - Execute an "early resume" callback for given device.
+ * __device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int device_resume_early(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -814,21 +810,31 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 
 	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_early++;
+		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async early" : " early", error);
+	}
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_early(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	struct device *dev = data;
 
+	__device_resume_early(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_early(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_early))
+		return;
+
+	__device_resume_early(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -842,14 +848,6 @@ void dpm_resume_early(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
-		dpm_async_fn(dev, async_resume_early);
-
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		get_device(dev);
@@ -857,17 +855,7 @@ void dpm_resume_early(pm_message_t state)
 
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
-
-			error = device_resume_early(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_early++;
-				dpm_save_failed_step(SUSPEND_RESUME_EARLY);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " early", error);
-			}
-		}
+		device_resume_early(dev);
 
 		put_device(dev);
 
@@ -891,12 +879,12 @@ void dpm_resume_start(pm_message_t state)
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
 /**
- * device_resume - Execute "resume" callbacks for given device.
+ * __device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  */
-static int device_resume(struct device *dev, pm_message_t state, bool async)
+static void __device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -978,20 +966,30 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 	TRACE_RESUME(error);
 
-	return error;
+	if (error) {
+		suspend_stats.failed_resume++;
+		dpm_save_failed_step(SUSPEND_RESUME);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async" : "", error);
+	}
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
+	struct device *dev = data;
 
-	error = device_resume(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	__device_resume(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume))
+		return;
+
+	__device_resume(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
  * @state: PM transition of the system being carried out.
@@ -1011,27 +1009,17 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
-		dpm_async_fn(dev, async_resume);
-
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
+
 		get_device(dev);
-		if (!is_async(dev)) {
-			int error;
 
-			mutex_unlock(&dpm_list_mtx);
+		mutex_unlock(&dpm_list_mtx);
+
+		device_resume(dev);
 
-			error = device_resume(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume++;
-				dpm_save_failed_step(SUSPEND_RESUME);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, "", error);
-			}
+		mutex_lock(&dpm_list_mtx);
 
-			mutex_lock(&dpm_list_mtx);
-		}
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
@@ -1272,7 +1260,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_noirq(dev, pm_transition, true);
@@ -1455,7 +1443,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_late(dev, pm_transition, true);
@@ -1731,7 +1719,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 
 static void async_suspend(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend(dev, pm_transition, true);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5824d41a0b74..6699096ff2fa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1479,11 +1479,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
 static void pm_runtime_disable_action(void *data)
 {
+	pm_runtime_dont_use_autosuspend(data);
 	pm_runtime_disable(data);
 }
 
 /**
  * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ *
+ * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
+ * you at driver exit time if needed.
+ *
  * @dev: Device to handle.
  */
 int devm_pm_runtime_enable(struct device *dev)
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 16744a79a178..3d6b12f27d0c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3454,14 +3454,15 @@ static bool rbd_lock_add_request(struct rbd_img_request *img_req)
 static void rbd_lock_del_request(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
-	bool need_wakeup;
+	bool need_wakeup = false;
 
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 	spin_lock(&rbd_dev->lock_lists_lock);
-	rbd_assert(!list_empty(&img_req->lock_item));
-	list_del_init(&img_req->lock_item);
-	need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
-		       list_empty(&rbd_dev->running_list));
+	if (!list_empty(&img_req->lock_item)) {
+		list_del_init(&img_req->lock_item);
+		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
+			       list_empty(&rbd_dev->running_list));
+	}
 	spin_unlock(&rbd_dev->lock_lists_lock);
 	if (need_wakeup)
 		complete(&rbd_dev->releasing_wait);
@@ -3844,14 +3845,19 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 		return;
 	}
 
-	list_for_each_entry(img_req, &rbd_dev->acquiring_list, lock_item) {
+	while (!list_empty(&rbd_dev->acquiring_list)) {
+		img_req = list_first_entry(&rbd_dev->acquiring_list,
+					   struct rbd_img_request, lock_item);
 		mutex_lock(&img_req->state_mutex);
 		rbd_assert(img_req->state == RBD_IMG_EXCLUSIVE_LOCK);
+		if (!result)
+			list_move_tail(&img_req->lock_item,
+				       &rbd_dev->running_list);
+		else
+			list_del_init(&img_req->lock_item);
 		rbd_img_schedule(img_req, result);
 		mutex_unlock(&img_req->state_mutex);
 	}
-
-	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
 static bool locker_equal(const struct ceph_locker *lhs,
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1896cde8135e..86a6242d9c20 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -606,6 +606,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 {
 	char *full_path;
 	char *a, *b;
+	int len;
 
 	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!full_path)
@@ -617,19 +618,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	 */
 	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
 	if (a) {
-		int len = a - dev_search_path;
+		len = a - dev_search_path;
 
 		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
 			       dev_search_path, srv_sess->sessname, dev_name);
-		if (len >= PATH_MAX) {
-			pr_err("Too long path: %s, %s, %s\n",
-			       dev_search_path, srv_sess->sessname, dev_name);
-			kfree(full_path);
-			return ERR_PTR(-EINVAL);
-		}
 	} else {
-		snprintf(full_path, PATH_MAX, "%s/%s",
-			 dev_search_path, dev_name);
+		len = snprintf(full_path, PATH_MAX, "%s/%s",
+			       dev_search_path, dev_name);
+	}
+	if (len >= PATH_MAX) {
+		pr_err("Too long path: %s, %s, %s\n",
+		       dev_search_path, srv_sess->sessname, dev_name);
+		kfree(full_path);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* eliminitate duplicated slashes */
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 56b4b7248483..d10f1fe0f5fa 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1860,6 +1860,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 = {
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 829d4fca7ddc..7ccc5cd27fd0 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -338,7 +338,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 		er_ctxt->msivec = cpu_to_le32(mhi_event->irq);
 		mhi_event->db_cfg.db_mode = true;
 
-		ring->el_size = sizeof(struct mhi_tre);
+		ring->el_size = sizeof(struct mhi_ring_element);
 		ring->len = ring->el_size * ring->elements;
 		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
 		if (ret)
@@ -370,7 +370,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
 		struct mhi_ring *ring = &mhi_cmd->ring;
 
-		ring->el_size = sizeof(struct mhi_tre);
+		ring->el_size = sizeof(struct mhi_ring_element);
 		ring->elements = CMD_EL_PER_RING;
 		ring->len = ring->el_size * ring->elements;
 		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
@@ -613,7 +613,7 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
 
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
-	tre_ring->el_size = sizeof(struct mhi_tre);
+	tre_ring->el_size = sizeof(struct mhi_ring_element);
 	tre_ring->len = tre_ring->el_size * tre_ring->elements;
 	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
 	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 71f181402be9..df65bb17fdba 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -257,7 +257,7 @@ struct mhi_ctxt {
 	dma_addr_t cmd_ctxt_addr;
 };
 
-struct mhi_tre {
+struct mhi_ring_element {
 	__le64 ptr;
 	__le32 dword[2];
 };
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 6b3668999942..1cb7c60594f1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -267,7 +267,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
+			!(addr & (sizeof(struct mhi_ring_element) - 1));
 }
 
 int mhi_destroy_device(struct device *dev, void *data)
@@ -556,7 +557,7 @@ static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
 }
 
 static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
-			    struct mhi_tre *event,
+			    struct mhi_ring_element *event,
 			    struct mhi_chan *mhi_chan)
 {
 	struct mhi_ring *buf_ring, *tre_ring;
@@ -592,7 +593,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	case MHI_EV_CC_EOT:
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
-		struct mhi_tre *local_rp, *ev_tre;
+		struct mhi_ring_element *local_rp, *ev_tre;
 		void *dev_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
@@ -633,6 +634,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
 
+			read_unlock_bh(&mhi_chan->lock);
+
 			/* notify client */
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 
@@ -658,6 +661,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 					kfree(buf_info->cb_buf);
 				}
 			}
+
+			read_lock_bh(&mhi_chan->lock);
 		}
 		break;
 	} /* CC_EOT */
@@ -691,7 +696,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 }
 
 static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
-			   struct mhi_tre *event,
+			   struct mhi_ring_element *event,
 			   struct mhi_chan *mhi_chan)
 {
 	struct mhi_ring *buf_ring, *tre_ring;
@@ -755,12 +760,12 @@ static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
 }
 
 static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
-				       struct mhi_tre *tre)
+				       struct mhi_ring_element *tre)
 {
 	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
 	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
 	struct mhi_ring *mhi_ring = &cmd_ring->ring;
-	struct mhi_tre *cmd_pkt;
+	struct mhi_ring_element *cmd_pkt;
 	struct mhi_chan *mhi_chan;
 	u32 chan;
 
@@ -793,7 +798,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
 			     u32 event_quota)
 {
-	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring_element *dev_rp, *local_rp;
 	struct mhi_ring *ev_ring = &mhi_event->ring;
 	struct mhi_event_ctxt *er_ctxt =
 		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
@@ -963,7 +968,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 				struct mhi_event *mhi_event,
 				u32 event_quota)
 {
-	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring_element *dev_rp, *local_rp;
 	struct mhi_ring *ev_ring = &mhi_event->ring;
 	struct mhi_event_ctxt *er_ctxt =
 		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
@@ -1110,17 +1115,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
 		return -EIO;
 
-	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-
 	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
-	if (unlikely(ret)) {
-		ret = -EAGAIN;
-		goto exit_unlock;
-	}
+	if (unlikely(ret))
+		return -EAGAIN;
 
 	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
 	if (unlikely(ret))
-		goto exit_unlock;
+		return ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
 	/* Packet is queued, take a usage ref to exit M3 if necessary
 	 * for host->device buffer, balanced put is done on buffer completion
@@ -1140,7 +1143,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (dir == DMA_FROM_DEVICE)
 		mhi_cntrl->runtime_put(mhi_cntrl);
 
-exit_unlock:
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
@@ -1187,11 +1189,14 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 			struct mhi_buf_info *info, enum mhi_flags flags)
 {
 	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_tre *mhi_tre;
+	struct mhi_ring_element *mhi_tre;
 	struct mhi_buf_info *buf_info;
 	int eot, eob, chain, bei;
 	int ret;
 
+	/* Protect accesses for reading and incrementing WP */
+	write_lock_bh(&mhi_chan->lock);
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1209,8 +1214,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret)
+		if (ret) {
+			write_unlock_bh(&mhi_chan->lock);
 			return ret;
+		}
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1227,6 +1234,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+	write_unlock_bh(&mhi_chan->lock);
+
 	return 0;
 }
 
@@ -1258,7 +1267,7 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
 		 struct mhi_chan *mhi_chan,
 		 enum mhi_cmd_type cmd)
 {
-	struct mhi_tre *cmd_tre = NULL;
+	struct mhi_ring_element *cmd_tre = NULL;
 	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
 	struct mhi_ring *ring = &mhi_cmd->ring;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -1516,7 +1525,7 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
 				  int chan)
 
 {
-	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring_element *dev_rp, *local_rp;
 	struct mhi_ring *ev_ring;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	unsigned long flags;
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index fd87a59837fa..fbf0818933be 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -832,6 +832,12 @@ static int moxtet_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -843,6 +849,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index cfb085de876b..c3a2df67e0e9 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -24,10 +24,13 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
+#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+
 static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
@@ -59,7 +62,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 
 static size_t rng_buffer_size(void)
 {
-	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
+	return RNG_BUFFER_SIZE;
 }
 
 static void add_early_randomness(struct hwrng *rng)
@@ -206,6 +209,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			    size_t size, loff_t *offp)
 {
+	u8 buffer[RNG_BUFFER_SIZE];
 	ssize_t ret = 0;
 	int err = 0;
 	int bytes_read, len;
@@ -233,34 +237,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (bytes_read < 0) {
 				err = bytes_read;
 				goto out_unlock_reading;
+			} else if (bytes_read == 0 &&
+				   (filp->f_flags & O_NONBLOCK)) {
+				err = -EAGAIN;
+				goto out_unlock_reading;
 			}
+
 			data_avail = bytes_read;
 		}
 
-		if (!data_avail) {
-			if (filp->f_flags & O_NONBLOCK) {
-				err = -EAGAIN;
-				goto out_unlock_reading;
-			}
-		} else {
-			len = data_avail;
+		len = data_avail;
+		if (len) {
 			if (len > size)
 				len = size;
 
 			data_avail -= len;
 
-			if (copy_to_user(buf + ret, rng_buffer + data_avail,
-								len)) {
+			memcpy(buffer, rng_buffer + data_avail, len);
+		}
+		mutex_unlock(&reading_mutex);
+		put_rng(rng);
+
+		if (len) {
+			if (copy_to_user(buf + ret, buffer, len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
 
 		if (need_resched())
 			schedule_timeout_interruptible(1);
@@ -271,6 +278,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		}
 	}
 out:
+	memzero_explicit(buffer, sizeof(buffer));
 	return ret ? : err;
 
 out_unlock_reading:
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..eb9c139babc3 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -467,8 +467,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 32df47c56621..ef560b59df11 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -67,6 +67,22 @@ static const char * const lcd_pxl_sels[] = {
 	"lcd_pxl_bypass_div_clk",
 };
 
+static const char *const lvds0_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"mipi0_lvds_bypass_clk",
+};
+
+static const char *const lvds1_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"mipi1_lvds_bypass_clk",
+};
+
 static const char * const mipi_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
@@ -201,9 +217,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi0_lvds_pixel_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi0_lvds_phy_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu2("mipi0_lvds_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("mipi0_lvds_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
@@ -213,9 +229,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi1_lvds_pixel_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi1_lvds_phy_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu2("mipi1_lvds_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("mipi1_lvds_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 1cee88b073fa..89a914a15d62 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -841,8 +841,10 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
 	if (!clk_node)
 		return ERR_PTR(-ENOMEM);
 
-	if (!imx_scu_clk_is_valid(rsrc_id))
+	if (!imx_scu_clk_is_valid(rsrc_id)) {
+		kfree(clk_node);
 		return ERR_PTR(-EINVAL);
+	}
 
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02e83cb..9674c6c06dca 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,18 +258,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 736cb2cfcbb0..dd5f4eee9ffb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -490,6 +490,30 @@ static inline int intel_pstate_get_cppc_guaranteed(int cpu)
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
+static int intel_pstate_freq_to_hwp_rel(struct cpudata *cpu, int freq,
+					unsigned int relation)
+{
+	if (freq == cpu->pstate.turbo_freq)
+		return cpu->pstate.turbo_pstate;
+
+	if (freq == cpu->pstate.max_freq)
+		return cpu->pstate.max_pstate;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		return freq / cpu->pstate.scaling;
+	case CPUFREQ_RELATION_C:
+		return DIV_ROUND_CLOSEST(freq, cpu->pstate.scaling);
+	}
+
+	return DIV_ROUND_UP(freq, cpu->pstate.scaling);
+}
+
+static int intel_pstate_freq_to_hwp(struct cpudata *cpu, int freq)
+{
+	return intel_pstate_freq_to_hwp_rel(cpu, freq, CPUFREQ_RELATION_L);
+}
+
 /**
  * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
@@ -507,6 +531,7 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
 	int scaling = cpu->pstate.scaling;
+	int freq;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
@@ -520,16 +545,16 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
 					 perf_ctl_scaling);
 
-	cpu->pstate.max_pstate_physical =
-			DIV_ROUND_UP(perf_ctl_max_phys * perf_ctl_scaling,
-				     scaling);
+	freq = perf_ctl_max_phys * perf_ctl_scaling;
+	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
-	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	cpu->pstate.min_freq = freq;
 	/*
 	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
 	 * the effective range of HWP performance levels.
 	 */
-	cpu->pstate.min_pstate = DIV_ROUND_UP(cpu->pstate.min_freq, scaling);
+	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
 static inline void update_turbo_state(void)
@@ -2332,18 +2357,13 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
 	 * HWP needs some special consideration, because HWP_REQUEST uses
 	 * abstract values to represent performance rather than pure ratios.
 	 */
-	if (hwp_active) {
-		intel_pstate_get_hwp_cap(cpu);
-
-		if (cpu->pstate.scaling != perf_ctl_scaling) {
-			int scaling = cpu->pstate.scaling;
-			int freq;
+	if (hwp_active && cpu->pstate.scaling != perf_ctl_scaling) {
+		int freq;
 
-			freq = max_policy_perf * perf_ctl_scaling;
-			max_policy_perf = DIV_ROUND_UP(freq, scaling);
-			freq = min_policy_perf * perf_ctl_scaling;
-			min_policy_perf = DIV_ROUND_UP(freq, scaling);
-		}
+		freq = max_policy_perf * perf_ctl_scaling;
+		max_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
+		freq = min_policy_perf * perf_ctl_scaling;
+		min_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
 	}
 
 	pr_debug("cpu:%d min_policy_perf:%d max_policy_perf:%d\n",
@@ -2712,18 +2732,7 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 
-	switch (relation) {
-	case CPUFREQ_RELATION_L:
-		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
-		break;
-	case CPUFREQ_RELATION_H:
-		target_pstate = freqs.new / cpu->pstate.scaling;
-		break;
-	default:
-		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
-		break;
-	}
-
+	target_pstate = intel_pstate_freq_to_hwp_rel(cpu, freqs.new, relation);
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
 
 	freqs.new = target_pstate * cpu->pstate.scaling;
@@ -2741,7 +2750,7 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 	update_turbo_state();
 
-	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 70174a9118b1..50120ed94231 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -323,10 +323,16 @@ EXPORT_SYMBOL_GPL(sev_platform_init);
 
 static int __sev_platform_shutdown_locked(int *error)
 {
-	struct sev_device *sev = psp_master->sev_data;
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
 	int ret;
 
-	if (!sev || sev->state == SEV_STATE_UNINIT)
+	if (!psp || !psp->sev_data)
+		return 0;
+
+	sev = psp->sev_data;
+
+	if (sev->state == SEV_STATE_UNINIT)
 		return 0;
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index c8350fcd60fa..dc0c25f0a11a 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -414,8 +414,8 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	return 0;
 
 free_iq:
-	otx2_cpt_free_instruction_queues(lfs);
 	cptlf_hw_cleanup(lfs);
+	otx2_cpt_free_instruction_queues(lfs);
 detach_rsrcs:
 	otx2_cpt_detach_rsrcs_msg(lfs);
 clear_lfs_num:
@@ -425,9 +425,11 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 
 void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs)
 {
-	lfs->lfs_num = 0;
 	/* Cleanup LFs hardware side */
 	cptlf_hw_cleanup(lfs);
+	/* Free instruction queues */
+	otx2_cpt_free_instruction_queues(lfs);
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
+	lfs->lfs_num = 0;
 }
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 3411e664cf50..73de61ebbbcf 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -249,8 +249,11 @@ static void cptvf_lf_shutdown(struct otx2_cptlfs_info *lfs)
 	otx2_cptlf_unregister_interrupts(lfs);
 	/* Cleanup LFs software side */
 	lf_sw_cleanup(lfs);
+	/* Free instruction queues */
+	otx2_cpt_free_instruction_queues(lfs);
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
+	lfs->lfs_num = 0;
 }
 
 static int cptvf_lf_init(struct otx2_cptvf_dev *cptvf)
diff --git a/drivers/crypto/stm32/stm32-crc32.c b/drivers/crypto/stm32/stm32-crc32.c
index 90a920e7f664..c439be1650c8 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -104,7 +104,7 @@ static struct stm32_crc *stm32_crc_get_next_crc(void)
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	crc = list_first_entry_or_null(&crc_list.dev_list, struct stm32_crc, list);
 	if (crc)
 		list_move_tail(&crc->list, &crc_list.dev_list);
 	spin_unlock_bh(&crc_list.lock);
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 29a14b0ffe33..237362316edb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -464,10 +464,14 @@ static void devfreq_monitor(struct work_struct *work)
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
+	if (devfreq->stop_polling)
+		goto out;
+
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
-	mutex_unlock(&devfreq->lock);
 
+out:
+	mutex_unlock(&devfreq->lock);
 	trace_devfreq_monitor(devfreq);
 }
 
@@ -485,6 +489,10 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (delayed_work_pending(&devfreq->work))
+		goto out;
+
 	switch (devfreq->profile->timer) {
 	case DEVFREQ_TIMER_DEFERRABLE:
 		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -493,12 +501,16 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 		break;
 	default:
-		return;
+		goto out;
 	}
 
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+out:
+	devfreq->stop_polling = false;
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -515,6 +527,14 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (devfreq->stop_polling) {
+		mutex_unlock(&devfreq->lock);
+		return;
+	}
+
+	devfreq->stop_polling = true;
+	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
@@ -1653,7 +1673,7 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	ssize_t len;
+	ssize_t len = 0;
 	int i, j;
 	unsigned int max_state;
 
@@ -1662,7 +1682,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->profile->max_state;
 
 	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
+		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1672,33 +1692,54 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				df->profile->freq_table[i]);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
+				 df->profile->freq_table[i]);
+	}
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (df->profile->freq_table[i]
 					== df->previous_freq) {
-			len += sprintf(buf + len, "*");
+			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
 		} else {
-			len += sprintf(buf + len, " ");
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+		}
+		if (len >= PAGE_SIZE - 1)
+			break;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
+				 df->profile->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
+					 df->stats.trans_table[(i * max_state) + j]);
 		}
-		len += sprintf(buf + len, "%10lu:",
-				df->profile->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
-				df->stats.trans_table[(i * max_state) + j]);
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
+				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
+
+	if (len < PAGE_SIZE - 1)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
+				 df->stats.total_trans);
 
-		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	if (len >= PAGE_SIZE - 1) {
+		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
 	}
 
-	len += sprintf(buf + len, "Total transition : %u\n",
-					df->stats.total_trans);
 	return len;
 }
 
diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
new file mode 100644
index 000000000000..628af51c81af
--- /dev/null
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * dma-fence-util: misc functions for dma_fence objects
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ * Authors:
+ *	Christian König <christian.koenig@amd.com>
+ */
+
+#include <linux/dma-fence.h>
+#include <linux/dma-fence-array.h>
+#include <linux/dma-fence-chain.h>
+#include <linux/dma-fence-unwrap.h>
+#include <linux/slab.h>
+
+/* Internal helper to start new array iteration, don't use directly */
+static struct dma_fence *
+__dma_fence_unwrap_array(struct dma_fence_unwrap *cursor)
+{
+	cursor->array = dma_fence_chain_contained(cursor->chain);
+	cursor->index = 0;
+	return dma_fence_array_first(cursor->array);
+}
+
+/**
+ * dma_fence_unwrap_first - return the first fence from fence containers
+ * @head: the entrypoint into the containers
+ * @cursor: current position inside the containers
+ *
+ * Unwraps potential dma_fence_chain/dma_fence_array containers and return the
+ * first fence.
+ */
+struct dma_fence *dma_fence_unwrap_first(struct dma_fence *head,
+					 struct dma_fence_unwrap *cursor)
+{
+	cursor->chain = dma_fence_get(head);
+	return __dma_fence_unwrap_array(cursor);
+}
+EXPORT_SYMBOL_GPL(dma_fence_unwrap_first);
+
+/**
+ * dma_fence_unwrap_next - return the next fence from a fence containers
+ * @cursor: current position inside the containers
+ *
+ * Continue unwrapping the dma_fence_chain/dma_fence_array containers and return
+ * the next fence from them.
+ */
+struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor)
+{
+	struct dma_fence *tmp;
+
+	++cursor->index;
+	tmp = dma_fence_array_next(cursor->array, cursor->index);
+	if (tmp)
+		return tmp;
+
+	cursor->chain = dma_fence_chain_walk(cursor->chain);
+	return __dma_fence_unwrap_array(cursor);
+}
+EXPORT_SYMBOL_GPL(dma_fence_unwrap_next);
+
+/* Implementation for the dma_fence_merge() marco, don't use directly */
+struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
+					   struct dma_fence **fences,
+					   struct dma_fence_unwrap *iter)
+{
+	struct dma_fence_array *result;
+	struct dma_fence *tmp, **array;
+	ktime_t timestamp;
+	unsigned int i;
+	size_t count;
+
+	count = 0;
+	timestamp = ns_to_ktime(0);
+	for (i = 0; i < num_fences; ++i) {
+		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
+			if (!dma_fence_is_signaled(tmp)) {
+				++count;
+			} else {
+				ktime_t t = dma_fence_timestamp(tmp);
+
+				if (ktime_after(t, timestamp))
+					timestamp = t;
+			}
+		}
+	}
+
+	/*
+	 * If we couldn't find a pending fence just return a private signaled
+	 * fence with the timestamp of the last signaled one.
+	 */
+	if (count == 0)
+		return dma_fence_allocate_private_stub(timestamp);
+
+	array = kmalloc_array(count, sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	/*
+	 * This trashes the input fence array and uses it as position for the
+	 * following merge loop. This works because the dma_fence_merge()
+	 * wrapper macro is creating this temporary array on the stack together
+	 * with the iterators.
+	 */
+	for (i = 0; i < num_fences; ++i)
+		fences[i] = dma_fence_unwrap_first(fences[i], &iter[i]);
+
+	count = 0;
+	do {
+		unsigned int sel;
+
+restart:
+		tmp = NULL;
+		for (i = 0; i < num_fences; ++i) {
+			struct dma_fence *next;
+
+			while (fences[i] && dma_fence_is_signaled(fences[i]))
+				fences[i] = dma_fence_unwrap_next(&iter[i]);
+
+			next = fences[i];
+			if (!next)
+				continue;
+
+			/*
+			 * We can't guarantee that inpute fences are ordered by
+			 * context, but it is still quite likely when this
+			 * function is used multiple times. So attempt to order
+			 * the fences by context as we pass over them and merge
+			 * fences with the same context.
+			 */
+			if (!tmp || tmp->context > next->context) {
+				tmp = next;
+				sel = i;
+
+			} else if (tmp->context < next->context) {
+				continue;
+
+			} else if (dma_fence_is_later(tmp, next)) {
+				fences[i] = dma_fence_unwrap_next(&iter[i]);
+				goto restart;
+			} else {
+				fences[sel] = dma_fence_unwrap_next(&iter[sel]);
+				goto restart;
+			}
+		}
+
+		if (tmp) {
+			array[count++] = dma_fence_get(tmp);
+			fences[sel] = dma_fence_unwrap_next(&iter[sel]);
+		}
+	} while (tmp);
+
+	if (count == 0) {
+		tmp = dma_fence_allocate_private_stub(ktime_get());
+		goto return_tmp;
+	}
+
+	if (count == 1) {
+		tmp = array[0];
+		goto return_tmp;
+	}
+
+	result = dma_fence_array_create(count, array,
+					dma_fence_context_alloc(1),
+					1, false);
+	if (!result) {
+		tmp = NULL;
+		goto return_tmp;
+	}
+	return &result->base;
+
+return_tmp:
+	kfree(array);
+	return tmp;
+}
+EXPORT_SYMBOL_GPL(__dma_fence_unwrap_merge);
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 394e6e1e9686..875ae4b3b047 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -384,13 +384,10 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 		sizeof(info->driver_name));
 
 	info->status = dma_fence_get_status(fence);
-	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
-	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
 	info->timestamp_ns =
-		test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags) ?
-		ktime_to_ns(fence->timestamp) :
-		ktime_set(0, 0);
+		dma_fence_is_signaled(fence) ?
+			ktime_to_ns(dma_fence_timestamp(fence)) :
+			ktime_set(0, 0);
 
 	return info->status;
 }
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4ec7bb58c195..9559ebd61f3b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1108,6 +1108,9 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
 static void __dma_async_device_channel_unregister(struct dma_device *device,
 						  struct dma_chan *chan)
 {
+	if (chan->local == NULL)
+		return;
+
 	WARN_ONCE(!device->device_release && chan->client_count,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 8dd40d00a672..6b829d347417 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -38,15 +38,17 @@ static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
 	if (!dpaa2_chan->fd_pool)
 		goto err;
 
-	dpaa2_chan->fl_pool = dma_pool_create("fl_pool", dev,
-					      sizeof(struct dpaa2_fl_entry),
-					      sizeof(struct dpaa2_fl_entry), 0);
+	dpaa2_chan->fl_pool =
+		dma_pool_create("fl_pool", dev,
+				 sizeof(struct dpaa2_fl_entry) * 3,
+				 sizeof(struct dpaa2_fl_entry), 0);
+
 	if (!dpaa2_chan->fl_pool)
 		goto err_fd;
 
 	dpaa2_chan->sdd_pool =
 		dma_pool_create("sdd_pool", dev,
-				sizeof(struct dpaa2_qdma_sd_d),
+				sizeof(struct dpaa2_qdma_sd_d) * 2,
 				sizeof(struct dpaa2_qdma_sd_d), 0);
 	if (!dpaa2_chan->sdd_pool)
 		goto err_fl;
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 045ead46ec8f..69385f32e275 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -514,11 +514,11 @@ static struct fsl_qdma_queue
 			queue_temp = queue_head + i + (j * queue_num);
 
 			queue_temp->cq =
-			dma_alloc_coherent(&pdev->dev,
-					   sizeof(struct fsl_qdma_format) *
-					   queue_size[i],
-					   &queue_temp->bus_addr,
-					   GFP_KERNEL);
+			dmam_alloc_coherent(&pdev->dev,
+					    sizeof(struct fsl_qdma_format) *
+					    queue_size[i],
+					    &queue_temp->bus_addr,
+					    GFP_KERNEL);
 			if (!queue_temp->cq)
 				return NULL;
 			queue_temp->block_base = fsl_qdma->block_base +
@@ -563,11 +563,11 @@ static struct fsl_qdma_queue
 	/*
 	 * Buffer for queue command
 	 */
-	status_head->cq = dma_alloc_coherent(&pdev->dev,
-					     sizeof(struct fsl_qdma_format) *
-					     status_size,
-					     &status_head->bus_addr,
-					     GFP_KERNEL);
+	status_head->cq = dmam_alloc_coherent(&pdev->dev,
+					      sizeof(struct fsl_qdma_format) *
+					      status_size,
+					      &status_head->bus_addr,
+					      GFP_KERNEL);
 	if (!status_head->cq) {
 		devm_kfree(&pdev->dev, status_head);
 		return NULL;
@@ -1272,8 +1272,6 @@ static void fsl_qdma_cleanup_vchan(struct dma_device *dmadev)
 
 static int fsl_qdma_remove(struct platform_device *pdev)
 {
-	int i;
-	struct fsl_qdma_queue *status;
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_qdma_engine *fsl_qdma = platform_get_drvdata(pdev);
 
@@ -1282,11 +1280,6 @@ static int fsl_qdma_remove(struct platform_device *pdev)
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_qdma->dma_dev);
 
-	for (i = 0; i < fsl_qdma->block_number; i++) {
-		status = fsl_qdma->status[i];
-		dma_free_coherent(&pdev->dev, sizeof(struct fsl_qdma_format) *
-				status->n_cq, status->cq, status->bus_addr);
-	}
 	return 0;
 }
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index d796e50dfe99..698fb898847c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3957,6 +3957,7 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 {
 	struct udma_chan *uc = to_udma_chan(&vc->chan);
 	struct udma_desc *d;
+	u8 status;
 
 	if (!vd)
 		return;
@@ -3966,12 +3967,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 	if (d->metadata_size)
 		udma_fetch_epib(uc, d);
 
-	/* Provide residue information for the client */
 	if (result) {
 		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
 
 		if (cppi5_desc_get_type(desc_vaddr) ==
 		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
+			/* Provide residue information for the client */
 			result->residue = d->residue -
 					  cppi5_hdesc_get_pktlen(desc_vaddr);
 			if (result->residue)
@@ -3980,7 +3981,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 				result->result = DMA_TRANS_NOERROR;
 		} else {
 			result->residue = 0;
-			result->result = DMA_TRANS_NOERROR;
+			/* Propagate TR Response errors to the client */
+			status = d->hwdesc[0].tr_resp_base->status;
+			if (status)
+				result->result = DMA_TRANS_ABORTED;
+			else
+				result->result = DMA_TRANS_NOERROR;
 		}
 	}
 }
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index e820c36718ff..8a285293f1c2 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -100,10 +100,9 @@ static int textual_leaf_to_string(const u32 *block, char *buf, size_t size)
  * @buf:	where to put the string
  * @size:	size of @buf, in bytes
  *
- * The string is taken from a minimal ASCII text descriptor leaf after
- * the immediate entry with @key.  The string is zero-terminated.
- * An overlong string is silently truncated such that it and the
- * zero byte fit into @size.
+ * The string is taken from a minimal ASCII text descriptor leaf just after the entry with the
+ * @key. The string is zero-terminated. An overlong string is silently truncated such that it
+ * and the zero byte fit into @size.
  *
  * Returns strlen(buf) or a negative error code.
  */
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b9f5829c0c4d..e52b502b665a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -439,6 +439,7 @@ void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index d1400de17eca..327b8c9348e4 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -43,6 +43,20 @@ static void rx_callback(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
+	/*
+	 * An A2P IRQ is NOT valid when received while the platform still has
+	 * the ownership of the channel, because the platform at first releases
+	 * the SMT channel and then sends the completion interrupt.
+	 *
+	 * This addresses a possible race condition in which a spurious IRQ from
+	 * a previous timed-out reply which arrived late could be wrongly
+	 * associated with the next pending transaction.
+	 */
+	if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
+		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
+		return;
+	}
+
 	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 56a1f61aa3ff..47122b67f2b3 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -99,3 +99,9 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
 		 SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
+
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
+{
+	return (ioread32(&shmem->channel_status) &
+			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
+}
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 865ab2b34fdd..3dfb8b6c6c71 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -318,20 +318,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -343,20 +350,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -370,29 +384,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
@@ -405,29 +424,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 53be0bdf2bc3..27e3fb993804 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1572,6 +1572,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 0.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1d0dbff87d3f..fb66e888ab3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -90,7 +90,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 19e32f38a4c4..5f6c32ec674d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1292,6 +1292,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
@@ -4088,7 +4089,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		amdgpu_fbdev_set_suspend(adev, 1);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
-	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 252712f930f4..5e32906f9819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -579,8 +579,15 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			/* If going to s2idle, no need to wait */
+			if (adev->in_s0ix) {
+				if (!amdgpu_dpm_set_powergating_by_smu(adev,
+						AMD_IP_BLOCK_TYPE_GFX, true))
+					adev->gfx.gfx_off_state = true;
+			} else {
+				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
+			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8a0b652da4f4..5d95594a1753 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1236,19 +1236,15 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address space
- * @new_mem: new information of the bufer object
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also performs
  * bookkeeping.
  * TTM driver callback which is called when ttm moves a buffer.
  */
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-			   bool evict,
-			   struct ttm_resource *new_mem)
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct amdgpu_bo *abo;
-	struct ttm_resource *old_mem = bo->resource;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
 		return;
@@ -1265,13 +1261,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 	/* remember the eviction */
 	if (evict)
 		atomic64_inc(&adev->num_evictions);
-
-	/* update statistics */
-	if (!new_mem)
-		return;
-
-	/* move_notify is called before move happens */
-	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index dc5b889828d9..0969669f1d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -313,9 +313,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags);
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-			   bool evict,
-			   struct ttm_resource *new_mem);
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
 void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 862eb3c1c4c5..494466893486 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -208,7 +208,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 
 	/* Never sync to VM updates either. */
 	if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-	    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+	    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 		return false;
 
 	/* Ignore fences depending on the sync mode */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 51c76d6322c9..b06fb1fa411b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -554,10 +554,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 	}
 
+	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
 out:
 	/* update statistics */
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-	amdgpu_bo_move_notify(bo, evict, new_mem);
+	amdgpu_bo_move_notify(bo, evict);
 	return 0;
 }
 
@@ -1480,7 +1481,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false, NULL);
+	amdgpu_bo_move_notify(bo, false);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2cbe8ea16f24..7f55decc5f37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -347,14 +347,9 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
-	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
-		/* We're not in the eviction worker.
-		 * Signal the fence and synchronize with any
-		 * pending eviction work.
-		 */
+	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
+		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
-		cancel_work_sync(&svm_bo->eviction_work);
-	}
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
@@ -2330,6 +2325,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
+	struct rb_node *rb_node;
 	unsigned long start_limit, end_limit;
 
 	vma = find_vma(p->mm, addr << PAGE_SHIFT);
@@ -2346,16 +2342,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	if (node) {
 		end_limit = min(end_limit, node->start);
 		/* Last range that ends before the fault address */
-		node = container_of(rb_prev(&node->rb),
-				    struct interval_tree_node, rb);
+		rb_node = rb_prev(&node->rb);
 	} else {
 		/* Last range must end before addr because
 		 * there was no range after addr
 		 */
-		node = container_of(rb_last(&p->svms.objects.rb_root),
-				    struct interval_tree_node, rb);
+		rb_node = rb_last(&p->svms.objects.rb_root);
 	}
-	if (node) {
+	if (rb_node) {
+		node = container_of(rb_node, struct interval_tree_node, rb);
 		if (node->last >= addr) {
 			WARN(1, "Overlap with prev node and page fault addr\n");
 			return -EFAULT;
@@ -2872,13 +2867,14 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 {
-	if (!fence)
-		return -EINVAL;
-
-	if (dma_fence_is_signaled(&fence->base))
-		return 0;
-
-	if (fence->svm_bo) {
+	/* Dereferencing fence->svm_bo is safe here because the fence hasn't
+	 * signaled yet and we're under the protection of the fence->lock.
+	 * After the fence is signaled in svm_range_bo_release, we cannot get
+	 * here any more.
+	 *
+	 * Reference is dropped in svm_range_evict_svm_bo_worker.
+	 */
+	if (svm_bo_ref_unless_zero(fence->svm_bo)) {
 		WRITE_ONCE(fence->svm_bo->evicting, 1);
 		schedule_work(&fence->svm_bo->eviction_work);
 	}
@@ -2893,8 +2889,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	struct mm_struct *mm;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
-	if (!svm_bo_ref_unless_zero(svm_bo))
-		return; /* svm_bo was freed while eviction was pending */
 
 	/* svm_range_bo_release destroys this worker thread. So during
 	 * the lifetime of this thread, kfd_process and mm will be valid.
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3919e75fec16..ef151a1bc31c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1680,6 +1680,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 735c92a5aa36..e8d4a8044d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1164,8 +1164,12 @@ struct stream_encoder *dcn30_stream_encoder_create(
 	vpg = dcn30_vpg_create(ctx, vpg_inst);
 	afmt = dcn30_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index dea358b01791..a24f1c215da9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1195,8 +1195,12 @@ struct stream_encoder *dcn301_stream_encoder_create(
 	vpg = dcn301_vpg_create(ctx, vpg_inst);
 	afmt = dcn301_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 2292bb82026e..7f04042d2213 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -542,8 +542,12 @@ static struct stream_encoder *dcn302_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn302_vpg_create(ctx, vpg_inst);
 	afmt = dcn302_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios, eng_id, vpg, afmt, &stream_enc_regs[eng_id],
 			&se_shift, &se_mask);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index e224c5213258..4f7bc8829b20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1291,8 +1291,12 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index f2a55c1413f5..17882f8dfdd3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -200,7 +200,7 @@ static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
 		ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
-	struct phm_ppm_table *ptr = kzalloc(sizeof(ATOM_Tonga_PPM_Table), GFP_KERNEL);
+	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index e941c1132598..eebb2dece768 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -54,13 +54,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 	int ret;
 
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
 		return ret;
 	}
@@ -78,7 +78,7 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
 	buf[1] = val;
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 3d9c0444df40..82960d5d4e73 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -683,22 +683,21 @@ static void drm_fb_helper_damage(struct fb_info *info, u32 x, u32 y,
 /**
  * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
  * @info: fb_info struct pointer
- * @pagelist: list of mmap framebuffer pages that have to be flushed
+ * @pagereflist: list of mmap framebuffer pages that have to be flushed
  *
  * This function is used as the &fb_deferred_io.deferred_io
  * callback function for flushing the fbdev mmap writes.
  */
-void drm_fb_helper_deferred_io(struct fb_info *info,
-			       struct list_head *pagelist)
+void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	unsigned long start, end, min, max;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	u32 y1, y2;
 
 	min = ULONG_MAX;
 	max = 0;
-	list_for_each_entry(page, pagelist, lru) {
-		start = page->index << PAGE_SHIFT;
+	list_for_each_entry(pageref, pagereflist, list) {
+		start = pageref->offset;
 		end = start + PAGE_SIZE - 1;
 		min = min(min, start);
 		max = max(max, end);
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ed25168619fc..5062f13808f2 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -411,7 +411,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 07f5abc875e9..4fd018c8235c 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -570,7 +570,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	struct drm_mode_fb_cmd2 *r = data;
 	struct drm_framebuffer *fb;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index d98b08c65db9..5d30ba3af456 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -346,7 +346,8 @@ static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	mipi_dsi_detach(dsi);
+	if (dsi->attached)
+		mipi_dsi_detach(dsi);
 	mipi_dsi_device_unregister(dsi);
 
 	return 0;
@@ -369,11 +370,18 @@ EXPORT_SYMBOL(mipi_dsi_host_unregister);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+	int ret;
 
 	if (!ops || !ops->attach)
 		return -ENOSYS;
 
-	return ops->attach(dsi->host, dsi);
+	ret = ops->attach(dsi->host, dsi);
+	if (ret)
+		return ret;
+
+	dsi->attached = true;
+
+	return 0;
 }
 EXPORT_SYMBOL(mipi_dsi_attach);
 
@@ -385,9 +393,14 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
+	if (WARN_ON(!dsi->attached))
+		return -EINVAL;
+
 	if (!ops || !ops->detach)
 		return -ENOSYS;
 
+	dsi->attached = false;
+
 	return ops->detach(dsi->host, dsi);
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index fd0bf90fb4c2..ce76d03e2d16 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1378,6 +1378,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 out:
 	if (fb)
 		drm_framebuffer_put(fb);
+	fb = NULL;
 	if (plane->old_fb)
 		drm_framebuffer_put(plane->old_fb);
 	plane->old_fb = NULL;
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index a350310b65d8..57f8570ca3ec 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -825,7 +825,7 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
 	if (max_segment == 0)
 		max_segment = UINT_MAX;
 	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
-						nr_pages << PAGE_SHIFT,
+						(unsigned long)nr_pages << PAGE_SHIFT,
 						max_segment, GFP_KERNEL);
 	if (err) {
 		kfree(sg);
diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index b5001db7a95c..2f6a5995b53f 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -317,9 +317,9 @@ static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
-	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane *plane = &ctx->planes[win];
 	struct exynos_drm_plane_state *state =
-		to_exynos_plane_state(plane.base.state);
+		to_exynos_plane_state(plane->base.state);
 	unsigned int alpha = state->base.alpha;
 	unsigned int pixel_alpha;
 	unsigned long val;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index d8f1cf4d6b69..2a7f96237f95 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -324,6 +324,7 @@ static int exynos_drm_bind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	exynos_drm_cleanup_dma(drm);
 	kfree(private);
+	dev_set_drvdata(dev, NULL);
 err_free_drm:
 	drm_dev_put(drm);
 
@@ -338,6 +339,7 @@ static void exynos_drm_unbind(struct device *dev)
 
 	exynos_drm_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -375,9 +377,18 @@ static int exynos_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void exynos_drm_platform_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (drm)
+		drm_atomic_helper_shutdown(drm);
+}
+
 static struct platform_driver exynos_drm_platform_driver = {
 	.probe	= exynos_drm_platform_probe,
 	.remove	= exynos_drm_platform_remove,
+	.shutdown = exynos_drm_platform_shutdown,
 	.driver	= {
 		.name	= "exynos-drm",
 		.pm	= &exynos_drm_pm_ops,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index c735e53939d8..f25e112a92ed 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -644,9 +644,9 @@ static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 				struct drm_framebuffer *fb, int width)
 {
-	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane *plane = &ctx->planes[win];
 	struct exynos_drm_plane_state *state =
-		to_exynos_plane_state(plane.base.state);
+		to_exynos_plane_state(plane->base.state);
 	uint32_t pixel_format = fb->format->format;
 	unsigned int alpha = state->base.alpha;
 	u32 val = WINCONx_ENWIN;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 166a80262896..8c090354fd8a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1346,7 +1346,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ret = clk_prepare_enable(ctx->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(ctx->clocks[i]);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 03bddd904d1a..3d5e3b77bbbe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -46,6 +46,9 @@
 		(p) ? ((p)->hw_pp ? (p)->hw_pp->idx - PINGPONG_0 : -1) : -1, \
 		##__VA_ARGS__)
 
+#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("enc%d " fmt,\
+		(e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
+
 /*
  * Two to anticipate panels that can do cmd/vid dynamic switching
  * plan is to create all possible physical encoder types, and switch between
@@ -2126,7 +2129,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 		return;
 	}
 
-	DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
+	DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
 
 	event = DPU_ENCODER_FRAME_EVENT_ERROR;
 	trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 323a6bce9e64..170b3e9dd4b0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -52,6 +52,7 @@
 	} while (0)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
+#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
 
 /**
  * ktime_compare_safe - compare two ktime structures
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index d4d31e5bda07..0b4539be0685 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_print.h>
 
+#include "dp_reg.h"
 #include "dp_link.h"
 #include "dp_panel.h"
 
@@ -1064,7 +1065,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 {
-	u32 cc;
+	u32 cc = DP_MISC0_COLORIMERY_CFG_LEGACY_RGB;
 	struct dp_link_private *link;
 
 	if (!dp_link) {
@@ -1078,10 +1079,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 	 * Unless a video pattern CTS test is ongoing, use RGB_VESA
 	 * Only RGB_VESA and RGB_CEA supported for now
 	 */
-	if (dp_link_is_video_pattern_requested(link))
-		cc = link->dp_link.test_video.test_dyn_range;
-	else
-		cc = DP_TEST_DYNAMIC_RANGE_VESA;
+	if (dp_link_is_video_pattern_requested(link)) {
+		if (link->dp_link.test_video.test_dyn_range &
+					DP_TEST_DYNAMIC_RANGE_CEA)
+			cc = DP_MISC0_COLORIMERY_CFG_CEA_RGB;
+	}
 
 	return cc;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 268602803d9a..176a503ece9c 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -129,6 +129,9 @@
 #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
 #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
 
+#define DP_MISC0_COLORIMERY_CFG_LEGACY_RGB	(0)
+#define DP_MISC0_COLORIMERY_CFG_CEA_RGB		(0x04)
+
 #define REG_DP_VALID_BOUNDARY			(0x00000030)
 #define REG_DP_VALID_BOUNDARY_2			(0x00000034)
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 4b5b0a4b051b..6b9a9e56df37 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -752,6 +752,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
diff --git a/drivers/gpu/drm/nouveau/nouveau_vmm.c b/drivers/gpu/drm/nouveau/nouveau_vmm.c
index 67d6619fcd5e..29b5dedf6db8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vmm.c
@@ -108,6 +108,9 @@ nouveau_vma_new(struct nouveau_bo *nvbo, struct nouveau_vmm *vmm,
 	} else {
 		ret = nvif_vmm_get(&vmm->vmm, PTES, false, mem->mem.page, 0,
 				   mem->mem.size, &tmp);
+		if (ret)
+			goto done;
+
 		vma->addr = tmp.addr;
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d9f1675c348e..671bd1d1ad19 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4173,6 +4173,7 @@ static const struct panel_desc tianma_tm070jdhg30 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct panel_desc tianma_tm070jvhg33 = {
@@ -4185,6 +4186,7 @@ static const struct panel_desc tianma_tm070jvhg33 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct display_timing tianma_tm070rvhg71_timing = {
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 67382621b429..e827e8a83c4e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -698,8 +698,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 						typeof(*next), list);
 		if (next)
 			next->s_fence->scheduled.timestamp =
-				job->s_fence->finished.timestamp;
-
+				dma_fence_timestamp(&job->s_fence->finished);
 	} else {
 		job = NULL;
 		/* queue timeout for next job */
diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 2218da3b3ca3..812be02c16ef 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -172,13 +172,13 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct tidss_device *tidss = to_tidss(ddev);
 	unsigned long flags;
 
-	dev_dbg(ddev->dev,
-		"%s: %s enabled %d, needs modeset %d, event %p\n", __func__,
-		crtc->name, drm_atomic_crtc_needs_modeset(crtc->state),
-		crtc->state->enable, crtc->state->event);
+	dev_dbg(ddev->dev, "%s: %s is %sactive, %s modeset, event %p\n",
+		__func__, crtc->name, crtc->state->active ? "" : "not ",
+		drm_atomic_crtc_needs_modeset(crtc->state) ? "needs" : "doesn't need",
+		crtc->state->event);
 
 	/* There is nothing to do if CRTC is not going to be enabled. */
-	if (!crtc->state->enable)
+	if (!crtc->state->active)
 		return;
 
 	/*
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index f18ed03a8b2d..79b08e927f76 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -316,18 +316,18 @@ static int vmw_fb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static void vmw_deferred_io(struct fb_info *info,
-			    struct list_head *pagelist)
+static void vmw_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct vmw_fb_par *par = info->par;
 	unsigned long start, end, min, max;
 	unsigned long flags;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	int y1, y2;
 
 	min = ULONG_MAX;
 	max = 0;
-	list_for_each_entry(page, pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *page = pageref->page;
 		start = page->index << PAGE_SHIFT;
 		end = start + PAGE_SIZE - 1;
 		min = min(min, start);
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index b683c0e8557d..b84ba8e4c79b 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -70,6 +70,28 @@ struct apple_key_translation {
 	u8 flags;
 };
 
+static const struct apple_key_translation apple2021_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_SEARCH,         APPLE_FLAG_FKEY },
+	{ KEY_F5,	KEY_MICMUTE,        APPLE_FLAG_FKEY },
+	{ KEY_F6,	KEY_SLEEP,          APPLE_FLAG_FKEY },
+	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -214,7 +236,9 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
+		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021)
+			table = apple2021_fn_keys;
+		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
@@ -377,6 +401,9 @@ static void apple_setup_input(struct input_dev *input)
 	for (trans = apple_iso_keyboard; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
 
+	for (trans = apple2021_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
 	if (swap_fn_leftctrl) {
 		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
 			set_bit(trans->to, input->keybit);
@@ -640,6 +667,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
 
 	{ }
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 06c53c817a02..7b1fdfde5b40 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -174,6 +174,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL3	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 33c102a60992..8a0d1365cd72 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -432,7 +432,7 @@ static const struct fb_ops picolcdfb_ops = {
 
 
 /* Callback from deferred IO workqueue */
-static void picolcd_fb_deferred_io(struct fb_info *info, struct list_head *pagelist)
+static void picolcd_fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	picolcd_fb_update(info);
 }
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index fbce6e892fc8..80e4247a768b 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -309,6 +309,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021) },
 #endif
 #if IS_ENABLED(CONFIG_HID_APPLEIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 97a27a803f58..6feb812fce37 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -80,6 +80,7 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	if (!ihid_of)
 		return -ENOMEM;
 
+	ihid_of->client = client;
 	ihid_of->ops.power_up = i2c_hid_of_power_up;
 	ihid_of->ops.power_down = i2c_hid_of_power_down;
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 76561f538eda..9270082ea02e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2088,7 +2088,7 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 	return 0;
 }
 
-static int wacom_register_inputs(struct wacom *wacom)
+static int wacom_setup_inputs(struct wacom *wacom)
 {
 	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
@@ -2107,10 +2107,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pen_input_dev);
 		wacom_wac->pen_input = NULL;
 		pen_input_dev = NULL;
-	} else {
-		error = input_register_device(pen_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
@@ -2119,10 +2115,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(touch_input_dev);
 		wacom_wac->touch_input = NULL;
 		touch_input_dev = NULL;
-	} else {
-		error = input_register_device(touch_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
@@ -2131,7 +2123,34 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pad_input_dev);
 		wacom_wac->pad_input = NULL;
 		pad_input_dev = NULL;
-	} else {
+	}
+
+	return 0;
+}
+
+static int wacom_register_inputs(struct wacom *wacom)
+{
+	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	int error = 0;
+
+	pen_input_dev = wacom_wac->pen_input;
+	touch_input_dev = wacom_wac->touch_input;
+	pad_input_dev = wacom_wac->pad_input;
+
+	if (pen_input_dev) {
+		error = input_register_device(pen_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (touch_input_dev) {
+		error = input_register_device(touch_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (pad_input_dev) {
 		error = input_register_device(pad_input_dev);
 		if (error)
 			goto fail;
@@ -2387,6 +2406,20 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
+	error = wacom_setup_inputs(wacom);
+	if (error)
+		goto fail;
+
+	if (features->type == HID_GENERIC)
+		connect_mask |= HID_CONNECT_DRIVER;
+
+	/* Regular HID work starts now */
+	error = hid_hw_start(hdev, connect_mask);
+	if (error) {
+		hid_err(hdev, "hw start failed\n");
+		goto fail;
+	}
+
 	error = wacom_register_inputs(wacom);
 	if (error)
 		goto fail;
@@ -2401,16 +2434,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
-	if (features->type == HID_GENERIC)
-		connect_mask |= HID_CONNECT_DRIVER;
-
-	/* Regular HID work starts now */
-	error = hid_hw_start(hdev, connect_mask);
-	if (error) {
-		hid_err(hdev, "hw start failed\n");
-		goto fail;
-	}
-
 	if (!wireless) {
 		/* Note that if query fails it is not a hard failure */
 		wacom_query_tablet_data(wacom);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6da69b1fde58..115d862d3e91 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2551,7 +2551,14 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
-			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			/*
+			 * xf86-input-wacom does not accept a serial number
+			 * of '0'. Report the low 32 bits if possible, but
+			 * if they are zero, report the upper ones instead.
+			 */
+			__u32 serial_lo = wacom_wac->serial[0] & 0xFFFFFFFFu;
+			__u32 serial_hi = wacom_wac->serial[0] >> 32;
+			input_event(input, EV_MSC, MSC_SERIAL, (int)(serial_lo ? serial_lo : serial_hi));
 			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3cb88d6fbec0..424613e5b14f 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -194,6 +194,8 @@ struct aspeed_pwm_tacho_data {
 	u8 fan_tach_ch_source[16];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
+	/* protects access to shared ASPEED_PTCR_RESULT */
+	struct mutex tach_lock;
 };
 
 enum type { TYPEM, TYPEN, TYPEO };
@@ -528,6 +530,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 	u8 fan_tach_ch_source, type, mode, both;
 	int ret;
 
+	mutex_lock(&priv->tach_lock);
+
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0x1 << fan_tach_ch);
 
@@ -545,6 +549,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 		ASPEED_RPM_STATUS_SLEEP_USEC,
 		usec);
 
+	mutex_unlock(&priv->tach_lock);
+
 	/* return -ETIMEDOUT if we didn't get an answer. */
 	if (ret)
 		return ret;
@@ -904,6 +910,7 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	mutex_init(&priv->tach_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
 			&aspeed_pwm_tacho_regmap_config);
 	if (IS_ERR(priv->regmap))
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5b2057ce5a59..d67d972d18aa 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -380,7 +380,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int attr_no)
+			     int index)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -392,13 +392,20 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		/*
+		 * We map the attr number to core id of the CPU
+		 * The attr number is always core id + 2
+		 * The Pkgtemp will always show up as temp1_*, if available
+		 */
+		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = attr_no;
+		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -456,27 +463,22 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, index;
 
 	/*
-	 * Find attr number for sysfs:
-	 * We map the attr number to core id of the CPU
-	 * The attr number is always core id + 2
-	 * The Pkgtemp will always show up as temp1_*, if available
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
 	 */
 	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
+		index = PKG_SYSFS_ATTR_NO;
 	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
-		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
-	}
 
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
+		pdata->cpu_map[index] = topology_core_id(cpu);
+		index += BASE_SYSFS_ATTR_NO;
 	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -508,20 +510,20 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		}
 	}
 
-	pdata->core_data[attr_no] = tdata;
+	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
 	if (err)
 		goto exit_free;
 
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
+	pdata->core_data[index] = NULL;
 	kfree(tdata);
 ida_free:
 	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 	return err;
 }
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 30b725d11178..87c2c7c84736 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -519,12 +519,13 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
+	/* Set block buffer mode */
+	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
 
-	/* Use 32-byte buffer to process this transaction */
 	if (read_write == I2C_SMBUS_WRITE) {
 		len = data->block[0];
 		outb_p(len, SMBHSTDAT0(priv));
+		inb_p(SMBHSTCNT(priv));	/* reset the data buffer index */
 		for (i = 0; i < len; i++)
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 	}
@@ -540,6 +541,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 			return -EPROTO;
 
 		data->block[0] = len;
+		inb_p(SMBHSTCNT(priv));	/* reset the data buffer index */
 		for (i = 0; i < len; i++)
 			data->block[i + 1] = inb_p(SMBBLKDAT(priv));
 	}
@@ -747,14 +749,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	return i801_check_post(priv, status);
 }
 
-static int i801_set_block_buffer_mode(struct i801_priv *priv)
-{
-	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
-	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0)
-		return -EIO;
-	return 0;
-}
-
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv, union i2c_smbus_data *data,
 				  char read_write, int command)
@@ -783,9 +777,8 @@ static int i801_block_transaction(struct i801_priv *priv, union i2c_smbus_data *
 	/* Experience has shown that the block buffer can only be used for
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
-	if ((priv->features & FEATURE_BLOCK_BUFFER)
-	 && command != I2C_SMBUS_I2C_BLOCK_DATA
-	 && i801_set_block_buffer_mode(priv) == 0)
+	if ((priv->features & FEATURE_BLOCK_BUFFER) &&
+	    command != I2C_SMBUS_I2C_BLOCK_DATA)
 		result = i801_block_transaction_by_block(priv, data,
 							 read_write,
 							 command);
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 4a49c75a9408..b9cfda6ae9ae 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -77,7 +77,8 @@
 #define PRESCL_CTRL0			0x14
 #define PRESCL_CTRL0_I2C(x)		((x) << 16)
 #define PRESCL_CTRL0_I3C(x)		(x)
-#define PRESCL_CTRL0_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I3C_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I2C_MAX		GENMASK(15, 0)
 
 #define PRESCL_CTRL1			0x18
 #define PRESCL_CTRL1_PP_LOW_MASK	GENMASK(15, 8)
@@ -1234,7 +1235,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 
 	pres = DIV_ROUND_UP(sysclk_rate, (bus->scl_rate.i3c * 4)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I3C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
@@ -1247,7 +1248,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	max_i2cfreq = bus->scl_rate.i2c;
 
 	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I2C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index a0e9061f6d6b..c258ea678470 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -128,10 +128,12 @@ config BMA400
 
 config BMA400_I2C
 	tristate
+	select REGMAP_I2C
 	depends on BMA400
 
 config BMA400_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA400
 
 config BMC150_ACCEL
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 811f04448d8d..76002b91c86a 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -28,6 +29,7 @@
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
 #define AD7091R_REG_CONF_AUTO   BIT(8)
 #define AD7091R_REG_CONF_CMD    BIT(10)
 
@@ -49,6 +51,27 @@ struct ad7091r_state {
 	struct mutex lock; /*lock to prevent concurent reads */
 };
 
+const struct iio_event_spec ad7091r_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
+
 static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 {
 	int ret, conf;
@@ -168,8 +191,142 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int ad7091r_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_HIGH_LIMIT;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_LOW_LIMIT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	if (state) {
+		return regmap_set_bits(st->map, AD7091R_REG_CONF,
+				       AD7091R_REG_CONF_ALERT_EN);
+	} else {
+		/*
+		 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to
+		 * prevent alerts and thus disable event generation.
+		 */
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    AD7091R_HIGH_LIMIT);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    AD7091R_LOW_LIMIT);
+		default:
+			return -EINVAL;
+		}
+	}
+}
+
+static int ad7091r_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				  val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val, int val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    val);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		return regmap_write(st->map,
+				    AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				    val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad7091r_info = {
 	.read_raw = ad7091r_read_raw,
+	.read_event_config = &ad7091r_read_event_config,
+	.write_event_config = &ad7091r_write_event_config,
+	.read_event_value = &ad7091r_read_event_value,
+	.write_event_value = &ad7091r_write_event_value,
 };
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
@@ -232,6 +389,11 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
+		if (ret)
+			return ret;
+
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
@@ -243,7 +405,14 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+
 		st->vref = NULL;
+		/* Enable internal vref */
+		ret = regmap_set_bits(st->map, AD7091R_REG_CONF,
+				      AD7091R_REG_CONF_INT_VREF);
+		if (ret)
+			return dev_err_probe(st->dev, ret,
+					     "Error on enable internal reference\n");
 	} else {
 		ret = regulator_enable(st->vref);
 		if (ret)
@@ -260,7 +429,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	return devm_iio_device_register(dev, iio_dev);
 }
-EXPORT_SYMBOL_GPL(ad7091r_probe);
+EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
 static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -290,7 +459,7 @@ const struct regmap_config ad7091r_regmap_config = {
 	.writeable_reg = ad7091r_writeable_reg,
 	.volatile_reg = ad7091r_volatile_reg,
 };
-EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
+EXPORT_SYMBOL_NS_GPL(ad7091r_regmap_config, IIO_AD7091R);
 
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 509748aef9b1..b9e1c8bf3440 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,12 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_CONF_INT_VREF	BIT(0)
+
+/* AD7091R_REG_CH_LIMIT */
+#define AD7091R_HIGH_LIMIT		0xFFF
+#define AD7091R_LOW_LIMIT		0x0
+
 struct device;
 struct ad7091r_state;
 
@@ -17,6 +23,8 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
+extern const struct iio_event_spec ad7091r_events[3];
+
 extern const struct regmap_config ad7091r_regmap_config;
 
 int ad7091r_probe(struct device *dev, const char *name,
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9665679c3ea6..12d475463945 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,26 +12,6 @@
 
 #include "ad7091r-base.h"
 
-static const struct iio_event_spec ad7091r5_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
 #define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
 	.type = IIO_VOLTAGE, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
@@ -44,10 +24,10 @@ static const struct iio_event_spec ad7091r5_events[] = {
 	.scan_type.realbits = bits, \
 }
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
-	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 };
 
 static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
@@ -111,3 +91,4 @@ module_i2c_driver(ad7091r5_driver);
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD7091R);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 78c780d1ab89..d21df1d300d2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1610,10 +1610,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	ret = iio_device_register_sysfs_group(indio_dev,
 					      &iio_dev_opaque->chan_attr_group);
 	if (ret)
-		goto error_clear_attrs;
+		goto error_free_chan_attrs;
 
 	return 0;
 
+error_free_chan_attrs:
+	kfree(iio_dev_opaque->chan_attr_group.attrs);
+	iio_dev_opaque->chan_attr_group.attrs = NULL;
 error_clear_attrs:
 	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
 
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5a1a625d8d16..85097b769c20 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -228,6 +228,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
+		ret = 0;
 		break;
 	default:
 		break;
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 13914273c999..a654c6bae728 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -538,6 +538,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	struct rm3100_data *data;
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -595,9 +596,14 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
 	/* Initializing max wait time, which is double conversion time. */
-	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
-				* 2;
+	data->conversion_time = rm3100_samp_rates[samp_rate_index][2] * 2;
 
 	/* Cycle count values may not be what we want. */
 	if ((tmp - RM3100_TMRC_OFFSET) == 0)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 5b3154503bf4..319d4288eddd 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -531,21 +531,18 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
 			rec.join_state = SENDONLY_FULLMEMBER_JOIN;
 	}
-	spin_unlock_irq(&priv->lock);
 
 	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
-					 &rec, comp_mask, GFP_KERNEL,
+					 &rec, comp_mask, GFP_ATOMIC,
 					 ipoib_mcast_join_complete, mcast);
-	spin_lock_irq(&priv->lock);
 	if (IS_ERR(multicast)) {
 		ret = PTR_ERR(multicast);
 		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
 		/* Requeue this join task with a backoff delay */
 		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
-		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
-		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index caf85ae46293..df04fbba449a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -802,7 +802,6 @@ static int atkbd_probe(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
-	bool skip_getid;
 
 /*
  * Some systems, where the bit-twiddling when testing the io-lines of the
@@ -816,6 +815,11 @@ static int atkbd_probe(struct atkbd *atkbd)
 				 "keyboard reset failed on %s\n",
 				 ps2dev->serio->phys);
 
+	if (atkbd_skip_getid(atkbd)) {
+		atkbd->id = 0xab83;
+		return 0;
+	}
+
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
  * Some keyboards report different values, but the first byte is always 0xab or
@@ -824,18 +828,17 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	skip_getid = atkbd_skip_getid(atkbd);
-	if (skip_getid || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command was skipped or failed, we check if we can at least set
+ * If the get ID command failed, we check if we can at least set
  * the LEDs on the keyboard. This should work on every keyboard out there.
  * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
-		atkbd->id = skip_getid ? 0xab83 : 0xabba;
+		atkbd->id = 0xabba;
 		return 0;
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 6af38f53154b..359d1a287a78 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1171,6 +1171,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
 					SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index fddea7227246..00f78d4176a0 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -2,7 +2,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
@@ -113,6 +113,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 490e6cfe510e..78eeb382c27e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3800,8 +3800,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int from, cpu = cpumask_first(mask_val);
+	struct cpumask common, *table_mask;
 	unsigned long flags;
+	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3817,19 +3818,22 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
 	 */
 	from = vpe_to_cpuid_lock(vpe, &flags);
-	if (from == cpu)
-		goto out;
-
-	vpe->col_idx = cpu;
+	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
 	/*
-	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
-	 * is sharing its VPE table with the current one.
+	 * If we are offered another CPU in the same GICv4.1 ITS
+	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
-	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+	if (table_mask && cpumask_and(&common, mask_val, table_mask))
+		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (from == cpu)
 		goto out;
 
+	vpe->col_idx = cpu;
+
 	its_send_vmovp(vpe);
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
diff --git a/drivers/leds/trigger/ledtrig-panic.c b/drivers/leds/trigger/ledtrig-panic.c
index 64abf2e91608..5a6b21bfeb9a 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -64,10 +64,13 @@ static long led_panic_blink(int state)
 
 static int __init ledtrig_panic_init(void)
 {
+	led_trigger_register_simple("panic", &trigger);
+	if (!trigger)
+		return -ENOMEM;
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &led_trigger_panic_nb);
 
-	led_trigger_register_simple("panic", &trigger);
 	panic_blink = led_panic_blink;
 	return 0;
 }
diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index 3af15083a25a..68f766621b9b 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -552,7 +552,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (i = 0; i < priv->windows; i++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5a7d270b32c0..eff11df6c32e 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -21,6 +21,8 @@
 #include "dm-ima.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 815c41e1ebdb..c1bcc857c1b6 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1859,7 +1859,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 46ec4590f62f..52083d397fc4 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -126,7 +126,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 int dm_table_create(struct dm_table **result, fmode_t mode,
 		    unsigned num_targets, struct mapped_device *md)
 {
-	struct dm_table *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	struct dm_table *t;
+
+	if (num_targets > DM_MAX_TARGETS)
+		return -EOVERFLOW;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 
 	if (!t)
 		return -ENOMEM;
@@ -140,7 +145,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index aae9ec78c0e8..ff65e5eddfa1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1162,6 +1162,7 @@ struct super_type  {
 					  struct md_rdev *refdev,
 					  int minor_version);
 	int		    (*validate_super)(struct mddev *mddev,
+					      struct md_rdev *freshest,
 					      struct md_rdev *rdev);
 	void		    (*sync_super)(struct mddev *mddev,
 					  struct md_rdev *rdev);
@@ -1300,8 +1301,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 
 /*
  * validate_super for 0.90.0
+ * note: we are not using "freshest" for 0.9 superblock
  */
-static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = page_address(rdev->sb_page);
@@ -1816,7 +1818,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	return ret;
 }
 
-static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
@@ -1912,13 +1914,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count) */
-		++ev1;
+		 * spares (which don't need an event count).
+		 * Similar to mdadm, we allow event counter difference of 1
+		 * from the freshest device.
+		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
 		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
 		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
-			if (ev1 < mddev->events)
+			if (ev1 + 1 < mddev->events)
 				return -EINVAL;
 	} else if (mddev->bitmap) {
 		/* If adding to array with a bitmap, then we can accept an
@@ -1939,8 +1943,38 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
 			role = MD_DISK_ROLE_SPARE;
 			rdev->desc_nr = -1;
-		} else
+		} else if (mddev->pers == NULL && freshest && ev1 < mddev->events) {
+			/*
+			 * If we are assembling, and our event counter is smaller than the
+			 * highest event counter, we cannot trust our superblock about the role.
+			 * It could happen that our rdev was marked as Faulty, and all other
+			 * superblocks were updated with +1 event counter.
+			 * Then, before the next superblock update, which typically happens when
+			 * remove_and_add_spares() removes the device from the array, there was
+			 * a crash or reboot.
+			 * If we allow current rdev without consulting the freshest superblock,
+			 * we could cause data corruption.
+			 * Note that in this case our event counter is smaller by 1 than the
+			 * highest, otherwise, this rdev would not be allowed into array;
+			 * both kernel and mdadm allow event counter difference of 1.
+			 */
+			struct mdp_superblock_1 *freshest_sb = page_address(freshest->sb_page);
+			u32 freshest_max_dev = le32_to_cpu(freshest_sb->max_dev);
+
+			if (rdev->desc_nr >= freshest_max_dev) {
+				/* this is unexpected, better not proceed */
+				pr_warn("md: %s: rdev[%pg]: desc_nr(%d) >= freshest(%pg)->sb->max_dev(%u)\n",
+						mdname(mddev), rdev->bdev, rdev->desc_nr,
+						freshest->bdev, freshest_max_dev);
+				return -EUCLEAN;
+			}
+
+			role = le16_to_cpu(freshest_sb->dev_roles[rdev->desc_nr]);
+			pr_debug("md: %s: rdev[%pg]: role=%d(0x%x) according to freshest %pg\n",
+				     mdname(mddev), rdev->bdev, role, role, freshest->bdev);
+		} else {
 			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+		}
 		switch(role) {
 		case MD_DISK_ROLE_SPARE: /* spare */
 			break;
@@ -2890,7 +2924,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 * and should be added immediately.
 		 */
 		super_types[mddev->major_version].
-			validate_super(mddev, rdev);
+			validate_super(mddev, NULL/*freshest*/, rdev);
 		if (add_journal)
 			mddev_suspend(mddev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
@@ -3809,7 +3843,7 @@ static int analyze_sbs(struct mddev *mddev)
 	}
 
 	super_types[mddev->major_version].
-		validate_super(mddev, freshest);
+		validate_super(mddev, NULL/*freshest*/, freshest);
 
 	i = 0;
 	rdev_for_each_safe(rdev, tmp, mddev) {
@@ -3824,7 +3858,7 @@ static int analyze_sbs(struct mddev *mddev)
 		}
 		if (rdev != freshest) {
 			if (super_types[mddev->major_version].
-			    validate_super(mddev, rdev)) {
+			    validate_super(mddev, freshest, rdev)) {
 				pr_warn("md: kicking non-fresh %s from array!\n",
 					bdevname(rdev->bdev,b));
 				md_kick_rdev_from_array(rdev);
@@ -6795,7 +6829,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 			rdev->saved_raid_disk = rdev->raid_disk;
 		} else
 			super_types[mddev->major_version].
-				validate_super(mddev, rdev);
+				validate_super(mddev, NULL/*freshest*/, rdev);
 		if ((info->state & (1<<MD_DISK_SYNC)) &&
 		     rdev->raid_disk != info->raid_disk) {
 			/* This was a hot-add request, but events doesn't
diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 410d6b86feb5..780eb68b1894 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -971,8 +971,8 @@ static int imx335_init_controls(struct imx335 *imx335)
 	imx335->hblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
 						&imx335_ctrl_ops,
 						V4L2_CID_HBLANK,
-						IMX335_REG_MIN,
-						IMX335_REG_MAX,
+						mode->hblank,
+						mode->hblank,
 						1, mode->hblank);
 	if (imx335->hblank_ctrl)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index cb51c81786bd..f49fc5663d22 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1784,10 +1784,6 @@ static int imx355_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
-	if (ret < 0)
-		goto error_media_entity;
-
 	/*
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
@@ -1796,9 +1792,15 @@ static int imx355_probe(struct i2c_client *client)
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
+	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
+	if (ret < 0)
+		goto error_media_entity_runtime_pm;
+
 	return 0;
 
-error_media_entity:
+error_media_entity_runtime_pm:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx355->sd.entity);
 
 error_handler_free:
diff --git a/drivers/media/i2c/ov9734.c b/drivers/media/i2c/ov9734.c
index df538ceb71c3..ae9af9e03284 100644
--- a/drivers/media/i2c/ov9734.c
+++ b/drivers/media/i2c/ov9734.c
@@ -939,6 +939,7 @@ static int ov9734_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	mutex_destroy(&ov9734->mutex);
 
 	return 0;
@@ -986,13 +987,6 @@ static int ov9734_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&ov9734->sd);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to register V4L2 subdev: %d",
-			ret);
-		goto probe_error_media_entity_cleanup;
-	}
-
 	/*
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
@@ -1001,9 +995,18 @@ static int ov9734_probe(struct i2c_client *client)
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
+	ret = v4l2_async_register_subdev_sensor(&ov9734->sd);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to register V4L2 subdev: %d",
+			ret);
+		goto probe_error_media_entity_cleanup_pm;
+	}
+
 	return 0;
 
-probe_error_media_entity_cleanup:
+probe_error_media_entity_cleanup_pm:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&ov9734->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..bb7fb6402d6e 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index bc84274ba87a..ba490b06ff70 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -977,13 +977,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	if (ret < 0)
 		goto dec_end;
 
-	schedule_delayed_work(&jpeg->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
 	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
 		goto dec_end;
 
+	schedule_delayed_work(&jpeg->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index e3246344fb72..bcbbd1408b36 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -187,25 +187,16 @@ static int rga_setup_ctrls(struct rga_ctx *ctx)
 static struct rga_fmt formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_ARGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
+		.color_swap = RGA_COLOR_ALPHA_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
 		.y_div = 1,
 		.x_div = 1,
 	},
-	{
-		.fourcc = V4L2_PIX_FMT_XRGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
-		.hw_format = RGA_COLOR_FMT_XBGR8888,
-		.depth = 32,
-		.uv_factor = 1,
-		.y_div = 1,
-		.x_div = 1,
-	},
 	{
 		.fourcc = V4L2_PIX_FMT_ABGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
@@ -214,7 +205,7 @@ static struct rga_fmt formats[] = {
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_XBGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_XBGR8888,
 		.depth = 32,
 		.uv_factor = 1,
diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 3eff08d7b8e5..713c4539f29c 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -249,7 +249,7 @@ int lirc_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (attr->attach_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
@@ -274,7 +274,7 @@ int lirc_prog_detach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev)) {
 		bpf_prog_put(prog);
 		return PTR_ERR(rcdev);
@@ -299,7 +299,7 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (attr->query.query_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->query.target_fd);
+	rcdev = rc_dev_get_from_fd(attr->query.target_fd, false);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 53ae19fa103a..658d27d29048 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -324,6 +324,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_EXIT), STATE_RESET);
 	if (err) {
 		dev_err(irtoy->dev, "exit sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
@@ -331,6 +332,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_ENTER), STATE_COMMAND);
 	if (err) {
 		dev_err(irtoy->dev, "enter sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 888177b91152..d73f02b0db84 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -827,7 +827,7 @@ void __exit lirc_dev_exit(void)
 	unregister_chrdev_region(lirc_base_dev, RC_DEV_MAX);
 }
 
-struct rc_dev *rc_dev_get_from_fd(int fd)
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 {
 	struct fd f = fdget(fd);
 	struct lirc_fh *fh;
@@ -841,6 +841,9 @@ struct rc_dev *rc_dev_get_from_fd(int fd)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (write && !(f.file->f_mode & FMODE_WRITE))
+		return ERR_PTR(-EPERM);
+
 	fh = f.file->private_data;
 	dev = fh->rc;
 
diff --git a/drivers/media/rc/rc-core-priv.h b/drivers/media/rc/rc-core-priv.h
index 62f032dffd33..dfe0352c0f0a 100644
--- a/drivers/media/rc/rc-core-priv.h
+++ b/drivers/media/rc/rc-core-priv.h
@@ -325,7 +325,7 @@ void lirc_raw_event(struct rc_dev *dev, struct ir_raw_event ev);
 void lirc_scancode_event(struct rc_dev *dev, struct lirc_scancode *lsc);
 int lirc_register(struct rc_dev *dev);
 void lirc_unregister(struct rc_dev *dev);
-struct rc_dev *rc_dev_get_from_fd(int fd);
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write);
 #else
 static inline int lirc_dev_init(void) { return 0; }
 static inline void lirc_dev_exit(void) {}
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 202b084f65a2..4cf540d1b250 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ef550d33af92..1a790e7f6549 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1377,6 +1377,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b121f9081e5e..96c098d6fc22 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1594,7 +1594,7 @@ static int fastrpc_cb_remove(struct platform_device *pdev)
 	int i;
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 1; i < FASTRPC_MAX_SESSIONS; i++) {
+	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
 		if (cctx->session[i].sid == sess->sid) {
 			cctx->session[i].valid = false;
 			cctx->sesscount--;
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index fac4a811b97b..3ab8dbae96af 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -29,7 +29,7 @@ struct lkdtm_list {
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
 #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
-#define REC_STACK_SIZE (THREAD_SIZE / 8)
+#define REC_STACK_SIZE (THREAD_SIZE / 8UL)
 #endif
 #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1fb6b6d99066..c3202e2e99e8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -399,6 +399,10 @@ struct mmc_blk_ioc_data {
 	struct mmc_ioc_cmd ic;
 	unsigned char *buf;
 	u64 buf_bytes;
+	unsigned int flags;
+#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
+#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
+
 	struct mmc_rpmb_data *rpmb;
 };
 
@@ -464,7 +468,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 }
 
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
-			       struct mmc_blk_ioc_data *idata)
+			       struct mmc_blk_ioc_data **idatas, int i)
 {
 	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {};
@@ -472,10 +476,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
+	struct mmc_blk_ioc_data *idata = idatas[i];
+	struct mmc_blk_ioc_data *prev_idata = NULL;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
 
+	if (idata->flags & MMC_BLK_IOC_DROP)
+		return 0;
+
+	if (idata->flags & MMC_BLK_IOC_SBC)
+		prev_idata = idatas[i - 1];
+
 	/*
 	 * The RPMB accesses comes in from the character device, so we
 	 * need to target these explicitly. Else we just target the
@@ -542,7 +554,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || prev_idata) {
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
@@ -550,6 +562,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * 'Reliable Write' bit here.
 		 */
 		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		if (prev_idata)
+			sbc.arg = prev_idata->ic.arg;
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
@@ -561,6 +575,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
+	if (prev_idata) {
+		memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
+		if (sbc.error) {
+			dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
+							__func__, sbc.error);
+			return sbc.error;
+		}
+	}
+
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
@@ -1030,6 +1053,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
+static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
+{
+	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
+	int i;
+
+	for (i = 1; i < mq_rq->ioc_count; i++) {
+		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
+		    mmc_op_multi(idata[i]->ic.opcode)) {
+			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
+			idata[i]->flags |= MMC_BLK_IOC_SBC;
+		}
+	}
+}
+
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
@@ -1057,11 +1094,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 			if (ret)
 				break;
 		}
+
+		mmc_blk_check_sbc(mq_rq);
+
 		fallthrough;
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
 			if (ret)
 				break;
 		}
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 05e907451df9..681653d097ef 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -62,11 +62,15 @@ int mmc_gpio_alloc(struct mmc_host *host)
 int mmc_gpio_get_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int cansleep;
 
 	if (!ctx || !ctx->ro_gpio)
 		return -ENOSYS;
 
-	return gpiod_get_value_cansleep(ctx->ro_gpio);
+	cansleep = gpiod_cansleep(ctx->ro_gpio);
+	return cansleep ?
+		gpiod_get_value_cansleep(ctx->ro_gpio) :
+		gpiod_get_value(ctx->ro_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_ro);
 
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 91fde4943def..05990cebafaa 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bio.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direction.h>
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
 #include <linux/scatterlist.h>
@@ -119,19 +119,14 @@ struct mmc_spi_host {
 	struct spi_transfer	status;
 	struct spi_message	readback;
 
-	/* underlying DMA-aware controller, or null */
-	struct device		*dma_dev;
-
 	/* buffer used for commands and for message "overhead" */
 	struct scratch		*data;
-	dma_addr_t		data_dma;
 
 	/* Specs say to write ones most of the time, even when the card
 	 * has no need to read its input data; and many cards won't care.
 	 * This is our source of those ones.
 	 */
 	void			*ones;
-	dma_addr_t		ones_dma;
 };
 
 
@@ -147,11 +142,8 @@ static inline int mmc_cs_off(struct mmc_spi_host *host)
 	return spi_setup(host->spi);
 }
 
-static int
-mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
+static int mmc_spi_readbytes(struct mmc_spi_host *host, unsigned int len)
 {
-	int status;
-
 	if (len > sizeof(*host->data)) {
 		WARN_ON(1);
 		return -EIO;
@@ -159,19 +151,7 @@ mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
 
 	host->status.len = len;
 
-	if (host->dma_dev)
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_FROM_DEVICE);
-
-	status = spi_sync_locked(host->spi, &host->readback);
-
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_FROM_DEVICE);
-
-	return status;
+	return spi_sync_locked(host->spi, &host->readback);
 }
 
 static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
@@ -506,23 +486,11 @@ mmc_spi_command_send(struct mmc_spi_host *host,
 	t = &host->t;
 	memset(t, 0, sizeof(*t));
 	t->tx_buf = t->rx_buf = data->status;
-	t->tx_dma = t->rx_dma = host->data_dma;
 	t->len = cp - data->status;
 	t->cs_change = 1;
 	spi_message_add_tail(t, &host->m);
 
-	if (host->dma_dev) {
-		host->m.is_dma_mapped = 1;
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
-	}
 	status = spi_sync_locked(host->spi, &host->m);
-
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
 	if (status < 0) {
 		dev_dbg(&host->spi->dev, "  ... write returned %d\n", status);
 		cmd->error = status;
@@ -540,9 +508,6 @@ mmc_spi_command_send(struct mmc_spi_host *host,
  * We always provide TX data for data and CRC.  The MMC/SD protocol
  * requires us to write ones; but Linux defaults to writing zeroes;
  * so we explicitly initialize it to all ones on RX paths.
- *
- * We also handle DMA mapping, so the underlying SPI controller does
- * not need to (re)do it for each message.
  */
 static void
 mmc_spi_setup_data_message(
@@ -552,11 +517,8 @@ mmc_spi_setup_data_message(
 {
 	struct spi_transfer	*t;
 	struct scratch		*scratch = host->data;
-	dma_addr_t		dma = host->data_dma;
 
 	spi_message_init(&host->m);
-	if (dma)
-		host->m.is_dma_mapped = 1;
 
 	/* for reads, readblock() skips 0xff bytes before finding
 	 * the token; for writes, this transfer issues that token.
@@ -570,8 +532,6 @@ mmc_spi_setup_data_message(
 		else
 			scratch->data_token = SPI_TOKEN_SINGLE;
 		t->tx_buf = &scratch->data_token;
-		if (dma)
-			t->tx_dma = dma + offsetof(struct scratch, data_token);
 		spi_message_add_tail(t, &host->m);
 	}
 
@@ -581,7 +541,6 @@ mmc_spi_setup_data_message(
 	t = &host->t;
 	memset(t, 0, sizeof(*t));
 	t->tx_buf = host->ones;
-	t->tx_dma = host->ones_dma;
 	/* length and actual buffer info are written later */
 	spi_message_add_tail(t, &host->m);
 
@@ -591,14 +550,9 @@ mmc_spi_setup_data_message(
 	if (direction == DMA_TO_DEVICE) {
 		/* the actual CRC may get written later */
 		t->tx_buf = &scratch->crc_val;
-		if (dma)
-			t->tx_dma = dma + offsetof(struct scratch, crc_val);
 	} else {
 		t->tx_buf = host->ones;
-		t->tx_dma = host->ones_dma;
 		t->rx_buf = &scratch->crc_val;
-		if (dma)
-			t->rx_dma = dma + offsetof(struct scratch, crc_val);
 	}
 	spi_message_add_tail(t, &host->m);
 
@@ -621,10 +575,7 @@ mmc_spi_setup_data_message(
 		memset(t, 0, sizeof(*t));
 		t->len = (direction == DMA_TO_DEVICE) ? sizeof(scratch->status) : 1;
 		t->tx_buf = host->ones;
-		t->tx_dma = host->ones_dma;
 		t->rx_buf = scratch->status;
-		if (dma)
-			t->rx_dma = dma + offsetof(struct scratch, status);
 		t->cs_change = 1;
 		spi_message_add_tail(t, &host->m);
 	}
@@ -653,23 +604,13 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
 
 	if (host->mmc->use_spi_crc)
 		scratch->crc_val = cpu_to_be16(crc_itu_t(0, t->tx_buf, t->len));
-	if (host->dma_dev)
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
 
 	status = spi_sync_locked(spi, &host->m);
-
 	if (status != 0) {
 		dev_dbg(&spi->dev, "write error (%d)\n", status);
 		return status;
 	}
 
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-
 	/*
 	 * Get the transmission data-response reply.  It must follow
 	 * immediately after the data block we transferred.  This reply
@@ -718,8 +659,6 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	t->tx_buf += t->len;
-	if (host->dma_dev)
-		t->tx_dma += t->len;
 
 	/* Return when not busy.  If we didn't collect that status yet,
 	 * we'll need some more I/O.
@@ -783,30 +722,12 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 	leftover = status << 1;
 
-	if (host->dma_dev) {
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-		dma_sync_single_for_device(host->dma_dev,
-				t->rx_dma, t->len,
-				DMA_FROM_DEVICE);
-	}
-
 	status = spi_sync_locked(spi, &host->m);
 	if (status < 0) {
 		dev_dbg(&spi->dev, "read error %d\n", status);
 		return status;
 	}
 
-	if (host->dma_dev) {
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-		dma_sync_single_for_cpu(host->dma_dev,
-				t->rx_dma, t->len,
-				DMA_FROM_DEVICE);
-	}
-
 	if (bitshift) {
 		/* Walk through the data and the crc and do
 		 * all the magic to get byte-aligned data.
@@ -841,8 +762,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	t->rx_buf += t->len;
-	if (host->dma_dev)
-		t->rx_dma += t->len;
 
 	return 0;
 }
@@ -857,7 +776,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		struct mmc_data *data, u32 blk_size)
 {
 	struct spi_device	*spi = host->spi;
-	struct device		*dma_dev = host->dma_dev;
 	struct spi_transfer	*t;
 	enum dma_data_direction	direction;
 	struct scatterlist	*sg;
@@ -884,31 +802,8 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	 */
 	for_each_sg(data->sg, sg, data->sg_len, n_sg) {
 		int			status = 0;
-		dma_addr_t		dma_addr = 0;
 		void			*kmap_addr;
 		unsigned		length = sg->length;
-		enum dma_data_direction	dir = direction;
-
-		/* set up dma mapping for controller drivers that might
-		 * use DMA ... though they may fall back to PIO
-		 */
-		if (dma_dev) {
-			/* never invalidate whole *shared* pages ... */
-			if ((sg->offset != 0 || length != PAGE_SIZE)
-					&& dir == DMA_FROM_DEVICE)
-				dir = DMA_BIDIRECTIONAL;
-
-			dma_addr = dma_map_page(dma_dev, sg_page(sg), 0,
-						PAGE_SIZE, dir);
-			if (dma_mapping_error(dma_dev, dma_addr)) {
-				data->error = -EFAULT;
-				break;
-			}
-			if (direction == DMA_TO_DEVICE)
-				t->tx_dma = dma_addr + sg->offset;
-			else
-				t->rx_dma = dma_addr + sg->offset;
-		}
 
 		/* allow pio too; we don't allow highmem */
 		kmap_addr = kmap(sg_page(sg));
@@ -943,8 +838,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		if (direction == DMA_FROM_DEVICE)
 			flush_dcache_page(sg_page(sg));
 		kunmap(sg_page(sg));
-		if (dma_dev)
-			dma_unmap_page(dma_dev, dma_addr, PAGE_SIZE, dir);
 
 		if (status < 0) {
 			data->error = status;
@@ -981,21 +874,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
 
 		host->early_status.tx_buf = host->early_status.rx_buf;
-		host->early_status.tx_dma = host->early_status.rx_dma;
 		host->early_status.len = statlen;
 
-		if (host->dma_dev)
-			dma_sync_single_for_device(host->dma_dev,
-					host->data_dma, sizeof(*scratch),
-					DMA_BIDIRECTIONAL);
-
 		tmp = spi_sync_locked(spi, &host->m);
-
-		if (host->dma_dev)
-			dma_sync_single_for_cpu(host->dma_dev,
-					host->data_dma, sizeof(*scratch),
-					DMA_BIDIRECTIONAL);
-
 		if (tmp < 0) {
 			if (!data->error)
 				data->error = tmp;
@@ -1269,52 +1150,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_HAS_DMA
-static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
-{
-	struct spi_device *spi = host->spi;
-	struct device *dev;
-
-	if (!spi->master->dev.parent->dma_mask)
-		return 0;
-
-	dev = spi->master->dev.parent;
-
-	host->ones_dma = dma_map_single(dev, host->ones, MMC_SPI_BLOCKSIZE,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, host->ones_dma))
-		return -ENOMEM;
-
-	host->data_dma = dma_map_single(dev, host->data, sizeof(*host->data),
-					DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, host->data_dma)) {
-		dma_unmap_single(dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
-				 DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	dma_sync_single_for_cpu(dev, host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
-
-	host->dma_dev = dev;
-	return 0;
-}
-
-static void mmc_spi_dma_free(struct mmc_spi_host *host)
-{
-	if (!host->dma_dev)
-		return;
-
-	dma_unmap_single(host->dma_dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
-			 DMA_TO_DEVICE);
-	dma_unmap_single(host->dma_dev, host->data_dma,	sizeof(*host->data),
-			 DMA_BIDIRECTIONAL);
-}
-#else
-static inline int mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
-static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
-#endif
-
 static int mmc_spi_probe(struct spi_device *spi)
 {
 	void			*ones;
@@ -1406,24 +1241,17 @@ static int mmc_spi_probe(struct spi_device *spi)
 			host->powerup_msecs = 250;
 	}
 
-	/* preallocate dma buffers */
+	/* Preallocate buffers */
 	host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
 	if (!host->data)
 		goto fail_nobuf1;
 
-	status = mmc_spi_dma_alloc(host);
-	if (status)
-		goto fail_dma;
-
 	/* setup message for status/busy readback */
 	spi_message_init(&host->readback);
-	host->readback.is_dma_mapped = (host->dma_dev != NULL);
 
 	spi_message_add_tail(&host->status, &host->readback);
 	host->status.tx_buf = host->ones;
-	host->status.tx_dma = host->ones_dma;
 	host->status.rx_buf = &host->data->status;
-	host->status.rx_dma = host->data_dma + offsetof(struct scratch, status);
 	host->status.cs_change = 1;
 
 	/* register card detect irq */
@@ -1468,9 +1296,8 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (!status)
 		has_ro = true;
 
-	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
+	dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
 			dev_name(&mmc->class_dev),
-			host->dma_dev ? "" : ", no DMA",
 			has_ro ? "" : ", no WP",
 			(host->pdata && host->pdata->setpower)
 				? "" : ", no poweroff",
@@ -1481,8 +1308,6 @@ static int mmc_spi_probe(struct spi_device *spi)
 fail_gpiod_request:
 	mmc_remove_host(mmc);
 fail_glue_init:
-	mmc_spi_dma_free(host);
-fail_dma:
 	kfree(host->data);
 fail_nobuf1:
 	mmc_spi_put_pdata(spi);
@@ -1504,7 +1329,6 @@ static int mmc_spi_remove(struct spi_device *spi)
 
 	mmc_remove_host(mmc);
 
-	mmc_spi_dma_free(host);
 	kfree(host->data);
 	kfree(host->ones);
 
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b29393831a30..7091b018078b 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -973,7 +973,8 @@ static int alb_upper_dev_walk(struct net_device *upper,
 	if (netif_is_macvlan(upper) && !strict_match) {
 		tags = bond_verify_device_path(bond->dev, upper, 0);
 		if (IS_ERR_OR_NULL(tags))
-			BUG();
+			return -ENOMEM;
+
 		alb_send_lp_vid(slave, upper->dev_addr,
 				tags[0].vlan_proto, tags[0].vlan_id);
 		kfree(tags);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 8271b8aa7b71..6b7307edaf17 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -578,8 +578,8 @@ struct mv88e6xxx_ops {
 	int (*serdes_get_sset_count)(struct mv88e6xxx_chip *chip, int port);
 	int (*serdes_get_strings)(struct mv88e6xxx_chip *chip,  int port,
 				  uint8_t *data);
-	int (*serdes_get_stats)(struct mv88e6xxx_chip *chip,  int port,
-				uint64_t *data);
+	size_t (*serdes_get_stats)(struct mv88e6xxx_chip *chip, int port,
+				   uint64_t *data);
 
 	/* SERDES registers for ethtool */
 	int (*serdes_get_regs_len)(struct mv88e6xxx_chip *chip,  int port);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 6ae7a0ed9e0b..e0e1a1b07886 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -338,8 +338,8 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	return val;
 }
 
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
@@ -787,8 +787,8 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	return reg[0] | ((u64)reg[1] << 16) | ((u64)reg[2] << 32);
 }
 
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6390_serdes_hw_stat *stat;
 	int lane;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 8dd8ed225b45..02966e520dd6 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -163,13 +163,13 @@ irqreturn_t mv88e6393x_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
 int mv88e6352_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 int mv88e6390_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 
 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 631639a19bad..3888561a5cc8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11925,6 +11925,11 @@ static int bnxt_fw_init_one_p1(struct bnxt *bp)
 
 	bp->fw_cap = 0;
 	rc = bnxt_hwrm_ver_get(bp);
+	/* FW may be unresponsive after FLR. FLR must complete within 100 msec
+	 * so wait before continuing with recovery.
+	 */
+	if (rc)
+		msleep(100);
 	bnxt_try_map_fw_health_reg(bp);
 	if (rc) {
 		rc = bnxt_try_recover_fw(bp);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1c3f7efce8a7..a2b736a9d20c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1248,7 +1248,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1268,7 +1269,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (enable)
+	if (tx_lpi_enabled)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1289,6 +1290,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	priv->eee.eee_enabled = enable;
 	priv->eee.eee_active = enable;
+	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
@@ -1304,6 +1306,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 
 	e->eee_enabled = p->eee_enabled;
 	e->eee_active = p->eee_active;
+	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1313,7 +1316,6 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_eee *p = &priv->eee;
-	int ret = 0;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1324,16 +1326,11 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	p->eee_enabled = e->eee_enabled;
 
 	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false);
+		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		ret = phy_init_eee(dev->phydev, 0);
-		if (ret) {
-			netif_err(priv, hw, dev, "EEE initialization failed\n");
-			return ret;
-		}
-
+		p->eee_active = phy_init_eee(dev->phydev, false) >= 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, true);
+		bcmgenet_eee_enable_set(dev, p->eee_active, e->tx_lpi_enabled);
 	}
 
 	return phy_ethtool_set_eee(dev->phydev, e);
@@ -4219,9 +4216,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	if (priv->eee.eee_enabled)
-		bcmgenet_eee_enable_set(dev, true);
-
 	bcmgenet_netif_start(dev);
 
 	netif_device_attach(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 0a6d91b0f0aa..0eeb304a4263 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -701,4 +701,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			       enum bcmgenet_power_mode mode);
 
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled);
+
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index bfe90cacbd07..51f6c94e919e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -25,6 +25,7 @@
 
 #include "bcmgenet.h"
 
+
 /* setup netdev link state when PHY link status change and
  * update UMAC and RGMII block when link up
  */
@@ -102,6 +103,11 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			reg |= CMD_TX_EN | CMD_RX_EN;
 		}
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+		bcmgenet_eee_enable_set(dev,
+					priv->eee.eee_enabled && priv->eee.eee_active,
+					priv->eee.tx_lpi_enabled);
 	} else {
 		/* done if nothing has changed */
 		if (!status_changed)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 717d4bc5bac6..39875ccbaa0f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1813,6 +1813,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
@@ -1822,6 +1823,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 	} else {
 		if (fep->link) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index ec394d991668..94e3b74a10f2 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -350,6 +350,7 @@ static void gve_tx_fill_pkt_desc_dqo(struct gve_tx_ring *tx, u32 *desc_idx,
 /* Validates and prepares `skb` for TSO.
  *
  * Returns header length, or < 0 if invalid.
+ * Warning : Might change skb->head (and thus skb_shinfo).
  */
 static int gve_prep_tso(struct sk_buff *skb)
 {
@@ -451,8 +452,8 @@ gve_tx_fill_general_ctx_desc(struct gve_tx_general_context_desc_dqo *desc,
 static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 				      struct sk_buff *skb)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	const bool is_gso = skb_is_gso(skb);
+	struct skb_shared_info *shinfo;
 	u32 desc_idx = tx->dqo_tx.tail;
 
 	struct gve_tx_pending_packet_dqo *pkt;
@@ -477,6 +478,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 		desc_idx = (desc_idx + 1) & tx->mask;
 	}
 
+	/* Must get after gve_prep_tso(), which can change shinfo. */
+	shinfo = skb_shinfo(skb);
 	gve_tx_fill_general_ctx_desc(&tx->dqo.tx_ring[desc_idx].general_ctx,
 				     &metadata);
 	desc_idx = (desc_idx + 1) & tx->mask;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 10737418565f..3d2b92a952a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5323,7 +5323,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4d23ff936ce4..9ff8bf346b9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2603,6 +2603,14 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	int aq_ret = 0;
 	int i;
 
+	if (vf->is_disabled_from_host) {
+		aq_ret = -EPERM;
+		dev_info(&pf->pdev->dev,
+			 "Admin has disabled VF %d, will not enable queues\n",
+			 vf->vf_id);
+		goto error_param;
+	}
+
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -4630,9 +4638,12 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	struct i40e_link_status *ls = &pf->hw.phy.link_info;
 	struct virtchnl_pf_event pfe;
 	struct i40e_hw *hw = &pf->hw;
+	struct i40e_vsi *vsi;
+	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
 	int ret = 0;
+	int tmp;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4655,17 +4666,38 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	switch (link) {
 	case IFLA_VF_LINK_STATE_AUTO:
 		vf->link_forced = false;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		i40e_set_vf_link_state(vf, &pfe, ls);
 		break;
 	case IFLA_VF_LINK_STATE_ENABLE:
 		vf->link_forced = true;
 		vf->link_up = true;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		i40e_set_vf_link_state(vf, &pfe, ls);
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
 		vf->link_up = false;
 		i40e_set_vf_link_state(vf, &pfe, ls);
+
+		vsi = pf->vsi[vf->lan_vsi_idx];
+		q_map = BIT(vsi->num_queue_pairs) - 1;
+
+		vf->is_disabled_from_host = true;
+
+		/* Try to stop both Tx&Rx rings even if one of the calls fails
+		 * to ensure we stop the rings even in case of errors.
+		 * If any of them returns with an error then the first
+		 * error that occurred will be returned.
+		 */
+		tmp = i40e_ctrl_vf_tx_rings(vsi, q_map, false);
+		ret = i40e_ctrl_vf_rx_rings(vsi, q_map, false);
+
+		ret = tmp ? tmp : ret;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index bd497cc5303a..97e9c34d7c6c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -98,6 +98,7 @@ struct i40e_vf {
 	bool link_forced;
 	bool link_up;		/* only valid if VF link is forced */
 	bool spoofchk;
+	bool is_disabled_from_host; /* PF ctrl of VF enable/disable */
 	u16 num_vlan;
 
 	/* ADq related variables */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 95c92fe890a1..ed35e06537a0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -123,14 +123,14 @@ static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
 		if (ret_val)
 			return ret_val;
 		if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 
 		/* Check to see if SFP+ module is supported */
 		ret_val = ixgbe_get_sfp_init_sequence_offsets(hw,
 							    &list_offset,
 							    &data_offset);
 		if (ret_val)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		break;
 	default:
 		break;
@@ -213,7 +213,7 @@ static s32 ixgbe_get_link_capabilities_82598(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -283,7 +283,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -292,7 +292,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -369,7 +369,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -438,7 +438,7 @@ static s32 ixgbe_start_mac_link_82598(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autonegotiation did not complete.\n");
 			}
 		}
@@ -478,7 +478,7 @@ static s32 ixgbe_validate_link_ready(struct ixgbe_hw *hw)
 
 	if (timeout == IXGBE_VALIDATE_LINK_READY_TIMEOUT) {
 		hw_dbg(hw, "Link was indicated but link is down\n");
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -594,7 +594,7 @@ static s32 ixgbe_setup_mac_link_82598(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Set KX4/KX support according to speed requested */
 	else if (link_mode == IXGBE_AUTOC_LMS_KX4_AN ||
@@ -701,9 +701,9 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 
 		/* Init PHY and function pointers, perform SFP setup */
 		phy_status = hw->phy.ops.init(hw);
-		if (phy_status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+		if (phy_status == -EOPNOTSUPP)
 			return phy_status;
-		if (phy_status == IXGBE_ERR_SFP_NOT_PRESENT)
+		if (phy_status == -ENOENT)
 			goto mac_reset_top;
 
 		hw->phy.ops.reset(hw);
@@ -727,7 +727,7 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 		udelay(1);
 	}
 	if (ctrl & IXGBE_CTRL_RST) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -789,7 +789,7 @@ static s32 ixgbe_set_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -814,7 +814,7 @@ static s32 ixgbe_clear_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -845,7 +845,7 @@ static s32 ixgbe_set_vfta_82598(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	u32 vftabyte;
 
 	if (vlan > 4095)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Determine 32-bit word position in array */
 	regindex = (vlan >> 5) & 0x7F;   /* upper seven bits */
@@ -964,7 +964,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 		gssr = IXGBE_GSSR_PHY0_SM;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	if (hw->phy.type == ixgbe_phy_nl) {
 		/*
@@ -993,7 +993,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		if (sfp_stat != IXGBE_I2C_EEPROM_STATUS_PASS) {
 			hw_dbg(hw, "EEPROM read did not pass.\n");
-			status = IXGBE_ERR_SFP_NOT_PRESENT;
+			status = -ENOENT;
 			goto out;
 		}
 
@@ -1003,7 +1003,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		*eeprom_data = (u8)(sfp_data >> 8);
 	} else {
-		status = IXGBE_ERR_PHY;
+		status = -EIO;
 	}
 
 out:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 58ea959a4482..339e106a5732 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -117,7 +117,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 							IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		if (hw->eeprom.ops.read(hw, ++data_offset, &data_value))
 			goto setup_sfp_err;
@@ -144,7 +144,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 
 		if (ret_val) {
 			hw_dbg(hw, " sfp module setup not complete\n");
-			return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+			return -EIO;
 		}
 	}
 
@@ -159,7 +159,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 	usleep_range(hw->eeprom.semaphore_delay * 1000,
 		     hw->eeprom.semaphore_delay * 2000);
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+	return -EIO;
 }
 
 /**
@@ -184,7 +184,7 @@ static s32 prot_autoc_read_82599(struct ixgbe_hw *hw, bool *locked,
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		*locked = true;
 	}
@@ -219,7 +219,7 @@ static s32 prot_autoc_write_82599(struct ixgbe_hw *hw, u32 autoc, bool locked)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		locked = true;
 	}
@@ -400,7 +400,7 @@ static s32 ixgbe_get_link_capabilities_82599(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	if (hw->phy.multispeed_fiber) {
@@ -541,7 +541,7 @@ static s32 ixgbe_start_mac_link_82599(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autoneg did not complete.\n");
 			}
 		}
@@ -794,7 +794,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Use stored value (EEPROM defaults) of AUTOC to find KR/KX4 support*/
 	if (hw->mac.orig_link_settings_stored)
@@ -861,8 +861,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 					msleep(100);
 				}
 				if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-					status =
-						IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+					status = -EIO;
 					hw_dbg(hw, "Autoneg did not complete.\n");
 				}
 			}
@@ -927,7 +926,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	/* Identify PHY and related function pointers */
 	status = hw->phy.ops.init(hw);
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Setup SFP module if there is one present. */
@@ -936,7 +935,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -974,7 +973,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -1093,7 +1092,7 @@ static s32 ixgbe_fdir_check_cmd_complete(struct ixgbe_hw *hw, u32 *fdircmd)
 		udelay(10);
 	}
 
-	return IXGBE_ERR_FDIR_CMD_INCOMPLETE;
+	return -EIO;
 }
 
 /**
@@ -1155,7 +1154,7 @@ s32 ixgbe_reinit_fdir_tables_82599(struct ixgbe_hw *hw)
 	}
 	if (i >= IXGBE_FDIR_INIT_DONE_POLL) {
 		hw_dbg(hw, "Flow Director Signature poll time exceeded!\n");
-		return IXGBE_ERR_FDIR_REINIT_FAILED;
+		return -EIO;
 	}
 
 	/* Clear FDIR statistics registers (read to clear) */
@@ -1387,7 +1386,7 @@ s32 ixgbe_fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type input\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* configure FDIRCMD register */
@@ -1546,7 +1545,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on vm pool mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (input_mask->formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) {
@@ -1555,14 +1554,14 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		if (input_mask->formatted.dst_port ||
 		    input_mask->formatted.src_port) {
 			hw_dbg(hw, " Error on src/dst port mask\n");
-			return IXGBE_ERR_CONFIG;
+			return -EIO;
 		}
 		break;
 	case IXGBE_ATR_L4TYPE_MASK:
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (ntohs(input_mask->formatted.vlan_id) & 0xEFFF) {
@@ -1583,7 +1582,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on VLAN mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
@@ -1595,7 +1594,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flexible byte mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
@@ -1824,7 +1823,7 @@ static s32 ixgbe_identify_phy_82599(struct ixgbe_hw *hw)
 
 	/* Return error if SFP module has been detected but is not supported */
 	if (hw->phy.type == ixgbe_phy_sfp_unsupported)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	return status;
 }
@@ -1863,13 +1862,13 @@ static s32 ixgbe_enable_rx_dma_82599(struct ixgbe_hw *hw, u32 regval)
  *  Verifies that installed the firmware version is 0.6 or higher
  *  for SFI devices. All 82599 SFI devices should have version 0.6 or higher.
  *
- *  Returns IXGBE_ERR_EEPROM_VERSION if the FW is not present or
- *  if the FW version is not supported.
+ *  Return: -EACCES if the FW is not present or if the FW version is
+ *  not supported.
  **/
 static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_EEPROM_VERSION;
 	u16 fw_offset, fw_ptp_cfg_offset;
+	s32 status = -EACCES;
 	u16 offset;
 	u16 fw_version = 0;
 
@@ -1883,7 +1882,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_offset == 0 || fw_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the offset to the Pass Through Patch Configuration block */
 	offset = fw_offset + IXGBE_FW_PASSTHROUGH_PATCH_CONFIG_PTR;
@@ -1891,7 +1890,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_ptp_cfg_offset == 0 || fw_ptp_cfg_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the firmware version */
 	offset = fw_ptp_cfg_offset + IXGBE_FW_PATCH_VERSION_4;
@@ -1905,7 +1904,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 
 fw_version_err:
 	hw_err(hw, "eeprom read at offset %d failed\n", offset);
-	return IXGBE_ERR_EEPROM_VERSION;
+	return -EACCES;
 }
 
 /**
@@ -2038,7 +2037,7 @@ static s32 ixgbe_reset_pipeline_82599(struct ixgbe_hw *hw)
 
 	if (!(anlp1_reg & IXGBE_ANLP1_AN_STATE_MASK)) {
 		hw_dbg(hw, "auto negotiation not completed\n");
-		ret_val = IXGBE_ERR_RESET_FAILED;
+		ret_val = -EIO;
 		goto reset_pipeline_out;
 	}
 
@@ -2087,7 +2086,7 @@ static s32 ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
@@ -2141,7 +2140,7 @@ static s32 ixgbe_write_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index e90b5047e695..033630d3c26e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -30,7 +30,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 					     u16 words, u16 *data);
 static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
 						 u16 offset);
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw);
 
 /* Base table for registers values that change by MAC */
 const u32 ixgbe_mvals_8259X[IXGBE_MVALS_IDX_LIMIT] = {
@@ -124,7 +124,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 	 */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_dbg(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/*
@@ -215,7 +215,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	if (hw->mac.type != ixgbe_mac_X540) {
@@ -500,7 +500,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (pba_num == NULL) {
 		hw_dbg(hw, "PBA string buffer was null\n");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	ret_val = hw->eeprom.ops.read(hw, IXGBE_PBANUM0_PTR, &data);
@@ -526,7 +526,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 		/* we will need 11 characters to store the PBA */
 		if (pba_num_size < 11) {
 			hw_dbg(hw, "PBA string buffer too small\n");
-			return IXGBE_ERR_NO_SPACE;
+			return -ENOSPC;
 		}
 
 		/* extract hex string from data and pba_ptr */
@@ -563,13 +563,13 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (length == 0xFFFF || length == 0) {
 		hw_dbg(hw, "NVM PBA number section invalid length\n");
-		return IXGBE_ERR_PBA_SECTION;
+		return -EIO;
 	}
 
 	/* check if pba_num buffer is big enough */
 	if (pba_num_size  < (((u32)length * 2) - 1)) {
 		hw_dbg(hw, "PBA string buffer too small\n");
-		return IXGBE_ERR_NO_SPACE;
+		return -ENOSPC;
 	}
 
 	/* trim pba length from start of string */
@@ -746,10 +746,10 @@ s32 ixgbe_stop_adapter_generic(struct ixgbe_hw *hw)
 	usleep_range(1000, 2000);
 
 	/*
-	 * Prevent the PCI-E bus from from hanging by disabling PCI-E master
+	 * Prevent the PCI-E bus from hanging by disabling PCI-E primary
 	 * access and verify no pending requests
 	 */
-	return ixgbe_disable_pcie_master(hw);
+	return ixgbe_disable_pcie_primary(hw);
 }
 
 /**
@@ -805,7 +805,7 @@ s32 ixgbe_led_on_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -826,7 +826,7 @@ s32 ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn off the LED, set mode to OFF. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -904,11 +904,8 @@ s32 ixgbe_write_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * The EEPROM page size cannot be queried from the chip. We do lazy
@@ -962,7 +959,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1028,7 +1025,7 @@ s32 ixgbe_write_eeprom_generic(struct ixgbe_hw *hw, u16 offset, u16 data)
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_write_eeprom_buffer_bit_bang(hw, offset, 1, &data);
 }
@@ -1050,11 +1047,8 @@ s32 ixgbe_read_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * We cannot hold synchronization semaphores for too long
@@ -1099,7 +1093,7 @@ static s32 ixgbe_read_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1142,7 +1136,7 @@ s32 ixgbe_read_eeprom_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_read_eeprom_buffer_bit_bang(hw, offset, 1, data);
 }
@@ -1165,11 +1159,8 @@ s32 ixgbe_read_eerd_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eerd = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1262,11 +1253,8 @@ s32 ixgbe_write_eewr_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eewr = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1328,7 +1316,7 @@ static s32 ixgbe_poll_eerd_eewr_done(struct ixgbe_hw *hw, u32 ee_reg)
 		}
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -1344,7 +1332,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 	u32 i;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	eec = IXGBE_READ_REG(hw, IXGBE_EEC(hw));
 
@@ -1366,7 +1354,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Could not acquire EEPROM grant\n");
 
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Setup EEPROM for Read/Write */
@@ -1419,7 +1407,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 		swsm = IXGBE_READ_REG(hw, IXGBE_SWSM(hw));
 		if (swsm & IXGBE_SWSM_SMBI) {
 			hw_dbg(hw, "Software semaphore SMBI between device drivers not granted.\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 	}
 
@@ -1447,7 +1435,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 	if (i >= timeout) {
 		hw_dbg(hw, "SWESMBI Software EEPROM semaphore not granted.\n");
 		ixgbe_release_eeprom_semaphore(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1503,7 +1491,7 @@ static s32 ixgbe_ready_eeprom(struct ixgbe_hw *hw)
 	 */
 	if (i >= IXGBE_EEPROM_MAX_RETRY_SPI) {
 		hw_dbg(hw, "SPI EEPROM Status error\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1715,7 +1703,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 	for (i = IXGBE_PCIE_ANALOG_PTR; i < IXGBE_FW_PTR; i++) {
 		if (hw->eeprom.ops.read(hw, i, &pointer)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		/* If the pointer seems invalid */
@@ -1724,7 +1712,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 
 		if (hw->eeprom.ops.read(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		if (length == 0xFFFF || length == 0)
@@ -1733,7 +1721,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (hw->eeprom.ops.read(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -1786,7 +1774,7 @@ s32 ixgbe_validate_eeprom_checksum_generic(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum)
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 
 	/* If the user cares, return the calculated checksum */
 	if (checksum_val)
@@ -1845,7 +1833,7 @@ s32 ixgbe_set_rar_generic(struct ixgbe_hw *hw, u32 index, u8 *addr, u32 vmdq,
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/* setup VMDq pool selection before this RAR gets enabled */
@@ -1897,7 +1885,7 @@ s32 ixgbe_clear_rar_generic(struct ixgbe_hw *hw, u32 index)
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/*
@@ -2146,7 +2134,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration. */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -2155,7 +2143,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -2212,7 +2200,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -2269,7 +2257,7 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm)
 {
 	if ((!(adv_reg)) ||  (!(lp_reg)))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EINVAL;
 
 	if ((adv_reg & adv_sym) && (lp_reg & lp_sym)) {
 		/*
@@ -2321,7 +2309,7 @@ static s32 ixgbe_fc_autoneg_fiber(struct ixgbe_hw *hw)
 	linkstat = IXGBE_READ_REG(hw, IXGBE_PCS1GLSTA);
 	if ((!!(linkstat & IXGBE_PCS1GLSTA_AN_COMPLETE) == 0) ||
 	    (!!(linkstat & IXGBE_PCS1GLSTA_AN_TIMED_OUT) == 1))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	pcs_anadv_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANA);
 	pcs_lpab_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANLP);
@@ -2353,12 +2341,12 @@ static s32 ixgbe_fc_autoneg_backplane(struct ixgbe_hw *hw)
 	 */
 	links = IXGBE_READ_REG(hw, IXGBE_LINKS);
 	if ((links & IXGBE_LINKS_KX_AN_COMP) == 0)
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	if (hw->mac.type == ixgbe_mac_82599EB) {
 		links2 = IXGBE_READ_REG(hw, IXGBE_LINKS2);
 		if ((links2 & IXGBE_LINKS2_AN_SUPPORTED) == 0)
-			return IXGBE_ERR_FC_NOT_NEGOTIATED;
+			return -EIO;
 	}
 	/*
 	 * Read the 10g AN autoc and LP ability registers and resolve
@@ -2407,8 +2395,8 @@ static s32 ixgbe_fc_autoneg_copper(struct ixgbe_hw *hw)
  **/
 void ixgbe_fc_autoneg(struct ixgbe_hw *hw)
 {
-	s32 ret_val = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 ret_val = -EIO;
 	bool link_up;
 
 	/*
@@ -2506,15 +2494,15 @@ static u32 ixgbe_pcie_timeout_poll(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_disable_pcie_master - Disable PCI-express master access
+ *  ixgbe_disable_pcie_primary - Disable PCI-express primary access
  *  @hw: pointer to hardware structure
  *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests. IXGBE_ERR_MASTER_REQUESTS_PENDING is returned if master disable
- *  bit hasn't caused the master requests to be disabled, else 0
- *  is returned signifying master requests disabled.
+ *  Disables PCI-Express primary access and verifies there are no pending
+ *  requests. -EALREADY is returned if primary disable
+ *  bit hasn't caused the primary requests to be disabled, else 0
+ *  is returned signifying primary requests disabled.
  **/
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw)
 {
 	u32 i, poll;
 	u16 value;
@@ -2523,23 +2511,23 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
 
 	/* Poll for bit to read as set */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
 			break;
 		usleep_range(100, 120);
 	}
-	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
+	if (i >= IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT) {
 		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
 		goto gio_disable_fail;
 	}
 
-	/* Exit if master requests are blocked */
+	/* Exit if primary requests are blocked */
 	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
 	    ixgbe_removed(hw->hw_addr))
 		return 0;
 
-	/* Poll for master request bit to clear */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	/* Poll for primary request bit to clear */
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		udelay(100);
 		if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO))
 			return 0;
@@ -2547,13 +2535,13 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 
 	/*
 	 * Two consecutive resets are required via CTRL.RST per datasheet
-	 * 5.2.5.3.2 Master Disable.  We set a flag to inform the reset routine
-	 * of this need.  The first reset prevents new master requests from
+	 * 5.2.5.3.2 Primary Disable.  We set a flag to inform the reset routine
+	 * of this need.  The first reset prevents new primary requests from
 	 * being issued by our device.  We then must wait 1usec or more for any
 	 * remaining completions from the PCIe bus to trickle in, and then reset
 	 * again to clear out any effects they may have had on our device.
 	 */
-	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
+	hw_dbg(hw, "GIO Primary Disable bit didn't clear - requesting resets\n");
 gio_disable_fail:
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
@@ -2575,7 +2563,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	}
 
 	hw_dbg(hw, "PCIe transaction pending bit also did not clear.\n");
-	return IXGBE_ERR_MASTER_REQUESTS_PENDING;
+	return -EALREADY;
 }
 
 /**
@@ -2600,7 +2588,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_eeprom_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		gssr = IXGBE_READ_REG(hw, IXGBE_GSSR);
 		if (!(gssr & (fwmask | swmask))) {
@@ -2620,7 +2608,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		ixgbe_release_swfw_sync(hw, gssr & (fwmask | swmask));
 
 	usleep_range(5000, 10000);
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -2757,7 +2745,7 @@ s32 ixgbe_blink_led_start_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * Link must be up to auto-blink the LEDs;
@@ -2803,7 +2791,7 @@ s32 ixgbe_blink_led_stop_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	ret_val = hw->mac.ops.prot_autoc_read(hw, &locked, &autoc_reg);
 	if (ret_val)
@@ -2963,7 +2951,7 @@ s32 ixgbe_clear_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	mpsar_lo = IXGBE_READ_REG(hw, IXGBE_MPSAR_LO(rar));
@@ -3014,7 +3002,7 @@ s32 ixgbe_set_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	if (vmdq < 32) {
@@ -3091,7 +3079,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	 * will simply bypass the VLVF if there are no entries present in the
 	 * VLVF that contain our VLAN
 	 */
-	first_empty_slot = vlvf_bypass ? IXGBE_ERR_NO_SPACE : 0;
+	first_empty_slot = vlvf_bypass ? -ENOSPC : 0;
 
 	/* add VLAN enable bit for comparison */
 	vlan |= IXGBE_VLVF_VIEN;
@@ -3115,7 +3103,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	if (!first_empty_slot)
 		hw_dbg(hw, "No space in VLVF.\n");
 
-	return first_empty_slot ? : IXGBE_ERR_NO_SPACE;
+	return first_empty_slot ? : -ENOSPC;
 }
 
 /**
@@ -3135,7 +3123,7 @@ s32 ixgbe_set_vfta_generic(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	s32 vlvf_index;
 
 	if ((vlan > 4095) || (vind > 63))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * this is a 2 part operation - first the VFTA, then the
@@ -3596,7 +3584,8 @@ u8 ixgbe_calculate_checksum(u8 *buffer, u32 length)
  *
  *  Communicates with the manageability block. On success return 0
  *  else returns semaphore error when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  semaphore, -EINVAL when incorrect parameters passed or -EIO when
+ *  command fails.
  *
  *  This function assumes that the IXGBE_GSSR_SW_MNG_SM semaphore is held
  *  by the caller.
@@ -3609,7 +3598,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 
 	/* Set bit 9 of FWSTS clearing FW reset indication */
@@ -3620,13 +3609,13 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	hicr = IXGBE_READ_REG(hw, IXGBE_HICR);
 	if (!(hicr & IXGBE_HICR_EN)) {
 		hw_dbg(hw, "IXGBE_HOST_EN bit disabled.\n");
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 	}
 
 	/* Calculate length in DWORDs. We must be DWORD aligned */
 	if (length % sizeof(u32)) {
 		hw_dbg(hw, "Buffer length failure, not aligned to dword");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	dword_len = length >> 2;
@@ -3651,7 +3640,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	/* Check command successful completion. */
 	if ((timeout && i == timeout) ||
 	    !(IXGBE_READ_REG(hw, IXGBE_HICR) & IXGBE_HICR_SV))
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 
 	return 0;
 }
@@ -3671,7 +3660,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
  *  in these cases.
  *
  *  Communicates with the manageability block.  On success return 0
- *  else return IXGBE_ERR_HOST_INTERFACE_COMMAND.
+ *  else return -EIO or -EINVAL.
  **/
 s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 				 u32 length, u32 timeout,
@@ -3686,7 +3675,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 	/* Take management host interface semaphore */
 	status = hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_SW_MNG_SM);
@@ -3716,7 +3705,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (length < round_up(buf_len, 4) + hdr_size) {
 		hw_dbg(hw, "Buffer not large enough for reply message.\n");
-		status = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		status = -EIO;
 		goto rel_out;
 	}
 
@@ -3747,8 +3736,8 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore or -EIO when command fails.
  **/
 s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 				 u8 build, u8 sub, __always_unused u16 len,
@@ -3784,7 +3773,7 @@ s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 		    FW_CEM_RESP_STATUS_SUCCESS)
 			ret_val = 0;
 		else
-			ret_val = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			ret_val = -EIO;
 
 		break;
 	}
@@ -3882,14 +3871,14 @@ static s32 ixgbe_get_ets_data(struct ixgbe_hw *hw, u16 *ets_cfg,
 		return status;
 
 	if ((*ets_offset == 0x0000) || (*ets_offset == 0xFFFF))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = hw->eeprom.ops.read(hw, *ets_offset, ets_cfg);
 	if (status)
 		return status;
 
 	if ((*ets_cfg & IXGBE_ETS_TYPE_MASK) != IXGBE_ETS_TYPE_EMC_SHIFTED)
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
@@ -3912,7 +3901,7 @@ s32 ixgbe_get_thermal_sensor_data_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
@@ -3972,7 +3961,7 @@ s32 ixgbe_init_thermal_sensor_thresh_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c829cb65171c..d00b0e85f0b2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3338,7 +3338,7 @@ static int ixgbe_get_module_eeprom(struct net_device *dev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	s32 status = IXGBE_ERR_PHY_ADDR_INVALID;
+	s32 status = -EFAULT;
 	u8 databyte = 0xFF;
 	int i = 0;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 819169eaebe9..cb9e9d70b338 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2758,7 +2758,6 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 eicr = adapter->interrupt_event;
-	s32 rc;
 
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
@@ -2792,14 +2791,13 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 		}
 
 		/* Check if this is not due to overtemp */
-		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 
 		break;
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
-		rc = hw->phy.ops.check_overtemp(hw);
-		if (rc != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 		break;
 	default:
@@ -5514,7 +5512,7 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
 	u32 speed;
 	bool autoneg, link_up = false;
-	int ret = IXGBE_ERR_LINK_SETUP;
+	int ret = -EIO;
 
 	if (hw->mac.ops.check_link)
 		ret = hw->mac.ops.check_link(hw, &speed, &link_up, false);
@@ -5940,13 +5938,13 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 	err = hw->mac.ops.init_hw(hw);
 	switch (err) {
 	case 0:
-	case IXGBE_ERR_SFP_NOT_PRESENT:
-	case IXGBE_ERR_SFP_NOT_SUPPORTED:
+	case -ENOENT:
+	case -EOPNOTSUPP:
 		break;
-	case IXGBE_ERR_MASTER_REQUESTS_PENDING:
-		e_dev_err("master disable timed out\n");
+	case -EALREADY:
+		e_dev_err("primary disable timed out\n");
 		break;
-	case IXGBE_ERR_EEPROM_VERSION:
+	case -EACCES:
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated with "
@@ -7736,10 +7734,10 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	adapter->sfp_poll_time = jiffies + IXGBE_SFP_POLL_JIFFIES - 1;
 
 	err = hw->phy.ops.identify_sfp(hw);
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		/* If no cable is present, then we need to reset
 		 * the next time we find a good cable. */
 		adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
@@ -7765,7 +7763,7 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	else
 		err = hw->mac.ops.setup_sfp(hw);
 
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
 	adapter->flags |= IXGBE_FLAG_NEED_LINK_CONFIG;
@@ -7774,8 +7772,8 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 sfp_out:
 	clear_bit(__IXGBE_IN_SFP_INIT, &adapter->state);
 
-	if ((err == IXGBE_ERR_SFP_NOT_SUPPORTED) &&
-	    (adapter->netdev->reg_state == NETREG_REGISTERED)) {
+	if (err == -EOPNOTSUPP &&
+	    adapter->netdev->reg_state == NETREG_REGISTERED) {
 		e_dev_err("failed to initialize because an unsupported "
 			  "SFP+ module type was detected.\n");
 		e_dev_err("Reload the driver after installing a "
@@ -7845,7 +7843,7 @@ static void ixgbe_service_timer(struct timer_list *t)
 static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 status;
+	bool overtemp;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
 		return;
@@ -7855,11 +7853,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 	if (!hw->phy.ops.handle_lasi)
 		return;
 
-	status = hw->phy.ops.handle_lasi(&adapter->hw);
-	if (status != IXGBE_ERR_OVERTEMP)
-		return;
-
-	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
+	if (overtemp)
+		e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
@@ -10782,9 +10778,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = hw->mac.ops.reset_hw(hw);
 	hw->phy.reset_if_overtemp = false;
 	ixgbe_set_eee_capable(adapter);
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		err = 0;
-	} else if (err == IXGBE_ERR_SFP_NOT_SUPPORTED) {
+	} else if (err == -EOPNOTSUPP) {
 		e_dev_err("failed to load because an unsupported SFP+ or QSFP module type was detected.\n");
 		e_dev_err("Reload the driver after installing a supported module.\n");
 		goto err_sw_init;
@@ -11001,7 +10997,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* reset the hardware with the new settings */
 	err = hw->mac.ops.start_hw(hw);
-	if (err == IXGBE_ERR_EEPROM_VERSION) {
+	if (err == -EACCES) {
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated "
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
index 5679293e53f7..fe7ef5773369 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
@@ -24,7 +24,7 @@ s32 ixgbe_read_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 		size = mbx->size;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->read(hw, msg, size, mbx_id);
 }
@@ -43,10 +43,10 @@ s32 ixgbe_write_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (size > mbx->size)
-		return IXGBE_ERR_MBX;
+		return -EINVAL;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->write(hw, msg, size, mbx_id);
 }
@@ -63,7 +63,7 @@ s32 ixgbe_check_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_msg(hw, mbx_id);
 }
@@ -80,7 +80,7 @@ s32 ixgbe_check_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_ack(hw, mbx_id);
 }
@@ -97,7 +97,7 @@ s32 ixgbe_check_for_rst(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_rst(hw, mbx_id);
 }
@@ -115,12 +115,12 @@ static s32 ixgbe_poll_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_msg(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -140,12 +140,12 @@ static s32 ixgbe_poll_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_ack(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -169,7 +169,7 @@ static s32 ixgbe_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 	s32 ret_val;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	ret_val = ixgbe_poll_for_msg(hw, mbx_id);
 	if (ret_val)
@@ -197,7 +197,7 @@ static s32 ixgbe_write_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 
 	/* exit if either we can't write or there isn't a defined timeout */
 	if (!mbx->ops || !mbx->timeout)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	/* send msg */
 	ret_val = mbx->ops->write(hw, msg, size, mbx_id);
@@ -217,7 +217,7 @@ static s32 ixgbe_check_for_bit_pf(struct ixgbe_hw *hw, u32 mask, s32 index)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -238,7 +238,7 @@ static s32 ixgbe_check_for_msg_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -259,7 +259,7 @@ static s32 ixgbe_check_for_ack_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -295,7 +295,7 @@ static s32 ixgbe_check_for_rst_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -317,7 +317,7 @@ static s32 ixgbe_obtain_mbx_lock_pf(struct ixgbe_hw *hw, u16 vf_number)
 	if (p2v_mailbox & IXGBE_PFMAILBOX_PFU)
 		return 0;
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index a148534d7256..def067b15873 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -7,7 +7,6 @@
 #include "ixgbe_type.h"
 
 #define IXGBE_VFMAILBOX_SIZE        16 /* 16 32 bit words - 64 bytes */
-#define IXGBE_ERR_MBX               -100
 
 #define IXGBE_VFMAILBOX             0x002FC
 #define IXGBE_VFMBMEM               0x00200
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 123dca9ce468..305afb82388b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -102,7 +102,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -150,7 +150,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte read combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -179,7 +179,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -215,7 +215,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte write combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -262,8 +262,8 @@ static bool ixgbe_probe_phy(struct ixgbe_hw *hw, u16 phy_addr)
  **/
 s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 {
+	u32 status = -EFAULT;
 	u32 phy_addr;
-	u32 status = IXGBE_ERR_PHY_ADDR_INVALID;
 
 	if (!hw->phy.phy_semaphore_mask) {
 		if (hw->bus.lan_id)
@@ -282,7 +282,7 @@ s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 		if (ixgbe_probe_phy(hw, phy_addr))
 			return 0;
 		else
-			return IXGBE_ERR_PHY_ADDR_INVALID;
+			return -EFAULT;
 	}
 
 	for (phy_addr = 0; phy_addr < IXGBE_MAX_PHY_ADDR; phy_addr++) {
@@ -408,8 +408,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 		return status;
 
 	/* Don't reset PHY if it's shut down due to overtemp. */
-	if (!hw->phy.reset_if_overtemp &&
-	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
+	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
 		return 0;
 
 	/* Blocked by MNG FW so bail */
@@ -457,7 +456,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 
 	if (ctrl & MDIO_CTRL1_RESET) {
 		hw_dbg(hw, "PHY reset polling failed to complete.\n");
-		return IXGBE_ERR_RESET_FAILED;
+		return -EIO;
 	}
 
 	return 0;
@@ -500,7 +499,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address command did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Address cycle complete, setup and write the read
@@ -527,7 +526,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY read command didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Read operation is complete.  Get the data
@@ -559,7 +558,7 @@ s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -604,7 +603,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/*
@@ -632,7 +631,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY write cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -657,7 +656,7 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						 phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -1303,7 +1302,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 	if ((phy_data & MDIO_CTRL1_RESET) != 0) {
 		hw_dbg(hw, "PHY reset did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Get init offsets */
@@ -1360,12 +1359,12 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 				hw_dbg(hw, "SOL\n");
 			} else {
 				hw_dbg(hw, "Bad control value\n");
-				return IXGBE_ERR_PHY;
+				return -EIO;
 			}
 			break;
 		default:
 			hw_dbg(hw, "Bad control type\n");
-			return IXGBE_ERR_PHY;
+			return -EIO;
 		}
 	}
 
@@ -1373,7 +1372,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 err_eeprom:
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -1391,10 +1390,10 @@ s32 ixgbe_identify_module_generic(struct ixgbe_hw *hw)
 		return ixgbe_identify_qsfp_module_generic(hw);
 	default:
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1419,7 +1418,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1434,7 +1433,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_SFP) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_1GBE_COMP_CODES,
@@ -1625,7 +1624,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1)) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	/* Anything else 82598-based is supported */
@@ -1649,7 +1648,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		}
 		hw_dbg(hw, "SFP+ module not supported\n");
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	return 0;
 
@@ -1659,7 +1658,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		hw->phy.id = 0;
 		hw->phy.type = ixgbe_phy_unknown;
 	}
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1686,7 +1685,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber_qsfp) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1700,7 +1699,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_QSFP_PLUS) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	hw->phy.id = identifier;
@@ -1768,7 +1767,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 		} else {
 			/* unsupported module type */
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 	}
 
@@ -1828,7 +1827,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 			}
 			hw_dbg(hw, "QSFP module not supported\n");
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 		return 0;
 	}
@@ -1839,7 +1838,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 	hw->phy.id = 0;
 	hw->phy.type = ixgbe_phy_unknown;
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1859,14 +1858,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	u16 sfp_type = hw->phy.sfp_type;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_not_present)
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 
 	if ((hw->device_id == IXGBE_DEV_ID_82598_SR_DUAL_PORT_EM) &&
 	    (hw->phy.sfp_type == ixgbe_sfp_type_da_cu))
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	/*
 	 * Limiting active cables and 1G Phys must be initialized as
@@ -1887,11 +1886,11 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	if (hw->eeprom.ops.read(hw, IXGBE_PHY_INIT_OFFSET_NL, list_offset)) {
 		hw_err(hw, "eeprom read at %d failed\n",
 		       IXGBE_PHY_INIT_OFFSET_NL);
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 	}
 
 	if ((!*list_offset) || (*list_offset == 0xFFFF))
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 
 	/* Shift offset to first ID word */
 	(*list_offset)++;
@@ -1910,7 +1909,7 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 				goto err_phy;
 			if ((!*data_offset) || (*data_offset == 0xFFFF)) {
 				hw_dbg(hw, "SFP+ module not supported\n");
-				return IXGBE_ERR_SFP_NOT_SUPPORTED;
+				return -EOPNOTSUPP;
 			} else {
 				break;
 			}
@@ -1923,14 +1922,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 
 	if (sfp_id == IXGBE_PHY_INIT_END_NL) {
 		hw_dbg(hw, "No matching SFP+ module found\n");
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
 
 err_phy:
 	hw_err(hw, "eeprom read at offset %d failed\n", *list_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -2025,7 +2024,7 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		ixgbe_i2c_start(hw);
 
@@ -2141,7 +2140,7 @@ static s32 ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
 	if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	do {
 		ixgbe_i2c_start(hw);
@@ -2383,7 +2382,7 @@ static s32 ixgbe_get_i2c_ack(struct ixgbe_hw *hw)
 
 	if (ack == 1) {
 		hw_dbg(hw, "I2C ack was not received.\n");
-		status = IXGBE_ERR_I2C;
+		status = -EIO;
 	}
 
 	ixgbe_lower_i2c_clk(hw, &i2cctl);
@@ -2455,7 +2454,7 @@ static s32 ixgbe_clock_out_i2c_bit(struct ixgbe_hw *hw, bool data)
 		udelay(IXGBE_I2C_T_LOW);
 	} else {
 		hw_dbg(hw, "I2C data was not set to %X\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2551,7 +2550,7 @@ static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
 	*i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	if (data != ixgbe_get_i2c_data(hw, i2cctl)) {
 		hw_dbg(hw, "Error - I2C data was not set to %X.\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2621,22 +2620,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Checks if the LASI temp alarm status was triggered due to overtemp
+ *
+ *  Return true when an overtemp event detected, otherwise false.
  **/
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
+	u32 status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
-		return 0;
+		return false;
 
 	/* Check that the LASI temp alarm status was triggered */
-	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
-			     MDIO_MMD_PMAPMD, &phy_data);
-
-	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
-		return 0;
+	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
+				      MDIO_MMD_PMAPMD, &phy_data);
+	if (status)
+		return false;
 
-	return IXGBE_ERR_OVERTEMP;
+	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM);
 }
 
 /** ixgbe_set_copper_phy_power - Control power for copper phy
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 6544c4539c0d..ef72729d7c93 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -155,7 +155,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 					u16 *list_offset,
 					u16 *data_offset);
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
 s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 5eba086690ef..0cd8bec6ae5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1279,7 +1279,7 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
-		retval = IXGBE_ERR_MBX;
+		retval = -EIO;
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2647937f7f4d..7c0358e0af44 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1247,7 +1247,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_PSRTYPE_RQPL_SHIFT    29
 
 /* CTRL Bit Masks */
-#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Master Disable bit */
+#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Primary Disable bit */
 #define IXGBE_CTRL_LNK_RST      0x00000008 /* Link Reset. Resets everything. */
 #define IXGBE_CTRL_RST          0x04000000 /* Reset (SW) */
 #define IXGBE_CTRL_RST_MASK     (IXGBE_CTRL_LNK_RST | IXGBE_CTRL_RST)
@@ -1811,7 +1811,7 @@ enum {
 /* STATUS Bit Masks */
 #define IXGBE_STATUS_LAN_ID         0x0000000C /* LAN ID */
 #define IXGBE_STATUS_LAN_ID_SHIFT   2          /* LAN ID Shift*/
-#define IXGBE_STATUS_GIO            0x00080000 /* GIO Master Enable Status */
+#define IXGBE_STATUS_GIO            0x00080000 /* GIO Primary Enable Status */
 
 #define IXGBE_STATUS_LAN_ID_0   0x00000000 /* LAN ID 0 */
 #define IXGBE_STATUS_LAN_ID_1   0x00000004 /* LAN ID 1 */
@@ -2193,8 +2193,8 @@ enum {
 #define IXGBE_PCIDEVCTRL2_4_8s		0xd
 #define IXGBE_PCIDEVCTRL2_17_34s	0xe
 
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define IXGBE_PCI_MASTER_DISABLE_TIMEOUT	800
+/* Number of 100 microseconds we wait for PCI Express primary disable */
+#define IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT	800
 
 /* RAH */
 #define IXGBE_RAH_VIND_MASK     0x003C0000
@@ -3502,10 +3502,10 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*check_overtemp)(struct ixgbe_hw *);
+	bool (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
-	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
 	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
@@ -3658,45 +3658,6 @@ struct ixgbe_info {
 	const u32			*mvals;
 };
 
-
-/* Error Codes */
-#define IXGBE_ERR_EEPROM                        -1
-#define IXGBE_ERR_EEPROM_CHECKSUM               -2
-#define IXGBE_ERR_PHY                           -3
-#define IXGBE_ERR_CONFIG                        -4
-#define IXGBE_ERR_PARAM                         -5
-#define IXGBE_ERR_MAC_TYPE                      -6
-#define IXGBE_ERR_UNKNOWN_PHY                   -7
-#define IXGBE_ERR_LINK_SETUP                    -8
-#define IXGBE_ERR_ADAPTER_STOPPED               -9
-#define IXGBE_ERR_INVALID_MAC_ADDR              -10
-#define IXGBE_ERR_DEVICE_NOT_SUPPORTED          -11
-#define IXGBE_ERR_MASTER_REQUESTS_PENDING       -12
-#define IXGBE_ERR_INVALID_LINK_SETTINGS         -13
-#define IXGBE_ERR_AUTONEG_NOT_COMPLETE          -14
-#define IXGBE_ERR_RESET_FAILED                  -15
-#define IXGBE_ERR_SWFW_SYNC                     -16
-#define IXGBE_ERR_PHY_ADDR_INVALID              -17
-#define IXGBE_ERR_I2C                           -18
-#define IXGBE_ERR_SFP_NOT_SUPPORTED             -19
-#define IXGBE_ERR_SFP_NOT_PRESENT               -20
-#define IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT       -21
-#define IXGBE_ERR_NO_SAN_ADDR_PTR               -22
-#define IXGBE_ERR_FDIR_REINIT_FAILED            -23
-#define IXGBE_ERR_EEPROM_VERSION                -24
-#define IXGBE_ERR_NO_SPACE                      -25
-#define IXGBE_ERR_OVERTEMP                      -26
-#define IXGBE_ERR_FC_NOT_NEGOTIATED             -27
-#define IXGBE_ERR_FC_NOT_SUPPORTED              -28
-#define IXGBE_ERR_SFP_SETUP_NOT_COMPLETE        -30
-#define IXGBE_ERR_PBA_SECTION                   -31
-#define IXGBE_ERR_INVALID_ARGUMENT              -32
-#define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
-#define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
-#define IXGBE_ERR_FW_RESP_INVALID		-39
-#define IXGBE_ERR_TOKEN_RETRY			-40
-#define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
-
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
 #define IXGBE_FUSES0_300MHZ		BIT(5)
 #define IXGBE_FUSES0_REV_MASK		(3u << 6)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index d5cfb51ff648..15325c549d9b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -84,7 +84,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl = IXGBE_CTRL_RST;
@@ -103,7 +103,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 	msleep(100);
@@ -220,7 +220,7 @@ static s32 ixgbe_read_eerd_X540(struct ixgbe_hw *hw, u16 offset, u16 *data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_generic(hw, offset, data);
 
@@ -243,7 +243,7 @@ static s32 ixgbe_read_eerd_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_buffer_generic(hw, offset, words, data);
 
@@ -264,7 +264,7 @@ static s32 ixgbe_write_eewr_X540(struct ixgbe_hw *hw, u16 offset, u16 data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_generic(hw, offset, data);
 
@@ -287,7 +287,7 @@ static s32 ixgbe_write_eewr_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_buffer_generic(hw, offset, words, data);
 
@@ -324,7 +324,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	for (i = 0; i < checksum_last_word; i++) {
 		if (ixgbe_read_eerd_generic(hw, i, &word)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 		checksum += word;
 	}
@@ -349,7 +349,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 
 		if (ixgbe_read_eerd_generic(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		/* Skip pointer section if length is invalid. */
@@ -360,7 +360,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (ixgbe_read_eerd_generic(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -397,7 +397,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -418,7 +418,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	 */
 	if (read_checksum != checksum) {
 		hw_dbg(hw, "Invalid EEPROM checksum");
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 	}
 
 	/* If the user cares, return the calculated checksum */
@@ -455,7 +455,7 @@ static s32 ixgbe_update_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return  IXGBE_ERR_SWFW_SYNC;
+		return  -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -490,7 +490,7 @@ static s32 ixgbe_update_flash_X540(struct ixgbe_hw *hw)
 	s32 status;
 
 	status = ixgbe_poll_flash_update_done_X540(hw);
-	if (status == IXGBE_ERR_EEPROM) {
+	if (status == -EIO) {
 		hw_dbg(hw, "Flash update time out\n");
 		return status;
 	}
@@ -540,7 +540,7 @@ static s32 ixgbe_poll_flash_update_done_X540(struct ixgbe_hw *hw)
 			return 0;
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -575,7 +575,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_swfw_sync_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 		if (!(swfw_sync & (fwmask | swmask | hwmask))) {
@@ -599,7 +599,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 	 * bits in the SW_FW_SYNC register.
 	 */
 	if (ixgbe_get_swfw_sync_semaphore(hw))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 	if (swfw_sync & (fwmask | hwmask)) {
 		swfw_sync |= swmask;
@@ -622,11 +622,11 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 			rmask |= IXGBE_GSSR_I2C_MASK;
 		ixgbe_release_swfw_sync_X540(hw, rmask);
 		ixgbe_release_swfw_sync_semaphore(hw);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 	ixgbe_release_swfw_sync_semaphore(hw);
 
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -680,7 +680,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	if (i == timeout) {
 		hw_dbg(hw,
 		       "Software semaphore SMBI between device drivers not granted.\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Now get the semaphore between SW/FW through the REGSMP bit */
@@ -697,7 +697,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	 */
 	hw_dbg(hw, "REGSMP Software NVM semaphore not granted\n");
 	ixgbe_release_swfw_sync_semaphore(hw);
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -768,7 +768,7 @@ s32 ixgbe_blink_led_start_X540(struct ixgbe_hw *hw, u32 index)
 	bool link_up;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Link should be up in order for the blink bit in the LED control
 	 * register to work. Force link and speed in the MAC if link is down.
@@ -804,7 +804,7 @@ s32 ixgbe_blink_led_stop_X540(struct ixgbe_hw *hw, u32 index)
 	u32 ledctl_reg;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Restore the LED to its default value. */
 	ledctl_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index e4b50c7781ff..1d3f99e664dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -206,13 +206,13 @@ static s32 ixgbe_reset_cs4227(struct ixgbe_hw *hw)
 	}
 	if (retry == IXGBE_CS4227_RETRIES) {
 		hw_err(hw, "CS4227 reset did not complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	status = ixgbe_read_cs4227(hw, IXGBE_CS4227_EEPROM_STATUS, &value);
 	if (status || !(value & IXGBE_CS4227_EEPROM_LOAD_OK)) {
 		hw_err(hw, "CS4227 EEPROM did not load successfully\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -350,13 +350,13 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 static s32 ixgbe_read_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				     u32 device_type, u16 *phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 static s32 ixgbe_write_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				      u32 device_type, u16 phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 /**
@@ -463,7 +463,7 @@ s32 ixgbe_fw_phy_activity(struct ixgbe_hw *hw, u16 activity,
 		--retries;
 	} while (retries > 0);
 
-	return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+	return -EIO;
 }
 
 static const struct {
@@ -511,7 +511,7 @@ static s32 ixgbe_get_phy_id_fw(struct ixgbe_hw *hw)
 	hw->phy.id |= phy_id_lo & IXGBE_PHY_REVISION_MASK;
 	hw->phy.revision = phy_id_lo & ~IXGBE_PHY_REVISION_MASK;
 	if (!hw->phy.id || hw->phy.id == IXGBE_PHY_REVISION_MASK)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	hw->phy.autoneg_advertised = hw->phy.speeds_supported;
 	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_100_FULL |
@@ -568,7 +568,7 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	switch (hw->fc.requested_mode) {
@@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
 	if (rc)
 		return rc;
+
 	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
-		return IXGBE_ERR_OVERTEMP;
+		return -EIO;
+
 	return 0;
 }
 
@@ -675,7 +677,7 @@ static s32 ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 		*ctrl = command;
 	if (i == IXGBE_MDIO_COMMAND_TIMEOUT) {
 		hw_dbg(hw, "IOSF wait timed out\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -715,7 +717,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to read, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (!ret)
@@ -750,9 +753,9 @@ static s32 ixgbe_get_phy_token(struct ixgbe_hw *hw)
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
 	if (token_cmd.hdr.cmd_or_resp.ret_status != FW_PHY_TOKEN_RETRY)
-		return IXGBE_ERR_FW_RESP_INVALID;
+		return -EIO;
 
-	return IXGBE_ERR_TOKEN_RETRY;
+	return -EAGAIN;
 }
 
 /**
@@ -778,7 +781,7 @@ static s32 ixgbe_put_phy_token(struct ixgbe_hw *hw)
 		return status;
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
-	return IXGBE_ERR_FW_RESP_INVALID;
+	return -EIO;
 }
 
 /**
@@ -942,7 +945,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 		local_buffer = buf;
 	} else {
 		if (buffer_size < ptr)
-			return  IXGBE_ERR_PARAM;
+			return  -EINVAL;
 		local_buffer = &buffer[ptr];
 	}
 
@@ -960,7 +963,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 	}
 
 	if (buffer && ((u32)start + (u32)length > buffer_size))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	for (i = start; length; i++, length--) {
 		if (i == bufsz && !buffer) {
@@ -1012,7 +1015,7 @@ static s32 ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 		local_buffer = eeprom_ptrs;
 	} else {
 		if (buffer_size < IXGBE_EEPROM_LAST_WORD)
-			return IXGBE_ERR_PARAM;
+			return -EINVAL;
 		local_buffer = buffer;
 	}
 
@@ -1148,7 +1151,7 @@ static s32 ixgbe_validate_eeprom_checksum_X550(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum) {
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 		hw_dbg(hw, "Invalid EEPROM checksum");
 	}
 
@@ -1203,7 +1206,7 @@ static s32 ixgbe_write_ee_hostif_X550(struct ixgbe_hw *hw, u16 offset, u16 data)
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
 	} else {
 		hw_dbg(hw, "write ee hostif failed to get semaphore");
-		status = IXGBE_ERR_SWFW_SYNC;
+		status = -EBUSY;
 	}
 
 	return status;
@@ -1415,7 +1418,7 @@ static s32 ixgbe_write_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to write, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 out:
@@ -1558,7 +1561,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 
 	/* iXFI is only supported with X552 */
 	if (mac->type != ixgbe_mac_X550EM_x)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 
 	/* Disable AN and force speed to 10G Serial. */
 	status = ixgbe_read_iosf_sb_reg_x550(hw,
@@ -1580,7 +1583,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal KR PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = ixgbe_write_iosf_sb_reg_x550(hw,
@@ -1611,7 +1614,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 {
 	switch (hw->phy.sfp_type) {
 	case ixgbe_sfp_type_not_present:
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	case ixgbe_sfp_type_da_cu_core0:
 	case ixgbe_sfp_type_da_cu_core1:
 		*linear = true;
@@ -1630,7 +1633,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 	case ixgbe_sfp_type_1g_cu_core0:
 	case ixgbe_sfp_type_1g_cu_core1:
 	default:
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -1660,7 +1663,7 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 	 * there is no reason to configure CS4227 and SFP not present error is
 	 * not accepted in the setup MAC link flow.
 	 */
-	if (status == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (status == -ENOENT)
 		return 0;
 
 	if (status)
@@ -1718,7 +1721,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = mac->ops.write_iosf_sb_reg(hw,
@@ -1753,7 +1756,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1803,7 +1806,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1813,7 +1816,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ixgbe_setup_kr_speed_x550em(hw, speed);
 
 	if (hw->phy.mdio.prtad == MDIO_PRTAD_NONE)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	/* Get external PHY SKU id */
 	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_EFUSE_PDF_SKU,
@@ -1912,7 +1915,7 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	status = ixgbe_check_mac_link_generic(hw, speed, link_up,
 					      link_up_wait_to_complete);
@@ -2095,9 +2098,9 @@ static s32 ixgbe_setup_sgmii_fw(struct ixgbe_hw *hw, ixgbe_link_speed speed,
  */
 static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	u32 info[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2115,7 +2118,7 @@ static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 	/* Check if auto-negotiation has completed */
 	status = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &info);
 	if (status || !(info[0] & FW_PHY_ACT_GET_LINK_INFO_AN_COMPLETE)) {
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -2319,18 +2322,18 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  * @hw: pointer to hardware structure
  * @lsc: pointer to boolean flag which indicates whether external Base T
  *	 PHY interrupt is lsc
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Determime if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
+static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
+				       bool *is_overtemp)
 {
 	u32 status;
 	u16 reg;
 
+	*is_overtemp = false;
 	*lsc = false;
 
 	/* Vendor alarm triggered */
@@ -2362,7 +2365,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
 		/* power down the PHY in case the PHY FW didn't already */
 		ixgbe_set_copper_phy_power(hw, false);
-		return IXGBE_ERR_OVERTEMP;
+		*is_overtemp = true;
+		return -EIO;
 	}
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
 		/*  device fault alarm triggered */
@@ -2376,7 +2380,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
 			/* power down the PHY in case the PHY FW didn't */
 			ixgbe_set_copper_phy_power(hw, false);
-			return IXGBE_ERR_OVERTEMP;
+			*is_overtemp = true;
+			return -EIO;
 		}
 	}
 
@@ -2412,12 +2417,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
  **/
 static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
+	bool lsc, overtemp;
 	u32 status;
 	u16 reg;
-	bool lsc;
 
 	/* Clear interrupt flags */
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
 
 	/* Enable link status change alarm */
 
@@ -2496,21 +2501,20 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 /**
  * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
  * @hw: pointer to hardware structure
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Handle external Base T PHY interrupt. If high temperature
  * failure alarm then return error, else if link status change
  * then setup internal/external PHY link
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
+					  bool *is_overtemp)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
 	u32 status;
 
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
 		return status;
 
@@ -2642,7 +2646,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	u16 speed;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	if (!(hw->mac.type == ixgbe_mac_X550EM_x &&
 	      !(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE))) {
@@ -2685,7 +2689,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		/* Internal PHY does not support anything else */
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	return ixgbe_setup_ixfi_x550em(hw, &force_speed);
@@ -2717,7 +2721,7 @@ static s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2739,7 +2743,7 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2763,8 +2767,9 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore, -EIO when command fails or -ENIVAL when incorrect
+ *  params passed.
  **/
 static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 				     u8 build, u8 sub, u16 len,
@@ -2775,7 +2780,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 	int i;
 
 	if (!len || !driver_ver || (len > sizeof(fw_cmd.driver_string)))
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 
 	fw_cmd.hdr.cmd = FW_CEM_CMD_DRIVER_INFO;
 	fw_cmd.hdr.buf_len = FW_CEM_CMD_DRIVER_INFO_LEN + len;
@@ -2800,7 +2805,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 
 		if (fw_cmd.hdr.cmd_or_resp.ret_status !=
 		    FW_CEM_RESP_STATUS_SUCCESS)
-			return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			return -EIO;
 		return 0;
 	}
 
@@ -2857,7 +2862,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/* 10gig parts do not have a word in the EEPROM to determine the
@@ -2892,7 +2897,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (hw->device_id) {
@@ -2936,8 +2941,8 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 {
 	u32 link_s1, lp_an_page_low, an_cntl_1;
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2963,7 +2968,7 @@ static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 
 	if (status || (link_s1 & IXGBE_KRM_LINK_S1_MAC_AN_COMPLETE) == 0) {
 		hw_dbg(hw, "Auto-Negotiation did not complete\n");
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -3137,21 +3142,23 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
 /**
  * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
  * @hw: pointer to hardware structure
+ *
+ * Return true when an overtemp event detected, otherwise false.
  */
-static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
+static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
 {
 	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	s32 rc;
 
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
 	if (rc)
-		return rc;
+		return false;
 
 	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
 		ixgbe_shutdown_fw_phy(hw);
-		return IXGBE_ERR_OVERTEMP;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
@@ -3201,8 +3208,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 
 	/* Identify the PHY or SFP module */
 	ret_val = phy->ops.identify(hw);
-	if (ret_val == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    ret_val == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (ret_val == -EOPNOTSUPP || ret_val == -EFAULT)
 		return ret_val;
 
 	/* Setup function pointers based on detected hardware */
@@ -3410,8 +3416,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 
 	/* PHY ops must be identified and initialized prior to reset */
 	status = hw->phy.ops.init(hw);
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    status == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (status == -EOPNOTSUPP || status == -EFAULT)
 		return status;
 
 	/* start the external PHY */
@@ -3427,7 +3432,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -3451,7 +3456,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
@@ -3469,7 +3474,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -3565,7 +3570,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	if (hw->fc.requested_mode == ixgbe_fc_default)
@@ -3622,7 +3627,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	status = hw->mac.ops.write_iosf_sb_reg(hw,
@@ -3718,7 +3723,7 @@ static s32 ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 			return 0;
 		if (hmask)
 			ixgbe_release_swfw_sync_X540(hw, hmask);
-		if (status != IXGBE_ERR_TOKEN_RETRY)
+		if (status != -EAGAIN)
 			return status;
 		msleep(FW_PHY_TOKEN_DELAY);
 	}
@@ -3762,7 +3767,7 @@ static s32 ixgbe_read_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->phy.ops.read_reg_mdi(hw, reg_addr, device_type, phy_data);
 
@@ -3788,7 +3793,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_phy_reg_mdi(hw, reg_addr, device_type, phy_data);
 	hw->mac.ops.release_swfw_sync(hw, mask);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 31b3ede563c0..ba44d1d9cfcd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -614,12 +614,38 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *priv)
 	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);
 }
 
+/* Cleanup pool before actual initialization in the OS */
+static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
+{
+	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
+	u32 val;
+	int i;
+
+	/* Drain the BM from all possible residues left by firmware */
+	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
+		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));
+
+	put_cpu();
+
+	/* Stop the BM pool */
+	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
+	val |= MVPP2_BM_STOP_MASK;
+	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
+}
+
 static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 {
 	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
 	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
 	struct mvpp2_port *port;
 
+	if (priv->percpu_pools)
+		poolnum = mvpp2_get_nrxqs(priv) * 2;
+
+	/* Clean up the pool state in case it contains stale state */
+	for (i = 0; i < poolnum; i++)
+		mvpp2_bm_pool_cleanup(priv, i);
+
 	if (priv->percpu_pools) {
 		for (i = 0; i < priv->port_count; i++) {
 			port = priv->port_list[i];
@@ -629,7 +655,6 @@ static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 			}
 		}
 
-		poolnum = mvpp2_get_nrxqs(priv) * 2;
 		for (i = 0; i < poolnum; i++) {
 			/* the pool in use */
 			int pn = i / (poolnum / 2);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8b16738e249f..70b4f2a3b02f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2625,18 +2625,17 @@ int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
 	rsp->entry = NPC_MCAM_ENTRY_INVALID;
 	rsp->free_count = 0;
 
-	/* Check if ref_entry is within range */
-	if (req->priority && req->ref_entry >= mcam->bmap_entries) {
-		dev_err(rvu->dev, "%s: reference entry %d is out of range\n",
-			__func__, req->ref_entry);
-		return NPC_MCAM_INVALID_REQ;
-	}
+	/* Check if ref_entry is greater that the range
+	 * then set it to max value.
+	 */
+	if (req->ref_entry > mcam->bmap_entries)
+		req->ref_entry = mcam->bmap_entries;
 
 	/* ref_entry can't be '0' if requested priority is high.
 	 * Can't be last entry if requested priority is low.
 	 */
 	if ((!req->ref_entry && req->priority == NPC_MCAM_HIGHER_PRIO) ||
-	    ((req->ref_entry == (mcam->bmap_entries - 1)) &&
+	    ((req->ref_entry == mcam->bmap_entries) &&
 	     req->priority == NPC_MCAM_LOWER_PRIO))
 		return NPC_MCAM_INVALID_REQ;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 572c981171ba..6b024d29eaf3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -856,8 +856,11 @@ static int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	if (pfvf->ptp) {
 		err = qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
 				 sizeof(*sq->timestamps));
-		if (err)
+		if (err) {
+			kfree(sq->sg);
+			sq->sg = NULL;
 			return err;
+		}
 	}
 
 	sq->head = 0;
@@ -872,7 +875,14 @@ static int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	sq->stats.bytes = 0;
 	sq->stats.pkts = 0;
 
-	return pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	if (err) {
+		kfree(sq->sg);
+		sq->sg = NULL;
+		return err;
+	}
+
+	return 0;
 
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index b26edbc53cad..05905e988431 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -435,6 +435,7 @@ static int fs_any_create_groups(struct mlx5e_flow_table *ft)
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index fe5d82fa6e92..313d62d38af8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -239,11 +239,13 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 
 	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
 			sizeof(*ft->g), GFP_KERNEL);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if  (!in || !ft->g) {
-		kfree(ft->g);
-		kvfree(in);
+	if (!ft->g)
 		return -ENOMEM;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_free_g;
 	}
 
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
@@ -263,7 +265,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	switch (type) {
@@ -285,7 +287,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
@@ -294,7 +296,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	memset(in, 0, inlen);
@@ -303,18 +305,20 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	kvfree(in);
 	return 0;
 
-err:
+err_clean_group:
 	err = PTR_ERR(ft->g[ft->num_groups]);
 	ft->g[ft->num_groups] = NULL;
-out:
+err_free_in:
 	kvfree(in);
-
+err_free_g:
+	kfree(ft->g);
+	ft->g = NULL;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 897c7f852123..51453d082966 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -579,6 +579,7 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 		switch (action_type) {
 		case DR_ACTION_TYP_DROP:
 			attr.final_icm_addr = nic_dmn->drop_icm_addr;
+			attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
 			break;
 		case DR_ACTION_TYP_FT:
 			dest_action = action;
@@ -666,16 +667,16 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 							action->sampler->tx_icm_addr;
 			break;
 		case DR_ACTION_TYP_VPORT:
-			attr.hit_gvmi = action->vport->caps->vhca_gvmi;
-			dest_action = action;
-			if (rx_rule) {
-				if (action->vport->caps->num == WIRE_PORT) {
-					mlx5dr_dbg(dmn, "Device doesn't support Loopback on WIRE vport\n");
-					return -EOPNOTSUPP;
-				}
-				attr.final_icm_addr = action->vport->caps->icm_address_rx;
+			if (unlikely(rx_rule && action->vport->caps->num == MLX5_VPORT_UPLINK)) {
+				/* can't go to uplink on RX rule - dropping instead */
+				attr.final_icm_addr = nic_dmn->drop_icm_addr;
+				attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
 			} else {
-				attr.final_icm_addr = action->vport->caps->icm_address_tx;
+				attr.hit_gvmi = action->vport->caps->vhca_gvmi;
+				dest_action = action;
+				attr.final_icm_addr = rx_rule ?
+						      action->vport->caps->icm_address_rx :
+						      action->vport->caps->icm_address_tx;
 			}
 			break;
 		case DR_ACTION_TYP_POP_VLAN:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
index ea1b8ca5bf3a..fe2c2b4113f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
@@ -171,7 +171,7 @@ static int dr_domain_query_vports(struct mlx5dr_domain *dmn)
 
 	/* Last vport is the wire port */
 	wire_vport = &dmn->info.caps.vports_caps[vport];
-	wire_vport->num = WIRE_PORT;
+	wire_vport->num = MLX5_VPORT_UPLINK;
 	wire_vport->icm_address_rx = esw_caps->uplink_icm_address_rx;
 	wire_vport->icm_address_tx = esw_caps->uplink_icm_address_tx;
 	wire_vport->vport_gvmi = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
index aca80efc28fa..323ea138ad99 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -1042,10 +1042,10 @@ static bool dr_rule_skip(enum mlx5dr_domain_type domain,
 		return false;
 
 	if (mask->misc.source_port) {
-		if (rx && value->misc.source_port != WIRE_PORT)
+		if (rx && value->misc.source_port != MLX5_VPORT_UPLINK)
 			return true;
 
-		if (!rx && value->misc.source_port == WIRE_PORT)
+		if (!rx && value->misc.source_port == MLX5_VPORT_UPLINK)
 			return true;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 9e2102f8bed1..175b9450c9aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -4,7 +4,7 @@
 #ifndef	_DR_TYPES_
 #define	_DR_TYPES_
 
-#include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
 #include <linux/refcount.h>
 #include "fs_core.h"
 #include "wq.h"
@@ -14,7 +14,6 @@
 
 #define DR_RULE_MAX_STES 18
 #define DR_ACTION_MAX_STES 5
-#define WIRE_PORT 0xFFFF
 #define DR_STE_SVLAN 0x1
 #define DR_STE_CVLAN 0x2
 #define DR_SZ_MATCH_PARAM (MLX5_ST_SZ_DW_MATCH_PARAM * 4)
@@ -1116,10 +1115,10 @@ static inline struct mlx5dr_cmd_vport_cap *
 mlx5dr_get_vport_cap(struct mlx5dr_cmd_caps *caps, u32 vport)
 {
 	if (!caps->vports_caps ||
-	    (vport >= caps->num_vports && vport != WIRE_PORT))
+	    (vport >= caps->num_vports && vport != MLX5_VPORT_UPLINK))
 		return NULL;
 
-	if (vport == WIRE_PORT)
+	if (vport == MLX5_VPORT_UPLINK)
 		vport = caps->num_vports;
 
 	return &caps->vports_caps[vport];
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index cb43651ea9ba..769412c70e17 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -927,7 +927,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 	u16 nfp_mac_idx = 0;
 
 	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
-	if (entry && nfp_tunnel_is_mac_idx_global(entry->index)) {
+	if (entry && (nfp_tunnel_is_mac_idx_global(entry->index) || netif_is_lag_port(netdev))) {
 		if (entry->bridge_count ||
 		    !nfp_flower_is_supported_bridge(netdev)) {
 			nfp_tunnel_offloaded_macs_inc_ref_and_link(entry,
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 252fe06f58aa..4c513e7755f7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -542,11 +542,13 @@ static int enable_bars(struct nfp6000_pcie *nfp, u16 interface)
 	const u32 barcfg_msix_general =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
 	const u32 barcfg_msix_xpb =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
 		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
 			NFP_CPP_TARGET_ISLAND_XPB);
 	const u32 barcfg_explicit[4] = {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index b778d8264bca..f81b00c7e106 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -268,6 +268,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 38f38fe8f21d..1ab86eee8b5a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -144,6 +144,7 @@ struct ionic_dev {
 	bool fw_hb_ready;
 	bool fw_status_ready;
 	u8 fw_generation;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 538c024afed5..7942a7f0f7b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -350,7 +350,7 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds)
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	do {
 		done = ionic_dev_cmd_done(idev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index c03ac229e936..d9e8602f866d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -209,6 +209,7 @@ struct stmmac_safety_stats {
 	unsigned long mac_errors[32];
 	unsigned long mtl_errors[32];
 	unsigned long dma_errors[32];
+	unsigned long dma_dpp_errors[32];
 };
 
 /* Number of fields in Safety Stats */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 880a75bf2eb1..8748c37e9dac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -282,6 +282,8 @@
 #define XGMAC_RXCEIE			BIT(4)
 #define XGMAC_TXCEIE			BIT(0)
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
+#define XGMAC_MTL_DPP_CONTROL		0x000010e0
+#define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_TQS_SHIFT			16
@@ -364,6 +366,7 @@
 #define XGMAC_DCEIE			BIT(1)
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
+#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index c2181c277291..ec1616ffbfa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -789,6 +789,44 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
+#define DPP_RX_ERR "Read Rx Descriptor Parity checker Error"
+#define DPP_TX_ERR "Read Tx Descriptor Parity checker Error"
+
+static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
+	{ true, "TDPES0", DPP_TX_ERR },
+	{ true, "TDPES1", DPP_TX_ERR },
+	{ true, "TDPES2", DPP_TX_ERR },
+	{ true, "TDPES3", DPP_TX_ERR },
+	{ true, "TDPES4", DPP_TX_ERR },
+	{ true, "TDPES5", DPP_TX_ERR },
+	{ true, "TDPES6", DPP_TX_ERR },
+	{ true, "TDPES7", DPP_TX_ERR },
+	{ true, "TDPES8", DPP_TX_ERR },
+	{ true, "TDPES9", DPP_TX_ERR },
+	{ true, "TDPES10", DPP_TX_ERR },
+	{ true, "TDPES11", DPP_TX_ERR },
+	{ true, "TDPES12", DPP_TX_ERR },
+	{ true, "TDPES13", DPP_TX_ERR },
+	{ true, "TDPES14", DPP_TX_ERR },
+	{ true, "TDPES15", DPP_TX_ERR },
+	{ true, "RDPES0", DPP_RX_ERR },
+	{ true, "RDPES1", DPP_RX_ERR },
+	{ true, "RDPES2", DPP_RX_ERR },
+	{ true, "RDPES3", DPP_RX_ERR },
+	{ true, "RDPES4", DPP_RX_ERR },
+	{ true, "RDPES5", DPP_RX_ERR },
+	{ true, "RDPES6", DPP_RX_ERR },
+	{ true, "RDPES7", DPP_RX_ERR },
+	{ true, "RDPES8", DPP_RX_ERR },
+	{ true, "RDPES9", DPP_RX_ERR },
+	{ true, "RDPES10", DPP_RX_ERR },
+	{ true, "RDPES11", DPP_RX_ERR },
+	{ true, "RDPES12", DPP_RX_ERR },
+	{ true, "RDPES13", DPP_RX_ERR },
+	{ true, "RDPES14", DPP_RX_ERR },
+	{ true, "RDPES15", DPP_RX_ERR },
+};
+
 static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 				    void __iomem *ioaddr, bool correctable,
 				    struct stmmac_safety_stats *stats)
@@ -800,6 +838,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 
 	dwxgmac3_log_error(ndev, value, correctable, "DMA",
 			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
+
+	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+
+	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
+			   dwxgmac3_dma_dpp_errors,
+			   STAT_OFF(dma_dpp_errors), stats);
 }
 
 static int
@@ -838,6 +883,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
 
+	/* 5. Enable Data Path Parity Protection */
+	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
+	/* already enabled by default, explicit enable it again */
+	value &= ~XGMAC_DPP_DISABLE;
+	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
+
 	return 0;
 }
 
@@ -871,7 +922,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
 		ret |= !corr;
 	}
 
-	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
+	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
+	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
+	 * Parity Errors here
+	 */
+	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
 	corr = dma & XGMAC_DECIS;
 	if (err) {
 		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
@@ -887,6 +942,7 @@ static const struct dwxgmac3_error {
 	{ dwxgmac3_mac_errors },
 	{ dwxgmac3_mtl_errors },
 	{ dwxgmac3_dma_errors },
+	{ dwxgmac3_dma_dpp_errors },
 };
 
 static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ede630bfad2f..ab3ded6e0e6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7096,6 +7096,9 @@ int stmmac_dvr_probe(struct device *device,
 		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
 			ERR_PTR(ret));
 
+	/* Wait a bit for the reset to take effect */
+	udelay(10);
+
 	/* Init MAC and get the capabilities */
 	ret = stmmac_hw_init(priv);
 	if (ret)
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ca587fe28150..cbd261b67a77 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -631,6 +631,8 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 		}
 	}
 
+	phy->mac_managed_pm = true;
+
 	slave->phy = phy;
 
 	phy_attached_info(slave->phy);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 0d921f6542d6..13e34ad72f26 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -772,6 +772,9 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 			slave->slave_num);
 		return;
 	}
+
+	phy->mac_managed_pm = true;
+
 	slave->phy = phy;
 
 	phy_attached_info(slave->phy);
diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index 065bb0a40b1d..a1405a3e294c 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -220,21 +220,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 	mem_size = FJES_DEV_REQ_BUF_SIZE(hw->max_epid);
 	hw->hw_info.req_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.req_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.req_buf)) {
+		result = -ENOMEM;
+		goto free_ep_info;
+	}
 
 	hw->hw_info.req_buf_size = mem_size;
 
 	mem_size = FJES_DEV_RES_BUF_SIZE(hw->max_epid);
 	hw->hw_info.res_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.res_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.res_buf)) {
+		result = -ENOMEM;
+		goto free_req_buf;
+	}
 
 	hw->hw_info.res_buf_size = mem_size;
 
 	result = fjes_hw_alloc_shared_status_region(hw);
 	if (result)
-		return result;
+		goto free_res_buf;
 
 	hw->hw_info.buffer_share_bit = 0;
 	hw->hw_info.buffer_unshare_reserve_bit = 0;
@@ -245,11 +249,11 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->tx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->rx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			spin_lock_irqsave(&hw->rx_status_lock, flags);
 			fjes_hw_setup_epbuf(&buf_pair->tx, mac,
@@ -272,6 +276,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 	fjes_hw_init_command_registers(hw, &param);
 
 	return 0;
+
+free_epbuf:
+	for (epidx = 0; epidx < hw->max_epid ; epidx++) {
+		if (epidx == hw->my_epid)
+			continue;
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].tx);
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].rx);
+	}
+	fjes_hw_free_shared_status_region(hw);
+free_res_buf:
+	kfree(hw->hw_info.res_buf);
+	hw->hw_info.res_buf = NULL;
+free_req_buf:
+	kfree(hw->hw_info.req_buf);
+	hw->hw_info.req_buf = NULL;
+free_ep_info:
+	kfree(hw->ep_shm_info);
+	hw->ep_shm_info = NULL;
+	return result;
 }
 
 static void fjes_hw_cleanup(struct fjes_hw *hw)
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 4156299e039d..058472f42938 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -710,7 +710,10 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Disable NAPI and disassociate its context from the device. */
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
-		napi_disable(&net_device->chan_table[i].napi);
+		/* only disable enabled NAPI channel */
+		if (i < ndev->real_num_rx_queues)
+			napi_disable(&net_device->chan_table[i].napi);
+
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
 
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c3a8ac244a08..25b65450cbb9 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -44,7 +44,7 @@
 
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
-MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
+MODULE_PARM_DESC(ring_size, "Ring buffer size (# of 4K pages)");
 unsigned int netvsc_ring_bytes __ro_after_init;
 
 static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
@@ -2824,7 +2824,7 @@ static int __init netvsc_drv_init(void)
 		pr_info("Increased ring_size to %u (min allowed)\n",
 			ring_size);
 	}
-	netvsc_ring_bytes = ring_size * PAGE_SIZE;
+	netvsc_ring_bytes = VMBUS_RING_SIZE(ring_size * 4096);
 
 	register_netdevice_notifier(&netvsc_netdev_notifier);
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 29a93d6bfe37..4a5c749ba223 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -471,6 +471,10 @@ ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3eefe8171925..6a655bd442fe 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2913,10 +2913,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -2953,8 +2954,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		callbacks[rxq2vq(i)] = skb_recv_done;
 		callbacks[txq2vq(i)] = skb_xmit_done;
-		sprintf(vi->rq[i].name, "input.%d", i);
-		sprintf(vi->sq[i].name, "output.%d", i);
+		sprintf(vi->rq[i].name, "input.%u", i);
+		sprintf(vi->sq[i].name, "output.%u", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 672789e3c55d..d6a3f001dacb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -652,9 +652,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON_ONCE(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9e00d1d7e146..f0e0d4ccbc09 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -527,7 +527,7 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 2) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -543,7 +543,7 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 1) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -559,7 +559,7 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 0) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -614,7 +614,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 2) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -630,7 +630,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 1) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -646,7 +646,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 0) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index f9bd081dd9e0..8a610c518082 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -836,7 +836,7 @@ static int iwl_dbg_tlv_override_trig_node(struct iwl_fw_runtime *fwrt,
 		node_trig = (void *)node_tlv->data;
 	}
 
-	memcpy(node_trig->data + offset, trig->data, trig_data_len);
+	memcpy((u8 *)node_trig->data + offset, trig->data, trig_data_len);
 	node_tlv->length = cpu_to_le32(size);
 
 	if (policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 388675d073ce..10ae5e313dda 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,7 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1268,6 +1269,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
@@ -1294,6 +1296,7 @@ void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 }
 
 static inline void rt2x00lib_set_if_combinations(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index dea5babd30fe..f81b0ab0b4c5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -598,6 +598,17 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 	if (changes & BSS_CHANGED_BEACON_ENABLED) {
 		mutex_lock(&intf->beacon_skb_mutex);
+
+		/*
+		 * Clear the 'enable_beacon' flag and clear beacon because
+		 * the beacon queue has been stopped after hardware reset.
+		 */
+		if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags) &&
+		    intf->enable_beacon) {
+			intf->enable_beacon = false;
+			rt2x00queue_clear_beacon(rt2x00dev, vif);
+		}
+
 		if (!bss_conf->enable_beacon && intf->enable_beacon) {
 			rt2x00dev->intf_beaconing--;
 			intf->enable_beacon = false;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index be93ffa5086a..30d9a195c6fb 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6973,6 +6973,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 #endif
 { }
 };
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index fe9b407dc2af..71e29b103da5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -49,7 +49,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 							    rfpath, regaddr);
 	}
 
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -80,7 +80,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = rtl8723_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -89,7 +89,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		rtl8723_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	} else {
 		if (bitmask != RFREG_OFFSET_MASK) {
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 2b9313cb93db..094cb36153f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -41,7 +41,7 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -68,7 +68,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = rtl8723_phy_rf_serial_read(hw, path,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index c07f5ab4c004..12986da63d4c 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -104,13 +104,12 @@ bool provides_xdp_headroom = true;
 module_param(provides_xdp_headroom, bool, 0644);
 
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status);
+			       s8 status);
 
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st);
-static void push_tx_responses(struct xenvif_queue *queue);
+			     s8 status);
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx);
 
@@ -208,13 +207,9 @@ static void xenvif_tx_err(struct xenvif_queue *queue,
 			  unsigned int extra_count, RING_IDX end)
 {
 	RING_IDX cons = queue->tx.req_cons;
-	unsigned long flags;
 
 	do {
-		spin_lock_irqsave(&queue->response_lock, flags);
 		make_tx_response(queue, txp, extra_count, XEN_NETIF_RSP_ERROR);
-		push_tx_responses(queue);
-		spin_unlock_irqrestore(&queue->response_lock, flags);
 		if (cons == end)
 			break;
 		RING_COPY_REQUEST(&queue->tx, cons++, txp);
@@ -465,12 +460,7 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
 	     nr_slots--) {
 		if (unlikely(!txp->size)) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&queue->response_lock, flags);
 			make_tx_response(queue, txp, 0, XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
-			spin_unlock_irqrestore(&queue->response_lock, flags);
 			++txp;
 			continue;
 		}
@@ -496,14 +486,8 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 
 		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots; ++txp) {
 			if (unlikely(!txp->size)) {
-				unsigned long flags;
-
-				spin_lock_irqsave(&queue->response_lock, flags);
 				make_tx_response(queue, txp, 0,
 						 XEN_NETIF_RSP_OKAY);
-				push_tx_responses(queue);
-				spin_unlock_irqrestore(&queue->response_lock,
-						       flags);
 				continue;
 			}
 
@@ -997,7 +981,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 					 (ret == 0) ?
 					 XEN_NETIF_RSP_OKAY :
 					 XEN_NETIF_RSP_ERROR);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1009,7 +992,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 
 			make_tx_response(queue, &txreq, extra_count,
 					 XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1445,8 +1427,35 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 	return work_done;
 }
 
+static void _make_tx_response(struct xenvif_queue *queue,
+			     const struct xen_netif_tx_request *txp,
+			     unsigned int extra_count,
+			     s8 status)
+{
+	RING_IDX i = queue->tx.rsp_prod_pvt;
+	struct xen_netif_tx_response *resp;
+
+	resp = RING_GET_RESPONSE(&queue->tx, i);
+	resp->id     = txp->id;
+	resp->status = status;
+
+	while (extra_count-- != 0)
+		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+
+	queue->tx.rsp_prod_pvt = ++i;
+}
+
+static void push_tx_responses(struct xenvif_queue *queue)
+{
+	int notify;
+
+	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
+	if (notify)
+		notify_remote_via_irq(queue->tx_irq);
+}
+
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status)
+			       s8 status)
 {
 	struct pending_tx_info *pending_tx_info;
 	pending_ring_idx_t index;
@@ -1456,8 +1465,8 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 
 	spin_lock_irqsave(&queue->response_lock, flags);
 
-	make_tx_response(queue, &pending_tx_info->req,
-			 pending_tx_info->extra_count, status);
+	_make_tx_response(queue, &pending_tx_info->req,
+			  pending_tx_info->extra_count, status);
 
 	/* Release the pending index before pusing the Tx response so
 	 * its available before a new Tx request is pushed by the
@@ -1471,32 +1480,19 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
-
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st)
+			     s8 status)
 {
-	RING_IDX i = queue->tx.rsp_prod_pvt;
-	struct xen_netif_tx_response *resp;
-
-	resp = RING_GET_RESPONSE(&queue->tx, i);
-	resp->id     = txp->id;
-	resp->status = st;
-
-	while (extra_count-- != 0)
-		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+	unsigned long flags;
 
-	queue->tx.rsp_prod_pvt = ++i;
-}
+	spin_lock_irqsave(&queue->response_lock, flags);
 
-static void push_tx_responses(struct xenvif_queue *queue)
-{
-	int notify;
+	_make_tx_response(queue, txp, extra_count, status);
+	push_tx_responses(queue);
 
-	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
-	if (notify)
-		notify_remote_via_irq(queue->tx_irq);
+	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index acf0d3110357..905ac6466a5b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1270,7 +1270,7 @@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
-DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 699daf0645d1..5a8d37cef0ba 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -49,6 +49,12 @@ static struct unittest_results {
 	failed; \
 })
 
+#ifdef CONFIG_OF_KOBJ
+#define OF_KREF_READ(NODE) kref_read(&(NODE)->kobj.kref)
+#else
+#define OF_KREF_READ(NODE) 1
+#endif
+
 /*
  * Expected message may have a message level other than KERN_INFO.
  * Print the expected message only if the current loglevel will allow
@@ -562,7 +568,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			pr_err("missing testcase data\n");
 			return;
 		}
-		prefs[i] = kref_read(&p[i]->kobj.kref);
+		prefs[i] = OF_KREF_READ(p[i]);
 	}
 
 	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
@@ -685,9 +691,9 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	for (i = 0; i < ARRAY_SIZE(p); ++i) {
-		unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
+		unittest(prefs[i] == OF_KREF_READ(p[i]),
 			 "provider%d: expected:%d got:%d\n",
-			 i, prefs[i], kref_read(&p[i]->kobj.kref));
+			 i, prefs[i], OF_KREF_READ(p[i]));
 		of_node_put(p[i]);
 	}
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 72280e9b23b2..2b5337980da7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -312,7 +312,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ca9ac8c6a202..4f7744aab6c7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -743,7 +743,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -931,7 +931,12 @@ static bool find_source_device(struct pci_dev *parent,
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
+		u8 bus = e_info->id >> 8;
+		u8 devfn = e_info->id & 0xff;
+
+		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
+			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 		return false;
 	}
 	return true;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 626d9ed733f1..fcdc17bbcc8e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -604,10 +604,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
-	/* Use "USB Device (not host controller)" class */
-	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
-		 class, pdev->class);
+	if (class != PCI_CLASS_SERIAL_USB_DEVICE) {
+		/* Use "USB Device (not host controller)" class */
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev,
+			"PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			class, pdev->class);
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_dwc_class);
@@ -3666,6 +3669,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d021ef3fb165..2a026183f06b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1250,13 +1250,6 @@ static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	if (stdev->dma_mrpc) {
-		iowrite32(0, &stdev->mmio_mrpc->dma_en);
-		flush_wc_buf(stdev);
-		writeq(0, &stdev->mmio_mrpc->dma_addr);
-		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
-				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
-	}
 	kfree(stdev);
 }
 
@@ -1300,7 +1293,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1334,6 +1327,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	return stdev;
 
 err_put:
+	pci_dev_put(stdev->pdev);
 	put_device(&stdev->dev);
 	return ERR_PTR(rc);
 }
@@ -1586,6 +1580,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static void switchtec_exit_pci(struct switchtec_dev *stdev)
+{
+	if (stdev->dma_mrpc) {
+		iowrite32(0, &stdev->mmio_mrpc->dma_en);
+		flush_wc_buf(stdev);
+		writeq(0, &stdev->mmio_mrpc->dma_addr);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+		stdev->dma_mrpc = NULL;
+	}
+}
+
 static int switchtec_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -1645,6 +1651,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
+	switchtec_exit_pci(stdev);
+	pci_dev_put(stdev->pdev);
+	stdev->pdev = NULL;
 	put_device(&stdev->dev);
 }
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 9de617ca9daa..7e61c6b278a7 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -675,8 +675,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
-		int ret;
-
 		channel->is_otg_channel = true;
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
 							"renesas,no-otg-pins");
@@ -740,8 +738,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		ret = PTR_ERR(provider);
 		goto error;
 	} else if (channel->is_otg_channel) {
-		int ret;
-
 		ret = device_create_file(dev, &dev_attr_role);
 		if (ret < 0)
 			goto error;
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index ca8532a3f193..59d3a692c725 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -116,7 +116,7 @@ static int omap_usb_set_vbus(struct usb_otg *otg, bool enabled)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->set_vbus)
 		return -ENODEV;
 
 	return phy->comparator->set_vbus(phy->comparator, enabled);
@@ -126,7 +126,7 @@ static int omap_usb_start_srp(struct usb_otg *otg)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->start_srp)
 		return -ENODEV;
 
 	return phy->comparator->start_srp(phy->comparator);
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed3..9879deb4dc0b 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -151,13 +151,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
-	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+	struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
-
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
+				    sizeof(range))) {
+		memcpy(&range, vendor->byte_data, sizeof(range));
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8ad50dc8fb35..9b1f27f87c95 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2881,7 +2881,8 @@ static int _regulator_enable(struct regulator *regulator)
 		/* Fallthrough on positive return values - already enabled */
 	}
 
-	rdev->use_count++;
+	if (regulator->enable_count == 1)
+		rdev->use_count++;
 
 	return 0;
 
@@ -2956,37 +2957,40 @@ static int _regulator_disable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (WARN(rdev->use_count <= 0,
+	if (WARN(regulator->enable_count == 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
 		return -EIO;
 
-	/* are we the last user and permitted to disable ? */
-	if (rdev->use_count == 1 &&
-	    (rdev->constraints && !rdev->constraints->always_on)) {
-
-		/* we are last user */
-		if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
-			ret = _notifier_call_chain(rdev,
-						   REGULATOR_EVENT_PRE_DISABLE,
-						   NULL);
-			if (ret & NOTIFY_STOP_MASK)
-				return -EINVAL;
-
-			ret = _regulator_do_disable(rdev);
-			if (ret < 0) {
-				rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
-				_notifier_call_chain(rdev,
-						REGULATOR_EVENT_ABORT_DISABLE,
+	if (regulator->enable_count == 1) {
+	/* disabling last enable_count from this regulator */
+		/* are we the last user and permitted to disable ? */
+		if (rdev->use_count == 1 &&
+		    (rdev->constraints && !rdev->constraints->always_on)) {
+
+			/* we are last user */
+			if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
+				ret = _notifier_call_chain(rdev,
+							   REGULATOR_EVENT_PRE_DISABLE,
+							   NULL);
+				if (ret & NOTIFY_STOP_MASK)
+					return -EINVAL;
+
+				ret = _regulator_do_disable(rdev);
+				if (ret < 0) {
+					rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
+					_notifier_call_chain(rdev,
+							REGULATOR_EVENT_ABORT_DISABLE,
+							NULL);
+					return ret;
+				}
+				_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
 						NULL);
-				return ret;
 			}
-			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
-					NULL);
-		}
 
-		rdev->use_count = 0;
-	} else if (rdev->use_count > 1) {
-		rdev->use_count--;
+			rdev->use_count = 0;
+		} else if (rdev->use_count > 1) {
+			rdev->use_count--;
+		}
 	}
 
 	if (ret == 0)
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index b03e7404212f..b863ebb9f6ec 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -377,6 +377,7 @@ static void virtio_rpmsg_release_device(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
+	kfree(rpdev->driver_override);
 	kfree(vch);
 }
 
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 00e2ca7374ec..178ee5563224 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -292,7 +292,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	/* Basic alarms only support hour, minute, and seconds fields.
 	 * Some also support day and month, for alarms up to a year in
@@ -557,7 +557,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
 	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 93f55c734802..83af6c6a9e21 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -254,9 +254,10 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		if (!recover) {
 			hash_del(&addr->hnode);
 			kfree(addr);
-			continue;
+		} else {
+			/* prepare for recovery */
+			addr->disp_flag = QETH_DISP_ADDR_ADD;
 		}
-		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
 	mutex_unlock(&card->ip_lock);
@@ -277,9 +278,11 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			rc = qeth_l3_register_addr_entry(card, addr);
 
-			if (!rc) {
+			if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
+				/* keep it in the records */
 				addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			} else {
+				/* bad address */
 				hash_del(&addr->hnode);
 				kfree(addr);
 			}
diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 6ce57f031df5..3324114e6b06 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -77,9 +77,13 @@ struct device_attribute;
 #ifndef PCI_DEVICE_ID_ARECA_1203
 #define PCI_DEVICE_ID_ARECA_1203	0x1203
 #endif
+#ifndef PCI_DEVICE_ID_ARECA_1883
+#define PCI_DEVICE_ID_ARECA_1883	0x1883
+#endif
 #ifndef PCI_DEVICE_ID_ARECA_1884
 #define PCI_DEVICE_ID_ARECA_1884	0x1884
 #endif
+#define PCI_DEVICE_ID_ARECA_1886_0	0x1886
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index ec1a834c922d..e33298b2d51c 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -214,8 +214,12 @@ static struct pci_device_id arcmsr_device_id_table[] = {
 		.driver_data = ACB_ADAPTER_TYPE_A},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1880),
 		.driver_data = ACB_ADAPTER_TYPE_C},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1883),
+		.driver_data = ACB_ADAPTER_TYPE_C},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1884),
 		.driver_data = ACB_ADAPTER_TYPE_E},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886_0),
+		.driver_data = ACB_ADAPTER_TYPE_F},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886),
 		.driver_data = ACB_ADAPTER_TYPE_F},
 	{0, 0}, /* Terminating entry */
@@ -4710,9 +4714,11 @@ static const char *arcmsr_info(struct Scsi_Host *host)
 	case PCI_DEVICE_ID_ARECA_1680:
 	case PCI_DEVICE_ID_ARECA_1681:
 	case PCI_DEVICE_ID_ARECA_1880:
+	case PCI_DEVICE_ID_ARECA_1883:
 	case PCI_DEVICE_ID_ARECA_1884:
 		type = "SAS/SATA";
 		break;
+	case PCI_DEVICE_ID_ARECA_1886_0:
 	case PCI_DEVICE_ID_ARECA_1886:
 		type = "NVMe/SAS/SATA";
 		break;
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 303ecbd86b68..558f3f4e1859 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,17 +319,16 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -700,7 +699,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -734,11 +732,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1715,11 +1713,10 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1730,7 +1727,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1747,9 +1744,8 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1776,7 +1772,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index fcaa84a3c210..6ef40993906a 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -3390,7 +3390,7 @@ static enum sci_status isci_io_request_build(struct isci_host *ihost,
 		return SCI_FAILURE;
 	}
 
-	return SCI_SUCCESS;
+	return status;
 }
 
 static struct isci_request *isci_request_from_tag(struct isci_host *ihost, u16 tag)
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 509eacd7893d..a6efbcc27181 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -270,6 +270,11 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
+	if (fsp->state & FC_SRB_ABORT_PENDING) {
+		FC_FCP_DBG(fsp, "abort already pending\n");
+		return -EBUSY;
+	}
+
 	per_cpu_ptr(fsp->lp->stats, get_cpu())->FcpPktAborts++;
 	put_cpu();
 
@@ -1681,7 +1686,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
@@ -1700,11 +1705,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
 	fsp->status_code = code;
 	fsp->cdb_status = 0;
 	fsp->io_status = 0;
-	/*
-	 * if this fails then we let the scsi command timer fire and
-	 * scsi-ml escalate.
-	 */
-	fc_fcp_send_abort(fsp);
+	if (!fsp->cmd)
+		/*
+		 * Only abort non-scsi commands; otherwise let the
+		 * scsi command timer fire and scsi-ml escalate.
+		 */
+		fc_fcp_send_abort(fsp);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 457ff86e02b3..65ac952b767f 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -32,6 +32,7 @@
 struct lpfc_sli2_slim;
 
 #define ELX_MODEL_NAME_SIZE	80
+#define ELX_FW_NAME_SIZE	84
 
 #define LPFC_PCI_DEV_LP		0x1
 #define LPFC_PCI_DEV_OC		0x2
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 2ca4cf1b58c4..bba51ce4276a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -14516,7 +14516,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 int
 lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 {
-	uint8_t file_name[ELX_MODEL_NAME_SIZE];
+	char file_name[ELX_FW_NAME_SIZE] = {0};
 	int ret;
 	const struct firmware *fw;
 
@@ -14525,7 +14525,7 @@ lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 	    LPFC_SLI_INTF_IF_TYPE_2)
 		return -EPERM;
 
-	snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
+	scnprintf(file_name, sizeof(file_name), "%s.grp", phba->ModelName);
 
 	if (fw_upgrade == INT_FW_UPGRADE) {
 		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f79cfd1cb3e7..2d5dc488f511 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -61,11 +61,11 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
 static enum scsi_disposition scsi_try_to_abort_cmd(struct scsi_host_template *,
 						   struct scsi_cmnd *);
 
-void scsi_eh_wakeup(struct Scsi_Host *shost)
+void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy)
 {
 	lockdep_assert_held(shost->host_lock);
 
-	if (scsi_host_busy(shost) == shost->host_failed) {
+	if (busy == shost->host_failed) {
 		trace_scsi_eh_wakeup(shost);
 		wake_up_process(shost->ehandler);
 		SCSI_LOG_ERROR_RECOVERY(5, shost_printk(KERN_INFO, shost,
@@ -88,7 +88,7 @@ void scsi_schedule_eh(struct Scsi_Host *shost)
 	if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
 	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0) {
 		shost->host_eh_scheduled++;
-		scsi_eh_wakeup(shost);
+		scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	}
 
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -276,11 +276,12 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
+	unsigned int busy = scsi_host_busy(shost);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost);
+	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3dbfd15e6fe7..0389bf281f4b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -281,9 +281,11 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
+		unsigned int busy = scsi_host_busy(shost);
+
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost);
+			scsi_eh_wakeup(shost, busy);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index b7f963149352..b650407690a8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -76,7 +76,7 @@ extern void scmd_eh_abort_handler(struct work_struct *work);
 extern enum blk_eh_timer_return scsi_times_out(struct request *req);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
-extern void scsi_eh_wakeup(struct Scsi_Host *shost);
+extern void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy);
 extern void scsi_eh_scmd_add(struct scsi_cmnd *);
 void scsi_eh_ready_devs(struct Scsi_Host *shost,
 			struct list_head *work_q,
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5caf7bd5877f..4ea119afd9db 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -367,6 +367,7 @@ enum storvsc_request_type {
  */
 
 static int storvsc_ringbuffer_size = (128 * 1024);
+static int aligned_ringbuffer_size;
 static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
@@ -737,8 +738,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	new_sc->next_request_id_callback = storvsc_next_request_id;
 
 	ret = vmbus_open(new_sc,
-			 storvsc_ringbuffer_size,
-			 storvsc_ringbuffer_size,
+			 aligned_ringbuffer_size,
+			 aligned_ringbuffer_size,
 			 (void *)&props,
 			 sizeof(struct vmstorage_channel_properties),
 			 storvsc_on_channel_callback, new_sc);
@@ -2033,7 +2034,7 @@ static int storvsc_probe(struct hv_device *device,
 	hv_set_drvdata(device, stor_device);
 
 	stor_device->port_number = host->host_no;
-	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
+	ret = storvsc_connect_to_vsp(device, aligned_ringbuffer_size, is_fc);
 	if (ret)
 		goto err_out1;
 
@@ -2226,7 +2227,7 @@ static int storvsc_resume(struct hv_device *hv_dev)
 {
 	int ret;
 
-	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
+	ret = storvsc_connect_to_vsp(hv_dev, aligned_ringbuffer_size,
 				     hv_dev_is_fc(hv_dev));
 	return ret;
 }
@@ -2264,8 +2265,9 @@ static int __init storvsc_drv_init(void)
 	 * for Win7 and older hosts because it does not take into account
 	 * the vmscsi_size_delta correction to the max request size.
 	 */
+	aligned_ringbuffer_size = VMBUS_RING_SIZE(storvsc_ringbuffer_size);
 	max_outstanding_req_per_channel =
-		((storvsc_ringbuffer_size - PAGE_SIZE) /
+		((aligned_ringbuffer_size - PAGE_SIZE) /
 		ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
 		sizeof(struct vstor_packet) + sizeof(u64),
 		sizeof(u64)));
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e78461f66400..03b33c34f702 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7896,7 +7896,6 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	ufs_bsg_probe(hba);
 	ufshpb_init(hba);
 	scsi_scan_host(hba->host);
-	pm_runtime_put_sync(hba->dev);
 
 out:
 	return ret;
@@ -8018,15 +8017,12 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 
 	/* Probe and add UFS logical units  */
 	ret = ufshcd_add_lus(hba);
+
 out:
-	/*
-	 * If we failed to initialize the device or the device is not
-	 * present, turn off the power/clocks etc.
-	 */
-	if (ret) {
-		pm_runtime_put_sync(hba->dev);
-		ufshcd_hba_exit(hba);
-	}
+	pm_runtime_put_sync(hba->dev);
+
+	if (ret)
+		dev_err(hba->dev, "%s failed: %d\n", __func__, ret);
 }
 
 static const struct attribute_group *ufshcd_driver_groups[] = {
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c79797c06cda..bca7ac570b94 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include "spi-bcm-qspi.h"
@@ -1049,7 +1049,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	/* non-aligned and very short transfers are handled by MSPI */
 	if (!IS_ALIGNED((uintptr_t)addr, 4) || !IS_ALIGNED((uintptr_t)buf, 4) ||
-	    len < 4)
+	    len < 4 || op->cmd.opcode == SPINOR_OP_RDSFDP)
 		mspi_read = true;
 
 	if (!has_bspi(qspi) || mspi_read)
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d65f047b6c82..1179a1115137 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -166,10 +166,8 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	int scr;
 	u8 cdm = 0;
 	u32 speed;
-	u8 bits_per_word;
 
 	/* Start with the generic configuration for this device. */
-	bits_per_word = spi->bits_per_word;
 	speed = spi->max_speed_hz;
 
 	/*
@@ -177,9 +175,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	 * the transfer to overwrite the generic configuration with zeros.
 	 */
 	if (t) {
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
 		if (t->speed_hz)
 			speed = min(t->speed_hz, spi->max_speed_hz);
 	}
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 1690358b8f01..810ed1fca10b 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -322,11 +322,11 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 }
 
-static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
+static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct fbtft_par *par = info->par;
 	unsigned int dirty_lines_start, dirty_lines_end;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	unsigned long index;
 	unsigned int y_low = 0, y_high = 0;
 	int count = 0;
@@ -340,7 +340,8 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
 	spin_unlock(&par->dirty_lock);
 
 	/* Mark display lines as dirty */
-	list_for_each_entry(page, pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *page = pageref->page;
 		count++;
 		index = page->index << PAGE_SHIFT;
 		y_low = index / info->fix.line_length;
@@ -653,9 +654,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
 	fbops->fb_blank     =      fbtft_fb_blank;
 
-	fbdefio->delay =           HZ / fps;
-	fbdefio->deferred_io =     fbtft_deferred_io;
-	fb_deferred_io_init(info);
+	fbdefio->delay =            HZ / fps;
+	fbdefio->sort_pagereflist = true;
+	fbdefio->deferred_io =      fbtft_deferred_io;
 
 	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
@@ -666,6 +667,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
+	fb_deferred_io_init(info);
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 793918e1c45f..b682d0f94b0b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -608,7 +608,7 @@ static void ad5933_work(struct work_struct *work)
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
 	__be16 buf[2];
-	int val[2];
+	u16 val[2];
 	unsigned char status;
 	int ret;
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 0b1976ceb01f..ada9666f5988 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -123,6 +123,7 @@ struct exar8250;
 
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	const struct serial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 	void (*unregister_gpio)(struct uart_8250_port *);
 };
@@ -441,10 +442,15 @@ static int generic_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static const struct serial_rs485 generic_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+};
+
 static const struct exar8250_platform exar8250_default_platform = {
 	.register_gpio = xr17v35x_register_gpio,
 	.unregister_gpio = xr17v35x_unregister_gpio,
 	.rs485_config = generic_rs485_config,
+	.rs485_supported = &generic_rs485_supported,
 };
 
 static int iot2040_rs485_config(struct uart_port *port,
@@ -480,6 +486,11 @@ static int iot2040_rs485_config(struct uart_port *port,
 	return generic_rs485_config(port, rs485);
 }
 
+static const struct serial_rs485 iot2040_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+};
+
 static const struct property_entry iot2040_gpio_properties[] = {
 	PROPERTY_ENTRY_U32("exar,first-pin", 10),
 	PROPERTY_ENTRY_U32("ngpios", 1),
@@ -508,6 +519,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 
 static const struct exar8250_platform iot2040_platform = {
 	.rs485_config = iot2040_rs485_config,
+	.rs485_supported = &iot2040_rs485_supported,
 	.register_gpio = iot2040_register_gpio,
 	.unregister_gpio = xr17v35x_unregister_gpio,
 };
@@ -550,6 +562,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 	port->port.uartclk = baud * 16;
 	port->port.rs485_config = platform->rs485_config;
+	port->port.rs485_supported = platform->rs485_supported;
 
 	/*
 	 * Setup the UART clock for the devices on expansion slot to
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3df0788ddeb0..5dd73d1da1ec 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -235,6 +235,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Crystal-related definitions */
+#define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
 
@@ -552,7 +556,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -610,12 +614,20 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 	/* Wait for crystal */
 	if (xtal) {
-		unsigned int val;
-		msleep(10);
-		regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
-		if (!(val & MAX310X_STS_CLKREADY_BIT)) {
-			dev_warn(dev, "clock is not stable yet\n");
-		}
+		bool stable = false;
+		unsigned int try = 0, val = 0;
+
+		do {
+			msleep(MAX310X_XTAL_WAIT_DELAY_MS);
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
+
+			if (val & MAX310X_STS_CLKREADY_BIT)
+				stable = true;
+		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
+
+		if (!stable)
+			return dev_err_probe(dev, -EAGAIN,
+					     "clock is not stable\n");
 	}
 
 	return bestfreq;
@@ -1255,7 +1267,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	u32 uartclk = 0;
+	s32 uartclk = 0;
 	bool xtal;
 
 	if (IS_ERR(regmap))
@@ -1335,6 +1347,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
+	if (uartclk < 0) {
+		ret = uartclk;
+		goto out_uart;
+	}
+
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	for (i = 0; i < devtype->nr; i++) {
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index dac1e2568803..224f13b98312 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -786,7 +786,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -803,7 +803,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios_1(&kterm,
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4bed41ca6b0f..2cd0089660ea 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -46,8 +46,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
@@ -2368,17 +2368,25 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 			}
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
-			/* Set a_alt_hnp_support for legacy otg device */
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_A_ALT_HNP_SUPPORT,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
-				dev_err(&udev->dev,
-					"set a_alt_hnp_support failed: %d\n",
-					err);
+			/*
+			 * We are operating on a legacy OTP device
+			 * These should be told that they are operating
+			 * on the wrong port if we have another port that does
+			 * support HNP
+			 */
+			if (bus->otg_port != 0) {
+				/* Set a_alt_hnp_support for legacy otg device */
+				err = usb_control_msg(udev,
+					usb_sndctrlpipe(udev, 0),
+					USB_REQ_SET_FEATURE, 0,
+					USB_DEVICE_A_ALT_HNP_SUPPORT,
+					0, NULL, 0,
+					USB_CTRL_SET_TIMEOUT);
+				if (err < 0)
+					dev_err(&udev->dev,
+						"set a_alt_hnp_support failed: %d\n",
+						err);
+			}
 		}
 	}
 #endif
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dcb5b744f7c..d64f7edc70c1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -722,6 +722,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_DELAY_STOP             BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 52f2bfae46bc..f402c66039af 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	return ret;
 }
 
-static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 
@@ -274,6 +274,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
 	int				ret;
+	int                             i;
 
 	complete(&dwc->ep0_in_setup);
 
@@ -282,6 +283,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
+	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dwc3_ep;
+
+		dwc3_ep = dwc->eps[i];
+		if (!dwc3_ep)
+			continue;
+
+		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
+			continue;
+
+		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
+		dwc3_stop_active_transfer(dwc3_ep, true, true);
+	}
 }
 
 static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
@@ -802,7 +816,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1076,13 +1090,18 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
 	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
 }
 
-static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
 	int			ret;
 
-	if (!dep->resource_index)
+	/*
+	 * For status/DATA OUT stage, TRB will be queued on ep0 out
+	 * endpoint for which resource index is zero. Hence allow
+	 * queuing ENDXFER command for ep0 out endpoint.
+	 */
+	if (!dep->resource_index && dep->number)
 		return;
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8ada601901cf..8e51db62a6f5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -139,6 +139,24 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	return -ETIMEDOUT;
 }
 
+static void dwc3_ep0_reset_state(struct dwc3 *dwc)
+{
+	unsigned int	dir;
+
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
+
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+}
+
 /**
  * dwc3_ep_inc_trb - increment a trb index.
  * @index: Pointer to the TRB index to increment.
@@ -641,9 +659,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-		bool interrupt);
-
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
@@ -872,12 +887,13 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+		dep->trb_dequeue = 0;
+		dep->trb_enqueue = 0;
+
 		if (usb_endpoint_xfer_control(desc))
 			goto out;
 
 		/* Initialize the TRB ring */
-		dep->trb_dequeue = 0;
-		dep->trb_enqueue = 0;
 		memset(dep->trb_pool, 0,
 		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 
@@ -1664,6 +1680,16 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	/*
+	 * If the End Transfer command was timed out while the device is
+	 * not in SETUP phase, it's possible that an incoming Setup packet
+	 * may prevent the command's completion. Let's retry when the
+	 * ep0state returns to EP0_SETUP_PHASE.
+	 */
+	if (ret == -ETIMEDOUT && dep->dwc->ep0state != EP0_SETUP_PHASE) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return 0;
+	}
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
@@ -1675,6 +1701,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 	}
 
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
 }
 
@@ -1891,6 +1918,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 */
 	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
 	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_STALL)) {
 		dep->flags |= DWC3_EP_DELAY_START;
 		return 0;
@@ -2022,7 +2050,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}
@@ -2114,7 +2152,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
-		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
+		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
 			return 0;
 		}
@@ -2459,10 +2498,18 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
 static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->connected = false;
 
+	/*
+	 * Attempt to end pending SETUP status phase, and not wait for the
+	 * function to do so.
+	 */
+	if (dwc->delayed_status)
+		dwc3_ep0_send_delayed_status(dwc);
+
 	/*
 	 * In the Synopsys DesignWare Cores USB3 Databook Rev. 3.30a
 	 * Section 4.1.8 Table 4-7, it states that for a device-initiated
@@ -2471,9 +2518,28 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * bit.
 	 */
 	dwc3_stop_active_transfers(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	/*
+	 * Per databook, when we want to stop the gadget, if a control transfer
+	 * is still in process, complete it and get the core into setup phase.
+	 * In case the host is unresponsive to a SETUP transaction, forcefully
+	 * stall the transfer, and move back to the SETUP phase, so that any
+	 * pending endxfers can be executed.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		reinit_completion(&dwc->ep0_in_setup);
+
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		if (ret == 0) {
+			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_ep0_reset_state(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+	}
+
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
 	 * driver needs to acknowledge them before the controller can halt.
@@ -2481,7 +2547,19 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false);
+	ret = dwc3_gadget_run_stop(dwc, false);
+
+	/*
+	 * Stop the gadget after controller is halted, so that if needed, the
+	 * events to update EP0 state can still occur while the run/stop
+	 * routine polls for the halted state.  DEVTEN is cleared as part of
+	 * gadget stop.
+	 */
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
 }
 
 static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
@@ -2507,18 +2585,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	is_on = !!is_on;
 
 	dwc->softconnect = is_on;
-	/*
-	 * Per databook, when we want to stop the gadget, if a control transfer
-	 * is still in process, complete it and get the core into setup phase.
-	 */
-	if (!is_on && dwc->ep0state != EP0_SETUP_PHASE) {
-		reinit_completion(&dwc->ep0_in_setup);
-
-		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
-				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0)
-			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
-	}
 
 	/*
 	 * Avoid issuing a runtime resume if the device is already in the
@@ -2698,6 +2764,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->ep0_bounced = false;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
@@ -3630,13 +3697,39 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
+
+	/*
+	 * Only issue End Transfer command to the control endpoint of a started
+	 * Data Phase. Typically we should only do so in error cases such as
+	 * invalid/unexpected direction as described in the control transfer
+	 * flow of the programming guide.
+	 */
+	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
+		return;
+
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
+	/*
+	 * If a Setup packet is received but yet to DMA out, the controller will
+	 * not process the End Transfer command of any endpoint. Polling of its
+	 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+	 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+	 * prepared.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return;
+	}
+
 	/*
 	 * NOTICE: We are violating what the Databook says about the
 	 * EndTransfer command. Ideally we would _always_ wait for the
@@ -3706,13 +3799,22 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_INITU2ENA;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
+	dwc->connected = false;
+
 	dwc3_disconnect_gadget(dwc);
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
-	dwc->connected = false;
+	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -3762,6 +3864,14 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+
+	/*
+	 * From SNPS databook section 8.1.2, the EP0 should be in setup
+	 * phase. So ensure that EP0 is in setup phase by issuing a stall
+	 * and restart if EP0 is not in setup phase.
+	 */
+	dwc3_ep0_reset_state(dwc);
+
 	/*
 	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
 	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
@@ -4412,15 +4522,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 77df4b6d6c13..55a56cf67d73 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -110,12 +110,15 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event);
 void dwc3_ep0_out_start(struct dwc3 *dwc);
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 2078e9d70292..012b54cb847f 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -44,7 +44,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[4];
+	struct property_entry	props[5];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	struct resource		*res;
@@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
+
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 5bd76c6d38e7..f602eee451a3 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -543,21 +543,37 @@ static int start_transfer(struct fsg_dev *fsg, struct usb_ep *ep,
 
 static bool start_in_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_SENDING;
-	if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq);
+	if (rc) {
 		bh->state = BUF_STATE_EMPTY;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
 static bool start_out_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_RECEIVING;
-	if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq);
+	if (rc) {
 		bh->state = BUF_STATE_FULL;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index e56a1fb9715a..83c7dffa945c 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -323,6 +323,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
+			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index b3f128bd4718..f47c2f392292 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -146,6 +146,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
+	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
 	{ USB_DEVICE(0x10C4, 0x8856) },	/* CEL EM357 ZigBee USB Stick - LR */
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4adef9259870..c0a0cca65437 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2269,6 +2269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index b1e844bf31f8..703a9c563557 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -184,6 +184,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
 	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
+	{DEVICE_SWI(0x413c, 0x8217)},	/* Dell Wireless DW5826e */
+	{DEVICE_SWI(0x413c, 0x8218)},	/* Dell Wireless DW5826e QDL */
 
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 04976435ad73..0c88d5bf09ca 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -70,9 +70,13 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &ua->flags);
+	else
+		set_bit(COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -82,7 +86,10 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &ua->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -106,8 +113,10 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &ua->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
+		complete(&ua->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bc14f1245a65..99cdd59f4e0c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2582,12 +2582,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 /* Create a new message. */
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
+	/* Make sure all padding within the structure is initialized. */
+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-	/* Make sure all padding within the structure is initialized. */
-	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index fd66f4d4a621..8b953d20ccdc 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -929,13 +929,11 @@ static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
 }
 
 /* this is called back from the deferred io workqueue */
-static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void broadsheetfb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	u16 y1 = 0, h = 0;
 	int prev_index = -1;
-	struct page *cur;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_pageref *pageref;
 	int h_inc;
 	u16 yres = info->var.yres;
 	u16 xres = info->var.xres;
@@ -944,7 +942,8 @@ static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
 	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
 
 	/* walk the written page list and swizzle the data */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *cur = pageref->page;
 		if (prev_index < 0) {
 			/* just starting so assign first page */
 			y1 = (cur->index << PAGE_SHIFT) / xres;
@@ -1058,8 +1057,9 @@ static const struct fb_ops broadsheetfb_ops = {
 };
 
 static struct fb_deferred_io broadsheetfb_defio = {
-	.delay		= HZ/4,
-	.deferred_io	= broadsheetfb_dpy_deferred_io,
+	.delay			= HZ/4,
+	.sort_pagereflist	= true,
+	.deferred_io		= broadsheetfb_dpy_deferred_io,
 };
 
 static int broadsheetfb_probe(struct platform_device *dev)
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 0708e214c5a3..1f12c2043603 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -36,6 +36,60 @@ static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs
 	return page;
 }
 
+static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info *info,
+								 unsigned long offset,
+								 struct page *page)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct list_head *pos = &fbdefio->pagereflist;
+	unsigned long pgoff = offset >> PAGE_SHIFT;
+	struct fb_deferred_io_pageref *pageref, *cur;
+
+	if (WARN_ON_ONCE(pgoff >= info->npagerefs))
+		return NULL; /* incorrect allocation size */
+
+	/* 1:1 mapping between pageref and page offset */
+	pageref = &info->pagerefs[pgoff];
+
+	/*
+	 * This check is to catch the case where a new process could start
+	 * writing to the same page through a new PTE. This new access
+	 * can cause a call to .page_mkwrite even if the original process'
+	 * PTE is marked writable.
+	 */
+	if (!list_empty(&pageref->list))
+		goto pageref_already_added;
+
+	pageref->page = page;
+	pageref->offset = pgoff << PAGE_SHIFT;
+
+	if (unlikely(fbdefio->sort_pagereflist)) {
+		/*
+		 * We loop through the list of pagerefs before adding in
+		 * order to keep the pagerefs sorted. This has significant
+		 * overhead of O(n^2) with n being the number of written
+		 * pages. If possible, drivers should try to work with
+		 * unsorted page lists instead.
+		 */
+		list_for_each_entry(cur, &fbdefio->pagereflist, list) {
+			if (cur->offset > pageref->offset)
+				break;
+		}
+		pos = &cur->list;
+	}
+
+	list_add_tail(&pageref->list, pos);
+
+pageref_already_added:
+	return pageref;
+}
+
+static void fb_deferred_io_pageref_put(struct fb_deferred_io_pageref *pageref,
+				       struct fb_info *info)
+{
+	list_del_init(&pageref->list);
+}
+
 /* this is to find and return the vmalloc-ed fb pages */
 static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 {
@@ -59,7 +113,7 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 		printk(KERN_ERR "no mapping available\n");
 
 	BUG_ON(!page->mapping);
-	page->index = vmf->pgoff;
+	page->index = vmf->pgoff; /* for page_mkclean() */
 
 	vmf->page = page;
 	return 0;
@@ -91,7 +145,11 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct fb_info *info = vmf->vma->vm_private_data;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
-	struct page *cur;
+	struct fb_deferred_io_pageref *pageref;
+	unsigned long offset;
+	vm_fault_t ret;
+
+	offset = (vmf->address - vmf->vma->vm_start);
 
 	/* this is a callback we get when userspace first tries to
 	write to the page. we schedule a workqueue. that workqueue
@@ -105,9 +163,15 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	mutex_lock(&fbdefio->lock);
 
 	/* first write in this cycle, notify the driver */
-	if (fbdefio->first_io && list_empty(&fbdefio->pagelist))
+	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
 		fbdefio->first_io(info);
 
+	pageref = fb_deferred_io_pageref_get(info, offset, page);
+	if (WARN_ON_ONCE(!pageref)) {
+		ret = VM_FAULT_OOM;
+		goto err_mutex_unlock;
+	}
+
 	/*
 	 * We want the page to remain locked from ->page_mkwrite until
 	 * the PTE is marked dirty to avoid page_mkclean() being called
@@ -116,30 +180,17 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	 * Do this by locking the page here and informing the caller
 	 * about it with VM_FAULT_LOCKED.
 	 */
-	lock_page(page);
-
-	/* we loop through the pagelist before adding in order
-	to keep the pagelist sorted */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		/* this check is to catch the case where a new
-		process could start writing to the same page
-		through a new pte. this new access can cause the
-		mkwrite even when the original ps's pte is marked
-		writable */
-		if (unlikely(cur == page))
-			goto page_already_added;
-		else if (cur->index > page->index)
-			break;
-	}
+	lock_page(pageref->page);
 
-	list_add_tail(&page->lru, &cur->lru);
-
-page_already_added:
 	mutex_unlock(&fbdefio->lock);
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 	return VM_FAULT_LOCKED;
+
+err_mutex_unlock:
+	mutex_unlock(&fbdefio->lock);
+	return ret;
 }
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
@@ -171,40 +222,65 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 /* workqueue callback */
 static void fb_deferred_io_work(struct work_struct *work)
 {
-	struct fb_info *info = container_of(work, struct fb_info,
-						deferred_work.work);
-	struct list_head *node, *next;
-	struct page *cur;
+	struct fb_info *info = container_of(work, struct fb_info, deferred_work.work);
+	struct fb_deferred_io_pageref *pageref, *next;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 
 	/* here we mkclean the pages, then do all deferred IO */
 	mutex_lock(&fbdefio->lock);
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
+		struct page *cur = pageref->page;
 		lock_page(cur);
 		page_mkclean(cur);
 		unlock_page(cur);
 	}
 
-	/* driver's callback with pagelist */
-	fbdefio->deferred_io(info, &fbdefio->pagelist);
+	/* driver's callback with pagereflist */
+	fbdefio->deferred_io(info, &fbdefio->pagereflist);
 
 	/* clear the list */
-	list_for_each_safe(node, next, &fbdefio->pagelist) {
-		list_del(node);
-	}
+	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
+		fb_deferred_io_pageref_put(pageref, info);
+
 	mutex_unlock(&fbdefio->lock);
 }
 
-void fb_deferred_io_init(struct fb_info *info)
+int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_pageref *pagerefs;
+	unsigned long npagerefs, i;
+	int ret;
 
 	BUG_ON(!fbdefio);
+
+	if (WARN_ON(!info->fix.smem_len))
+		return -EINVAL;
+
 	mutex_init(&fbdefio->lock);
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
-	INIT_LIST_HEAD(&fbdefio->pagelist);
+	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
+
+	npagerefs = DIV_ROUND_UP(info->fix.smem_len, PAGE_SIZE);
+
+	/* alloc a page ref for each page of the display memory */
+	pagerefs = kvcalloc(npagerefs, sizeof(*pagerefs), GFP_KERNEL);
+	if (!pagerefs) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	for (i = 0; i < npagerefs; ++i)
+		INIT_LIST_HEAD(&pagerefs[i].list);
+	info->npagerefs = npagerefs;
+	info->pagerefs = pagerefs;
+
+	return 0;
+
+err:
+	mutex_destroy(&fbdefio->lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
 
@@ -212,25 +288,43 @@ void fb_deferred_io_open(struct fb_info *info,
 			 struct inode *inode,
 			 struct file *file)
 {
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
 	file->f_mapping->a_ops = &fb_deferred_io_aops;
+	fbdefio->open_count++;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
-void fb_deferred_io_cleanup(struct fb_info *info)
+static void fb_deferred_io_lastclose(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *page;
 	int i;
 
-	BUG_ON(!fbdefio);
-	cancel_delayed_work_sync(&info->deferred_work);
+	flush_delayed_work(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
 	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
 		page = fb_deferred_io_page(info, i);
 		page->mapping = NULL;
 	}
+}
+
+void fb_deferred_io_release(struct fb_info *info)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	if (!--fbdefio->open_count)
+		fb_deferred_io_lastclose(info);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_release);
+
+void fb_deferred_io_cleanup(struct fb_info *info)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	fb_deferred_io_lastclose(info);
 
+	kvfree(info->pagerefs);
 	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1b288a613a6e..ec7a883715e3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1454,6 +1454,10 @@ __releases(&info->lock)
 	struct fb_info * const info = file->private_data;
 
 	lock_fb_info(info);
+#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
+	if (info->fbdefio)
+		fb_deferred_io_release(info);
+#endif
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 00d77105161a..bd6b0dec414b 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -115,8 +115,7 @@ static void hecubafb_dpy_update(struct hecubafb_par *par)
 }
 
 /* this is called back from the deferred io workqueue */
-static void hecubafb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void hecubafb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	hecubafb_dpy_update(info->par);
 }
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index de865e197c8d..6a881cfd7f5c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -420,11 +420,10 @@ static void hvfb_docopy(struct hvfb_par *par,
 }
 
 /* Deferred IO callback */
-static void synthvid_deferred_io(struct fb_info *p,
-				 struct list_head *pagelist)
+static void synthvid_deferred_io(struct fb_info *p, struct list_head *pagereflist)
 {
 	struct hvfb_par *par = p->par;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	unsigned long start, end;
 	int y1, y2, miny, maxy;
 
@@ -437,7 +436,8 @@ static void synthvid_deferred_io(struct fb_info *p,
 	 * in synthvid_update function by clamping the y2
 	 * value to yres.
 	 */
-	list_for_each_entry(page, pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *page = pageref->page;
 		start = page->index << PAGE_SHIFT;
 		end = start + PAGE_SIZE - 1;
 		y1 = start / p->fix.line_length;
diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 952826557a0c..b8df0bb7cabc 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -465,16 +465,15 @@ static u16 metronomefb_dpy_update_page(struct metronomefb_par *par, int index)
 }
 
 /* this is called back from the deferred io workqueue */
-static void metronomefb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void metronomefb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	u16 cksum;
-	struct page *cur;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_pageref *pageref;
 	struct metronomefb_par *par = info->par;
 
 	/* walk the written page list and swizzle the data */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *cur = pageref->page;
 		cksum = metronomefb_dpy_update_page(par,
 					(cur->index << PAGE_SHIFT));
 		par->metromem_img_csum -= par->csum_table[cur->index];
@@ -567,8 +566,9 @@ static const struct fb_ops metronomefb_ops = {
 };
 
 static struct fb_deferred_io metronomefb_defio = {
-	.delay		= HZ,
-	.deferred_io	= metronomefb_dpy_deferred_io,
+	.delay			= HZ,
+	.sort_pagereflist	= true,
+	.deferred_io		= metronomefb_dpy_deferred_io,
 };
 
 static int metronomefb_probe(struct platform_device *dev)
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index aa4ebe3192ec..e33c016c5428 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -435,24 +435,24 @@ static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
 	.read_data	= lcdc_sys_read_data,
 };
 
-static int sh_mobile_lcdc_sginit(struct fb_info *info,
-				  struct list_head *pagelist)
+static int sh_mobile_lcdc_sginit(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	unsigned int nr_pages_max = ch->fb_size >> PAGE_SHIFT;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	int nr_pages = 0;
 
 	sg_init_table(ch->sglist, nr_pages_max);
 
-	list_for_each_entry(page, pagelist, lru)
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *page = pageref->page;
 		sg_set_page(&ch->sglist[nr_pages++], page, PAGE_SIZE, 0);
+	}
 
 	return nr_pages;
 }
 
-static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
-				       struct list_head *pagelist)
+static void sh_mobile_lcdc_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	const struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg->panel_cfg;
@@ -461,7 +461,7 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 	sh_mobile_lcdc_clk_on(ch->lcdc);
 
 	/*
-	 * It's possible to get here without anything on the pagelist via
+	 * It's possible to get here without anything on the pagereflist via
 	 * sh_mobile_lcdc_deferred_io_touch() or via a userspace fsync()
 	 * invocation. In the former case, the acceleration routines are
 	 * stepped in to when using the framebuffer console causing the
@@ -471,12 +471,12 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 	 * acceleration routines have their own methods for writing in
 	 * that still need to be updated.
 	 *
-	 * The fsync() and empty pagelist case could be optimized for,
+	 * The fsync() and empty pagereflist case could be optimized for,
 	 * but we don't bother, as any application exhibiting such
 	 * behaviour is fundamentally broken anyways.
 	 */
-	if (!list_empty(pagelist)) {
-		unsigned int nr_pages = sh_mobile_lcdc_sginit(info, pagelist);
+	if (!list_empty(pagereflist)) {
+		unsigned int nr_pages = sh_mobile_lcdc_sginit(info, pagereflist);
 
 		/* trigger panel update */
 		dma_map_sg(ch->lcdc->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index b3295cd7fd4f..14e4e106d26b 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -953,12 +953,10 @@ static void ufx_ops_fillrect(struct fb_info *info,
  *   Touching ANY framebuffer memory that triggers a page fault
  *   in fb_defio will cause a deadlock, when it also tries to
  *   grab the same mutex. */
-static void ufx_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void ufx_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
-	struct page *cur;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct ufx_data *dev = info->par;
+	struct fb_deferred_io_pageref *pageref;
 
 	if (!fb_defio)
 		return;
@@ -967,9 +965,10 @@ static void ufx_dpy_deferred_io(struct fb_info *info,
 		return;
 
 	/* walk the written page list and render each to device */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
 		/* create a rectangle of full screen width that encloses the
 		 * entire dirty framebuffer page */
+		struct page *cur = pageref->page;
 		const int x = 0;
 		const int width = dev->info->var.xres;
 		const int y = (cur->index << PAGE_SHIFT) / (width * 2);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1e2f71c2f8a8..7acf7c0b263e 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -370,8 +370,7 @@ static const struct fb_ops ssd1307fb_ops = {
 	.fb_imageblit	= ssd1307fb_imageblit,
 };
 
-static void ssd1307fb_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void ssd1307fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	ssd1307fb_update_display(info->par);
 }
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 0de7b867714a..12bd5a7318e1 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -780,11 +780,9 @@ static void dlfb_ops_fillrect(struct fb_info *info,
  *   in fb_defio will cause a deadlock, when it also tries to
  *   grab the same mutex.
  */
-static void dlfb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void dlfb_dpy_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
-	struct page *cur;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_pageref *pageref;
 	struct dlfb_data *dlfb = info->par;
 	struct urb *urb;
 	char *cmd;
@@ -810,7 +808,8 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	cmd = urb->transfer_buffer;
 
 	/* walk the written page list and render each to device */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *cur = pageref->page;
 
 		if (dlfb_render_hline(dlfb, &urb, (char *) info->fix.smem_start,
 				  &cmd, cur->index << PAGE_SHIFT,
@@ -982,6 +981,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 
 		if (fbdefio) {
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;
+			fbdefio->sort_pagereflist = true;
 			fbdefio->deferred_io = dlfb_dpy_deferred_io;
 		}
 
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 5ec51445bee8..37e3f226f78c 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -181,17 +181,17 @@ static void xenfb_refresh(struct xenfb_info *info,
 		xenfb_do_update(info, x1, y1, x2 - x1 + 1, y2 - y1 + 1);
 }
 
-static void xenfb_deferred_io(struct fb_info *fb_info,
-			      struct list_head *pagelist)
+static void xenfb_deferred_io(struct fb_info *fb_info, struct list_head *pagereflist)
 {
 	struct xenfb_info *info = fb_info->par;
-	struct page *page;
+	struct fb_deferred_io_pageref *pageref;
 	unsigned long beg, end;
 	int y1, y2, miny, maxy;
 
 	miny = INT_MAX;
 	maxy = 0;
-	list_for_each_entry(page, pagelist, lru) {
+	list_for_each_entry(pageref, pagereflist, list) {
+		struct page *page = pageref->page;
 		beg = page->index << PAGE_SHIFT;
 		end = beg + PAGE_SIZE - 1;
 		y1 = beg / fb_info->fix.line_length;
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index bb1122909396..843f9f8e3917 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -255,6 +255,7 @@ static struct watchdog_device wdt_dev = {
 static int __init it87_wdt_init(void)
 {
 	u8  chip_rev;
+	u8 ctrl;
 	int rc;
 
 	rc = superio_enter();
@@ -313,7 +314,18 @@ static int __init it87_wdt_init(void)
 
 	superio_select(GPIO);
 	superio_outb(WDT_TOV1, WDTCFG);
-	superio_outb(0x00, WDTCTRL);
+
+	switch (chip_type) {
+	case IT8784_ID:
+	case IT8786_ID:
+		ctrl = superio_inb(WDTCTRL);
+		ctrl &= 0x08;
+		superio_outb(ctrl, WDTCTRL);
+		break;
+	default:
+		superio_outb(0x00, WDTCTRL);
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 4c13cbc99896..398ea69c176c 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-direct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -56,7 +57,7 @@ struct gntdev_dmabuf {
 
 	/* Number of pages this buffer has. */
 	int nr_pages;
-	/* Pages of this buffer. */
+	/* Pages of this buffer (only for dma-buf export). */
 	struct page **pages;
 };
 
@@ -490,7 +491,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 /* DMA buffer import support. */
 
 static int
-dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
+dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
 				int count, int domid)
 {
 	grant_ref_t priv_gref_head;
@@ -513,7 +514,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
 		}
 
 		gnttab_grant_foreign_access_ref(cur_ref, domid,
-						xen_page_to_gfn(pages[i]), 0);
+						gfns[i], 0);
 		refs[i] = cur_ref;
 	}
 
@@ -535,7 +536,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
 
 static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
 {
-	kfree(gntdev_dmabuf->pages);
 	kfree(gntdev_dmabuf->u.imp.refs);
 	kfree(gntdev_dmabuf);
 }
@@ -555,12 +555,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 	if (!gntdev_dmabuf->u.imp.refs)
 		goto fail;
 
-	gntdev_dmabuf->pages = kcalloc(count,
-				       sizeof(gntdev_dmabuf->pages[0]),
-				       GFP_KERNEL);
-	if (!gntdev_dmabuf->pages)
-		goto fail;
-
 	gntdev_dmabuf->nr_pages = count;
 
 	for (i = 0; i < count; i++)
@@ -582,7 +576,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 	struct dma_buf *dma_buf;
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
-	struct sg_page_iter sg_iter;
+	struct sg_dma_page_iter sg_iter;
+	unsigned long *gfns;
 	int i;
 
 	dma_buf = dma_buf_get(fd);
@@ -630,26 +625,31 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.sgt = sgt;
 
-	/* Now convert sgt to array of pages and check for page validity. */
+	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
+	if (!gfns) {
+		ret = ERR_PTR(-ENOMEM);
+		goto fail_unmap;
+	}
+
+	/*
+	 * Now convert sgt to array of gfns without accessing underlying pages.
+	 * It is not allowed to access the underlying struct page of an sg table
+	 * exported by DMA-buf, but since we deal with special Xen dma device here
+	 * (not a normal physical one) look at the dma addresses in the sg table
+	 * and then calculate gfns directly from them.
+	 */
 	i = 0;
-	for_each_sgtable_page(sgt, &sg_iter, 0) {
-		struct page *page = sg_page_iter_page(&sg_iter);
-		/*
-		 * Check if page is valid: this can happen if we are given
-		 * a page from VRAM or other resources which are not backed
-		 * by a struct page.
-		 */
-		if (!pfn_valid(page_to_pfn(page))) {
-			ret = ERR_PTR(-EINVAL);
-			goto fail_unmap;
-		}
+	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
+		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
 
-		gntdev_dmabuf->pages[i++] = page;
+		gfns[i++] = pfn_to_gfn(pfn);
 	}
 
-	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
+	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
 						      gntdev_dmabuf->u.imp.refs,
 						      count, domid));
+	kfree(gfns);
 	if (IS_ERR(ret))
 		goto fail_end_access;
 
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 1b4d5809808d..e0f5dcffe4e3 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -110,13 +110,14 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 0;
+	int seq = 1;
 
 	do {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&cell->volume_lock, &seq);
 
 		p = rcu_dereference_raw(cell->volumes.rb_node);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index cec18f9f8bd7..106426de5027 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -492,6 +492,14 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
+		/* Don't expose silly rename entries to userspace. */
+		if (nlen > 6 &&
+		    dire->u.name[0] == '.' &&
+		    ctx->actor != afs_lookup_filldir &&
+		    ctx->actor != afs_lookup_one_filldir &&
+		    memcmp(dire->u.name, ".__afs", 6) == 0)
+			continue;
+
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
diff --git a/fs/afs/server.c b/fs/afs/server.c
index ffed828622b6..34b47218129e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -27,7 +27,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 1, diff;
 
 	rcu_read_lock();
 
@@ -35,6 +35,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		if (srx->transport.family == AF_INET6) {
@@ -90,7 +91,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq = 1;
 
 	_enter("%pU", uuid);
 
@@ -102,7 +103,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		if (server)
 			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
-
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
 
 		p = net->fs_servers.rb_node;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1467bf439cb4..17ebcf19b444 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -282,6 +282,26 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
 
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Extent tree v2 supported only with CONFIG_BTRFS_DEBUG
+ */
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+#else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
 	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
@@ -296,6 +316,7 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED)
+#endif
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
@@ -1361,6 +1382,7 @@ struct btrfs_drop_extents_args {
 
 struct btrfs_file_private {
 	void *filldir_buf;
+	u64 last_index;
 };
 
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fd951aeaeac5..5a98c5da1225 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1513,6 +1513,7 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
 }
 
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list)
 {
@@ -1532,14 +1533,14 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
-	while (item) {
+	while (item && item->key.offset <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, ins_list);
 		item = __btrfs_next_delayed_item(item);
 	}
 
 	item = __btrfs_first_delayed_deletion_item(delayed_node);
-	while (item) {
+	while (item && item->key.offset <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, del_list);
 		item = __btrfs_next_delayed_item(item);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index b2412160c5bc..a9cfce856d2e 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -123,6 +123,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info);
 
 /* Used for readdir() */
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
 void btrfs_readdir_put_delayed_items(struct inode *inode,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f0654fe80b34..9ae7c12668cd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1619,8 +1619,17 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-		/* Shouldn't get preallocated anon_dev for cached roots */
-		ASSERT(!anon_dev);
+		/*
+		 * Some other caller may have read out the newly inserted
+		 * subvolume already (for things like backref walk etc).  Not
+		 * that common but still possible.  In that case, we just need
+		 * to free the anon_dev.
+		 */
+		if (unlikely(anon_dev)) {
+			free_anon_bdev(anon_dev);
+			anon_dev = 0;
+		}
+
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a19bdb359740..24cbddc0b36f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1206,7 +1206,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	u64 bytes_left, end;
 	u64 aligned_start = ALIGN(start, 1 << 9);
 
-	if (WARN_ON(start != aligned_start)) {
+	/* Adjust the range to be aligned to 512B sectors if necessary. */
+	if (start != aligned_start) {
 		len -= aligned_start - start;
 		len = round_down(len, 1 << 9);
 		start = aligned_start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 95af29634e55..c7d8a18daaf5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4501,6 +4501,8 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	u64 root_flags;
 	int ret;
 
+	down_write(&fs_info->subvol_sem);
+
 	/*
 	 * Don't allow to delete a subvolume with send in progress. This is
 	 * inside the inode lock so the error handling that has to drop the bit
@@ -4512,25 +4514,25 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu during send",
 			   dest->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	if (atomic_read(&dest->nr_swapfiles)) {
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
 			   root->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	root_flags = btrfs_root_flags(&dest->root_item);
 	btrfs_set_root_flags(&dest->root_item,
 			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
 	spin_unlock(&dest->root_item_lock);
 
-	down_write(&fs_info->subvol_sem);
-
 	ret = may_destroy_subvol(dest);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
@@ -4540,7 +4542,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
@@ -4606,15 +4608,17 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
-out_up_write:
-	up_write(&fs_info->subvol_sem);
+out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
 		root_flags = btrfs_root_flags(&dest->root_item);
 		btrfs_set_root_flags(&dest->root_item,
 				root_flags & ~BTRFS_ROOT_SUBVOL_DEAD);
 		spin_unlock(&dest->root_item_lock);
-	} else {
+	}
+out_up_write:
+	up_write(&fs_info->subvol_sem);
+	if (!ret) {
 		d_invalidate(dentry);
 		btrfs_prune_dentries(dest);
 		ASSERT(dest->send_in_progress == 0);
@@ -6121,6 +6125,78 @@ static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+/*
+ * Find the highest existing sequence number in a directory and then set the
+ * in-memory index_cnt variable to the first free sequence number.
+ */
+static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_key key, found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid = btrfs_ino(inode);
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = (u64)-1;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	/* FIXME: we should be able to handle this */
+	if (ret == 0)
+		goto out;
+	ret = 0;
+
+	if (path->slots[0] == 0) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	path->slots[0]--;
+
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.objectid != btrfs_ino(inode) ||
+	    found_key.type != BTRFS_DIR_INDEX_KEY) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	inode->index_cnt = found_key.offset + 1;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
+{
+	int ret = 0;
+
+	btrfs_inode_lock(&dir->vfs_inode, 0);
+	if (dir->index_cnt == (u64)-1) {
+		ret = btrfs_inode_delayed_dir_index_count(dir);
+		if (ret) {
+			ret = btrfs_set_inode_index_count(dir);
+			if (ret)
+				goto out;
+		}
+	}
+
+	/* index_cnt is the index number of next new entry, so decrement it. */
+	*index = dir->index_cnt - 1;
+out:
+	btrfs_inode_unlock(&dir->vfs_inode, 0);
+
+	return ret;
+}
+
 /*
  * All this infrastructure exists because dir_emit can fault, and we are holding
  * the tree lock when doing readdir.  For now just allocate a buffer and copy
@@ -6133,10 +6209,17 @@ static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
 static int btrfs_opendir(struct inode *inode, struct file *file)
 {
 	struct btrfs_file_private *private;
+	u64 last_index;
+	int ret;
+
+	ret = btrfs_get_dir_last_index(BTRFS_I(inode), &last_index);
+	if (ret)
+		return ret;
 
 	private = kzalloc(sizeof(struct btrfs_file_private), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
+	private->last_index = last_index;
 	private->filldir_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!private->filldir_buf) {
 		kfree(private);
@@ -6146,6 +6229,19 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static loff_t btrfs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct btrfs_file_private *private = file->private_data;
+	int ret;
+
+	ret = btrfs_get_dir_last_index(BTRFS_I(file_inode(file)),
+				       &private->last_index);
+	if (ret)
+		return ret;
+
+	return generic_file_llseek(file, offset, whence);
+}
+
 struct dir_entry {
 	u64 ino;
 	u64 offset;
@@ -6205,7 +6301,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 
 	INIT_LIST_HEAD(&ins_list);
 	INIT_LIST_HEAD(&del_list);
-	put = btrfs_readdir_get_delayed_items(inode, &ins_list, &del_list);
+	put = btrfs_readdir_get_delayed_items(inode, private->last_index,
+					      &ins_list, &del_list);
 
 again:
 	key.type = BTRFS_DIR_INDEX_KEY;
@@ -6238,6 +6335,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		if (found_key.offset < ctx->pos)
 			goto next;
+		if (found_key.offset > private->last_index)
+			break;
 		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
 			goto next;
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
@@ -6371,57 +6470,6 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 	return dirty ? btrfs_dirty_inode(inode) : 0;
 }
 
-/*
- * find the highest existing sequence number in a directory
- * and then set the in-memory index_cnt variable to reflect
- * free sequence numbers
- */
-static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_key key, found_key;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	int ret;
-
-	key.objectid = btrfs_ino(inode);
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = (u64)-1;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-	/* FIXME: we should be able to handle this */
-	if (ret == 0)
-		goto out;
-	ret = 0;
-
-	if (path->slots[0] == 0) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	path->slots[0]--;
-
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-
-	if (found_key.objectid != btrfs_ino(inode) ||
-	    found_key.type != BTRFS_DIR_INDEX_KEY) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	inode->index_cnt = found_key.offset + 1;
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
 /*
  * helper to find a free sequence number in a given directory.  This current
  * code is very simple, later versions will do smarter things in the btree
@@ -11059,7 +11107,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 233e465647fd..50f75986a79b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -725,6 +725,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	int ret;
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 
@@ -3183,6 +3186,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				ret = -EFAULT;
 				goto out;
 			}
+			if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
 			/* compression requires us to start the IO */
 			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
 				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
@@ -4331,6 +4338,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && is_fstree(sa->qgroupid)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d46a070275ff..34278cb5f964 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1608,6 +1608,15 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+{
+	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
+		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+}
+
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1627,6 +1636,11 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
+	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Check if there are no children of this qgroup */
 	if (!list_empty(&qgroup->members)) {
 		ret = -EBUSY;
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 50a5a5cfe38f..492566691026 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -883,8 +883,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 out_unlock:
 	spin_unlock(&fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }
 
@@ -1013,8 +1015,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		}
 	}
 	if (ret) {
-		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		btrfs_free_ref_cache(fs_info);
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c9fd598b0325..9900f879fa34 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7558,7 +7558,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 1c40e5151321..93a9dfbc8d13 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -283,9 +283,11 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
-/* Remove once support for zoned allocation is feature complete */
 #ifdef CONFIG_BTRFS_DEBUG
+/* Remove once support for zoned allocation is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
+/* Remove once support for extent tree v2 is feature complete */
+BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
@@ -314,6 +316,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(zoned),
+	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
@@ -1523,6 +1526,10 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 	unsigned long long limit;
 
 	limit = memparse(buf, &endptr);
+	/* There could be trailing '\n', also catch any typos after the value. */
+	endptr = skip_spaces(endptr);
+	if (*endptr != 0)
+		return -EINVAL;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index bd71c7369794..a190ae887bdc 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1382,7 +1382,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
-				   ptr, inline_type, end);
+				   ptr, btrfs_extent_inline_ref_size(inline_type), end);
 			return -EUCLEAN;
 		}
 
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ca92f2d2f3c7..e37e9fa457af 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1390,7 +1390,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
 		arg->old_xattr_buf = __ceph_build_xattrs_blob(ci);
 		arg->xattr_version = ci->i_xattrs.version;
-		arg->xattr_buf = ci->i_xattrs.blob;
+		arg->xattr_buf = ceph_buffer_get(ci->i_xattrs.blob);
 	} else {
 		arg->xattr_buf = NULL;
 		arg->old_xattr_buf = NULL;
@@ -1456,6 +1456,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 	encode_cap_msg(msg, arg);
 	ceph_con_send(&arg->session->s_con, msg);
 	ceph_buffer_put(arg->old_xattr_buf);
+	ceph_buffer_put(arg->xattr_buf);
 	if (arg->wake)
 		wake_up_all(&ci->i_cap_wq);
 }
@@ -4536,12 +4537,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
 	int ret;
 
+	/* This shouldn't happen */
+	BUG_ON(!dir);
+
 	/*
 	 * force an record for the directory caps if we have a dentry lease.
 	 * this is racy (can't take i_ceph_lock and d_lock together), but it
@@ -4551,14 +4554,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	if (!dir) {
-		parent = dget(dentry->d_parent);
-		dir = d_inode(parent);
-	}
 	spin_unlock(&dentry->d_lock);
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
-	dput(parent);
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index e2f401c8c5ce..8f409404aee1 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -113,7 +113,7 @@ static __u32 get_neg_ctxt_len(struct smb2_sync_hdr *hdr, __u32 len,
 	} else if (nc_offset + 1 == non_ctxlen) {
 		cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
 		size_of_pad_before_neg_ctxts = 0;
-	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE)
+	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE + 1)
 		/* has padding, but no SPNEGO blob */
 		size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen + 1;
 	else
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f31da2647d04..f8847546d6ac 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5826,7 +5826,7 @@ struct smb_version_values smb20_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5848,7 +5848,7 @@ struct smb_version_values smb21_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5869,7 +5869,7 @@ struct smb_version_values smb3any_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5890,7 +5890,7 @@ struct smb_version_values smbdefault_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5911,7 +5911,7 @@ struct smb_version_values smb30_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5932,7 +5932,7 @@ struct smb_version_values smb302_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5953,7 +5953,7 @@ struct smb_version_values smb311_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6714e9db0ee8..a21eeb23f8e1 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1327,7 +1327,7 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
 	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req) - 1 /* pad */);
+		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
 	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
@@ -1826,8 +1826,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	iov[0].iov_len = total_len - 1;
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req)
-			- 1 /* pad */);
+	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
 	req->PathLength = cpu_to_le16(unc_path_len - 2);
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
@@ -4748,7 +4747,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	memcpy(bufptr, &asteriks, len);
 
 	req->FileNameOffset =
-		cpu_to_le16(sizeof(struct smb2_query_directory_req) - 1);
+		cpu_to_le16(sizeof(struct smb2_query_directory_req));
 	req->FileNameLength = cpu_to_le16(len);
 	/*
 	 * BB could be 30 bytes or so longer if we used SMB2 specific
@@ -4945,7 +4944,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->AdditionalInformation = cpu_to_le32(additional_info);
 
 	req->BufferOffset =
-			cpu_to_le16(sizeof(struct smb2_set_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_set_info_req));
 	req->BufferLength = cpu_to_le32(*size);
 
 	memcpy(req->Buffer, *data, *size);
@@ -5177,9 +5176,9 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	req->VolatileFileId = volatile_fid;
 	/* 1 for pad */
 	req->InputBufferOffset =
-			cpu_to_le16(sizeof(struct smb2_query_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_query_info_req));
 	req->OutputBufferLength = cpu_to_le32(
-		outbuf_len + sizeof(struct smb2_query_info_rsp) - 1);
+		outbuf_len + sizeof(struct smb2_query_info_rsp));
 
 	iov->iov_base = (char *)req;
 	iov->iov_len = total_len;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 301c155c5267..812a1b564fb2 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -218,7 +218,7 @@ struct smb2_err_rsp {
 	__le16 StructureSize;
 	__le16 Reserved; /* MBZ */
 	__le32 ByteCount;  /* even if zero, at least one byte follows */
-	__u8   ErrorData[1];  /* variable length */
+	__u8   ErrorData[];  /* variable length */
 } __packed;
 
 #define SYMLINK_ERROR_TAG 0x4c4d5953
@@ -487,7 +487,7 @@ struct smb2_negotiate_rsp {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Flags */
@@ -504,7 +504,7 @@ struct smb2_sess_setup_req {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__u64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Currently defined SessionFlags */
@@ -517,7 +517,7 @@ struct smb2_sess_setup_rsp {
 	__le16 SessionFlags;
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 struct smb2_logoff_req {
@@ -543,7 +543,7 @@ struct smb2_tree_connect_req {
 	__le16 Flags; /* Reserved MBZ for dialects prior to SMB3.1.1 */
 	__le16 PathOffset;
 	__le16 PathLength;
-	__u8   Buffer[1];	/* variable length */
+	__u8   Buffer[];	/* variable length */
 } __packed;
 
 /* See MS-SMB2 section 2.2.9.2 */
@@ -852,7 +852,7 @@ struct smb2_create_rsp {
 	__u64  VolatileFileId; /* opaque endianness */
 	__le32 CreateContextsOffset;
 	__le32 CreateContextsLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct create_context {
@@ -1313,7 +1313,7 @@ struct smb2_read_plain_req {
 	__le32 RemainingBytes;
 	__le16 ReadChannelInfoOffset;
 	__le16 ReadChannelInfoLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Read flags */
@@ -1328,7 +1328,7 @@ struct smb2_read_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* For write request Flags field below the following flags are defined: */
@@ -1348,7 +1348,7 @@ struct smb2_write_req {
 	__le16 WriteChannelInfoOffset;
 	__le16 WriteChannelInfoLength;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_write_rsp {
@@ -1359,7 +1359,7 @@ struct smb2_write_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Reserved2;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* notify flags */
@@ -1395,7 +1395,7 @@ struct smb2_change_notify_rsp {
 	__le16	StructureSize;  /* Must be 9 */
 	__le16	OutputBufferOffset;
 	__le32	OutputBufferLength;
-	__u8	Buffer[1]; /* array of file notify structs */
+	__u8	Buffer[]; /* array of file notify structs */
 } __packed;
 
 #define SMB2_LOCKFLAG_SHARED_LOCK	0x0001
@@ -1422,7 +1422,10 @@ struct smb2_lock_req {
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
 	/* Followed by at least one */
-	struct smb2_lock_element locks[1];
+	union {
+		struct smb2_lock_element lock;
+		DECLARE_FLEX_ARRAY(struct smb2_lock_element, locks);
+	};
 } __packed;
 
 struct smb2_lock_rsp {
@@ -1478,7 +1481,7 @@ struct smb2_query_directory_req {
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_directory_rsp {
@@ -1486,7 +1489,7 @@ struct smb2_query_directory_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Possible InfoType values */
@@ -1527,7 +1530,7 @@ struct smb2_query_info_req {
 	__le32 Flags;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_info_rsp {
@@ -1535,7 +1538,7 @@ struct smb2_query_info_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /*
@@ -1558,7 +1561,7 @@ struct smb2_set_info_req {
 	__le32 AdditionalInformation;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_set_info_rsp {
@@ -1761,7 +1764,10 @@ struct smb2_file_all_info { /* data block encoding of response to level 18 */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char   FileName[1];
+	union {
+		char __pad;     /* Legacy structure padding */
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __packed; /* level 18 Query */
 
 struct smb2_file_eof_info { /* encoding of request for level 10 */
diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..422c440b492a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -762,12 +762,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
-		return false;
+		dentry->d_lockref.count--;
+		goto locked;
 	}
 
 	/*
@@ -825,6 +825,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
+locked:
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
 		return true;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..bea4c2b0cd6b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -76,6 +76,14 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 
 	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
 		return ERR_PTR(-EXDEV);
+
+	/* Reject dealing with casefold directories. */
+	if (IS_CASEFOLDED(lower_inode)) {
+		pr_err_ratelimited("%s: Can't handle casefolded directory.\n",
+				   __func__);
+		return ERR_PTR(-EREMOTE);
+	}
+
 	if (!igrab(lower_inode))
 		return ERR_PTR(-ESTALE);
 	inode = iget5_locked(sb, (unsigned long)lower_inode,
diff --git a/fs/exec.c b/fs/exec.c
index 881390b44cfd..719115f23282 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1410,6 +1410,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 out_unlock:
 	up_write(&me->signal->exec_update_lock);
+	if (!bprm->cred)
+		mutex_unlock(&me->signal->cred_guard_mutex);
+
 out:
 	return retval;
 }
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e44c28ceb9cd..762c2f8b5b2a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6434,11 +6434,16 @@ __acquires(bitlock)
 static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					   ext4_group_t grp)
 {
-	if (grp < ext4_get_groups_count(sb))
-		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
-		ext4_group_first_block_no(sb, grp) - 1) >>
-					EXT4_CLUSTER_BITS(sb);
+	unsigned long nr_clusters_in_group;
+
+	if (grp < (ext4_get_groups_count(sb) - 1))
+		nr_clusters_in_group = EXT4_CLUSTERS_PER_GROUP(sb);
+	else
+		nr_clusters_in_group = (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+					ext4_group_first_block_no(sb, grp))
+				       >> EXT4_CLUSTER_BITS(sb);
+
+	return nr_clusters_in_group - 1;
 }
 
 static bool ext4_trim_interrupted(void)
@@ -6452,13 +6457,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, last, origin_start;
 	bool set_trimmed = false;
 	void *bitmap;
 
+	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
-	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+	if (start == 0 && max >= last)
 		set_trimmed = true;
+	origin_start = start;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -6467,7 +6474,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		next = mb_find_next_bit(bitmap, last + 1, start);
+		if (origin_start == 0 && next >= last)
+			set_trimmed = true;
 
 		if ((next - start) >= minblocks) {
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 64a579734f93..f8dd5d972c33 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -615,6 +615,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		goto out;
 	o_end = o_start + len;
 
+	*moved_len = 0;
 	while (o_start < o_end) {
 		struct ext4_extent *ex;
 		ext4_lblk_t cur_blk, next_blk;
@@ -670,7 +671,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-		move_extent_per_page(o_filp, donor_inode,
+		*moved_len += move_extent_per_page(o_filp, donor_inode,
 				     orig_page_index, donor_page_index,
 				     offset_in_page, cur_len,
 				     unwritten, &ret);
@@ -680,9 +681,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		o_start += cur_len;
 		d_start += cur_len;
 	}
-	*moved_len = o_start - orig_blk;
-	if (*moved_len > len)
-		*moved_len = len;
 
 out:
 	if (*moved_len) {
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index d0c41343a5c4..70d4f6e3aaa7 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -227,17 +227,24 @@ struct ext4_new_flex_group_data {
 						   in the flex group */
 	__u16 *bg_flags;			/* block group flags of groups
 						   in @groups */
+	ext4_group_t resize_bg;			/* number of allocated
+						   new_group_data */
 	ext4_group_t count;			/* number of groups in @groups
 						 */
 };
 
+/*
+ * Avoiding memory allocation failures due to too many groups added each time.
+ */
+#define MAX_RESIZE_BG				16384
+
 /*
  * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
  * @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -245,17 +252,18 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (flexbg_size >= UINT_MAX / sizeof(struct ext4_new_group_data))
-		goto out2;
-	flex_gd->count = flexbg_size;
+	if (unlikely(flexbg_size > MAX_RESIZE_BG))
+		flex_gd->resize_bg = MAX_RESIZE_BG;
+	else
+		flex_gd->resize_bg = flexbg_size;
 
-	flex_gd->groups = kmalloc_array(flexbg_size,
+	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
 	if (flex_gd->groups == NULL)
 		goto out2;
 
-	flex_gd->bg_flags = kmalloc_array(flexbg_size, sizeof(__u16),
+	flex_gd->bg_flags = kmalloc_array(flex_gd->resize_bg, sizeof(__u16),
 					  GFP_NOFS);
 	if (flex_gd->bg_flags == NULL)
 		goto out1;
@@ -292,7 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -393,12 +401,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 		group = group_data[0].group;
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
-		       "%d groups, flexbg size is %d:\n", flex_gd->count,
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,
 		       flexbg_size);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
-			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
+			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
 			       ext4_bg_has_super(sb, group + i) ? "normal" :
 			       "no-super", group + i,
 			       group_data[i].blocks_count,
@@ -1576,8 +1584,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
-				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    ext4_fsblk_t n_blocks_count)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1601,7 +1608,7 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
 	BUG_ON(last);
 	ext4_get_group_no_and_offset(sb, n_blocks_count - 1, &n_group, &last);
 
-	last_group = group | (flexbg_size - 1);
+	last_group = group | (flex_gd->resize_bg - 1);
 	if (last_group > n_group)
 		last_group = n_group;
 
@@ -1963,8 +1970,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	ext4_fsblk_t o_blocks_count;
 	ext4_fsblk_t n_blocks_count_retry = 0;
 	unsigned long last_update_time = 0;
-	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
+	int err = 0;
 	int meta_bg;
+	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
 
 	/* See if the device is actually as big as what was requested */
 	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
@@ -2105,8 +2113,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	/* Add flex groups. Note that a regular group is a
 	 * flex group with 1 group.
 	 */
-	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
-					      flexbg_size)) {
+	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count)) {
 		if (jiffies - last_update_time > HZ * 10) {
 			if (last_update_time)
 				ext4_msg(sb, KERN_INFO,
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3982b4a7618c..7b4479d5b531 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1037,8 +1037,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
 			set_page_dirty(cc->rpages[i]);
+			set_page_private_gcing(cc->rpages[i]);
+		}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d220c4523982..489854d841e7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1278,6 +1278,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			f2fs_copy_page(psrc, pdst);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -3981,6 +3982,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			break;
 		}
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ba7eeb3c2738..f07ae58d266d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -657,7 +657,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -665,12 +674,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
@@ -860,6 +871,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 352230a011e0..54379ee573b1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -135,6 +135,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
+	vm_flags_t vm_flags;
 
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -176,10 +177,20 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
+
+	vm_flags = vma->vm_flags;
+	/*
+	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
+	 * reserving here. Note: only for SHM hugetlbfs file, the inode
+	 * flag S_PRIVATE is set.
+	 */
+	if (inode->i_flags & S_PRIVATE)
+		vm_flags |= VM_NORESERVE;
+
 	if (!hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
-				vma->vm_flags))
+				vm_flags))
 		goto out;
 
 	ret = 0;
diff --git a/fs/ioctl.c b/fs/ioctl.c
index e0a3455f9a0f..5b0ab4ad1772 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -920,8 +920,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (!f.file)
 		return -EBADF;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out;
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5b01026fff9b..3f5c14315719 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -63,10 +63,10 @@
  */
 static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			int nblocks);
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
-static int dbBackSplit(dmtree_t * tp, int leafno);
-static int dbJoin(dmtree_t * tp, int leafno, int newval);
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl);
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl);
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl);
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl);
 static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
 		    int level);
 static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
@@ -2171,7 +2171,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		 * system.
 		 */
 		if (dp->tree.stree[word] == NOFREE)
-			dbBackSplit((dmtree_t *) & dp->tree, word);
+			dbBackSplit((dmtree_t *)&dp->tree, word, false);
 
 		dbAllocBits(bmp, dp, blkno, nblocks);
 	}
@@ -2257,7 +2257,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			 * the binary system of the leaves if need be.
 			 */
 			dbSplit(tp, word, BUDMIN,
-				dbMaxBud((u8 *) & dp->wmap[word]));
+				dbMaxBud((u8 *)&dp->wmap[word]), false);
 
 			word += 1;
 		} else {
@@ -2297,7 +2297,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 				 * system of the leaves to reflect the current
 				 * allocation (size).
 				 */
-				dbSplit(tp, word, size, NOFREE);
+				dbSplit(tp, word, size, NOFREE, false);
 
 				/* get the number of dmap words handled */
 				nw = BUDSIZE(size, BUDMIN);
@@ -2404,7 +2404,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			/* update the leaf for this dmap word.
 			 */
 			rc = dbJoin(tp, word,
-				    dbMaxBud((u8 *) & dp->wmap[word]));
+				    dbMaxBud((u8 *)&dp->wmap[word]), false);
 			if (rc)
 				return rc;
 
@@ -2437,7 +2437,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 
 				/* update the leaf.
 				 */
-				rc = dbJoin(tp, word, size);
+				rc = dbJoin(tp, word, size, false);
 				if (rc)
 					return rc;
 
@@ -2589,16 +2589,16 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 		 * that it is at the front of a binary buddy system.
 		 */
 		if (oldval == NOFREE) {
-			rc = dbBackSplit((dmtree_t *) dcp, leafno);
+			rc = dbBackSplit((dmtree_t *)dcp, leafno, true);
 			if (rc) {
 				release_metapage(mp);
 				return rc;
 			}
 			oldval = dcp->stree[ti];
 		}
-		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
+		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
 	} else {
-		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
+		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
 		if (rc) {
 			release_metapage(mp);
 			return rc;
@@ -2629,7 +2629,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 				 */
 				if (alloc) {
 					dbJoin((dmtree_t *) dcp, leafno,
-					       oldval);
+					       oldval, true);
 				} else {
 					/* the dbJoin() above might have
 					 * caused a larger binary buddy system
@@ -2639,9 +2639,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 					 */
 					if (dcp->stree[ti] == NOFREE)
 						dbBackSplit((dmtree_t *)
-							    dcp, leafno);
+							    dcp, leafno, true);
 					dbSplit((dmtree_t *) dcp, leafno,
-						dcp->budmin, oldval);
+						dcp->budmin, oldval, true);
 				}
 
 				/* release the buffer and return the error.
@@ -2689,7 +2689,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl)
 {
 	int budsz;
 	int cursz;
@@ -2711,7 +2711,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 		while (cursz >= splitsz) {
 			/* update the buddy's leaf with its new value.
 			 */
-			dbAdjTree(tp, leafno ^ budsz, cursz);
+			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
 
 			/* on to the next size and buddy.
 			 */
@@ -2723,7 +2723,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 	/* adjust the dmap tree to reflect the specified leaf's new
 	 * value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 }
 
 
@@ -2754,7 +2754,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static int dbBackSplit(dmtree_t * tp, int leafno)
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
 {
 	int budsz, bud, w, bsz, size;
 	int cursz;
@@ -2805,7 +2805,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
 				 * system in two.
 				 */
 				cursz = leaf[bud] - 1;
-				dbSplit(tp, bud, cursz, cursz);
+				dbSplit(tp, bud, cursz, cursz, is_ctl);
 				break;
 			}
 		}
@@ -2833,7 +2833,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
  *
  * RETURN VALUES: none
  */
-static int dbJoin(dmtree_t * tp, int leafno, int newval)
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int budsz, buddy;
 	s8 *leaf;
@@ -2888,12 +2888,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 			if (leafno < buddy) {
 				/* leafno is the left buddy.
 				 */
-				dbAdjTree(tp, buddy, NOFREE);
+				dbAdjTree(tp, buddy, NOFREE, is_ctl);
 			} else {
 				/* buddy is the left buddy and becomes
 				 * leafno.
 				 */
-				dbAdjTree(tp, leafno, NOFREE);
+				dbAdjTree(tp, leafno, NOFREE, is_ctl);
 				leafno = buddy;
 			}
 
@@ -2906,7 +2906,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 
 	/* update the leaf value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 
 	return 0;
 }
@@ -2927,15 +2927,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
  *
  * RETURN VALUES: none
  */
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int lp, pp, k;
-	int max;
+	int max, size;
+
+	size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* pick up the index of the leaf for this leafno.
 	 */
 	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
 
+	if (WARN_ON_ONCE(lp >= size || lp < 0))
+		return;
+
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 837d42f61464..a222a9d71887 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -633,6 +633,11 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] < 0) {
+				rc = -EIO;
+				goto out;
+			}
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
@@ -1970,7 +1975,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 6ed2e1d4c894..ac42f8ee553f 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2179,6 +2179,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index aa4ff7bcaff2..55702b31ab3c 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -172,15 +172,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6a1cb2a182b6..36430bdf9381 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -654,6 +654,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs
+		 */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index 4a4b2b03ff33..b931a99ab9c8 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -214,10 +214,15 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 {
 	struct ksmbd_conn *conn = context;
 
+	if (!vlen)
+		return -EINVAL;
+
 	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
+	conn->mechTokenLen = (unsigned int)vlen;
+
 	return 0;
 }
 
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 0a7a30bd531f..63815c4df133 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -284,6 +284,7 @@ int ksmbd_conn_handler_loop(void *p)
 		goto out;
 
 	conn->last_active = jiffies;
+	set_freezable();
 	while (ksmbd_conn_alive(conn)) {
 		if (try_to_freeze())
 			continue;
@@ -415,13 +416,7 @@ static void stop_sessions(void)
 again:
 	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
-		struct task_struct *task;
-
 		t = conn->transport;
-		task = t->handler;
-		if (task)
-			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
-				    task->comm, task_pid_nr(task));
 		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
 			up_read(&conn_list_lock);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 3c005246a32e..0e04cf8b1d89 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -88,6 +88,7 @@ struct ksmbd_conn {
 	__u16				dialect;
 
 	char				*mechToken;
+	unsigned int			mechTokenLen;
 
 	struct ksmbd_conn_ops	*conn_ops;
 
@@ -134,7 +135,6 @@ struct ksmbd_transport_ops {
 struct ksmbd_transport {
 	struct ksmbd_conn		*conn;
 	struct ksmbd_transport_ops	*ops;
-	struct task_struct		*handler;
 };
 
 #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index 821ed8e3cbee..ecffcb8a1557 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -304,7 +304,8 @@ enum ksmbd_event {
 	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
 	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
 
-	KSMBD_EVENT_MAX
+	__KSMBD_EVENT_MAX,
+	KSMBD_EVENT_MAX = __KSMBD_EVENT_MAX - 1
 };
 
 /*
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 2da256259722..4e444d01a3c3 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -105,7 +105,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = le16_to_cpu(lctx->epoch);
+	lease->epoch = le16_to_cpu(lctx->epoch) + 1;
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -546,6 +546,7 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			     atomic_read(&ci->sop_count)) == 1) {
 				if (lease->state != SMB2_LEASE_NONE_LE &&
 				    lease->state == (lctx->req_state & lease->state)) {
+					lease->epoch++;
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
@@ -556,13 +557,17 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				    atomic_read(&ci->sop_count)) > 1) {
 				if (lctx->req_state ==
 				    (SMB2_LEASE_READ_CACHING_LE |
-				     SMB2_LEASE_HANDLE_CACHING_LE))
+				     SMB2_LEASE_HANDLE_CACHING_LE)) {
+					lease->epoch++;
 					lease->state = lctx->req_state;
+				}
 			}
 
 			if (lctx->req_state && lease->state ==
-			    SMB2_LEASE_NONE_LE)
+			    SMB2_LEASE_NONE_LE) {
+				lease->epoch++;
 				lease_none_upgrade(opinfo, lctx->req_state);
+			}
 		}
 		read_lock(&ci->m_lock);
 	}
@@ -1035,7 +1040,8 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
-	lease2->epoch = lease1->epoch++;
+	lease2->epoch = lease1->epoch;
+	lease2->version = lease1->version;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
@@ -1191,6 +1197,12 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
+	/* Only v2 leases handle the directory */
+	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
+		if (!lctx || lctx->version != 2)
+			return 0;
+	}
+
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;
@@ -1447,7 +1459,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
-		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
+		buf->lcontext.Epoch = cpu_to_le16(lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8875c04e8382..7e8f1c89124f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1414,7 +1414,10 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	char *name;
 	unsigned int name_off, name_len, secbuf_len;
 
-	secbuf_len = le16_to_cpu(req->SecurityBufferLength);
+	if (conn->use_spnego && conn->mechToken)
+		secbuf_len = conn->mechTokenLen;
+	else
+		secbuf_len = le16_to_cpu(req->SecurityBufferLength);
 	if (secbuf_len < sizeof(struct authenticate_message)) {
 		ksmbd_debug(SMB, "blob len %d too small\n", secbuf_len);
 		return NULL;
@@ -1505,7 +1508,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		struct authenticate_message *authblob;
 
 		authblob = user_authblob(conn, req);
-		sz = le16_to_cpu(req->SecurityBufferLength);
+		if (conn->use_spnego && conn->mechToken)
+			sz = conn->mechTokenLen;
+		else
+			sz = le16_to_cpu(req->SecurityBufferLength);
 		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, conn, sess);
 		if (rc) {
 			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
@@ -1778,8 +1784,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
-	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
-	    negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
+	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer)) {
 		rc = -EINVAL;
 		goto out_err;
 	}
@@ -1788,8 +1793,15 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			negblob_off);
 
 	if (decode_negotiation_token(conn, negblob, negblob_len) == 0) {
-		if (conn->mechToken)
+		if (conn->mechToken) {
 			negblob = (struct negotiate_message *)conn->mechToken;
+			negblob_len = conn->mechTokenLen;
+		}
+	}
+
+	if (negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
+		rc = -EINVAL;
+		goto out_err;
 	}
 
 	if (server_conf.auth_mechs & conn->auth_mechs) {
@@ -2311,11 +2323,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * @eabuf:	set info command buffer
  * @buf_len:	set info command buffer length
  * @path:	dentry path for get ea
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       const struct path *path)
+		       const struct path *path, bool get_write)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -2968,7 +2981,7 @@ int smb2_open(struct ksmbd_work *work)
 					    &may_flags);
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-		if (open_flags & O_CREAT) {
+		if (open_flags & (O_CREAT | O_TRUNC)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			rc = -EACCES;
@@ -3000,7 +3013,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5568,6 +5581,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
@@ -5945,12 +5959,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_RENAME_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_rename_info))
 			return -EINVAL;
 
@@ -5970,12 +5978,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_disposition_info))
 			return -EINVAL;
 
@@ -5994,7 +5996,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
@@ -6037,7 +6039,7 @@ int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
@@ -6057,6 +6059,13 @@ int smb2_set_info(struct ksmbd_work *work)
 		rsp = smb2_get_msg(work->response_buf);
 	}
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		pr_err("User does not have write permission\n");
+		rc = -EACCES;
+		goto err_out;
+	}
+
 	if (!has_file_id(id)) {
 		id = req->VolatileFileId;
 		pid = req->PersistentFileId;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 9ace5027684d..3a6c0abdb035 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -399,10 +399,6 @@ static void parse_dacl(struct user_namespace *user_ns,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -412,6 +408,13 @@ static void parse_dacl(struct user_namespace *user_ns,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 9560c704033e..2c9662e32799 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -74,7 +74,7 @@ static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info)
 static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
 static int ksmbd_ipc_heartbeat_request(void);
 
-static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX + 1] = {
 	[KSMBD_EVENT_UNSPEC] = {
 		.len = 0,
 	},
@@ -402,7 +402,7 @@ static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 #endif
 
-	if (type >= KSMBD_EVENT_MAX) {
+	if (type > KSMBD_EVENT_MAX) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 252a1e7afcc0..355673f2830b 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -2039,6 +2039,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	struct task_struct *handler;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2056,11 +2057,11 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (ret)
 		goto out_err;
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-					      smb_direct_port);
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
+			      smb_direct_port);
+	if (IS_ERR(handler)) {
+		ret = PTR_ERR(handler);
 		pr_err("Can't start thread\n");
 		goto out_err;
 	}
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index eff7a1d793f0..9d4222154dcc 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -185,6 +185,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
+	struct task_struct *handler;
 
 	t = alloc_transport(client_sk);
 	if (!t) {
@@ -199,13 +200,13 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 		goto out_error;
 	}
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn,
-					      "ksmbd:%u",
-					      ksmbd_tcp_get_port(csin));
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn,
+			      "ksmbd:%u",
+			      ksmbd_tcp_get_port(csin));
+	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
-		rc = PTR_ERR(KSMBD_TRANS(t)->handler);
+		rc = PTR_ERR(handler);
 		free_transport(t);
 	}
 	return rc;
diff --git a/fs/namei.c b/fs/namei.c
index a7f88c5b3d90..05d45b9b59cb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2993,20 +2993,14 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
 		return p;
 	}
 
 	p = d_ancestor(p1, p2);
-	if (p) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
-		return p;
-	}
-
-	lock_two_inodes(p1->d_inode, p2->d_inode,
-			I_MUTEX_PARENT, I_MUTEX_PARENT2);
-	return NULL;
+	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	return p;
 }
 
 /*
@@ -4691,11 +4685,12 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *
  *	a) we can get into loop creation.
  *	b) race potential - two innocent renames can create a loop together.
- *	   That's where 4.4 screws up. Current fix: serialization on
+ *	   That's where 4.4BSD screws up. Current fix: serialization on
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
- *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source.
+ *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
+ *	   and source (if it's a non-directory or a subdirectory that moves to
+ *	   different parent).
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4727,6 +4722,7 @@ int vfs_rename(struct renamedata *rd)
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
+	bool lock_old_subdir, lock_new_subdir;
 
 	if (source == target)
 		return 0;
@@ -4780,15 +4776,32 @@ int vfs_rename(struct renamedata *rd)
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
 	/*
-	 * Lock all moved children. Moved directories may need to change parent
-	 * pointer so they need the lock to prevent against concurrent
-	 * directory changes moving parent pointer. For regular files we've
-	 * historically always done this. The lockdep locking subclasses are
-	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
-	 * regular files and directories so it's difficult to tell which
-	 * subclasses to use.
+	 * Lock children.
+	 * The source subdirectory needs to be locked on cross-directory
+	 * rename or cross-directory exchange since its parent changes.
+	 * The target subdirectory needs to be locked on cross-directory
+	 * exchange due to parent change and on any rename due to becoming
+	 * a victim.
+	 * Non-directories need locking in all cases (for NFS reasons);
+	 * they get locked after any subdirectories (in inode address order).
+	 *
+	 * NOTE: WE ONLY LOCK UNRELATED DIRECTORIES IN CROSS-DIRECTORY CASE.
+	 * NEVER, EVER DO THAT WITHOUT ->s_vfs_rename_mutex.
 	 */
-	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
+	lock_old_subdir = new_dir != old_dir;
+	lock_new_subdir = new_dir != old_dir || !(flags & RENAME_EXCHANGE);
+	if (is_dir) {
+		if (lock_old_subdir)
+			inode_lock_nested(source, I_MUTEX_CHILD);
+		if (target && (!new_is_dir || lock_new_subdir))
+			inode_lock(target);
+	} else if (new_is_dir) {
+		if (lock_new_subdir)
+			inode_lock_nested(target, I_MUTEX_CHILD);
+		inode_lock(source);
+	} else {
+		lock_two_nondirectories(source, target);
+	}
 
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
@@ -4836,8 +4849,9 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	inode_unlock(source);
-	if (target)
+	if (!is_dir || lock_old_subdir)
+		inode_unlock(source);
+	if (target && (!new_is_dir || lock_new_subdir))
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 8fedc7104320..22b1ca5c379d 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_err(dat->i_sb,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 7cf765258fda..e337afb9fade 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -105,7 +105,13 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	wait_on_page_writeback(page);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(ret);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 2217f904a7cf..188b8cc52e2b 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -472,9 +472,10 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     struct page *page)
+				     loff_t pos, struct page *page)
 {
 	struct buffer_head *bh_org;
+	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
@@ -482,7 +483,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 		return -EIO;
 
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
+	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
 	kunmap_atomic(kaddr);
 	brelse(bh_org);
 	return 0;
@@ -521,7 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index d61d702215db..17ff9589c474 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1702,7 +1702,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
@@ -1713,6 +1712,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_begin_page_io(fs_page);
 				fs_page = bh->b_page;
@@ -1798,7 +1798,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
@@ -1807,6 +1806,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, err);
 				fs_page = bh->b_page;
@@ -1894,8 +1894,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
@@ -1903,6 +1904,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, 0);
 				fs_page = bh->b_page;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4413f6da68e6..110690edbf62 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1872,10 +1872,12 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 		goto out;
 	}
 
-	root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT));
-	if (root_sdh->type != ATTR_ZERO ||
+	if(!(root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+	    root_sdh->type != ATTR_ZERO ||
 	    root_sdh->rule != NTFS_COLLATION_TYPE_SECURITY_HASH ||
-	    offsetof(struct INDEX_ROOT, ihdr) + root_sdh->ihdr.used > attr->res.data_size) {
+	    offsetof(struct INDEX_ROOT, ihdr) +
+			le32_to_cpu(root_sdh->ihdr.used) >
+			le32_to_cpu(attr->res.data_size)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -1891,10 +1893,12 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 		goto out;
 	}
 
-	root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT));
-	if (root_sii->type != ATTR_ZERO ||
+	if(!(root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+	    root_sii->type != ATTR_ZERO ||
 	    root_sii->rule != NTFS_COLLATION_TYPE_UINT ||
-	    offsetof(struct INDEX_ROOT, ihdr) + root_sii->ihdr.used > attr->res.data_size) {
+	    offsetof(struct INDEX_ROOT, ihdr) +
+			le32_to_cpu(root_sii->ihdr.used) >
+			le32_to_cpu(attr->res.data_size)) {
 		err = -EINVAL;
 		goto out;
 	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index b49e62e2080b..76935562d5ce 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1106,7 +1106,8 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	}
 
 	/* check for index header length */
-	if (offsetof(struct INDEX_BUFFER, ihdr) + ib->ihdr.used > bytes) {
+	if (offsetof(struct INDEX_BUFFER, ihdr) + le32_to_cpu(ib->ihdr.used) >
+	    bytes) {
 		err = -EINVAL;
 		goto out;
 	}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 510ed2ea1c48..981276500043 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -468,7 +468,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 int al_update(struct ntfs_inode *ni, int sync);
 static inline size_t al_aligned(size_t size)
 {
-	return (size + 1023) & ~(size_t)1023;
+	return size_add(size, 1023) & ~(size_t)1023;
 }
 
 /* Globals from bitfunc.c */
diff --git a/fs/pipe.c b/fs/pipe.c
index e08f0fe55584..a8b8ef2dae7b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -435,12 +435,10 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue) {
+	if (pipe_has_watch_queue(pipe)) {
 		ret = -EXDEV;
 		goto out;
 	}
-#endif
 
 	/*
 	 * If it wasn't empty we try to merge new data into
@@ -1302,6 +1300,11 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
+	if (!pipe_has_watch_queue(pipe)) {
+		pipe->max_usage = nr_slots;
+		pipe->nr_accounted = nr_slots;
+	}
+
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
@@ -1319,10 +1322,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	unsigned int nr_slots, size;
 	long ret = 0;
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe_has_watch_queue(pipe))
 		return -EBUSY;
-#endif
 
 	size = round_pipe_size(arg);
 	nr_slots = size >> PAGE_SHIFT;
@@ -1355,8 +1356,6 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	if (ret < 0)
 		goto out_revert_acct;
 
-	pipe->max_usage = nr_slots;
-	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
@@ -1374,10 +1373,8 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 
 	if (file->f_op != &pipefifo_fops || !pipe)
 		return NULL;
-#ifdef CONFIG_WATCH_QUEUE
-	if (for_splice && pipe->watch_queue)
+	if (for_splice && pipe_has_watch_queue(pipe))
 		return NULL;
-#endif
 	return pipe;
 }
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f3fa3625d772..e15b4631364a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -519,6 +519,7 @@ static int ramoops_init_przs(const char *name,
 	}
 
 	zone_sz = mem_sz / *cnt;
+	zone_sz = ALIGN_DOWN(zone_sz, 2);
 	if (!zone_sz) {
 		dev_err(dev, "%s zone size == 0\n", name);
 		goto fail;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 6a054df8b991..69d75f8197c5 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1225,6 +1225,8 @@ static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	mutex_unlock(&dir_ui->ui_mutex);
 out_inode:
+	/* Free inode->i_link before inode is marked as bad. */
+	fscrypt_free_inode(inode);
 	make_bad_inode(inode);
 	iput(inode);
 out_fname:
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 569960e4ea3a..f4c25b07dc99 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1436,6 +1436,18 @@ xfs_fs_fill_super(
 
 	mp->m_super = sb;
 
+	/*
+	 * Copy VFS mount flags from the context now that all parameter parsing
+	 * is guaranteed to have been completed by either the old mount API or
+	 * the newer fsopen/fsconfig API.
+	 */
+	if (fc->sb_flags & SB_RDONLY)
+		set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
+	if (fc->sb_flags & SB_DIRSYNC)
+		mp->m_features |= XFS_FEAT_DIRSYNC;
+	if (fc->sb_flags & SB_SYNCHRONOUS)
+		mp->m_features |= XFS_FEAT_WSYNC;
+
 	error = xfs_fs_validate_params(mp);
 	if (error)
 		goto out_free_names;
@@ -1910,6 +1922,11 @@ static const struct fs_context_operations xfs_context_ops = {
 	.free        = xfs_fs_free,
 };
 
+/*
+ * WARNING: do not initialise any parameters in this function that depend on
+ * mount option parsing having already been performed as this can be called from
+ * fsopen() before any parameters have been set.
+ */
 static int xfs_init_fs_context(
 	struct fs_context	*fc)
 {
@@ -1942,16 +1959,6 @@ static int xfs_init_fs_context(
 	mp->m_logbsize = -1;
 	mp->m_allocsize_log = 16; /* 64k */
 
-	/*
-	 * Copy binary VFS mount flags we are interested in.
-	 */
-	if (fc->sb_flags & SB_RDONLY)
-		set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
-	if (fc->sb_flags & SB_DIRSYNC)
-		mp->m_features |= XFS_FEAT_DIRSYNC;
-	if (fc->sb_flags & SB_SYNCHRONOUS)
-		mp->m_features |= XFS_FEAT_WSYNC;
-
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;
 
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 1a3ad6d29833..c32e0cf23c90 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
+int __init early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
@@ -46,6 +47,7 @@ static inline void numa_add_cpu(unsigned int cpu) { }
 static inline void numa_remove_cpu(unsigned int cpu) { }
 static inline void arch_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
+static inline int early_cpu_to_node(int cpu) { return 0; }
 
 #endif	/* CONFIG_NUMA */
 
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c..6b5eec10c3db 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -24,6 +24,7 @@
 #define __DRM_COLOR_MGMT_H__
 
 #include <linux/ctype.h>
+#include <linux/math64.h>
 #include <drm/drm_property.h>
 
 struct drm_crtc;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 3af4624368d8..329607ca65c0 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -229,8 +229,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
 			     struct drm_fb_helper_surface_size *sizes);
 
-void drm_fb_helper_deferred_io(struct fb_info *info,
-			       struct list_head *pagelist);
+void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist);
 
 ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index d9af72024d66..5190fd48d318 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -166,6 +166,7 @@ struct mipi_dsi_device_info {
  * struct mipi_dsi_device - DSI peripheral device
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
+ * @attached: the DSI device has been successfully attached
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -181,6 +182,7 @@ struct mipi_dsi_device_info {
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
+	bool attached;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;
diff --git a/include/linux/async.h b/include/linux/async.h
index cce4ad31e8fc..33c9ff4afb49 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -90,6 +90,8 @@ async_schedule_dev(async_func_t func, struct device *dev)
 	return async_schedule_node(func, dev, dev_to_node(dev));
 }
 
+bool async_schedule_dev_nocall(async_func_t func, struct device *dev);
+
 /**
  * async_schedule_dev_domain - A device specific version of async_schedule_domain
  * @func: function to execute asynchronously
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 00c615fc8ec3..48f3cc3bafea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -91,7 +91,11 @@ struct bpf_map_ops {
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
 				int fd);
-	void (*map_fd_put_ptr)(void *ptr);
+	/* If need_defer is true, the implementation should guarantee that
+	 * the to-be-put element is still alive before the bpf program, which
+	 * may manipulate it, exists.
+	 */
+	void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_defer);
 	int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf);
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 6ffb4b2c6371..9d276655cc25 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -551,6 +551,25 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
 	fence->error = error;
 }
 
+/**
+ * dma_fence_timestamp - helper to get the completion timestamp of a fence
+ * @fence: fence to get the timestamp from.
+ *
+ * After a fence is signaled the timestamp is updated with the signaling time,
+ * but setting the timestamp can race with tasks waiting for the signaling. This
+ * helper busy waits for the correct timestamp to appear.
+ */
+static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
+{
+	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+		return ktime_get();
+
+	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+		cpu_relax();
+
+	return fence->timestamp;
+}
+
 signed long dma_fence_wait_timeout(struct dma_fence *,
 				   bool intr, signed long timeout);
 signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9000f3ffce8b..04826a793039 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -959,7 +959,8 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
-	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
+	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM) ||
+	       (direction == DMA_DEV_TO_DEV);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3d7306c9a706..b79a833524ef 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -201,11 +201,20 @@ struct fb_pixmap {
 };
 
 #ifdef CONFIG_FB_DEFERRED_IO
+struct fb_deferred_io_pageref {
+	struct page *page;
+	unsigned long offset;
+	/* private */
+	struct list_head list;
+};
+
 struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
-	struct mutex lock; /* mutex that protects the page list */
-	struct list_head pagelist; /* list of touched pages */
+	bool sort_pagereflist; /* sort pagelist by offset */
+	int open_count; /* number of opened files; protected by fb_info lock */
+	struct mutex lock; /* mutex that protects the pageref list */
+	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
 	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
@@ -468,6 +477,8 @@ struct fb_info {
 #endif
 #ifdef CONFIG_FB_DEFERRED_IO
 	struct delayed_work deferred_work;
+	unsigned long npagerefs;
+	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
 #endif
 
@@ -661,10 +672,11 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 
 /* drivers/video/fb_defio.c */
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma);
-extern void fb_deferred_io_init(struct fb_info *info);
+extern int  fb_deferred_io_init(struct fb_info *info);
 extern void fb_deferred_io_open(struct fb_info *info,
 				struct inode *inode,
 				struct file *file);
+extern void fb_deferred_io_release(struct fb_info *info);
 extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_fsync(struct file *file, loff_t start,
 				loff_t end, int datasync);
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f2044d5a652b..254d4a898179 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -197,6 +197,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -219,7 +220,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index ec2a47a81e42..ee5f9120c4d7 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -58,6 +58,9 @@ void irq_work_sync(struct irq_work *work);
 void irq_work_run(void);
 bool irq_work_needs_cpu(void);
 void irq_work_single(void *arg);
+
+void arch_irq_work_raise(void);
+
 #else
 static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c4f245262f98..af2fa1134b50 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -165,6 +165,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
+	 unsigned long arg)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6ba100216530..8b8349ffa1cd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1287,6 +1287,7 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1457,7 +1458,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
@@ -1481,6 +1482,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -1493,14 +1495,20 @@ static inline int pfn_valid(unsigned long pfn)
 
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	ms = __nr_to_section(pfn_to_section_nr(pfn));
-	if (!valid_section(ms))
+	ms = __pfn_to_section(pfn);
+	rcu_read_lock();
+	if (!valid_section(ms)) {
+		rcu_read_unlock();
 		return 0;
+	}
 	/*
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	ret = early_section(ms) || pfn_section_valid(ms, pfn);
+	rcu_read_unlock();
+
+	return ret;
 }
 #endif
 
@@ -1508,7 +1516,7 @@ static inline int pfn_in_present_section(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
+	return present_section(__pfn_to_section(pfn));
 }
 
 static inline unsigned long next_present_section_nr(unsigned long section_nr)
diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 72f5ebc5c97a..0b217d4ae2a4 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -186,6 +186,8 @@ struct ip_set_type_variant {
 	/* Return true if "b" set is the same as "a"
 	 * according to the create set parameters */
 	bool (*same_set)(const struct ip_set *a, const struct ip_set *b);
+	/* Cancel ongoing garbage collectors before destroying the set*/
+	void (*cancel_gc)(struct ip_set *set);
 	/* Region-locking is used */
 	bool region_lock;
 };
@@ -242,6 +244,8 @@ extern void ip_set_type_unregister(struct ip_set_type *set_type);
 
 /* A generic IP set */
 struct ip_set {
+	/* For call_cru in destroy */
+	struct rcu_head rcu;
 	/* The name of the set */
 	char name[IPSET_MAXNAMELEN];
 	/* Lock protecting the set data */
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..73bc67ec2136 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,40 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d2d5e854c692..2590ccda29ab 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2999,6 +2999,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d15190b3e032..0613daf8997a 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -124,6 +124,22 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_has_watch_queue - Check whether the pipe is a watch_queue,
+ * i.e. it was created with O_NOTIFICATION_PIPE
+ * @pipe: The pipe to check
+ *
+ * Return: true if pipe is a watch queue, false otherwise.
+ */
+static inline bool pipe_has_watch_queue(const struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_WATCH_QUEUE
+	return pipe->watch_queue != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * pipe_empty - Return true if the pipe is empty
  * @head: The pipe ring head pointer
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 90eaff8b78fc..7efb10518313 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -542,6 +542,10 @@ static inline void pm_runtime_disable(struct device *dev)
  * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
  * requested (or "autosuspend" will be handled as direct runtime-suspend for
  * it).
+ *
+ * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
+ * at driver exit time unless your driver initially enabled pm_runtime
+ * with devm_pm_runtime_enable() (which handles it for you).
  */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index da184e7b361f..e844834db698 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -382,6 +382,8 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -963,6 +965,13 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_file_ioctl_compat(struct file *file,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 252243c7783d..7a1446a7e336 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -122,6 +122,7 @@ enum landlock_rule_type;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 7d142e8a0550..32d21983c696 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -47,12 +47,6 @@ struct scm_stat {
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-#define unix_state_lock_nested(s) \
-				spin_lock_nested(&unix_sk(s)->lock, \
-				SINGLE_DEPTH_NESTING)
-
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -80,6 +74,20 @@ static inline struct unix_sock *unix_sk(const struct sock *sk)
 	return (struct unix_sock *)sk;
 }
 
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+enum unix_socket_lock_class {
+	U_LOCK_NORMAL,
+	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
+	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+};
+
+static inline void unix_state_lock_nested(struct sock *sk,
+				   enum unix_socket_lock_class subclass)
+{
+	spin_lock_nested(&unix_sk(sk)->lock, subclass);
+}
+
 #define peer_wait peer_wq.wait
 
 long unix_inq_len(struct sock *sk);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d31a18824cd5..798aad21694e 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -335,4 +335,12 @@ static inline bool inet_csk_has_ulp(struct sock *sk)
 	return inet_sk(sk)->is_icsk && !!inet_csk(sk)->icsk_ulp_ops;
 }
 
+static inline void inet_init_csk_locks(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
+	spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
+}
+
 #endif /* _INET_CONNECTION_SOCK_H */
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 49aa79c7b278..581cd37aa98b 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,8 +262,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
+	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
 /**
@@ -275,8 +274,7 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
+	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
 /**
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 8e9c5bc1a9e6..1e6e4af4df0a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1253,6 +1253,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
  *	@type: stateful object numeric type
  *	@owner: module owner
  *	@maxattr: maximum netlink attribute
+ *	@family: address family for AF-specific object types
  *	@policy: netlink attribute policy
  */
 struct nft_object_type {
@@ -1262,6 +1263,7 @@ struct nft_object_type {
 	struct list_head		list;
 	u32				type;
 	unsigned int                    maxattr;
+	u8				family;
 	struct module			*owner;
 	const struct nla_policy		*policy;
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5f4513f2d41d..493b10b9fedd 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -310,6 +310,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
+#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
@@ -578,6 +579,9 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_START_IO)
+
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 07871c8a0601..62cc780a168a 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -266,9 +266,11 @@ enum nft_rule_attributes {
 /**
  * enum nft_rule_compat_flags - nf_tables rule compat flags
  *
+ * @NFT_RULE_COMPAT_F_UNUSED: unused
  * @NFT_RULE_COMPAT_F_INV: invert the check result
  */
 enum nft_rule_compat_flags {
+	NFT_RULE_COMPAT_F_UNUSED = (1 << 0),
 	NFT_RULE_COMPAT_F_INV	= (1 << 1),
 	NFT_RULE_COMPAT_F_MASK	= NFT_RULE_COMPAT_F_INV,
 };
diff --git a/kernel/async.c b/kernel/async.c
index b2c4ba5686ee..673bba6bdf3a 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -145,6 +145,39 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
+static async_cookie_t __async_schedule_node_domain(async_func_t func,
+						   void *data, int node,
+						   struct async_domain *domain,
+						   struct async_entry *entry)
+{
+	async_cookie_t newcookie;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&entry->domain_list);
+	INIT_LIST_HEAD(&entry->global_list);
+	INIT_WORK(&entry->work, async_run_entry_fn);
+	entry->func = func;
+	entry->data = data;
+	entry->domain = domain;
+
+	spin_lock_irqsave(&async_lock, flags);
+
+	/* allocate cookie and queue */
+	newcookie = entry->cookie = next_cookie++;
+
+	list_add_tail(&entry->domain_list, &domain->pending);
+	if (domain->registered)
+		list_add_tail(&entry->global_list, &async_global_pending);
+
+	atomic_inc(&entry_count);
+	spin_unlock_irqrestore(&async_lock, flags);
+
+	/* schedule for execution */
+	queue_work_node(node, system_unbound_wq, &entry->work);
+
+	return newcookie;
+}
+
 /**
  * async_schedule_node_domain - NUMA specific version of async_schedule_domain
  * @func: function to execute asynchronously
@@ -186,29 +219,8 @@ async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
 		func(data, newcookie);
 		return newcookie;
 	}
-	INIT_LIST_HEAD(&entry->domain_list);
-	INIT_LIST_HEAD(&entry->global_list);
-	INIT_WORK(&entry->work, async_run_entry_fn);
-	entry->func = func;
-	entry->data = data;
-	entry->domain = domain;
-
-	spin_lock_irqsave(&async_lock, flags);
-
-	/* allocate cookie and queue */
-	newcookie = entry->cookie = next_cookie++;
-
-	list_add_tail(&entry->domain_list, &domain->pending);
-	if (domain->registered)
-		list_add_tail(&entry->global_list, &async_global_pending);
-
-	atomic_inc(&entry_count);
-	spin_unlock_irqrestore(&async_lock, flags);
-
-	/* schedule for execution */
-	queue_work_node(node, system_unbound_wq, &entry->work);
 
-	return newcookie;
+	return __async_schedule_node_domain(func, data, node, domain, entry);
 }
 EXPORT_SYMBOL_GPL(async_schedule_node_domain);
 
@@ -231,6 +243,35 @@ async_cookie_t async_schedule_node(async_func_t func, void *data, int node)
 }
 EXPORT_SYMBOL_GPL(async_schedule_node);
 
+/**
+ * async_schedule_dev_nocall - A simplified variant of async_schedule_dev()
+ * @func: function to execute asynchronously
+ * @dev: device argument to be passed to function
+ *
+ * @dev is used as both the argument for the function and to provide NUMA
+ * context for where to run the function.
+ *
+ * If the asynchronous execution of @func is scheduled successfully, return
+ * true. Otherwise, do nothing and return false, unlike async_schedule_dev()
+ * that will run the function synchronously then.
+ */
+bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
+{
+	struct async_entry *entry;
+
+	entry = kzalloc(sizeof(struct async_entry), GFP_KERNEL);
+
+	/* Give up if there is no memory or too much work. */
+	if (!entry || atomic_read(&entry_count) > MAX_WORK) {
+		kfree(entry);
+		return false;
+	}
+
+	__async_schedule_node_domain(func, dev, dev_to_node(dev),
+				     &async_dfl_domain, entry);
+	return true;
+}
+
 /**
  * async_synchronize_full - synchronize all asynchronous function calls
  *
diff --git a/kernel/audit.c b/kernel/audit.c
index 94ded5de9131..82b6fea46e20 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -490,15 +490,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+		      struct sk_buff *skb, bool *ack)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct nlmsghdr *nlh;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -510,6 +514,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	/* send the ack now to avoid a race with the queue backlog */
+	if (*ack) {
+		nlh = nlmsg_hdr(skb);
+		netlink_ack(skb, nlh, 0, NULL);
+		*ack = false;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1203,7 +1214,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1296,7 +1308,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1541,9 +1554,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
 {
 	struct nlmsghdr *nlh;
+	bool ack;
 	/*
 	 * len MUST be signed for nlmsg_next to be able to dec it below 0
 	 * if the nlmsg_len was not aligned
@@ -1556,9 +1570,12 @@ static void audit_receive(struct sk_buff  *skb)
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		ack = nlh->nlmsg_flags & NLM_F_ACK;
+		err = audit_receive_msg(skb, nlh, &ack);
+
+		/* send an ack if the user asked for one and audit_receive_msg
+		 * didn't already do it, or if there was an error. */
+		if (ack || err)
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 23ffb8f0b5d7..c76870bfd816 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -811,7 +811,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	}
 
 	if (old_ptr)
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 	return 0;
 }
 
@@ -834,7 +834,7 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 		return 0;
 	} else {
 		return -ENOENT;
@@ -858,8 +858,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	return prog;
 }
 
-static void prog_fd_array_put_ptr(void *ptr)
+static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_prog is freed after one RCU or tasks trace grace period */
 	bpf_prog_put(ptr);
 }
 
@@ -1148,8 +1149,9 @@ static void *perf_event_fd_array_get_ptr(struct bpf_map *map,
 	return ee;
 }
 
-static void perf_event_fd_array_put_ptr(void *ptr)
+static void perf_event_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_perf_event is freed after one RCU grace period */
 	bpf_event_entry_free_rcu(ptr);
 }
 
@@ -1204,7 +1206,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
 	return cgroup_get_from_fd(fd);
 }
 
-static void cgroup_fd_array_put_ptr(void *ptr)
+static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* cgroup_put free cgrp after a rcu grace period */
 	cgroup_put(ptr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a63c68f5945c..28b43642c059 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -857,7 +857,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (map->ops->map_fd_put_ptr) {
 		ptr = fd_htab_map_get_ptr(map, l);
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
 
@@ -2330,7 +2330,7 @@ static void fd_htab_map_free(struct bpf_map *map)
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			void *ptr = fd_htab_map_get_ptr(map, l);
 
-			map->ops->map_fd_put_ptr(ptr);
+			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
 	}
 
@@ -2371,7 +2371,7 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
 	if (ret)
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, false);
 
 	return ret;
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 5cd8f5277279..af0f15db1bf9 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -108,7 +108,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	return inner_map;
 }
 
-void bpf_map_fd_put_ptr(void *ptr)
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* ptr->ops->map_free() has to go through one
 	 * rcu grace period by itself.
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index bcb7534afb3c..7d61602354de 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -13,7 +13,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd);
 void bpf_map_meta_free(struct bpf_map *map_meta);
 void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
-void bpf_map_fd_put_ptr(void *ptr);
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 #endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dbe98040e855..64206856a05c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1314,6 +1314,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1372,6 +1375,9 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ada7ef0eb639..4e5a73c7db12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11220,9 +11220,30 @@ static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_nr_addr_filters.attr,
+	NULL,
+};
+
+static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (n == 2 && !pmu->nr_addr_filters)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group pmu_dev_attr_group = {
+	.is_visible = pmu_dev_is_visible,
+	.attrs = pmu_dev_attrs,
+};
+
+static const struct attribute_group *pmu_dev_groups[] = {
+	&pmu_dev_attr_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmu_dev);
 
 static int pmu_bus_running;
 static struct bus_type pmu_bus = {
@@ -11258,18 +11279,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
-	/* For PMUs with address filters, throw in an extra attribute: */
-	if (pmu->nr_addr_filters)
-		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
-
-	if (ret)
-		goto del_dev;
-
-	if (pmu->attr_update)
+	if (pmu->attr_update) {
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
-
-	if (ret)
-		goto del_dev;
+		if (ret)
+			goto del_dev;
+	}
 
 out:
 	return ret;
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f3a1086f7cdb..6146c746371c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -603,11 +603,11 @@ static int crc32_threadfn(void *data)
 	unsigned i;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -616,7 +616,7 @@ static int crc32_threadfn(void *data)
 		for (i = 0; i < d->run_threads; i++)
 			*d->crc32 = crc32_le(*d->crc32,
 			                     d->unc[i], *d->unc_len[i]);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -646,12 +646,12 @@ static int lzo_compress_threadfn(void *data)
 	struct cmp_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -660,7 +660,7 @@ static int lzo_compress_threadfn(void *data)
 		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
 		                          d->cmp + LZO_HEADER, &d->cmp_len,
 		                          d->wrk);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -798,7 +798,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 			data[thr].unc_len = off;
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -806,12 +806,12 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			break;
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -850,7 +850,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			}
 		}
 
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 
@@ -1132,12 +1132,12 @@ static int lzo_decompress_threadfn(void *data)
 	struct dec_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -1150,7 +1150,7 @@ static int lzo_decompress_threadfn(void *data)
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
 
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -1338,7 +1338,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read(&crc->stop));
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));
 			atomic_set(&crc->stop, 0);
 			crc->run_threads = 0;
 		}
@@ -1374,7 +1374,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 					pg = 0;
 			}
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -1393,7 +1393,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -1424,7 +1424,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				ret = snapshot_write_next(snapshot);
 				if (ret <= 0) {
 					crc->run_threads = thr + 1;
-					atomic_set(&crc->ready, 1);
+					atomic_set_release(&crc->ready, 1);
 					wake_up(&crc->go);
 					goto out_finish;
 				}
@@ -1432,13 +1432,13 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 	}
 
 out_finish:
 	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 3d2825408e3a..0836235bbd59 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -162,6 +162,8 @@
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK		\
 	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
 
+static DEFINE_MUTEX(membarrier_ipi_mutex);
+
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
@@ -259,6 +261,7 @@ static int membarrier_global_expedited(void)
 	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -304,6 +307,8 @@ static int membarrier_global_expedited(void)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
+
 	return 0;
 }
 
@@ -347,6 +352,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 
 	if (cpu_id >= 0) {
@@ -419,6 +425,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }
@@ -460,6 +467,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
 	 */
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -476,6 +484,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 97ec98041f92..7d6d87a22ad5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -120,6 +120,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -138,6 +139,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -390,8 +392,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -461,6 +463,27 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_interval) {
+				watchdog_max_interval = interval;
+				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
+					cs_nsec, wd_nsec);
+			}
+			watchdog_timer.expires = jiffies;
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index eebd0f31daa8..5502c687bd40 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1082,6 +1082,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2180,6 +2181,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2247,6 +2249,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
@@ -2263,7 +2266,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2290,6 +2293,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2309,7 +2319,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2317,7 +2327,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8f4788be9e85..ae1b207c6447 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1529,6 +1529,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1537,9 +1538,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 374cfba6c306..d9bed77f96c1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1061,7 +1061,7 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bac5505b243e..87ad97dbe8a4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -40,6 +40,7 @@
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
+#include <linux/kmemleak.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
@@ -2236,7 +2237,7 @@ struct saved_cmdlines_buffer {
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	char *saved_cmdlines;
+	char saved_cmdlines[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
@@ -2250,47 +2251,60 @@ static inline void set_cmdline(int idx, const char *cmdline)
 	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
-static int allocate_cmdlines_buffer(unsigned int val,
-				    struct saved_cmdlines_buffer *s)
+static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 {
+	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+
+	kfree(s->map_cmdline_to_pid);
+	kmemleak_free(s);
+	free_pages((unsigned long)s, order);
+}
+
+static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
+{
+	struct saved_cmdlines_buffer *s;
+	struct page *page;
+	int orig_size, size;
+	int order;
+
+	/* Figure out how much is needed to hold the given number of cmdlines */
+	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	order = get_order(orig_size);
+	size = 1 << (order + PAGE_SHIFT);
+	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return NULL;
+
+	s = page_address(page);
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
+	memset(s, 0, sizeof(*s));
+
+	/* Round up to actual allocation */
+	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	s->cmdline_num = val;
+
 	s->map_cmdline_to_pid = kmalloc_array(val,
 					      sizeof(*s->map_cmdline_to_pid),
 					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid)
-		return -ENOMEM;
-
-	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
-	if (!s->saved_cmdlines) {
-		kfree(s->map_cmdline_to_pid);
-		return -ENOMEM;
+	if (!s->map_cmdline_to_pid) {
+		free_saved_cmdlines_buffer(s);
+		return NULL;
 	}
 
 	s->cmdline_idx = 0;
-	s->cmdline_num = val;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
 	       val * sizeof(*s->map_cmdline_to_pid));
 
-	return 0;
+	return s;
 }
 
 static int trace_create_savedcmd(void)
 {
-	int ret;
-
-	savedcmd = kmalloc(sizeof(*savedcmd), GFP_KERNEL);
-	if (!savedcmd)
-		return -ENOMEM;
+	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
 
-	ret = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT, savedcmd);
-	if (ret < 0) {
-		kfree(savedcmd);
-		savedcmd = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
+	return savedcmd ? 0 : -ENOMEM;
 }
 
 int is_tracing_stopped(void)
@@ -5947,26 +5961,14 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-{
-	kfree(s->saved_cmdlines);
-	kfree(s->map_cmdline_to_pid);
-	kfree(s);
-}
-
 static int tracing_resize_saved_cmdlines(unsigned int val)
 {
 	struct saved_cmdlines_buffer *s, *savedcmd_temp;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = allocate_cmdlines_buffer(val);
 	if (!s)
 		return -ENOMEM;
 
-	if (allocate_cmdlines_buffer(val, s) < 0) {
-		kfree(s);
-		return -ENOMEM;
-	}
-
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 106f9813841a..dfdbcf1da216 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1161,8 +1161,10 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, ops, data, file);
 }
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9628b5571846..3edf5e515813 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				}
 
 				memcpy(elt->key, key, map->key_size);
-				entry->val = elt;
+				/*
+				 * Ensure the initialization is visible and
+				 * publish the elt.
+				 */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
 				atomic64_inc(&map->hits);
 
 				return entry->val;
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 579406c1e9ed..09fddc0ea6d3 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -593,9 +593,8 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	/*
@@ -621,24 +620,18 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
-		break;
-
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
-
-	case ODEBUG_STATE_DESTROYED:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
 		return;
 	default:
 		break;
 	}
 
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "init");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_init, addr, o.state);
 }
 
 /**
@@ -679,11 +672,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	int ret;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -693,49 +684,38 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	if (likely(!IS_ERR_OR_NULL(obj))) {
-		bool print_object = false;
-
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return 0;
+	} else if (likely(!IS_ERR(obj))) {
 		switch (obj->state) {
-		case ODEBUG_STATE_INIT:
-		case ODEBUG_STATE_INACTIVE:
-			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
-			break;
-
 		case ODEBUG_STATE_ACTIVE:
-			state = obj->state;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_print_object(obj, "activate");
-			ret = debug_object_fixup(descr->fixup_activate, addr, state);
-			return ret ? 0 : -EINVAL;
-
 		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			ret = -EINVAL;
+			o = *obj;
 			break;
+		case ODEBUG_STATE_INIT:
+		case ODEBUG_STATE_INACTIVE:
+			obj->state = ODEBUG_STATE_ACTIVE;
+			fallthrough;
 		default:
-			ret = 0;
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return 0;
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		if (print_object)
-			debug_print_object(obj, "activate");
-		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "activate");
 
-	/* If NULL the allocation has hit OOM */
-	if (!obj) {
-		debug_objects_oom();
-		return 0;
+	switch (o.state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_NOTAVAILABLE:
+		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
-
-	/* Object is neither static nor tracked. It's not initialized */
-	debug_print_object(&o, "activate");
-	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
-	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -746,10 +726,10 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  */
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -761,33 +741,24 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 	obj = lookup_object(addr, db);
 	if (obj) {
 		switch (obj->state) {
+		case ODEBUG_STATE_DESTROYED:
+			break;
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
-				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				print_object = true;
-			break;
-
-		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			break;
+			if (obj->astate)
+				break;
+			obj->state = ODEBUG_STATE_INACTIVE;
+			fallthrough;
 		default:
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "deactivate");
-	} else if (print_object) {
-		debug_print_object(obj, "deactivate");
-	}
+	debug_print_object(&o, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -798,11 +769,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  */
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -812,32 +781,31 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_DESTROYED:
+		break;
 	case ODEBUG_STATE_NONE:
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_DESTROYED;
-		break;
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
+		fallthrough;
+	default:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "destroy");
-		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
-
-	case ODEBUG_STATE_DESTROYED:
-		print_object = true;
-		break;
-	default:
-		break;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (print_object)
-		debug_print_object(obj, "destroy");
+	debug_print_object(&o, "destroy");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_destroy, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -848,9 +816,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  */
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
@@ -861,24 +828,26 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "free");
-		debug_object_fixup(descr->fixup_free, addr, state);
-		return;
+		break;
 	default:
 		hlist_del(&obj->node);
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		free_object(obj);
 		return;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "free");
+
+	debug_object_fixup(descr->fixup_free, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_free);
 
@@ -928,10 +897,10 @@ void
 debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -944,28 +913,19 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
-				obj->astate = next;
-			else
-				print_object = true;
-			break;
-
+			if (obj->astate != expect)
+				break;
+			obj->astate = next;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		default:
-			print_object = true;
 			break;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "active_state");
-	} else if (print_object) {
-		debug_print_object(obj, "active_state");
-	}
+	debug_print_object(&o, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -973,12 +933,10 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	const struct debug_obj_descr *descr;
-	enum debug_obj_state state;
+	int cnt, objs_checked = 0;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -1000,12 +958,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				descr = obj->descr;
-				state = obj->state;
+				o = *obj;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
-				debug_print_object(obj, "free");
-				debug_object_fixup(descr->fixup_free,
-						   (void *) oaddr, state);
+				debug_print_object(&o, "free");
+				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
diff --git a/lib/mpi/ec.c b/lib/mpi/ec.c
index 40f5908e57a4..e16dca1e23d5 100644
--- a/lib/mpi/ec.c
+++ b/lib/mpi/ec.c
@@ -584,6 +584,9 @@ void mpi_ec_init(struct mpi_ec_ctx *ctx, enum gcry_mpi_ec_models model,
 	ctx->a = mpi_copy(a);
 	ctx->b = mpi_copy(b);
 
+	ctx->d = NULL;
+	ctx->t.two_inv_p = NULL;
+
 	ctx->t.p_barrett = use_barrett > 0 ? mpi_barrett_init(ctx->p, 0) : NULL;
 
 	mpi_ec_get_reset(ctx);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8ca6617b2a72..f57a659b2218 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1529,7 +1529,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
diff --git a/mm/sparse.c b/mm/sparse.c
index 120bc8ea5293..27092badd15b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -789,6 +789,13 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
+		/*
+		 * Mark the section invalid so that valid_section()
+		 * return false. This prevents code from dereferencing
+		 * ms->usage array.
+		 */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
+
 		/*
 		 * When removing an early section, the usage map is kept (as the
 		 * usage maps of other sections fall into the same page). It
@@ -797,16 +804,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			kfree(ms->usage);
-			ms->usage = NULL;
+			kfree_rcu(ms->usage, rcu);
+			WRITE_ONCE(ms->usage, NULL);
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		/*
-		 * Mark the section invalid so that valid_section()
-		 * return false. This prevents code from dereferencing
-		 * ms->usage array.
-		 */
-		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
 	/*
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 53b1955b027f..dca1ec705b6c 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -118,12 +118,16 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 	if (data[IFLA_VLAN_INGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_INGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			vlan_dev_set_ingress_priority(dev, m->to, m->from);
 		}
 	}
 	if (data[IFLA_VLAN_EGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_EGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			err = vlan_dev_set_egress_priority(dev, m->from, m->to);
 			if (err)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9f3596de90a7..850b6aab7377 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6527,7 +6527,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
 			l2cap_sig_send_rej(conn, cmd->ident);
-			break;
+			skb_pull(skb, len > skb->len ? skb->len : len);
+			continue;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
index 5c4c369f8536..2faab44652e7 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -362,7 +362,7 @@ static int br_cc_ccm_tx_parse(struct net_bridge *br, struct nlattr *attr,
 
 	memset(&tx_info, 0, sizeof(tx_info));
 
-	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_RDI_INSTANCE]);
+	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE]);
 	nla_memcpy(&tx_info.dmac.addr,
 		   tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC],
 		   sizeof(tx_info.dmac.addr));
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index db4f2641d1cd..9765f9f9bf7f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1607,6 +1607,10 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
+static void br_multicast_query_delay_expired(struct timer_list *t)
+{
+}
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -3024,7 +3028,7 @@ br_multicast_update_query_timer(struct net_bridge_mcast *brmctx,
 				unsigned long max_delay)
 {
 	if (!timer_pending(&query->timer))
-		query->delay_time = jiffies + max_delay;
+		mod_timer(&query->delay_timer, jiffies + max_delay);
 
 	mod_timer(&query->timer, jiffies + brmctx->multicast_querier_interval);
 }
@@ -3867,13 +3871,11 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_querier_interval = 255 * HZ;
 	brmctx->multicast_membership_interval = 260 * HZ;
 
-	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
-	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
@@ -3882,6 +3884,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip4_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3889,6 +3893,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip6_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip6_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
@@ -4023,10 +4029,12 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
 	del_timer_sync(&brmctx->ip4_mc_router_timer);
 	del_timer_sync(&brmctx->ip4_other_query.timer);
+	del_timer_sync(&brmctx->ip4_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
 	del_timer_sync(&brmctx->ip6_mc_router_timer);
 	del_timer_sync(&brmctx->ip6_other_query.timer);
+	del_timer_sync(&brmctx->ip6_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip6_own_query.timer);
 #endif
 }
@@ -4469,13 +4477,15 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 	max_delay = brmctx->multicast_query_response_interval;
 
 	if (!timer_pending(&brmctx->ip4_other_query.timer))
-		brmctx->ip4_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip4_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip4_own_query);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!timer_pending(&brmctx->ip6_other_query.timer))
-		brmctx->ip6_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip6_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip6_own_query);
 #endif
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bd218c2b2cd9..ff10ddeeb50f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -77,7 +77,7 @@ struct bridge_mcast_own_query {
 /* other querier */
 struct bridge_mcast_other_query {
 	struct timer_list		timer;
-	unsigned long			delay_time;
+	struct timer_list		delay_timer;
 };
 
 /* selected querier */
@@ -1066,7 +1066,7 @@ __br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 		own_querier_enabled = false;
 	}
 
-	return time_is_before_jiffies(querier->delay_time) &&
+	return !timer_pending(&querier->delay_timer) &&
 	       (own_querier_enabled || timer_pending(&querier->timer));
 }
 
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 16af1a7f80f6..31a93cae5111 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -86,7 +86,7 @@ struct j1939_priv {
 	unsigned int tp_max_packet_size;
 
 	/* lock for j1939_socks list */
-	spinlock_t j1939_socks_lock;
+	rwlock_t j1939_socks_lock;
 	struct list_head j1939_socks;
 
 	struct kref rx_kref;
@@ -301,6 +301,7 @@ struct j1939_sock {
 
 	int ifindex;
 	struct j1939_addr addr;
+	spinlock_t filters_lock;
 	struct j1939_filter *filters;
 	int nfilters;
 	pgn_t pgn_rx_filter;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index e82b91509258..0ef399abd097 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -270,7 +270,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		return ERR_PTR(-ENOMEM);
 
 	j1939_tp_init(priv);
-	spin_lock_init(&priv->j1939_socks_lock);
+	rwlock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
 	mutex_lock(&j1939_netdev_lock);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index dfce84f2349f..da538c29c749 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
 	jsk->state |= J1939_SOCK_BOUND;
 	j1939_priv_get(priv);
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_del_init(&jsk->list);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 
 	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
@@ -262,12 +262,17 @@ static bool j1939_sk_match_dst(struct j1939_sock *jsk,
 static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 				  const struct j1939_sk_buff_cb *skcb)
 {
-	const struct j1939_filter *f = jsk->filters;
-	int nfilter = jsk->nfilters;
+	const struct j1939_filter *f;
+	int nfilter;
+
+	spin_lock_bh(&jsk->filters_lock);
+
+	f = jsk->filters;
+	nfilter = jsk->nfilters;
 
 	if (!nfilter)
 		/* receive all when no filters are assigned */
-		return true;
+		goto filter_match_found;
 
 	for (; nfilter; ++f, --nfilter) {
 		if ((skcb->addr.pgn & f->pgn_mask) != f->pgn)
@@ -276,9 +281,15 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 			continue;
 		if ((skcb->addr.src_name & f->name_mask) != f->name)
 			continue;
-		return true;
+		goto filter_match_found;
 	}
+
+	spin_unlock_bh(&jsk->filters_lock);
 	return false;
+
+filter_match_found:
+	spin_unlock_bh(&jsk->filters_lock);
+	return true;
 }
 
 static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
@@ -329,13 +340,13 @@ bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
 	struct j1939_sock *jsk;
 	bool match = false;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		match = j1939_sk_recv_match_one(jsk, skcb);
 		if (match)
 			break;
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 
 	return match;
 }
@@ -344,11 +355,11 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sock *jsk;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		j1939_sk_recv_one(jsk, skb);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_sk_sock_destruct(struct sock *sk)
@@ -401,6 +412,7 @@ static int j1939_sk_init(struct sock *sk)
 	atomic_set(&jsk->skb_pending, 0);
 	spin_lock_init(&jsk->sk_session_queue_lock);
 	INIT_LIST_HEAD(&jsk->sk_session_queue);
+	spin_lock_init(&jsk->filters_lock);
 
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -703,9 +715,11 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		lock_sock(&jsk->sk);
+		spin_lock_bh(&jsk->filters_lock);
 		ofilters = jsk->filters;
 		jsk->filters = filters;
 		jsk->nfilters = count;
+		spin_unlock_bh(&jsk->filters_lock);
 		release_sock(&jsk->sk);
 		kfree(ofilters);
 		return 0;
@@ -1078,12 +1092,12 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	}
 
 	/* spread RX notifications to all sockets subscribed to this session */
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		if (j1939_sk_recv_match_one(jsk, &session->skcb))
 			__j1939_sk_errqueue(session, &jsk->sk, type);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 };
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
@@ -1271,7 +1285,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	struct j1939_sock *jsk;
 	int error_code = ENETDOWN;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		jsk->sk.sk_err = error_code;
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
@@ -1279,7 +1293,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index f35c2e998406..63de5c635842 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -33,9 +33,6 @@
 
 void reqsk_queue_alloc(struct request_sock_queue *queue)
 {
-	spin_lock_init(&queue->rskq_lock);
-
-	spin_lock_init(&queue->fastopenq.lock);
 	queue->fastopenq.rskq_rst_head = NULL;
 	queue->fastopenq.rskq_rst_tail = NULL;
 	queue->fastopenq.qlen = 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7090844af499..3dbefce8d14b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4079,8 +4079,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
+		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len, GSO_BY_FRAGS - 1U) / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 7ce40b49c956..4a50ffc2a70c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -291,7 +291,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "HSR: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
 		return;
 	}
 
@@ -338,7 +338,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "PRP: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
 	}
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e46b11507edc..487f75993bf4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -327,6 +327,9 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
 
@@ -1602,10 +1605,12 @@ EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 {
-	if (sk->sk_family == AF_INET)
+	unsigned int family = READ_ONCE(sk->sk_family);
+
+	if (family == AF_INET)
 		return ip_recv_error(sk, msg, len, addr_len);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	if (family == AF_INET6)
 		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
 #endif
 	return -EINVAL;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index c770719797e1..da43957a5843 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -545,6 +545,10 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 	}
 	if (req)
 		reqsk_put(req);
+
+	if (newsk)
+		inet_init_csk_locks(newsk);
+
 	return newsk;
 out_err:
 	newsk = NULL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a445e4e05e0d..ee4e7e7a0992 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1251,6 +1251,12 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	if (unlikely(!rt))
 		return -EFAULT;
 
+	cork->fragsize = ip_sk_use_pmtu(sk) ?
+			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+
+	if (!inetdev_valid_mtu(cork->fragsize))
+		return -ENETUNREACH;
+
 	/*
 	 * setup for corking.
 	 */
@@ -1267,12 +1273,6 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		cork->addr = ipc->addr;
 	}
 
-	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
-
-	if (!inetdev_valid_mtu(cork->fragsize))
-		return -ENETUNREACH;
-
 	cork->gso_size = ipc->gso_size;
 
 	cork->dst = &rt->dst;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3275d1ed260..50ddbd7021f0 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -332,7 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	};
 	skb_reset_network_header(skb);
 
-	csum = csum_partial(icmp6h, len, 0);
+	csum = skb_checksum(skb, skb_transport_offset(skb), len, 0);
 	icmp6h->icmp6_cksum = csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr, len,
 					      IPPROTO_ICMPV6, csum);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 86dff7abdfd6..626cef75afe7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -722,6 +722,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 		if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTOCORKING);
 			set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
+			smp_mb__after_atomic();
 		}
 		/* It is possible TX completion already happened
 		 * before we set TSQ_THROTTLED.
@@ -1797,7 +1798,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 
 static bool can_map_frag(const skb_frag_t *frag)
 {
-	return skb_frag_size(frag) == PAGE_SIZE && !skb_frag_off(frag);
+	struct page *page;
+
+	if (skb_frag_size(frag) != PAGE_SIZE || skb_frag_off(frag))
+		return false;
+
+	page = skb_frag_page(frag);
+
+	if (PageCompound(page) || page->mapping)
+		return false;
+
+	return true;
 }
 
 static int find_next_mappable_frag(const skb_frag_t *frag,
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index 1d4054bb345b..b2da2abfac82 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -220,19 +220,26 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
-const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
+const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LOOPBACK_INIT;
 EXPORT_SYMBOL(in6addr_loopback);
-const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_any __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_ANY_INIT;
 EXPORT_SYMBOL(in6addr_any);
-const struct in6_addr in6addr_linklocal_allnodes = IN6ADDR_LINKLOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
-const struct in6_addr in6addr_linklocal_allrouters = IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allrouters);
-const struct in6_addr in6addr_interfacelocal_allnodes = IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
-const struct in6_addr in6addr_interfacelocal_allrouters = IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
-const struct in6_addr in6addr_sitelocal_allrouters = IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 164b130203f1..1da7fa58f714 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -198,6 +198,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a41ba4b161c4..d370a71c9752 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -798,9 +798,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
-	struct pcpu_sw_netstats *tstats;
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	int err;
+	const struct ipv6hdr *ipv6h;
+	int nh, err;
 
 	if ((!(tpi->flags & TUNNEL_CSUM) &&
 	     (tunnel->parms.i_flags & TUNNEL_CSUM)) ||
@@ -832,7 +831,6 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 			goto drop;
 		}
 
-		ipv6h = ipv6_hdr(skb);
 		skb->protocol = eth_type_trans(skb, tunnel->dev);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	} else {
@@ -840,7 +838,23 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		skb_reset_mac_header(skb);
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	ipv6h = (struct ipv6hdr *)(skb->head + nh);
+
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 
 	__skb_tunnel_rx(skb, tunnel->dev, tunnel->net);
@@ -858,11 +872,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		}
 	}
 
-	tstats = this_cpu_ptr(tunnel->dev->tstats);
-	u64_stats_update_begin(&tstats->syncp);
-	tstats->rx_packets++;
-	tstats->rx_bytes += skb->len;
-	u64_stats_update_end(&tstats->syncp);
+	dev_sw_netstats_rx_add(tunnel->dev, skb->len);
 
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(tunnel->dev)));
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 8b9a10d10036..70973bf18ee3 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -226,6 +226,8 @@ static int llc_ui_release(struct socket *sock)
 	}
 	dev_put(llc->dev);
 	sock_put(sk);
+	sock_orphan(sk);
+	sock->sk = NULL;
 	llc_sk_free(sk);
 out:
 	return 0;
@@ -926,14 +928,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  */
 static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
+	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	int flags = msg->msg_flags;
 	int noblock = flags & MSG_DONTWAIT;
+	int rc = -EINVAL, copied = 0, hdrlen, hh_len;
 	struct sk_buff *skb = NULL;
+	struct net_device *dev;
 	size_t size = 0;
-	int rc = -EINVAL, copied = 0, hdrlen;
 
 	dprintk("%s: sending from %02X to %02X\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
@@ -953,22 +956,29 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		if (rc)
 			goto out;
 	}
-	hdrlen = llc->dev->hard_header_len + llc_ui_header_len(sk, addr);
+	dev = llc->dev;
+	hh_len = LL_RESERVED_SPACE(dev);
+	hdrlen = llc_ui_header_len(sk, addr);
 	size = hdrlen + len;
-	if (size > llc->dev->mtu)
-		size = llc->dev->mtu;
+	size = min_t(size_t, size, READ_ONCE(dev->mtu));
 	copied = size - hdrlen;
 	rc = -EINVAL;
 	if (copied < 0)
 		goto out;
 	release_sock(sk);
-	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
+	skb = sock_alloc_send_skb(sk, hh_len + size, noblock, &rc);
 	lock_sock(sk);
 	if (!skb)
 		goto out;
-	skb->dev      = llc->dev;
+	if (sock_flag(sk, SOCK_ZAPPED) ||
+	    llc->dev != dev ||
+	    hdrlen != llc_ui_header_len(sk, addr) ||
+	    hh_len != LL_RESERVED_SPACE(dev) ||
+	    size > READ_ONCE(dev->mtu))
+		goto out;
+	skb->dev      = dev;
 	skb->protocol = llc_proto_type(addr->sllc_arphrd);
-	skb_reserve(skb, hdrlen);
+	skb_reserve(skb, hh_len + hdrlen);
 	rc = memcpy_from_msg(skb_put(skb, copied), msg, copied);
 	if (rc)
 		goto out;
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 6e387aadffce..4f16d9c88350 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -135,22 +135,15 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
-static struct packet_type llc_tr_packet_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_TR_802_2),
-	.func = llc_rcv,
-};
-
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
-	dev_add_pack(&llc_tr_packet_type);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
 	dev_remove_pack(&llc_packet_type);
-	dev_remove_pack(&llc_tr_packet_type);
 }
 
 module_init(llc_init);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d5c89c6758f2..481b6b34797d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3746,6 +3746,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			goto begin;
 
 		skb = __skb_dequeue(&tx.skbs);
+		info = IEEE80211_SKB_CB(skb);
 
 		if (!skb_queue_empty(&tx.skbs)) {
 			spin_lock_bh(&fq->lock);
@@ -3790,7 +3791,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 encap_out:
-	IEEE80211_SKB_CB(skb)->control.vif = vif;
+	info->control.vif = vif;
 
 	if (vif &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 62e1875b9290..8d3afa99ef65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2203,9 +2203,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	if (__mptcp_check_fallback(mptcp_sk(sk)))
 		return false;
 
-	if (tcp_rtx_and_write_queues_empty(sk))
-		return false;
-
 	/* the closing socket has some data untransmitted and/or unacked:
 	 * some data in the mptcp rtx queue has not really xmitted yet.
 	 * keep it simple and re-inject the whole mptcp level rtx queue
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 26ab0e9612d8..9523104a90da 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -28,6 +28,7 @@
 #define mtype_del		IPSET_TOKEN(MTYPE, _del)
 #define mtype_list		IPSET_TOKEN(MTYPE, _list)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype			MTYPE
 
 #define get_ext(set, map, id)	((map)->extensions + ((set)->dsize * (id)))
@@ -57,9 +58,6 @@ mtype_destroy(struct ip_set *set)
 {
 	struct mtype *map = set->data;
 
-	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
-
 	if (set->dsize && set->extensions & IPSET_EXT_DESTROY)
 		mtype_ext_cleanup(set);
 	ip_set_free(map->members);
@@ -288,6 +286,15 @@ mtype_gc(struct timer_list *t)
 	add_timer(&map->gc);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct mtype *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		del_timer_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant mtype = {
 	.kadt	= mtype_kadt,
 	.uadt	= mtype_uadt,
@@ -301,6 +308,7 @@ static const struct ip_set_type_variant mtype = {
 	.head	= mtype_head,
 	.list	= mtype_list,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 };
 
 #endif /* __IP_SET_BITMAP_IP_GEN_H */
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 978014928d07..01cedf416b10 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1156,6 +1156,7 @@ static int ip_set_create(struct sk_buff *skb, const struct nfnl_info *info,
 	return ret;
 
 cleanup:
+	set->variant->cancel_gc(set);
 	set->variant->destroy(set);
 put_out:
 	module_put(set->type->me);
@@ -1184,6 +1185,14 @@ ip_set_destroy_set(struct ip_set *set)
 	kfree(set);
 }
 
+static void
+ip_set_destroy_set_rcu(struct rcu_head *head)
+{
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
+
+	ip_set_destroy_set(set);
+}
+
 static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			  const struct nlattr * const attr[])
 {
@@ -1195,8 +1204,6 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-	/* Must wait for flush to be really finished in list:set */
-	rcu_barrier();
 
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
@@ -1208,8 +1215,10 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	 * counter, so if it's already zero, we can proceed
 	 * without holding the lock.
 	 */
-	read_lock_bh(&ip_set_ref_lock);
 	if (!attr[IPSET_ATTR_SETNAME]) {
+		/* Must wait for flush to be really finished in list:set */
+		rcu_barrier();
+		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
 			if (s && (s->ref || s->ref_netlink)) {
@@ -1223,6 +1232,8 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			s = ip_set(inst, i);
 			if (s) {
 				ip_set(inst, i) = NULL;
+				/* Must cancel garbage collectors */
+				s->variant->cancel_gc(s);
 				ip_set_destroy_set(s);
 			}
 		}
@@ -1230,6 +1241,9 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		inst->is_destroyed = false;
 	} else {
 		u32 flags = flag_exist(info->nlh);
+		u16 features = 0;
+
+		read_lock_bh(&ip_set_ref_lock);
 		s = find_set_and_id(inst, nla_data(attr[IPSET_ATTR_SETNAME]),
 				    &i);
 		if (!s) {
@@ -1240,10 +1254,16 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
-
-		ip_set_destroy_set(s);
+		if (features & IPSET_TYPE_NAME) {
+			/* Must wait for flush to be really finished  */
+			rcu_barrier();
+		}
+		/* Must cancel garbage collectors */
+		s->variant->cancel_gc(s);
+		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
 out:
@@ -1396,9 +1416,6 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
-	/* Make sure all readers of the old set pointers are completed. */
-	synchronize_rcu();
-
 	return 0;
 }
 
@@ -2362,6 +2379,7 @@ ip_set_net_exit(struct net *net)
 		set = ip_set(inst, i);
 		if (set) {
 			ip_set(inst, i) = NULL;
+			set->variant->cancel_gc(set);
 			ip_set_destroy_set(set);
 		}
 	}
@@ -2409,8 +2427,11 @@ ip_set_fini(void)
 {
 	nf_unregister_sockopt(&so_set);
 	nfnetlink_subsys_unregister(&ip_set_netlink_subsys);
-
 	unregister_pernet_subsys(&ip_set_net_ops);
+
+	/* Wait for call_rcu() in destroy */
+	rcu_barrier();
+
 	pr_debug("these are the famous last words\n");
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 7499192af586..ef04e556aadb 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -210,6 +210,7 @@ htable_size(u8 hbits)
 #undef mtype_gc_do
 #undef mtype_gc
 #undef mtype_gc_init
+#undef mtype_cancel_gc
 #undef mtype_variant
 #undef mtype_data_match
 
@@ -254,6 +255,7 @@ htable_size(u8 hbits)
 #define mtype_gc_do		IPSET_TOKEN(MTYPE, _gc_do)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
 #define mtype_gc_init		IPSET_TOKEN(MTYPE, _gc_init)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype_variant		IPSET_TOKEN(MTYPE, _variant)
 #define mtype_data_match	IPSET_TOKEN(MTYPE, _data_match)
 
@@ -417,7 +419,7 @@ mtype_ahash_destroy(struct ip_set *set, struct htable *t, bool ext_destroy)
 	u32 i;
 
 	for (i = 0; i < jhash_size(t->htable_bits); i++) {
-		n = __ipset_dereference(hbucket(t, i));
+		n = (__force struct hbucket *)hbucket(t, i);
 		if (!n)
 			continue;
 		if (set->extensions & IPSET_EXT_DESTROY && ext_destroy)
@@ -437,10 +439,7 @@ mtype_destroy(struct ip_set *set)
 	struct htype *h = set->data;
 	struct list_head *l, *lt;
 
-	if (SET_WITH_TIMEOUT(set))
-		cancel_delayed_work_sync(&h->gc.dwork);
-
-	mtype_ahash_destroy(set, ipset_dereference_nfnl(h->table), true);
+	mtype_ahash_destroy(set, (__force struct htable *)h->table, true);
 	list_for_each_safe(l, lt, &h->ad) {
 		list_del(l);
 		kfree(l);
@@ -586,6 +585,15 @@ mtype_gc_init(struct htable_gc *gc)
 	queue_delayed_work(system_power_efficient_wq, &gc->dwork, HZ);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct htype *h = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		cancel_delayed_work_sync(&h->gc.dwork);
+}
+
 static int
 mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	  struct ip_set_ext *mext, u32 flags);
@@ -1416,6 +1424,7 @@ static const struct ip_set_type_variant mtype_variant = {
 	.uref	= mtype_uref,
 	.resize	= mtype_resize,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 	.region_lock = true,
 };
 
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 5a67f7966574..6bc7019982b0 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -426,9 +426,6 @@ list_set_destroy(struct ip_set *set)
 	struct list_set *map = set->data;
 	struct set_elem *e, *n;
 
-	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
-
 	list_for_each_entry_safe(e, n, &map->members, list) {
 		list_del(&e->list);
 		ip_set_put_byindex(map->net, e->id);
@@ -545,6 +542,15 @@ list_set_same_set(const struct ip_set *a, const struct ip_set *b)
 	       a->extensions == b->extensions;
 }
 
+static void
+list_set_cancel_gc(struct ip_set *set)
+{
+	struct list_set *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		del_timer_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant set_variant = {
 	.kadt	= list_set_kadt,
 	.uadt	= list_set_uadt,
@@ -558,6 +564,7 @@ static const struct ip_set_type_variant set_variant = {
 	.head	= list_set_head,
 	.list	= list_set_list,
 	.same_set = list_set_same_set,
+	.cancel_gc = list_set_cancel_gc,
 };
 
 static void
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index edee7fa944c1..8f5362a19b15 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -193,11 +193,12 @@ void nf_logger_put(int pf, enum nf_log_type type)
 		return;
 	}
 
-	BUG_ON(loggers[pf][type] == NULL);
-
 	rcu_read_lock();
 	logger = rcu_dereference(loggers[pf][type]);
-	module_put(logger->me);
+	if (!logger)
+		WARN_ON_ONCE(1);
+	else
+		module_put(logger->me);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nf_logger_put);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e2e3ccbb635f..3ad2b22886ff 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -24,6 +24,7 @@
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
+#define NFT_SET_MAX_ANONLEN 16
 
 unsigned int nf_tables_net_id __read_mostly;
 
@@ -4057,6 +4058,9 @@ static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
 		if (p[1] != 'd' || strchr(p + 2, '%'))
 			return -EINVAL;
 
+		if (strnlen(name, NFT_SET_MAX_ANONLEN) >= NFT_SET_MAX_ANONLEN)
+			return -EINVAL;
+
 		inuse = (unsigned long *)get_zeroed_page(GFP_KERNEL);
 		if (inuse == NULL)
 			return -ENOMEM;
@@ -6995,11 +6999,15 @@ static int nft_object_dump(struct sk_buff *skb, unsigned int attr,
 	return -1;
 }
 
-static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
+static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
 	list_for_each_entry(type, &nf_tables_objects, list) {
+		if (type->family != NFPROTO_UNSPEC &&
+		    type->family != family)
+			continue;
+
 		if (objtype == type->type)
 			return type;
 	}
@@ -7007,11 +7015,11 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
 }
 
 static const struct nft_object_type *
-nft_obj_type_get(struct net *net, u32 objtype)
+nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	type = __nft_obj_type_get(objtype);
+	type = __nft_obj_type_get(objtype, family);
 	if (type != NULL && try_module_get(type->owner))
 		return type;
 
@@ -7104,7 +7112,7 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 		if (info->nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		type = __nft_obj_type_get(objtype);
+		type = __nft_obj_type_get(objtype, family);
 		if (WARN_ON_ONCE(!type))
 			return -ENOENT;
 
@@ -7118,7 +7126,7 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 	if (!nft_use_inc(&table->use))
 		return -EMFILE;
 
-	type = nft_obj_type_get(net, objtype);
+	type = nft_obj_type_get(net, objtype, family);
 	if (IS_ERR(type)) {
 		err = PTR_ERR(type);
 		goto err_type;
@@ -10247,16 +10255,10 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
-	default:
-		switch (data->verdict.code & NF_VERDICT_MASK) {
-		case NF_ACCEPT:
-		case NF_DROP:
-		case NF_QUEUE:
-			break;
-		default:
-			return -EINVAL;
-		}
-		fallthrough;
+	case NF_ACCEPT:
+	case NF_DROP:
+	case NF_QUEUE:
+		break;
 	case NFT_CONTINUE:
 	case NFT_BREAK:
 	case NFT_RETURN:
@@ -10291,6 +10293,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 		data->verdict.chain = chain;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	desc->len = sizeof(data->verdict);
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 5b02408a920b..35aa4ea94205 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -355,9 +355,10 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 				  unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nft_base_chain *basechain;
 	struct nftables_pernet *nft_net;
-	struct nft_table *table;
 	struct nft_chain *chain, *nr;
+	struct nft_table *table;
 	struct nft_ctx ctx = {
 		.net	= dev_net(dev),
 	};
@@ -369,7 +370,8 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	nft_net = nft_pernet(ctx.net);
 	mutex_lock(&nft_net->commit_mutex);
 	list_for_each_entry(table, &nft_net->tables, list) {
-		if (table->family != NFPROTO_NETDEV)
+		if (table->family != NFPROTO_NETDEV &&
+		    table->family != NFPROTO_INET)
 			continue;
 
 		ctx.family = table->family;
@@ -378,6 +380,11 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 			if (!nft_is_base_chain(chain))
 				continue;
 
+			basechain = nft_base_chain(chain);
+			if (table->family == NFPROTO_INET &&
+			    basechain->ops.hooknum != NF_INET_INGRESS)
+				continue;
+
 			ctx.chain = chain;
 			nft_netdev_event(event, dev, &ctx);
 		}
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index f69cc73c5813..64a2a5f19589 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -200,6 +200,7 @@ static const struct nla_policy nft_rule_compat_policy[NFTA_RULE_COMPAT_MAX + 1]
 static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 {
 	struct nlattr *tb[NFTA_RULE_COMPAT_MAX+1];
+	u32 l4proto;
 	u32 flags;
 	int err;
 
@@ -212,12 +213,18 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 		return -EINVAL;
 
 	flags = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_FLAGS]));
-	if (flags & ~NFT_RULE_COMPAT_F_MASK)
+	if (flags & NFT_RULE_COMPAT_F_UNUSED ||
+	    flags & ~NFT_RULE_COMPAT_F_MASK)
 		return -EINVAL;
 	if (flags & NFT_RULE_COMPAT_F_INV)
 		*inv = true;
 
-	*proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	l4proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	if (l4proto > U16_MAX)
+		return -EINVAL;
+
+	*proto = l4proto;
+
 	return 0;
 }
 
@@ -349,6 +356,12 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -592,6 +605,12 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index bd468e955a21..7c667629c514 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -483,6 +483,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFT_CT_ID:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+
 		len = sizeof(u32);
 		break;
 	default:
@@ -1186,7 +1189,31 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_CT_EXPECT_L3PROTO])
 		priv->l3num = ntohs(nla_get_be16(tb[NFTA_CT_EXPECT_L3PROTO]));
 
+	switch (priv->l3num) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+		if (priv->l3num != ctx->family)
+			return -EINVAL;
+
+		fallthrough;
+	case NFPROTO_INET:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	priv->l4proto = nla_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
+	switch (priv->l4proto) {
+	case IPPROTO_TCP:
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+	case IPPROTO_DCCP:
+	case IPPROTO_SCTP:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	priv->dport = nla_get_be16(tb[NFTA_CT_EXPECT_DPORT]);
 	priv->timeout = nla_get_u32(tb[NFTA_CT_EXPECT_TIMEOUT]);
 	priv->size = nla_get_u8(tb[NFTA_CT_EXPECT_SIZE]);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index a5fc7213be3e..f8346497c9b4 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -357,6 +357,11 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 {
 	unsigned int hook_mask = (1 << NF_INET_FORWARD);
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
 }
 
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index 593fa07f10d5..b23a671fa9d8 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -58,17 +58,19 @@ static inline bool nft_limit_eval(struct nft_limit_priv *priv, u64 cost)
 static int nft_limit_init(struct nft_limit_priv *priv,
 			  const struct nlattr * const tb[], bool pkts)
 {
+	u64 unit, tokens, rate_with_burst;
 	bool invert = false;
-	u64 unit, tokens;
 
 	if (tb[NFTA_LIMIT_RATE] == NULL ||
 	    tb[NFTA_LIMIT_UNIT] == NULL)
 		return -EINVAL;
 
 	priv->rate = be64_to_cpu(nla_get_be64(tb[NFTA_LIMIT_RATE]));
+	if (priv->rate == 0)
+		return -EINVAL;
+
 	unit = be64_to_cpu(nla_get_be64(tb[NFTA_LIMIT_UNIT]));
-	priv->nsecs = unit * NSEC_PER_SEC;
-	if (priv->rate == 0 || priv->nsecs < unit)
+	if (check_mul_overflow(unit, NSEC_PER_SEC, &priv->nsecs))
 		return -EOVERFLOW;
 
 	if (tb[NFTA_LIMIT_BURST])
@@ -77,18 +79,25 @@ static int nft_limit_init(struct nft_limit_priv *priv,
 	if (pkts && priv->burst == 0)
 		priv->burst = NFT_LIMIT_PKT_BURST_DEFAULT;
 
-	if (priv->rate + priv->burst < priv->rate)
+	if (check_add_overflow(priv->rate, priv->burst, &rate_with_burst))
 		return -EOVERFLOW;
 
 	if (pkts) {
-		tokens = div64_u64(priv->nsecs, priv->rate) * priv->burst;
+		u64 tmp = div64_u64(priv->nsecs, priv->rate);
+
+		if (check_mul_overflow(tmp, priv->burst, &tokens))
+			return -EOVERFLOW;
 	} else {
+		u64 tmp;
+
 		/* The token bucket size limits the number of tokens can be
 		 * accumulated. tokens_max specifies the bucket size.
 		 * tokens_max = unit * (rate + burst) / rate.
 		 */
-		tokens = div64_u64(priv->nsecs * (priv->rate + priv->burst),
-				 priv->rate);
+		if (check_mul_overflow(priv->nsecs, rate_with_burst, &tmp))
+			return -EOVERFLOW;
+
+		tokens = div64_u64(tmp, priv->rate);
 	}
 
 	if (tb[NFTA_LIMIT_FLAGS]) {
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index cd4eb4996aff..2e1ee7d9d9c3 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -142,6 +142,11 @@ static int nft_nat_validate(const struct nft_ctx *ctx,
 	struct nft_nat *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	err = nft_chain_validate_dependency(ctx->chain, NFT_CHAIN_T_NAT);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index bcd01a63e38f..f4a96164a5a1 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -166,6 +166,11 @@ static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *exp
 	const struct nft_rt *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->key) {
 	case NFT_RT_NEXTHOP4:
 	case NFT_RT_NEXTHOP6:
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4e1cc31729b8..e1969209b3ab 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,9 +342,6 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_scratch_index);
-
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -412,6 +409,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
@@ -422,15 +420,17 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 	local_bh_disable();
 
-	map_index = raw_cpu_read(nft_pipapo_scratch_index);
-
 	m = rcu_dereference(priv->match);
 
 	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
 		goto out;
 
-	res_map  = *raw_cpu_ptr(m->scratch) + (map_index ? m->bsize_max : 0);
-	fill_map = *raw_cpu_ptr(m->scratch) + (map_index ? 0 : m->bsize_max);
+	scratch = *raw_cpu_ptr(m->scratch);
+
+	map_index = scratch->map_index;
+
+	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
 
@@ -460,7 +460,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
 				  last);
 		if (b < 0) {
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return false;
@@ -477,7 +477,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 * current inactive bitmap is clean and can be reused as
 			 * *next* bitmap (not initial) for the next packet.
 			 */
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return true;
@@ -1101,6 +1101,25 @@ static void pipapo_map(struct nft_pipapo_match *m,
 		f->mt[map[i].to + j].e = e;
 }
 
+/**
+ * pipapo_free_scratch() - Free per-CPU map at original (not aligned) address
+ * @m:		Matching data
+ * @cpu:	CPU number
+ */
+static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int cpu)
+{
+	struct nft_pipapo_scratch *s;
+	void *mem;
+
+	s = *per_cpu_ptr(m->scratch, cpu);
+	if (!s)
+		return;
+
+	mem = s;
+	mem -= s->align_off;
+	kfree(mem);
+}
+
 /**
  * pipapo_realloc_scratch() - Reallocate scratch maps for partial match results
  * @clone:	Copy of matching data with pending insertions and deletions
@@ -1114,12 +1133,13 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	int i;
 
 	for_each_possible_cpu(i) {
-		unsigned long *scratch;
+		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
-		unsigned long *scratch_aligned;
+		void *scratch_aligned;
+		u32 align_off;
 #endif
-
-		scratch = kzalloc_node(bsize_max * sizeof(*scratch) * 2 +
+		scratch = kzalloc_node(struct_size(scratch, map,
+						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
 				       GFP_KERNEL, cpu_to_node(i));
 		if (!scratch) {
@@ -1133,14 +1153,25 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 			return -ENOMEM;
 		}
 
-		kfree(*per_cpu_ptr(clone->scratch, i));
-
-		*per_cpu_ptr(clone->scratch, i) = scratch;
+		pipapo_free_scratch(clone, i);
 
 #ifdef NFT_PIPAPO_ALIGN
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(scratch);
-		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
+		/* Align &scratch->map (not the struct itself): the extra
+		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
+		 * above guarantee we can waste up to those bytes in order
+		 * to align the map field regardless of its offset within
+		 * the struct.
+		 */
+		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
+
+		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
+		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
+		align_off = scratch_aligned - (void *)scratch;
+
+		scratch = scratch_aligned;
+		scratch->align_off = align_off;
 #endif
+		*per_cpu_ptr(clone->scratch, i) = scratch;
 	}
 
 	return 0;
@@ -1294,11 +1325,6 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	if (!new->scratch)
 		goto out_scratch;
 
-#ifdef NFT_PIPAPO_ALIGN
-	new->scratch_aligned = alloc_percpu(*new->scratch_aligned);
-	if (!new->scratch_aligned)
-		goto out_scratch;
-#endif
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(new->scratch, i) = NULL;
 
@@ -1350,10 +1376,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	}
 out_scratch_realloc:
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(new->scratch, i));
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(new->scratch_aligned);
-#endif
+		pipapo_free_scratch(new, i);
 out_scratch:
 	free_percpu(new->scratch);
 	kfree(new);
@@ -1638,13 +1661,9 @@ static void pipapo_free_match(struct nft_pipapo_match *m)
 	int i;
 
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(m->scratch, i));
+		pipapo_free_scratch(m, i);
 
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
-
 	pipapo_free_fields(m);
 
 	kfree(m);
@@ -2132,7 +2151,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 	m->field_count = field_count;
 	m->bsize_max = 0;
 
-	m->scratch = alloc_percpu(unsigned long *);
+	m->scratch = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch) {
 		err = -ENOMEM;
 		goto out_scratch;
@@ -2140,16 +2159,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
-#ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(unsigned long *);
-	if (!m->scratch_aligned) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-	for_each_possible_cpu(i)
-		*per_cpu_ptr(m->scratch_aligned, i) = NULL;
-#endif
-
 	rcu_head_init(&m->rcu);
 
 	nft_pipapo_for_each_field(f, i, m) {
@@ -2180,9 +2189,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	return 0;
 
 out_free:
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
 out_scratch:
 	kfree(m);
@@ -2236,11 +2242,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 
 		nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(m->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(m->scratch, cpu));
+			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
 		pipapo_free_fields(m);
 		kfree(m);
@@ -2253,11 +2256,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		if (priv->dirty)
 			nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(priv->clone->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(priv->clone->scratch, cpu));
+			pipapo_free_scratch(priv->clone, cpu);
 		free_percpu(priv->clone->scratch);
 
 		pipapo_free_fields(priv->clone);
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 25a75591583e..30a3d092cd84 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -130,21 +130,29 @@ struct nft_pipapo_field {
 	union nft_pipapo_map_bucket *mt;
 };
 
+/**
+ * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @map_index:	Current working bitmap index, toggled between field matches
+ * @align_off:	Offset to get the originally allocated address
+ * @map:	store partial matching results during lookup
+ */
+struct nft_pipapo_scratch {
+	u8 map_index;
+	u32 align_off;
+	unsigned long map[];
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
  * @scratch:		Preallocated per-CPU maps for partial matching results
- * @scratch_aligned:	Version of @scratch aligned to NFT_PIPAPO_ALIGN bytes
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
  * @f:			Fields, with lookup and mapping tables
  */
 struct nft_pipapo_match {
 	int field_count;
-#ifdef NFT_PIPAPO_ALIGN
-	unsigned long * __percpu *scratch_aligned;
-#endif
-	unsigned long * __percpu *scratch;
+	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[];
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 6f4116e72958..0d9f8e79eb00 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -71,9 +71,6 @@
 #define NFT_PIPAPO_AVX2_ZERO(reg)					\
 	asm volatile("vpxor %ymm" #reg ", %ymm" #reg ", %ymm" #reg)
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_avx2_scratch_index);
-
 /**
  * nft_pipapo_avx2_prepare() - Prepare before main algorithm body
  *
@@ -1122,11 +1119,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			    const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	unsigned long *res, *fill, *scratch;
+	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
+	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
@@ -1143,15 +1141,16 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	 */
 	kernel_fpu_begin_mask(0);
 
-	scratch = *raw_cpu_ptr(m->scratch_aligned);
+	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		return false;
 	}
-	map_index = raw_cpu_read(nft_pipapo_avx2_scratch_index);
 
-	res  = scratch + (map_index ? m->bsize_max : 0);
-	fill = scratch + (map_index ? 0 : m->bsize_max);
+	map_index = scratch->map_index;
+
+	res  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	/* Starting map doesn't need to be set for this implementation */
 
@@ -1223,7 +1222,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	if (i % 2)
-		raw_cpu_write(nft_pipapo_avx2_scratch_index, !map_index);
+		scratch->map_index = !map_index;
 	kernel_fpu_end();
 
 	return ret >= 0;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index e34662f4a71e..5bf5572e945c 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -235,7 +235,7 @@ static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
 
 static const struct nft_rbtree_elem *
 nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
-		   struct nft_rbtree_elem *rbe, u8 genmask)
+		   struct nft_rbtree_elem *rbe)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
@@ -254,7 +254,7 @@ nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev) &&
-		    nft_set_elem_active(&rbe_prev->ext, genmask))
+		    nft_set_elem_active(&rbe_prev->ext, NFT_GENMASK_ANY))
 			break;
 
 		prev = rb_prev(prev);
@@ -365,7 +365,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
-			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			removed_end = nft_rbtree_gc_elem(set, priv, rbe);
 			if (IS_ERR(removed_end))
 				return PTR_ERR(removed_end);
 
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 1725e7349f3d..3c444fcb20ec 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -214,6 +214,11 @@ static int nft_socket_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_PRE_ROUTING) |
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 1133e06f3c40..0806813d3a76 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -186,7 +186,6 @@ static int nft_synproxy_do_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		err = nf_synproxy_ipv4_init(snet, ctx->net);
 		if (err)
 			goto nf_ct_failure;
@@ -219,7 +218,6 @@ static void nft_synproxy_do_destroy(const struct nft_ctx *ctx)
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		nf_synproxy_ipv4_fini(snet, ctx->net);
 		nf_synproxy_ipv6_fini(snet, ctx->net);
 		break;
@@ -253,6 +251,11 @@ static int nft_synproxy_validate(const struct nft_ctx *ctx,
 				 const struct nft_expr *expr,
 				 const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
 						    (1 << NF_INET_FORWARD));
 }
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index e9679cb4afbe..5c1ef4709c49 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -316,6 +316,11 @@ static int nft_tproxy_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, 1 << NF_INET_PRE_ROUTING);
 }
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 2ee50996da8c..c8822fa8196d 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -684,6 +684,7 @@ static const struct nft_object_ops nft_tunnel_obj_ops = {
 
 static struct nft_object_type nft_tunnel_obj_type __read_mostly = {
 	.type		= NFT_OBJECT_TUNNEL,
+	.family		= NFPROTO_NETDEV,
 	.ops		= &nft_tunnel_obj_ops,
 	.maxattr	= NFTA_TUNNEL_KEY_MAX,
 	.policy		= nft_tunnel_key_policy,
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 3553f89fd057..e96f3420947f 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -233,6 +233,11 @@ static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *e
 	const struct nft_xfrm *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->dir) {
 	case XFRM_POLICY_IN:
 		hooks = (1 << NF_INET_FORWARD) |
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f41e130a812f..2169a9c3da1c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -374,7 +374,7 @@ static void netlink_skb_destructor(struct sk_buff *skb)
 	if (is_vmalloc_addr(skb->head)) {
 		if (!skb->cloned ||
 		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-			vfree(skb->head);
+			vfree_atomic(skb->head);
 
 		skb->head = NULL;
 	}
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 643dfc90b063..419a1d0ba4c9 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1211,6 +1211,10 @@ void nci_free_device(struct nci_dev *ndev)
 {
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
+
+	/* drop partial rx data packet if present */
+	if (ndev->rx_data_reassembly)
+		kfree_skb(ndev->rx_data_reassembly);
 	kfree(ndev);
 }
 EXPORT_SYMBOL(nci_free_device);
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d77c21ff066c..1cf431d04a46 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -47,6 +47,7 @@ struct ovs_len_tbl {
 
 #define OVS_ATTR_NESTED -1
 #define OVS_ATTR_VARIABLE -2
+#define OVS_COPY_ACTIONS_MAX_DEPTH 16
 
 static bool actions_may_change_flow(const struct nlattr *actions)
 {
@@ -2514,13 +2515,15 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log);
+				  u32 mpls_label_count, bool log,
+				  u32 depth);
 
 static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    const struct sw_flow_key *key,
 				    struct sw_flow_actions **sfa,
 				    __be16 eth_type, __be16 vlan_tci,
-				    u32 mpls_label_count, bool log, bool last)
+				    u32 mpls_label_count, bool log, bool last,
+				    u32 depth)
 {
 	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
 	const struct nlattr *probability, *actions;
@@ -2571,7 +2574,8 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -2586,7 +2590,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 				     const struct sw_flow_key *key,
 				     struct sw_flow_actions **sfa,
 				     __be16 eth_type, __be16 vlan_tci,
-				     u32 mpls_label_count, bool log)
+				     u32 mpls_label_count, bool log,
+				     u32 depth)
 {
 	const struct nlattr *attrs[OVS_DEC_TTL_ATTR_MAX + 1];
 	int start, action_start, err, rem;
@@ -2629,7 +2634,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 		return action_start;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa, eth_type,
-				     vlan_tci, mpls_label_count, log);
+				     vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -2643,7 +2649,8 @@ static int validate_and_copy_clone(struct net *net,
 				   const struct sw_flow_key *key,
 				   struct sw_flow_actions **sfa,
 				   __be16 eth_type, __be16 vlan_tci,
-				   u32 mpls_label_count, bool log, bool last)
+				   u32 mpls_label_count, bool log, bool last,
+				   u32 depth)
 {
 	int start, err;
 	u32 exec;
@@ -2663,7 +2670,8 @@ static int validate_and_copy_clone(struct net *net,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, attr, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -3032,7 +3040,7 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 					   struct sw_flow_actions **sfa,
 					   __be16 eth_type, __be16 vlan_tci,
 					   u32 mpls_label_count,
-					   bool log, bool last)
+					   bool log, bool last, u32 depth)
 {
 	const struct nlattr *acts_if_greater, *acts_if_lesser_eq;
 	struct nlattr *a[OVS_CHECK_PKT_LEN_ATTR_MAX + 1];
@@ -3080,7 +3088,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_lesser_eq, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3093,7 +3102,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_greater, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3121,12 +3131,16 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log)
+				  u32 mpls_label_count, bool log,
+				  u32 depth)
 {
 	u8 mac_proto = ovs_key_mac_proto(key);
 	const struct nlattr *a;
 	int rem, err;
 
+	if (depth > OVS_COPY_ACTIONS_MAX_DEPTH)
+		return -EOVERFLOW;
+
 	nla_for_each_nested(a, attr, rem) {
 		/* Expected argument lengths, (u32)-1 for variable length. */
 		static const u32 action_lens[OVS_ACTION_ATTR_MAX + 1] = {
@@ -3321,7 +3335,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_sample(net, a, key, sfa,
 						       eth_type, vlan_tci,
 						       mpls_label_count,
-						       log, last);
+						       log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3392,7 +3406,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_clone(net, a, key, sfa,
 						      eth_type, vlan_tci,
 						      mpls_label_count,
-						      log, last);
+						      log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3406,7 +3420,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 							      eth_type,
 							      vlan_tci,
 							      mpls_label_count,
-							      log, last);
+							      log, last,
+							      depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3416,7 +3431,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 		case OVS_ACTION_ATTR_DEC_TTL:
 			err = validate_and_copy_dec_ttl(net, a, key, sfa,
 							eth_type, vlan_tci,
-							mpls_label_count, log);
+							mpls_label_count, log,
+							depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3456,7 +3472,8 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 	(*sfa)->orig_len = nla_len(attr);
 	err = __ovs_nla_copy_actions(net, attr, key, sfa, key->eth.type,
-				     key->eth.vlan.tci, mpls_label_count, log);
+				     key->eth.vlan.tci, mpls_label_count, log,
+				     0);
 	if (err)
 		ovs_nla_free_flow_actions(*sfa);
 
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index b239120dd9ca..0ec0ae148349 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -419,7 +419,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, sockptr_t optval,
 
 	rs->rs_rx_traces = trace.rx_traces;
 	for (i = 0; i < rs->rs_rx_traces; i++) {
-		if (trace.rx_trace_pos[i] > RDS_MSG_RX_DGRAM_TRACE_MAX) {
+		if (trace.rx_trace_pos[i] >= RDS_MSG_RX_DGRAM_TRACE_MAX) {
 			rs->rs_rx_traces = 0;
 			return -EFAULT;
 		}
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index aab069701398..5d91ef562ff7 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -41,6 +41,14 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	_enter("%d", conn->debug_id);
 
+	if (sp && sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+				  &pkt.ack, sizeof(pkt.ack)) < 0)
+			return;
+		if (pkt.ack.reason == RXRPC_ACK_PING_RESPONSE)
+			return;
+	}
+
 	chan = &conn->channels[channel];
 
 	/* If the last call got moved on whilst we were waiting to run, just
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 6e6aa02c6f9e..249353417a18 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -31,7 +31,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq = 1;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -41,6 +41,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c952986a6aca..d6e3fc402a6f 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -164,7 +164,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	}
 	if (smc->conn.lgr && smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
-	    !list_empty(&smc->conn.lgr->list)) {
+	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
 		struct smc_connection *conn = &smc->conn;
 		struct smcd_diag_dmbinfo dinfo;
 
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 1693f81aae37..e5c67506334e 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -288,8 +288,9 @@ struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
 	return xprt_switch_find_current_entry(head, xpi->xpi_cursor);
 }
 
-bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
-			      const struct sockaddr *sap)
+static
+bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+				const struct sockaddr *sap)
 {
 	struct list_head *head;
 	struct rpc_xprt *pos;
@@ -308,6 +309,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 	return false;
 }
 
+bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+			      const struct sockaddr *sap)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = __rpc_xprt_switch_has_addr(xps, sap);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index dcbae29aa7e0..17e8e6e3670a 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1088,6 +1088,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 16b04e553a6c..265dc665c92a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1192,13 +1192,11 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
-	if (sk1 < sk2) {
-		unix_state_lock(sk1);
-		unix_state_lock_nested(sk2);
-	} else {
-		unix_state_lock(sk2);
-		unix_state_lock_nested(sk1);
-	}
+	if (sk1 > sk2)
+		swap(sk1, sk2);
+
+	unix_state_lock(sk1);
+	unix_state_lock_nested(sk2, U_LOCK_SECOND);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
@@ -1426,7 +1424,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk);
+	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
 	if (sk->sk_state != st) {
 		unix_state_unlock(sk);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index e534e327a6a5..daef19932f78 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -83,7 +83,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 			 * queue lock. With the other's queue locked it's
 			 * OK to lock the state.
 			 */
-			unix_state_lock_nested(req);
+			unix_state_lock_nested(req, U_LOCK_DIAG);
 			peer = unix_sk(req)->peer;
 			buf[i++] = (peer ? sock_i_ino(peer) : 0);
 			unix_state_unlock(req);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dc2763540393..9e1bab97c05b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -314,6 +314,18 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	while (!list_empty(&gc_candidates)) {
+		u = list_entry(gc_candidates.next, struct unix_sock, link);
+		if (u->oob_skb) {
+			struct sk_buff *skb = u->oob_skb;
+
+			u->oob_skb = NULL;
+			kfree_skb(skb);
+		}
+	}
+#endif
+
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4decdc2c601f..2898df10a72a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1808,8 +1808,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_access_pointer(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 5fbad61fe490..bfe5a4082d8e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -8,6 +8,29 @@ usage() {
 	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
 }
 
+# Try to find a Rust demangler
+if type llvm-cxxfilt >/dev/null 2>&1 ; then
+	cppfilt=llvm-cxxfilt
+elif type c++filt >/dev/null 2>&1 ; then
+	cppfilt=c++filt
+	cppfilt_opts=-i
+fi
+
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -45,8 +68,13 @@ else
 	fi
 fi
 
-declare -A cache
-declare -A modcache
+declare aarray_support=true
+declare -A cache 2>/dev/null
+if [[ $? != 0 ]]; then
+	aarray_support=false
+else
+	declare -A modcache
+fi
 
 find_module() {
 	if [[ -n $debuginfod ]] ; then
@@ -62,7 +90,7 @@ find_module() {
 
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -97,7 +125,7 @@ parse_symbol() {
 
 	if [[ $module == "" ]] ; then
 		local objfile=$vmlinux
-	elif [[ "${modcache[$module]+isset}" == "isset" ]]; then
+	elif [[ $aarray_support == true && "${modcache[$module]+isset}" == "isset" ]]; then
 		local objfile=${modcache[$module]}
 	else
 		local objfile=$(find_module)
@@ -105,7 +133,9 @@ parse_symbol() {
 			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
-		modcache[$module]=$objfile
+		if [[ $aarray_support == true ]]; then
+			modcache[$module]=$objfile
+		fi
 	fi
 
 	# Remove the englobing parenthesis
@@ -125,7 +155,7 @@ parse_symbol() {
 	# Use 'nm vmlinux' to figure out the base address of said symbol.
 	# It's actually faster to call it every time than to load it
 	# all into bash.
-	if [[ "${cache[$module,$name]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
 		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
@@ -133,7 +163,9 @@ parse_symbol() {
 			# address not found
 			return
 		fi
-		cache[$module,$name]="$base_addr"
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$name]="$base_addr"
+		fi
 	fi
 	# Let's start doing the math to get the exact address into the
 	# symbol. First, strip out the symbol total length.
@@ -149,11 +181,13 @@ parse_symbol() {
 
 	# Pass it to addr2line to get filename and line number
 	# Could get more than one result
-	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
-		cache[$module,$address]=$code
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$address]=$code
+		fi
 	fi
 
 	# addr2line doesn't return a proper error code if it fails, so
@@ -169,6 +203,12 @@ parse_symbol() {
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
 
+	# Demangle if the name looks like a Rust symbol and if
+	# we got a Rust demangler
+	if [[ $name =~ ^_R && $cppfilt != "" ]] ; then
+		name=$("$cppfilt" "$cppfilt_opts" "$name")
+	fi
+
 	# Replace old address with pretty line numbers
 	symbol="$segment$name ($code)"
 }
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d7aa82094296..65b5fde34caa 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -75,7 +75,7 @@ sub parse_abi {
 	$name =~ s,.*/,,;
 
 	my $fn = $file;
-	$fn =~ s,Documentation/ABI/,,;
+	$fn =~ s,.*Documentation/ABI/,,;
 
 	my $nametag = "File $fn";
 	$data{$nametag}->{what} = "File $name";
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 57ef6accbb40..5a5a0cfad69d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -236,8 +236,13 @@ gen_btf()
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
 		--strip-all ${1} ${2} 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
-	# Unlike GNU ld, lld does not allow an ET_EXEC input.
-	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
+	if [ -n "${CONFIG_CPU_BIG_ENDIAN}" ]; then
+		et_rel='\0\1'
+	else
+		et_rel='\1\0'
+	fi
+	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
 }
 
 # Create ${2} .S file with all symbols from the ${1} object file
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 905c0ec291e1..e6962678032e 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -328,7 +328,12 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 
 	/* Sum all files in the same dir or subdirs. */
 	while ((line = get_line(&pos))) {
-		char* p = line;
+		char* p;
+
+		/* trim the leading spaces away */
+		while (isspace(*line))
+			line++;
+		p = line;
 
 		if (strncmp(line, "source_", sizeof("source_")-1) == 0) {
 			p = strrchr(line, ' ');
diff --git a/security/security.c b/security/security.c
index a97079e12c67..33864d067f7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1556,6 +1556,24 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit
+ * processes running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
@@ -2145,7 +2163,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
+		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(inode_getsecctx);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ec839716dbac..d9a680792b21 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3810,6 +3810,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to
+	 * make sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec __ro_after_init;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -7208,6 +7235,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 39f564f47fea..a5a78aef6403 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4767,6 +4767,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b6a31901f289..1be96e2ce9f1 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -546,6 +546,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index ec95d0449bfe..c3342c9fee86 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -598,17 +598,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 	struct hdac_stream *s;
 	bool inited = false;
 	u64 cycle_last = 0;
-	int i = 0;
 
 	list_for_each_entry(s, &bus->stream_list, list) {
-		if (streams & (1 << i)) {
+		if ((streams & (1 << s->index))) {
 			azx_timecounter_init(s, inited, cycle_last);
 			if (!inited) {
 				inited = true;
 				cycle_last = s->tc.cycle_last;
 			}
 		}
-		i++;
 	}
 
 	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
@@ -653,14 +651,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	int i, nwait, timeout;
+	int nwait, timeout;
 	struct hdac_stream *s;
 
 	for (timeout = 5000; timeout; timeout--) {
 		nwait = 0;
-		i = 0;
 		list_for_each_entry(s, &bus->stream_list, list) {
-			if (!(streams & (1 << i++)))
+			if (!(streams & (1 << s->index)))
 				continue;
 
 			if (start) {
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 774d80f4b101..e4cd6f0c686f 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -389,6 +389,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x7e28,
 	},
+	/* ArrowLake-S */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL_S,
+	},
+	/* ArrowLake */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL,
+	},
 #endif
 
 /* Lunar Lake */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 65f7e3dc4602..dd4d802c9e71 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2516,6 +2516,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	{ PCI_DEVICE(0x8086, 0x4b58),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index deff4a3d7a78..876380ad2ed1 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,6 +21,12 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+enum {
+	CX_HEADSET_NOPRESENT = 0,
+	CX_HEADSET_PARTPRESENT,
+	CX_HEADSET_ALLPRESENT,
+};
+
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -42,7 +48,8 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-
+	unsigned int headset_present_flag;
+	bool is_cx8070_sn6140;
 };
 
 
@@ -164,6 +171,27 @@ static void cxt_init_gpio_led(struct hda_codec *codec)
 	}
 }
 
+static void cx_fixup_headset_recog(struct hda_codec *codec)
+{
+	unsigned int mic_persent;
+
+	/* fix some headset type recognize fail issue, such as EDIFIER headset */
+	/* set micbiasd output current comparator threshold from 66% to 55%. */
+	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
+	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias registor
+	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
+	 */
+	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
+	/* fix reboot headset type recognize fail issue */
+	mic_persent = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (mic_persent & AC_PINSENSE_PRESENCE)
+		/* enable headset mic VREF */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	else
+		/* disable headset mic VREF */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+}
+
 static int cx_auto_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -174,6 +202,9 @@ static int cx_auto_init(struct hda_codec *codec)
 	cxt_init_gpio_led(codec);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
+	if (spec->is_cx8070_sn6140)
+		cx_fixup_headset_recog(codec);
+
 	return 0;
 }
 
@@ -192,6 +223,77 @@ static void cx_auto_free(struct hda_codec *codec)
 	snd_hda_gen_free(codec);
 }
 
+static void cx_process_headset_plugin(struct hda_codec *codec)
+{
+	unsigned int val;
+	unsigned int count = 0;
+
+	/* Wait headset detect done. */
+	do {
+		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
+		if (val & 0x080) {
+			codec_dbg(codec, "headset type detect done!\n");
+			break;
+		}
+		msleep(20);
+		count++;
+	} while (count < 3);
+	val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
+	if (val & 0x800) {
+		codec_dbg(codec, "headset plugin, type is CTIA\n");
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	} else if (val & 0x400) {
+		codec_dbg(codec, "headset plugin, type is OMTP\n");
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	} else {
+		codec_dbg(codec, "headphone plugin\n");
+	}
+}
+
+static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+{
+	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
+	struct conexant_spec *spec = codec->spec;
+
+	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
+	 * the node 19 can only be config to microphone or disabled.
+	 * Check hp&mic tag to process headset pulgin&plugout.
+	 */
+	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
+	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
+		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
+			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+			return;
+		}
+		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
+			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
+		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
+			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
+							 AC_VERB_GET_PIN_SENSE, 0x0);
+			/* headset is present */
+			if ((phone_present & AC_PINSENSE_PRESENCE) &&
+			    (mic_persent & AC_PINSENSE_PRESENCE)) {
+				cx_process_headset_plugin(codec);
+				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
+			}
+		}
+	}
+}
+
+static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (spec->is_cx8070_sn6140)
+		cx_update_headset_mic_vref(codec, res);
+
+	snd_hda_jack_unsol_event(codec, res);
+}
+
 #ifdef CONFIG_PM
 static int cx_auto_suspend(struct hda_codec *codec)
 {
@@ -205,7 +307,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = snd_hda_jack_unsol_event,
+	.unsol_event = cx_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -242,6 +344,7 @@ enum {
 	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
+	CXT_PINCFG_SWS_JS201D,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -739,6 +842,17 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* SuoWoSi/South-holding JS201D with sn6140 */
+static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
+	{ 0x16, 0x03211040 }, /* hp out */
+	{ 0x17, 0x91170110 }, /* SPK/Class_D */
+	{ 0x18, 0x95a70130 }, /* Internal mic */
+	{ 0x19, 0x03a11020 }, /* Headset Mic */
+	{ 0x1a, 0x40f001f0 }, /* Not used */
+	{ 0x21, 0x40f001f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -894,6 +1008,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_HEADSET_MIC,
 	},
+	[CXT_PINCFG_SWS_JS201D] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_sws_js201d,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -967,6 +1085,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo T410", CXT_PINCFG_LENOVO_TP410),
@@ -1007,6 +1126,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_ZBOOK_MUTE_LED, .name = "hp-zbook-mute-led" },
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
+	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{}
 };
 
@@ -1042,6 +1162,15 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	codec->spec = spec;
 	codec->patch_ops = cx_auto_patch_ops;
 
+	/* init cx8070/sn6140 flag and reset headset_present_flag */
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		spec->is_cx8070_sn6140 = true;
+		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		break;
+	}
+
 	cx_auto_parse_eapd(codec);
 	spec->gen.own_eapd_ctl = 1;
 
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index aff2b5abb81e..abf4eef9afa0 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1200,6 +1200,7 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		spec->scodecs[CS8409_CODEC1] = &dolphin_cs42l42_1;
 		spec->scodecs[CS8409_CODEC1]->codec = codec;
 		spec->num_scodecs = 2;
+		spec->gen.suppress_vmaster = 1;
 
 		codec->patch_ops = cs8409_dolphin_patch_ops;
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9a0824459d13..a6e6ed1355ab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8905,6 +8905,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54", ALC256_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x126a, "Acer Swift SF114-32", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
@@ -9089,6 +9090,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -9413,6 +9415,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
+	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 8973f439123f..5dbe5de81dc3 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1577,7 +1577,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 	u16 gain_reg;
 	u16 reg;
 	int val;
-	int offset_val = 0;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
 	if (w->shift == WSA_MACRO_COMP1) {
@@ -1616,10 +1615,8 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
 					CDC_WSA_RX_PGA_HALF_DB_MASK,
 					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
-			offset_val = -2;
 		}
 		val = snd_soc_component_read(component, gain_reg);
-		val += offset_val;
 		snd_soc_component_write(component, gain_reg, val);
 		wsa_macro_config_ear_spkr_gain(component, wsa,
 						event, gain_reg);
@@ -1647,10 +1644,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
 					CDC_WSA_RX_PGA_HALF_DB_MASK,
 					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
-			offset_val = 2;
-			val = snd_soc_component_read(component, gain_reg);
-			val += offset_val;
-			snd_soc_component_write(component, gain_reg, val);
 		}
 		wsa_macro_config_ear_spkr_gain(component, wsa,
 						event, gain_reg);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2fdfec505192..f903bee194d5 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3288,6 +3288,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
+		mutex_unlock(&rt5645->jd_mutex);
 		return;
 	case 4:
 		val = snd_soc_component_read(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 529aa480267b..94038eed2423 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4573,7 +4573,7 @@ static int wcd938x_probe(struct platform_device *pdev)
 	ret = wcd938x_populate_dt_data(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: Fail to obtain platform data\n", __func__);
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = wcd938x_add_slave_components(wcd938x, dev, &match);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9cdf0e05cf49..03b6a07a2ea0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1759,6 +1759,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04d8, 0xfeea, /* Benchmark DAC1 Pre */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
@@ -1796,6 +1798,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0763, 0x2031, /* M-Audio Fast Track C600 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x07fd, 0x000b, /* MOTU M Series 2nd hardware revision */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x08bb, 0x2702, /* LineX FM Transmitter */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index eb6303ff446e..4cfcef9da3e4 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
+#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.1.1 is required"
+#error "OpenCSD >= 1.2.1 is required"
 #endif
 
 int main(void)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f87a15bbf53b..0c201f07d8ae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3803,6 +3803,8 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, GElf_Shdr *shdr, Elf_Data
 
 	scn = elf_sec_by_idx(obj, sec_idx);
 	scn_data = elf_sec_data(obj, scn);
+	if (!scn_data)
+		return -LIBBPF_ERRNO__FORMAT;
 
 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
 	sec_name = elf_sec_name(obj, scn);
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..42f57b640f11 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -50,11 +50,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f3daa44a8266..f63c7ee3d798 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -348,10 +348,20 @@ int setup_classid_environment(void)
 		return 1;
 	}
 
-	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls") &&
-	    errno != EBUSY) {
-		log_err("mount cgroup net_cls");
-		return 1;
+	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls")) {
+		if (errno != EBUSY) {
+			log_err("mount cgroup net_cls");
+			return 1;
+		}
+
+		if (rmdir(NETCLS_MOUNT_PATH)) {
+			log_err("rmdir cgroup net_cls");
+			return 1;
+		}
+		if (umount(CGROUP_MOUNT_DFLT)) {
+			log_err("umount cgroup base");
+			return 1;
+		}
 	}
 
 	cleanup_classid_environment();
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 2a04dbec510d..92080f64b5cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4766,6 +4766,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 28e30ad4a30e..2e3e525e8579 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -810,59 +810,6 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	bpf_object__close(obj);
 }
 
-#include "tailcall_bpf2bpf6.skel.h"
-
-/* Tail call counting works even when there is data on stack which is
- * not aligned to 8 bytes.
- */
-static void test_tailcall_bpf2bpf_6(void)
-{
-	struct tailcall_bpf2bpf6 *obj;
-	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = &pkt_v4,
-		.data_size_in = sizeof(pkt_v4),
-		.repeat = 1,
-	);
-
-	obj = tailcall_bpf2bpf6__open_and_load();
-	if (!ASSERT_OK_PTR(obj, "open and load"))
-		return;
-
-	main_fd = bpf_program__fd(obj->progs.entry);
-	if (!ASSERT_GE(main_fd, 0, "entry prog fd"))
-		goto out;
-
-	map_fd = bpf_map__fd(obj->maps.jmp_table);
-	if (!ASSERT_GE(map_fd, 0, "jmp_table map fd"))
-		goto out;
-
-	prog_fd = bpf_program__fd(obj->progs.classifier_0);
-	if (!ASSERT_GE(prog_fd, 0, "classifier_0 prog fd"))
-		goto out;
-
-	i = 0;
-	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
-	if (!ASSERT_OK(err, "jmp_table map update"))
-		goto out;
-
-	err = bpf_prog_test_run_opts(main_fd, &topts);
-	ASSERT_OK(err, "entry prog test run");
-	ASSERT_EQ(topts.retval, 0, "tailcall retval");
-
-	data_fd = bpf_map__fd(obj->maps.bss);
-	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
-		goto out;
-
-	i = 0;
-	err = bpf_map_lookup_elem(data_fd, &i, &val);
-	ASSERT_OK(err, "bss map lookup");
-	ASSERT_EQ(val, 1, "done flag is set");
-
-out:
-	tailcall_bpf2bpf6__destroy(obj);
-}
-
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -885,6 +832,4 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(false);
 	if (test__start_subtest("tailcall_bpf2bpf_5"))
 		test_tailcall_bpf2bpf_4(true);
-	if (test__start_subtest("tailcall_bpf2bpf_6"))
-		test_tailcall_bpf2bpf_6();
 }
diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..42c4a8b62e36 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at clang18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some branch
+ * target distance exceeded 16bit representation which is the maximum for
+ * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang18
+ * to specify which cpu version is used for compilation. So a smaller
+ * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
+ * reduced some branch target distances and resolved the compilation failure.
+ *
+ * To capture the case where a developer/ci uses clang18 but the corresponding
+ * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_count
+ * will be set as well to prevent potential compilation failures.
+ */
+#ifdef __BPF_CPU_VERSION__
+#if __BPF_CPU_VERSION__ < 4
+#define UNROLL_COUNT 90
+#endif
+#elif __clang_major__ == 18
+#define UNROLL_COUNT 90
+#endif
+
 #include "pyperf.h"
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
deleted file mode 100644
index 41ce83da78e8..000000000000
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-#define __unused __attribute__((unused))
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(max_entries, 1);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
-} jmp_table SEC(".maps");
-
-int done = 0;
-
-SEC("tc")
-int classifier_0(struct __sk_buff *skb __unused)
-{
-	done = 1;
-	return 0;
-}
-
-static __noinline
-int subprog_tail(struct __sk_buff *skb)
-{
-	/* Don't propagate the constant to the caller */
-	volatile int ret = 1;
-
-	bpf_tail_call_static(skb, &jmp_table, 0);
-	return ret;
-}
-
-SEC("tc")
-int entry(struct __sk_buff *skb)
-{
-	/* Have data on stack which size is not a multiple of 8 */
-	volatile char arr[1] = {};
-
-	return subprog_tail(skb);
-}
-
-char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 1b08e042cf94..185b02d2d4cd 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -269,6 +269,7 @@ for port in 0 1; do
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
+    ifconfig $NSIM_NETDEV up
 
     msg="new NIC device created"
     exp0=( 0 0 0 0 )
@@ -430,6 +431,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -487,6 +489,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -543,6 +546,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "destroy NIC"
@@ -572,6 +576,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -632,6 +637,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
@@ -687,6 +693,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -746,6 +753,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -876,6 +884,7 @@ msg="re-add a port"
 
 echo 2 > $NSIM_DEV_SYS/del_port
 echo 2 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV=`get_netdev_name old_netdevs`
 check_tables
 
 msg="replace VxLAN in overflow table"
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 0a9d482c5058..31e3d0db7a12 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -698,23 +698,23 @@ setup_xfrm6() {
 }
 
 setup_xfrm4udp() {
-	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udp() {
-	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_xfrm4udprouted() {
-	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udprouted() {
-	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_routing_old() {
@@ -1795,6 +1795,13 @@ check_command() {
 	return 0
 }
 
+check_running() {
+	pid=${1}
+	cmd=${2}
+
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+}
+
 test_cleanup_vxlanX_exception() {
 	outer="${1}"
 	encap="vxlan"
@@ -1825,11 +1832,12 @@ test_cleanup_vxlanX_exception() {
 
 	${ns_a} ip link del dev veth_A-R1 &
 	iplink_pid=$!
-	sleep 1
-	if [ "$(cat /proc/${iplink_pid}/cmdline 2>/dev/null | tr -d '\0')" = "iplinkdeldevveth_A-R1" ]; then
-		err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
-		return 1
-	fi
+	for i in $(seq 1 20); do
+		check_running ${iplink_pid} "iplinkdeldevveth_A-R1" || return 0
+		sleep 0.1
+	done
+	err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
+	return 1
 }
 
 test_cleanup_ipv6_exception() {
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index 1003ddf7b3b2..227fd1076f21 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -8,7 +8,7 @@ setup_veth_ns() {
 	local -r ns_mac="$4"
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
 
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 1bcd82e1f662..fa5aa588e53f 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -36,6 +36,10 @@ create_ns() {
 	for ns in $NS_SRC $NS_DST; do
 		ip netns add $ns
 		ip -n $ns link set dev lo up
+
+		# disable route solicitations to decrease 'noise' traffic
+		ip netns exec $ns sysctl -qw net.ipv6.conf.default.router_solicitations=0
+		ip netns exec $ns sysctl -qw net.ipv6.conf.all.router_solicitations=0
 	done
 
 	ip link add name veth$SRC type veth peer name veth$DST
@@ -77,6 +81,12 @@ create_vxlan_pair() {
 		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) vxlan6$ns 6
 		ip -n $BASE$ns addr add dev vxlan6$ns $OL_NET_V6$ns/24 nodad
 	done
+
+	# preload neighbur cache, do avoid some noisy traffic
+	local addr_dst=$(ip -j -n $BASE$DST link show dev vxlan6$DST  |jq -r '.[]["address"]')
+	local addr_src=$(ip -j -n $BASE$SRC link show dev vxlan6$SRC  |jq -r '.[]["address"]')
+	ip -n $BASE$DST neigh add dev vxlan6$DST lladdr $addr_src $OL_NET_V6$SRC
+	ip -n $BASE$SRC neigh add dev vxlan6$SRC lladdr $addr_dst $OL_NET_V6$DST
 }
 
 is_ipv6() {
@@ -116,7 +126,7 @@ run_test() {
 	# not enable GRO
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 4789
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
-	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
+	ip netns exec $NS_DST ./udpgso_bench_rx -C 2000 -R 100 -n 10 -l 1300 $rx_args &
 	local spid=$!
 	sleep 0.1
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
@@ -165,7 +175,7 @@ run_bench() {
 	# bind the sender and the receiver to different CPUs to try
 	# get reproducible results
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
-	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
+	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 2000 -R 100  &
 	local spid=$!
 	sleep 0.1
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index f35a924d4a30..1cbadd267c96 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -375,7 +375,7 @@ static void do_recv(void)
 			do_flush_udp(fd);
 
 		tnow = gettimeofday_ms();
-		if (tnow > treport) {
+		if (!cfg_expected_pkt_nr && tnow > treport) {
 			if (packets)
 				fprintf(stderr,
 					"%s rx: %6lu MB/s %8lu calls/s\n",
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..108bc11d1d8c 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -34,8 +34,4 @@ SECTIONS
 	}
 }
 
-ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
+ASSERT(!DEFINED(_GLOBAL_OFFSET_TABLE_), "Libcalls through GOT are not supported in enclaves")

