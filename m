Return-Path: <linux-kernel+bounces-28759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964D8302B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9991C244A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76A1B814;
	Wed, 17 Jan 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC8LeK6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9D14285
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484826; cv=none; b=L5HwkVAhBG2t5Xxu+wgE8qIPHm2rxtiQO4JDcIzhezf2oNjXVyrUmUTcqKleVjb0GK8bGQ74H6dxr+3ccatTvdSNPLunA0LwUzMhSP/b2wsnLE9WUsIXwQMfkVS0ioP+UAqwfewlWW12fjiB6J6TJBblbzFCsILGYze0yv951FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484826; c=relaxed/simple;
	bh=vQ/zSo1rB98kkRoqPvtpPAIL4GYX/nPABskTJyyPx9Y=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=c6ru/5pEivYZNL4H+AKzTkYZDXTJbdjHtxhQI53LvRT3uUMFVyyeA01cEF9q50exrzTAkDKPPpdrWnjNKebEV6I3Q6CBghE0HZDPz6lk89IxNIhWFDnooH3ocR9L+8+s+4TrmkLh9VDPKYzU2+mkHbOwX3hNZGTj80JaAxGH8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC8LeK6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF44C43390;
	Wed, 17 Jan 2024 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484826;
	bh=vQ/zSo1rB98kkRoqPvtpPAIL4GYX/nPABskTJyyPx9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hC8LeK6WAYqUyyQ00KsJR/xYsAuKDbWWuatznaud9LIaRX7KJAlKafPsFiFqI+fpS
	 cmyxMpYJMW0TitFHw+prKvxzUgvpsucQfzG8FNSoAA+QzznJikMF0SHD4UFVYEmdSz
	 Q7csTjyeBS8FXrdRRFxjPFX9qlYjd8yjPiEvzwVns/GgC8aS3HLXyiyE+yaI6/CDmS
	 yCBB2NefBW1ZW0vqp9XnUcNTYfPqmeNNSUOn+HcD2xvpyVdyxoU0x29tMuWD1sNTXN
	 t6fp4OzNyQOi12Z78SB16hvoeXH7cIT7b6IYqeHZBsm5eQVeEuUhAj+ajzKgrf47M7
	 OMnFAWqa14n/Q==
From: Maxime Ripard <mripard@kernel.org>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Michal Wajdeczko <michal.wajdeczko@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20240115171351.504264-3-michal.winiarski@intel.com>
References: <20240115171351.504264-1-michal.winiarski@intel.com>
 <20240115171351.504264-3-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH v5 2/5] drm/tests: managed: Rename the suite
 name to match other DRM tests
Message-Id: <170548482352.96553.16307390784963258870.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:47:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 18:13:48 +0100, Michał Winiarski wrote:
> DRM tests use "_" rather than "-" as word separator. Rename the test
> suite to match other tests.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


