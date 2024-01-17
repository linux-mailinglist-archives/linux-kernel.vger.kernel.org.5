Return-Path: <linux-kernel+bounces-28760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FF8302B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694FA1C24996
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174911DA3E;
	Wed, 17 Jan 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+Qu7xQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE241CFBF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484829; cv=none; b=okJRvbBVdwr+IoGaFg/nzvzxWnx0C5kcRL7A9yKSS82DnFRTLYjjwVohCJn+p2tFJz0aI5kenKLJ+8gLyDv+bzUD8FNga/w1ZxRORw2UfdkFBUyODplqQpw7+P+gi2C5D87LqGUsy4XWcRIBedAvKwU3QFn0IgUw+V714TpTL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484829; c=relaxed/simple;
	bh=LfGrIBdmJEyFBJfUHMkX0XbzklHWItPHNXU+cjhqFuA=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=oq3LjhfdgvE+YQpcFTOdSRjrrFF67xq+T4FCcrN/CooBd3kSOy9gn21A5dMJMh1kWfM7W2zisUShNdIFijHkmKyMPi2zoG3KgYdeWzfRnN1onAwNGLqm/6pBH4Dpm6XY+ktosCvV/HwjjwMXO8Tr5y4u9Req/mMnBPhruwUdYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+Qu7xQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E9C43390;
	Wed, 17 Jan 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484828;
	bh=LfGrIBdmJEyFBJfUHMkX0XbzklHWItPHNXU+cjhqFuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I+Qu7xQcYgGFuHTN1QnJ5b620qg7pp6ihl+SzPv9q9tlDf5BZJg6s492/yolgJqAR
	 g6IauKkZ8iwl+BPQyuQHQdxE6zrtBnBUCNCrrYripHDx+Mp04ET+Q4oFTV7YXRdEn3
	 /4e5VLv38XFg/d6nFg7lBKh7Fnllc9ud4BqhdfaBxWp0gbCTMNj55n0l3gV8fsdNpI
	 WLGC2Rdq6F2NmblWWcCe5kNcQrPd01FGRHBq5LqPlsY9y4V+UPr7W6XsGNhHU4b266
	 MM1/iSB5w+kuxhKtPJDgsh+4IpXW/t1GW4ClGQGIP+hnxblbIwvY1dfoRIcsr+qW9d
	 JiBLws4orxovA==
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
In-Reply-To: <20240115171351.504264-4-michal.winiarski@intel.com>
References: <20240115171351.504264-1-michal.winiarski@intel.com>
 <20240115171351.504264-4-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH v5 3/5] drm/tests: managed: Add comments about
 test intent
Message-Id: <170548482640.96553.2643651506083718393.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 18:13:49 +0100, Michał Winiarski wrote:
> Add comments explaining the intention behind the test and certain
> implementation details related to device lifetime.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


