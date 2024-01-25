Return-Path: <linux-kernel+bounces-38277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C236B83BD71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A0282F73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30CF225A9;
	Thu, 25 Jan 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rw4Ow2iN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAzlF9g+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4992031C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175185; cv=none; b=GrMJfEUbC5Iu+Z5OCG0H3GP0GAbD72/GRZC6NafhVmo8EufCpY97iZiESCEzEFkjtSNq56ki5SxoHS05kfXw3PWhkd5mFz1MWtNEppX+HN3oXftByrGLCvCvGkDnUaJy00tarII8AnsnJpd1GEIi6TWpS6DzEYfphN4HpswLsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175185; c=relaxed/simple;
	bh=znVLHhA6UoDXZQ6+CuwmqU5jJOHJA9vAJ3XSVqJgfdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+QUvZy57u7yDI1a1kI+QdM7q1Nm84QRX+W7GbgIkiH+2dS6or8JOWhpLXyr/iLeesOn4QIWx9AjKcJ2eobVVG5TEY4k19+O2YTcRHsROX/BWkokSzdlCq1IurIlt7UiCtXjTY9+vDwwDW2eFj88smfHhITV772sDT8+xA7iIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rw4Ow2iN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAzlF9g+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znVLHhA6UoDXZQ6+CuwmqU5jJOHJA9vAJ3XSVqJgfdo=;
	b=rw4Ow2iNQPDa3hnKlHiqVyO6cX9eyQR4d9vdwkbJSfKPTTd5TYEtXj+799fTw8oW27oPYR
	SrE28TNu1EaepVzI5sHfpSm5cmFwjL7aKO782B002XlBaTk3X3q55HKrLTAjA9vwLHTQ5y
	xBuo1wMrW6QsmojPZP1ELmyiAiUbii6WiJhGye5cVMmPCwHLQJd49zhYHdQad2IxHljR1o
	MndRXLNMZniaDrV+x8i/Fs6vM9QhsbiUJThN93PphQt7dA/ulxjqf0sGnyfLyesGSNoQv9
	LLk7xyVGp3ga/EAukLlpz25Tdr+qVbuI1aEmVVI1lOOw/kyJZF82Qqx8WE2SzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znVLHhA6UoDXZQ6+CuwmqU5jJOHJA9vAJ3XSVqJgfdo=;
	b=mAzlF9g+KxnwTq/FtBfQe9fb6J1WWrRxnOVHsXWJbrOt5kEofxfpicVWtyopd+lcwKTGL6
	DGzjFVmHx1cVn1Ag==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 04/15] tick: Use IS_ENABLED() whenever possible
In-Reply-To: <20240124170459.24850-5-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-5-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:33:01 +0100
Message-ID: <878r4dkbaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> Avoid ifdeferry if it can be converted to IS_ENABLED() whenever possible
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

