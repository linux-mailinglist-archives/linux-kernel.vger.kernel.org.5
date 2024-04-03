Return-Path: <linux-kernel+bounces-129564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95041896C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71E31C25769
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28614830A;
	Wed,  3 Apr 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ULOAWaDl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F11386DC;
	Wed,  3 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140327; cv=none; b=nAXc+zuqg8bL1KwmaYiuO/36C063AWNh58bjr1dGg+LSzB45pCKXhcThAC5P5Fzi7ctJrGxYD3zOVxl6jSTgInKtC6t4clMek3F4OjPGzKJzDj5A+4uAlSvoLAaGHngMXj+ar2LMUV5F5uStCYoYwdRUdXfqIOLAJJBuZ4jHXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140327; c=relaxed/simple;
	bh=g339Nfakmy10N8LmQYjcsqMkACofjFVwJwlCIJNtuNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/4fsExgmlCMfJmERFWwQSfRz0fTe+tldcHCQOk4PzjApPW/O/axl80+vIXYo/VlNyBmhC5x+0V4g3GiWP1fLZdtCt7jjqGbYDYPGNkm1If0tee1QUXKCZqwaCRSQ0qMLxoMB7ICFrXuQbsQSFySaVOSDqj5tYHv2I4qw8bDh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ULOAWaDl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140324;
	bh=g339Nfakmy10N8LmQYjcsqMkACofjFVwJwlCIJNtuNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULOAWaDlnGej6ZoXI94u56QiKae1+eyLqorV0zT1tS0I+JDbK45OP+5yqAKDN4BbX
	 oh8c7chaZV7h40n/QhFLhlCkkucfVBhCFX2iPOgaeoThYsRhKbrKcanWRQc4fowgHN
	 r0OIeRrmHxmZw50tFaKcBbWoxXh8wIrBTnMIT9cQ9NRFsRItJy733BXL2o/D/0jQNj
	 l9nZfJCQd3hgsrk3ZIcCDVv/UL1JzLBKQ9sSaPjvAylJmm8TCuM+reIfSOEcQP8N4g
	 lZE7sBpkjzBfSRRbRlOisH9c5LFNlvZX/p3GDiThLwiT9WybtY6mY10F30KUFFxHcV
	 3oZDAIDKfyICw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19CFE37820EF;
	Wed,  3 Apr 2024 10:32:03 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: Re: [PATCH v2] soc: mediatek: cmdq: Don't log an error when gce-client-reg is not found
Date: Wed,  3 Apr 2024 12:31:58 +0200
Message-ID: <171214017002.130010.3184925664722710524.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229-gce-client-reg-log-dbg-v2-1-4975077173d0@collabora.com>
References: <20240229-gce-client-reg-log-dbg-v2-1-4975077173d0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 14:51:08 -0500, Nícolas F. R. A. Prado wrote:
> Most of the callers to this function do not require CMDQ support, it is
> optional, so the missing property shouldn't cause an error message.
> However, it could result on degraded performance, so the fact that it's
> missing should still be alerted. Furthermore, the callers that do
> require CMDQ support already log at the error level when an error is
> returned.
> 
> [...]

Applied to v6.9-next/soc, thanks!

[1/1] soc: mediatek: cmdq: Don't log an error when gce-client-reg is not found
      commit: ef964918d42b9d9cf534754f82ccdaa402783ecd

Cheers,
Angelo


