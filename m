Return-Path: <linux-kernel+bounces-118275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE888B728
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEBEB23113
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE084E1A2;
	Tue, 26 Mar 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEseGsx9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8FF1F16B;
	Tue, 26 Mar 2024 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418377; cv=none; b=aZ9GhH8vWX7ys1CJK3jE1bOYsHhU2cdGo/zIR2NcfQ5QlL68nNIidOdoqIqLLEUmZV4Y/srl1R7UMCnlgsohzk2tkQ0gbXAuEQB4G4Mx9S7zZrAgGD5URkn4Fld9RRs2Kd9RqxsRgpKqalGWbcYed2/ZmtO4NrocnYX+Gzz8XiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418377; c=relaxed/simple;
	bh=godkSQKzA+faGIiVFZsDHyhNsvM15bnkQ1YACwtY2GU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sNBdJ/yzHfqykH4vU9fJpQnVlK0CL25tIedf8QxVoUw7ZfFrIm4B9quTVUO1wpZEhIVF5jSBjM7pFweaKFmlWfisJkPOB7MdVvW9OkB7LICExOJAeC336M6NAjmdj87hvR/LzCB6fOa0tvEbhVz/W+jvvl/+azxzmGzYZ9Gnolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEseGsx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E54C433C7;
	Tue, 26 Mar 2024 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418376;
	bh=godkSQKzA+faGIiVFZsDHyhNsvM15bnkQ1YACwtY2GU=;
	h=Date:From:To:Cc:Subject:From;
	b=vEseGsx9VChXF6uoxfB81/TXxABM0Tm8P30hdOtWQH6VzHSy3gSeFMON0IL7wc44r
	 ZRdhiHS5jriNrOHhmeYJDesXljZs1Rrn17t06sM8kZvEGFgUd6iWyZjnQzoWwYImcy
	 +DzsiGlhCkliNR+Xr9b0nQtSs9UJ9rMaf051oIcoINiPQOqLGDeKHNcKKl71ue4J0p
	 j151q4LQNuT7XvYsSEtS0ohKksohJmPWYnKDp0sKNjrsuUE/t9xFzGQdoH/F6UMaYo
	 +XiTX3QfRWcnP5/9rfSGKmaSBpBdtsrEY2cyPSy5VW+hJUtfn3juyvxwfaqz5wWCE2
	 t8DSj/HZB4uwQ==
Date: Mon, 25 Mar 2024 19:59:34 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] ALSA: firewire-lib: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <ZgIsBqoMb7p3fMDr@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_FLEX()` helper for an on-stack definition of a
flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
sound/firewire/amdtp-stream.c:1184:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use DEFINE_FLEX() helper instead of a new tagged struct.

v1:
 - Link: https://lore.kernel.org/linux-hardening/d3a764eb76909b16b8a22d9ff530e5edf0e59e6b.1709658886.git.gustavoars@kernel.org/

 sound/firewire/amdtp-stream.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c9f153f85ae6..d35d0a420ee0 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1180,13 +1180,11 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
 
 	for (i = 0; i < packets; ++i) {
-		struct {
-			struct fw_iso_packet params;
-			__be32 header[CIP_HEADER_QUADLETS];
-		} template = { {0}, {0} };
+		DEFINE_FLEX(struct fw_iso_packet, template, header,
+			    header_length, CIP_HEADER_QUADLETS);
 		bool sched_irq = false;
 
-		build_it_pkt_header(s, desc->cycle, &template.params, pkt_header_length,
+		build_it_pkt_header(s, desc->cycle, template, pkt_header_length,
 				    desc->data_blocks, desc->data_block_counter,
 				    desc->syt, i, curr_cycle_time);
 
@@ -1198,7 +1196,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 			}
 		}
 
-		if (queue_out_packet(s, &template.params, sched_irq) < 0) {
+		if (queue_out_packet(s, template, sched_irq) < 0) {
 			cancel_stream(s);
 			return;
 		}
-- 
2.34.1


