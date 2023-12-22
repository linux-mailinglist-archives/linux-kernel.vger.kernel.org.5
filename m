Return-Path: <linux-kernel+bounces-9364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8681C49F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9B1C24B52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5F6FD9;
	Fri, 22 Dec 2023 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzF0NmxM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224A6124
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EBqowUzGpDWua1BG7YiJIcY9apvHph/sydmOhBcHXkU=; b=nzF0NmxMWhBMlmbAGsuap5JedS
	47DFcSlDbj6impoGUffP5ZbA1rDRbTw/56ag6h1Ga3GQM/AJPeDnKzoylMqyMVqbp6VjgYfwVBg89
	3CLmf1zvCI2Kj+PoQ0vp8ztjMgUECAZiTC5L64eZOJKZ1pxfpHn4tjI34OnvcQlYXtp4of7Xh3eQU
	CO8nmN+RV6kH9mD8bQT69TZq3feKVwugRE6cxi1MP0pF6T3A/52q9A4VyZcEfV4aHeREBeYkpO6vz
	ZmxKdZu90YQThN9I+oJeTMaavgROCKDr/lQDFeqj+0UH9qkSB2dSRU6a1IftgkbvSBvUC842neIT9
	FQFm07pA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGY2D-004y0F-20;
	Fri, 22 Dec 2023 05:25:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] virt: vbox: core: fix all kernel-doc warnings
Date: Thu, 21 Dec 2023 21:25:19 -0800
Message-ID: <20231222052521.14333-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kernel-doc format for functions that have comments that begin
with "/**".
This prevents 26 kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/vboxguest/vboxguest_core.c |  154 +++++++++++++---------
 1 file changed, 91 insertions(+), 63 deletions(-)

diff -- a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -33,16 +33,15 @@
 	 VMMDEV_REQUESTOR_CON_DONT_KNOW | VMMDEV_REQUESTOR_TRUST_NOT_GIVEN)
 
 /**
- * Reserves memory in which the VMM can relocate any guest mappings
- * that are floating around.
+ * vbg_guest_mappings_init - Reserves memory in which the VMM can
+ *	relocate any guest mappings that are floating around.
+ * @gdev:		The Guest extension device.
  *
  * This operation is a little bit tricky since the VMM might not accept
  * just any address because of address clashes between the three contexts
  * it operates in, so we try several times.
  *
  * Failure to reserve the guest mappings is ignored.
- *
- * @gdev:		The Guest extension device.
  */
 static void vbg_guest_mappings_init(struct vbg_dev *gdev)
 {
@@ -125,7 +124,7 @@ out:
 }
 
 /**
- * Undo what vbg_guest_mappings_init did.
+ * vbg_guest_mappings_exit - Undo what vbg_guest_mappings_init did.
  *
  * @gdev:		The Guest extension device.
  */
@@ -166,9 +165,10 @@ static void vbg_guest_mappings_exit(stru
 }
 
 /**
- * Report the guest information to the host.
- * Return: 0 or negative errno value.
+ * vbg_report_guest_info - Report the guest information to the host.
  * @gdev:		The Guest extension device.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_report_guest_info(struct vbg_dev *gdev)
 {
@@ -229,10 +229,11 @@ out_free:
 }
 
 /**
- * Report the guest driver status to the host.
- * Return: 0 or negative errno value.
+ * vbg_report_driver_status - Report the guest driver status to the host.
  * @gdev:		The Guest extension device.
  * @active:		Flag whether the driver is now active or not.
+ *
+ * Return: 0 or negative errno value.
  */
 static int vbg_report_driver_status(struct vbg_dev *gdev, bool active)
 {
@@ -261,10 +262,12 @@ static int vbg_report_driver_status(stru
 }
 
 /**
- * Inflate the balloon by one chunk. The caller owns the balloon mutex.
- * Return: 0 or negative errno value.
+ * vbg_balloon_inflate - Inflate the balloon by one chunk. The caller
+ * owns the balloon mutex.
  * @gdev:		The Guest extension device.
  * @chunk_idx:		Index of the chunk.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_balloon_inflate(struct vbg_dev *gdev, u32 chunk_idx)
 {
@@ -312,10 +315,12 @@ out_error:
 }
 
 /**
- * Deflate the balloon by one chunk. The caller owns the balloon mutex.
- * Return: 0 or negative errno value.
+ * vbg_balloon_deflate - Deflate the balloon by one chunk. The caller
+ * owns the balloon mutex.
  * @gdev:		The Guest extension device.
  * @chunk_idx:		Index of the chunk.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_balloon_deflate(struct vbg_dev *gdev, u32 chunk_idx)
 {
@@ -344,7 +349,7 @@ static int vbg_balloon_deflate(struct vb
 	return 0;
 }
 
-/**
+/*
  * Respond to VMMDEV_EVENT_BALLOON_CHANGE_REQUEST events, query the size
  * the host wants the balloon to be and adjust accordingly.
  */
@@ -409,7 +414,7 @@ static void vbg_balloon_work(struct work
 	}
 }
 
