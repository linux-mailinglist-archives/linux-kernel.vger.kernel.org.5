Return-Path: <linux-kernel+bounces-81179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA142867317
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6738BB33279
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E41CF8F;
	Mon, 26 Feb 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W0KmmBG5"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05181CF92;
	Mon, 26 Feb 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944200; cv=none; b=f4TpIyh2KS8UKAHJsBfP68ePjUCHA+DVhssJfR6/KiAz7dWMbN3ubR01T2TGT7rl1ovhFXCyoIkRCS9KjD/u9ISxlQd4W5+K1yFsKdRGltB+r1VYbkGQ2sJkVYCPbaBe6u98V4hnP7vUrntjzjhmjnzAhaJR3e2LoxE3gnh6Ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944200; c=relaxed/simple;
	bh=aUcVDM1+6ARSzZRquw7Ik0hUINROv/efcpHajUakwjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpSJH+19x/NgE7OtHgX9ZR7KqW3HXPa+8z9aLLxH9gDn2YmQu6bu8SwkCAjPiyveGt7JGgWikjTqw7iMmzmZsTDFCdB1vBKmFmuTQCMKBnZ7CAYEDUa5BaAlzOzoNQceKlGTSl7rLNwmWrMPaSeFHewECuMXQYorgB4Qe4gRzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W0KmmBG5; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDC16FF824;
	Mon, 26 Feb 2024 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21jxhojpGuLyAIprsmsZyKfJVscT4QidpkL5l1YrKGk=;
	b=W0KmmBG5feEiVPtqgBp5uHiLTZEoe5HmuoblznMIabvdxsixyTRNUXFKaD5PvQkoZGGuPO
	JqJ9/2E3PvyCq0Qx4bSdWOCQ9tbJibgvAdirLuvt80zOGIZixx5xDjkFDDF4UUTHvsgUxA
	FUemVTgay0icE9nMnMasLZ4Uc5d1He/RbThLQf7XMx2Mc9K3r1Z8VW9Zs21y+eY2g/Oftq
	VHPUZ7RtooOvjAvgVJDDuxXfFO5DM8xnT85haWDtIeE9c7VzaqSKFJPTmkyHD37NU9sxy7
	E74XPFs8o4e7KlJ5RLG9Z74EimKbgHihWLE+FXA/GbuvjYHBkZwjSwq6ISPFgg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fbdev@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Lee Jones <lee@kernel.org>,
	Andy Lowe <alowe@mvista.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: [PATCH 2/2] mtd: Remove support for Carillo Ranch driver
Date: Mon, 26 Feb 2024 11:43:12 +0100
Message-Id: <20240226104312.488935-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208224703.1603264-2-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'77bf032528393d2dc9430b3cea1fee8d0762a86f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-12-08 at 22:47:03 UTC, "Matthew Wilcox (Oracle)" wrote:
> As far as anybody can tell, this product never shipped.  If it did,
> it shipped in 2007 and nobody has access to one any more.  Remove the
> mtd NOR driver.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

