Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2757AB5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjIVQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:26:46 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 09:26:39 PDT
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70042114;
        Fri, 22 Sep 2023 09:26:39 -0700 (PDT)
Received: from avalon.lan (unknown [IPv6:2001:19f0:6c01:100::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id AC6A81F5E2;
        Fri, 22 Sep 2023 18:18:31 +0200 (CEST)
From:   Matthias Schiffer <mschiffer@universe-factory.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [RFC] ata: libata: increase PMP SRST timeout to 10s
Date:   Fri, 22 Sep 2023 18:18:20 +0200
Message-ID: <dcbe606ac716e01f103f8aa62f0201cdb8f3efa0.1695394865.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On certain devices(*), this device probe failures for SATA disks after
wakeup from S2RAM, which often led to the disks not to be detected again.

    ata1: softreset failed (1st FIS failed)

(*) Observed for disks connected to the internal SATA controller of the
QNAP TS-453B, which is a "SATA controller: Intel Corporation
Celeron/Pentium Silver Processor SATA Controller (rev 06)".

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

I'm sending this as an RFC, as I don't think it makes sense to increase the
timeout unconditionally - maybe it should be some kind of device quirk, if
there isn't any better fix.

See text below for more information.

 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index be2f0cee1601..9194030527b6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -256,7 +256,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
---

I'm running plain Debian 12 rather than the QNAP OS (I believe the original
software does not support S2RAM at all). The issue I'm describing exists at
least since kernel 5.15; I've never run older kernels on this hardware. The
mainboard has 2 SATA controllers, both handled by the ahci driver:

    # lspci | grep SATA
    00:12.0 SATA controller: Intel Corporation Celeron/Pentium Silver Processor SATA Controller (rev 06)
    02:00.0 SATA controller: ASMedia Technology Inc. 106x SATA/RAID Controller (rev 01)

The first two channels ata1 and ata2 are connected to the Intel controller,
while the ASMedia is responsible for ata3 through ata14. I have the same hard
drives connected to ata2, ata3, and ata4 (ata1 has a different model), and I'm
seeing the timeout issue after suspend only on ata1 and ata2, so it is specific
to the Intel controller rather than the drive model.

On Debian's default 6.1.52 kernel, a wakeup looks like the following *in the
good case*, where all disks are successfully brought up again (unfortunately,
journald doesn't seem to have recorded correct timing information; roughly
22 seconds pass between the "starting disk" and final "link up"). I have
redacted lines for the unused ata{5..14} ports for conciseness.

    ACPI: PM: Waking up from system sleep state S3
    sd 2:0:0:0: [sdc] Starting disk
    sd 3:0:0:0: [sdd] Starting disk
    sd 1:0:0:0: [sdb] Starting disk
    sd 0:0:0:0: [sda] Starting disk
    ata3: link is slow to respond, please be patient (ready=0)
    ata4: link is slow to respond, please be patient (ready=0)
    ata2: found unknown device (class 0)
    ata1: found unknown device (class 0)
    ata1: softreset failed (1st FIS failed)
    ata2: softreset failed (1st FIS failed)
    ata3: COMRESET failed (errno=-16)
    ata4: COMRESET failed (errno=-16)
    ata1: found unknown device (class 0)
    ata2: found unknown device (class 0)
    ata3: link is slow to respond, please be patient (ready=0)
    ata4: link is slow to respond, please be patient (ready=0)
    ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata3.00: configured for UDMA/133
    ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata4.00: configured for UDMA/133
    ata1: softreset failed (1st FIS failed)
    ata2: softreset failed (1st FIS failed)
    ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata2.00: configured for UDMA/133
    ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata1.00: configured for UDMA/133

On the same kernel, another wakeup might look like this:

    ACPI: PM: Waking up from system sleep state S3
    sd 2:0:0:0: [sdd] Starting disk
    sd 3:0:0:0: [sdc] Starting disk
    sd 0:0:0:0: [sda] Starting disk
    sd 1:0:0:0: [sdb] Starting disk
    ata2: SATA link down (SStatus 0 SControl 300)
    ata3: link is slow to respond, please be patient (ready=0)
    ata4: link is slow to respond, please be patient (ready=0)
    ata1: SATA link down (SStatus 0 SControl 300)
    ata3: COMRESET failed (errno=-16)
    ata4: COMRESET failed (errno=-16)
    ata1: SATA link down (SStatus 0 SControl 300)
    ata1: limiting SATA link speed to <unknown>
    ata3: link is slow to respond, please be patient (ready=0)
    ata4: link is slow to respond, please be patient (ready=0)
    ata2: SATA link down (SStatus 0 SControl 300)
    ata2: limiting SATA link speed to <unknown>
    ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata3.00: configured for UDMA/133
    ata4.00: configured for UDMA/133
    ata1: SATA link down (SStatus 0 SControl 3F0)
    ata1.00: disable device
    ata2: SATA link down (SStatus 0 SControl 3F0)
    ata2.00: disable device
    sd 1:0:0:0: rejecting I/O to offline device
    sd 0:0:0:0: rejecting I/O to offline device
    ata2.00: detaching (SCSI 1:0:0:0)
    ata1.00: detaching (SCSI 0:0:0:0)
    sd 0:0:0:0: [sda] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
    sd 1:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
    sd 0:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 [scsi_mod] returns -5
    sd 1:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 [scsi_mod] returns -5
    sd 0:0:0:0: PM: failed to resume async: error -5
    sd 1:0:0:0: PM: failed to resume async: error -5

With my patch applied, the following log is generated instead:

    [   63.748299] ACPI: PM: Waking up from system sleep state S3
    [   63.767111] sd 2:0:0:0: [sdc] Starting disk
    [   63.767181] sd 3:0:0:0: [sdd] Starting disk
    [   63.776402] sd 0:0:0:0: [sdb] Starting disk
    [   63.776500] sd 1:0:0:0: [sda] Starting disk
    [   69.121513] ata4: link is slow to respond, please be patient (ready=0)
    [   69.125531] ata3: link is slow to respond, please be patient (ready=0)
    [   69.133538] ata2: link is slow to respond, please be patient (ready=0)
    [   69.133557] ata1: link is slow to respond, please be patient (ready=0)
    [   73.803763] ata4: COMRESET failed (errno=-16)
    [   73.807805] ata3: COMRESET failed (errno=-16)
    [   73.815780] ata2: found unknown device (class 0)
    [   73.815800] ata1: found unknown device (class 0)
    [   73.975799] ata2: softreset failed (device not ready)
    [   73.975813] ata1: softreset failed (device not ready)
    [   79.157124] ata4: link is slow to respond, please be patient (ready=0)
    [   79.161116] ata3: link is slow to respond, please be patient (ready=0)
    [   79.329119] ata1: link is slow to respond, please be patient (ready=0)
    [   79.329129] ata2: link is slow to respond, please be patient (ready=0)
    [   80.781376] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [   80.792790] ata3.00: configured for UDMA/133
    [   80.837437] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [   80.843358] ata4.00: configured for UDMA/133
    [   82.309565] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [   82.334217] ata2.00: configured for UDMA/133
    [   84.009745] ata1: found unknown device (class 0)
    [   84.169743] ata1: softreset failed (device not ready)
    [   85.425859] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    [   85.486518] ata1.00: configured for UDMA/133

Compared to the previous "good" log
- ata1 and ata2 got "link is slow to respond" messages
- the "softreset failed" error changed from "1st FIS failed" to "device not
  ready"
- I haven't seen any failures to bring up drives in 10+ wakeups, where it would
  fail in roughly 1 out of 3 tries without the increased timeout

I also saw the resume improvements going on in
https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/, so next I
took kernel 6.5.4 and applied all patches from the for-6.6 and for-6.7 branches
from that repo on top. The first thing I noticed with this new kernel was a
regression:

    16:24:25 : PM: suspend exit
    16:24:25 : ata2: SATA link down (SStatus 0 SControl 300)
    16:24:25 : ata2.00: Entering active power mode
    16:24:25 : ata1: SATA link down (SStatus 0 SControl 300)
    16:24:25 : ata1.00: Entering active power mode
    16:24:30 : ata3: link is slow to respond, please be patient (ready=0)
    16:24:30 : ata4: link is slow to respond, please be patient (ready=0)
    16:24:35 : ata2.00: qc timeout after 10000 msecs (cmd 0x40)
    16:24:35 : ata1.00: qc timeout after 10000 msecs (cmd 0x40)
    16:24:35 : ata1.00: VERIFY failed (err_mask=0x4)
    16:24:35 : ata2.00: VERIFY failed (err_mask=0x4)
    16:24:35 : ata2: SATA link down (SStatus 0 SControl 300)
    16:24:35 : ata2: limiting SATA link speed to <unknown>
    16:24:41 : ata4: link is slow to respond, please be patient (ready=0)
    16:24:41 : ata3: link is slow to respond, please be patient (ready=0)
    16:24:41 : ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:24:41 : ata4.00: Entering active power mode
    16:24:41 : ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:24:41 : ata3.00: Entering active power mode
    16:24:41 : ata4.00: configured for UDMA/133
    16:24:41 : ata3.00: configured for UDMA/133
    16:24:41 : ata1: SATA link down (SStatus 0 SControl 300)
    16:24:41 : ata1: limiting SATA link speed to <unknown>
    16:24:47 : ata1: SATA link down (SStatus 0 SControl 3F0)
    16:24:47 : ata1.00: disable device
    16:24:47 : ata2: SATA link down (SStatus 0 SControl 3F0)
    16:24:47 : ata2.00: disable device
    16:24:47 : ata1.00: detaching (SCSI 0:0:0:0)
    16:24:47 : ata2.00: detaching (SCSI 1:0:0:0)

For the ASMedia controller, the new kernel fixes the "COMRESET failed" messages,
but on the Intel controller, two new errors have appeared ("qc timeout" and
"VERIFY failed"), and my drives are missing again.

The new messages could be fixed by adding libata.ata_probe_timeout=30 to the
cmdline; I still consider this a regression, as it wasn't necessary before.
With the added cmdline:

    16:34:17 : PM: suspend exit
    16:34:22 : ata3: link is slow to respond, please be patient (ready=0)
    16:34:22 : ata4: link is slow to respond, please be patient (ready=0)
    16:34:22 : ata2: found unknown device (class 0)
    16:34:22 : ata1: found unknown device (class 0)
    16:34:27 : ata1: softreset failed (1st FIS failed)
    16:34:27 : ata2: softreset failed (1st FIS failed)
    16:34:32 : ata1: found unknown device (class 0)
    16:34:32 : ata2: found unknown device (class 0)
    16:34:32 : ata3: link is slow to respond, please be patient (ready=0)
    16:34:32 : ata4: link is slow to respond, please be patient (ready=0)
    16:34:35 : ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:34:35 : ata3.00: Entering active power mode
    16:34:35 : ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:34:35 : ata4.00: Entering active power mode
    16:34:35 : ata3.00: configured for UDMA/133
    16:34:35 : ata4.00: configured for UDMA/133
    16:34:37 : ata1: softreset failed (1st FIS failed)
    16:34:37 : ata2: softreset failed (1st FIS failed)
    16:34:38 : ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:34:38 : ata2.00: Entering active power mode
    16:34:38 : ata2.00: configured for UDMA/133
    16:34:40 : ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:34:40 : ata1.00: Entering active power mode
    16:34:40 : ata1.00: configured for UDMA/133

Okay, we're back at the "1st FIS failed" message. I actually haven't tried
suspending with this kernel a lot, so I don't know how often my drives would
go missing in this setup, but I assume it's similar to kernel 6.1 (the first
two logs I posted), as the error messages look the same.

