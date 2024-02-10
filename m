Return-Path: <linux-kernel+bounces-60504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8F8505D0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BFB1F256D8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFA5D730;
	Sat, 10 Feb 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH3CZQ/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AA5D491;
	Sat, 10 Feb 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587734; cv=none; b=EytE+Ygswfmd023RyHXBHjAOPK8MD5MpJUzFArBr1vX1Z2PidB8m8w+LCm9CrF30PmYMesb/UNiaUU3WEK/5RsuPGUkKzgVwRnamdS+hHPJiZbg7d4XPf4Une3/mg3XeqZTv8Gk7IDR5kHNB3xXejJ6Jtpjnvb8Rqpk2gx3NgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587734; c=relaxed/simple;
	bh=ap3JjIjFbc61TT1tG3+muHIUhO4Rb8ru71qzcOe2sUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhvfwNYpgO8D6tc5GgBq8tHKTm/8XvPnq5rKRMcTDltaVjWwGtAcaTw2qfT8P/WMJOdruOOhy8vo/WzzIXV7AvzKcr2CYqmHRU6UQ5kcVQsVPBwzRruMgXJQEi/gKCZ0NIOxa/ocL/Li+2IbfQqP1AbTjqGrMkOfbOUYfBZ67Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH3CZQ/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FD9C433C7;
	Sat, 10 Feb 2024 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707587733;
	bh=ap3JjIjFbc61TT1tG3+muHIUhO4Rb8ru71qzcOe2sUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WH3CZQ/rC5aqGe3w5A3t4lwJXSR0BY2C3oE7PzQlrcQqCBGMklvzatKYf3QS6ebxa
	 HpzyXgCCUBLPsP9lA92acqB3O4VHNMek8jbItLX+km4TDUTPBXgIosDxoEH1QHJKLR
	 V0DZEn2hjLeyxma5llNWnvurVtZukJYJCt6CJOuyY3hyhFoa4JmT3CxZcxArtvvfVJ
	 4a3DTdlIgb74YLnpGUxtaE+2wmJM0PzR0M2lP4zTM+J8EP/uzfg+KpwvRaJmowCnBM
	 fJLxrtGBEJSEOInF/xnsHK/A4iebE04NosajUR4ZtdCVu9H4NfdPSyUZ8dbGmElisK
	 uZu3dydsybGOQ==
Date: Sat, 10 Feb 2024 17:55:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: humidity: hdc3020: drop u8 register pairs
Message-ID: <20240210175521.6984cee6@jic23-huawei>
In-Reply-To: <20240207074758.4138724-2-dima.fedrau@gmail.com>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
	<20240207074758.4138724-2-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 08:47:51 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Switch to 16bit defines. Create helper functions that are aware of the
> new register format and apply them wherever possible.

The dropping of const is an unrelated (though sensible) change.
Given it's really minor, just calling it out with a comment here would be
fine (rather than a separate patch).

Otherwise looks good to me.  Thanks for cleaning this up.

Jonathan

> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>


