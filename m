Return-Path: <linux-kernel+bounces-113764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325B888678
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E6C1F24BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C2F1F23F3;
	Sun, 24 Mar 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/wqQ3YZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5814127B5A;
	Sun, 24 Mar 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320771; cv=none; b=IO+kNq+Ppn0KG68F91G/wCCIiSx4TbBa8saotioaiyX1mNAalnzGJXGOqH5qyDUU+TuB17cSxxcV0pe68NYOYNSp4aSPAT4a3WDv9tdjhYr6rPqx5d4LRvYV/1G3eGlUmGebAv2+vuPukW7pbWrA979DRR7IrWppP+pjDnf5Ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320771; c=relaxed/simple;
	bh=k9fXtCbqXNZ0AnUWWV++CufZSs17sIiecx+63pb9vlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc7TiLK4ppsWRcQUO8xluDPPLybHyo1FGvxMQvarHCuJZ2WbJNyBcPGJHcDORk4r+CrczhrDXO/Reew82Ti62xFgFVn+Nhx6NMbbhSgNJGekOvpZooXI7WJNRH1dPKiMQBGrNDEIj+zzGMX60pQfMLSVzFtDTzUFZX1W59yGSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/wqQ3YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934AEC433F1;
	Sun, 24 Mar 2024 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320770;
	bh=k9fXtCbqXNZ0AnUWWV++CufZSs17sIiecx+63pb9vlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/wqQ3YZ2o47wjII5gG/ix2WUCO7BZCsIJ7gdhb2H+OQ6J303uPPWdeeM02GpSQBJ
	 WmJXZfLKIKMrMzxQFq1Al7wjiNoZnzd89j4LVEdEbks6bOfnZBEBT4kjdHZce0O+xd
	 3bYSO1BbEcHogKksNrzEnLucb/1HslDp+/nB9K9rjAjgY9UyXKzDCBiqHaOC/nERau
	 1Hi0Bn6cBhH/TPp295y2DXihYgKRV6Tk2GutwC5OiIqk6ZTI7xDc1TBmmugF3qMDxf
	 w2IZ/qLiny4T48+Evc9+G0C7g5nFEtymk2c3NB2q6Y0xDtqV1erJXzR6kdou7al4Z+
	 BPwahHq+Q020Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 334/713] wifi: rtw88: 8821cu: Fix firmware upload fail
Date: Sun, 24 Mar 2024 18:41:00 -0400
Message-ID: <20240324224720.1345309-335-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 41a7acb7dde8395f52a707bbba7712a898dfafb0 ]

RTL8822CU, RTL8822BU, and RTL8821CU need an extra register write after
reading and writing certain addresses.

Without this, the firmware upload fails approximately more than 50% of
the time.

Tested with RTL8811CU (Tenda U9 V2.0) which is the same as RTL8821CU
but without Bluetooth.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e6ab1ac6d7093..a0188511099a1 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -33,6 +33,36 @@ static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
 	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
 }
 
+static void rtw_usb_reg_sec(struct rtw_dev *rtwdev, u32 addr, __le32 *data)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	bool reg_on_section = false;
+	u16 t_reg = 0x4e0;
+	u8 t_len = 1;
+	int status;
+
+	/* There are three sections:
+	 * 1. on (0x00~0xFF; 0x1000~0x10FF): this section is always powered on
+	 * 2. off (< 0xFE00, excluding "on" section): this section could be
+	 *    powered off
+	 * 3. local (>= 0xFE00): usb specific registers section
+	 */
+	if (addr <= 0xff || (addr >= 0x1000 && addr <= 0x10ff))
+		reg_on_section = true;
+
+	if (!reg_on_section)
+		return;
+
+	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				 RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
+				 t_reg, 0, data, t_len, 500);
+
+	if (status != t_len && status != -ENODEV)
+		rtw_err(rtwdev, "%s: reg 0x%x, usb write %u fail, status: %d\n",
+			__func__, t_reg, t_len, status);
+}
+
 static u32 rtw_usb_read(struct rtw_dev *rtwdev, u32 addr, u16 len)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
@@ -58,6 +88,11 @@ static u32 rtw_usb_read(struct rtw_dev *rtwdev, u32 addr, u16 len)
 		rtw_err(rtwdev, "read register 0x%x failed with %d\n",
 			addr, ret);
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822B ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_usb_reg_sec(rtwdev, addr, data);
+
 	return le32_to_cpu(*data);
 }
 
@@ -102,6 +137,11 @@ static void rtw_usb_write(struct rtw_dev *rtwdev, u32 addr, u32 val, int len)
 	if (ret < 0 && ret != -ENODEV && count++ < 4)
 		rtw_err(rtwdev, "write register 0x%x failed with %d\n",
 			addr, ret);
+
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822B ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_usb_reg_sec(rtwdev, addr, data);
 }
 
 static void rtw_usb_write8(struct rtw_dev *rtwdev, u32 addr, u8 val)
-- 
2.43.0


