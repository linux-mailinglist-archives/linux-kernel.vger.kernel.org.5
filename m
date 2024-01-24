Return-Path: <linux-kernel+bounces-36506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB383A1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE1B1C23BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE59F9D1;
	Wed, 24 Jan 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UNHnqT0P"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53486F517;
	Wed, 24 Jan 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077276; cv=none; b=tlNBlniOWq8qGACGNUM8+LR6eDdl8EAU/dntFXq9AZs5acnQVe4vmtIQpMjdRwf9QFPhIicOCVzmwamrs1+IjBXelqXoyHO+mXbEtU1xD8DqjGXXBWzvCJBd8N0yl+szYYtSJjm18GH0cLBzwO+D+AMT6+LEmXArZP8t/VKTyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077276; c=relaxed/simple;
	bh=+crDcs1U3dpFBqXCD5S9FqWqMOENUd/dd/uDv5z4acg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stAHZGkVKfGa3txDKHvvMLf6a5vXx5o1jYTs+Mb5KSR4hyKXfByazATlwYi+939a3cim3hLBLXKN+sw8h/+f1nZgindvyd4+GwJnfzQdc1kyfcQDOGoTIvSYYYpowskjTUOsN+zQ9rubYum2rpqcpTQogtRWH+UtEHszQ5qBtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UNHnqT0P; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6LCQp032241;
	Wed, 24 Jan 2024 00:21:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706077272;
	bh=CeHzPI2FEdLrQIvB+JAPDZ1b5+tc/R6noqdrg+0xVnM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UNHnqT0P0aNT8MSzRxavj2sncsDYNO+Ebeyz0Vydueuar+vZp6lyOgce5BMAKhB3E
	 qZRSPjur3mJVG0vBBgVaqwx/7MXkSipSPpmcHtBjzeC+UyB3jfBzW3OCMA6SsKZPWz
	 BW0+nG1skSv3HIONFcdjVs9x59XqQdSCeXZR1xDM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6LCRk040697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 00:21:12 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:21:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:21:11 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6LAnK057454;
	Wed, 24 Jan 2024 00:21:11 -0600
Date: Wed, 24 Jan 2024 11:51:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Jonathan Corbet <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: index: Minor re-arrangement and
 improvements
Message-ID: <20240124062110.zxhodh2vorh3y7jp@dhruva>
References: <20240104073317.19709-1-d-gole@ti.com>
 <87bk9bk9b4.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87bk9bk9b4.fsf@meer.lwn.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jan 23, 2024 at 14:51:27 -0700, Jonathan Corbet wrote:
> Dhruva Gole <d-gole@ti.com> writes:
> 
> > * It seems odd that a develper is forced to look at the licensing rules
> >   even before they get to the doc or coding guide.
> >   This belongs under the "Working with the development community" / "All
> >   development docs" page where it does reside even today.
> > * Rearrange the section for Internal API manuals to go lower because
> >   generally one would want to look at the tools and processes and admin
> >   guide pages first and then move onto something deeper like the API
> >   manuals.
> > * Reword the Dev tools section and title to something a bit more suitable.
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> As a general rule, multiple items in the changelog like this suggest
> that you need to break a patch up.

I understand, can break this patch up if required.

> 
> In this case, though, I guess I don't see the reason why we would want
> to churn this page this way.  The ordering of the items on the front
> page was thought through and discussed the last time we did this; why
> should we revisit it now?

The changes from "docs: Rewrite the front page[0]" are indeed great
however I saw a little more scope for improvement and thus decided to patch

Let me know how you think we should proceed.

[0] https://lore.kernel.org/r/20220927160559.97154-3-corbet@lwn.net

> 
> Thanks,
> 
> jon

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

