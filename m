Return-Path: <linux-kernel+bounces-145260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5C8A518A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FD11F2437F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D351E896;
	Mon, 15 Apr 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdkVwXgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD9763E2;
	Mon, 15 Apr 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187371; cv=none; b=fDhH6Q+WXyuyPn4OCHPZwS4wQaOe5ThyIuK1XubfDl26wW495HehpvEOOPRZvI4CapuwVxFbbv4qo3Vk3am861DKhzeZGaOmTa4l6XJ7dAylehVTjB6ruPeAAy3wgj4MF3pKaC7quwENCkZu20/DCjWPpHJbQLHi8It9q17Dp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187371; c=relaxed/simple;
	bh=SZAlJ+Qs4QdL84IODe5Qz4hh9hsjjjspqVk5ksFWvDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwNDgjKSQJOyonIyEer1fPvb3Q0dLiZ9abMmzYuFaHObXa7zLDUq3VRF1k9n9DHDuF6GFT3wIQ7oGnWb911rWA8oEr84eU80tu1+4jyBhkCpiulMhPghY9VwPV6XK1fYiN/WptiOrVJ1XQB8FpqXOLsxjjHi1ATkGZMGa11DOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdkVwXgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5490DC113CC;
	Mon, 15 Apr 2024 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713187371;
	bh=SZAlJ+Qs4QdL84IODe5Qz4hh9hsjjjspqVk5ksFWvDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdkVwXgLkmjYtmETgdhlBVE0X5By2J6fxnVccg5kp0ZWrohqPbKMAGgrCF+8ryUqt
	 r+Q44fAUHK2HOA2EqUmnJD0/hGxxtpvNhOU/PTJ4N9wkv7EWc7wYM2bbcSuor1oFiG
	 0lXor4Zp/N9vWKnwqOc29xNYDEs+2mdMLnj690DfEOaUL7kSMN342WsOaxM9sxMbVR
	 b6RvUrto+9p5vISl5QoUQI1gLleYb49oHoUAS4nrXTIyPPtKuz3kK0odRIVedJK6Mw
	 Y2p53jBGEs3u16h20BBqr08c6jclIX87J7rbPA0YVpIL0yPf6QWoDQ8UtTF2nCuhkn
	 98GAtRIa3Y1IQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwMIL-0000000050T-0JDk;
	Mon, 15 Apr 2024 15:22:49 +0200
Date: Mon, 15 Apr 2024 15:22:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Kenny Levinsen <kl@kl.wtf>
Cc: lma@chromium.org, benjamin.tissoires@redhat.com, dianders@chromium.org,
	dtor@chromium.org, hdegoede@redhat.com, jikos@kernel.org,
	johan+linaro@kernel.org, kai.heng.feng@canonical.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	mripard@kernel.org, rad@chromium.org
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Message-ID: <Zh0qKeI-YPDE-NVT@hovoldconsulting.com>
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>

On Mon, Apr 15, 2024 at 12:28:28PM +0200, Kenny Levinsen wrote:
> > The problem is that the probe function calling i2c_smbus_read_byte()
> > is not aware that
> > uC on the other end is in a deep sleep state so the first read will
> > fail and so the whole probe.

> Well, the probe was just added to "avoid scary messages", so we could 
> just do away with it and fix the "scary messages" instead.

We also use it for devices that may not be populated (e.g. an optional
touchscreen) and in that case we should not print anything.

Johan

