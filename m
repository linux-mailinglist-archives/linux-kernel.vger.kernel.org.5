Return-Path: <linux-kernel+bounces-29454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527B830E81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BC01F256D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE82562C;
	Wed, 17 Jan 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="oUqDpa7G"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55B1DA4C;
	Wed, 17 Jan 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526408; cv=none; b=j+1bX9K2n9IPr94XEG468dnX79vQRW0kWKQ02TLvHEdRI28fixOPssu+T/sSD+TPC3+yn43TXNpxry8cAzh6hnAZuSZk+xBPV4cTUaurF9/sCYYNPiQveB+cDrR8hD05u3ypgenYE7HfJA3OIJvuES56y1HPPdqO5aglxbrRIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526408; c=relaxed/simple;
	bh=CULms6Y3rOAgl8603S8sqrFefqGe5149zhf0yikEoFw=;
	h=Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=OeGJm/whknwekh1bRqL0WecmNllV3pj/TXXzaDVgKeVpGeZw7ure6v9XMv1kdL566W2JT3PlJc22Zs+phmp+xrgaiwZHR2L9eV64gsw9RSSAteQfQcPQbC5KtSLuBMUL0XL0LVKHX7ZMRNp0fYr1y8I9pEik3hFclZZhvdArCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=oUqDpa7G; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A088FC00709B;
	Wed, 17 Jan 2024 13:20:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A088FC00709B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1705526406;
	bh=CULms6Y3rOAgl8603S8sqrFefqGe5149zhf0yikEoFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUqDpa7GtTb5UzifsuzEeND9OLZ4pMprn5ie9oxpTSv+OhcifNmYfq6gsf1bkwSfL
	 eeBGgqQi7dI/s+TSM72YcMtAPnprCp8wekBExVFKC2eWK+IF0N55uwn8A7Yk2VfA9L
	 vXIxsaROXFgMRK5PG6+aBpFVBlslRwkRiRS6BdGM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2AB8918041CAC4;
	Wed, 17 Jan 2024 13:20:05 -0800 (PST)
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
Subject: Re: [PATCH 1/2] dt-bindings: bus: Document Broadcom GISB arbiter 74165 compatible
Date: Wed, 17 Jan 2024 13:20:06 -0800
Message-Id: <20240117212006.1315624-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111231539.783785-2-florian.fainelli@broadcom.com>
References: <20240111231539.783785-1-florian.fainelli@broadcom.com> <20240111231539.783785-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 11 Jan 2024 15:15:38 -0800, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> The 74165 chip introduces a new layout for the GISB arbiter which is not
> identical to previous chips, document the new compatible that we are
> going to key off.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian

