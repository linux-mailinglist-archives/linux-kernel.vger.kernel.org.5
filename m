Return-Path: <linux-kernel+bounces-29455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0342830E83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C71F263AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24925575;
	Wed, 17 Jan 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cQ0LfDt+"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CA24A18;
	Wed, 17 Jan 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526427; cv=none; b=thxNICw5mu8C18mRMdJ293PHI6426TiCyHKHRo8tuPOIecToWZNRwkhF3/D9rOaADUmKbrTL1Fx/nOo4AO6kyPahftXwZCLJ28yMOnZYctLPzfBFPiMQgwBhsIiTSpx14HsxCqa/ilukE/MLOkQRkk+vXZsmmotlRip7UXmaD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526427; c=relaxed/simple;
	bh=WnqOanwskYGMncvRjdavgmyaWRbgE5RCu2ABf/pnEb0=;
	h=Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=LYDE/fDzWD+f9XTrK0gScIBgs4zWoj9Hah+lTh5lBtAXL0ld5aZ7DcyckULteJ4+pk0xFuiRWk1wVNPMF0tno6K4Tf7MU+/qTEUkwI2nd2GDWOdrFlQu0c7NdT7j5RSkW7CqSQNOp3XA649H3LYypOw8gzF3iNjxtLwmh2L6Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cQ0LfDt+; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C9B30C0000D4;
	Wed, 17 Jan 2024 13:20:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C9B30C0000D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1705526418;
	bh=WnqOanwskYGMncvRjdavgmyaWRbgE5RCu2ABf/pnEb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQ0LfDt+x7bxweTOTelmTJVhnaK7CIxg8IixjTarUfm1l7nr49aR/hpdP9fMWz8if
	 WMnh9AkhBY6Xs9NpFUU6suBcoQrH7q+TKQS2KpEtLea/wDlK9ZBOLyqEAsUkLcs1WM
	 AnRV90ky25czmOoiYHZlmOT2C5q8bPYFsc6Kigi0=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1935518041CAC4;
	Wed, 17 Jan 2024 13:20:17 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] bus: brcmstb_gisb: Added support for 74165 register layout
Date: Wed, 17 Jan 2024 13:20:18 -0800
Message-Id: <20240117212018.1315719-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111231539.783785-3-florian.fainelli@broadcom.com>
References: <20240111231539.783785-1-florian.fainelli@broadcom.com> <20240111231539.783785-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 11 Jan 2024 15:15:39 -0800, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> BCM74165 introduces a new register layout which is different from
> previously taped out chips, match the documented compatible and use the
> appropriate table of register offsets.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian

