Return-Path: <linux-kernel+bounces-73303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB085C0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8544C28487C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB376402;
	Tue, 20 Feb 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PjvmA2CQ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224E69E1C;
	Tue, 20 Feb 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445054; cv=none; b=itTHhjGo9ZLpocp21DckrDnMj8tAAOgO8KqRUmbpYDKx8jrw6uIeeFWKLKc8xL8xTJYfq3XCnCEZNpuDpaggKXx/NH/K+FHYHHgI0zfVdZsDeszgD4EIpVasVKH+RMCnUBRvlooKKeoIZdoY73icBFoqQeKRCH/lajxtOX2P0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445054; c=relaxed/simple;
	bh=Z8LxH+9aWo/jLryT3yq7HqAN0fukEaHkp14V5rZAVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUEpB9aZ71f3AKqtvW4fd34W68hlb3ZmXmOv+6GE1wDN8OxlPwx+XEBQwpN9r/6UXIPuNdEFK+E4ycPXny/ieaZDUdyJUtSvQIAAhH3NolcpePI/qBhhvzihXttA5GF9jIcHoa5JLH/fEfnPP12Dn+jS/YhK/g0mg5iRZTTPtIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PjvmA2CQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F63FFF804;
	Tue, 20 Feb 2024 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708445049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRyinCg9Yrt94wADBKsj2h1PRn0oLViha04AuY6wTjQ=;
	b=PjvmA2CQERq7xZlj7IBA846bT9wuWmK9yKdXpU/DJLkNRj5vugyb4VHRzC/tq7zZEJpSG1
	DvDMPkl39TKHPxIA8n76MZ+EtWdQw/CN22KSayW6C6hbCMByRjWe3G9sSwn2FwSgpOsY5Z
	zsVJiUrhI7vr/T9BHeHxya0kTx4jGPtAFI0wASMTwJJOZ+JqpPBbjBse6YhjRuTj0vx47b
	/ej6ZhXTiRvpBl2fO2gNeclChmFCSBcjyJaLJXNwyQlUADHzjquFQ0VAKw1129EUc/bHrj
	Rra3vVYUptXwlq4ZwKlRDcr19jeDvqOl3O6ZR8j12yP416gYnfbpQXpF2vpAHQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next 0/2] doc: sfp-phylink: update the porting guide
Date: Tue, 20 Feb 2024 17:04:02 +0100
Message-ID: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

I'm currently in the process of porting fs_enet to phylink, and I'm
using this occasion to update the porting guide along the way. Let me
know if these changes are clear enough, and if there are any mistakes in
there.

Thanks,

Maxime

Maxime Chevallier (2):
  doc: sfp-phylink: drop the mention to phylink_config->pcs_poll
  doc: sfp-phylink: mention the mac_capabilities and
    supported_interfaces

 Documentation/networking/sfp-phylink.rst | 48 ++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

-- 
2.43.2


