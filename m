Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D37DAC25
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ2LTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJ2LTS (ORCPT
        <RFC822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:19:18 -0400
Received: from smtp1.ms.mff.cuni.cz (smtp1.ms.mff.cuni.cz [IPv6:2001:718:1e03:801::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E42C2;
        Sun, 29 Oct 2023 04:19:13 -0700 (PDT)
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
        serial F5FD910E8FE2121B897F7E55B84E351D
        issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
        auth type TLS.CUNI
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (authenticated)
        by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 39TBIQdY065431
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Sun, 29 Oct 2023 12:18:27 +0100 (CET)
        (envelope-from balejk@matfyz.cz)
From:   Karel Balej <balejk@matfyz.cz>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 0/2] net: mwifiex: add support for the SD8777 chipset
Date:   Sun, 29 Oct 2023 12:08:15 +0100
Message-ID: <20231029111807.19261-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces simple modifications to the Marvell mwifiex
wireless driver to make it support the SD8777 chipset which can be found
in mobile devices using the PXA1908 SoC (the support for which is being
upstreamed here [1]), among others, such as samsung,coreprimevelte or
samsung,xcover3lte. The changes are based on the Samsung downstream code
for coreprimevelte [2].

The driver requires proprietary firmware which is not yet part of
linux-firmware, but it is packaged in postmarketOS.

The Marvell repository for PXA1908 [3] contains some information in the
form of release notes (in a PDF under drivers/marvell/sd8777).

This series was sucessfully tested with the aforementioned smartphone,
samsung,coreprimevelte. However it has a caveat: the driver is not
always able to load the firmware onto the device and even when it
succeeds, it emits some errors and eventually breaks irrecoverably after
some time, seemingly after heavier usage. dmesg outputs with description
are below. The suspicion, supported by the fact that the eMMC on the
smartphone does not work at the moment (it reports as busy and the
initialization fails with -ETIMEDOUT, see [4] for dmesg output), is that
the problem is either with the MMC driver (sdhci-pxav3) or the clocks
driver which according to the author is currently missing some parts
present in the downstream version. In particular, the lack of tuning in
the mainline sdhci-pxav3 was considered a possible cause (specifically
the dvfs tuning which the downstream driver performs), however disabling
of this tuning in the downstream kernel doesn't seem to have any effect
on it's ability to use either eMMC or the wireless.

Here are the relevant dmesg outputs for several situations (debug
messages are enabled in the first, not so in the others):

This is the usual output when the firmware loading fails. The device has
to be rebooted before the next attempt to load the firmware because the
driver seems to think that it's already loaded.

	[   68.335394] mwifiex_sdio mmc2:0001:1: info: SDIO FUNC1 IO port: 0x10000
	[   68.485552] mwifiex_sdio mmc2:0001:1: info: downloading FW image (418332 bytes)
	[   68.698674] mwifiex_sdio mmc2:0001:1: FW download, write iomem (0) failed @ 208016
	[   68.698711] mwifiex_sdio mmc2:0001:1: prog_fw failed ret=0xffffffff
	[   68.698724] mwifiex_sdio mmc2:0001:1: info: _mwifiex_fw_dpc: unregister device

The return value of mwifiex_write_data_sync which is invoked during the
firmware loading is -EILSEQ.

Here, the download succeeds but the driver still emits some errors.
Eventually after some (short in this case) time the wireless stops
working and the below errors are printed repeatedly (here the failure
occurred while page loading was in progress in Mozilla Firefox). A
restart seems to be necessary to get the adapter to work again.

	[   61.876547] mwifiex_sdio mmc2:0001:1: info: FW download over, size 418332 bytes
	[   61.981497] mwifiex_sdio mmc2:0001:1: WLAN FW is active
	[   62.278898] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x242 error, result=0x2
	[   62.278919] mwifiex_sdio mmc2:0001:1: mwifiex_process_cmdresp: cmd 0x242 failed during	initialization
	[   62.661327] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (14.75.33.p119) 
	[   62.661349] mwifiex_sdio mmc2:0001:1: driver_version = mwifiex 1.0 (14.75.33.p119) 
	[   63.886186] mwifiex_sdio mmc2:0001:1: info: trying to associate to bssid CENSORED
	[   63.898581] mwifiex_sdio mmc2:0001:1: info: associated to bssid CENSORED successfully
	[   64.011982] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
	[  145.926392] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(1) failed: -110
	[  146.643323] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  147.342918] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(2) failed: -16
	[  148.041929] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  148.727401] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(3) failed: -16
	[  149.418479] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  149.418508] mwifiex_sdio mmc2:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
	[  150.108002] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(1) failed: -16
	[  150.788011] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  151.452231] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(2) failed: -16
	[  152.136966] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  152.836739] mwifiex_sdio mmc2:0001:1: host_to_card, write iomem	(3) failed: -16
	[  153.545571] mwifiex_sdio mmc2:0001:1: write CFG reg failed
	[  153.545611] mwifiex_sdio mmc2:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
	[  154.083665] mwifiex_sdio mmc2:0001:1: cmd_wait_q terminated: -110
	[  154.083707] mwifiex_sdio mmc2:0001:1: failed to get signal information
	[...]

