Return-Path: <linux-kernel+bounces-48903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996E8846307
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB06B28D60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B23F9C6;
	Thu,  1 Feb 2024 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ka36WAfz"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21463CF65
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824543; cv=none; b=G1AORHwgLx5nuo9kobJ1TTosiDCkEhXEZgwS8M0iZMiJiCRSgJydK7lkAdGcVQUUFDJPMIdebNBuyeolyKMruBSnhU/v7CtRNoRA2yxr2wJQpVFoFPUeqVFKO2Ma8z2fmeS+MCeiqyx+6aeq5AbBIDlbyB6D6yDgRNg0albSKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824543; c=relaxed/simple;
	bh=MlRyLyzqikcwM+AiNbxjM/6ncFTI2d+6hAaeIv97k8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORYkrpI6rMpzqzvWMt41KIN8OR+KOVGIdsy7fSR0ZMpbPkTy0OTmFRLiILYuZC0YWA7qgvnKGgWED4kAzvsV8omfFRdDDVzqxJldHEAy5qOa77ko5DqyDDjoLJffvbksaaSYHlt5J/n+YoWRhqbMKAt7GrBG7m7az99CWrd5Dgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ka36WAfz; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 241C6C003408;
	Thu,  1 Feb 2024 13:50:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 241C6C003408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706824211;
	bh=MlRyLyzqikcwM+AiNbxjM/6ncFTI2d+6hAaeIv97k8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ka36WAfzllRbex4soE/D4Zt+yfU1aHBqnZqEadBCBJPY48cHX08dPpUOeImArHgDO
	 6oZ23dtValzcOVi6u/sGE3Vnks2RFNwtE+ZMSHpqtyDafVHRDHSHUVkv+9w6gm/D7x
	 axFSDeCuHytZX8OQlCMvlUxD30LJpK90AkuZR6RM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8103218041CAC4;
	Thu,  1 Feb 2024 13:50:09 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: brcmstb: Add debug UART entry for 74165
Date: Thu,  1 Feb 2024 13:50:10 -0800
Message-Id: <20240201215010.2633163-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129184651.2405485-1-florian.fainelli@broadcom.com>
References: <20240129184651.2405485-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Mon, 29 Jan 2024 10:46:51 -0800, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> BCM74165 uses the same address map as the 7278 family (v7 memory map)
> therefore re-use that constant and shit down the other labels to keep
> numerical ordering.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian

