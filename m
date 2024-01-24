Return-Path: <linux-kernel+bounces-37238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F2983AD19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EC51F23D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBABA7A71F;
	Wed, 24 Jan 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P7NbJN+z"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8B40C1B;
	Wed, 24 Jan 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109617; cv=none; b=oZ+pc8n94ntIINFSxernQdMxeNOEXEdFT80z9fOCEdDY1AV6+csFCSiT3exv7s81IunBvL6oBgO2vo5IuUemrei0U+3iQ795bK9aF9lNPFHUPr5B28lfd1QcSgEs35VoXK1YkjwmMvzWoz0Gjc3fGN36fO4jm8okJm9D55kaKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109617; c=relaxed/simple;
	bh=zX7eqkGsLS6odL5uF8581JDrJBM5mU7ldiPJDj/CpiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow7ew4FmXYPdZc1MZZDQwKZjK9F541lWXMt7pvwzFF1QO8eSwpA/xjOT0CTUM24dvwGYujfs/ffNX/RqPrvdvGQZG8PR+9y9vfjC2nyNzcfzdtAipBzNmgtEwrmXPB2vHqFJwl4Tw5aBRmsn9V0RjtfCIkigErHBvIf9ohj91YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P7NbJN+z; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O6UAwa025066;
	Wed, 24 Jan 2024 09:20:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=SrSKAtFBOmvPm4U
	4MUjJ2ZI1KavQKTqCbfxnpWUz/oM=; b=P7NbJN+zAv2xj8zxZabnO3tYXyWFS5p
	JP6OZyYfx92NyR1LphcFjt7gXbOMLBCwOg564XwZTE402nt8eQhbXNMbCQlfPBd+
	ErX+X3PMrN+f8FDweyj1X1heS8hdk2JJ6cqG+Y7r8lRVC3bBSycv44hDtvfWWuMy
	ykA8TA6rhUfHbb/VFGOVHr+4GKEc6rXSI7hdC7kyyreULhMIZqUsN/oSzV50A9X6
	FoXsZohci+6TUiZL5QTxpu7k5IUdBIuNEtNBTKyZlOkGQUICaRFhqNDFHYgn+w1M
	eLRSnsgZlGAH+USBbGNLPn6Gv5Pn07C51244yUOvt4SFHybfvZ0ZghQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:20:08 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:20:06 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:20:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B222C820246;
	Wed, 24 Jan 2024 15:20:06 +0000 (UTC)
Date: Wed, 24 Jan 2024 15:20:05 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>, <andy.shevchenko@gmail.com>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/6] mfd: cs42l43: Tidy up header includes
Message-ID: <ZbEqpbwTOlWBHrL2@ediswmail9.ad.cirrus.com>
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
X-Proofpoint-GUID: 2kAoorBE5-OQqpanyrE7qAA0Sjpd1n6f
X-Proofpoint-ORIG-GUID: 2kAoorBE5-OQqpanyrE7qAA0Sjpd1n6f
X-Proofpoint-Spam-Reason: safe

On Wed, Jan 24, 2024 at 03:12:17PM +0000, Charles Keepax wrote:
> Use more forward declarations, move header guards to cover other
> includes, and rely less on including headers through other headers.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Apologies Andy, I forgot to CC you on this series, hopefully you
can pick up off the list, but let me know if you want me to
resend.

Thanks,
Charles

