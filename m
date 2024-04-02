Return-Path: <linux-kernel+bounces-127302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC8894966
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728291C242CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682F17BC9;
	Tue,  2 Apr 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="L9GGML5O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4ZqQrS4"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2017C7C;
	Tue,  2 Apr 2024 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024811; cv=none; b=Bl5dBv2A6TMKzg6UqgvIskKrMY1tUQn/CPIDRo12MszwFGfootjKZ9H7jagQ70kQT5u9jhiug7NFQbMf45djoKUA/VBf55gxJ2eBm2OeGPUbumNCSppR20ARFX5iyrLa1MoGNG3a38Q+0onlMZjvNZTTAJ90LIpRx48Aq35hj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024811; c=relaxed/simple;
	bh=DpU+90yzllWC8NY3lXLp9lfHmboCaJNtCEDWV7RIZnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4e29M4Mjw2H2Pkaq7frg6Nuf98MWOJ7/3V1MC5B79UCMZ4R0oBXTZs1r0/RM9JMXYyZsGsoAZLhKsh12ehRb7gDPxx/uS+92BMCJtPHyk36SnPwkIjQHZ4d4acQezDV+hJ41SxA4iHofe+ZcNA6yE7KxTsYGpyPZdi7U7Itljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=L9GGML5O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4ZqQrS4; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 5C5561C000CC;
	Mon,  1 Apr 2024 22:26:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 01 Apr 2024 22:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024807; x=
	1712111207; bh=EJJ/s7hSFzUoPuPOGWvFkDGMhyLn0Akl3eFtGSVwkcU=; b=L
	9GGML5Odgd1DJJCPXJOIwmM9bwWHPF5rciuQefl424MIws360A/rqm/yaSkMRfri
	QezjMzAzo86LbO3Xl1zxywFolnhv09vzCCCUNed9n0vHy/5UvBq/fdkqvO1amExs
	UOoBJB2IEjj2KmWpXV3+Yjmw3tgdA4jUHj0IXakWDGTs7nq3+oizvbK20BX7fBKd
	5Siomc+xxfQ94HCuMcrmYZOqSZI7y/BL6DFL30e2VH46Jdm6wxyhvtCpP9WWeQ/k
	EIqsM41dSjWEJbplkQqBTwxs5Pop0Z5nQhbCvGERFhSmmUQEZFVjvIyHbMIqMxz1
	9VyWRKqMzZYwues14G6pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024807; x=
	1712111207; bh=EJJ/s7hSFzUoPuPOGWvFkDGMhyLn0Akl3eFtGSVwkcU=; b=g
	4ZqQrS47WlPdmwD50wT79tbEBQliHeAB3XgrWbZLH2e9ClqXVy/6XRiXyEv+BqYp
	BZjdznbw5ToxeyiSwZAcr/+Xdmeyy5rnh/MN0pvLFm9bmL/jZPVRFBTsugOKgTQP
	uxO1Eht+PYEVIGA+grK1eAMaXY//J16whGLy+0W3qcIIVcSwhTdd/0bqjRG4oL38
	7Kq7Zf6sEQAI10HyyCILGcsJwYc5nsSYGvBVUu1duEGipvxJv9isqUWM259rTw/+
	JaPoqt3KOqY0NUVvquyTuYYL1EalMz4sBdwy6LTIkbjsAnkZQdHEi1qU6kVPu5Lr
	BjZk0qi33Qnaf+fXkbwFQ==
X-ME-Sender: <xms:52wLZm025OFe6_M___rfmP-2XwqkzzzOwf11bswY3ufPMpnbctj6kg>
    <xme:52wLZpE2gzEZA5DNIq-lP1iBsfvosmbRU4oZ5Fm3HGPcAef_2dwnj1WO_jhPZD9sY
    CnKpEdZ7n86cyXmAXc>
X-ME-Received: <xmr:52wLZu7Z8PpIJR5QFk8KSag7wbDgYI634ISUR6i93ZJ6oOXEpzrHxZO44xIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:52wLZn0KpMxnXQW9Jxmz1VAzdraKOGd7_ZnrtRDVSOfIYtwHemTtGw>
    <xmx:52wLZpGJxNAudiF7n97fAJdcWlTY8vf-0b92olTIn9kgEQxSsvBZTg>
    <xmx:52wLZg912Yf-uhLxwdg9mj5Z_uSiZLe9uPNTqORc8CJCZ4GqdvMQJg>
    <xmx:52wLZuniM5VXBy77utBjX_t2jcmOBU6uIW6h-SvM7TPJKddFY7zDkA>
    <xmx:52wLZu4QMFjT5vAFeglR13ifdupSll-ehBorPbFi5yxymLZoC0qJwvoG>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:44 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 7/9] platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
Date: Tue,  2 Apr 2024 15:26:05 +1300
Message-ID: <20240402022607.34625-8-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402022607.34625-1-luke@ljones.dev>
References: <20240402022607.34625-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous work to allow the MCU to be resumed correctly after sleep
and resume tried to take the shortest possible time. However as work
continues in various other parts of the s2idle subsystems it has shown
that it wasn't entirely reliable.

If the MCU disable/enable call is done correctly the MCU fully removes
its USB endpoints, and this shows as a full USB device reconnection on
resume. When we tried to short this as much as possible sometimes the
MCU doesn't get to complete what it needs to do before going to low-power
and this affected the reconnection.

Through trial it is found that the minimum time required is approx 1200ms
to allow a proper disconnect and disable, and the same amount of time on
resume is required to prevent a rapid disconnect/reconnect happening on
seemingly random occasions. To be safe the time is now 1500ms for msleep.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1743ff1eb0ac..ddf568ef8c5e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -129,7 +129,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4811,6 +4811,7 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
+		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4822,17 +4823,8 @@ static int asus_hotk_resume_early(struct device *device)
 static int asus_hotk_prepare(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
-	int result, err;
 
 	if (asus->ally_mcu_usb_switch) {
-		/* When powersave is enabled it causes many issues with resume of USB hub */
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
-		if (result == 1) {
-			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
-			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
-			if (err || result != 1)
-				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
-		}
 		/* sleep required to ensure USB0 is disabled before sleep continues */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
 			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
-- 
2.44.0