-/**
+/*
  * Callback for heartbeat timer.
  */
 static void vbg_heartbeat_timer(struct timer_list *t)
@@ -422,11 +427,12 @@ static void vbg_heartbeat_timer(struct t
 }
 
 /**
- * Configure the host to check guest's heartbeat
- * and get heartbeat interval from the host.
- * Return: 0 or negative errno value.
+ * vbg_heartbeat_host_config - Configure the host to check guest's heartbeat
+ *	and get heartbeat interval from the host.
  * @gdev:		The Guest extension device.
  * @enabled:		Set true to enable guest heartbeat checks on host.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_heartbeat_host_config(struct vbg_dev *gdev, bool enabled)
 {
@@ -449,9 +455,11 @@ static int vbg_heartbeat_host_config(str
 }
 
 /**
- * Initializes the heartbeat timer. This feature may be disabled by the host.
- * Return: 0 or negative errno value.
+ * vbg_heartbeat_init - Initializes the heartbeat timer. This feature
+ * may be disabled by the host.
  * @gdev:		The Guest extension device.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_heartbeat_init(struct vbg_dev *gdev)
 {
@@ -481,7 +489,8 @@ static int vbg_heartbeat_init(struct vbg
 }
 
 /**
- * Cleanup hearbeat code, stop HB timer and disable host heartbeat checking.
+ * vbg_heartbeat_exit - Cleanup heartbeat code, stop HB timer and disable
+ *	host heartbeat checking.
  * @gdev:		The Guest extension device.
  */
 static void vbg_heartbeat_exit(struct vbg_dev *gdev)
@@ -493,11 +502,12 @@ static void vbg_heartbeat_exit(struct vb
 }
 
 /**
- * Applies a change to the bit usage tracker.
- * Return: true if the mask changed, false if not.
+ * vbg_track_bit_usage - Applies a change to the bit usage tracker.
  * @tracker:		The bit usage tracker.
  * @changed:		The bits to change.
  * @previous:		The previous value of the bits.
+ *
+ * Return: %true if the mask changed, %false if not.
  */
 static bool vbg_track_bit_usage(struct vbg_bit_usage_tracker *tracker,
 				u32 changed, u32 previous)
