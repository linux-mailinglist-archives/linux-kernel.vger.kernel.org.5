Return-Path: <linux-kernel+bounces-28757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD08302B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D4B1F23926
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98E1BDFD;
	Wed, 17 Jan 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuBDT7US"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914501B814
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484823; cv=none; b=EG31vQtq708Bvzz/MLeu+v2x61j/FWaf/UUQ/jZD9XlD8Vt8duO1aAUHBzl1SL0Kmf3LwEB3PmbWM/FiENa8+zrBP6G/q86hPLoceS29DYt2zdQ03oevQXpGGWovP6yHHoHnDgqq2hdWnmWA3uueoLGO7ROcttwj/muVMS2vXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484823; c=relaxed/simple;
	bh=+W1QtavGg43I25Qlt8kktX9sjC8kTiEwRJDpeusCOuI=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=etyE2UepfpzrzAwLneD5WxSZAxkIl92Um7gxshD+M/rR/iGRmQxqfd3F1smFMmHihk73dHPcRfkdSS+Wt11QPzNRdKwUM2qJN22vcGZaanNhrjJvpgxiN0EoLNFpwTjTxXasrPRHD9vOrTlDyzwQQFMbGojq2Siwb79WmPKdG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuBDT7US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC31AC433C7;
	Wed, 17 Jan 2024 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484823;
	bh=+W1QtavGg43I25Qlt8kktX9sjC8kTiEwRJDpeusCOuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tuBDT7USVMJgL8Xa7Tv6d0XoAkJsWYWSsdCooC5XhNIDnwP13fjPBHxDbqUNQhxq+
	 ZqzjOpl+QbgxyBxmlewJbqOU87S9hrz7Nc3A8PmYs8KYIRF3tX9rJ2OoNKNQGR2fM6
	 n+SVYh4HQ2RVzXvQSdmoZRBwaJnINPqtDQ8SgNgDSy5AMLwQipd4izUhY786kCGJ9U
	 NHutOYBogx742ky4pvDRCf/CWWkXw2ENLKf8jvZBAvGIZTfOL3EnWfV6T769vdpvC4
	 hBASxjLOoHfrm1NBhuRfcViGEbstJpNn+L6zbFca9uPV7PE4J2LJqkf0ze7JJljARf
	 5GuQ2lasJAHzA==
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
In-Reply-To: <20240115171351.504264-2-michal.winiarski@intel.com>
References: <20240115171351.504264-1-michal.winiarski@intel.com>
 <20240115171351.504264-2-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH v5 1/5] drm/managed: Add drmm_release_action
Message-Id: <170548482051.96553.15600235735895208775.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 18:13:47 +0100, Michał Winiarski wrote:
> Similar to devres equivalent, it allows to call the "release" action
> directly and remove the resource from the managed resources list.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


