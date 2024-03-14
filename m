Return-Path: <linux-kernel+bounces-102883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44487B7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340CD2844DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80AD4C6B;
	Thu, 14 Mar 2024 06:36:45 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D403D75;
	Thu, 14 Mar 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398205; cv=none; b=RSji9eyl0A+wSm+z/4Hf7ufwHmtYFU+o7yeb8wxqUsRi+FpFtgtVmAQwtx2G61bT0YnYfZcaB5+KHKXSSqDGhPu6OG99OrnVtuIhhgmdcpk/mlLiWwj02ev1IAXMEhN18Jf0cWOpqLNUijfbgJ3Jge301huvGmYVMX7PeqNq994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398205; c=relaxed/simple;
	bh=zX99hBMYW1SD+MxJv3qVxndLjx1Q1X27Qhmz8T2Gi4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnWRLVoRp5CSIQGKH9rY+AZMmwY68SuFN9LvkyCED9puWdqourYA94NH0UvY+hwauZu51vkEsbZgvzINt2zAjWqqoz3hsJ67JKwz9ZP0nWbUzeIh2JtW2ftBz3vFWRD2fajezx7eJW3IObmIrheRHPj5Vh+PfxE2FM7zVvCTVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.236.129])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TwHYp3sdBzyQc;
	Thu, 14 Mar 2024 09:30:22 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Reichel <sre@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] net: dsa: add return value check of genphy_read_status()
Date: Thu, 14 Mar 2024 09:30:08 +0300
Message-Id: <20240314063008.11214-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefiedruddvleenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfeeirdduvdelmeehudejgeekpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
 gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12498327, Updated: 2024-Mar-14 04:41:39 UTC]

Need to check return value of genphy_read_status(),
because higher in the call hierarchy is the
dsa_register_switch() function,
which is used in various drivers.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 33615367f378 ("net: dsa: Support internal phy on 'cpu' port")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 net/dsa/port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index c42dac87671b..c411f30bb5f6 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1765,7 +1765,9 @@ static int dsa_shared_port_fixed_link_register_of(struct dsa_port *dp)
 		mode = PHY_INTERFACE_MODE_NA;
 	phydev->interface = mode;
 
-	genphy_read_status(phydev);
+	err = genphy_read_status(phydev);
+	if (err)
+		return err;
 
 	if (ds->ops->adjust_link)
 		ds->ops->adjust_link(ds, port, phydev);
-- 
2.30.2


