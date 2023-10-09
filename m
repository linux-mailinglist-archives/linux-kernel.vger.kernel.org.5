Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D67BD412
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbjJIHJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbjJIHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC094;
        Mon,  9 Oct 2023 00:09:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6535C433B6;
        Mon,  9 Oct 2023 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696835395;
        bh=laGQUOyn4KCepo+cHn7ADCkvO41qlO/e9164aDPaDKw=;
        h=From:To:Cc:Subject:Date:From;
        b=V0sFDqi/xtkR1ONHTOaiRXroiVD5/XxgniHuHOQr2gl0Vq100F8qAUnOQipmWCjeV
         qB1elols6WbCZVE2pC4wy0gXZ1eDomX6jjK7eNzIWgksE+Au53j0tSB1GfjT7JOLfa
         VGhhhhCCa5tx/2PBM8H0HtPIqHTHQx2uJjHmpkM+kpqvn038N4JpAu8juBptghTbUI
         FEr0URcEivyQuJkmVPesG6cec8FmKTViJn4gdS8x1c9/cAByNlPOVuhZb725d9++vC
         23Ke8K0pIRnbeuP8UcLEDcHOqu3fiR0Qm+aVM/2KrMNzYUeEHSD9N5hl5PkYMsb9H+
         6CRjKcIO8nZJw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFH] wireless-next: fix new W=1 warnings
Date:   Mon, 09 Oct 2023 10:09:53 +0300
Message-ID: <87fs2k5l1a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During the weekend we updated wireless-next tree from v6.5 to v6.6-rc4+.
It looks like a new warning was enabled for v6.6 as I see with GCC 13.2
and W=1 several warnings (list below). In v6.5 wireless code was still
W=1 warning free with GCC.

For wireless we get lots of questionable cleanup patches. But actually
these kind of warnings are what we would prefer to be fixed instead of
the random churn we always see. Hence I'm sending this Request For Help
(RFH) in case the cleanup people would fix these. Is there a mailing
list I should send this to?

The sooner these are fixed the better, it makes it difficult for us to
see any new warnings from this noise.

Kalle

drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:63: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:9: note: 'snprintf' output between 4 and 140 bytes into a destination of size 32
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:63: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:9: note: 'snprintf' output between 4 and 98 bytes into a destination of size 32
drivers/net/wireless/intel/iwlwifi/dvm/main.c:1467:19: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/dvm/main.c:1465:9: note: 'snprintf' output between 1 and 64 bytes into a destination of size 32
drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1307:19: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1305:9: note: 'snprintf' output between 1 and 64 bytes into a destination of size 32
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:52: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:9: note: 'snprintf' output between 9 and 17 bytes into a destination of size 9
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:55: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:50: warning: '/' directive output may be truncated writing 1 byte into a region of size between 0 and 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:42: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:549:33: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 48 and 56 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:547:9: note: 'snprintf' output 9 or more bytes (assuming 80) into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:729:33: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 48 and 56 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:727:9: note: 'snprintf' output 9 or more bytes (assuming 80) into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:989:51: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 46 and 58 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:987:33: note: 'snprintf' output between 7 and 82 bytes into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:984:53: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 40 and 50 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:982:33: note: 'snprintf' output between 15 and 88 bytes into a destination of size 64
drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size 2 [-Wformat-truncation=]
drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: 'snprintf' output between 5 and 7 bytes into a destination of size 5
drivers/net/wireless/ath/ath9k/hif_usb.c:1223:42: warning: '.0.fw' directive output may be truncated writing 5 bytes into a region of size between 4 and 11 [-Wformat-truncation=]
drivers/net/wireless/ath/ath9k/hif_usb.c:1222:17: note: 'snprintf' output between 27 and 34 bytes into a destination of size 32
