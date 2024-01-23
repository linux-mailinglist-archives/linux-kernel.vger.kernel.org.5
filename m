Return-Path: <linux-kernel+bounces-34796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C610083878B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C62D1F212F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BF50276;
	Tue, 23 Jan 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djj/RH3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553E51C2A;
	Tue, 23 Jan 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991805; cv=none; b=ki6aUgMs80k6179pmYmNJGIsuzM8E3X4A+Y74FDZvD9/+UG0AGFLscQMBbHVZfEHWF0zjgknay4Jkr0N/8T0Jt1EGOXalYSCfiROgGT0bJAUhQnN0kuZWQUkiJs/MFQC9eXE014zrAXneSl9e3Y0WfS7gDTa+T7nMn98+Hj/njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991805; c=relaxed/simple;
	bh=3zQmCmznrHx2SqlPuePLfPAeGr3HxXLwdcMosqQt1Jc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MAN5ZmOmBarI/+FDt+qtnoX/Yc0Qy6LgEpUXEYOeolGp3/w4x8EpJpGlvodQS7AHP7+kUT+iVwIamdBP2pPOSd6nF0CNtL6t0FGsBCNsweiAunNrOZUoTcf6QIjjyR7l4+K2QaWp60ImfkcxxRhcns6Zr8NFlsH/TEW+n5bqU+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djj/RH3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7498C433C7;
	Tue, 23 Jan 2024 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705991805;
	bh=3zQmCmznrHx2SqlPuePLfPAeGr3HxXLwdcMosqQt1Jc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Djj/RH3bDVaHN3WtezrR+0gh1hIFdsf+LuUmh8LCNkNPz/9vKujzP2WWInL9JENvy
	 ha9US7Nl4ZKBzrjRuIcF0FM2pL2Wy7Jgo7tesiBZH6T0Q7ZnltGyHhWE4AI2UoQeHs
	 zS5NuWZ4H1QS3BbuxJ8J55s5nf/1f+lMw6vLqLP2bi803pWAfu5S+dFGvs4jAAYRXL
	 47ocinELJvcIXu2MXjbLB/ZzqxkuOhzX+jVScJQQKgVRzWUa/v/Q3WXsDjUwvgoY99
	 w+ndnEkwk8GwyDi30VwTOfT9SPe+0PyvOBmT+YwVcgkoRsOfdBXMyB2NqujMdQ0MXs
	 v4srBtPyOBBBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,  Brian Norris
 <briannorris@chromium.org>,  Jonas =?utf-8?Q?Dre=C3=9Fler?=
 <verdre@v0yd.nl>,  Dmitry
 Antipov <dmantipov@yandex.ru>,  Tsuchiya Yuto <kitakar@gmail.com>,
  linux-wireless@vger.kernel.org,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  Bill Wendling <morbo@google.com>,  Justin Stitt
 <justinstitt@google.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 62/82] mwifiex: pcie: Refactor intentional wrap-around test
References: <20240122235208.work.748-kees@kernel.org>
	<20240123002814.1396804-62-keescook@chromium.org>
Date: Tue, 23 Jan 2024 08:36:38 +0200
In-Reply-To: <20240123002814.1396804-62-keescook@chromium.org> (Kees Cook's
	message of "Mon, 22 Jan 2024 16:27:37 -0800")
Message-ID: <87bk9ceetl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kees Cook <keescook@chromium.org> writes:

> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Jonas Dre=C3=9Fler" <verdre@v0yd.nl>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Tsuchiya Yuto <kitakar@gmail.com>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I assume this goes via some other tree than wireless-next so:

Acked-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

