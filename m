Return-Path: <linux-kernel+bounces-84800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE086ABC6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776481C24422
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E2364B1;
	Wed, 28 Feb 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TXG43PxJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97227364A4;
	Wed, 28 Feb 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114285; cv=none; b=MNISCmB6Cq6TfXr80USY3sq9vkbOh6fYnsYUyPriUYAy8RWrUibEJMAuK6cWrT8yh8FV7No2yT/zAKP+8WrlauJZadQFSMAcHKYOtHXIrMtZW01RKIf3YIlBWHJ35ObsnL9mI35E8zb9XEh42RpttfGjdpcE1ReK8iYqJOOcoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114285; c=relaxed/simple;
	bh=q7uO3PIAUbv5s0zNPk/hs5o0FMrE1BTaxQJaQU7AWy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mz+pwrZY0apY8/g6d0Q6uxO4mcQnxlZ3FqI4FQO+AJVVezN3OQLvtuxzSsYD88Pv6N1CwHjZcRQQpndEnHbuWQAwGZ2B3g+EiB3rWgPhxZ1sACXgcxDIsZLeKtscxIGFS3/p3P9VZ39DB5XBATqoDCxR6U0E8jRIw0ng93D1XUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TXG43PxJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25ADFFF803;
	Wed, 28 Feb 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709114280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zSLYn7rXTUnchKC2ZY6W8KUHuCnCdXr699wv9CBj8ZM=;
	b=TXG43PxJ7e8avkmxqC16QU8f3o/nqVSFbG1YvLqNcuOXIGEtDTOwEGFmvL6SKkCONRk8VJ
	j5XTKcWeBIrwY+eYYZAXgFRBNJzjpscmwrL2ZYHIYbgL6uePdfNF92ey53m/amwdhgdmpM
	FRafWylvIz6pHzJidPhk7TX5r8bpSWsb/IZP5GWxzK8F96T8tV7EY5rPOwSoT2HezIwQtI
	L3yo/gIylrReFlaootHXLJlsEGdDDxqUV0ezyxL7ujFlJ11txYtU9oOi79jkY5NVLqr+Fq
	RtzKcT1cz+VawBIFonDxF6B+jOIwo3aswyGv+CqVd3HoYv9ZzbEez9nKQqbwkA==
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
Subject: [PATCH net-next v2 0/2] doc: sfp-phylink: update the porting guide
Date: Wed, 28 Feb 2024 10:57:52 +0100
Message-ID: <20240228095755.1499577-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This small series updates the Phylink porting guide, mentionning PCS
handling, suported_interfaces and mac_capabilities.

The first patch is related to the dedicated documentation, whil the
second patch fixes a small discrepancy in the phylink code
documentation.

Link to V1: https://lore.kernel.org/netdev/20240220160406.3363002-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (2):
  doc: sfp-phylink: update the porting guide with PCS handling
  net: phylink: clean the pcs_get_state documentation

 Documentation/networking/sfp-phylink.rst | 146 ++++++++++++++++++++---
 include/linux/phylink.h                  |   3 -
 2 files changed, 132 insertions(+), 17 deletions(-)

-- 
2.43.2


