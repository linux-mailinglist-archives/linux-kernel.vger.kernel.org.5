Return-Path: <linux-kernel+bounces-144734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6AA8A49F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C911B22C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C1376E1;
	Mon, 15 Apr 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0JBn5TT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CC374C6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168800; cv=none; b=OVwQVvhs6hLbWktwdWKswZXgXf55DYXdVtSNUVN57slGyYoU3uSmOwO7IfMqi3YPTFvIgVvLSbB0F3sqsbAtbt22LWk84fK77freQZyiAGla+tZlJCTxT5o6MV2xnXkEak6gd1cE2u7GPIZ4a5PmlhAv7fVCt7XxG6r+l5chSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168800; c=relaxed/simple;
	bh=rcDAWNhXVzUZL03O1SHWIX9sFvrB+I8PVu/WEazX9Ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c1tviZafyrxMu8NLqAedheN2/qcyvZr4Q+h7QDTomGaG1YTgBR+cZWq7i/GPPcM2i88odVaHDsDY35FT+43y4ek8R+QbsG/x1wfJNiI1RR3lZDiuGN5T5BbJlQ6bQ9tXh4gaZtrDYiydyE/Qh6UZWErSEMTM0lMjqwKHTwFAci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0JBn5TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC35C113CC;
	Mon, 15 Apr 2024 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713168799;
	bh=rcDAWNhXVzUZL03O1SHWIX9sFvrB+I8PVu/WEazX9Ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V0JBn5TTqAla89qpDE0M+vBIipafEvd3mGQijUuI6KvyiNY0IZWmXN/E5py2H0A9h
	 2NVFepot6wpcrEic4ZMAUHeEDoy58H2/9TSQPxB0L5NLVxIpk/Iznlc0q92YhkuzPc
	 kKUe0JhtR25LcCY9GV2w99nxbtYjns/ssHShCv1hSfcXPsxd3OETiZ4tpce4eqJl5y
	 e8i1RAeoHkeUmtwQ9r4pFnOPdkFQChtEhb7eNZWlOEs1O9OfU710KAjas//kOWTvCf
	 8PyuCtP18XiK9jIP/6psJ6dFtLt6tYdktikUh67vIs9EjA1p4CtJnZ1Oyk8d7VqI4B
	 qp/FXRCUOEdkA==
From: Maxime Ripard <mripard@kernel.org>
To: Eric Anholt <eric@anholt.net>, Aleksandr Mishin <amishin@t-argos.ru>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240409075622.11783-1-amishin@t-argos.ru>
References: <20240409075622.11783-1-amishin@t-argos.ru>
Subject: Re: (subset) [PATCH] drm: vc4: Fix possible null pointer
 dereference
Message-Id: <171316879740.200641.7167138932298013615.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 10:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 09 Apr 2024 10:56:22 +0300, Aleksandr Mishin wrote:
> In vc4_hdmi_audio_init() of_get_address() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


