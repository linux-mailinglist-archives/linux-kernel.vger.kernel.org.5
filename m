Return-Path: <linux-kernel+bounces-127407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90005894AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3610B235AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689F1862E;
	Tue,  2 Apr 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pP7xSJuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA017BBB;
	Tue,  2 Apr 2024 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036563; cv=none; b=kcrM28podk1aXzBnJZk0tIIjrIQRSrnFfwCHAjmBu9JG1xuOGRyrf8xMJOgdgFRPVPlQJCqcd/XpjhmthFpC7v1do7Ifg5IFhB9C0WoDk0aBkNvEV2iptJLNlAK9kbZIdF6bIn+in8c4b4JeXkKG+Pt1coH2Z5zNG+vfxIg2U3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036563; c=relaxed/simple;
	bh=wjKa61zXYDVrcZt81c4gmK2Wg06oWwgdqgv0grMT/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg6aRER3pVxnNHmK1Ep07dnqUHGJFceV1B1pVtm4p/0BTtaNn+m9r8uwfACtZLBjUi23jWgjwn4UPSMJMhAyxiLp5PGsu1X0jnX7d8pgMtmHSfKCzVytTIvamEQ6VTDev08iQ30XC0YCvYc04og+aeYp7h+igByc0S1P/tg9dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pP7xSJuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA920C433F1;
	Tue,  2 Apr 2024 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712036562;
	bh=wjKa61zXYDVrcZt81c4gmK2Wg06oWwgdqgv0grMT/jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pP7xSJuSg8hNGaX8I9wu2sPgg52gpHylYTWcqHdZALSVZJb3uhwCLJStNscRjZIRF
	 9QjCR6x9HeMHNp3pyymfeBY2FxvKFFvUHg0veDgWZSdFxhjHYMcGMyeLbfWgiD2zXI
	 3sfmcvvDZGensxPElDl9jnhDh0fM0+/T9o76GA4o=
Date: Tue, 2 Apr 2024 07:42:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laine Taffin Altman <alexanderaltman@me.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	stable@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: init: remove impl Zeroable for Infallible
Message-ID: <2024040209-cardiac-recede-06bc@gregkh>
References: <98DBB275-AEA9-4B1A-94B0-99C01BD3BE50@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98DBB275-AEA9-4B1A-94B0-99C01BD3BE50@me.com>

On Mon, Apr 01, 2024 at 06:57:57PM -0700, Laine Taffin Altman wrote:
> A type is inhabited if at least one valid value of that type exists; a type is uninhabited if no valid values of that type exist.  The terms "inhabited" and "uninhabited" in this sense originate in type theory, a branch of mathematics.

Always run checkpatch.pl on your changes so you don't get maintainers
asking you why you didn't run checkpatch.pl on your changes.

thanks,

greg k-h

