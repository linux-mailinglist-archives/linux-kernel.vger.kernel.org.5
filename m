Return-Path: <linux-kernel+bounces-56430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF7284CA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD232893F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C555779;
	Wed,  7 Feb 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DX0qjuiI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YbpDKrc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3E54FA8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307043; cv=none; b=jUXHoR/hzKoapM8UIbJFXbThrNgzyJq3Tsvvrv1OUo9NlKYdGizvHhpfKUDbaLH/Zd/mvpKw+bcjKOYCRZDZPM4hX5R8lGBfqhaAgWrQsn0TiVjXVyETTYbU+4sWAeprVmy9TCgF1Oub+W/l/Q+kASOxc8ax522ySPMmsoHjFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307043; c=relaxed/simple;
	bh=mjNObsOH/cmBDB1PBC2tiCHU4aUPhO+goO/k1fO/4FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdoTZA+BlVsgtbg6B6Vcd9dBfUnFH2C9yjgmg06qbzUy8JJ1gTOyaFZdyW1+wrF8Q8GOIylxYJAiMbE+Ln6gMVp/qIEkufFQOMBgSFmTmFSpHuLE2uNT9uHOGuD6VR52DjijFysbh4PMW5zUqX20vTeAtnu+41dTXDgsizlaSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DX0qjuiI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YbpDKrc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707307039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjNObsOH/cmBDB1PBC2tiCHU4aUPhO+goO/k1fO/4FA=;
	b=DX0qjuiIcq1p1bRUzfUL/a/mL87NiYD/uy4cOtHR3U0biKJfD15SnPVCixeUMYpIITBYAL
	Fang9hm9N6RUgSJm5FG8rI+VolLv/UiMI8fdLQxCQhJDWn/0sF7UJ0RBjpUDZd3f2PJp+d
	lu/r/GSR6Op6/Nvz+EmNXC1I2grYtPQJ+ghouJjPguzSRyXwZeqw6XvZ88eDrcu+7dmnQt
	ChiC3KjpML8om/tQBXaL8u+pk7wqgLmg8KhmG8aUAmN20zIi4sJV2yZ8eOXrjtWlyxpG3U
	sZ4PRTBHz33MACI2mPrQPU6arEicrf6G7y5dVEDyrWsx9UvlPssWiCGHgnu0tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707307039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjNObsOH/cmBDB1PBC2tiCHU4aUPhO+goO/k1fO/4FA=;
	b=3YbpDKrcgTylstu0Mi88n0WZZKlKL+YbYavoKxoPTGFrD5hFxjp9/X8ylA66bCMOE+2/3M
	+3ZEpAGfZZXNC4CA==
To: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, Leonardo Bras
 <leobras@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Marcelo
 Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 05/12] timekeeping_notify: use stop_machine_fail when
 appropriate
In-Reply-To: <20240206185709.955049547@redhat.com>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.955049547@redhat.com>
Date: Wed, 07 Feb 2024 12:57:19 +0100
Message-ID: <87h6ikmqqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> Change timekeeping_notify to use stop_machine_fail when appropriate,
> which will fail in case the target CPU is tagged as block interference
> CPU.

You completely fail to explain 'appropriate'. There is zero reason for
this churn, really.


