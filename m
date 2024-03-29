Return-Path: <linux-kernel+bounces-124949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB19891E24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68AB287416
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9DF1A8ACB;
	Fri, 29 Mar 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKasXNMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D416C6A2;
	Fri, 29 Mar 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716494; cv=none; b=su/QPCNBKSvEA/a9FVuQ1ARdUCkEG0IYnDcwRHiV0fwGJCqwWxSmet17CzBtFuw/VylgEPlCZjCEF63Ed1gXvBp5SAZV5cJOcJ48wGbvKXCt08W0mLzD2vUpzun0pKKHh858ys7s9zkKpIi5ZoLf6qbVb8lbC5gBIfTB8wUVWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716494; c=relaxed/simple;
	bh=24ZfbhX4pI7+/FQ2TTtmh8cVzbSFP7TYidogpYLdsoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UctC8gazH6XTuQL5CcgoL3xN690qZO8URyVscwhvckCD/vV4hEazSlLEzLgMijuVvkuBcEDG2TZvM7l1o6JZQynN5alhqZ9VrWi4waVpq6pnIN8RUsMlzQsEoUgDsng0pcJ+Lbsh3GCijwO3Y6kp7hODD3YjnZzl0c2RxiaXEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKasXNMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C8C433F1;
	Fri, 29 Mar 2024 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716494;
	bh=24ZfbhX4pI7+/FQ2TTtmh8cVzbSFP7TYidogpYLdsoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKasXNMvd2fi9ZFinhLwPB+8oMkPSed3RdqKp3YVn09CFXZnm4CKrKarGTHA/5Cvf
	 nXEB/Se5K58G4wj7FazzU3OETHBOw4lI57lFApQtcdmx9tW809VwtLQuAfKBALSunX
	 enYLqbF3F2RmkyWJC5kycvgCPRJpkBwb067VjivVJCcbLbDc1cewYEJiFvpQOT0yXe
	 yInUn+qcq7cyWUYCoR8z8dDAMl9BiSbGp3G3EbGMpqqK1y84fv5YEh4EakG0tQ6ABt
	 Fcd8ue8ihX+OslvLb7edYySAjMe+8w5kZ9+qcswRuxCRyrTU5sT3OmrMwXMzioT3kz
	 +H2/Ij9pEyi5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/34] ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter
Date: Fri, 29 Mar 2024 08:47:14 -0400
Message-ID: <20240329124750.3092394-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 4a486439d2ca85752c46711f373b6ddc107bb35d ]

Miglia Harmony Audio (OXFW970) has a quirk to put the number of
accumulated quadlets in CIP payload into the dbc field of CIP header.

This commit handles the quirk in the packet processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20240218074128.95210-4-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/amdtp-stream.c | 12 ++++++++----
 sound/firewire/amdtp-stream.h |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f8b644cb9157a..8753125683692 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -771,10 +771,14 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	} else {
 		unsigned int dbc_interval;
 
-		if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
-			dbc_interval = s->ctx_data.tx.dbc_interval;
-		else
-			dbc_interval = *data_blocks;
+		if (!(s->flags & CIP_DBC_IS_PAYLOAD_QUADLETS)) {
+			if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
+				dbc_interval = s->ctx_data.tx.dbc_interval;
+			else
+				dbc_interval = *data_blocks;
+		} else {
+			dbc_interval = payload_length / sizeof(__be32);
+		}
 
 		lost = dbc != ((*data_block_counter + dbc_interval) & 0xff);
 	}
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 1f957c946c956..cf9ab347277f2 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -37,6 +37,9 @@
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
  *	For incoming packet, the value in SYT field of CIP is not handled.
+ * @CIP_DBC_IS_PAYLOAD_QUADLETS: Available for incoming packet, and only effective with
+ *	CIP_DBC_IS_END_EVENT flag. The value of dbc field is the number of accumulated quadlets
+ *	in CIP payload, instead of the number of accumulated data blocks.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -51,6 +54,7 @@ enum cip_flags {
 	CIP_NO_HEADER		= 0x100,
 	CIP_UNALIGHED_DBC	= 0x200,
 	CIP_UNAWARE_SYT		= 0x400,
+	CIP_DBC_IS_PAYLOAD_QUADLETS = 0x800,
 };
 
 /**
-- 
2.43.0


