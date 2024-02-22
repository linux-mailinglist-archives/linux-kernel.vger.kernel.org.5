Return-Path: <linux-kernel+bounces-76729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA285FBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADC21C23C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81901487F9;
	Thu, 22 Feb 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VIpnetJY"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2812D773;
	Thu, 22 Feb 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613733; cv=none; b=Z/37PTT2L6shxbpCYtyMhALS+qHwqpEO2XBC6r5d++bNd3srpkpukMyMqjDF7rnUme2JChgZ9wnvBaoHS7l8A5Kd8yc6T6wcWmJW+q8nbEU0CmS5y5canj5GV2ZzFT10TYdxOpjCgzkDLTzMgSC7S+c4wfGLLb9xrTx6AGmXDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613733; c=relaxed/simple;
	bh=UqPQe47cxPeMnp1/tmUMKaP3xffJYUbRfKDIjii29m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R93E1W/H7AgGC77QBf/qOpB4PdIHpWj01rDHLyE/GMQ7TchhMZCFi+O+uRXi8eJzbs8uWF2ntHwThS1dZ3ZdMSUZGO6Aiu248UxYLJDLcU13hijL998T7wV07pmHOq8bOEdEubdWhOthOwQbd3PGxZp1VQsFfKJjeE0F3qvl9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VIpnetJY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iX6QxosVulzWPXQAoKr0Ar24MQe9V4D+gJ1RxluBhso=; b=VIpnetJYFuIACkjr9kzicNuorF
	vBTRSCTnKoi/9YCWFb0rB8K/YDMaofTD2QwaUF0nMLs6eM2CXc5UQw4yxesthIFC7MyjLDJK4FXgz
	lquWjLfHocGgjQcwqrPYwKHaejuucDtNrjI1G9uqGULzt0epd7ip4p1rgwcTum9a/PRA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdAUA-008S24-RI; Thu, 22 Feb 2024 15:55:42 +0100
Date: Thu, 22 Feb 2024 15:55:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"sre@kernel.org" <sre@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Message-ID: <3344f3ab-8fba-4013-bc6a-8ec0246964b8@lunn.ch>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
 <f8e3a66f-20a3-4819-ab1b-d0f163a2e95f@lunn.ch>
 <80dc4e2e0c7e0fc6f224e704b8594c0f12d0afe9.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80dc4e2e0c7e0fc6f224e704b8594c0f12d0afe9.camel@siemens.com>

> Yes, the code is platform-independent now and can be re-used for deployments
> which meant to be "always on".

You need to be careful with the meaning of "always on". It is always
on in that the hardware does not have any PMICs. It is impossible to
turn the power off. This is a poweroff driver, and it powers the
hardware off by dropping into the bootloader which then spins.

> One could actually even use it with off-the-shelf x86 hardware.

Is there off the shelf x86 which does not support turning the power
off? I'm not familiar with x86 that much, but it seems to be a feature
that has existed since the first IBM PC in 1980.

     Andrew

