Return-Path: <linux-kernel+bounces-48048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B488C84569E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBBD2849DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72DD161B53;
	Thu,  1 Feb 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNGHT2ex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24516089D;
	Thu,  1 Feb 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788417; cv=none; b=ZuUGS2/eBi9wHaX8YCB3+yAjocoV14eoEJ6JSkVXALpQFfHcajmpRIeSWI/pMr1Ir3HPUvfRJeO6Sf8A3SqQ7fGxR5Q/F0BjBmAAGhwFgFRp+akCh7e+B0bW94Rh0uyVTRe6Ro67UjhYVxg1E9/JjLP02JgGrRZNoXnXuZD74j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788417; c=relaxed/simple;
	bh=NF/WyNz8fSJXXP6Kn7H5YvVfKOqkIoj0xrHRvaRo2mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ4IUcxe0ytbNcaY8o8h4YpixqXEPtGKu7qm/96Vmtkx/AgLPNGUjckPBfSkx/cYvpGDYqUCrAiV2dNFS/W/xPVA0GuSZSVLj1MtVzvvLXGJc6UF9CkhfgonCPinwB1Wd8wBNpERzddHIJIj998noml7qJtU5Am/Jixo3H/G14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNGHT2ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B98C433C7;
	Thu,  1 Feb 2024 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788417;
	bh=NF/WyNz8fSJXXP6Kn7H5YvVfKOqkIoj0xrHRvaRo2mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNGHT2exEp4W0nJRU3r+k4NHUJ4UbMrAnlMHIWY7IedIvpUjmfMfxlFNlOm1i6w5W
	 tfV61ZlxLQeDsjEBqgyFeKy4PmZ3pwLcjZ59lhnFAAyO9tAR9pKuIUBwCe6TSo4sZA
	 rQJbhUmLUTTRDcvu17Vitnsf6PcEJmkwLK8KDynl6C326JvkX6nBRSCV621eHc6D4O
	 JLad5znyo94r+VxbMSlbZJ466YdSYmVYV1mK81NxOqXPC7VVSxC473LTF1FyG/MUq3
	 69v7Iwy43en8QVn+ncbyLHSyWhmZG3RR3HcrVKqPSC+48ogC9AaO6y+9qcZ0YrtznP
	 j7TPvlr5DVqqQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/7] HID: hid-prodikeys: remove struct pk_device
Date: Thu,  1 Feb 2024 12:53:20 +0100
Message-ID: <20240201115320.684-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, quirks was unused in struct pk_device.

And I see no reason for this additional level of indirection. struct
pcmidi_snd is far enough for the driver. Unless I am missing something?

So drop struct pk_device and convert all the users to use struct
pcmidi_snd directly. No need for doubled kmalloc+kfrees now.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-prodikeys.c | 113 +++++++++++++-----------------------
 1 file changed, 40 insertions(+), 73 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 439f4320f1d2..a593ed62c969 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -32,13 +32,6 @@
 
 struct pcmidi_snd;
 
