Return-Path: <linux-kernel+bounces-146200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F48A61F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E1D1C20D27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F4210EC;
	Tue, 16 Apr 2024 04:03:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C42D512;
	Tue, 16 Apr 2024 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240187; cv=none; b=cBq/D+wp7xEx+8qr6qd9F5iMdEaGokeQBOFghONsaWmzsQNtzB/XLxzKu7KM/JrKv7agZnKFPCnC9Pdg9THIpjwW1jelhWlMu3amDRdu9WJd1m5lXORa2mVGUmN/1IlvVeWIKepM04KKyhVUTISvJPINI6e2ySubab+1XUQLglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240187; c=relaxed/simple;
	bh=tOJZOL1oQNa5yFnF6zjxSaef37t70hI0cdfYFqAe32s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HyNrraz3BWj6uZA7wOYyQ359KG5pX691CdlxqYpt9HuBmFVET9sX+v5D53x74sd+cQpadSH+YG7UFLQiXH/St6jzBcBIuaJWJ3pA7KL3GDHiqQyI6FEtpObmzh94hsTZbkJbHzlt0+zDSRgDmY8mypwwJ2potnr+2Ux/qQnWs+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04AEC113CE;
	Tue, 16 Apr 2024 04:03:05 +0000 (UTC)
Date: Tue, 16 Apr 2024 00:03:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value
Message-ID: <20240416000303.04670cdf@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


The string SND_SOC_DAPM_DIR_OUT is printed in the snd_soc_dapm_path trace
event instead of its value:

   (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")

User space cannot parse this, as it has no idea what SND_SOC_DAPM_DIR_OUT
is. Use TRACE_DEFINE_ENUM() to convert it to its value:

   (((REC->path_dir) == 1) ? "->" : "<-")

So that user space tools, such as perf and trace-cmd, can parse it
correctly.

Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Fixes: 6e588a0d839b5 ("ASoC: dapm: Consolidate path trace events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/asoc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 4eed9028bb11..517015ef36a8 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,6 +12,8 @@
 #define DAPM_DIRECT "(direct)"
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
+TRACE_DEFINE_ENUM(SND_SOC_DAPM_DIR_OUT);
+
 struct snd_soc_jack;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
-- 
2.43.0


