Return-Path: <linux-kernel+bounces-40815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FE83E666
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4191C21DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A55FEED;
	Fri, 26 Jan 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyL9QUuj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47915EE62;
	Fri, 26 Jan 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310852; cv=none; b=h+WIWPkyKNIh8F4Sl0nleBlIHLmxhlZkQ/0B0y5UZm4lV64a2WN0zAdS3V9X294AYxCzh+VLn81dTtgK8Nt7PNuN8XACo3XtaEHheyWvivc1vOH7JsOpTvKiaRk2lNMEMqmeMgBtPOPMFAiJvZr7BfvQj7aEMKO+QIeW6QKNtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310852; c=relaxed/simple;
	bh=gcaCmv31jC9+dLD+970bShIol4o9Uq98lPUTwZv23Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCVEcRdao61FouO2YflVBkvhs7Qv+Pk1s0zVO9yG37C53iTkBoohgLG6COT+dgKRED9QkFJa9/gVSJ64Uabp0puyg7SpMydQF8AnTWsp7pk0HpICDRC+RvES5PonIJCq0jU8xIrKpAPEEx80Klm8RPfgGnlzy0f8fHvTXkUdVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyL9QUuj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d711d7a940so8358445ad.1;
        Fri, 26 Jan 2024 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310850; x=1706915650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFbx+2eRIKYYfw924Gczlw/lLoyAbfAHs5r+gBC2OQ=;
        b=lyL9QUujNxrLi9UaunMf2pKmy8U+0UUvFUa5ln/NBtl7X+3CGsdlmFn0itJdggZZZY
         cGAGL8ptlySTZhABfHwtQ3DsaQeR2o+109KivhV/PMhpO6dRztNWjACB/RDNHLrQ/gqI
         ruA0PNX6aSN7uZTREClqwBYwh0e2VxQp/ZF23JVJ8J1QO5k2mE+3Yc+XjHRPEavSn7zA
         /Jubir2MHSP0RvmHiIUvbuHxFFzR7IJYNpwPH6kvJDZJ160nHej69Gb+zLSqpO7B/cr6
         o49w18gU0v7eQnXTjqo+opPncKHLyPqxiHggyoS+QRznfKiFb+GaNcXIOHDM0K7Yu6gF
         42pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310850; x=1706915650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFbx+2eRIKYYfw924Gczlw/lLoyAbfAHs5r+gBC2OQ=;
        b=fdt1OclPrUsNBP6VTBVOSqC86YA9wmq/Mk2YUVt+cCJmUxX1PDKzabhziIYlDABZBo
         eYg3FZducMNrmBfOdvOg6Dpcyx+tDjmlEt5Q8qyxIDwHSmBlb4jteKiUCLF3tmpn3X0u
         4oHYzV98lnVBk5LxuvYVfo2k+OblqTmlRODtK65ykCWodmsLVTLSkMXkJHUaRTbn9ZMX
         LK2f8zi6NkhYv8i5UdAus8d/E+U0GHXsaQJaSJd6vl1MNQ1oSoLGGICESVtqVX0n9xct
         0+jD3YolJupN9N5+XozP6cdvqjKVJ0D7B4Bd5CmjuIVAvSMQ8g1oJNglexmKXZOhF/2D
         veSQ==
X-Gm-Message-State: AOJu0YxF7PR/oxS5itdtt4xg3CvBmsPQnBTp4MJ0PWaEC+SOTGbioecz
	IURv3MWbyDy1YploNmhRr9l7Wsr5BVp9EJAm3RAchotnMwC0dI5k
X-Google-Smtp-Source: AGHT+IHACOHBeY51L8GurENnKLLidBUSoUP5U9AqnYdftk3BjgeefzhnxUc1/P25zKyWklE3TkkBaA==
X-Received: by 2002:a17:902:ce83:b0:1d6:f87f:7627 with SMTP id f3-20020a170902ce8300b001d6f87f7627mr672487plg.130.1706310850069;
        Fri, 26 Jan 2024 15:14:10 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id md8-20020a17090b23c800b002933c85eb64sm1659421pjb.53.2024.01.26.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:14:09 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 8/8] net: netconsole: append userdata to fragmented netconsole messages
Date: Fri, 26 Jan 2024 15:13:43 -0800
Message-ID: <20240126231348.281600-9-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regardless of whether the original message body or formatted userdata
exceeds the MAX_PRINT_CHUNK, append userdata to the netconsole message
starting with the first chunk that has available space after writing the
body.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 50 +++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index de668a0794b1..b33ceb110434 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1086,24 +1086,48 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
-	while (offset < body_len) {
+	while (offset < body_len + userdata_len) {
 		int this_header = header_len;
-		int this_chunk;
+		int this_offset = 0;
+		int this_chunk = 0;
 
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
-					 ",ncfrag=%d/%d;", offset, body_len);
-
-		this_chunk = min(body_len - offset,
-				 MAX_PRINT_CHUNK - this_header);
-		if (WARN_ON_ONCE(this_chunk <= 0))
-			return;
-
-		memcpy(buf + this_header, body + offset, this_chunk);
-
-		netpoll_send_udp(&nt->np, buf, this_header + this_chunk);
+					 ",ncfrag=%d/%d;", offset,
+					 body_len + userdata_len);
+
+		/* Not all body data has been written yet */
+		if (offset < body_len) {
+			this_chunk = min(body_len - offset,
+					 MAX_PRINT_CHUNK - this_header);
+			if (WARN_ON_ONCE(this_chunk <= 0))
+				return;
+			memcpy(buf + this_header, body + offset, this_chunk);
+			this_offset += this_chunk;
+		}
+		/* Body is fully written and there is pending userdata to write,
+		 * append userdata in this chunk
+		 */
+		if (offset + this_offset >= body_len &&
+		    offset + this_offset < userdata_len + body_len) {
+			int sent_userdata = (offset + this_offset) - body_len;
+			int preceding_bytes = this_chunk + this_header;
+
+			if (WARN_ON_ONCE(sent_userdata < 0))
+				return;
+
+			this_chunk = min(userdata_len - sent_userdata,
+					 MAX_PRINT_CHUNK - preceding_bytes);
+			if (WARN_ON_ONCE(this_chunk <= 0))
+				return;
+			memcpy(buf + this_header + this_offset,
+			       userdata + sent_userdata,
+			       this_chunk);
+			this_offset += this_chunk;
+		}
 
-		offset += this_chunk;
+		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		offset += this_offset;
 	}
 }
 
-- 
2.43.0


