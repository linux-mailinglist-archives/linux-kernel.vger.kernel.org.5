Return-Path: <linux-kernel+bounces-71305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DB85A331
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA05281AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB731A81;
	Mon, 19 Feb 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPbwxWgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F332FC59
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345678; cv=none; b=NeByBqA9dtbqrIFjj2x41B8EoYL52vWKhDHR/AhdLwWInkdQfozD4t082bZZNNWj1WL+fDQboc0Zywb5bZ83HBeSykjVyYNF0M38JcMQjw8ogpCj6XYQuFvPakEmu1AxRApJ62JxTswb5LC8rUhh9ZNafFAEexJYD715PEwaUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345678; c=relaxed/simple;
	bh=v7TF6D7rCT1Xtj8T7jMIW7GSQIy+0TcQjmq6sFHYN4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EVevIEhbgExSMMINhujnKLUcY7ErKaXzaR5qKOVWmTYBU7LngpPmbhqNYuxo/S2Mt27XiQsaFvVJ1HmIVpFV6L1v6xjknZlBwpWCySdOqhJ3FOMAxpO3r+0BeDH3yt5gz4YUmpkES5qwkg4QWzysDcfQpJ0CY/8N5+B/TA4COCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPbwxWgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FABC433F1;
	Mon, 19 Feb 2024 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345678;
	bh=v7TF6D7rCT1Xtj8T7jMIW7GSQIy+0TcQjmq6sFHYN4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WPbwxWgkOxrUtLw7Mw3h4YpF7/LTym0hpLxdG8wqk5340/44ljPpxuKq0yNAsw5Xe
	 XXsGPTZMtJkv4JrFyVobC2xIQ7OZ2cpZmUZ0EcFyxdnd6akVpIiQW6xzAQZBC3ma7X
	 BKRsKMRxhBrj377tMduSIDpnoWBG7ZEsOaUSrjMS53T4xDSYs6ibw3y+pkWH+0h1O5
	 DRCEv9LkL4oHeO6kEae1aUKnVjUzAUJQOZ2V/f8YVBfb/h49VLNemwqnyOQSLjhXyD
	 5iVBKLcjNG+PjfcTajEpMw9hJIDLGX+ol4v14foE369aH40ZcZ2KszOsKVddQsUf9D
	 +YLculyxLh6EQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 2/7] riscv: jump_label: Simplify assembly syntax
In-Reply-To: <20240212025529.1971876-3-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-3-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 13:27:55 +0100
Message-ID: <87edd8fxkk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> The idiomatic way to write "jal zero" is "j".
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