Finally, I took that last kernel and also applied my timeout increase patch on
top, resulting in the following log:

    16:48:33 : PM: suspend exit
    16:48:39 : ata3: link is slow to respond, please be patient (ready=0)
    16:48:39 : ata4: link is slow to respond, please be patient (ready=0)
    16:48:39 : ata2: link is slow to respond, please be patient (ready=0)
    16:48:39 : ata1: link is slow to respond, please be patient (ready=0)
    16:48:43 : ata1: found unknown device (class 0)
    16:48:43 : ata2: found unknown device (class 0)
    16:48:44 : ata2: softreset failed (device not ready)
    16:48:44 : ata1: softreset failed (device not ready)
    16:48:49 : ata4: link is slow to respond, please be patient (ready=0)
    16:48:49 : ata3: link is slow to respond, please be patient (ready=0)
    16:48:49 : ata2: link is slow to respond, please be patient (ready=0)
    16:48:49 : ata1: link is slow to respond, please be patient (ready=0)
    16:48:51 : ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:48:51 : ata3.00: Entering active power mode
    16:48:51 : ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:48:51 : ata4.00: Entering active power mode
    16:48:51 : ata3.00: configured for UDMA/133
    16:48:51 : ata4.00: configured for UDMA/133
    16:48:52 : ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:48:52 : ata2.00: Entering active power mode
    16:48:52 : ata2.00: configured for UDMA/133
    16:48:54 : ata1: found unknown device (class 0)
    16:48:54 : ata1: softreset failed (device not ready)
    16:48:56 : ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    16:48:56 : ata1.00: Entering active power mode
    16:48:56 : ata1.00: configured for UDMA/133

We got our "link is slow to respond" and "device not ready" back for ata1/ata2,
and enabling the drives after wakeup seems to be reliable.

Unfortunately, I don't know much about (S)ATA, so I have no idea what is
actually going on here. In any case, I'd prefer my kernel not to lose my drives
on a regular basis, so I'll gladly take any pointers on what the best way to fix
this is :)

Best regards,
Matthias
