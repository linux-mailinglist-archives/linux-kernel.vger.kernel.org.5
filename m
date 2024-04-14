Return-Path: <linux-kernel+bounces-144027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBB8A4106
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D74D281985
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40920B34;
	Sun, 14 Apr 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="Gz8TYfjE"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F79208A4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080835; cv=none; b=ICpP6IkJ5AqfPyWPYmmhGxiWCzSB5NBr0q4CGXoQxxWRiqy0JCfGz22lNg+3dj7GKJHQjRnPi035adL156K6bAqe51p1Y9UBfSoFzlOIXZjj8Ry6uWqTgRQTzrA9TcSrxyGzIyIl6VPD3fXv/5wfEWQTed10/7kEVMznNc0nIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080835; c=relaxed/simple;
	bh=66B9xW2JnZF+T+ORl+vmwNxP9ZuLdipN2y3NqjssXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+KJnUbxdauB7RMDZyygmx2ez4wiE2TO1NYVjctvYpC6xBCwss/SUqkv6qaUywe44nmZRXUqLbc3A8aKxfD708AOGiPzCZ7fRjSi73ey37D0z4r6oNE1JHwmQfGZ2XvXrNkqOzMkUAdfcqVAgFJw90Awv6fUyoHFYA9hKQaAclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=Gz8TYfjE; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202404140747038c889a3b7225b45e3a
        for <linux-kernel@vger.kernel.org>;
        Sun, 14 Apr 2024 09:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mRTcKk9CAwzkOcmbjmAlIJKdoAVTq0P9oRRdIYZzYdw=;
 b=Gz8TYfjEfurOTWhvYtKCLk18xlnVUejBN5W04nkiza/SyUHBV6y9rUVvs5Ab279BVT5Y4j
 3Z4Z9+I8eg3XPlDoLp/3GpAPJJGtnxmPuHXVb6Lt9m7pAlTu2wjdly7zWfG/6gjINpe0VLMb
 XlfvwUemmwfBr2vtISPg0rpvxXrnQ=;
From: Michael Haener <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 0/1] Add ST33KTPM2XI2C chip to the TPM TIS I2C driver
Date: Sun, 14 Apr 2024 09:44:33 +0200
Message-ID: <20240414074440.23831-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

This patch series adds support for the ST33KTPM2XI2C chip.

Changelog:
v2: removed driver patch

Michael Haener (1):
  dt-bindings: tpm: Add st,st33ktpm2xi2c

 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.44.0


