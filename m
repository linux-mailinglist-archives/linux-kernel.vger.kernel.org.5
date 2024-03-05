Return-Path: <linux-kernel+bounces-92760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B36A87259A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FAB219D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEE16427;
	Tue,  5 Mar 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGIoI2Rq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00714AA3;
	Tue,  5 Mar 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659535; cv=none; b=fyS5zioiC+Yw9UGBABaY8Kx+NUreRcX4ChU+89diz9HOkJgffo2ocJcnRJEtDufclBphqEhXW+xV5AK6xUOckr04j0jJiyU313/fkqDQZBto6X24f2EBuZpaSFNKAU9d9rmEZEjXVoL6tVQDXSHMWlwYEKVfJYT2Hwg9HN9GDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659535; c=relaxed/simple;
	bh=4nFC5omIFOjOAJ+cP/UoTfF1yurBWzlnntNqzpar1uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfBtgAV6H+rNMgDeAlAdUi8CX/rDNANU2Pgg1V4p3FCfL2+D929f4JWlP4nfNIWm/n6NlndLMSR4I/eY6wD1X9IldsPjqb0IszrRt4jsVrVZY27kzd4YSj88BM1z4UbXm6zmUfjxq5tOpuqKHB3i5nBL4BOaQr+7YxU8kD/5g5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGIoI2Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE95C433C7;
	Tue,  5 Mar 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709659535;
	bh=4nFC5omIFOjOAJ+cP/UoTfF1yurBWzlnntNqzpar1uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGIoI2RqSSD+o5WgK9vgZYqgif+hg8huqzeRQfiT4srghDdJmIeoqQSII8KF0NwNc
	 WhTFl3lISg2N3BXnnD8honFCDlkWkCLPzATIHWdliP3x3xjDnxmO6KuHzM2zL5APwC
	 sAiyhqYbkWpDmbBP1JA/FAzosdQDSChqnfX/LBUGWTz9WUX/TEx3zPIzORcgYSm99b
	 xYlQr6Z0yT4rAAWNEdQHP02sm4tNCDMnTGNARDBIrNaLW3sU3t2zXk1dvhGbcqpg0n
	 2F/sl6ixgTHrDNsicoFbpZ7owAlaGBnYy+P+Se9N6NqcNkd121JRUA5eDQIObyb65h
	 wno0/gZxqkbdw==
Date: Tue, 5 Mar 2024 11:25:32 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 2/2][next] ALSA: firewire-lib: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <d3a764eb76909b16b8a22d9ff530e5edf0e59e6b.1709658886.git.gustavoars@kernel.org>
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

There is currently a local structure `template` that is using a flexible
`struct fw_iso_packet` as a header for an on-stack array
`__be32 header[CIP_HEADER_QUADLETS];`.

struct {
	struct fw_iso_packet params;
	__be32 header[CIP_HEADER_QUADLETS];
} template = { {0}, {0} };

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
	struct fw_iso_packet_hdr params;
	__be32 header[CIP_HEADER_QUADLETS];
} template = { {0}, {0} };

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure.

So, with these changes, fix the following warning:

sound/firewire/amdtp-stream.c: In function ‘process_rx_packets’:
sound/firewire/amdtp-stream.c:1184:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
 1184 |                         struct fw_iso_packet params;
      |

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/firewire/amdtp-stream.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c9f153f85ae6..7ba1cd64d7f1 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1181,12 +1181,14 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 
 	for (i = 0; i < packets; ++i) {
 		struct {
-			struct fw_iso_packet params;
+			struct fw_iso_packet_hdr params;
 			__be32 header[CIP_HEADER_QUADLETS];
 		} template = { {0}, {0} };
+		struct fw_iso_packet *params =
+			container_of(&template.params, struct fw_iso_packet, hdr);
 		bool sched_irq = false;
 
-		build_it_pkt_header(s, desc->cycle, &template.params, pkt_header_length,
+		build_it_pkt_header(s, desc->cycle, params, pkt_header_length,
 				    desc->data_blocks, desc->data_block_counter,
 				    desc->syt, i, curr_cycle_time);
 
@@ -1198,7 +1200,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 			}
 		}
 
-		if (queue_out_packet(s, &template.params, sched_irq) < 0) {
+		if (queue_out_packet(s, params, sched_irq) < 0) {
 			cancel_stream(s);
 			return;
 		}
-- 
2.34.1


