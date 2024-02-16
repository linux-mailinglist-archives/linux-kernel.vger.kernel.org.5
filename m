Return-Path: <linux-kernel+bounces-69244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56442858627
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885EC1C21C01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821AF137C55;
	Fri, 16 Feb 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSKUoWaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E41369B4;
	Fri, 16 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111679; cv=none; b=KEXWLBGcIgOBv7BLdKwuIgozaQkvHO9PgdddlHD81zNBzVRczctbjnVbPXSNub6JrZDdlkmGUcg2jBokm+dsl3weoqGkLr2JNFGwixR4GlYYYN2l1qaEDtbH1yec7pbMU2V7NQe3UlbxljysE7jsBLvM+q02TZj0yWhvCa3AQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111679; c=relaxed/simple;
	bh=RQsL18uJ4AP9VuasXYeoSPuHa2JIzAuKp8EP2goIoE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g8ifNsgUVUTIzpRHWO25+YXfAbhxzv7yUVSqM1QbBvOh65jQm6HrbYBgscImJLN58u26kEjc0/pKJ1+veNyGUgFucl5J/HDDDAhiDDPle/xC5KDZVzLcGnNti7uxRwrvqfgE8EA2gmbJumuo4vS3d9PqqVXpSINKxlJ0sq3r/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSKUoWaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F3C433F1;
	Fri, 16 Feb 2024 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708111679;
	bh=RQsL18uJ4AP9VuasXYeoSPuHa2JIzAuKp8EP2goIoE0=;
	h=Date:From:To:Cc:Subject:From;
	b=fSKUoWaDgkqN32vCFJgZgd1Uv+x9ET8jzDE+DbDfrOf6gppkiraJqnfgaXr8OVA+G
	 3p0n8kaJngJidrg9OuNAbj4Og9pguNB0NcjVvoMA9GwGo/seNBEztBrhsXtQ3TpfsO
	 W4++v+wiAYMK50a+c5Mi5ssh3Cvfcig75BTHHz4lKhoYKO+ksshfTheA/wAeWwFMQW
	 lzoBQ3nXthaSq9S5DU+qK1AWL/66QJ8JLC1KLQvJms3a3Bf0JEtbPGSm35RK/LzupH
	 0MvOlHctGkyNCyM5/TpCsWoWscqPwNVTIN2gSMOmolib/QS2gLygIdPOUzSqH5Pt3E
	 IXANjOCWtTktA==
Date: Fri, 16 Feb 2024 13:27:56 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: brcmfmac: fweh: Fix boot crash on Raspberry Pi 4
Message-ID: <Zc+3PFCUvLoVlpg8@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix boot crash on Raspberry Pi by moving the update to `event->datalen`
before data is copied into flexible-array member `data` via `memcpy()`.

Flexible-array member `data` was annotated with `__counted_by(datalen)`
in commit 62d19b358088 ("wifi: brcmfmac: fweh: Add __counted_by for
struct brcmf_fweh_queue_item and use struct_size()"). The intention of
this is to gain visibility into the size of `data` at run-time through
its _counter_ (in this case `datalen`), and with this have its accesses
bounds-checked at run-time via CONFIG_FORTIFY_SOURCE and
CONFIG_UBSAN_BOUNDS.

To effectively accomplish the above, we shall update the counter
(`datalen`), before the first access to the flexible array (`data`),
which was also done in the mentioned commit.

However, commit edec42821911 ("wifi: brcmfmac: allow per-vendor event
handling") inadvertently caused a buffer overflow, detected by
FORTIFY_SOURCE. It moved the `event->datalen = datalen;` update to after
the first `data` access, at which point `event->datalen` was not yet
updated from zero (after calling `kzalloc()`), leading to the overflow
issue.

This fix repositions the `event->datalen = datalen;` update before
accessing `data`, restoring the intended buffer overflow protection. :)

Fixes: edec42821911 ("wifi: brcmfmac: allow per-vendor event handling")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://gist.github.com/nathanchance/e22f681f3bfc467f15cdf6605021aaa6
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index 0774f6c59226..f0b6a7607f16 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -497,12 +497,12 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 		return;
 
 	event->code = fwevt_idx;
+	event->datalen = datalen;
 	event->ifidx = event_packet->msg.ifidx;
 
 	/* use memcpy to get aligned event message */
 	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
 	memcpy(event->data, data, datalen);
-	event->datalen = datalen;
 	memcpy(event->ifaddr, event_packet->eth.h_dest, ETH_ALEN);
 
 	brcmf_fweh_queue_event(fweh, event);
-- 
2.34.1