@@ -529,10 +539,12 @@ static bool vbg_track_bit_usage(struct v
 }
 
 /**
- * Init and termination worker for resetting the (host) event filter on the host
- * Return: 0 or negative errno value.
+ * vbg_reset_host_event_filter - Init and termination worker for
+ *	resetting the (host) event filter on the host
  * @gdev:		   The Guest extension device.
  * @fixed_events:	   Fixed events (init time).
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_reset_host_event_filter(struct vbg_dev *gdev,
 				       u32 fixed_events)
@@ -556,12 +568,8 @@ static int vbg_reset_host_event_filter(s
 }
 
 /**
- * Changes the event filter mask for the given session.
- *
- * This is called in response to VBG_IOCTL_CHANGE_FILTER_MASK as well as to
- * do session cleanup. Takes the session mutex.
- *
- * Return: 0 or negative errno value.
+ * vbg_set_session_event_filter - Changes the event filter mask for the
+ *	given session.
  * @gdev:			The Guest extension device.
  * @session:			The session.
  * @or_mask:			The events to add.
@@ -570,6 +578,11 @@ static int vbg_reset_host_event_filter(s
  *				This tweaks the error handling so we perform
  *				proper session cleanup even if the host
  *				misbehaves.
+ *
+ * This is called in response to VBG_IOCTL_CHANGE_FILTER_MASK as well as to
+ * do session cleanup. Takes the session mutex.
+ *
+ * Return: 0 or negative errno value.
  */
 static int vbg_set_session_event_filter(struct vbg_dev *gdev,
 					struct vbg_session *session,
@@ -637,9 +650,11 @@ out:
 }
 
 /**
- * Init and termination worker for set guest capabilities to zero on the host.
- * Return: 0 or negative errno value.
+ * vbg_reset_host_capabilities - Init and termination worker for set
+ *	guest capabilities to zero on the host.
  * @gdev:		The Guest extension device.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_reset_host_capabilities(struct vbg_dev *gdev)
 {
@@ -662,12 +677,14 @@ static int vbg_reset_host_capabilities(s
 }
 
 /**
- * Set guest capabilities on the host.
- * Must be called with gdev->session_mutex hold.
- * Return: 0 or negative errno value.
+ * vbg_set_host_capabilities - Set guest capabilities on the host.
  * @gdev:			The Guest extension device.
  * @session:			The session.
  * @session_termination:	Set if we're called by the session cleanup code.
+ *
+ * Must be called with gdev->session_mutex hold.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_set_host_capabilities(struct vbg_dev *gdev,
 				     struct vbg_session *session,
@@ -704,9 +721,8 @@ static int vbg_set_host_capabilities(str
 }
 
 /**
- * Acquire (get exclusive access) guest capabilities for a session.
- * Takes the session mutex.
- * Return: 0 or negative errno value.
+ * vbg_acquire_session_capabilities - Acquire (get exclusive access)
+ *	guest capabilities for a session.
  * @gdev:			The Guest extension device.
  * @session:			The session.
  * @flags:			Flags (VBGL_IOC_AGC_FLAGS_XXX).
@@ -716,6 +732,10 @@ static int vbg_set_host_capabilities(str
  *				This tweaks the error handling so we perform
  *				proper session cleanup even if the host
  *				misbehaves.
+ *
+ * Takes the session mutex.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_acquire_session_capabilities(struct vbg_dev *gdev,
 					    struct vbg_session *session,
@@ -811,8 +831,8 @@ out:
 }
 
 /**
- * Sets the guest capabilities for a session. Takes the session mutex.
- * Return: 0 or negative errno value.
+ * vbg_set_session_capabilities - Sets the guest capabilities for a
+ *	session. Takes the session mutex.
  * @gdev:			The Guest extension device.
  * @session:			The session.
  * @or_mask:			The capabilities to add.
@@ -821,6 +841,8 @@ out:
  *				This tweaks the error handling so we perform
  *				proper session cleanup even if the host
  *				misbehaves.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 					struct vbg_session *session,
@@ -866,9 +888,10 @@ out:
 }
 
 /**
- * vbg_query_host_version get the host feature mask and version information.
- * Return: 0 or negative errno value.
+ * vbg_query_host_version - get the host feature mask and version information.
  * @gdev:		The Guest extension device.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_query_host_version(struct vbg_dev *gdev)
 {
@@ -905,19 +928,18 @@ out:
 }
 
 /**
- * Initializes the VBoxGuest device extension when the
- * device driver is loaded.
+ * vbg_core_init - Initializes the VBoxGuest device extension when the
+ *	device driver is loaded.
+ * @gdev:		The Guest extension device.
+ * @fixed_events:	Events that will be enabled upon init and no client
+ *			will ever be allowed to mask.
  *
  * The native code locates the VMMDev on the PCI bus and retrieve
  * the MMIO and I/O port ranges, this function will take care of
  * mapping the MMIO memory (if present). Upon successful return
  * the native code should set up the interrupt handler.
  *
- * Return: 0 or negative errno value.
- *
- * @gdev:		The Guest extension device.
- * @fixed_events:	Events that will be enabled upon init and no client
- *			will ever be allowed to mask.
+ * Return: %0 or negative errno value.
  */
 int vbg_core_init(struct vbg_dev *gdev, u32 fixed_events)
 {
@@ -1017,11 +1039,12 @@ err_free_reqs:
 }
 
 /**
- * Call this on exit to clean-up vboxguest-core managed resources.
+ * vbg_core_exit - Call this on exit to clean-up vboxguest-core managed
+ *	resources.
+ * @gdev:		The Guest extension device.
  *
  * The native code should call this before the driver is loaded,
  * but don't call this on shutdown.
- * @gdev:		The Guest extension device.
  */
 void vbg_core_exit(struct vbg_dev *gdev)
 {
@@ -1046,12 +1069,13 @@ void vbg_core_exit(struct vbg_dev *gdev)
 }
 
 /**
- * Creates a VBoxGuest user session.
+ * vbg_core_open_session - Creates a VBoxGuest user session.
+ * @gdev:		The Guest extension device.
+ * @requestor:		VMMDEV_REQUESTOR_* flags
  *
  * vboxguest_linux.c calls this when userspace opens the char-device.
+ *
  * Return: A pointer to the new session or an ERR_PTR on error.
- * @gdev:		The Guest extension device.
- * @requestor:		VMMDEV_REQUESTOR_* flags
  */
 struct vbg_session *vbg_core_open_session(struct vbg_dev *gdev, u32 requestor)
 {
@@ -1068,7 +1092,7 @@ struct vbg_session *vbg_core_open_sessio
 }
 
 /**
- * Closes a VBoxGuest session.
+ * vbg_core_close_session - Closes a VBoxGuest session.
  * @session:		The session to close (and free).
  */
 void vbg_core_close_session(struct vbg_session *session)
