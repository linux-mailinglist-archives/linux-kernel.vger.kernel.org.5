Return-Path: <linux-kernel+bounces-152009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A048AB74D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208C9282940
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6B13D60E;
	Fri, 19 Apr 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YxP7DKR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266D64D;
	Fri, 19 Apr 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713566433; cv=none; b=CxWkgwri7dzckBTvBsSReVCNv3Mw9V3s3sIZhsRml6szgWBABFOuIqjiKqu2SGM0e1f7RcfdeVExmTYHJneFHpUcLbPSDLtzNZxXmqKQ1NA3Or7yeFYFIlOxPBbVoc+z8W7yah4j91dR+oYnxgTW0PI70Gu6Dosc/e/hMEqWLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713566433; c=relaxed/simple;
	bh=BLFVLdvU9NKQVPFJ9lkOxKZX98gDWz8QP8n6TniqGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpoijOHTwKEUkjuvBeWYE9q+xShg9g8OwLbh5guM3iaG0dAcoNt6rOHYTj0GfeGhlyc9rNzgmWzl80PBY7lJ/6c9FHlJksXUIeveCce4RDLF290Wvar1pnSMXcxShZ6iVcO4si1BfCAzQ7owIivQiv4mDEC5YwF4REiddCa1624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YxP7DKR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF56C072AA;
	Fri, 19 Apr 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YxP7DKR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713566429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BvTzOUUvkXW7f/b/MPNNcGab2kVSdnda+T0yRBlxFys=;
	b=YxP7DKR5OM3gt49XEtX/v4vF/fiuNcM3cqqUmG3FL4mu8iwo7wx1B1dScbSxJ7KvWSflZe
	/+8FGWj/F3/UlB96O7c11tJy6dsrQy98LA7uYzvrTJd4kxzXQcRHvHvHTaAihfN1A1vsYO
	OCC0t5L9NR2YDt+4v2A71eXWtiSt/n8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17871b02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 22:40:28 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudanl@amazon.com,
	graf@amazon.com,
	dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org,
	bchalios@amazon.es
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v8 0/3] virt: vmgenid: add devicetree bindings support
Date: Sat, 20 Apr 2024 00:39:57 +0200
Message-ID: <20240419224020.780377-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v7->v8:
- Remove Kconfig depends statement entirely, instead of ACPI||OF.
- Check platform_get_irq() return value against < 0 rather than !0.

This is a cleanup of Sudan's OF vmgenid patches, simplified a bit, but
still with the same intent and mostly unchanged. I'll take this via my
random tree, but Krzysztof, I would appreciate having your ack/review on
it.

Sudan - if I've mangled something here, please let me know. I verified
this still works with ACPI in QEMU, but I don't know about your private
firecracker OF branch, so please pipe up if something is amiss. It's
basically the same thing, though, so I suspect it'll be fine.

Thanks,
Jason

Sudan Landge (3):
  virt: vmgenid: change implementation to use a platform driver
  dt-bindings: rng: Add vmgenid support
  virt: vmgenid: add support for devicetree bindings

 .../bindings/rng/microsoft,vmgenid.yaml       |  49 ++++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   1 -
 drivers/virt/vmgenid.c                        | 150 ++++++++++++++----
 4 files changed, 165 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

-- 
2.44.0


