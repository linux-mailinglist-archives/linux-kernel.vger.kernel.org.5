Return-Path: <linux-kernel+bounces-37240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7163D83AD22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309CC28647D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1C47A734;
	Wed, 24 Jan 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="j83oTUWT"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050723C9;
	Wed, 24 Jan 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109666; cv=none; b=JngTORNHCjSl4J04G4rvB3gBxCAPTO8cO/pp17FfQc9VUCJUWL+MqLRkz6CqwfYeU2W4U7kAi6LUnjLLkV/Qf7Qz0KmqMIdFgOg8GiPcc8nd7ymYS6o3OEtJ1RKXuNxlVLU+S99A3x2qVvxCTDcrPovhVz8tmMkPyn4ASyWyB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109666; c=relaxed/simple;
	bh=agPLFUEFM5/Xl+Qkb3//4GKSlO6yApWCN4GTb4cujnA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLoLvYv41h+4Ox6lb9DqSs4iXGjoVvb6M0Otp3BfagCO16AjmOu8xCTaEz23OeECwmn13iX8LnQDlYkBzCaXVmzEKqPNwinsSfWx8IA792ZUlIAtXHBLZoZl9wHs9eYnMtklGqgpDeem1lOeLU0Odtdj52hdESr+lRnTo4VaPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=j83oTUWT; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O6UAwg025066;
	Wed, 24 Jan 2024 09:20:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=vOohKh4Jlq7Gj3T
	yhebrNhjFZ8GR73TN9M0kxe4dS2c=; b=j83oTUWT5M9ESeQZKSOzQ5Y3U82cWCL
	S5SxfcNyFK34eUwgtzVeP59hos64i9+qSsM/otqeD0Cf7UYT+Gf2kj8lGSsFJ5G4
	u3QwIaTL5cnu+HvJwZPN9EHq5qGoJ7M7D6T/lllH0b22TjYRaKNIgA46EP43AiCG
	MtMiE7Ki72BVDpR5GKuJPHhbKRQ2zWIKhTc7AiRt74sFhCjWqGOYrvhtAZ7+DMj4
	4Ne5yC7ldNxdiciQq8xjcpsdMnlYlpSzHhwxSaKxgjWVkTZioBXRlN0WvkjFIcpj
	vspvfpCWN90l3p6g1+3g4cFMNx74/xeoRS8BkGdCVxZgYHl8L0B0e3A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:20:50 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:20:48 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:20:48 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E28AA820246;
	Wed, 24 Jan 2024 15:20:48 +0000 (UTC)
Date: Wed, 24 Jan 2024 15:20:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <lee@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 6/6] spi: cs42l43: Tidy up header includes
Message-ID: <ZbEqz31G+WfTtsZ/@ediswmail9.ad.cirrus.com>
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
 <20240124151222.1448570-6-ckeepax@opensource.cirrus.com>
 <8b8fcdbd-b1c8-4618-acf8-e31b6ab33be7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b8fcdbd-b1c8-4618-acf8-e31b6ab33be7@sirena.org.uk>
X-Proofpoint-GUID: kGDzglf-HN_pl0pxtUvti2jlDz9C3-0p
X-Proofpoint-ORIG-GUID: kGDzglf-HN_pl0pxtUvti2jlDz9C3-0p
X-Proofpoint-Spam-Reason: safe

On Wed, Jan 24, 2024 at 03:16:25PM +0000, Mark Brown wrote:
> On Wed, Jan 24, 2024 at 03:12:22PM +0000, Charles Keepax wrote:
> > Including some missing headers.
> > 
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > The changes to the MFD headers necessitate the inclusion of of.h here to
> > keep things building, hence my including this SPI change in the this MFD
> > series. The rest of the SPI fixups will be sent separately, as they are
> > also not dependent on this change.
> 
> If this is needed to keep things building then presumably it should be
> before or part of whatever change introduces the requirement, otherwise
> we have a bisection issue.  Anyway:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Yup it should will, I forgot to CC Andy too, so this is a good
excuse to resend :-)

Thanks,
Charles

