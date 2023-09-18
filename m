Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B57A509B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjIRRJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjIRRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:09:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4C91
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:09:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso35269065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695056981; x=1695661781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IItNc+Zt5nnQ/8UdDotMfLHi/NEp9s9tuV8PI8RzTEg=;
        b=HFcQ/hteFuQSIJGVBRo5W2ZCLOD6Cd+9aC8Zx2njOy3l0Q+0udB9b4W5+ZV0Pcy5Vz
         rmZBk3+fgvrjCVw3d50cTrhmYCQtRXjULEZXvCz/iVH7E3Im9N8JlQgNXk+vv6Figgzh
         Y6ItT69mFZd8aQdpQefHhQSUq8xZYWyRRouMuL+5nfsjY1w9svAdc9aVuIxinffvXgBF
         7PT/KCnaBx52xEl//fogzVyAqKySZVA/iCegLjS7iibGVWsQJuOKg3ybPu9RBZQLEEhf
         IcicLj9Qyj7xnAvR6SIKpyCCE0643GrgBtSG4lbHFv1Ow+q2c2xKahtfWWq7wRhj1hbJ
         TGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056981; x=1695661781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IItNc+Zt5nnQ/8UdDotMfLHi/NEp9s9tuV8PI8RzTEg=;
        b=PUBUtK+VRmWfhVHbcmOdVNG3cAMlwR1VSor2icYKIAMjmrKheRSQJgVSCBD93SeJHi
         j/mgLTJYcGr8iwihux5SzQlQv3bMlrwU20HiC7dy+AVs2l/UqbGVpPpLsHPna7VKBFA6
         msCXSvskpe1DvKdiq9GM2wc0tjVwiV+Lshxau+u3AJKDH+N6/TbQoDJsjo4NG09SYdCr
         YBAgNYg2QTsjB8vEbk9LLjIaanFWzrwBza2N+KOgL36JHvs2HuO691Pi/BDz7q2sFP+N
         YM8y+zLNI9fPz100cxN3p22IZIKZZCJPjq+q0MLgrC8NsAYU7eK+ifsC/QeglDJXiF/j
         a62w==
X-Gm-Message-State: AOJu0YxI5UpuldCsN2sEP1Dmqt8qKnhoc52HoRFHaGiiTYMYtxdkzGwR
        t/UJGmN3+sdjmxfImUMobRnCpQ==
X-Google-Smtp-Source: AGHT+IGICE7p0GqE8Tg9jhcYRkzC3fqApnNRjDURAFmQTFb9i/QX9MA1iUEb6QiwhikQ+AKuqo0Hjg==
X-Received: by 2002:a17:902:e9d5:b0:1bd:e64c:5c71 with SMTP id 21-20020a170902e9d500b001bde64c5c71mr6845120plk.21.1695056981249;
        Mon, 18 Sep 2023 10:09:41 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001c57aac6e5esm1604567plb.23.2023.09.18.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:09:40 -0700 (PDT)
From:   Jade Lovelace <lists@jade.fyi>
To:     Gene <lists@sapience.com>, Ricky WU <ricky_wu@realtek.com>,
        Keith Busch <kbusch@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     regressions@lists.linux.dev, Alyssa Ross <hi@alyssa.is>,
        Michal Suchanek <msuchanek@suse.de>,
        "axboe @ kernel . dk " <axboe@kernel.dk>,
        "sagi @ grimberg . me " <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org " 
        <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gene <geneslists@sapience.com>
Subject: [PATCH] Revert "misc: rtsx: judge ASPM Mode to set PETXCFG Reg"
Date:   Mon, 18 Sep 2023 10:07:39 -0700
Message-ID: <20230918170831.1677690-3-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
References: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 101bd907b4244a726980ee67f95ed9cafab6ff7a.

This commit causes the NVMe controller to not work on the Dell XPS 15
9560, and similar laptop models. It appears to happen with any SSD
model.

This commit is broken on 6.1, 6.4, 6.5, and 6.6-rc1.

OpenSUSE has already reverted, and I have submitted a revert to NixOS.
As far as I can tell, this regression has fallen through the cracks.

Symptom:

kernel: nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
kernel: nvme nvme0: Does your device have a faulty power saving mode enabled?
kernel: nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to D0, device inaccessible
kernel: nvme nvme0: Disabling device after reset failure: -19
systemd-cryptsetup[169]: Device /dev/disk/by-uuid/b80aedf8-ddd4-46fa-8d09-5215d5f286b9 READ lock released.
systemd-cryptsetup[169]: IO error while decrypting keyslot.
systemd-cryptsetup[169]: Keyslot 0 (luks2) open failed with -5.
systemd-cryptsetup[169]: Keyslot open failed.
systemd-cryptsetup[169]: Failed to activate with specified passphrase: Input/output error

There are several downstream bugs, these are the ones I know of:
- https://bugzilla.suse.com/show_bug.cgi?id=1214428
- https://github.com/NixOS/nixpkgs/issues/253418
- https://bugs.archlinux.org/task/79439#comment221866

Upstream revert links:
- https://github.com/openSUSE/kernel-source/commit/1b02b1528a26f4e9b577e215c114d8c5e773ee10
- https://github.com/NixOS/nixpkgs/pull/255824

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217802
Reported-and-bisected-by: Gene <geneslists@sapience.com>
Link: https://lore.kernel.org/lkml/30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com/
Signed-off-by: Jade Lovelace <lists@jade.fyi>
---
 drivers/misc/cardreader/rts5227.c  |  2 +-
 drivers/misc/cardreader/rts5228.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rts5249.c  |  3 ++-
 drivers/misc/cardreader/rts5260.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rts5261.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rtsx_pcr.c |  5 +----
 6 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3dae5e3a1697..d676cf63a966 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -195,7 +195,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
 				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index f4ab09439da7..cfebad51d1d8 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -435,10 +435,17 @@ static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -469,6 +476,17 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 47ab72a43256..91d240dd68fa 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -327,11 +327,12 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
+
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
 	 */
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_write_register(pcr, PETXCFG,
 			FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 79b18f6f73a8..9b42b20a3e5a 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -517,10 +517,17 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	/* Set mcu_cnt to 7 to ensure data can be sampled properly */
 	rtsx_pci_write_register(pcr, 0xFC03, 0x7F, 0x07);
@@ -539,6 +546,17 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rts5260_init_hw(pcr);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return 0;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 94af6bf8a25a..b1e76030cafd 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -498,10 +498,17 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
@@ -547,6 +554,17 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a3f4b52bb159..32b7783e9d4f 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1326,11 +1326,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
-	if (pcr->aspm_mode == ASPM_MODE_REG) {
+	if (pcr->aspm_mode == ASPM_MODE_REG)
 		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
-		rtsx_pci_write_register(pcr, PETXCFG,
-				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-	}
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
-- 
2.42.0

