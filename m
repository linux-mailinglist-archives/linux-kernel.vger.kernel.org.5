Return-Path: <linux-kernel+bounces-47720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9A8451BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C60D1F2762E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2441586C2;
	Thu,  1 Feb 2024 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixM97rRB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2179157E90
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771234; cv=none; b=LkFYT/Odv21zg6o/qK5QYVOEsSiESzMN5lsOJ3ub9XeP8rf1WyiTekQgkychKXK8Tvz+m4xbzjLl6Kb9yMC4GxkdqM0i6Fn4z0En4bM9NcjoqDYENH0SSOLCNi0FyYp6JpLhFMTy4y2VIWwyjRQaXOOdHr5kF69AKButQJraT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771234; c=relaxed/simple;
	bh=Cq73BcEx/uYKDbOU3/mg9M1bMhtj7nZ8crkg4Fn+pc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WsgiCyAzDFgJhUpPxhXA3arji883tZ7X73NG1zJ47sC7bpN3jqhE0v9XRw7KHbi4tTH7WFsevut7ntnhbpjdP9VTW2SB5bauHXbIB1+inACBA4zjIfmWuGrV6nw3GxlaX/NiJHVgVELqZjKMuXj5oC319RbJ5FqknMKvRSl+v/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vincenttew.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixM97rRB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vincenttew.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60407831b3cso11374527b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706771231; x=1707376031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nARAJpsDECWE0kiylBNBZDPewhI1rfVQYGPQbaScn7c=;
        b=ixM97rRBFltiLaTHg0ReAjOqOOGM6HjhTmNEv5fzA2bXq0TTZAvh+PmQggDpOaF1Ju
         BepaFkKwQMv8ayl6u7BEHBOSTQsdj/8vYsNJtGLJoGRwD3eejrbshZ/juWssqpPKYiiN
         xhjqZGDXh56dBJU+i6DaVHTrTyssGawP12D1WLQTJupOTJdp6Hv9u+6xFui9sPAp7PRc
         cF7EefU31biAvr7S43l/ViX5MDCmuIWVrIh7IeoZEbYGtWTIZREnm4/h+kDbuPw7uhIi
         hrcI+hgauABGsQzRHVC0ueKdW5UzEmSBNGU7uQAsysPt9o+ByLSaXfJFKXxV+wzpzmb+
         ZEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706771231; x=1707376031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nARAJpsDECWE0kiylBNBZDPewhI1rfVQYGPQbaScn7c=;
        b=CR7kOX97B/avSbSKKoYKAHs6QYC0v5D1cv9UMCFUG/FiYrYytsuNum2Sj60qKFTokE
         THNQslV3N2u/OztEepINd3Rzt45erbu7n5Yj2Rgwp8yCjPLxs+W7mMsKidPEDciaBhyw
         dKZ3RFqtArOCX57skzwxY8Wbh0oJGCW0GcL/53dHkAVhXSj/kbJMdK0y+ETu96WKGTaS
         aQzoKILLJrZ2G026kXtbfpo7+KQAIPEgAl0ITbAzMF9vpK5cbhwZhOGBpMxWHBgq/Ujh
         a1ZqfoSFSlzDnYk7T1MrUDe3X9YNmeqy9nq+kaxV6Jd72RjW0SD4CZNSejSF92lE+KJu
         5Hqg==
X-Gm-Message-State: AOJu0Yz2B3GI6TZmDMlL/fvcMtqRzB+iV18tjb5EH1Tmo8BnOOqVYPY+
	WkYxMcmUb5N7zc0l6Cc9r0eXF8vkmVmBum9sFwFdbmZ/WMPwja80RscG5MI4pg9OymRK0rnR2PY
	m35J0LiT2DUlm/qFAFw==
X-Google-Smtp-Source: AGHT+IHS6RTl0iDRKRZ2PQzkBsUbcBqzMJTi18Hw7Gd56oY2VMs1/QXeWN3CaEJwy1YoCP5dIyXlKQudFtJMpEj3
X-Received: from vincenttew1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1bb2])
 (user=vincenttew job=sendgmr) by 2002:a81:9b12:0:b0:5fb:455a:df08 with SMTP
 id s18-20020a819b12000000b005fb455adf08mr928942ywg.7.1706771231672; Wed, 31
 Jan 2024 23:07:11 -0800 (PST)
Date: Thu,  1 Feb 2024 15:06:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201070641.401684-1-vincenttew@google.com>
Subject: [PATCH] ALSA: usb-audio: retry clock validate when it takes some times
From: vincenttew <vincenttew@google.com>
To: perex@perex.cz, tiwai@suse.com, vincenttew@google.com, 
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: alexander@tsoy.me
Content-Type: text/plain; charset="UTF-8"

Behringer UMC202HD and UMC404HD take some times to validate the clock
source. To prevent more DAC have the same delay which return the false
in the first time, remove the USB id check to have a chance to retry the
clock validate.

Signed-off-by: vincenttew <vincenttew@google.com>
---
 sound/usb/clock.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b118cf97607f..16d7a456dd10 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -181,34 +181,27 @@ static bool uac_clock_source_is_valid_quirk(struct snd_usb_audio *chip,
 			return true;
 	}
 
-	/*
-	 * MOTU MicroBook IIc
-	 * Sample rate changes takes more than 2 seconds for this device. Clock
-	 * validity request returns false during that period.
-	 */
-	if (chip->usb_id == USB_ID(0x07fd, 0x0004)) {
-		count = 0;
+	count = 0;
 
-		while ((!ret) && (count < 50)) {
-			int err;
+	while ((!ret) && (count < 50)) {
+		int err;
 
-			msleep(100);
-
-			err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
-					      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-					      UAC2_CS_CONTROL_CLOCK_VALID << 8,
-					      snd_usb_ctrl_intf(chip) | (source_id << 8),
-					      &data, sizeof(data));
-			if (err < 0) {
-				dev_warn(&dev->dev,
-					 "%s(): cannot get clock validity for id %d\n",
-					   __func__, source_id);
-				return false;
-			}
-
-			ret = !!data;
-			count++;
+		msleep(100);
+
+		err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+				      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+				      UAC2_CS_CONTROL_CLOCK_VALID << 8,
+				      snd_usb_ctrl_intf(chip) | (source_id << 8),
+				      &data, sizeof(data));
+		if (err < 0) {
+			dev_warn(&dev->dev,
+				 "%s(): cannot get clock validity for id %d\n",
+				   __func__, source_id);
+			return false;
 		}
+
+		ret = !!data;
+		count++;
 	}
 
 	return ret;
-- 
2.43.0.429.g432eaa2c6b-goog