@@ -1250,11 +1274,13 @@ static int vbg_ioctl_interrupt_all_wait_
 }
 
 /**
- * Checks if the VMM request is allowed in the context of the given session.
- * Return: 0 or negative errno value.
+ * vbg_req_allowed - Checks if the VMM request is allowed in the
+ *	context of the given session.
  * @gdev:		The Guest extension device.
  * @session:		The calling session.
  * @req:		The request.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_req_allowed(struct vbg_dev *gdev, struct vbg_session *session,
 			   const struct vmmdev_request_header *req)
@@ -1670,11 +1696,12 @@ static int vbg_ioctl_write_core_dump(str
 }
 
 /**
- * Common IOCtl for user to kernel communication.
- * Return: 0 or negative errno value.
+ * vbg_core_ioctl - Common IOCtl for user to kernel communication.
  * @session:	The client session.
  * @req:	The requested function.
  * @data:	The i/o data buffer, minimum size sizeof(struct vbg_ioctl_hdr).
+ *
+ * Return: %0 or negative errno value.
  */
 int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
 {
@@ -1744,11 +1771,12 @@ int vbg_core_ioctl(struct vbg_session *s
 }
 
 /**
- * Report guest supported mouse-features to the host.
+ * vbg_core_set_mouse_status - Report guest supported mouse-features to the host.
  *
- * Return: 0 or negative errno value.
  * @gdev:		The Guest extension device.
  * @features:		The set of features to report to the host.
+ *
+ * Return: %0 or negative errno value.
  */
 int vbg_core_set_mouse_status(struct vbg_dev *gdev, u32 features)
 {
@@ -1772,7 +1800,7 @@ int vbg_core_set_mouse_status(struct vbg
 	return vbg_status_code_to_errno(rc);
 }
 
-/** Core interrupt service routine. */
+/* Core interrupt service routine. */
 irqreturn_t vbg_core_isr(int irq, void *dev_id)
 {
 	struct vbg_dev *gdev = dev_id;

