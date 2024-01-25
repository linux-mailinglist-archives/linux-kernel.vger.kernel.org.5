Return-Path: <linux-kernel+bounces-38640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11B83C389
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DB4B236CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EC4F8B0;
	Thu, 25 Jan 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBL/Jisb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6C4F88D;
	Thu, 25 Jan 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188999; cv=none; b=FclJcRFyPgquupPidseQl4Z2fsLBjlluWpkHBtgsOdrTjKh0P1rrDv60lJVAmvGk03B1E/h35wtH+PfSNlDCKh8TqsKExFFnv7lCsUy+isPDLau5RVXgY/bI+aTFqwzEXvh1KeEGkNUEenWmJaht3llhrMYkgVt+y6iM8siWg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188999; c=relaxed/simple;
	bh=RTrUkGFlhHDqssknlVEh2NOMXjB2QBjHYkzy/Jg4Als=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xk6pscdiUij5dsGHNYNphJ3HFVTOEN4KcyMjK4XT1v2kMct3hJN0wqN9xRx9NqoPwHIfroHzcIs6bY8dweZE3v0SSGXPMwrXpOVuoCu1Tt265CZFAFWGbXhJQNqOSPiwXGVHtfDvYYGRS0EKE0CMs1mi6XlWJPOjvVdIz8G0m/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBL/Jisb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AA8C433C7;
	Thu, 25 Jan 2024 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706188998;
	bh=RTrUkGFlhHDqssknlVEh2NOMXjB2QBjHYkzy/Jg4Als=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pBL/JisbmdvDKYuIIgfc3Rxlu0CdWJJHW2gI65zuEtIaOMFAF+ooxCr44jOyb2IDS
	 GYsDdA0BDzY3u8HIz/yyBCPMLVudOMU/Sw4teA0waV1+6AXY/sdydC/Fe4xwF1Spm8
	 HjWrWwtdQuX48da9V3uwPdFBFmHWghGljjP3Xd9vxe0oaiSjA/MJxLcsjziKobjYJp
	 oa4JZUJXO6K/cENGl5Od70HQZzQOx6zaz70imtkt9XdsKDbSKQOetrdUn4WKRF+Jh7
	 qzG8uMKVZrzE9sMDoiXaEZTE4NWBkOQS3e380xIG0yv6sLkOa4TKEPFH6OBDzc1gIE
	 dOqTEli/QhAug==
From: Lee Jones <lee@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20240114143921.550736-1-andriy.shevchenko@linux.intel.com>
References: <20240114143921.550736-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] backlight: hx8357: Fix potential NULL
 pointer dereference
Message-Id: <170618899680.1460445.7138651116963022324.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:23:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 14 Jan 2024 16:39:21 +0200, Andy Shevchenko wrote:
> The "im" pins are optional. Add missing check in the hx8357_probe().
> 
> 

Applied, thanks!

[1/1] backlight: hx8357: Fix potential NULL pointer dereference
      commit: 3b75d271e161e22aff8171940a77510d2fb2ad6f

--
Lee Jones [李琼斯]


