Return-Path: <linux-kernel+bounces-127293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7504894951
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691ED283C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59035DF42;
	Tue,  2 Apr 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HaO/i8dh"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51478F7D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024709; cv=none; b=VydhNPR5Ef+MXDVyeVpzIDI/4PUKzXBBFC7q6CsvW8QhHF9k7DD3khLqaUH/cd2GV0KhVz1J3RFEgJF63aJ6LOvA0f2ywN9hw6fXBmixJMAchi40OKLMYIpYDnMNgtcWpjcPjVVEiJeYYVgBnRlq6mAk/BwautF/afivMSVsLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024709; c=relaxed/simple;
	bh=IW+56lxilHIV/NjCwVyHui/3X+WfcOhkOIhe1DBfPgU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J/MaOn2CySxvDEHg3u6dveAe7b3qtFMDfTmJu689rEgPt+Od3/NfbCRpypw7tw3SYM0Bk0QRWpsQZzawzlndQwdYpQvgwduOjSOm9DJ+nzx53x584tfq1kXBgpp5+uqeYVNQlt2PCZ19dAmItK4nfuSxId6eNFxqQ9jyNqwSH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HaO/i8dh; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712024699; bh=AgJwW43Q7MpnhHFZxa9TVyvkVMcGmwHpkk0ychbYba0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HaO/i8dheBEDjodXjPIxa/X60n/aLXnYP5QQTCO0ZWij9z/0U2wjhOJ7sMxLFTdOH
	 CPt5+wYFjet47IkuDBYKTagxpU7QqWTMvlfox/n4BEE4u/yWyyhYxsU/H1cz0LBnx9
	 UP8p8w9qcQ9k07SQ0EBY5aRTh+lgBDHZUp0O9gJ0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 63A140AD; Tue, 02 Apr 2024 10:24:58 +0800
X-QQ-mid: xmsmtpt1712024698tg1e6aqsc
Message-ID: <tencent_A6BE4B38751776D567BC3C2337FC960C3709@qq.com>
X-QQ-XMAILINFO: MpvVxjO9l39xz2IdF26OEwQuICFQDPHQZ0/WAWPlXD9vobRf0GcrtT0jBHI1gH
	 7UDV65riknxtD0B0S9ssIleHOhStCyOfrWBjTKnHi4reaRm5NaCYQWpzn0tmGaqTy+kObbhyyhkg
	 FMuAxoB5bJi/IiA7E3q7tucjOJExgxCnxUrhyM/PNLaor7rnIRIKC2BfcjcMsId+UTACDiwakGqH
	 J+DSjfl8uiw/EvUtotLQzSNDPLVP1R1WdzBib6Lo2nvWXExKulkO+iSRxR1i9Fvz2mfJ5PHAoJ7z
	 XmxbCYWHcfl7EcyJw19jiwaCe92pAgJYGDSBo/JJb7tyYCln45UbRWtYP5Js2vK9S+PMP4pD1RSE
	 06tvN5pmcsD3fsK961m9UO9KPikedmVIybTMObiCP2x9zH3kkOQqzpcWxub+eMzGgSMavSHUAYVK
	 mbZ2DoD8TbZFOW3OM2we76RpyYAkMelC+RYiilrG8IAuQop5oPY3BYfFEhImcfCkjfm8EQ9v11w+
	 N5JikrTJvulAAGHd4uMgl2zx7Zlw+92mjGn/W3xoJr8NuilPo6L6BLMucZso3Tl5mT32iL4U3iku
	 ECojCQ8w1kUP7cE2xhwDm3UD1MpxrVo0l+u2ybLJ+awIVzIuP+s/aOnFTwQ2JT+ykQ/gdKHzuFgO
	 lNZ986lWeyzmH98TCQaDR/D1Wg2iPddFH/8mo/mL4436ochOlrIbHfW5wsndNj/VNCMd6mOkEvII
	 n55bdMnXIArm9iiftC6bcuAZM0yyCvlAbn2E3jVlu/E6EEJQFMywZ69r3ZL6+Y2GFG3QRdFtiaR5
	 DafUPgOV5C8PXYRXpyf5/OmqX5k08PBUxzxaPEc95I90Pou/dK9wcS7lhxd4Pf9pM1JCueMjPCbM
	 N/Cujg/g6QTpwMMCsMQy+o8PlzjT6mCi6LhQN53+Nb+nmmogIZ37NYiWE1DXIhxuJjhLlqX/56Jm
	 /9RRgr2UA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [sound?] KMSAN: uninit-value in line6_pod_process_message
Date: Tue,  2 Apr 2024 10:24:58 +0800
X-OQ-MSGID: <20240402022457.1738306-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000084b18706150bcca5@google.com>
References: <00000000000084b18706150bcca5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in line6_pod_process_message

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b67617b68e50..8fd9d42aa8e2 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -697,7 +697,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 


