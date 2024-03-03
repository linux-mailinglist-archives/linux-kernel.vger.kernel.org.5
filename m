Return-Path: <linux-kernel+bounces-89767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A7086F53E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E001F2239C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AF5A0F9;
	Sun,  3 Mar 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRlYYKgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3DC13C;
	Sun,  3 Mar 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709474477; cv=none; b=UzjpW4MkGMK7LKz3Z4yZjG3y16LgX8/bOw17CcoCTXR2VYMvEvjR+hi3sYUNeA/ir+Sj6twnGcROIv1JIHa/YcqGUDvBVe4fXp0+QSsEHRVpV3TOjIUNnRBniDqVq+NWW1fdhDqVCsfL7yStLw92nL12txSkzXoee1b6u71+h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709474477; c=relaxed/simple;
	bh=oI8++W6FJtrxSa6G388ppZjFLv+Pf7SPyCqdh4rpAFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4P88O00eToG7mDdTLQffCd5r0KirWSLpNSm7gDAe9jQamUaVwJHnwArs1rLGa/N9oEsCsxUDgb7CFmMa+GzX5mtZ3TnAD6A1kHc5aCM31iVcSnXUfHmQ2EZ8pLwJ7NtUG8aAuTXkZIAMJEq1h0zm0B2fGhNu+VaJPxKbUZg+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRlYYKgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A16C43390;
	Sun,  3 Mar 2024 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709474477;
	bh=oI8++W6FJtrxSa6G388ppZjFLv+Pf7SPyCqdh4rpAFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRlYYKgfw6xGpau9f1f6Sg55xJbl9qgiQz7gqOpcOtQoOC5VtPD8fgJr7rkyG+z/0
	 pvbbs28Z67fBa2XLsMB39EBosP9e8XiTzIUGWQ1NIOiwXPLcKEYyaFOtjEMsDX/R1v
	 on9z3YckogMfVzp3CAg4AQDl/crCqZVfI4YMBl0xEwKEBE8KH4jwFgsWJQfncC5owQ
	 N5lsGb+6nUMH8EVgtNqOox31Pxssv8A5NJwEw+5jU4jdqtD9KFz2rbT4ybPs8YCjLq
	 k6GgX2Af91wcL4a+vGT3cvzADYlnx9052sQZG7C/f6ssnW9yAFsUBp1o6ZK6cSxOcp
	 NxFVjmkGHJJAA==
Date: Sun, 3 Mar 2024 14:01:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: spear_adc: Make use of device
 properties
Message-ID: <20240303140105.6b7d44d9@jic23-huawei>
In-Reply-To: <20240228203023.3609181-1-andriy.shevchenko@linux.intel.com>
References: <20240228203023.3609181-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 22:30:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg-normal branch and pushed out as that for
0-day to take a look.

Thanks,

Jonathan

