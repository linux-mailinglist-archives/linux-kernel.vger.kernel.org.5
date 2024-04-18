Return-Path: <linux-kernel+bounces-149882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9858A9757
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B20E286887
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9A15CD43;
	Thu, 18 Apr 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X5shHVWw"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A715AAAD;
	Thu, 18 Apr 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435978; cv=none; b=GVi3Ey9xnETrJ217Skl1Z0NnOrQYdVTr7FdlqrAGUAjcsn4ABhOUJqrv+XtXp9oqRXWi7xjpARW1YMAKtzDi9mUrkQTzIeqGe+i55W70UXMmXtQT21ViWy2CuwHXDnbMoQH2nXei0k4Nis5qaEGyXBysTwf7mszY48qLmCncqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435978; c=relaxed/simple;
	bh=zsM/iB4mGCTl7LmWoqNU7yUQUj/3fGVzRHR12CI27Q8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSNx0QK3jAQI2aNE+3XRtSNj4fHx2azSX9NhcOApR3gx8n9v58ecToOcjbDBdiYTkBfhxTPQ4Fb9+xnbiw4MAaEJ4ooBOGg+ndYiyHYx61fhXPCvhRbY9qYUBxLWF99Y0PUbBCXi6gDyWsuRlxPwKgJYp/wutc2PyunprsEud/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=X5shHVWw; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I5jAL6019878;
	Thu, 18 Apr 2024 05:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=
	PODMain02222019; bh=zsM/iB4mGCTl7LmWoqNU7yUQUj/3fGVzRHR12CI27Q8=; b=
	X5shHVWwAeiughpEBrf7vMHcxLA4+Xrlmf77SahR07OUhgQavXEa/cLUwm7R0uQL
	ZMqJRleqs9E4gSuonsHHAZTC+YjsJkPvCdv1Q7yn/xkFCA/J/xvVw6mVEZktUj+E
	/04Xo8XwcuVfZ2bKAGODywHY1kDL7pEBXQT+yZ7tOgI8NderakALyuBgpQBolhfG
	6FzXxKDBin+B/+v8Tz/MB73Gdr3EyvH4/V8BO+tGKtCWc/7cym14fKYl0kP+7eKH
	g0V/hAssRjKuHeAeyBSbpbfkv+NjjqGfQOcF14Q4GLRBur3/FnX5KDp1SPVxWybH
	cHzc93NeRapiU98LO6Z3zg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhvmhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:26:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:26:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 18 Apr 2024 11:26:07 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2E77282024A;
	Thu, 18 Apr 2024 10:26:07 +0000 (UTC)
Message-ID: <d2cd2a02c05da332ed839eb735c7bbbfea84c400.camel@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Correct name of ACPI property
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date: Thu, 18 Apr 2024 10:26:07 +0000
In-Reply-To: <ZiD0N24MpYX7uj1U@ediswmail9.ad.cirrus.com>
References: <20240418094206.1323489-1-mstrozek@opensource.cirrus.com>
	 <ZiD0N24MpYX7uj1U@ediswmail9.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: dWqPW6ZcixiRIt3gBsfrNG8ADh5TPWjF
X-Proofpoint-GUID: dWqPW6ZcixiRIt3gBsfrNG8ADh5TPWjF
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu czw, 18.04.2024 o=C2=A0godzinie 10=E2=88=B621=E2=80=89+0000, u=
=C5=BCytkownik Charles
Keepax napisa=C5=82:
> On Thu, Apr 18, 2024 at 10:42:06AM +0100, Maciej Strozek wrote:
> > Fixes: 1f05252a3a95 ("Add bridged amplifiers to cs42l43")
>=20
> Sorry actually are you sure this commit ID is right, I don't
> think it matches the one in Mark's tree?

You are right, let me correct that in v2

Regards,
Maciej

