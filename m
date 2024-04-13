Return-Path: <linux-kernel+bounces-143611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DB8A3B68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6131C20D87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582321CD37;
	Sat, 13 Apr 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="hZ6ltHAa"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1D17C8D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992604; cv=none; b=X2rai6gb4myNtKIPgG8SBPHv/OVkVmTIs5EWaXMmQ4RHggk2yJdIfx4p0ZQp87EjvGjm2Hva4VYczYovTew7RcGgjtkzq1ZqzbOQ2Bqh48ntsupaJNnboqxS/M1+8cRCy+Lt8OqPMhsgvhWMNMufHXuiKuxJAV/8ZxHtpmLnrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992604; c=relaxed/simple;
	bh=z25bTZc9JG5yJA9IHvnqHV8Wk5GB3X3k1vQl9OUyOm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUHid3jhskkmhL72c0Y/rfx2i4oM9DCK0XprvGRN2+UzPCMrYAeUFanUwyCRQkllHBhzWfw1pvWtOjbW8RibjcN6IxrZq6bkR7kRw62BOnMH+dvrjCJnrata5TggRtoTjtCQ27ziyyuEQg2tqqX0Q6YsBovVfnbwhIDAC2sD77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=hZ6ltHAa; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240413071632672e383756a5b0cdb2
        for <linux-kernel@vger.kernel.org>;
        Sat, 13 Apr 2024 09:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=limXHXZhHYSYa+SxW/WS0j+eNSyq1f+RRAMZebUPVWc=;
 b=hZ6ltHAakl+6w1+QqRO49Cadylo4KsxXdByFnhyCRZs6yoKt3C+7EAp/tniEjy9ov+GWm6
 krXVAQnvTXr+vHZsJQnZoHBj89Cu392AjDuLJQobnKTmOFaxaZCWQ1koIqy7ZFudwG+ztn4h
 FBVXi2+TUFCbD0stRtop6GnFlE40Y=;
From: "M. Haener" <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 0/2] Add ST33KTPM2XI2C chip to the TPM TIS I2C driver
Date: Sat, 13 Apr 2024 09:15:05 +0200
Message-ID: <20240413071621.12509-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

From: Michael Haener <michael.haener@siemens.com>

This patch series adds support for the ST33KTPM2XI2C chip.

Michael Haener (2):
  tpm: tis_i2c: Add compatible string st,st33ktpm2xi2c
  dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS binding

 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 drivers/char/tpm/tpm_tis_i2c.c                             | 1 +
 2 files changed, 2 insertions(+)

-- 
2.44.0


