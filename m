Return-Path: <linux-kernel+bounces-56578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0D884CBE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2950328F797
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591776C9F;
	Wed,  7 Feb 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e966wrx4"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A6199B4;
	Wed,  7 Feb 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313549; cv=none; b=ahVsVuphBKLgIImwTg5ZQmD6xayqqJzMj4vurAYdlDe4DI6jmted+iUs8dbPnAWjn4QXbtwGYrydsaYJXMOTuEQEyUp5hYa6UNwlYqnj8441/kWW24rmzdnEM6D110Ewq6tjz8i99O2ul1x8XEKlhtHmv7VHHLDTU4bRfGdd39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313549; c=relaxed/simple;
	bh=tS/prRl5t8R43hQLzqGPVVnj4kD+14hA2T/50X3qjsQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Am4DzZ9qFBPYWMGqXSTeSOpDTjkyPzBFvnJLK9MvMpaGXVGQbg1z5NQpiDEnt5Ni45rppnkVCS2gYc7p65PNFXFthtPvMsFDAf1+IcysrwNW8hdLiypZqhxzyVWgtzR0ns540/yrR1WqX+Z0qBZYBq2gUSVYUGUp+sz90jEZMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e966wrx4; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417DjeO4036011;
	Wed, 7 Feb 2024 07:45:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707313540;
	bh=tS/prRl5t8R43hQLzqGPVVnj4kD+14hA2T/50X3qjsQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=e966wrx44vDMXmY+4rZi77AG7bLxdNoH8TPWGx+DBy3vAsofgMvPp8YOsPmg2Hyyf
	 XxuUAsGxW5eiW9NxJiTjbmD/tKkO2rhJpqCUlOb8pkIKJYfBVEu5CnPruAjh2n11BN
	 GmcyR7l49BCzKgSu0QIuGiniMCRlE4XpUF5Utf/0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417Djeql016507
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 07:45:40 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 07:45:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 07:45:39 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417Djd9Y026046;
	Wed, 7 Feb 2024 07:45:39 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <vigneshr@ti.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240207125410.r2q3jcplvif7dvt2@tumbling>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
Date: Wed, 7 Feb 2024 19:15:38 +0530
Message-ID: <87il30xu9p.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Nishanth Menon <nm@ti.com> writes:

>
> A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
> change just above till I saw that you are pre-incrementing
> clk_id - Is there a harm in leaving the original clk_id increment logic
> alone (it was much simpler to read up)?
>
Personlly, I think this is simpler as this keeps everything related to
parents inside while loop and increment only at one place.

The other logic will have increment inside condition and also at 2 other
places.

Let's Udit take a call.

Kamlesh

