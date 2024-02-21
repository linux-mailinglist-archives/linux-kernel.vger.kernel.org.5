Return-Path: <linux-kernel+bounces-75035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB485E1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E47A1F24B48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7280C0B;
	Wed, 21 Feb 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KPVNGf/J"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AF80BFF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530785; cv=none; b=IsQOHFpfL+MN3sLLG9vRe2qpaKKk3mYWZDpi1weTSz6CGnxcM6pAEXP43Rb6m/D4CpuKPEH8x4M757R9hNK3Il6uLTtVBdQMvt83p8zyIcVlf1TEHCsQ550bv5N7pikSpKdXoW8RiUbjogK4+KBpHd+aTuRwDSm/nFRVIIus6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530785; c=relaxed/simple;
	bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzdUUKzcSU/QtOUqAazee86C6TQ6J2xi+hrzYz3UU3QQkfHewbrH7yGklB0P/S6rADK0nEDYsamF2+lM7TZH4+mCUlBTFyJReSojt12XlMp+tZuJoMaDGiXUhf5yJniAAB5BdLFdi1AgHvzTusHITrWAv26SWrh9XyKtWF37YG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KPVNGf/J; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a020f5a4c5so73665eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708530783; x=1709135583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
        b=KPVNGf/JFzGtwRewRMQg5bShOJa0Dgvza0OeCoUI1GWDo3nuIs/PNoWjuu8dwSGmAf
         SZPCubx3OIjthO+2MmVHtovqUtncme4JxvyCFCCOmhxRsa6LoP9T/D5mw9loiBQBUzeo
         HdjFsS431y7wY1GXtpOUY9cN0BW3QNQF26OSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530783; x=1709135583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
        b=g08rVR3Q6+aJhtaWIE/y25pHu+O60xqOSJPqLNQYwaIr7cmam2PUzj2f6NgVD95zn0
         j2oE6BzZAXakiiS6lbdjrrrkeJZ23NVt1ejVgG12RVXvQZ3FzN8fivGpl4R0QgEWhqNE
         cRXiJPlELaHNnNeQGu+Ad4HOZKJAm4NHjO6nVZeHUfNxMfVAIPG0yrDZSfncRMJBdInd
         ChTNqbYo/MOMzwkDQzc9Z7cw3bxPDwZjbPcOgy3Kwcxp5pSehRu/PG/+nRZ6rpP2EaoJ
         acZ5j2E+1J9s39cfqP6KBo/wtksH5f28NHSXhs2R5yXhwz1tgZ60KbvkJ9H82lfTq6DO
         271A==
X-Forwarded-Encrypted: i=1; AJvYcCUXOsSyqRpacMXcyOyEf3xXrgIySyxa2vyKDWkqwWDGrCp92X9vURFq5UA1m/Wf1mVtthFWRUVZLV7cyJ/8TifyYfy5Vt+apuM8PXkV
X-Gm-Message-State: AOJu0YwrnB3PrQTNAE5cbX5RUHLqLM0U9sL0VnFdQGmfSkVN2t0L5VgQ
	uMOeSC3Y3oy+L8c6W/RkgeKf5CtqJN/yp6Y7UQ/pM24kQ9yVtois60GwZZK4Hw3X8S7McmSfLxt
	UKZSnQVUt1UdzQ/lUrVa/++ISn/yR7ld0YQNe
X-Google-Smtp-Source: AGHT+IHQpFoZXWJNF9xVniu1c31fdFShm2fJtfOtAD0LYOdmrGGoF9j9d5Fv7SW7EM5r/4boF5/8ahxD5g+W+hfI9X4=
X-Received: by 2002:a4a:355a:0:b0:59f:fc30:d3aa with SMTP id
 w26-20020a4a355a000000b0059ffc30d3aamr5366824oog.3.1708530782898; Wed, 21 Feb
 2024 07:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz>
In-Reply-To: <20240221114357.13655-2-vbabka@suse.cz>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Wed, 21 Feb 2024 10:52:52 -0500
Message-ID: <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, 
	cujomalainey@chromium.org, kramasub@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sound@vger.kernel.org, 
	perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com, tiwai@suse.de, 
	Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"

Thanks so much ! We will stress test this on our side.

We do this by exhausting memory and triggering many suspend/resume
cycles. This reliably reproduces the problem (before this patch).

Of course, as we all know, absence of evidence (no more stalls in stress tests)
does not equal evidence of absence (stalls are gone in all code paths).

