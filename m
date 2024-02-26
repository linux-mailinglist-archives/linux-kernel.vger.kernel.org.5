Return-Path: <linux-kernel+bounces-81119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F4867073
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DCF1F26104
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737D4EB52;
	Mon, 26 Feb 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA9tMa0Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37434EB36;
	Mon, 26 Feb 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941335; cv=none; b=GNkiP6SY23rHKxqlhXWq/zB2E8TUPRJcsiM7HzBwVPWPZZMT3SrDJhwevBsywjczeqHf3jjHpROjxxY4ek/4Sg2YA5Ml9q2qPyUZ4hxGez51IYoEInizLtED0ejupUwZPdwFUKua47hBqDg8vJqY4VNCe4CUuqe2EE273DBu/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941335; c=relaxed/simple;
	bh=fMqa43xKI+gryM08fa980kLZLgK0kWJVv6T9a0vdxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR22KxMiuNkOZkLKq1n6ngaPZf4wWui0NKZWNYOjVFGcddtU4ARCCGbUsngTYbFIjCoQPiv45+ozsEGZei6SVMPzAliIV7kVxIaBdfog1vXNc7C4Qq7Yc2fQz//PImyEyk45d8unS3QJYSKD3XXulROG4crP6ZEIbmYuhuXY62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA9tMa0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86EFC43394;
	Mon, 26 Feb 2024 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708941335;
	bh=fMqa43xKI+gryM08fa980kLZLgK0kWJVv6T9a0vdxd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UA9tMa0ZnLJU4FseNE/PEavyTD/X5o1e2gJF9Wj1PTkCFmjIEnUJ1QAGHSPoKg4Br
	 B/u4kOqQ7D5ZcYtoNICfSB1Z0j0iCHa3Y867eWAIXPpHZrlzXMYLmfA6AYXgU7VGBl
	 MD0glzXU3eS3mLZUYg3le/zr+uqeHQt+8MufptsxuqmkdWZ5GBqDiY5DzLx8fAHCnI
	 yK+L1zb8EolWCfBIYWWWMf9Oab1DY69pnu2R/dXazUEh4bnUtVA3LcVVXlWmVAIxR6
	 kDFr++sFpTaF066ttULv00qCWx5cPlHVEppspsuYKc29heOAqhmXhkD9LZZYpzKv8x
	 edP9uiXcTrWhQ==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: (subset) [PATCH v7 34/36] drm/sun4i: hdmi: Switch to container_of_const
Date: Mon, 26 Feb 2024 10:55:22 +0100
Message-ID: <170894131837.29486.6507796941074207475.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-34-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-34-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:14:20 +0100, Maxime Ripard wrote:
> container_of_const() allows to preserve the pointer constness and is
> thus more flexible than inline functions.
> 
> Let's switch all our instances of container_of() to container_of_const().
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

