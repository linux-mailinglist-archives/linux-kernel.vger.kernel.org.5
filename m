Return-Path: <linux-kernel+bounces-105861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBF87E5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D32814A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074602C1AD;
	Mon, 18 Mar 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GjOj/aJU"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8326AF7;
	Mon, 18 Mar 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753846; cv=none; b=uqaa62tFGFky0gfBj86q/3Znh2xfh4XNZvQf1sljlMTBdGzQo18SYSqDwGaDL9ORv+NFsfDIz4LcCmHUMJkI1RaXLhzmC0I4nm8Ma7g4ERmPlytNF+RniPpbogqjSjHPrQEmjra+Dz/ieDykz0jcBaPpG9n6bSE5TLoR8OsKZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753846; c=relaxed/simple;
	bh=DpVVUBuvLHpQCKgKSJ/r5ujars6qANboe0uw/ZA8xpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMSar+JI8OAB9tZkE4jWyYRP7QtwKdqv4P2DU+dD7rRGvFer+8e9WM6l1y+oJuSogocheJllm2pSg9UF+8fg1CmdWToBiKzz/buxhheHVWbNztdTmaztLQQdRTAE2Eoc8rRaNtKK9+9yh1+xYc6E4r77g8m0Ioo3kSYsl54guF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GjOj/aJU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I90EeJ019800;
	Mon, 18 Mar 2024 04:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=LpFO4w9gXdXIdRz
	3lp4nFmm9huDm3XdMOvGss5eCmI4=; b=GjOj/aJUactSeGm371ocin1DUdF65l+
	Q2Tb8OJhGmdUdw2tuCT/907rZxuOt0u1EVhit4uy+Lz10M81zCt89bRM/dDHH/Q5
	6gfJVAchwPB4SxN583h+dPwRyAOkUoJnZdRK4g4QrVGhlYqfb4P2XQ78PxcKsV5X
	4ZYGzciP4JxkSh9oEFXM5Lku0Jq7Wg+J1COKKON85Jj+qHKNdghQYQIjJOb7+QzL
	7KkEWe8Fya6vVWSz/tUew3uF6MM7DvtszrJ+UktAwWij4uOeKLsqT2ZiFJThm1xv
	aaghj3DTkzZMt7qGK44fi1ux8PR7YRkjz+b7kod+BnyIRiLGiHSZhiA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ww7uj1uxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 04:23:48 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Mar
 2024 09:23:47 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 18 Mar 2024 09:23:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id F16C3820244;
	Mon, 18 Mar 2024 09:23:46 +0000 (UTC)
Date: Mon, 18 Mar 2024 09:23:45 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kartik Agarwala <agarwala.kartik@gmail.com>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8776: Convert to dtschema
Message-ID: <ZfgIIT4wObY+TlZ5@ediswmail9.ad.cirrus.com>
References: <20240317200201.119233-1-agarwala.kartik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240317200201.119233-1-agarwala.kartik@gmail.com>
X-Proofpoint-ORIG-GUID: WRt0zsDs5d2poBW6Pz6vUrdhezhFBfd6
X-Proofpoint-GUID: WRt0zsDs5d2poBW6Pz6vUrdhezhFBfd6
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 18, 2024 at 01:32:02AM +0530, Kartik Agarwala wrote:
> Convert WM8776 audio CODEC bindings from text to dtschema.
> 
> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

