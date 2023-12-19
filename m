Return-Path: <linux-kernel+bounces-4772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32948181D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED08281E78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B661216423;
	Tue, 19 Dec 2023 06:58:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6463812B80;
	Tue, 19 Dec 2023 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3FA5260F0D2BB;
	Tue, 19 Dec 2023 14:57:51 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Larry.Finger@lwfinger.net,
	linville@tuxdriver.com,
	george0505@realtek.com,
	chaoming_li@realsil.com.cn,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 00/11] using calculate_bit_shift() to fix undefined bitwise shift behavior.
Date: Tue, 19 Dec 2023 14:57:28 +0800
Message-Id: <20231219065739.1895666-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an undefined bitwise shift behavior, when the right operand is
greater than or equal to then width of the  promoted left operand.
(eg: (u32)data << 32). Commit bc8263083af6("fix an undefined bitwise shift
behavior") only fixed one problem, there are many similar problems in 
drivers/net/wireless/realtek/. 

This patchset adds a new function calculate_bit_shift() to fix the
remaining undefined bitwise shift behavior problems.(Compile tested only)

Su Hui (11):
  wifi: rtlwifi: add calculate_bit_shift()
  wifi: rtlwifi: rtl8821ae: phy: using calculate_bit_shift()
  wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
  wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
  wifi: rtlwifi: rtl8723_common: using calculate_bit_shift()
  wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 14 ++++----------
 .../realtek/rtlwifi/rtl8192c/phy_common.c        | 12 ++----------
 .../realtek/rtlwifi/rtl8192c/phy_common.h        |  1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c |  6 +++---
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h |  1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c |  6 +++---
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 15 ++++-----------
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c | 16 ++++------------
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c | 15 ++++-----------
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c |  6 +++---
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c |  4 ++--
 .../realtek/rtlwifi/rtl8723com/phy_common.c      | 12 ++----------
 .../realtek/rtlwifi/rtl8723com/phy_common.h      |  1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 15 ++++-----------
 drivers/net/wireless/realtek/rtlwifi/wifi.h      |  7 +++++++
 15 files changed, 42 insertions(+), 89 deletions(-)

-- 
2.30.2