Last observed scenario is again a failure occuring some time after
firmware loading succeeds. This also seems to be irrecoverable without
device reboot.

	[ 2101.209913] mwifiex_sdio mmc2:0001:1: mwifiex_cmd_timeout_func: Timeout cmd id = 0xa4, act = 0x0
	[ 2101.209941] mwifiex_sdio mmc2:0001:1: num_data_h2c_failure = 0
	[ 2101.209949] mwifiex_sdio mmc2:0001:1: num_cmd_h2c_failure = 0
	[ 2101.209957] mwifiex_sdio mmc2:0001:1: is_cmd_timedout = 1
	[ 2101.209964] mwifiex_sdio mmc2:0001:1: num_tx_timeout = 0
	[ 2101.209971] mwifiex_sdio mmc2:0001:1: last_cmd_index = 1
	[ 2101.209978] mwifiex_sdio mmc2:0001:1: last_cmd_id: 16 00 a4 00 75 00 a4 00 7f 00
	[ 2101.209988] mwifiex_sdio mmc2:0001:1: last_cmd_act: 00 00 00 00 02 00 00 00 00 00
	[ 2101.209995] mwifiex_sdio mmc2:0001:1: last_cmd_resp_index = 0
	[ 2101.210003] mwifiex_sdio mmc2:0001:1: last_cmd_resp_id: 16 80 a4 80 75 80 a4 80 7f 80
	[ 2101.210010] mwifiex_sdio mmc2:0001:1: last_event_index = 4
	[ 2101.210018] mwifiex_sdio mmc2:0001:1: last_event: 0b 00 0a 00 0b 00 0a 00 1c 00
	[ 2101.210025] mwifiex_sdio mmc2:0001:1: data_sent=1 cmd_sent=1
	[ 2101.210033] mwifiex_sdio mmc2:0001:1: ps_mode=1 ps_state=0
	[ 2101.210089] mwifiex_sdio mmc2:0001:1: failed to get signal information
	[ 2101.210761] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.210786] mwifiex_sdio mmc2:0001:1: failed to get signal information
	[ 2101.211162] mwifiex_sdio mmc2:0001:1: ===mwifiex driverinfo dump start===
	[ 2101.211178] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (14.75.33.p119) 
	[ 2101.211202] mwifiex_sdio mmc2:0001:1: SDIO register dump start
	[ 2101.211482] mwifiex_sdio mmc2:0001:1: SDIO Func0 (0x0-0x9): 32 02 02 02 03 00 00 02 03 00 
	[ 2101.211649] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x0-0x9): 02 3f 03 00 00 00 00 00 92 00 
	[ 2101.211740] mwifiex_sdio mmc2:0001:1: SDIO Func1: (0x28) 00 (0x30) 08 (0x34) 07 (0x38) 11 (0x3c) 00 
	[ 2101.211921] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x60-0x6a): dc fe 5f 81 ca 04 00 79 79 00 30 
	[ 2101.314135] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x60-0x6a): dc fe 5f 81 ca 04 00 79 79 00 30 
	[ 2101.314168] mwifiex_sdio mmc2:0001:1: SDIO register dump end
	[ 2101.314300] mwifiex_sdio mmc2:0001:1: ===mwifiex driverinfo dump end===
	[ 2101.314313] mwifiex_sdio mmc2:0001:1: == mwifiex dump information to /sys/class/devcoredump start
	[ 2101.314586] mwifiex_sdio mmc2:0001:1: == mwifiex dump information to /sys/class/devcoredump end
	[ 2101.314610] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.314638] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.317997] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318029] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318037] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318044] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318051] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318057] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318064] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318071] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318078] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318084] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318091] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318098] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.321278] mwifiex_sdio mmc2:0001:1: info: shutdown mwifiex...
	[ 2101.323214] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.323250] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.324427] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.419786] mmc2: queuing unknown CIS tuple 0x50 [40 1e fd d1 c0 46 70 47 00 b5 23 48 24 49 01 60 24 48 24 49 01 60 24 49 08 47 1f 48 24 49 01 60] (32 bytes)
	[ 2101.460850] mmc2: queuing unknown CIS tuple 0x70 [53 f0 21 e3 1e ff 2f e1 10 1f 11 ee 00 00 50 e3 02 2a a0 e3 02 10 c1 01 02 10 81 11 10 1f 01 ee 1e ff 2f e1 01 00 a0 e3 f6 ff ff eb ea ff ff fa 48 00 9f e5 54 10 9f e5 54 20 9f e5 ef ff ff eb] (71 bytes)
	[ 2101.532495] mmc2: queuing unknown CIS tuple 0xe8 [2f 07 ee 1e ff 2f e1 0e 30 a0 e1 00 00 a0 e3 ea ff ff eb e5 ff ff fa 03 e0 a0 e1 2c 30 9f e5 13 ff 2f e1 00 10 80 e5 1a 9f 00 ee 12 ff 2f e1 04 21 00 80 c0 00 10 80 04 22 00 80 06 0a 46 02 48] (144 bytes)
	[ 2101.598922] mmc2: queuing unknown CIS tuple 0x9d [29 15 1d 01 00 4d 61 72 76 65 6c 6c 20 42 6c 75 65 74 6f 6f 74 68 20 44 65 76 69 63 65 00 00 ff 20 04 df 02 32 91 21 02 0c 00 22 2a 01 01 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00] (162 bytes)
	[ 2101.599647] mmc2: tried to HW reset card, got error -2
	[ 2101.599699] mwifiex_sdio mmc2:0001:1: SDIO HW reset failed: -2

Despite these problems, the wireless is overall usable on the phone,
once the firmware loading succeeds, even for intensive transfers, until
one of the other failures occurs, for which no rule seems to exist - it
can happen soon after starting some transfer or it can work for several
hours under normal load, although some CMD_RESP errors (as above) are
printed frequently.

[1] https://lore.kernel.org/all/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr/
[2] https://github.com/CoderCharmander/g361f-kernel
[3] https://github.com/acorn-marvell/brillo_pxa_kernel
[4] https://wiki.postmarketos.org/wiki/Marvell_PXA1908

Karel Balej (2):
  dt-bindings: mwifiex: document use with the SD8777 chipset
  net: mwifiex: add support for the SD8777 chipset

 .../bindings/net/wireless/marvell-8xxx.txt    |  3 ++-
 drivers/net/wireless/marvell/mwifiex/Kconfig  |  4 ++--
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  1 +
 include/linux/mmc/sdio_ids.h                  |  1 +
 5 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.42.0

