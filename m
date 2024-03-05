Return-Path: <linux-kernel+bounces-92759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B4872599
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151061F26011
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF214F64;
	Tue,  5 Mar 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z903NSju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCD17582;
	Tue,  5 Mar 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659498; cv=none; b=JfCHO1CLAQiKAMd+BOr5honlFPUvTBgTNgmJAsOUBYnUlXTGmxEJcOE68DENZ2HzQhnb7kKJhOypRbMhLSbzLH0HpV/GhmSyDqT7nSp7Zm9zxb9XVprPcRDY2gtBeUBmF7AkhfdG5q6WHkVAixk2rcOtQslsW0fsZn8hGCd90fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659498; c=relaxed/simple;
	bh=0lwIjheUVVinIAmrLyBNdgK66HWaAqekBzSfCyt9IXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpcOet2AJhSn5nUxdxY4pFbLo01bUGNgwb0ejp5So9KVjnnsYTSQ2cYjQXmcubz5PW9MPb7I7Bk3GFat0lOeTD1G8Oo1DnqKmxBncZf5m8dg+1WBT4Ds9IEIkBgK6uGDQWsJ4loW0b9TV5j480iyczy8whu+zJqqgnH07y6gV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z903NSju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CCC433F1;
	Tue,  5 Mar 2024 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709659498;
	bh=0lwIjheUVVinIAmrLyBNdgK66HWaAqekBzSfCyt9IXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z903NSjuRS54CjitvIUAHCtyiTeYD9kpF16xaR6iCL0pBoY7G2j1sdFwYrxw9llc3
	 vAneSCEfELCgq9mk8dxSj/AJSDfxpBXh9Of7zHDuhZgbHAJVxkAPbYfl++P3FK7PFB
	 ep2fLKsOtkra6ll9CtSwoHrap4qqibhT7NhvSAsbvhhSAbPu4D6lEVM+8v8wbrxjeD
	 J+RXr4lNozZ6SEp6K5qX54J4yelJI2ZD5Q14HEPyj3rVU/e1/PvAXhhSsVP7b+Ay2T
	 fI6tLHe/LNMDZMrS3K4cUImbIQPtrpmQ8XFYMUZCyUphwI5obMSq0gHxYRJAXyh1z/
	 gC/rlOZXKIS3Q==
Date: Tue, 5 Mar 2024 11:24:55 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 1/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <eac86b3b9b84859528c346977a8f879188dc61e0.1709658886.git.gustavoars@kernel.org>
References: <cover.1709658886.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1709658886.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There is currently a local structure `u` that is using a flexible
`struct fw_iso_packet` as header for an on-stack array `u8 header[256]`.

struct {
	struct fw_iso_packet packet;
	u8 header[256];
} u;

However, we are deprecating flexible arrays in the middle of another
struct. So, in order to avoid this, we use the `struct_group_tagged()`
helper to separate the flexible array from the rest of the members in
the flexible structure:

struct fw_iso_packet {
        struct_group_tagged(fw_iso_packet_hdr, hdr,
		... the rest of the members
        );
        u32 header[];           /* tx: Top of 1394 isoch. data_block    */
};

With the change described above, we can now declare an object of the
type of the tagged struct, without embedding the flexible array in the
middle of another struct:

struct {
        struct fw_iso_packet_hdr packet;
        u8 header[256];
} u;

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which the flexible-array member can be
accessed, as in this case.

So, with these changes, fix the following warning:

drivers/firewire/core-cdev.c: In function ‘ioctl_queue_iso’:
drivers/firewire/core-cdev.c:1129:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
 1129 |                 struct fw_iso_packet packet;
      |                                      ^~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firewire/core-cdev.c |  9 +++++----
 include/linux/firewire.h     | 16 +++++++++-------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 6274b86eb943..e1f1daa2e667 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1126,9 +1126,11 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 	u32 control;
 	int count;
 	struct {
-		struct fw_iso_packet packet;
+		struct fw_iso_packet_hdr packet;
 		u8 header[256];
 	} u;
+	struct fw_iso_packet *packet =
+			container_of(&u.packet, struct fw_iso_packet, hdr);
 
 	if (ctx == NULL || a->handle != 0)
 		return -EINVAL;
@@ -1192,7 +1194,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 		if (next > end)
 			return -EINVAL;
 		if (copy_from_user
-		    (u.packet.header, p->header, transmit_header_bytes))
+		    (packet->header, p->header, transmit_header_bytes))
 			return -EFAULT;
 		if (u.packet.skip && ctx->type == FW_ISO_CONTEXT_TRANSMIT &&
 		    u.packet.header_length + u.packet.payload_length > 0)
@@ -1200,8 +1202,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 		if (payload + u.packet.payload_length > buffer_end)
 			return -EINVAL;
 
-		if (fw_iso_context_queue(ctx, &u.packet,
-					 &client->buffer, payload))
+		if (fw_iso_context_queue(ctx, packet, &client->buffer, payload))
 			break;
 
 		p = next;
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index dd9f2d765e68..becd3a60d0fb 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -456,13 +456,15 @@ void fw_core_remove_descriptor(struct fw_descriptor *desc);
  * scatter-gather streaming (e.g. assembling video frame automatically).
  */
 struct fw_iso_packet {
-	u16 payload_length;	/* Length of indirect payload		*/
-	u32 interrupt:1;	/* Generate interrupt on this packet	*/
-	u32 skip:1;		/* tx: Set to not send packet at all	*/
-				/* rx: Sync bit, wait for matching sy	*/
-	u32 tag:2;		/* tx: Tag in packet header		*/
-	u32 sy:4;		/* tx: Sy in packet header		*/
-	u32 header_length:8;	/* Length of immediate header		*/
+	struct_group_tagged(fw_iso_packet_hdr, hdr,
+		u16 payload_length;	/* Length of indirect payload		*/
+		u32 interrupt:1;	/* Generate interrupt on this packet	*/
+		u32 skip:1;		/* tx: Set to not send packet at all	*/
+		/* rx: Sync bit, wait for matching sy	*/
+		u32 tag:2;		/* tx: Tag in packet header		*/
+		u32 sy:4;		/* tx: Sy in packet header		*/
+		u32 header_length:8;	/* Length of immediate header		*/
+	);
 	u32 header[];		/* tx: Top of 1394 isoch. data_block	*/
 };
 
-- 
2.34.1


