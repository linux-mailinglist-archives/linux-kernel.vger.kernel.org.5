Return-Path: <linux-kernel+bounces-163769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DDD8B6FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D904B21B35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7911428F0;
	Tue, 30 Apr 2024 10:26:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44326129A7B;
	Tue, 30 Apr 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472804; cv=none; b=j7kcgLD5SCCmAOGWiWeytX/GPeY/pLgM9sWbYEVnnN4P/QSjRvWKkY6M2p5Fuvu94aNqU8pOhuWqDnzyPV159P31Ty/TNbLEuJIW1koz0H8lBDDPEOd9mGvODTPDNRlR3OANLwm9KK+6U6n+nksHoh0vLWTdGjlFtCBjilBdaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472804; c=relaxed/simple;
	bh=5WdwNIE7HLL/qISxGEUMCkBTFd6EYA6XDuF8DRHGN8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atwDHCLiFMZopkFhv0FFh+6JZOAP9wWlt+RxwdLwxP0r0/F4z8Z7v1iu3i26csDdTP44yP0FxD8gRr+AX+C0k9WO7NWfcwI8m52i7KrRhjKkgJKWS9OkjjGJV8rElo8rD/hqCYDRJtlvKTO1TeDZKoFYQo6OFUGqoK6JC364/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6984FC2BBFC;
	Tue, 30 Apr 2024 10:26:42 +0000 (UTC)
Message-ID: <ace1b749-9a4d-4c68-b5a7-530e0d3ff504@xs4all.nl>
Date: Tue, 30 Apr 2024 12:26:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Content-Language: en-US, nl
To: "Yang, Chenyuan" <cy54@illinois.edu>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "Zhao, Zijie"
 <zijie4@illinois.edu>, "Zhang, Lingming" <lingming@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
 <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
 <2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
 <F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
 <49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
 <PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
 <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
 <f196c736-dbfe-4ca0-995b-1720bf530edf@xs4all.nl>
 <C84ADEF3-5553-41AF-B127-85D5630CC8A1@illinois.edu>
 <9e76f971-b2d7-424a-bf21-c6cf5cd4a3f3@xs4all.nl>
 <CA3D308A-ED29-440C-A6C5-C5450CDA2C84@illinois.edu>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CA3D308A-ED29-440C-A6C5-C5450CDA2C84@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chenyuan,

On 29/04/2024 17:42, Yang, Chenyuan wrote:
> Hi Hans,
> 
> Here is my QEMU booting command:
> 
> ```
> qemu-system-x86_64 \
> 	-m 2G \
> 	-smp 2 \
> 	-kernel linux/arch/x86/boot/bzImage \
> 	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> 	-drive file=image/bullseye-qemu.img,format=raw \
> 	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> 	-net nic,model=e1000 \
> 	-enable-kvm \
> 	-nographic \
> 	-pidfile vm.pi
> ```
> 
> Plus, here is the config of vivid from my linux kernel building config:
> 
> ```
> CONFIG_VIDEO_VIVID=y
> CONFIG_VIDEO_VIVID_CEC=y
> CONFIG_VIDEO_VIVID_MAX_DEVS=64
> 
> CONFIG_CMDLINE="... vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 ..."
> 
> # Here is the full
> CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/sda console=ttyS0 vsyscall=native numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 smp.csd_lock_timeout=100000 watchdog_thresh=55 workqueue.watchdog_thresh=140 sysctl.net.core.netdev_unregister_timeout_secs=140 dummy_hcd.num=8 kmsan.panic=1"
> ```
> 
> Plus, I attached the current patch (git diff > patch).
> 
> Let me know if you need any further information.

Ah, that was helpful. I also discovered that I had to run the reproducer as root,
that helped too :-)

Please add this patch on top of the diff you already have and try again.

The reproducer kills each forked process after 5 seconds from what I can
tell. That causes a driver wait call to return -ERESTARTSYS, and that corner
case was not handled correctly. It caused the harmless but confusing
"transmit timed out" message.

Regards,

	Hans

---------------------------------------------------------------------
[PATCH] cec: core: avoid confusing "transmit timed out" message

If, when waiting for a transmit to finish, the wait is interrupted,
then you might get a "transmit timed out" message, even though the
transmit was interrupted and did not actually time out.

Set transmit_in_progress_aborted to true if the
wait_for_completion_killable() call was interrupted and ensure
that the transmit is properly marked as ABORTED.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/core/cec-adap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index a493cbce24567..da09834990b87 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -490,6 +490,15 @@ int cec_thread_func(void *_adap)
 			goto unlock;
 		}

+		if (adap->transmit_in_progress &&
+		    adap->transmit_in_progress_aborted) {
+			if (adap->transmitting)
+				cec_data_cancel(adap->transmitting,
+						CEC_TX_STATUS_ABORTED, 0);
+			adap->transmit_in_progress = false;
+			adap->transmit_in_progress_aborted = false;
+			goto unlock;
+		}
 		if (adap->transmit_in_progress && timeout) {
 			/*
 			 * If we timeout, then log that. Normally this does
@@ -771,6 +780,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int err;

 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -935,10 +945,13 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 * Release the lock and wait, retake the lock afterwards.
 	 */
 	mutex_unlock(&adap->lock);
-	wait_for_completion_killable(&data->c);
+	err = wait_for_completion_killable(&data->c);
 	cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);

+	if (err)
+		adap->transmit_in_progress_aborted = true;
+
 	/* Cancel the transmit if it was interrupted */
 	if (!data->completed) {
 		if (data->msg.tx_status & CEC_TX_STATUS_OK)
-- 
2.43.0



