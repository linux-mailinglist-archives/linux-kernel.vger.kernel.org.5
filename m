Return-Path: <linux-kernel+bounces-103139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425087BB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D61F228E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB16CDC1;
	Thu, 14 Mar 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5NqvJSi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D165DF0E;
	Thu, 14 Mar 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412870; cv=none; b=oXHHzzRx8Q1oKO+RC0DZyVGgpqdpBxvd+P8rDryiXVTCGB+WnRiMhWdJchx6HDPPKsWuWFVVd/3Rdotk7jMRdNIffz5ZniFcjgLEQ7lsyZ1Rx6n2TdpKFCxH6Ykp9u907Zhe/9iLHrC2PPyKbwsBNQ7sdBCzsFTPdEMCV8ukhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412870; c=relaxed/simple;
	bh=NKeKefPF6egagCg3IVA3tpwNCyhF4yfvOCdSY7XKMV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIzPZTnugTCdGgv7lzHMQ0EJvnXO/Yvqco7uQnadOVoBtPLuJIntM7B5OqL+SsIAS530v0nt6VLp8pY6LcgAKanJ1vzwu5wg1E7qu9YDevY4fniPkriCy4WAbgnVFPC6+TOSoXpYZTCuMjg1qEmI9up7OYOQt9Ern9KG2rObcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5NqvJSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63136C433F1;
	Thu, 14 Mar 2024 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412870;
	bh=NKeKefPF6egagCg3IVA3tpwNCyhF4yfvOCdSY7XKMV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5NqvJSiJLIuJ8UfZzIlO+3hWCpzNH+tKOmCRquj6mVZpDuZpZPfJJqRpiTe1Ufj+
	 4CDxEWnc+DhHW6ZcQVNa0FJm8l5qm51+tnWI5h5X30tDvkkmcbymgTgjPhmVu+skC+
	 fhKJyOoLRmBbkxKV5O5F7UCo7jjHlmQ4kp6QMh3tIcZtZetbwPw8vsjZKyvMt5lhOj
	 ELghCvaa4Bip6VGbyvfldZNrilS4haYwvzT8JHXtvH1jG6+sMBV9f26/qUy7ajiMfM
	 pvIThJ8v0fM4ud0wySZ1/ygDtkyG2wb8njNYj/jQ/p/QMHHarXbr9fLq/P0ASW4pa5
	 cTFtcNALYcL7Q==
Date: Thu, 14 Mar 2024 11:40:25 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
 <vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
 <mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
 <nikitos.tr@gmail.com>, <kabel@kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <kernel@salutedevices.com>
Subject: Re: [PATCH v6 1/9] locking/mutex: introduce devm_mutex_init
Message-ID: <20240314114025.1e27399e@thinkpad>
In-Reply-To: <20240314084531.1935545-2-gnstark@salutedevices.com>
References: <20240314084531.1935545-1-gnstark@salutedevices.com>
	<20240314084531.1935545-2-gnstark@salutedevices.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 11:45:23 +0300
George Stark <gnstark@salutedevices.com> wrote:

> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Suggested by-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