-struct pk_device {
-	unsigned long		quirks;
-
-	struct hid_device	*hdev;
-	struct pcmidi_snd	*pm; /* pcmidi device context */
-};
-
 struct pcmidi_sustain {
 	unsigned long		in_use;
 	struct pcmidi_snd	*pm;
@@ -50,7 +43,7 @@ struct pcmidi_sustain {
 
 #define PCMIDI_SUSTAINED_MAX	32
 struct pcmidi_snd {
-	struct pk_device		*pk;
+	struct hid_device		*hdev;
 	unsigned short			ifnum;
 	struct hid_report		*pcmidi_report6;
 	struct input_dev		*input_ep82;
@@ -98,11 +91,11 @@ static ssize_t show_channel(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
-	dbg_hid("pcmidi sysfs read channel=%u\n", pk->pm->midi_channel);
+	dbg_hid("pcmidi sysfs read channel=%u\n", pm->midi_channel);
 
-	return sprintf(buf, "%u (min:%u, max:%u)\n", pk->pm->midi_channel,
+	return sprintf(buf, "%u (min:%u, max:%u)\n", pm->midi_channel,
 		PCMIDI_CHANNEL_MIN, PCMIDI_CHANNEL_MAX);
 }
 
@@ -111,13 +104,13 @@ static ssize_t store_channel(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
 	unsigned channel = 0;
 
 	if (sscanf(buf, "%u", &channel) > 0 && channel <= PCMIDI_CHANNEL_MAX) {
 		dbg_hid("pcmidi sysfs write channel=%u\n", channel);
-		pk->pm->midi_channel = channel;
+		pm->midi_channel = channel;
 		return strlen(buf);
 	}
 	return -EINVAL;
@@ -135,11 +128,11 @@ static ssize_t show_sustain(struct device *dev,
  struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
-	dbg_hid("pcmidi sysfs read sustain=%u\n", pk->pm->midi_sustain);
+	dbg_hid("pcmidi sysfs read sustain=%u\n", pm->midi_sustain);
 
-	return sprintf(buf, "%u (off:%u, max:%u (ms))\n", pk->pm->midi_sustain,
+	return sprintf(buf, "%u (off:%u, max:%u (ms))\n", pm->midi_sustain,
 		PCMIDI_SUSTAIN_MIN, PCMIDI_SUSTAIN_MAX);
 }
 
@@ -148,15 +141,14 @@ static ssize_t store_sustain(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
 	unsigned sustain = 0;
 
 	if (sscanf(buf, "%u", &sustain) > 0 && sustain <= PCMIDI_SUSTAIN_MAX) {
 		dbg_hid("pcmidi sysfs write sustain=%u\n", sustain);
-		pk->pm->midi_sustain = sustain;
-		pk->pm->midi_sustain_mode =
-			(0 == sustain || !pk->pm->midi_mode) ? 0 : 1;
+		pm->midi_sustain = sustain;
+		pm->midi_sustain_mode = (0 == sustain || !pm->midi_mode) ? 0 : 1;
 		return strlen(buf);
 	}
 	return -EINVAL;
@@ -174,11 +166,11 @@ static ssize_t show_octave(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
-	dbg_hid("pcmidi sysfs read octave=%d\n", pk->pm->midi_octave);
+	dbg_hid("pcmidi sysfs read octave=%d\n", pm->midi_octave);
 
-	return sprintf(buf, "%d (min:%d, max:%d)\n", pk->pm->midi_octave,
+	return sprintf(buf, "%d (min:%d, max:%d)\n", pm->midi_octave,
 		PCMIDI_OCTAVE_MIN, PCMIDI_OCTAVE_MAX);
 }
 
@@ -187,14 +179,14 @@ static ssize_t store_octave(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = to_hid_device(dev);
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
 	int octave = 0;
 
 	if (sscanf(buf, "%d", &octave) > 0 &&
 		octave >= PCMIDI_OCTAVE_MIN && octave <= PCMIDI_OCTAVE_MAX) {
 		dbg_hid("pcmidi sysfs write octave=%d\n", octave);
-		pk->pm->midi_octave = octave;
+		pm->midi_octave = octave;
 		return strlen(buf);
 	}
 	return -EINVAL;
@@ -268,7 +260,7 @@ static void stop_sustain_timers(struct pcmidi_snd *pm)
 
 static int pcmidi_get_output_report(struct pcmidi_snd *pm)
 {
-	struct hid_device *hdev = pm->pk->hdev;
+	struct hid_device *hdev = pm->hdev;
 	struct hid_report *report;
 
 	list_for_each_entry(report,
@@ -293,7 +285,7 @@ static int pcmidi_get_output_report(struct pcmidi_snd *pm)
 
 static void pcmidi_submit_output_report(struct pcmidi_snd *pm, int state)
 {
-	struct hid_device *hdev = pm->pk->hdev;
+	struct hid_device *hdev = pm->hdev;
 	struct hid_report *report = pm->pcmidi_report6;
 	report->field[0]->value[0] = 0x01;
 	report->field[0]->value[1] = state;
@@ -620,7 +612,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 
 	/* Setup sound card */
 
-	err = snd_card_new(&pm->pk->hdev->dev, index[dev], id[dev],
+	err = snd_card_new(&pm->hdev->dev, index[dev], id[dev],
 			   THIS_MODULE, 0, &card);
 	if (err < 0) {
 		pk_error("failed to create pc-midi sound card\n");
@@ -658,7 +650,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		&pcmidi_in_ops);
 
 	/* create sysfs variables */
-	err = device_create_file(&pm->pk->hdev->dev,
+	err = device_create_file(&pm->hdev->dev,
 				 sysfs_device_attr_channel);
 	if (err < 0) {
 		pk_error("failed to create sysfs attribute channel: error %d\n",
@@ -666,7 +658,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail;
 	}
 
-	err = device_create_file(&pm->pk->hdev->dev,
+	err = device_create_file(&pm->hdev->dev,
 				sysfs_device_attr_sustain);
 	if (err < 0) {
 		pk_error("failed to create sysfs attribute sustain: error %d\n",
@@ -674,7 +666,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail_attr_sustain;
 	}
 
-	err = device_create_file(&pm->pk->hdev->dev,
+	err = device_create_file(&pm->hdev->dev,
 			 sysfs_device_attr_octave);
 	if (err < 0) {
 		pk_error("failed to create sysfs attribute octave: error %d\n",
@@ -704,11 +696,11 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 
 fail_register:
 	stop_sustain_timers(pm);
-	device_remove_file(&pm->pk->hdev->dev, sysfs_device_attr_octave);
+	device_remove_file(&pm->hdev->dev, sysfs_device_attr_octave);
 fail_attr_octave:
-	device_remove_file(&pm->pk->hdev->dev, sysfs_device_attr_sustain);
+	device_remove_file(&pm->hdev->dev, sysfs_device_attr_sustain);
 fail_attr_sustain:
-	device_remove_file(&pm->pk->hdev->dev, sysfs_device_attr_channel);
+	device_remove_file(&pm->hdev->dev, sysfs_device_attr_channel);
 fail:
 	if (pm->card) {
 		snd_card_free(pm->card);
@@ -722,12 +714,9 @@ static int pcmidi_snd_terminate(struct pcmidi_snd *pm)
 	if (pm->card) {
 		stop_sustain_timers(pm);
 
-		device_remove_file(&pm->pk->hdev->dev,
-			sysfs_device_attr_channel);
-		device_remove_file(&pm->pk->hdev->dev,
-			sysfs_device_attr_sustain);
-		device_remove_file(&pm->pk->hdev->dev,
-			sysfs_device_attr_octave);
+		device_remove_file(&pm->hdev->dev, sysfs_device_attr_channel);
+		device_remove_file(&pm->hdev->dev, sysfs_device_attr_sustain);
+		device_remove_file(&pm->hdev->dev, sysfs_device_attr_octave);
 
 		snd_card_disconnect(pm->card);
 		snd_card_free_when_closed(pm->card);
@@ -757,10 +746,7 @@ static int pk_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	struct pk_device *pk = hid_get_drvdata(hdev);
-	struct pcmidi_snd *pm;
-
-	pm = pk->pm;
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
 	if (HID_UP_MSVENDOR == (usage->hid & HID_USAGE_PAGE) &&
 		1 == pm->ifnum) {
@@ -775,16 +761,16 @@ static int pk_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 	u8 *data, int size)
 {
-	struct pk_device *pk = hid_get_drvdata(hdev);
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 	int ret = 0;
 
-	if (1 == pk->pm->ifnum) {
+	if (1 == pm->ifnum) {
 		if (report->id == data[0])
 			switch (report->id) {
 			case 0x01: /* midi keys (qwerty)*/
 			case 0x03: /* midi keyboard (musical)*/
 			case 0x04: /* extra/midi keys (qwerty)*/
-				ret = pcmidi_handle_report(pk->pm,
+				ret = pcmidi_handle_report(pm,
 						report->id, data, size);
 				break;
 			}
@@ -799,8 +785,7 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct usb_interface *intf;
 	unsigned short ifnum;
 	unsigned long quirks = id->driver_data;
-	struct pk_device *pk;
-	struct pcmidi_snd *pm = NULL;
+	struct pcmidi_snd *pm;
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
@@ -808,26 +793,16 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	intf = to_usb_interface(hdev->dev.parent);
 	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
-	if (pk == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
-		return -ENOMEM;
-	}
-
-	pk->hdev = hdev;
-
 	pm = kzalloc(sizeof(*pm), GFP_KERNEL);
 	if (pm == NULL) {
 		hid_err(hdev, "can't alloc descriptor\n");
-		ret = -ENOMEM;
-		goto err_free_pk;
+		return -ENOMEM;
 	}
 
-	pm->pk = pk;
-	pk->pm = pm;
+	pm->hdev = hdev;
 	pm->ifnum = ifnum;
 
-	hid_set_drvdata(hdev, pk);
+	hid_set_drvdata(hdev, pm);
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -854,26 +829,18 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_stop(hdev);
 err_free:
 	kfree(pm);
-err_free_pk:
-	kfree(pk);
 
 	return ret;
 }
 
 static void pk_remove(struct hid_device *hdev)
 {
-	struct pk_device *pk = hid_get_drvdata(hdev);
-	struct pcmidi_snd *pm;
-
-	pm = pk->pm;
-	if (pm) {
-		pcmidi_snd_terminate(pm);
-		kfree(pm);
-	}
+	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 
+	pcmidi_snd_terminate(pm);
 	hid_hw_stop(hdev);
 
-	kfree(pk);
+	kfree(pm);
 }
 
 static const struct hid_device_id pk_devices[] = {
-- 
2.43.0


