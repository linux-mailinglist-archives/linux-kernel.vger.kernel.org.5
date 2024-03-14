Return-Path: <linux-kernel+bounces-102977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD687B95B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FF31F214AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57736BB26;
	Thu, 14 Mar 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHFVNfrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B875CDD0;
	Thu, 14 Mar 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405306; cv=none; b=QBckRZy4k5lBNHtGQBk/nOG86nhhYQtYrQukwgJs5K/r2gn3rri5mvCWqLcA/ZTZ+QQ1AB5wg1oAKujJP9u8Ca3eiM+u2J/r9vyuGj46R4QgLIxtInZ2EtuV8s0C7FXzybzI+j+mivwPL9ZnJeodvb9oTaBdtZ7PpIMnFlTllaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405306; c=relaxed/simple;
	bh=BUVTvVoWhWW7I6iuppUWf5Vkh117VC2V2EAATYN1ptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu5o+N2573hrf3ovBdD92piBjP3Oxrwd04LzcWG1sY8A9i+jbyHSejDTf+alqe0PLk7r0NJ3dsXMK4duhAgpoDI/A+Fn6GLPLijYqkhHA0ird1qxz2OBV2gHfkQvYtRclhJsyykToOIq/Z8F2UVlj5y8Tmcu879/E2TqG0jkTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHFVNfrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16FBC433C7;
	Thu, 14 Mar 2024 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710405305;
	bh=BUVTvVoWhWW7I6iuppUWf5Vkh117VC2V2EAATYN1ptQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHFVNfrFcomj3scl6cCSA1rHFiuGZPT3prwd9WnZUbp3hsewRtqlR7YK6yl5e030v
	 zEGGcJJ6Dv+iXZepUhjBppIuNmKx9A+nXFfAWp05+6nhhNt+tEwDzOZJP3vQu1dC8u
	 UaSnRjQ8vSJ0CWKlX2fzQJs1E4QZG46TK3FjJUR7oYA2APr0NXxurTAz69eQRKuO9g
	 tA4X3u2ZHJdvuAwAaNO9P1gChTAG5D/p0uErPVZy2w7koyrrEik0t3ugACPdARHrmp
	 b8yO7mdhD+6exc3pIp6LeIvXIpb3Ddx3iiu+4fnQXerzvFtNXqWplGNyMPAcy71rou
	 WMvEoBzwmPO4Q==
Date: Thu, 14 Mar 2024 16:35:02 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ai Chao <aichao@kylinos.cn>
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/chrome: use sysfs_emit() instead of sprintf()
Message-ID: <ZfK2tmJ3c1Td2lVR@google.com>
References: <20240314052828.186924-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314052828.186924-1-aichao@kylinos.cn>

On Thu, Mar 14, 2024 at 01:28:28PM +0800, Ai Chao wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

It seems we overlooked the case when handling [1].  Will queue the patch
after for-next rebased to next -rc1.

[1] https://patchwork.kernel.org/project/chrome-platform/patch/202212021656040995199@zte.com.cn/

